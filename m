Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275520AbTHMV3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275521AbTHMV3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:29:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:65230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275520AbTHMV30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:29:26 -0400
Date: Wed, 13 Aug 2003 14:29:52 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960 minor code cleanup for test3-mm2
Message-ID: <20030813212952.GA22440@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch applies to linux-2.6.0-test3-mm2.
It just does a one-line code cleanup to the previous patch, to
use an already present variable instead of deferencing a pointer.

diff -ur linux-2.6.0-test3_mm2_original/drivers/block/DAC960.c linux-2.6.0-test3_mm2_DAC/drivers/block/DAC960.c
--- linux-2.6.0-test3_mm2_original/drivers/block/DAC960.c	2003-08-13 14:11:24.000000000 -0700
+++ linux-2.6.0-test3_mm2_DAC/drivers/block/DAC960.c	2003-08-13 14:09:28.000000000 -0700
@@ -2487,7 +2487,8 @@
 
   for (n = 0; n < DAC960_MaxLogicalDrives; n++) {
 	struct gendisk *disk = Controller->disks[n];
-	Controller->disks[n]->queue = RequestQueue;
+
+	disk->queue = RequestQueue;
 	sprintf(disk->disk_name, "rd/c%dd%d", Controller->ControllerNumber, n);
 	sprintf(disk->devfs_name, "rd/c%dd%d", Controller->ControllerNumber, n);
 	disk->major = MajorNumber;
