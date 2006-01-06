Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752564AbWAFUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbWAFUzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbWAFUzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:55:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752564AbWAFUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:55:41 -0500
Date: Fri, 6 Jan 2006 21:55:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, mike.miller@hp.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] cciss: avoid defining useless MAJOR_NR macro
Message-ID: <20060106205532.GF12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

this sneaked in with one of the updates


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Christoph Hellwig on:
- 4 May 2005

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
 
