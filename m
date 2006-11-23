Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933688AbWKWNUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbWKWNUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWKWNUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:20:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34978 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933688AbWKWNUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:20:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 28/19] FS-Cache: NFS: Handle caching being disabled correctly
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 13:17:21 +0000
Message-ID: <29741.1164287841@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make the prototypes of the cache-disabled stubs consistent with the
cache-enabled functions

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index c363421..4e42bc9 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -445,7 +445,7 @@ static inline void nfs_fscache_renew_fh_
 static inline void nfs_fscache_disable_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_set_fh_cookie(struct inode *inode, struct file *filp) {}
 static inline void nfs_fscache_install_vm_ops(struct inode *inode, struct vm_area_struct *vma) {}
-static inline int nfs_fscache_release_page(struct page *page)
+static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
 	return 1; /* True: may release page */
 }
