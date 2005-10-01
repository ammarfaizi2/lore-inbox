Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVJAXo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVJAXo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVJAXo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:44:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750899AbVJAXo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:44:56 -0400
Date: Sun, 2 Oct 2005 01:44:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20051001234443.GH4212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no modular usage in the kernel and modules shouldn't use this 
symbol.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Sep 2005
- 22 Aug 2005
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

