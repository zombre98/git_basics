##
## Makefile for makefile in /home/derote_t/bin
##
## Made by thomas derote-parcellier
## Login   <derote_t@epitech.net>
##
## Started on  Tue Jan  5 11:06:07 2016 thomas derote-parcellier
## Last update Tue May 23 21:24:19 2017 thomas derote-parcellier
##

NAME		=	livecoding
NAME_DB		=	livecoding_db

HEADERS_DIR	=	include/
OBJS_DIR	=	srcs/

INCLUDE		=	$(addprefix -I, $(HEADERS_DIR))

CPPFLAGS	+=	-W -Wall -Wextra $(INCLUDE)
CPPFLAGS_DB	+=	-g3
CPPFLAGS_BONUS	=	-D BONUS

SRCS		=	srcs/main.c

OBJS		=	$(addprefix $(OBJS_DIR), $(SRCS:.c=.o))
OBJS_DB		=	$(addprefix $(OBJS_DIR), $(SRCS:.c=.o.db))
OBJS_DP		=	$(addprefix $(OBJS_DIR), $(SRCS:.c=.d))

CXX		=	gcc

RM		=	rm -rf

DEFAULT		=	\033[00m
BOLD		=	\033[1m
RED		=	\033[31m
GREEN		=	\033[32m
BLUE		=	\033[34m
PURPLE		=	\033[35m
CYAN		=	\033[36m

clear_func	=	$(foreach var, $1, if [ -f $(var) ] ; then \
			printf "$(RED)DELETED $(DEFAULT) $(notdir $(var))\n$(DEFAULT)" && \
			$(RM) $(var) ; \
			fi ; if [ -d $(var) ] ; then \
			printf "$(RED)DELETED $(DEFAULT) $(var)\n" && $(RM) $(var) ; \
			fi ; )

mr_clean	=	find -type f -name "*~" -delete  && \
			find -type f -name "*\#" -delete && \
			find -type f -name "\#*" -delete ;

MAKE		=	make --no-print-directory

all:		$(NAME)

debug:		$(NAME_DB)

bonus:
		@$(MAKE) CPPFLAGS="-D BONUS $(CPPFLAGS)"

$(NAME_DB):	$(OBJS_DB)
		@echo -e "$(CYAN)Mode DEBUG$(DEFAULT)"
		@$(CXX) -o $@ $(OBJS_DB) $(CPPFLAGS) $(CPPFLAGS_DB)
		@echo -e "$(BLUE)$(BOLD)Done. $(DB_NAME) project created$(DEFAULT)"

$(NAME):	$(OBJS_DP) $(OBJS)
		@echo -e "$(CYAN)Mode RELEASE$(DEFAULT)"
		@$(CXX) -o $@ $(OBJS) $(CPPFLAGS)
		@echo -e "$(BLUE)$(BOLD)Done. $(NAME) project created$(DEFAULT)"

$(OBJS_DIR)%.o:	%.c
		@printf "$(PURPLE)COMPILATION$(DEFAULT) $(notdir $<)\n"
		@-mkdir -p $(dir $@)
		@$(CXX) -o $@ -c $< $(CPPFLAGS)


$(OBJS_DIR)%.o.db:%.c
		@printf "$(PURPLE)COMPILATION$(DEFAULT) $(notdir $<)\n"
		@-mkdir -p $(dir $@)
		@$(CXX) -o $@ -c $< $(CPPFLAGS) $(CPPFLAGS_DB)

$(OBJS_DIR)%.d:	%.c
		@printf "$(PURPLE)REQUIRED$(DEFAULT) $(notdir $<)\n"
		@-mkdir -p $(dir $@)
		@echo -n $(dir $@) > $@
		@$(CXX) -MM $< $(INCLUDE) >> $@

clean:
		@if [ ! -d $(OBJS_DIR) ] ; then \
			printf " ---> $(GREEN)NO OBJECTS TO DELETE$(DEFAULT)\n" ; \
		else \
			printf " ---> $(GREEN)DELETING OBJECTS$(DEFAULT)\n" ; \
			$(call clear_func, $(OBJS_DP)) \
			$(call clear_func, $(OBJS)) \
			$(call clear_func, $(OBJS_DB)) \
			$(call clear_func, $(OBJS_DIR)) \
			$(call mr_clean, ) \
		fi ;

fclean:		clean
		@if [[ ! -d $(OBJS_DIR) && ! -f  $(NAME) && ! -f  $(NAME_DB) ]] ; then \
			printf " ---> $(GREEN)NO PROJECT TO DELETE\n" ; \
		else \
			printf " ---> $(GREEN)DELETING PROJECT$(DEFAULT)\n" ; \
			$(call clear_func, $(NAME)) \
			$(call clear_func, $(NAME_DB)) \
		fi ;

re:		fclean all

.PHONY:		all debug clean fclean re

ifeq ($(MAKECMDGOALS), )
-include $(OBJS_DP)
endif
ifeq ($(MAKECMDGOALS), all)
-include $(OBJS_DP)
endif
