Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVBKTDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVBKTDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBKS75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:59:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37394 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262308AbVBKSyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:47 -0500
Date: Fri, 11 Feb 2005 19:54:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] deadline-iosched.c: make a struct static
Message-ID: <20050211185441.GJ3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 29 Jan 2005

--- linux-2.6.11-rc2-mm1-full/drivers/block/deadline-iosched.c.old	2005-01-29 14:07:00.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/block/deadline-iosched.c	2005-01-29 14:07:10.000000000 +0100
@@ -909,7 +909,7 @@
 	.store	= deadline_attr_store,
 };
 
-struct kobj_type deadline_ktype = {
+static struct kobj_type deadline_ktype = {
 	.sysfs_ops	= &deadline_sysfs_ops,
 	.default_attrs	= default_attrs,
 };

