Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263500AbSJGXJW>; Mon, 7 Oct 2002 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263734AbSJGXJW>; Mon, 7 Oct 2002 19:09:22 -0400
Received: from group1.mxgrp.airmail.net ([209.196.77.107]:51466 "EHLO
	mx10.airmail.net") by vger.kernel.org with ESMTP id <S263500AbSJGXHU>;
	Mon, 7 Oct 2002 19:07:20 -0400
Date: Mon, 7 Oct 2002 17:09:44 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializer for fs/hfs
Message-ID: <20021007220944.GB9856@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches converting fs/hfs to use C99 designated
initializers.  Mail to maintainer Adrian Sun (asun@cobaltnet.com)
isn't acknowleged, so I don't know if the patches reach him or not,
or if HFS is even maintained. :-/

Art Haas


--- linux-2.5.41/fs/hfs/dir_cap.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.41/fs/hfs/dir_cap.c	2002-10-07 15:51:35.000000000 -0500
@@ -59,30 +59,30 @@
 #define DOT_ROOTINFO	(&hfs_cap_reserved2[0])
 
 struct file_operations hfs_cap_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	cap_readdir,
-	fsync:		file_fsync,
+	.read		= generic_read_dir,
+	.readdir	= cap_readdir,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_cap_ndir_inode_operations = {
-	create:		hfs_create,
-	lookup:		cap_lookup,
-	unlink:		hfs_unlink,
-	mkdir:		hfs_mkdir,
-	rmdir:		hfs_rmdir,
-	rename:		hfs_rename,
-	setattr:	hfs_notify_change,
+	.create		= hfs_create,
+	.lookup		= cap_lookup,
+	.unlink		= hfs_unlink,
+	.mkdir		= hfs_mkdir,
+	.rmdir		= hfs_rmdir,
+	.rename		= hfs_rename,
+	.setattr	= hfs_notify_change,
 };
 
 struct inode_operations hfs_cap_fdir_inode_operations = {
-	lookup:		cap_lookup,
-	setattr:	hfs_notify_change,
+	.lookup		= cap_lookup,
+	.setattr	= hfs_notify_change,
 };
 
 struct inode_operations hfs_cap_rdir_inode_operations = {
-	create:		hfs_create,
-	lookup:		cap_lookup,
-	setattr:	hfs_notify_change,
+	.create		= hfs_create,
+	.lookup		= cap_lookup,
+	.setattr	= hfs_notify_change,
 };
 
 /*================ File-local functions ================*/
--- linux-2.5.41/fs/hfs/dir_dbl.c.old	2002-07-05 18:42:20.000000000 -0500
+++ linux-2.5.41/fs/hfs/dir_dbl.c	2002-10-07 15:51:35.000000000 -0500
@@ -58,19 +58,19 @@
 #define PCNT_ROOTINFO	(&hfs_dbl_reserved2[1])
 
 struct file_operations hfs_dbl_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dbl_readdir,
-	fsync:		file_fsync,
+	.read		= generic_read_dir,
+	.readdir	= dbl_readdir,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_dbl_dir_inode_operations = {
-	create:		dbl_create,
-	lookup:		dbl_lookup,
-	unlink:		dbl_unlink,
-	mkdir:		dbl_mkdir,
-	rmdir:		dbl_rmdir,
-	rename:		dbl_rename,
-	setattr:	hfs_notify_change,
+	.create		= dbl_create,
+	.lookup		= dbl_lookup,
+	.unlink		= dbl_unlink,
+	.mkdir		= dbl_mkdir,
+	.rmdir		= dbl_rmdir,
+	.rename		= dbl_rename,
+	.setattr	= hfs_notify_change,
 };
 
 
--- linux-2.5.41/fs/hfs/dir_nat.c.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.41/fs/hfs/dir_nat.c	2002-10-07 15:51:36.000000000 -0500
@@ -64,27 +64,27 @@
 #define ROOTINFO        (&hfs_nat_reserved2[0])
 
 struct file_operations hfs_nat_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	nat_readdir,
-	fsync:		file_fsync,
+	.read		= generic_read_dir,
+	.readdir	= nat_readdir,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_nat_ndir_inode_operations = {
-	create:		hfs_create,
-	lookup:		nat_lookup,
-	unlink:		hfs_unlink,
-	mkdir:		hfs_mkdir,
-	rmdir:		nat_rmdir,
-	rename:		hfs_rename,
-	setattr:	hfs_notify_change,
+	.create		= hfs_create,
+	.lookup		= nat_lookup,
+	.unlink		= hfs_unlink,
+	.mkdir		= hfs_mkdir,
+	.rmdir		= nat_rmdir,
+	.rename		= hfs_rename,
+	.setattr	= hfs_notify_change,
 };
 
 struct inode_operations hfs_nat_hdir_inode_operations = {
-	create:		hfs_create,
-	lookup:		nat_lookup,
-	unlink:		nat_hdr_unlink,
-	rename:		nat_hdr_rename,
-	setattr:	hfs_notify_change,
+	.create		= hfs_create,
+	.lookup		= nat_lookup,
+	.unlink		= nat_hdr_unlink,
+	.rename		= nat_hdr_rename,
+	.setattr	= hfs_notify_change,
 };
 
 /*================ File-local functions ================*/
--- linux-2.5.41/fs/hfs/file.c.old	2002-07-05 18:42:20.000000000 -0500
+++ linux-2.5.41/fs/hfs/file.c	2002-10-07 15:51:35.000000000 -0500
@@ -34,16 +34,16 @@
 /*================ Global variables ================*/
 
 struct file_operations hfs_file_operations = {
-	llseek:		generic_file_llseek,
-	read:		hfs_file_read,
-	write:		hfs_file_write,
-	mmap:		generic_file_mmap,
-	fsync:		file_fsync,
+	.llseek		= generic_file_llseek,
+	.read		= hfs_file_read,
+	.write		= hfs_file_write,
+	.mmap		= generic_file_mmap,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_file_inode_operations = {
-	truncate:	hfs_file_truncate,
-	setattr:	hfs_notify_change,
+	.truncate	= hfs_file_truncate,
+	.setattr	= hfs_notify_change,
 };
 
 /*================ Variable-like macros ================*/
--- linux-2.5.41/fs/hfs/file_cap.c.old	2002-07-05 18:42:00.000000000 -0500
+++ linux-2.5.41/fs/hfs/file_cap.c	2002-10-07 15:51:35.000000000 -0500
@@ -47,14 +47,14 @@
 /*================ Global variables ================*/
 
 struct file_operations hfs_cap_info_operations = {
-	llseek:		cap_info_llseek,
-	read:		cap_info_read,
-	write:		cap_info_write,
-	fsync:		file_fsync,
+	.llseek		= cap_info_llseek,
+	.read		= cap_info_read,
+	.write		= cap_info_write,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_cap_info_inode_operations = {
-	setattr:	hfs_notify_change_cap,
+	.setattr	= hfs_notify_change_cap,
 };
 
 /*================ File-local functions ================*/
--- linux-2.5.41/fs/hfs/file_hdr.c.old	2002-07-05 18:42:32.000000000 -0500
+++ linux-2.5.41/fs/hfs/file_hdr.c	2002-10-07 15:51:36.000000000 -0500
@@ -47,20 +47,20 @@
 /*================ Global variables ================*/
 
 struct file_operations hfs_hdr_operations = {
-	llseek:		hdr_llseek,
-	read:		hdr_read,
-	write:		hdr_write,
-	fsync:		file_fsync,
+	.llseek		= hdr_llseek,
+	.read		= hdr_read,
+	.write		= hdr_write,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations hfs_hdr_inode_operations = {
-	setattr:	hfs_notify_change_hdr,
+	.setattr	= hfs_notify_change_hdr,
 };
 
 const struct hfs_hdr_layout hfs_dbl_fil_hdr_layout = {
-	magic:		__constant_htonl(HFS_DBL_MAGIC),	/* magic   */
-	version:	__constant_htonl(HFS_HDR_VERSION_2),	/* version */
-	entries:	6,					/* entries */
+	.magic		= __constant_htonl(HFS_DBL_MAGIC),	/* magic   */
+	.version	= __constant_htonl(HFS_HDR_VERSION_2),	/* version */
+	.entries	= 6,					/* entries */
 	{					/* descr[] */
 		{HFS_HDR_FNAME, offsetof(struct hfs_dbl_hdr, real_name),   ~0},
 		{HFS_HDR_DATES, offsetof(struct hfs_dbl_hdr, create_time), 16},
@@ -80,9 +80,9 @@
 };
 
 const struct hfs_hdr_layout hfs_dbl_dir_hdr_layout = {
-	magic:		__constant_htonl(HFS_DBL_MAGIC),	/* magic   */
-	version:	__constant_htonl(HFS_HDR_VERSION_2),	/* version */
-	entries:	5,					/* entries */
+	.magic		= __constant_htonl(HFS_DBL_MAGIC),	/* magic   */
+	.version	= __constant_htonl(HFS_HDR_VERSION_2),	/* version */
+	.entries	= 5,					/* entries */
 	{					/* descr[] */
 		{HFS_HDR_FNAME, offsetof(struct hfs_dbl_hdr, real_name),   ~0},
 		{HFS_HDR_DATES, offsetof(struct hfs_dbl_hdr, create_time), 16},
@@ -100,9 +100,9 @@
 };
 
 const struct hfs_hdr_layout hfs_nat2_hdr_layout = {
-	magic:		__constant_htonl(HFS_DBL_MAGIC),	/* magic   */
-	version:	__constant_htonl(HFS_HDR_VERSION_2),	/* version */
-	entries:	9,					/* entries */
+	.magic		= __constant_htonl(HFS_DBL_MAGIC),	/* magic   */
+	.version	= __constant_htonl(HFS_HDR_VERSION_2),	/* version */
+	.entries	= 9,					/* entries */
 	{					/* descr[] */
 		{HFS_HDR_FNAME, offsetof(struct hfs_dbl_hdr, real_name),   ~0},
 		{HFS_HDR_COMNT, offsetof(struct hfs_dbl_hdr, comment),      0},
@@ -128,9 +128,9 @@
 };
 
 const struct hfs_hdr_layout hfs_nat_hdr_layout = {
-	magic:		__constant_htonl(HFS_DBL_MAGIC),	/* magic   */
-	version:	__constant_htonl(HFS_HDR_VERSION_1),	/* version */
-	entries:	5,					/* entries */
+	.magic		= __constant_htonl(HFS_DBL_MAGIC),	/* magic   */
+	.version	= __constant_htonl(HFS_HDR_VERSION_1),	/* version */
+	.entries	= 5,					/* entries */
 	{					/* descr[] */
 		{HFS_HDR_FNAME, offsetof(struct hfs_dbl_hdr, real_name),   ~0},
 		{HFS_HDR_COMNT, offsetof(struct hfs_dbl_hdr, comment),      0},
--- linux-2.5.41/fs/hfs/inode.c.old	2002-07-05 18:42:23.000000000 -0500
+++ linux-2.5.41/fs/hfs/inode.c	2002-10-07 15:51:36.000000000 -0500
@@ -247,12 +247,12 @@
 	return generic_block_bmap(mapping,block,hfs_get_block);
 }
 struct address_space_operations hfs_aops = {
-	readpage: hfs_readpage,
-	writepage: hfs_writepage,
-	sync_page: block_sync_page,
-	prepare_write: hfs_prepare_write,
-	commit_write: generic_commit_write,
-	bmap: hfs_bmap
+	.readpage = hfs_readpage,
+	.writepage = hfs_writepage,
+	.sync_page = block_sync_page,
+	.prepare_write = hfs_prepare_write,
+	.commit_write = generic_commit_write,
+	.bmap = hfs_bmap
 };
 
 /*
--- linux-2.5.41/fs/hfs/super.c.old	2002-07-05 18:42:20.000000000 -0500
+++ linux-2.5.41/fs/hfs/super.c	2002-10-07 15:51:35.000000000 -0500
@@ -87,13 +87,13 @@
 /*================ Global variables ================*/
 
 static struct super_operations hfs_super_operations = { 
-	alloc_inode:	hfs_alloc_inode,
-	destroy_inode:	hfs_destroy_inode,
-	read_inode:	hfs_read_inode,
-	put_inode:	hfs_put_inode,
-	put_super:	hfs_put_super,
-	write_super:	hfs_write_super,
-	statfs:		hfs_statfs,
+	.alloc_inode	= hfs_alloc_inode,
+	.destroy_inode	= hfs_destroy_inode,
+	.read_inode	= hfs_read_inode,
+	.put_inode	= hfs_put_inode,
+	.put_super	= hfs_put_super,
+	.write_super	= hfs_write_super,
+	.statfs		= hfs_statfs,
 };
 
 /*================ File-local variables ================*/
@@ -105,11 +105,11 @@
 }
 
 static struct file_system_type hfs_fs = {
-	owner:		THIS_MODULE,
-	name:		"hfs",
-	get_sb:		hfs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "hfs",
+	.get_sb		= hfs_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 /*================ File-local functions ================*/
--- linux-2.5.41/fs/hfs/sysdep.c.old	2002-07-05 18:42:31.000000000 -0500
+++ linux-2.5.41/fs/hfs/sysdep.c	2002-10-07 15:51:36.000000000 -0500
@@ -25,10 +25,10 @@
 static void hfs_dentry_iput(struct dentry *, struct inode *);
 struct dentry_operations hfs_dentry_operations =
 {
-	d_revalidate:	hfs_revalidate_dentry,	
-	d_hash:		hfs_hash_dentry,
-	d_compare:	hfs_compare_dentry,
-	d_iput:		hfs_dentry_iput,
+	.d_revalidate	= hfs_revalidate_dentry,	
+	.d_hash		= hfs_hash_dentry,
+	.d_compare	= hfs_compare_dentry,
+	.d_iput		= hfs_dentry_iput,
 };
 
 /*

-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
