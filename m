Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVCIIge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVCIIge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 03:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCIIge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 03:36:34 -0500
Received: from granny.lievin.net ([81.56.184.74]:1996 "EHLO granny.lievin.net")
	by vger.kernel.org with ESMTP id S261643AbVCIIgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 03:36:31 -0500
Date: Wed, 9 Mar 2005 09:36:12 +0100
From: Romain Lievin <lkml@lievin.net>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: [PATCH] Fix warning in gkc (make gconfig) {Scanned}
Message-ID: <20050309083612.GA15812@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
X-FamilleLievin-MailScanner-Information: Please contact postmaster@lievin.net for more information
X-FamilleLievin-MailScanner: Found to be clean
X-MailScanner-From: lkml@lievin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch against 2.6.11-rc3 fixes some warnings about GtkToolButton in gkc
(the GTK Kernel Configurator).

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






