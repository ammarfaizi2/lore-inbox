Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVKNVzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVKNVzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVKNVzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751284AbVKNVzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:19 -0500
Date: Mon, 14 Nov 2005 21:54:38 GMT
Message-Id: <200511142154.jAELscoK007527@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 7/12] FS-Cache: Export a couple of VM functions
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch exports a couple of VM functions needed by CacheFS.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 exports-2614mm2.diff
 mm/page-writeback.c |    1 +
 mm/swap.c           |    2 ++
 2 files changed, 3 insertions(+)

diff -uNrp linux-2.6.14-mm2/mm/page-writeback.c linux-2.6.14-mm2-cachefs/mm/page-writeback.c
--- linux-2.6.14-mm2/mm/page-writeback.c	2005-11-14 16:18:00.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/mm/page-writeback.c	2005-11-14 16:23:46.000000000 +0000
@@ -750,6 +750,7 @@ int clear_page_dirty_for_io(struct page 
 	}
 	return TestClearPageDirty(page);
 }
+EXPORT_SYMBOL_GPL(clear_page_dirty_for_io);
 
 int test_clear_page_writeback(struct page *page)
 {
diff -uNrp linux-2.6.14-mm2/mm/swap.c linux-2.6.14-mm2-cachefs/mm/swap.c
--- linux-2.6.14-mm2/mm/swap.c	2005-11-14 16:18:00.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/mm/swap.c	2005-11-14 16:23:46.000000000 +0000
@@ -149,6 +149,8 @@ void fastcall lru_cache_add(struct page 
 	put_cpu_var(lru_add_pvecs);
 }
 
+EXPORT_SYMBOL_GPL(lru_cache_add);
+
 void fastcall lru_cache_add_active(struct page *page)
 {
 	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
