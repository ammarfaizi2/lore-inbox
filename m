Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264240AbSIVNEl>; Sun, 22 Sep 2002 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbSIVNEk>; Sun, 22 Sep 2002 09:04:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2030 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264240AbSIVNEj>; Sun, 22 Sep 2002 09:04:39 -0400
Date: Sun, 22 Sep 2002 15:09:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0209221444040.18211-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Linus Torvalds wrote:

>...
> Alexander Viro <viro@math.psu.edu>:
>   o gendisk for pcd, cdu31a, cm206, mcd, mcdx, sbpcd, jsflash, mtdblock_ro,
>     pf, swim3, loop, aztcd, gscd, optcd, sjcd, sonycd, stram, rd, nbd, xpram,
>     acorn floppy, swim_iop
>...


Below are the trivial fixes for some typos introduced by these changes:

- missing comma in cdu31a
- missing semicolon in cdu31a
- comma instead of colon in gscd
- semicolon instead of comma in mcd
- missing closing bracket in sonycd535

cu
Adrian


--- linux-2.5.38-full/drivers/cdrom/cdu31a.c.old	2002-09-22 14:31:17.000000000 +0200
+++ linux-2.5.38-full/drivers/cdrom/cdu31a.c	2002-09-22 14:50:40.000000000 +0200
@@ -3193,10 +3193,10 @@
 	.major		= MAJOR_NR,
 	.first_minor	= 0,
 	.minor_shift	= 0,
-	.major_name	= "cdu31a"
+	.major_name	= "cdu31a",
 	.fops		= &scd_bdops,
 	.flags		= GENHD_FL_CD,
-}
+};

 /* The different types of disc loading mechanisms supported */
 static char *load_mech[] __initdata =
--- linux-2.5.38-full/drivers/cdrom/gscd.c.old	2002-09-22 14:53:47.000000000 +0200
+++ linux-2.5.38-full/drivers/cdrom/gscd.c	2002-09-22 14:55:48.000000000 +0200
@@ -901,7 +901,7 @@
 static struct gendisk gscd_disk = {
 	.major = MAJOR_NR,
 	.first_minor = 0,
-	,minor_shift = 0,
+	.minor_shift = 0,
 	.fops = &gscd_fops,
 	.major_name = "gscd"
 };
--- linux-2.5.38-full/drivers/cdrom/mcd.c.old	2002-09-22 14:58:25.000000000 +0200
+++ linux-2.5.38-full/drivers/cdrom/mcd.c	2002-09-22 14:59:35.000000000 +0200
@@ -227,7 +227,7 @@
 	.minor_shift	= 0,
 	.major_name	= "mcd",
 	.fops		= &mcd_bdops,
-	.flags		= GENHD_FL_CD;
+	.flags		= GENHD_FL_CD,
 };

 #ifndef MODULE
--- linux-2.5.38-full/drivers/cdrom/sonycd535.c.old	2002-09-22 15:03:13.000000000 +0200
+++ linux-2.5.38-full/drivers/cdrom/sonycd535.c	2002-09-22 15:04:27.000000000 +0200
@@ -1461,7 +1461,8 @@
 	.first_minor = 0,
 	.minor_shift = 0,
 	.fops = &cdu_fops,
-	.major_name = "cdu"
+	.major_name = "cdu",
+};

 /*
  * Initialize the driver.




