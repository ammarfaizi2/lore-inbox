Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSKFC2O>; Tue, 5 Nov 2002 21:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265536AbSKFC0A>; Tue, 5 Nov 2002 21:26:00 -0500
Received: from holomorphy.com ([66.224.33.161]:65179 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265535AbSKFCZ1>;
	Tue, 5 Nov 2002 21:25:27 -0500
To: linux-kernel@vger.kernel.org
Subject: [7/7] hugetlb: make private functions static
Message-Id: <E189FxU-0002ZQ-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:30:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes various private structures and procedures static.

 hugetlbpage.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -urpN hugetlbfs-2.5.46-5/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46-6/arch/i386/mm/hugetlbpage.c
--- hugetlbfs-2.5.46-5/arch/i386/mm/hugetlbpage.c	2002-11-05 13:59:05.000000000 -0800
+++ hugetlbfs-2.5.46-6/arch/i386/mm/hugetlbpage.c	2002-11-05 14:02:05.000000000 -0800
@@ -18,16 +18,16 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-long    htlbpagemem = 0;
+static long    htlbpagemem;
 int     htlbpage_max;
-long    htlbzone_pages;
+static long    htlbzone_pages;
 
 struct vm_operations_struct hugetlb_vm_ops;
 static LIST_HEAD(htlbpage_freelist);
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
 #define MAX_ID 	32
-struct htlbpagekey {
+static struct htlbpagekey {
 	struct inode *in;
 	int key;
 } htlbpagek[MAX_ID];
@@ -109,7 +109,7 @@ static int anon_get_hugetlb_page(struct 
 	return page ? 1 : -1;
 }
 
-int make_hugetlb_pages_present(unsigned long addr, unsigned long end, int flags)
+static int make_hugetlb_pages_present(unsigned long addr, unsigned long end, int flags)
 {
 	int write;
 	struct mm_struct *mm = current->mm;
