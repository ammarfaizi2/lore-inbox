Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbTCUCfn>; Thu, 20 Mar 2003 21:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbTCUCfm>; Thu, 20 Mar 2003 21:35:42 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:54656 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S263195AbTCUCfk>; Thu, 20 Mar 2003 21:35:40 -0500
Date: Fri, 21 Mar 2003 11:45:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (5/14) floppy update
Message-ID: <20030321024553.GE1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (5/14)

Update drivers/block/floppy98.c to syncronize with 2.5.65.
(Driver for PC98 standard floppy disk drive.)

diff -Nru linux-2.5.65-ac1/drivers/block/floppy98.c linux98-2.5.65/drivers/block/floppy98.c
--- linux-2.5.65-ac1/drivers/block/floppy98.c	2003-03-20 09:09:42.000000000 +0900
+++ linux98-2.5.65/drivers/block/floppy98.c	2003-03-18 11:57:40.000000000 +0900
@@ -4273,8 +4273,7 @@
 	}
 
 	devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
-		printk("Unable to get major %d for floppy\n",FLOPPY_MAJOR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd")) {
 		err = -EBUSY;
 		goto out;
 	}
