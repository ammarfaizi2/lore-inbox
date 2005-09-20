Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVITSsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVITSsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVITSsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:48:14 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:12992 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965070AbVITSsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:48:13 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/7] fix locking comment in unmap_region()
Date: Tue, 20 Sep 2005 20:45:38 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050920184537.14557.4586.stgit@zion.home.lan>
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

That comment is plain wrong (we even take the pagetable lock inside
unmap_region()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/mmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1640,7 +1640,7 @@ static void unmap_vma_list(struct mm_str
 /*
  * Get rid of page table information in the indicated region.
  *
- * Called with the page table lock held.
+ * Called with the mm semaphore held.
  */
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,

