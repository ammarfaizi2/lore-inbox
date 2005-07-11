Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVGKJ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVGKJ0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGKJ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:26:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:13453 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261499AbVGKJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:25:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Update mmu.h header to match implementation changes
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050711092450.99529627@mctpc71>
Date: Mon, 11 Jul 2005 18:24:50 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/mmu.h |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff -ruN -X../cludes linux-2.6.11-uc0/include/asm-v850/mmu.h linux-2.6.11-uc0-v850-20050711/include/asm-v850/mmu.h
--- linux-2.6.11-uc0/include/asm-v850/mmu.h	2002-11-05 11:25:32.169771000 +0900
+++ linux-2.6.11-uc0-v850-20050711/include/asm-v850/mmu.h	2005-04-11 13:46:11.741698000 +0900
@@ -1,22 +1,11 @@
-/* Copyright (C) 2002, David McCullough <davidm@snapgear.com> */
+/* Copyright (C) 2002, 2005, David McCullough <davidm@snapgear.com> */
 
 #ifndef __V850_MMU_H__
 #define __V850_MMU_H__
 
-struct mm_rblock_struct {
-	int		size;
-	int		refcount;
-	void	*kblock;
-};
-
-struct mm_tblock_struct {
-	struct mm_rblock_struct	*rblock;
-	struct mm_tblock_struct	*next;
-};
-
 typedef struct {
-	struct mm_tblock_struct	tblock;
-	unsigned long			end_brk;
+	struct vm_list_struct	*vmlist;
+	unsigned long		end_brk;
 } mm_context_t;
 
 #endif /* __V850_MMU_H__ */
