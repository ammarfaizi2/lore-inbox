Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbTCWGfo>; Sun, 23 Mar 2003 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCWGfo>; Sun, 23 Mar 2003 01:35:44 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:34432 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262852AbTCWGfm>; Sun, 23 Mar 2003 01:35:42 -0500
Date: Sun, 23 Mar 2003 15:45:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.65-ac3] Updates for PC-9800 related (3/5) floppy98
Message-ID: <20030323064553.GC2851@yuzuki.cinet.co.jp>
References: <20030323063207.GA2803@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323063207.GA2803@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture related files
against 2.5.65-ac3. (3/5)

Update drivers/block/floppy98.c to syncronize with 2.5.65.
(Driver for PC98 standard floppy disk drive.)

Regards,
Osamu Tomita

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
