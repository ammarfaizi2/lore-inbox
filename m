Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262847AbRE0R7O>; Sun, 27 May 2001 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262848AbRE0R7E>; Sun, 27 May 2001 13:59:04 -0400
Received: from drama.obuda.kando.hu ([193.224.41.14]:30602 "EHLO drama.koli")
	by vger.kernel.org with ESMTP id <S262847AbRE0R66>;
	Sun, 27 May 2001 13:58:58 -0400
Date: Sun, 27 May 2001 19:57:56 +0200 (CEST)
From: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
X-X-Sender: <fero@drama.koli>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] hgafb logo band-aid removal (2.4.5-ac1)
Message-ID: <Pine.LNX.4.32.0105271955370.28801-100000@drama.koli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi Alan!

This patch removes all brain-damaged band-aid patch sent by
various people and also corrects the logo issue the right way.

Best regards:
	Ferenc Bakonyi


--- linux.ac/drivers/video/hgafb.c.bad	Sun May 27 19:47:28 2001
+++ linux.ac/drivers/video/hgafb.c	Sun May 27 19:24:10 2001
@@ -47,9 +47,9 @@
 #include <video/fbcon.h>
 #include <video/fbcon-hga.h>

-#ifndef MODULE
+#ifdef MODULE

-#define INCLUDE_LINUX_LOGOBW
+#define INCLUDE_LINUX_LOGO_DATA
 #include <linux/linux_logo.h>

 #endif /* MODULE */
@@ -271,7 +271,7 @@
 	spin_unlock_irqrestore(&hga_reg_lock, flags);
 }

-#ifndef MODULE
+#ifdef MODULE
 static void hga_show_logo(void)
 {
 	int x, y;
@@ -712,7 +712,7 @@

 	hga_gfx_mode();
 	hga_clear_screen();
-#ifndef MODULE
+#ifdef MODULE
 	if (!nologo) hga_show_logo();
 #endif /* MODULE */


