Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285617AbRLGW1n>; Fri, 7 Dec 2001 17:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285619AbRLGW1d>; Fri, 7 Dec 2001 17:27:33 -0500
Received: from freesurfmta04.sunrise.ch ([194.230.0.33]:3070 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S285617AbRLGW1S>; Fri, 7 Dec 2001 17:27:18 -0500
Message-ID: <3C0B85300006640D@freesurfmail.sunrise.ch> (added by
	    postmaster@freesurf.ch)
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Vollmar <nv@bluewin.ch>
To: torvalds@transmeta.com
Subject: [PATCH] 2.5.1-pre6 (blk.h)
Date: Fri, 7 Dec 2001 23:27:13 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Patch 2.5.1-pre6 removed some declarations in include/linux/blk.h who
are needed by arch/i386/kernel/setup.c<br>

diff -u -r -N linux/include/linux/blk.h linux-2.5.1-pre6/include/linux/blk.h
--- linux/include/linux/blk.h   Fri Dec  7 23:07:22 2001
+++ linux-2.5.1-pre6/include/linux/blk.h        Fri Dec  7 23:03:40 2001
@@ -15,6 +15,10 @@
 extern void set_device_ro(kdev_t dev,int flag);
 extern void add_blkdev_randomness(int major);

+extern int rd_doload;          /* 1 = load ramdisk, 0 = don't load */
+extern int rd_prompt;          /* 1 = prompt for ramdisk, 0 = don't prompt */
+extern int rd_image_start;     /* starting block # of image */
+
 #ifdef CONFIG_BLK_DEV_INITRD

 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */

Nicolas
