Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGYN0B>; Thu, 25 Jul 2002 09:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSGYN0B>; Thu, 25 Jul 2002 09:26:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:64508 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314149AbSGYN0A>; Thu, 25 Jul 2002 09:26:00 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251443.g6PEh86s010371@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) - I2O does not need init in genhd now
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:43:08 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/block/genhd.c linux-2.5.28-ac1/drivers/block/genhd.c
--- linux-2.5.28/drivers/block/genhd.c	Thu Jul 25 11:09:40 2002
+++ linux-2.5.28-ac1/drivers/block/genhd.c	Thu Jul 25 11:10:52 2002
@@ -177,16 +177,12 @@
 extern int blk_dev_init(void);
 extern int soc_probe(void);
 extern int atmdev_init(void);
-extern int i2o_init(void);
 extern int cpqarray_init(void);
 
 int __init device_init(void)
 {
 	rwlock_init(&gendisk_lock);
 	blk_dev_init();
-#ifdef CONFIG_I2O
-	i2o_init();
-#endif
 #ifdef CONFIG_FC4_SOC
 	/* This has to be done before scsi_dev_init */
 	soc_probe();
