Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTCFAlJ>; Wed, 5 Mar 2003 19:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTCFAlJ>; Wed, 5 Mar 2003 19:41:09 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:26635 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267548AbTCFAlI>; Wed, 5 Mar 2003 19:41:08 -0500
Date: Wed, 5 Mar 2003 19:51:30 -0500
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compilation of atyfb
Message-ID: <20030306005130.GA419@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed this patch in order for mach64 fb support to be compiled.

--- linux-2.5.64.orig/drivers/video/Makefile	2003-03-05 08:49:48.000000000 -0500
+++ linux-2.5.64/drivers/video/Makefile	2003-03-05 08:59:41.000000000 -0500
@@ -57,7 +57,7 @@
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
 obj-$(CONFIG_FB_SIS)		  += sis/
-obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
+obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o vgastate.o
 
