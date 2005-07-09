Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVGIAAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVGIAAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVGIAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:00:29 -0400
Received: from silver.veritas.com ([143.127.12.111]:9535 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262986AbVGIAAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:00:00 -0400
Date: Sat, 9 Jul 2005 01:01:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] update swapfile i_sem comment
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090100350.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Jul 2005 23:59:59.0026 (UTC) FILETIME=[25A0A120:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update swap extents comment: nowadays we guard with S_SWAPFILE not i_sem.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.13-rc2-mm1/mm/swapfile.c	2005-07-07 12:33:21.000000000 +0100
+++ swap1/mm/swapfile.c	2005-07-08 19:13:21.000000000 +0100
@@ -924,7 +924,7 @@ add_swap_extent(struct swap_info_struct 
  * requirements, they are simply tossed out - we will never use those blocks
  * for swapping.
  *
- * For S_ISREG swapfiles we hold i_sem across the life of the swapon.  This
+ * For S_ISREG swapfiles we set S_SWAPFILE across the life of the swapon.  This
  * prevents root from shooting her foot off by ftruncating an in-use swapfile,
  * which will scribble on the fs.
  *
