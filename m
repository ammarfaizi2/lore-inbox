Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUK2M00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUK2M00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUK2M00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:26:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38674 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261697AbUK2M0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:23 -0500
Date: Mon, 29 Nov 2004 13:26:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/genhd.c: make a function static
Message-ID: <20041129122620.GE9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/genhd.c.old	2004-11-06 20:07:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/genhd.c	2004-11-06 20:07:13.000000000 +0100
@@ -305,7 +305,7 @@
 	return NULL;
 }
 
-int __init device_init(void)
+static int __init device_init(void)
 {
 	bdev_map = kobj_map_init(base_probe, &block_subsys);
 	blk_dev_init();

