Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVDOPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVDOPKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDOPKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:10:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28690 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261831AbVDOPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:28 -0400
Date: Fri, 15 Apr 2005 17:10:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport uts_sem
Message-ID: <20050415151026.GE5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/sys.c.old	2005-03-04 01:19:18.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/sys.c	2005-03-04 01:19:29.000000000 +0100
@@ -1382,8 +1382,6 @@
 
 DECLARE_RWSEM(uts_sem);
 
-EXPORT_SYMBOL(uts_sem);
-
 asmlinkage long sys_newuname(struct new_utsname __user * name)
 {
 	int errno = 0;

