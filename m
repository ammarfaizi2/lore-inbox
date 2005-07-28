Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVG1WEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVG1WEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVG1WEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:04:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61961 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261501AbVG1WD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:03:59 -0400
Date: Fri, 29 Jul 2005 00:03:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/blkdev.h:  "extern inline" -> "static inline"
Message-ID: <20050728220358.GE4790@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm3-full/include/linux/blkdev.h.old	2005-07-28 16:07:30.000000000 +0200
+++ linux-2.6.13-rc3-mm3-full/include/linux/blkdev.h	2005-07-28 16:08:12.000000000 +0200
@@ -727,7 +727,7 @@
 	return bits;
 }
 
-extern inline unsigned int block_size(struct block_device *bdev)
+static inline unsigned int block_size(struct block_device *bdev)
 {
 	return bdev->bd_block_size;
 }

