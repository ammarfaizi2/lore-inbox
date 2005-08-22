Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVHVUgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVHVUgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVHVUgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:36:03 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62181 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751134AbVHVUgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:36:01 -0400
Date: Mon, 22 Aug 2005 18:20:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20050822162056.GD9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 30 May 2005
- 13 May 2005
- 1 May 2005
- 23 Apr 2005

--- linux-2.6.12-rc2-mm3-full/fs/super.c.old	2005-04-23 02:45:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/super.c	2005-04-23 02:46:07.000000000 +0200
@@ -467,8 +467,6 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(user_get_super);
-
 asmlinkage long sys_ustat(unsigned dev, struct ustat __user * ubuf)
 {
         struct super_block *s;

