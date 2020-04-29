# @file Covid19StudyCodeToRun.R
#
# Copyright 2020 Observational Health Data Sciences and Informatics
#
# This file is part of Covid19StudyCodeToRun
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' DatabaseConnectorAuth
#'
#' This package provides Windows integrated authenication DLL for \code{sqljdbc42}
#'
#' @docType package
#' @name Covid19StudyCodeToRun
NULL

#' Print out SQL for a cohort
#'
#' @examples
#' printCohortSql(cohortNumber = 1,
#'                cohortId = 1,
#'                packageName = "study",
#'                dbms = "sql server",
#'                cdmDatabaseSchema = "cdm",
#'                vocabularyDatabaseSchema = "vocab",
#'                cohortDatabaseSchema = "cohort_schema",
#'                cohortTable = "cohort_table",
#'                oracleTempSchema = NULL)
#'
#' @export
printCohortSql <- function(cohortNumber,
                           cohortId,
                           packageName,
                           dbms,
                           cdmDatabaseSchema,
                           vocabularyDatabaseSchema,
                           cohortDatabaseSchema,
                           cohortTable,
                           oracleTempSchema = NULL) {

  pathToCsv <- system.file("settings", "CohortsToCreate.csv", package = packageName)
  cohortsToCreate <- read.csv(pathToCsv)
  writeLines(paste("Creating cohort:", cohortsToCreate$name[cohortNumber]))
  writeLines("")

  sql <- SqlRender::loadRenderTranslateSql(sqlFilename = paste0(cohortsToCreate$name[cohortNumber], ".sql"),
                                           packageName = packageName,
                                           dbms = dbms,
                                           oracleTempSchema = oracleTempSchema,
                                           cdm_database_schema = cdmDatabaseSchema,
                                           vocabulary_database_schema = vocabularyDatabaseSchema,
                                           target_database_schema = cohortDatabaseSchema,
                                           target_cohort_table = cohortTable,
                                           target_cohort_id = cohortsToCreate$cohortId[cohortNumber])
  writeLines(sql)
}
