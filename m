Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVAWFxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVAWFxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVAWFxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:53:09 -0500
Received: from ozlabs.org ([203.10.76.45]:65182 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261228AbVAWFxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:53:05 -0500
Date: Sun, 23 Jan 2005 16:49:54 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rename device_init
Message-ID: <20050123054954.GF5920@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename device_init to make it more unique. Useful when looking through
debug initcall bootlogs. While Im in the area, also make it static.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN drivers/block/genhd.c~rename_device_init drivers/block/genhd.c
--- gr_work/drivers/block/genhd.c~rename_device_init	2005-01-21 19:37:07.585813607 -0600
+++ gr_work-anton/drivers/block/genhd.c	2005-01-21 19:37:07.596811864 -0600
@@ -300,7 +300,7 @@ static struct kobject *base_probe(dev_t 
 	return NULL;
 }
 
-int __init device_init(void)
+static int __init genhd_device_init(void)
 {
 	bdev_map = kobj_map_init(base_probe, &block_subsys);
 	blk_dev_init();
@@ -308,7 +308,7 @@ int __init device_init(void)
 	return 0;
 }
 
-subsys_initcall(device_init);
+subsys_initcall(genhd_device_init);
 
