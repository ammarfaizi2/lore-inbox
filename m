Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbTCaSKs>; Mon, 31 Mar 2003 13:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCaSKs>; Mon, 31 Mar 2003 13:10:48 -0500
Received: from smtp5.wanadoo.nl ([194.134.35.176]:56086 "EHLO smtp5.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S261760AbTCaSKr>;
	Mon, 31 Mar 2003 13:10:47 -0500
From: "Marijn Kruisselbrink" <marijnk@gmx.co.uk>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "James Simmons" <jsimmons@infradead.org>
Cc: <torvalds@transmeta.com>
Subject: [PATCH] fix for drivers/video/logo/Makefile
Date: Mon, 31 Mar 2003 20:22:10 +0200
Message-ID: <HJEOKOJLKINBOCDGFDOOOEPECEAA.marijnk@gmx.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fb-logo *.c files are not deleted on a make clean; this patch fixes
this.

Marijn Kruisselbrink

diff -urN linux-2.5.66/drivers/video/logo/Makefile
linux/drivers/video/logo/Makefile
--- linux-2.5.66/drivers/video/logo/Makefile	Mon Mar 31 16:37:09 2003
+++ linux/drivers/video/logo/Makefile	Mon Mar 31 17:06:29 2003
@@ -25,3 +25,6 @@
 $(obj)/%_gray256.c:	$(src)/%_gray256.pgm
 		$(objtree)/scripts/pnmtologo -t gray256 -n $*_gray256 -o $@ $<

+
+# Files generated that shall be removed upon make clean
+clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c

