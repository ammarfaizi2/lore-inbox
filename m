Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVCFOnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVCFOnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCFOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:43:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26384 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261407AbVCFOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:43:25 -0500
Date: Sun, 6 Mar 2005 15:43:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/{mmap,nommu}.c: several unexports
Message-ID: <20050306144319.GG5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 mm/mmap.c  |    4 ----
 mm/nommu.c |    4 ----
 2 files changed, 8 deletions(-)

--- linux-2.6.11-mm1-full/mm/mmap.c.old	2005-03-04 15:52:50.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/mmap.c	2005-03-04 15:54:57.000000000 +0100
@@ -147,10 +147,6 @@
 	return -ENOMEM;
 }
 
-EXPORT_SYMBOL(sysctl_overcommit_memory);
-EXPORT_SYMBOL(sysctl_overcommit_ratio);
-EXPORT_SYMBOL(sysctl_max_map_count);
-EXPORT_SYMBOL(vm_committed_space);
 EXPORT_SYMBOL(__vm_enough_memory);
 
 /*
--- linux-2.6.11-mm1-full/mm/nommu.c.old	2005-03-04 15:53:11.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/nommu.c	2005-03-04 15:56:16.000000000 +0100
@@ -44,10 +44,6 @@
 int heap_stack_gap = 0;
 
 EXPORT_SYMBOL(mem_map);
-EXPORT_SYMBOL(sysctl_max_map_count);
-EXPORT_SYMBOL(sysctl_overcommit_memory);
-EXPORT_SYMBOL(sysctl_overcommit_ratio);
-EXPORT_SYMBOL(vm_committed_space);
 EXPORT_SYMBOL(__vm_enough_memory);
 
 /* list of shareable VMAs */

