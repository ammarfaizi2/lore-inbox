Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVKGVUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVKGVUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVKGVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:19:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13572 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965096AbVKGVTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:19:04 -0500
Date: Mon, 7 Nov 2005 22:19:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hugetlbfs/inode.c: make a function static
Message-ID: <20051107211903.GC3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Nov 2005

--- linux-2.6.14-rc5-mm1-full/fs/hugetlbfs/inode.c.old	2005-10-31 17:32:34.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/hugetlbfs/inode.c	2005-10-31 17:32:58.000000000 +0100
@@ -63,7 +63,7 @@
  *
  * Result is in bytes to be compatible with is_hugepage_mem_enough()
  */
-unsigned long
+static unsigned long
 huge_pages_needed(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	int i;

