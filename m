Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVA2Nhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVA2Nhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVA2NgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:36:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:268 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262909AbVA2Nf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:35:29 -0500
Date: Sat, 29 Jan 2005 14:35:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cfq-iosched.c: make some code static
Message-ID: <20050129133524.GW28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm1-full/drivers/block/cfq-iosched.c.old	2005-01-29 14:05:30.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/cfq-iosched.c	2005-01-29 14:05:49.000000000 +0100
@@ -1790,7 +1790,7 @@
 	.store	= cfq_attr_store,
 };
 
-struct kobj_type cfq_ktype = {
+static struct kobj_type cfq_ktype = {
 	.sysfs_ops	= &cfq_sysfs_ops,
 	.default_attrs	= default_attrs,
 };
@@ -1819,7 +1819,7 @@
 	.elevator_owner =	THIS_MODULE,
 };
 
-int cfq_init(void)
+static int cfq_init(void)
 {
 	int ret;
 

