Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTLTLx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLTLx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:53:58 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:8383 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263996AbTLTLxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:53:55 -0500
Message-ID: <004501c3c6ef$e5d68330$0e25fe0a@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH BEAVER] make gconfig warning removal
Date: Sat, 20 Dec 2003 12:53:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

make gconfig causes this:

scripts/kconfig/gconf.c: In function `on_treeview1_button_press_event':
scripts/kconfig/gconf.c:1175: warning: passing arg 1 of
`gtk_widget_grab_focus' from incompatible pointer type

Please apply this trivial fix.

Available here:

http://www.soltysiak.com/patches/2.6/2.6.0/gconf/patch-2.6.0-gconf.diff

and in the body of this email

Best Regards,
Maciej

--- linux/scripts/kconfig/gconf.c~2003-12-19 23:34:45.218280808 +0100
+++ linux/scripts/kconfig/gconf.c2003-12-19 23:34:45.218280808 +0100
@@ -1172,7 +1172,7 @@

 gtk_widget_realize(tree2_w);
 gtk_tree_view_set_cursor(view, path, NULL, FALSE);
-gtk_widget_grab_focus(GTK_TREE_VIEW(tree2_w));
+gtk_widget_grab_focus(GTK_WIDGET(tree2_w));

 return FALSE;
 }

