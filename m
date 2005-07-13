Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVGMRXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVGMRXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVGMRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:21:22 -0400
Received: from mta03.mail.t-online.hu ([195.228.240.56]:54517 "EHLO
	mta03.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261588AbVGMRUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:20:10 -0400
Subject: [PATCH 9/19] Kconfig I18N: gconfig: answering
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
Date: Wed, 13 Jul 2005 19:20:08 +0200
Message-Id: <1121275209.2975.29.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for answering in gconfig. This patch is useful for 
non-latin based languages.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/gconf.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff -puN scripts/kconfig/gconf.c~kconfig-i18n-09-gconfig-key-i18n scripts/kconfig/gconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/gconf.c~kconfig-i18n-09-gconfig-key-i18n	2005-07-13 18:32:18.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/gconf.c	2005-07-13 18:36:51.000000000 +0200
@@ -407,19 +407,19 @@ void init_right_tree(void)
 						    COL_COLOR, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    "N", renderer,
+						    _("N"), renderer,
 						    "text", COL_NO,
 						    "foreground-gdk",
 						    COL_COLOR, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    "M", renderer,
+						    _("M"), renderer,
 						    "text", COL_MOD,
 						    "foreground-gdk",
 						    COL_COLOR, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    "Y", renderer,
+						    _("Y"), renderer,
 						    "text", COL_YES,
 						    "foreground-gdk",
 						    COL_COLOR, NULL);
@@ -1102,11 +1102,11 @@ on_treeview2_key_press_event(GtkWidget *
 	gtk_tree_model_get_iter(model2, &iter, path);
 	gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
 
-	if (!strcasecmp(event->string, "n"))
+	if ((!strcmp(event->string, _("n"))) || (!strcmp(event->string, _("N"))))
 		col = COL_NO;
-	else if (!strcasecmp(event->string, "m"))
+	else if ((!strcmp(event->string, _("m"))) || (!strcmp(event->string, _("M"))))
 		col = COL_MOD;
-	else if (!strcasecmp(event->string, "y"))
+	else if ((!strcmp(event->string, _("y"))) || (!strcmp(event->string, _("Y"))))
 		col = COL_YES;
 	else
 		col = -1;
@@ -1256,19 +1256,19 @@ static gchar **fill_row(struct menu *men
 		val = sym_get_tristate_value(sym);
 		switch (val) {
 		case no:
-			row[COL_NO] = g_strdup("N");
-			row[COL_VALUE] = g_strdup("N");
+			row[COL_NO] = g_strdup(_("N"));
+			row[COL_VALUE] = g_strdup(_("N"));
 			row[COL_BTNACT] = GINT_TO_POINTER(FALSE);
 			row[COL_BTNINC] = GINT_TO_POINTER(FALSE);
 			break;
 		case mod:
-			row[COL_MOD] = g_strdup("M");
-			row[COL_VALUE] = g_strdup("M");
+			row[COL_MOD] = g_strdup(_("M"));
+			row[COL_VALUE] = g_strdup(_("M"));
 			row[COL_BTNINC] = GINT_TO_POINTER(TRUE);
 			break;
 		case yes:
-			row[COL_YES] = g_strdup("Y");
-			row[COL_VALUE] = g_strdup("Y");
+			row[COL_YES] = g_strdup(_("Y"));
+			row[COL_VALUE] = g_strdup(_("Y"));
 			row[COL_BTNACT] = GINT_TO_POINTER(TRUE);
 			row[COL_BTNINC] = GINT_TO_POINTER(FALSE);
 			break;
_


