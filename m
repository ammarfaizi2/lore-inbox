Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVAGBlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVAGBlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVAGBks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:40:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27142 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261253AbVAGB3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:29:02 -0500
Date: Fri, 7 Jan 2005 02:29:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hugetlbfs/inode.c: make 4 functions static
Message-ID: <20050107012900.GD14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes four needlessly global functions static.


diffstta output:
 fs/hugetlbfs/inode.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/hugetlbfs/inode.c.old	2005-01-07 00:54:42.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hugetlbfs/inode.c	2005-01-07 00:55:32.000000000 +0100
@@ -168,7 +168,7 @@
 	return -EINVAL;
 }
 
-void huge_pagevec_release(struct pagevec *pvec)
+static void huge_pagevec_release(struct pagevec *pvec)
 {
 	int i;
 
@@ -178,7 +178,7 @@
 	pagevec_reinit(pvec);
 }
 
-void truncate_huge_page(struct page *page)
+static void truncate_huge_page(struct page *page)
 {
 	clear_page_dirty(page);
 	ClearPageUptodate(page);
@@ -186,7 +186,7 @@
 	put_page(page);
 }
 
-void truncate_hugepages(struct address_space *mapping, loff_t lstart)
+static void truncate_hugepages(struct address_space *mapping, loff_t lstart)
 {
 	const pgoff_t start = lstart >> HPAGE_SHIFT;
 	struct pagevec pvec;
@@ -495,7 +495,7 @@
 /*
  * For direct-IO reads into hugetlb pages
  */
-int hugetlbfs_set_page_dirty(struct page *page)
+static int hugetlbfs_set_page_dirty(struct page *page)
 {
 	return 0;
 }

