Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVL2Qko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVL2Qko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVL2Qko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:40:44 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:50338 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750809AbVL2Qkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:43 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/5] Hostfs: remove unused var
Date: Thu, 29 Dec 2005 17:39:54 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051229163953.4985.51651.stgit@zion.home.lan>
In-Reply-To: <20051229163803.4985.66742.stgit@zion.home.lan>
References: <20051229163803.4985.66742.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Trivial removal of unused variable from this file - doesn't even change the
generated assembly code, in fact (gcc should trigger a warning for unused value
here).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 4684eb7..3aac164 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -910,10 +910,8 @@ static struct inode_operations hostfs_di
 int hostfs_link_readpage(struct file *file, struct page *page)
 {
 	char *buffer, *name;
-	long long start;
 	int err;
 
-	start = page->index << PAGE_CACHE_SHIFT;
 	buffer = kmap(page);
 	name = inode_name(page->mapping->host, 0);
 	if(name == NULL) return(-ENOMEM);

