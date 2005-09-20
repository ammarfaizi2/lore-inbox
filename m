Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVITSsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVITSsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVITSsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:13 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:12736 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965069AbVITSsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:13 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/7] Clearify comment in swapfile.c
Date: Tue, 20 Sep 2005 20:45:50 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184549.14557.12139.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

That comment is unclear enough (since there's no pte_wrprotect) that I
"fixed" it, and even Hugh, when rejecting my "fix", agreed on the code
being "mystifying". So here's a note on this.

CC: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/swapfile.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -399,9 +399,10 @@ void free_swap_and_cache(swp_entry_t ent
 
 /*
  * Always set the resulting pte to be nowrite (the same as COW pages
- * after one process has exited).  We don't know just how many PTEs will
- * share this swap entry, so be cautious and let do_wp_page work out
- * what to do if a write is requested later.
+ * after one process has exited - so vma->vm_page_prot is already
+ * write-protected). We don't know just how many PTEs will share this
+ * swap entry, so be cautious and let do_wp_page work out what to do if
+ * a write is requested later.
  *
  * vma->vm_mm->page_table_lock is held.
  */

