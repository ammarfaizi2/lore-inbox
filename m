Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbVCXDNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVCXDNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVCXDLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:11:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49425 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262998AbVCXDJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:09:19 -0500
Date: Thu, 24 Mar 2005 04:09:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [2.6 patch] mm/{mmap,nommu}.c: several unexports
Message-ID: <20050324030913.GP1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

This patch was already ACK'ed by Christoph Hellwig.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Mar 2005

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

