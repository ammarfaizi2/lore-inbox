Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVEDTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEDTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVEDTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:36:16 -0400
Received: from verein.lst.de ([213.95.11.210]:28396 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261437AbVEDTfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:35:51 -0400
Date: Wed, 4 May 2005 21:35:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: mike.miller@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cciss: avoid defining useless MAJOR_NR macro
Message-ID: <20050504193546.GA21618@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this sneaked in with one of the recent updates


--- 1.136/drivers/block/cciss.c	2005-03-10 09:38:39 +01:00
+++ edited/drivers/block/cciss.c	2005-03-12 09:12:51 +01:00
@@ -2762,7 +2762,7 @@
 	 * 8 controller support.
 	 */
 	if (i < MAX_CTLR_ORIG)
-		hba[i]->major = MAJOR_NR + i;
+		hba[i]->major = COMPAQ_CISS_MAJOR + i;
 	rc = register_blkdev(hba[i]->major, hba[i]->devname);
 	if(rc == -EBUSY || rc == -EINVAL) {
 		printk(KERN_ERR
--- 1.27/drivers/block/cciss.h	2005-03-10 09:38:39 +01:00
+++ edited/drivers/block/cciss.h	2005-03-12 09:12:30 +01:00
@@ -13,8 +13,6 @@
 #define IO_OK		0
 #define IO_ERROR	1
 
-#define MAJOR_NR COMPAQ_CISS_MAJOR
-
 struct ctlr_info;
 typedef struct ctlr_info ctlr_info_t;
 
