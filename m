Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSKRT3y>; Mon, 18 Nov 2002 14:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSKRT2t>; Mon, 18 Nov 2002 14:28:49 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:39338 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264748AbSKRTYy> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (13/16): xpram driver.
Date: Mon, 18 Nov 2002 20:22:36 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182022.36722.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable and add missing return in xpram_setup_blkdev.

diff -urN linux-2.5.48/drivers/s390/block/xpram.c linux-2.5.48-s390/drivers/s390/block/xpram.c
--- linux-2.5.48/drivers/s390/block/xpram.c	Mon Nov 18 05:29:51 2002
+++ linux-2.5.48-s390/drivers/s390/block/xpram.c	Mon Nov 18 20:12:02 2002
@@ -325,7 +325,6 @@
 {
 	struct hd_geometry *geo;
 	unsigned long size;
-	int idx = minor(inode->i_rdev);
  	if (cmd != HDIO_GETGEO)
 		return -EINVAL;
 	/*
@@ -474,6 +473,7 @@
 out:
 	while (i--)
 		put_disk(xpram_disks[i]);
+	return rc;
 }
 
 /*

