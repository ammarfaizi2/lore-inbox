Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUBHB1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBHBZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:25:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55238 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261909AbUBHBYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:24:44 -0500
Date: Sun, 8 Feb 2004 02:24:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] adfs: remove a kernel 2.2 #ifdef
Message-ID: <20040208012441.GK7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a kernel 2.2 #ifdef from fs/adfs/adfs.h .

Note that this #ifdef was only present in the header, the implementation 
of adfs_bmap was already removed.

Please apply
Adrian

--- linux-2.6.2-mm1/fs/adfs/adfs.h.old	2004-02-08 02:20:03.000000000 +0100
+++ linux-2.6.2-mm1/fs/adfs/adfs.h	2004-02-08 02:20:38.000000000 +0100
@@ -68,12 +68,8 @@
 
 
 /* Inode stuff */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
 int adfs_get_block(struct inode *inode, sector_t block,
 		   struct buffer_head *bh, int create);
-#else
-int adfs_bmap(struct inode *inode, int block);
-#endif
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
 void adfs_read_inode(struct inode *inode);
 void adfs_write_inode(struct inode *inode,int unused);
