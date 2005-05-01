Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVEAQFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVEAQFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVEAPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:47:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261674AbVEAPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:42:32 -0400
Date: Sun, 1 May 2005 17:42:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20050501154228.GO3592@stusta.de>
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

