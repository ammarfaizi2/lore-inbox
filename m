Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272916AbTHKRVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272801AbTHKQtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:65368 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272796AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] correct tlb_remove_page comment.
Message-Id: <E19mFqr-00068E-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove prototype. It was wrong anyway.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-generic/tlb.h linux-2.5/include/asm-generic/tlb.h
--- bk-linus/include/asm-generic/tlb.h	2003-05-26 12:57:43.000000000 +0100
+++ linux-2.5/include/asm-generic/tlb.h	2003-07-13 06:05:04.000000000 +0100
@@ -99,7 +99,7 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 }
 
 
-/* void tlb_remove_page(struct mmu_gather *tlb, pte_t *ptep, unsigned long addr)
+/* tlb_remove_page
  *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
  *	handling the additional races in SMP caused by other CPUs caching valid
  *	mappings in their TLBs.
