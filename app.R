#install.packages('rsconnect')
#install.packages('DT')
#install.packages('shiny')
rsconnect::setAccountInfo(name='insofe-cts-curriculum', token='F355D90EEDC74F82E7A2ECA033E4C032', secret='cl+NTO3xFCNlTYPzjwJir3pQTR6keUNvT22DkbKR')


library(shiny)
library(DT)
library(rsconnect)
#bcl <- read.csv("/Users/tanzeemahmednayaz/Insofe/Corporate Training Proposal Details/Prof Anuradha WIP/Curriculum Menu/21032019_AI_ML_Worley-Parsons.csv", stringsAsFactors = FALSE)
bcl <- read.csv("21032019_AI_ML_Worley-Parsons.csv", stringsAsFactors = FALSE)

ui <- fluidPage(   img(src='https://cdn.datafloq.com/cache/f7/63/28877-Big-Data-INSOFE-0.png', align = "center", style="display: block; margin-left: auto; margin-right: auto;"),

  titlePanel("Curriculum Creator"),
            h3("Choose the relevant dropdowns to get the appropriate curriculum"),
            sidebarLayout(
               sidebarPanel(selectInput("background", "Background of the participants:",
                                        c("Choose one" = "", "Level 1 - Freshers" = "lev1",
                                          "Level 2 - Experienced programmers who have not worked with R/Python" = "lev2",
                                          "Level 3 -Experienced Business Analysts who have not worked with R/Python" = "lev3",
                                          "Level 4 -Experienced programmers with some exposure to R/Python" = "lev4",
                                          "Level 5 -Experienced programmers who do some basic modelling" = "lev5",
                                          "Level 6 -Experienced programmers who do some advanced modelling" = "lev6",
                                          "Level 7 -Experienced programmers who know basic neural nets" = "lev7",
                                          "Level 8 - Product Managers/Techno Managers/ Translators/ Non tech managers" = "lev8",
                                          "Level 9 - Senior Leaders/ Decision Makers/ C - Suite/ VP and above" = "lev9",
                                          "Not mentioned/Not known/ Doesnt matter" = "na"
                                          )),
               selectInput("expectations", "Expectation of the training:",
                           c("Choose one" = "", "Introductory knowledge" = "intro",
                             "Implement the techniques learnt to solve problems in their process" = "implement",
                             "Not mentioned/Not known/ Doesnt matter" = "na"
                             )),
               selectInput("exposure", "Exposure to Data Science:",
                           c("Choose one" = "", "No exposure" = "no",
                             "Low Exposure" = "low",
                             "High Exposure" = "high",
                             "Not mentioned/Not known/ Doesnt matter" = "na"
                           )),
               selectInput("type", "Training type:",
                           c("Choose one" = "", "Statistics" = "stat",
                             "Statistics / ML" = "statml",
                             "Basic Machine Learning" = "basicml",
                             "Advanced Machine Learning" = "advancedml",
                             "ML/ Deep Learning" = "mldl",
                             "Deep Learning" = "dl",
                             "Deep Learning - Text specific" = "dltext",
                             "Deep Learning - Image specific" = "dlimage",
                             "Big Data" = "bigdata",
                             "IOT" = "iot",
                             "Use Case discussion" = "use_case",
                             "Not mentioned/Not known/ Doesnt matter" = "na"
                           )),
               selectInput("days", "No of days of training:",
                           c("Choose one" = "", "3 days" = "3",
                             "5 days" = "5",
                             "7 days" = "7",
                             "Not mentioned/Not known/ Doesnt matter" = "na"
                             
                           )),
               
               actionButton("generate","Generate Curriculum"),
               
               conditionalPanel(condition = "input.background == 'lev9'",downloadButton("downloadData", label = "Download"))
               
               ),
               
              # conditionalPanel(condition = "input.background == "lev9",downloadButton("downloadData", label = "Download")),
  
              mainPanel(      textOutput("txtOutput"),
                              DT::dataTableOutput("responses", width = 500), tags$hr()
              )
              )  )
server <- function(input, output, session) {
  curriculum <- as.data.frame(bcl)
  #observe the add click and perform a reactive expression
  observeEvent( input$generate,{   #Watches for button click - generate button
    output$responses <-NULL     # Resets the output screen
    output$txtOutput <- NULL    # Resets the output screen
    if (input$background == "lev9") {
    output$responses <- DT::renderDataTable({    #Print the dataframe
      curriculum1 <- curriculum[1:5,]            # Assigns 1st 5 rows to curriculum1
      curriculum1
    })     
    }
    else {output$txtOutput <- renderText({print("Kindly reach out to the relevant Data Scientist")})}
    


  })
}
shinyApp(ui = ui, server = server)

#Error was coming while deploying because the path used t read files was not relative. Direct filename to be used as shown below.
#bcl <- read.csv("/Users/tanzeemahmednayaz/Insofe/Corporate Training Proposal Details/Prof Anuradha WIP/Curriculum Menu/21032019_AI_ML_Worley-Parsons.csv", stringsAsFactors = FALSE)
#bcl <- read.csv("21032019_AI_ML_Worley-Parsons.csv", stringsAsFactors = FALSE)

