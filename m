Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVAUKLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVAUKLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVAUKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:09:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4112 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262306AbVAUKHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:07:44 -0500
Date: Fri, 21 Jan 2005 11:07:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/fork.c: make mm_cachep static
Message-ID: <20050121100742.GB3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global mm_cachep static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/kernel/fork.c.old	2004-12-12 02:50:56.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/fork.c	2004-12-12 03:35:55.000000000 +0100
@@ -1209,7 +1209,7 @@
 kmem_cache_t *vm_area_cachep;
 
 /* SLAB cache for mm_struct structures (tsk->mm) */
-kmem_cache_t *mm_cachep;
+static kmem_cache_t *mm_cachep;
 
 void __init proc_caches_init(void)
 {

