Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWARLxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWARLxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWARLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:53:49 -0500
Received: from 81-178-120-66.dsl.pipex.com ([81.178.120.66]:34016 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030241AbWARLxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:53:48 -0500
Date: Wed, 18 Jan 2006 11:53:32 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] migrate_page_add mangled brackets during merge
Message-ID: <20060118115332.GA15951@shadowen.org>
References: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060118005053.118f1abc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_page_add mangled brackets during merge

It appears that there was some kind of merge mangle in migrate_page_add().
Sort out an extraneous bracket and a couple of spacing issues.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 mempolicy.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)
diff -upN reference/mm/mempolicy.c current/mm/mempolicy.c
--- reference/mm/mempolicy.c
+++ current/mm/mempolicy.c
@@ -533,17 +533,15 @@ long do_get_mempolicy(int *policy, nodem
 /*
  * page migration
  */
-
 static void migrate_page_add(struct page *page, struct list_head *pagelist,
 				unsigned long flags)
 {
 	/*
 	 * Avoid migrating a page that is shared with others.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) ==1)
+	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) == 1)
 		if (isolate_lru_page(page))
 			list_add(&page->lru, pagelist);
-	}
 }
 
 /*
