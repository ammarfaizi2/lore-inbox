Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVEMBEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVEMBEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVEMBE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:04:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43531 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262211AbVEMArw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:52 -0400
Date: Fri, 13 May 2005 02:47:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20050513004751.GX3603@stusta.de>
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

