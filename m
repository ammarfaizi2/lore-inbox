Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVBKTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVBKTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVBKTrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:47:24 -0500
Received: from granny.lievin.net ([81.56.184.74]:24776 "EHLO granny.lievin.net")
	by vger.kernel.org with ESMTP id S262321AbVBKTrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:47:16 -0500
Date: Fri, 11 Feb 2005 20:47:09 +0100
From: Romain Lievin <lkml@lievin.net>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: [PATCH] Fix warning in gkc (make gconfig) {Scanned}
Message-ID: <20050211194708.GA12366@lievin.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
X-FamilleLievin-MailScanner-Information: Please contact postmaster@lievin.net for more information
X-FamilleLievin-MailScanner: Found to be clean
X-MailScanner-From: lkml@lievin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

this patch against 2.6.11-rc3 fixes some warnings about GtkToolButton in gkc (the GTK Kernel Configurator).

Please apply.

Thanks, Romain.

Signed-off-by: Romain Liévin <lkml@lievin.net>
================[cut here]====================
diff -Naur linux-2.6.11-rc3/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.11-rc3/scripts/kconfig/gconf.c	2005-02-11 20:41:34.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2005-02-11 20:43:23.000000000 +0100
@@ -222,15 +222,15 @@
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		widget = glade_xml_get_widget(xml, "button4");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	case SPLIT_VIEW:
 		widget = glade_xml_get_widget(xml, "button5");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	case FULL_VIEW:
 		widget = glade_xml_get_widget(xml, "button6");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	}
 
================[cut here]====================
-- 
Romain Liévin :		<roms@lievin.net>
Web site :		http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"




--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff -Naur linux-2.6.11-rc3/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.11-rc3/scripts/kconfig/gconf.c	2005-02-11 20:41:34.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2005-02-11 20:43:23.000000000 +0100
@@ -222,15 +222,15 @@
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		widget = glade_xml_get_widget(xml, "button4");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	case SPLIT_VIEW:
 		widget = glade_xml_get_widget(xml, "button5");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	case FULL_VIEW:
 		widget = glade_xml_get_widget(xml, "button6");
-		gtk_button_clicked(GTK_BUTTON(widget));
+		g_signal_emit_by_name(widget, "clicked");
 		break;
 	}
 

--WYTEVAkct0FjGQmd--
