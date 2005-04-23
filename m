Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDWAD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDWAD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDWAD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:03:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261368AbVDWADU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:03:20 -0400
Date: Sat, 23 Apr 2005 02:03:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nfs/: make some functions static
Message-ID: <20050423000315.GM4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfs/idmap.c |    4 ++--
 fs/nfs/inode.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/nfs/idmap.c.old	2005-04-20 23:55:03.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfs/idmap.c	2005-04-20 23:55:20.000000000 +0200
@@ -80,7 +80,7 @@
 		     char __user *, size_t);
 static ssize_t   idmap_pipe_downcall(struct file *, const char __user *,
 		     size_t);
-void             idmap_pipe_destroy_msg(struct rpc_pipe_msg *);
+static void      idmap_pipe_destroy_msg(struct rpc_pipe_msg *);
 
 static unsigned int fnvhash32(const void *, size_t);
 
@@ -435,7 +435,7 @@
 	return ret;
 }
 
-void
+static void
 idmap_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 {
 	struct idmap_msg *im = msg->data;
--- linux-2.6.12-rc2-mm3-full/fs/nfs/inode.c.old	2005-04-20 23:55:35.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nfs/inode.c	2005-04-20 23:56:05.000000000 +0200
@@ -1996,7 +1996,7 @@
 	}
 }
  
-int nfs_init_inodecache(void)
+static int nfs_init_inodecache(void)
 {
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
@@ -2008,7 +2008,7 @@
 	return 0;
 }
 
-void nfs_destroy_inodecache(void)
+static void nfs_destroy_inodecache(void)
 {
 	if (kmem_cache_destroy(nfs_inode_cachep))
 		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");

