Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWB0HCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWB0HCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWB0HCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:02:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751593AbWB0HC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:02:29 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Sun, 26 Feb 2006 23:02:14 -0800
Message-Id: <20060227070214.1994.87540.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/02] cpuset memory spread slab cache format
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Rewrap the overly long source code lines resulting
from the previous patch's addition of the slab
cache flag SLAB_MEM_SPREAD.  This patch contains only
formatting changes, and no function change.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 fs/adfs/super.c       |    3 ++-
 fs/affs/super.c       |    3 ++-
 fs/befs/linuxvfs.c    |    3 ++-
 fs/bfs/inode.c        |    3 ++-
 fs/block_dev.c        |    3 ++-
 fs/cifs/cifsfs.c      |    3 ++-
 fs/dquot.c            |    3 ++-
 fs/ext2/super.c       |    3 ++-
 fs/ext3/super.c       |    3 ++-
 fs/fat/inode.c        |    3 ++-
 fs/hpfs/super.c       |    3 ++-
 fs/isofs/inode.c      |    3 ++-
 fs/jffs/inode-v23.c   |   10 ++++++----
 fs/jffs2/super.c      |    3 ++-
 fs/jfs/super.c        |    3 ++-
 fs/minix/inode.c      |    3 ++-
 fs/ncpfs/inode.c      |    3 ++-
 fs/nfs/direct.c       |    3 ++-
 fs/nfs/inode.c        |    3 ++-
 fs/ocfs2/dlm/dlmfs.c  |    3 ++-
 fs/ocfs2/super.c      |    8 +++++---
 fs/proc/inode.c       |    3 ++-
 fs/qnx4/inode.c       |    3 ++-
 fs/reiserfs/super.c   |    3 ++-
 fs/romfs/inode.c      |    3 ++-
 fs/smbfs/inode.c      |    3 ++-
 fs/udf/super.c        |    3 ++-
 fs/ufs/super.c        |    3 ++-
 net/socket.c          |    3 ++-
 net/sunrpc/rpc_pipe.c |    7 ++++---
 30 files changed, 69 insertions(+), 37 deletions(-)

--- 2.6.16-rc4-mm2.orig/fs/adfs/super.c	2006-02-26 18:40:51.420223812 -0800
+++ 2.6.16-rc4-mm2/fs/adfs/super.c	2006-02-26 18:40:56.873409942 -0800
@@ -241,7 +241,8 @@ static int init_inodecache(void)
 {
 	adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
 					     sizeof(struct adfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (adfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/affs/super.c	2006-02-26 18:40:51.431942693 -0800
+++ 2.6.16-rc4-mm2/fs/affs/super.c	2006-02-26 18:40:56.891964837 -0800
@@ -98,7 +98,8 @@ static int init_inodecache(void)
 {
 	affs_inode_cachep = kmem_cache_create("affs_inode_cache",
 					     sizeof(struct affs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (affs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/befs/linuxvfs.c	2006-02-26 18:40:51.436825560 -0800
+++ 2.6.16-rc4-mm2/fs/befs/linuxvfs.c	2006-02-26 18:40:56.896847704 -0800
@@ -427,7 +427,8 @@ befs_init_inodecache(void)
 {
 	befs_inode_cachep = kmem_cache_create("befs_inode_cache",
 					      sizeof (struct befs_inode_info),
-					      0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					      0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					      init_once, NULL);
 	if (befs_inode_cachep == NULL) {
 		printk(KERN_ERR "befs_init_inodecache: "
--- 2.6.16-rc4-mm2.orig/fs/bfs/inode.c	2006-02-26 18:40:51.440731854 -0800
+++ 2.6.16-rc4-mm2/fs/bfs/inode.c	2006-02-26 18:40:56.899777425 -0800
@@ -257,7 +257,8 @@ static int init_inodecache(void)
 {
 	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
 					     sizeof(struct bfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (bfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/block_dev.c	2006-02-26 18:40:51.441708427 -0800
+++ 2.6.16-rc4-mm2/fs/block_dev.c	2006-02-26 18:40:56.901730572 -0800
@@ -319,7 +319,8 @@ void __init bdev_cache_init(void)
 {
 	int err;
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
-			0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_PANIC,
+			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+				SLAB_MEM_SPREAD|SLAB_PANIC),
 			init_once, NULL);
 	err = register_filesystem(&bd_type);
 	if (err)
--- 2.6.16-rc4-mm2.orig/fs/cifs/cifsfs.c	2006-02-26 18:40:51.444638148 -0800
+++ 2.6.16-rc4-mm2/fs/cifs/cifsfs.c	2006-02-26 18:40:56.915402600 -0800
@@ -692,7 +692,8 @@ cifs_init_inodecache(void)
 {
 	cifs_inode_cachep = kmem_cache_create("cifs_inode_cache",
 					      sizeof (struct cifsInodeInfo),
-					      0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					      0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					      cifs_init_once, NULL);
 	if (cifs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/dquot.c	2006-02-26 18:40:51.449521015 -0800
+++ 2.6.16-rc4-mm2/fs/dquot.c	2006-02-26 18:40:56.917355747 -0800
@@ -1817,7 +1817,8 @@ static int __init dquot_init(void)
 
 	dquot_cachep = kmem_cache_create("dquot", 
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_PANIC,
+			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+				SLAB_MEM_SPREAD|SLAB_PANIC),
 			NULL, NULL);
 
 	order = 0;
--- 2.6.16-rc4-mm2.orig/fs/ext2/super.c	2006-02-26 18:40:51.453427309 -0800
+++ 2.6.16-rc4-mm2/fs/ext2/super.c	2006-02-26 18:40:56.920285467 -0800
@@ -175,7 +175,8 @@ static int init_inodecache(void)
 {
 	ext2_inode_cachep = kmem_cache_create("ext2_inode_cache",
 					     sizeof(struct ext2_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (ext2_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ext3/super.c	2006-02-26 18:40:51.458310176 -0800
+++ 2.6.16-rc4-mm2/fs/ext3/super.c	2006-02-26 18:40:56.924191761 -0800
@@ -481,7 +481,8 @@ static int init_inodecache(void)
 {
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
 					     sizeof(struct ext3_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (ext3_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/fat/inode.c	2006-02-26 18:40:51.462216470 -0800
+++ 2.6.16-rc4-mm2/fs/fat/inode.c	2006-02-26 18:40:56.927121481 -0800
@@ -518,7 +518,8 @@ static int __init fat_init_inodecache(vo
 {
 	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
 					     sizeof(struct msdos_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (fat_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/hpfs/super.c	2006-02-26 18:40:51.467099337 -0800
+++ 2.6.16-rc4-mm2/fs/hpfs/super.c	2006-02-26 18:40:56.930051202 -0800
@@ -191,7 +191,8 @@ static int init_inodecache(void)
 {
 	hpfs_inode_cachep = kmem_cache_create("hpfs_inode_cache",
 					     sizeof(struct hpfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (hpfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/isofs/inode.c	2006-02-26 18:40:51.471005631 -0800
+++ 2.6.16-rc4-mm2/fs/isofs/inode.c	2006-02-26 18:40:56.932980922 -0800
@@ -87,7 +87,8 @@ static int init_inodecache(void)
 {
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					     sizeof(struct iso_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (isofs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/jffs/inode-v23.c	2006-02-26 18:40:51.473935351 -0800
+++ 2.6.16-rc4-mm2/fs/jffs/inode-v23.c	2006-02-26 18:40:56.936887216 -0800
@@ -1812,15 +1812,17 @@ init_jffs_fs(void)
 	}
 #endif
 	fm_cache = kmem_cache_create("jffs_fm", sizeof(struct jffs_fm),
-				     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
-				     NULL, NULL);
+		       0,
+		       SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+		       NULL, NULL);
 	if (!fm_cache) {
 		return -ENOMEM;
 	}
 
 	node_cache = kmem_cache_create("jffs_node",sizeof(struct jffs_node),
-				       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
-				       NULL, NULL);
+		       0,
+		       SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+		       NULL, NULL);
 	if (!node_cache) {
 		kmem_cache_destroy(fm_cache);
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/jffs2/super.c	2006-02-26 18:40:51.477841645 -0800
+++ 2.6.16-rc4-mm2/fs/jffs2/super.c	2006-02-26 18:40:56.939816936 -0800
@@ -331,7 +331,8 @@ static int __init init_jffs2_fs(void)
 
 	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     jffs2_i_init_once, NULL);
 	if (!jffs2_inode_cachep) {
 		printk(KERN_ERR "JFFS2 error: Failed to initialise inode cache\n");
--- 2.6.16-rc4-mm2.orig/fs/jfs/super.c	2006-02-26 18:40:51.479794792 -0800
+++ 2.6.16-rc4-mm2/fs/jfs/super.c	2006-02-26 18:40:56.943723230 -0800
@@ -634,7 +634,8 @@ static int __init init_jfs_fs(void)
 
 	jfs_inode_cachep =
 	    kmem_cache_create("jfs_ip", sizeof(struct jfs_inode_info), 0, 
-			    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, init_once, NULL);
+			    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+			    init_once, NULL);
 	if (jfs_inode_cachep == NULL)
 		return -ENOMEM;
 
--- 2.6.16-rc4-mm2.orig/fs/minix/inode.c	2006-02-26 18:40:51.508115422 -0800
+++ 2.6.16-rc4-mm2/fs/minix/inode.c	2006-02-26 18:40:56.984739315 -0800
@@ -80,7 +80,8 @@ static int init_inodecache(void)
 {
 	minix_inode_cachep = kmem_cache_create("minix_inode_cache",
 					     sizeof(struct minix_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (minix_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ncpfs/inode.c	2006-02-26 18:40:51.512021716 -0800
+++ 2.6.16-rc4-mm2/fs/ncpfs/inode.c	2006-02-26 18:40:56.988645608 -0800
@@ -72,7 +72,8 @@ static int init_inodecache(void)
 {
 	ncp_inode_cachep = kmem_cache_create("ncp_inode_cache",
 					     sizeof(struct ncp_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (ncp_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/nfs/direct.c	2006-02-26 18:40:51.513974863 -0800
+++ 2.6.16-rc4-mm2/fs/nfs/direct.c	2006-02-26 18:40:56.990598755 -0800
@@ -771,7 +771,8 @@ int nfs_init_directcache(void)
 {
 	nfs_direct_cachep = kmem_cache_create("nfs_direct_cache",
 						sizeof(struct nfs_direct_req),
-						0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+						0, (SLAB_RECLAIM_ACCOUNT|
+							SLAB_MEM_SPREAD),
 						NULL, NULL);
 	if (nfs_direct_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/nfs/inode.c	2006-02-26 18:40:51.515928009 -0800
+++ 2.6.16-rc4-mm2/fs/nfs/inode.c	2006-02-26 18:40:56.991575329 -0800
@@ -2163,7 +2163,8 @@ static int nfs_init_inodecache(void)
 {
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (nfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ocfs2/dlm/dlmfs.c	2006-02-26 18:40:51.521787450 -0800
+++ 2.6.16-rc4-mm2/fs/ocfs2/dlm/dlmfs.c	2006-02-26 18:40:56.995481623 -0800
@@ -596,7 +596,8 @@ static int __init init_dlmfs_fs(void)
 
 	dlmfs_inode_cache = kmem_cache_create("dlmfs_inode_cache",
 				sizeof(struct dlmfs_inode_private),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+					SLAB_MEM_SPREAD),
 				dlmfs_init_once, NULL);
 	if (!dlmfs_inode_cache)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ocfs2/super.c	2006-02-26 18:40:51.523740597 -0800
+++ 2.6.16-rc4-mm2/fs/ocfs2/super.c	2006-02-26 18:40:56.999387916 -0800
@@ -950,9 +950,11 @@ static void ocfs2_inode_init_once(void *
 static int ocfs2_initialize_mem_caches(void)
 {
 	ocfs2_inode_cachep = kmem_cache_create("ocfs2_inode_cache",
-					       sizeof(struct ocfs2_inode_info),
-					       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
-					       ocfs2_inode_init_once, NULL);
+				       sizeof(struct ocfs2_inode_info),
+				       0,
+				       (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
+				       ocfs2_inode_init_once, NULL);
 	if (!ocfs2_inode_cachep)
 		return -ENOMEM;
 
--- 2.6.16-rc4-mm2.orig/fs/proc/inode.c	2006-02-26 18:40:51.526670317 -0800
+++ 2.6.16-rc4-mm2/fs/proc/inode.c	2006-02-26 18:40:57.001341063 -0800
@@ -121,7 +121,8 @@ int __init proc_init_inodecache(void)
 {
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (proc_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/qnx4/inode.c	2006-02-26 18:40:51.529600038 -0800
+++ 2.6.16-rc4-mm2/fs/qnx4/inode.c	2006-02-26 18:40:57.005247357 -0800
@@ -546,7 +546,8 @@ static int init_inodecache(void)
 {
 	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
 					     sizeof(struct qnx4_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (qnx4_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/reiserfs/super.c	2006-02-26 18:40:51.534482905 -0800
+++ 2.6.16-rc4-mm2/fs/reiserfs/super.c	2006-02-26 18:40:57.009153651 -0800
@@ -521,7 +521,8 @@ static int init_inodecache(void)
 	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
 						  sizeof(struct
 							 reiserfs_inode_info),
-						  0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+						  0, (SLAB_RECLAIM_ACCOUNT|
+							SLAB_MEM_SPREAD),
 						  init_once, NULL);
 	if (reiserfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/romfs/inode.c	2006-02-26 18:40:51.536436052 -0800
+++ 2.6.16-rc4-mm2/fs/romfs/inode.c	2006-02-26 18:40:57.012083371 -0800
@@ -579,7 +579,8 @@ static int init_inodecache(void)
 {
 	romfs_inode_cachep = kmem_cache_create("romfs_inode_cache",
 					     sizeof(struct romfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (romfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/smbfs/inode.c	2006-02-26 18:40:51.539365772 -0800
+++ 2.6.16-rc4-mm2/fs/smbfs/inode.c	2006-02-26 18:40:57.016966238 -0800
@@ -80,7 +80,8 @@ static int init_inodecache(void)
 {
 	smb_inode_cachep = kmem_cache_create("smb_inode_cache",
 					     sizeof(struct smb_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (smb_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/udf/super.c	2006-02-26 18:40:51.545225213 -0800
+++ 2.6.16-rc4-mm2/fs/udf/super.c	2006-02-26 18:40:57.018919385 -0800
@@ -140,7 +140,8 @@ static int init_inodecache(void)
 {
 	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
 					     sizeof(struct udf_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (udf_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ufs/super.c	2006-02-26 18:40:51.548154933 -0800
+++ 2.6.16-rc4-mm2/fs/ufs/super.c	2006-02-26 18:40:57.022825679 -0800
@@ -1184,7 +1184,8 @@ static int init_inodecache(void)
 {
 	ufs_inode_cachep = kmem_cache_create("ufs_inode_cache",
 					     sizeof(struct ufs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+					     0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
 					     init_once, NULL);
 	if (ufs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/net/socket.c	2006-02-26 18:40:51.550108080 -0800
+++ 2.6.16-rc4-mm2/net/socket.c	2006-02-26 18:40:57.024778826 -0800
@@ -319,7 +319,8 @@ static int init_inodecache(void)
 {
 	sock_inode_cachep = kmem_cache_create("sock_inode_cache",
 				sizeof(struct socket_alloc),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+					SLAB_MEM_SPREAD),
 				init_once, NULL);
 	if (sock_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/net/sunrpc/rpc_pipe.c	2006-02-26 18:40:51.554990947 -0800
+++ 2.6.16-rc4-mm2/net/sunrpc/rpc_pipe.c	2006-02-26 18:40:57.027708546 -0800
@@ -849,9 +849,10 @@ init_once(void * foo, kmem_cache_t * cac
 int register_rpc_pipefs(void)
 {
 	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
-                                             sizeof(struct rpc_inode),
-                                             0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
-                                             init_once, NULL);
+				sizeof(struct rpc_inode),
+				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
+				init_once, NULL);
 	if (!rpc_inode_cachep)
 		return -ENOMEM;
 	register_filesystem(&rpc_pipe_fs_type);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
