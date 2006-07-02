Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWGBP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWGBP3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGBP3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:29:08 -0400
Received: from lb01nat09.inode.at ([62.99.145.9]:31696 "EHLO mx.inode.at")
	by vger.kernel.org with ESMTP id S932317AbWGBP3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:29:07 -0400
Date: Sun, 2 Jul 2006 17:29:26 +0200 (CEST)
From: Dominik Hackl <dominik@hackl.dhs.org>
X-X-Sender: dominik@mercury.foo
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: procfs fix
Message-ID: <Pine.LNX.4.61.0607021549550.6987@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a bug in fs/nfs which makes it impossible to build nfs 
without having procfs enabled.



        Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



diff -pruN linux-2.6.17-git20.orig/fs/nfs/internal.h linux-2.6.17-git20/fs/nfs/internal.h
--- linux-2.6.17-git20.orig/fs/nfs/internal.h	2006-07-02 15:18:02.000000000 +0200
+++ linux-2.6.17-git20/fs/nfs/internal.h	2006-07-02 15:27:13.000000000 +0200
@@ -81,9 +81,9 @@ extern struct file_system_type clone_nfs
 #ifdef CONFIG_NFS_V4
 extern struct file_system_type clone_nfs4_fs_type;
 #endif
-#ifdef CONFIG_PROC_FS
+
 extern struct rpc_stat nfs_rpcstat;
-#endif
+
 extern int __init register_nfs_fs(void);
 extern void __exit unregister_nfs_fs(void);
 
