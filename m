Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKNSSo>; Thu, 14 Nov 2002 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSKNSSo>; Thu, 14 Nov 2002 13:18:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44417 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261587AbSKNSSn>;
	Thu, 14 Nov 2002 13:18:43 -0500
Date: Thu, 14 Nov 2002 10:25:34 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.47] Fix char/raw.c to build as module TAKE II
Message-ID: <20021114182534.GB4542@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Thu Nov 14 10:22:44 2002
+++ b/drivers/char/raw.c	Thu Nov 14 10:22:44 2002
@@ -103,7 +103,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+	return ioctl_by_bdev(bdev, command, arg);
 }
 
 /*
@@ -241,3 +241,4 @@
 
 module_init(raw_init);
 module_exit(raw_exit);
+MODULE_LICENSE("GPL");
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
