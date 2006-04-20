Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDTRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDTRAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDTQ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:59:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751140AbWDTQ7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:59:46 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/7] FS-Cache: Export find_get_pages()
Date: Thu, 20 Apr 2006 17:59:35 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch exports find_get_pages() for use by the kAFS filesystem in
conjunction with it caching patch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/filemap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d4a598f..d6f7ab4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -714,6 +714,8 @@ unsigned find_get_pages(struct address_s
 	return ret;
 }
 
+EXPORT_SYMBOL(find_get_pages);
+
 /*
  * Like find_get_pages, except we only return pages which are tagged with
  * `tag'.   We update *index to index the next page for the traversal.

