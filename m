Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263708AbTCUSbZ>; Fri, 21 Mar 2003 13:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbTCUSaW>; Fri, 21 Mar 2003 13:30:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62339
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263708AbTCUS3r>; Fri, 21 Mar 2003 13:29:47 -0500
Date: Fri, 21 Mar 2003 19:45:02 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211945.h2LJj2s3025941@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix time types in aha152x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/scsi/aha152x.c linux-2.5.65-ac2/drivers/scsi/aha152x.c
--- linux-2.5.65/drivers/scsi/aha152x.c	2003-03-06 17:04:28.000000000 +0000
+++ linux-2.5.65-ac2/drivers/scsi/aha152x.c	2003-03-14 00:54:01.000000000 +0000
@@ -2651,7 +2651,7 @@
 
 static void datai_run(struct Scsi_Host *shpnt)
 {
-	unsigned int the_time;
+	unsigned long the_time;
 	int fifodata, data_count;
 
 	/*
@@ -2793,7 +2793,7 @@
 
 static void datao_run(struct Scsi_Host *shpnt)
 {
-	unsigned int the_time;
+	unsigned long the_time;
 	int data_count;
 
 	/* until phase changes or all data sent */
