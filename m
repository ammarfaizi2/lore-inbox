Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRGLPrn>; Thu, 12 Jul 2001 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbRGLPre>; Thu, 12 Jul 2001 11:47:34 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:49608 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266130AbRGLPrT>; Thu, 12 Jul 2001 11:47:19 -0400
Date: Thu, 12 Jul 2001 16:48:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking comment on do_wp_page()
Message-ID: <Pine.LNX.4.21.0107121643090.1934-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment on locking in do_wp_page() is out of date: copy do_swap_page().

Hugh

--- linux-2.4.7-pre6/mm/memory.c	Wed Jul 11 11:23:29 2001
+++ linux/mm/memory.c	Thu Jul 12 16:24:55 2001
@@ -888,8 +888,7 @@
  * change only once the write actually happens. This avoids a few races,
  * and potentially makes it more efficient.
  *
- * We enter with the page table read-lock held, and need to exit without
- * it.
+ * We hold the mm semaphore and the page_table_lock on entry and exit.
  */
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, pte_t *page_table, pte_t pte)

