Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSHCSOI>; Sat, 3 Aug 2002 14:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSHCSNC>; Sat, 3 Aug 2002 14:13:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317642AbSHCSMy>; Sat, 3 Aug 2002 14:12:54 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 6: 2.5.29-memory
Message-Id: <E17b3Rp-0006wR-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Trivial patch; removes cruft that got left over from the TLB shootdown
changes.  "dir" is never used in zap_page_range

 mm/memory.c |    3 ---
 1 files changed, 3 deletions

diff -urN orig/mm/memory.c linux/mm/memory.c
--- orig/mm/memory.c	Thu Jul 25 20:13:56 2002
+++ linux/mm/memory.c	Thu Jul 25 19:59:49 2002
@@ -408,10 +408,7 @@
 {
 	struct mm_struct *mm = vma->vm_mm;
 	mmu_gather_t *tlb;
-	pgd_t * dir;
 	unsigned long start = address, end = address + size;
-
-	dir = pgd_offset(mm, address);
 
 	/*
 	 * This is a long-lived spinlock. That's fine.

