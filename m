Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVGMRZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVGMRZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVGMRXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:23:53 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:34243 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261750AbVGMRVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:21:50 -0400
Subject: [PATCH 10/19] Kconfig I18N: gconfig: missing macros
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
Date: Wed, 13 Jul 2005 19:21:47 +0200
Message-Id: <1121275307.2975.32.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Supplementing missing macros.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/gconf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN scripts/kconfig/gconf.c~kconfig-i18n-10-gconfig-missing scripts/kconfig/gconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/gconf.c~kconfig-i18n-10-gconfig-missing	2005-07-13 18:32:18.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/gconf.c	2005-07-13 18:36:49.000000000 +0200
@@ -464,7 +464,7 @@ static void text_insert_help(struct menu
 {
 	GtkTextBuffer *buffer;
 	GtkTextIter start, end;
-	const char *prompt = menu_get_prompt(menu);
+	const char *prompt = _(menu_get_prompt(menu));
 	gchar *name;
 	const char *help = _(nohelp_text);
 
@@ -1188,7 +1188,7 @@ static gchar **fill_row(struct menu *men
 	bzero(row, sizeof(row));
 
 	row[COL_OPTION] =
-	    g_strdup_printf("%s %s", menu_get_prompt(menu),
+	    g_strdup_printf("%s %s", _(menu_get_prompt(menu)),
 			    sym ? (sym->
 				   flags & SYMBOL_NEW ? _("(NEW)") : "") :
 			    "");
@@ -1240,7 +1240,7 @@ static gchar **fill_row(struct menu *men
 
 		if (def_menu)
 			row[COL_VALUE] =
-			    g_strdup(menu_get_prompt(def_menu));
+			    g_strdup(_(menu_get_prompt(def_menu)));
 	}
 	if(sym->flags & SYMBOL_CHOICEVAL)
 		row[COL_BTNRAD] = GINT_TO_POINTER(TRUE);
_


