Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVGMRVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGMRVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGMRSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:18:40 -0400
Received: from mta03.mail.t-online.hu ([195.228.240.56]:50678 "EHLO
	mta03.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261326AbVGMRRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:17:07 -0400
Subject: [PATCH 7/19] Kconfig I18N: gconfig
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:17:04 +0200
Message-Id: <1121275024.2975.25.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Full I18N support for gconf.c .

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/gconf.c |   58 ++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff -puN scripts/kconfig/gconf.c~kconfig-i18n-07-gconfig-i18n scripts/kconfig/gconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/gconf.c~kconfig-i18n-07-gconfig-i18n	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/gconf.c	2005-07-13 18:36:52.000000000 +0200
@@ -87,19 +87,19 @@ const char *dbg_print_stype(int val)
 	bzero(buf, 256);
 
 	if (val == S_UNKNOWN)
-		strcpy(buf, "unknown");
+		strcpy(buf, _("unknown"));
 	if (val == S_BOOLEAN)
-		strcpy(buf, "boolean");
+		strcpy(buf, _("boolean"));
 	if (val == S_TRISTATE)
-		strcpy(buf, "tristate");
+		strcpy(buf, _("tristate"));
 	if (val == S_INT)
-		strcpy(buf, "int");
+		strcpy(buf, _("int"));
 	if (val == S_HEX)
-		strcpy(buf, "hex");
+		strcpy(buf, _("hex"));
 	if (val == S_STRING)
-		strcpy(buf, "string");
+		strcpy(buf, _("string"));
 	if (val == S_OTHER)
-		strcpy(buf, "other");
+		strcpy(buf, _("other"));
 
 #ifdef DEBUG
 	printf("%s", buf);
@@ -115,33 +115,33 @@ const char *dbg_print_flags(int val)
 	bzero(buf, 256);
 
 	if (val & SYMBOL_YES)
-		strcat(buf, "yes/");
+		strcat(buf, _("yes/"));
 	if (val & SYMBOL_MOD)
-		strcat(buf, "mod/");
+		strcat(buf, _("mod/"));
 	if (val & SYMBOL_NO)
-		strcat(buf, "no/");
+		strcat(buf, _("no/"));
 	if (val & SYMBOL_CONST)
-		strcat(buf, "const/");
+		strcat(buf, _("const/"));
 	if (val & SYMBOL_CHECK)
-		strcat(buf, "check/");
+		strcat(buf, _("check/"));
 	if (val & SYMBOL_CHOICE)
-		strcat(buf, "choice/");
+		strcat(buf, _("choice/"));
 	if (val & SYMBOL_CHOICEVAL)
-		strcat(buf, "choiceval/");
+		strcat(buf, _("choiceval/"));
 	if (val & SYMBOL_PRINTED)
-		strcat(buf, "printed/");
+		strcat(buf, _("printed/"));
 	if (val & SYMBOL_VALID)
-		strcat(buf, "valid/");
+		strcat(buf, _("valid/"));
 	if (val & SYMBOL_OPTIONAL)
-		strcat(buf, "optional/");
+		strcat(buf, _("optional/"));
 	if (val & SYMBOL_WRITE)
-		strcat(buf, "write/");
+		strcat(buf, _("write/"));
 	if (val & SYMBOL_CHANGED)
-		strcat(buf, "changed/");
+		strcat(buf, _("changed/"));
 	if (val & SYMBOL_NEW)
-		strcat(buf, "new/");
+		strcat(buf, _("new/"));
 	if (val & SYMBOL_AUTO)
-		strcat(buf, "auto/");
+		strcat(buf, _("auto/"));
 
 	buf[strlen(buf) - 1] = '\0';
 #ifdef DEBUG
@@ -158,17 +158,17 @@ const char *dbg_print_ptype(int val)
 	bzero(buf, 256);
 
 	if (val == P_UNKNOWN)
-		strcpy(buf, "unknown");
+		strcpy(buf, _("unknown"));
 	if (val == P_PROMPT)
-		strcpy(buf, "prompt");
+		strcpy(buf, _("prompt"));
 	if (val == P_COMMENT)
-		strcpy(buf, "comment");
+		strcpy(buf, _("comment"));
 	if (val == P_MENU)
-		strcpy(buf, "menu");
+		strcpy(buf, _("menu"));
 	if (val == P_DEFAULT)
-		strcpy(buf, "default");
+		strcpy(buf, _("default"));
 	if (val == P_CHOICE)
-		strcpy(buf, "choice");
+		strcpy(buf, _("choice"));
 
 #ifdef DEBUG
 	printf("%s", buf);
@@ -1190,7 +1190,7 @@ static gchar **fill_row(struct menu *men
 	row[COL_OPTION] =
 	    g_strdup_printf("%s %s", menu_get_prompt(menu),
 			    sym ? (sym->
-				   flags & SYMBOL_NEW ? "(NEW)" : "") :
+				   flags & SYMBOL_NEW ? _("(NEW)") : "") :
 			    "");
 
 	if (show_all && !menu_is_visible(menu))
@@ -1614,7 +1614,7 @@ int main(int ac, char *av[])
 			break;
 		case 'h':
 		case '?':
-			printf("%s <config>\n", av[0]);
+			printf(_("%s <config>\n"), av[0]);
 			exit(0);
 		}
 		name = av[2];
_


