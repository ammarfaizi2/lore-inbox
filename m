Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUDKStt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUDKStt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 14:49:49 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:21702 "EHLO
	test.arklinux.org") by vger.kernel.org with ESMTP id S262448AbUDKStr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 14:49:47 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make 2.6.5-mm3 compile
Date: Sun, 11 Apr 2004 20:46:01 +0200
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pJZeAgXyuSiXRbU"
Message-Id: <200404112046.01682.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pJZeAgXyuSiXRbU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There's a couple of typos in mm/hugetlb.c

Fairly trivial patch attached.

--Boundary-00=_pJZeAgXyuSiXRbU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.5-mm3-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.5-mm3-compile.patch"

--- linux-2.6.5/mm/hugetlb.c.ark	2004-04-11 11:56:17.000000000 +0200
+++ linux-2.6.5/mm/hugetlb.c	2004-04-11 11:57:09.000000000 +0200
@@ -140,11 +140,11 @@
 	for (i = 0; i < MAX_NUMNODES; ++i) {
 		struct page *page;
 		list_for_each_entry(page, &hugepage_freelists[i], lru) {
-			if (PageHighmem(page))
+			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);
 			update_and_free_page(page);
-			--free_huge_pages
+			--free_huge_pages;
 			if (!--count)
 				return 0;
 		}

--Boundary-00=_pJZeAgXyuSiXRbU--
