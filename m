Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVCYRcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVCYRcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVCYR3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:29:34 -0500
Received: from mail.dif.dk ([193.138.115.101]:39324 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261704AbVCYR2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:28:38 -0500
Date: Fri, 25 Mar 2005 18:30:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][5/5] cifs: cifsfs.c cleanup - remove redundant casts
Message-ID: <Pine.LNX.4.62.0503251828050.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two redundant casts.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c.with_patch4	2005-03-25 18:03:49.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-25 18:10:55.000000000 +0100
@@ -233,9 +233,7 @@ mempool_t *cifs_mid_poolp;
 static struct inode *cifs_alloc_inode(struct super_block *sb)
 {
 	struct cifsInodeInfo *cifs_inode;
-	cifs_inode =
-	    (struct cifsInodeInfo *)kmem_cache_alloc(cifs_inode_cachep,
-						     SLAB_KERNEL);
+	cifs_inode = kmem_cache_alloc(cifs_inode_cachep, SLAB_KERNEL);
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20; /* default */
@@ -595,7 +593,7 @@ struct file_operations cifs_dir_ops = {
 static void cifs_init_once(void *inode, kmem_cache_t *cachep,
 	unsigned long flags)
 {
-	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *)inode;
+	struct cifsInodeInfo *cifsi = inode;
 
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
