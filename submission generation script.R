testdata <- read.csv("pml-testing.csv", stringsAsFactors=FALSE)
testdata$cvtd_timestamp <- as.numeric(strptime(testdata$cvtd_timestamp, "%d/%m/%Y %H:%M"))

#keep only columns same as retained in fulldata -> assumes assignment.Rmd has been run
testdata <- testdata[, which(names(testdata) %in% names(fulldata))]

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

testpred <- predict(modelFit, testdata)
pml_write_files(as.character(testpred))