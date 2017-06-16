setwd('D:/Vikas_Agrawal/Education/Kaggle/Walmart')
source('R/util.R')
source('R/grouped.forecast.R')
source('R/postprocess.R')

train <- raw.train()
test <- raw.test()

train <- train[train$Store==1 & train$Dept==1, ]
train$Store <- as.factor(as.character(train$Store))
train$Dept <- as.factor(as.character(train$Dept))
test <- test[test$Store==1 & test$Dept==1, ]
test$Store <- as.factor(as.character(test$Store))
test$Dept <- as.factor(as.character(test$Dept))
str(train)
str(test)

# This is the best single model from the competition.
pred <- grouped.forecast(train, test, 'stlf.svd', model.type='ets', n.comp=12)
pred <- postprocess(train, pred, shift=2.5)
snum <- write.submission(pred)


