Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVBKS7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVBKS7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVBKS6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:58:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36626 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262300AbVBKSyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:40 -0500
Date: Fri, 11 Feb 2005 19:54:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cfq-iosched.c: make some code static
Message-ID: <20050211185438.GI3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 29 Jan 2005

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
 

