Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSFMDxq>; Wed, 12 Jun 2002 23:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSFMDxp>; Wed, 12 Jun 2002 23:53:45 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:24081 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317439AbSFMDxo>;
	Wed, 12 Jun 2002 23:53:44 -0400
From: kuebelr@email.uc.edu
Date: Wed, 12 Jun 2002 23:53:39 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] namespace.c - compiler warning
Message-Id: <20020613035339.GA3950@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init_rootfs() (from ramfs) doesn't appear in any header file.  I didn't
see any that looked like a good home, so lets put a prototype at the top
of fs/namespace.c.  This only use of this function is in namespace.c.

Patch is agains 2.4.19-pre10.

Rob.

--- linux-clean/fs/namespace.c  Fri Jun  7 23:42:07 2002
+++ linux-dirty/fs/namespace.c  Wed Jun 12 23:48:02 2002
@@ -29,6 +29,8 @@
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
 
+extern void init_rootfs(void);
+
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
        unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
