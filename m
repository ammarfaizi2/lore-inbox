Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTESAib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 20:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTESAia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 20:38:30 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:1773 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S261965AbTESAiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 20:38:20 -0400
Message-ID: <3EC82A7D.5090105@quark.didntduck.org>
Date: Sun, 18 May 2003 20:51:09 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update fs Makefiles
Content-Type: multipart/mixed;
 boundary="------------040409060204000301090104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409060204000301090104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert foo-objs to newer-style foo-y.

--
				Brian Gerst

--------------040409060204000301090104
Content-Type: text/plain;
 name="make-objs-fs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make-objs-fs"

diff -urN linux-2.5.69-bk/fs/adfs/Makefile linux/fs/adfs/Makefile
--- linux-2.5.69-bk/fs/adfs/Makefile	2003-04-07 13:30:34.000000000 -0400
+++ linux/fs/adfs/Makefile	2003-05-18 15:49:45.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_ADFS_FS) += adfs.o
 
-adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
+adfs-y := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
diff -urN linux-2.5.69-bk/fs/affs/Makefile linux/fs/affs/Makefile
--- linux-2.5.69-bk/fs/affs/Makefile	2003-04-07 13:32:49.000000000 -0400
+++ linux/fs/affs/Makefile	2003-05-18 15:49:50.000000000 -0400
@@ -6,4 +6,4 @@
 
 obj-$(CONFIG_AFFS_FS) += affs.o
 
-affs-objs := super.o namei.o inode.o file.o dir.o amigaffs.o bitmap.o symlink.o
+affs-y := super.o namei.o inode.o file.o dir.o amigaffs.o bitmap.o symlink.o
diff -urN linux-2.5.69-bk/fs/afs/Makefile linux/fs/afs/Makefile
--- linux-2.5.69-bk/fs/afs/Makefile	2003-04-07 13:31:50.000000000 -0400
+++ linux/fs/afs/Makefile	2003-05-18 15:49:54.000000000 -0400
@@ -2,7 +2,7 @@
 # Makefile for Red Hat Linux AFS client.
 #
 
-kafs-objs := \
+kafs-y := \
 	callback.o \
 	cell.o \
 	cmservice.o \
diff -urN linux-2.5.69-bk/fs/autofs/Makefile linux/fs/autofs/Makefile
--- linux-2.5.69-bk/fs/autofs/Makefile	2003-04-07 13:33:03.000000000 -0400
+++ linux/fs/autofs/Makefile	2003-05-18 15:50:01.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_AUTOFS_FS) += autofs.o
 
-autofs-objs := dirhash.o init.o inode.o root.o symlink.o waitq.o
+autofs-y := dirhash.o init.o inode.o root.o symlink.o waitq.o
diff -urN linux-2.5.69-bk/fs/autofs4/Makefile linux/fs/autofs4/Makefile
--- linux-2.5.69-bk/fs/autofs4/Makefile	2003-04-07 13:31:50.000000000 -0400
+++ linux/fs/autofs4/Makefile	2003-05-18 15:49:57.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
 
-autofs4-objs := init.o inode.o root.o symlink.o waitq.o expire.o
+autofs4-y := init.o inode.o root.o symlink.o waitq.o expire.o
diff -urN linux-2.5.69-bk/fs/befs/Makefile linux/fs/befs/Makefile
--- linux-2.5.69-bk/fs/befs/Makefile	2003-04-07 13:33:03.000000000 -0400
+++ linux/fs/befs/Makefile	2003-05-18 15:50:05.000000000 -0400
@@ -10,4 +10,4 @@
  
 obj-$(CONFIG_BEFS_FS) += befs.o
 
-befs-objs := datastream.o btree.o super.o inode.o debug.o io.o linuxvfs.o
+befs-y := datastream.o btree.o super.o inode.o debug.o io.o linuxvfs.o
diff -urN linux-2.5.69-bk/fs/bfs/Makefile linux/fs/bfs/Makefile
--- linux-2.5.69-bk/fs/bfs/Makefile	2003-04-07 13:32:18.000000000 -0400
+++ linux/fs/bfs/Makefile	2003-05-18 15:50:09.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_BFS_FS) += bfs.o
 
-bfs-objs := inode.o file.o dir.o
+bfs-y := inode.o file.o dir.o
diff -urN linux-2.5.69-bk/fs/cifs/Makefile linux/fs/cifs/Makefile
--- linux-2.5.69-bk/fs/cifs/Makefile	2003-04-07 13:30:57.000000000 -0400
+++ linux/fs/cifs/Makefile	2003-05-18 15:50:12.000000000 -0400
@@ -3,4 +3,4 @@
 #
 obj-$(CONFIG_CIFS) += cifs.o
 
-cifs-objs := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o link.o misc.o netmisc.o smbdes.o smbencrypt.o transport.o asn1.o md4.o md5.o cifs_unicode.o nterr.o
+cifs-y := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o link.o misc.o netmisc.o smbdes.o smbencrypt.o transport.o asn1.o md4.o md5.o cifs_unicode.o nterr.o
diff -urN linux-2.5.69-bk/fs/coda/Makefile linux/fs/coda/Makefile
--- linux-2.5.69-bk/fs/coda/Makefile	2003-04-07 13:32:15.000000000 -0400
+++ linux/fs/coda/Makefile	2003-05-18 15:58:36.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_CODA_FS) += coda.o
 
-coda-objs := psdev.o cache.o cnode.o inode.o dir.o file.o upcall.o \
+coda-y    := psdev.o cache.o cnode.o inode.o dir.o file.o upcall.o \
 	     coda_linux.o symlink.o pioctl.o sysctl.o 
 
 # If you want debugging output, please uncomment the following line.
diff -urN linux-2.5.69-bk/fs/cramfs/Makefile linux/fs/cramfs/Makefile
--- linux-2.5.69-bk/fs/cramfs/Makefile	2003-04-07 13:31:07.000000000 -0400
+++ linux/fs/cramfs/Makefile	2003-05-18 15:50:19.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_CRAMFS) += cramfs.o
 
-cramfs-objs := inode.o uncompress.o
+cramfs-y := inode.o uncompress.o
diff -urN linux-2.5.69-bk/fs/devfs/Makefile linux/fs/devfs/Makefile
--- linux-2.5.69-bk/fs/devfs/Makefile	2003-04-07 13:30:39.000000000 -0400
+++ linux/fs/devfs/Makefile	2003-05-18 15:58:43.000000000 -0400
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_DEVFS_FS) += devfs.o
 
-devfs-objs := base.o util.o
-
+devfs-y := base.o util.o
diff -urN linux-2.5.69-bk/fs/devpts/Makefile linux/fs/devpts/Makefile
--- linux-2.5.69-bk/fs/devpts/Makefile	2003-04-07 13:31:58.000000000 -0400
+++ linux/fs/devpts/Makefile	2003-05-18 15:50:24.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_DEVPTS_FS) += devpts.o
 
-devpts-objs := inode.o
+devpts-y := inode.o
diff -urN linux-2.5.69-bk/fs/efs/Makefile linux/fs/efs/Makefile
--- linux-2.5.69-bk/fs/efs/Makefile	2003-04-07 13:30:58.000000000 -0400
+++ linux/fs/efs/Makefile	2003-05-18 15:50:27.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_EFS_FS) += efs.o
 
-efs-objs := super.o inode.o namei.o dir.o file.o symlink.o
+efs-y := super.o inode.o namei.o dir.o file.o symlink.o
diff -urN linux-2.5.69-bk/fs/exportfs/Makefile linux/fs/exportfs/Makefile
--- linux-2.5.69-bk/fs/exportfs/Makefile	2003-04-07 13:30:59.000000000 -0400
+++ linux/fs/exportfs/Makefile	2003-05-18 15:50:31.000000000 -0400
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_EXPORTFS) += exportfs.o
 
-exportfs-objs := expfs.o
+exportfs-y := expfs.o
diff -urN linux-2.5.69-bk/fs/ext2/Makefile linux/fs/ext2/Makefile
--- linux-2.5.69-bk/fs/ext2/Makefile	2003-05-17 23:55:01.000000000 -0400
+++ linux/fs/ext2/Makefile	2003-05-18 15:58:51.000000000 -0400
@@ -4,17 +4,9 @@
 
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
-ext2-objs := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+ext2-y    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 	     ioctl.o namei.o super.o symlink.o
 
-ifeq ($(CONFIG_EXT2_FS_XATTR),y)
-ext2-objs += xattr.o xattr_user.o xattr_trusted.o
-endif
-
-ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
-ext2-objs += acl.o
-endif
-
-ifeq ($(CONFIG_EXT2_FS_SECURITY),y)
-ext2-objs += xattr_security.o
-endif
+ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o xattr_user.o xattr_trusted.o
+ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
+ext2-$(CONFIG_EXT2_FS_SECURITY) += xattr_security.o
diff -urN linux-2.5.69-bk/fs/ext3/Makefile linux/fs/ext3/Makefile
--- linux-2.5.69-bk/fs/ext3/Makefile	2003-05-17 23:55:01.000000000 -0400
+++ linux/fs/ext3/Makefile	2003-05-18 15:59:09.000000000 -0400
@@ -4,17 +4,9 @@
 
 obj-$(CONFIG_EXT3_FS) += ext3.o
 
-ext3-objs    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
+ext3-y       := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 		ioctl.o namei.o super.o symlink.o hash.o
 
-ifeq ($(CONFIG_EXT3_FS_XATTR),y)
-ext3-objs += xattr.o xattr_user.o xattr_trusted.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
-ext3-objs += acl.o
-endif
-
-ifeq ($(CONFIG_EXT3_FS_SECURITY),y)
-ext3-objs += xattr_security.o
-endif
+ext3-$(CONFIG_EXT3_FS_XATTR) += xattr.o xattr_user.o xattr_trusted.o
+ext3-$(CONFIG_EXT3_FS_POSIX_ACL) += acl.o
+ext3-$(CONFIG_EXT3_FS_SECURITY) += xattr_security.o
diff -urN linux-2.5.69-bk/fs/fat/Makefile linux/fs/fat/Makefile
--- linux-2.5.69-bk/fs/fat/Makefile	2003-04-07 13:30:35.000000000 -0400
+++ linux/fs/fat/Makefile	2003-05-18 15:52:25.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FAT_FS) += fat.o
 
-fat-objs := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
+fat-y := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
diff -urN linux-2.5.69-bk/fs/freevxfs/Makefile linux/fs/freevxfs/Makefile
--- linux-2.5.69-bk/fs/freevxfs/Makefile	2003-04-07 13:32:56.000000000 -0400
+++ linux/fs/freevxfs/Makefile	2003-05-18 15:59:15.000000000 -0400
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_VXFS_FS) += freevxfs.o
 
-freevxfs-objs := vxfs_bmap.o vxfs_fshead.o vxfs_immed.o vxfs_inode.o \
+freevxfs-y    := vxfs_bmap.o vxfs_fshead.o vxfs_immed.o vxfs_inode.o \
 		 vxfs_lookup.o vxfs_olt.o vxfs_subr.o vxfs_super.o
diff -urN linux-2.5.69-bk/fs/hfs/Makefile linux/fs/hfs/Makefile
--- linux-2.5.69-bk/fs/hfs/Makefile	2003-04-07 13:33:03.000000000 -0400
+++ linux/fs/hfs/Makefile	2003-05-18 15:52:39.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_HFS_FS) += hfs.o
 
-hfs-objs := balloc.o bdelete.o bfind.o bins_del.o binsert.o bitmap.o bitops.o \
+hfs-y    := balloc.o bdelete.o bfind.o bins_del.o binsert.o bitmap.o bitops.o \
 	    bnode.o brec.o btree.o catalog.o dir.o dir_cap.o dir_dbl.o \
 	    dir_nat.o extent.o file.o file_cap.o file_hdr.o inode.o mdb.o \
             part_tbl.o string.o super.o sysdep.o trans.o version.o
diff -urN linux-2.5.69-bk/fs/hpfs/Makefile linux/fs/hpfs/Makefile
--- linux-2.5.69-bk/fs/hpfs/Makefile	2003-04-07 13:30:34.000000000 -0400
+++ linux/fs/hpfs/Makefile	2003-05-18 15:52:47.000000000 -0400
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_HPFS_FS) += hpfs.o
 
-hpfs-objs := alloc.o anode.o buffer.o dentry.o dir.o dnode.o ea.o file.o \
+hpfs-y    := alloc.o anode.o buffer.o dentry.o dir.o dnode.o ea.o file.o \
 	     inode.o map.o name.o namei.o super.o
diff -urN linux-2.5.69-bk/fs/hugetlbfs/Makefile linux/fs/hugetlbfs/Makefile
--- linux-2.5.69-bk/fs/hugetlbfs/Makefile	2003-04-07 13:31:00.000000000 -0400
+++ linux/fs/hugetlbfs/Makefile	2003-05-18 15:52:50.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_HUGETLBFS) += hugetlbfs.o
 
-hugetlbfs-objs := inode.o
+hugetlbfs-y := inode.o
diff -urN linux-2.5.69-bk/fs/intermezzo/Makefile linux/fs/intermezzo/Makefile
--- linux-2.5.69-bk/fs/intermezzo/Makefile	2003-04-07 13:32:17.000000000 -0400
+++ linux/fs/intermezzo/Makefile	2003-05-18 15:52:55.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_INTERMEZZO_FS) += intermezzo.o
 
-intermezzo-objs := cache.o dcache.o dir.o ext_attr.o file.o fileset.o \
+intermezzo-y    := cache.o dcache.o dir.o ext_attr.o file.o fileset.o \
 	           inode.o journal.o journal_ext2.o journal_ext3.o \
 	           journal_obdfs.o journal_reiserfs.o journal_tmpfs.o journal_xfs.o \
 	           kml_reint.o kml_unpack.o methods.o presto.o psdev.o replicator.o \
diff -urN linux-2.5.69-bk/fs/isofs/Makefile linux/fs/isofs/Makefile
--- linux-2.5.69-bk/fs/isofs/Makefile	2003-04-07 13:33:02.000000000 -0400
+++ linux/fs/isofs/Makefile	2003-05-18 15:53:15.000000000 -0400
@@ -4,7 +4,6 @@
 
 obj-$(CONFIG_ISO9660_FS) += isofs.o
 
-isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o
-isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
-isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
-isofs-objs			:= $(isofs-objs-y)
+isofs-y 		:= namei.o inode.o dir.o util.o rock.o
+isofs-$(CONFIG_JOLIET)	+= joliet.o
+isofs-$(CONFIG_ZISOFS)	+= compress.o
diff -urN linux-2.5.69-bk/fs/jbd/Makefile linux/fs/jbd/Makefile
--- linux-2.5.69-bk/fs/jbd/Makefile	2003-04-07 13:31:14.000000000 -0400
+++ linux/fs/jbd/Makefile	2003-05-18 15:53:18.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_JBD) += jbd.o
 
-jbd-objs := transaction.o commit.o recovery.o checkpoint.o revoke.o journal.o
+jbd-y := transaction.o commit.o recovery.o checkpoint.o revoke.o journal.o
diff -urN linux-2.5.69-bk/fs/jffs/Makefile linux/fs/jffs/Makefile
--- linux-2.5.69-bk/fs/jffs/Makefile	2003-04-07 13:31:47.000000000 -0400
+++ linux/fs/jffs/Makefile	2003-05-18 15:53:40.000000000 -0400
@@ -8,4 +8,3 @@
 
 jffs-y 				:= jffs_fm.o intrep.o inode-v23.o
 jffs-$(CONFIG_JFFS_PROC_FS)	+= jffs_proc.o
-jffs-objs			:= $(jffs-y)
diff -urN linux-2.5.69-bk/fs/jffs2/Makefile linux/fs/jffs2/Makefile
--- linux-2.5.69-bk/fs/jffs2/Makefile	2003-04-07 13:30:57.000000000 -0400
+++ linux/fs/jffs2/Makefile	2003-05-18 15:53:35.000000000 -0400
@@ -16,5 +16,5 @@
 
 NAND_OBJS-$(CONFIG_JFFS2_FS_NAND)	:= wbuf.o
 
-jffs2-objs := $(COMPR_OBJS) $(JFFS2_OBJS) $(VERS_OBJS) $(NAND_OBJS-y) \
+jffs2-y    := $(COMPR_OBJS) $(JFFS2_OBJS) $(VERS_OBJS) $(NAND_OBJS-y) \
 	      $(LINUX_OBJS-$(VERSION)$(PATCHLEVEL))
diff -urN linux-2.5.69-bk/fs/jfs/Makefile linux/fs/jfs/Makefile
--- linux-2.5.69-bk/fs/jfs/Makefile	2003-04-07 13:32:29.000000000 -0400
+++ linux/fs/jfs/Makefile	2003-05-18 15:53:58.000000000 -0400
@@ -4,14 +4,12 @@
 
 obj-$(CONFIG_JFS_FS) += jfs.o
 
-jfs-objs := super.o file.o inode.o namei.o jfs_mount.o jfs_umount.o \
+jfs-y    := super.o file.o inode.o namei.o jfs_mount.o jfs_umount.o \
 	    jfs_xtree.o jfs_imap.o jfs_debug.o jfs_dmap.o \
 	    jfs_unicode.o jfs_dtree.o jfs_inode.o \
 	    jfs_extent.o symlink.o jfs_metapage.o \
 	    jfs_logmgr.o jfs_txnmgr.o jfs_uniupr.o resize.o xattr.o
 
-ifeq ($(CONFIG_JFS_POSIX_ACL),y)
-jfs-objs += acl.o
-endif
+jfs-$(CONFIG_JFS_POSIX_ACL) += acl.o
 
 EXTRA_CFLAGS += -D_JFS_4K
diff -urN linux-2.5.69-bk/fs/lockd/Makefile linux/fs/lockd/Makefile
--- linux-2.5.69-bk/fs/lockd/Makefile	2003-04-07 13:30:40.000000000 -0400
+++ linux/fs/lockd/Makefile	2003-05-18 15:54:10.000000000 -0400
@@ -4,7 +4,6 @@
 
 obj-$(CONFIG_LOCKD) += lockd.o
 
-lockd-objs-y := clntlock.o clntproc.o host.o svc.o svclock.o svcshare.o \
+lockd-y      := clntlock.o clntproc.o host.o svc.o svclock.o svcshare.o \
 	        svcproc.o svcsubs.o mon.o xdr.o lockd_syms.o
-lockd-objs-$(CONFIG_LOCKD_V4) += xdr4.o svc4proc.o
-lockd-objs		      := $(lockd-objs-y)
+lockd-$(CONFIG_LOCKD_V4) += xdr4.o svc4proc.o
diff -urN linux-2.5.69-bk/fs/minix/Makefile linux/fs/minix/Makefile
--- linux-2.5.69-bk/fs/minix/Makefile	2003-04-07 13:30:57.000000000 -0400
+++ linux/fs/minix/Makefile	2003-05-18 15:54:13.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_MINIX_FS) += minix.o
 
-minix-objs := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o
+minix-y := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o
diff -urN linux-2.5.69-bk/fs/msdos/Makefile linux/fs/msdos/Makefile
--- linux-2.5.69-bk/fs/msdos/Makefile	2003-04-07 13:32:49.000000000 -0400
+++ linux/fs/msdos/Makefile	2003-05-18 15:54:16.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_MSDOS_FS) += msdos.o
 
-msdos-objs := namei.o msdosfs_syms.o
+msdos-y := namei.o msdosfs_syms.o
diff -urN linux-2.5.69-bk/fs/ncpfs/Makefile linux/fs/ncpfs/Makefile
--- linux-2.5.69-bk/fs/ncpfs/Makefile	2003-04-07 13:33:04.000000000 -0400
+++ linux/fs/ncpfs/Makefile	2003-05-18 15:54:54.000000000 -0400
@@ -4,14 +4,11 @@
 
 obj-$(CONFIG_NCP_FS) += ncpfs.o
 
-ncpfs-objs   := dir.o file.o inode.o ioctl.o mmap.o ncplib_kernel.o sock.o \
+ncpfs-y      := dir.o file.o inode.o ioctl.o mmap.o ncplib_kernel.o sock.o \
 		ncpsign_kernel.o getopt.o
-ifeq ($(CONFIG_NCPFS_EXTRAS),y)
-ncpfs-objs   += symlink.o
-endif
-ifeq ($(CONFIG_NCPFS_NFS_NS),y)
-ncpfs-objs   += symlink.o
-endif
+
+ncpfs-$(CONFIG_NCPFS_EXTRAS) += symlink.o
+ncpfs-$(CONFIG_NCPFS_NFS_NS) += symlink.o
 
 # If you want debugging output, please uncomment the following line
 # EXTRA_CFLAGS += -DDEBUG_NCP=1
diff -urN linux-2.5.69-bk/fs/nfs/Makefile linux/fs/nfs/Makefile
--- linux-2.5.69-bk/fs/nfs/Makefile	2003-05-05 10:50:07.000000000 -0400
+++ linux/fs/nfs/Makefile	2003-05-18 15:55:02.000000000 -0400
@@ -11,4 +11,3 @@
 nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o \
 			   idmap.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
-nfs-objs		:= $(nfs-y)
diff -urN linux-2.5.69-bk/fs/nfsd/Makefile linux/fs/nfsd/Makefile
--- linux-2.5.69-bk/fs/nfsd/Makefile	2003-05-05 10:50:07.000000000 -0400
+++ linux/fs/nfsd/Makefile	2003-05-18 15:54:58.000000000 -0400
@@ -8,4 +8,3 @@
 			   export.o auth.o lockd.o nfscache.o nfsxdr.o stats.o
 nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o
-nfsd-objs		:= $(nfsd-y)
diff -urN linux-2.5.69-bk/fs/ntfs/Makefile linux/fs/ntfs/Makefile
--- linux-2.5.69-bk/fs/ntfs/Makefile	2003-05-05 10:50:28.000000000 -0400
+++ linux/fs/ntfs/Makefile	2003-05-18 15:55:08.000000000 -0400
@@ -2,7 +2,7 @@
 
 obj-$(CONFIG_NTFS_FS) += ntfs.o
 
-ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
+ntfs-y    := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
 EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.4\"
diff -urN linux-2.5.69-bk/fs/openpromfs/Makefile linux/fs/openpromfs/Makefile
--- linux-2.5.69-bk/fs/openpromfs/Makefile	2003-04-07 13:32:52.000000000 -0400
+++ linux/fs/openpromfs/Makefile	2003-05-18 15:55:11.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SUN_OPENPROMFS) += openpromfs.o
 
-openpromfs-objs := inode.o
+openpromfs-y := inode.o
diff -urN linux-2.5.69-bk/fs/proc/Makefile linux/fs/proc/Makefile
--- linux-2.5.69-bk/fs/proc/Makefile	2003-04-07 13:30:39.000000000 -0400
+++ linux/fs/proc/Makefile	2003-05-18 15:57:30.000000000 -0400
@@ -4,15 +4,13 @@
 
 obj-$(CONFIG_PROC_FS) += proc.o
 
-proc-objs    := inode.o root.o base.o generic.o array.o \
+proc-y       := inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o kcore.o
 
 ifeq ($(CONFIG_MMU),y)
-proc-objs    += task_mmu.o
+proc-y       += task_mmu.o
 else
-proc-objs    += task_nommu.o
+proc-y       += task_nommu.o
 endif
 
-ifeq ($(CONFIG_PROC_DEVICETREE),y)
-proc-objs    += proc_devtree.o
-endif
+proc-$(CONFIG_PROC_DEVICETREE) += proc_devtree.o
diff -urN linux-2.5.69-bk/fs/qnx4/Makefile linux/fs/qnx4/Makefile
--- linux-2.5.69-bk/fs/qnx4/Makefile	2003-04-07 13:31:12.000000000 -0400
+++ linux/fs/qnx4/Makefile	2003-05-18 15:57:33.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_QNX4FS_FS) += qnx4.o
 
-qnx4-objs := inode.o dir.o namei.o file.o bitmap.o truncate.o fsync.o
+qnx4-y := inode.o dir.o namei.o file.o bitmap.o truncate.o fsync.o
diff -urN linux-2.5.69-bk/fs/ramfs/Makefile linux/fs/ramfs/Makefile
--- linux-2.5.69-bk/fs/ramfs/Makefile	2003-04-07 13:33:02.000000000 -0400
+++ linux/fs/ramfs/Makefile	2003-05-18 15:57:37.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_RAMFS) += ramfs.o
 
-ramfs-objs := inode.o
+ramfs-y := inode.o
diff -urN linux-2.5.69-bk/fs/reiserfs/Makefile linux/fs/reiserfs/Makefile
--- linux-2.5.69-bk/fs/reiserfs/Makefile	2003-04-07 13:33:02.000000000 -0400
+++ linux/fs/reiserfs/Makefile	2003-05-18 15:57:40.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_REISERFS_FS) += reiserfs.o
 
-reiserfs-objs := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o \
+reiserfs-y    := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o \
 		 super.o prints.o objectid.o lbalance.o ibalance.o stree.o \
 		 hashes.o tail_conversion.o journal.o resize.o \
 		 item_ops.o ioctl.o procfs.o
diff -urN linux-2.5.69-bk/fs/romfs/Makefile linux/fs/romfs/Makefile
--- linux-2.5.69-bk/fs/romfs/Makefile	2003-04-07 13:30:45.000000000 -0400
+++ linux/fs/romfs/Makefile	2003-05-18 15:57:42.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_ROMFS_FS) += romfs.o
 
-romfs-objs := inode.o
+romfs-y := inode.o
diff -urN linux-2.5.69-bk/fs/smbfs/Makefile linux/fs/smbfs/Makefile
--- linux-2.5.69-bk/fs/smbfs/Makefile	2003-04-07 13:30:59.000000000 -0400
+++ linux/fs/smbfs/Makefile	2003-05-18 15:57:48.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SMB_FS) += smbfs.o
 
-smbfs-objs := proc.o dir.o cache.o sock.o inode.o file.o ioctl.o getopt.o \
+smbfs-y      := proc.o dir.o cache.o sock.o inode.o file.o ioctl.o getopt.o \
 		symlink.o smbiod.o request.o
 
 # If you want debugging output, you may add these flags to the EXTRA_CFLAGS
diff -urN linux-2.5.69-bk/fs/sysv/Makefile linux/fs/sysv/Makefile
--- linux-2.5.69-bk/fs/sysv/Makefile	2003-04-07 13:32:15.000000000 -0400
+++ linux/fs/sysv/Makefile	2003-05-18 15:57:51.000000000 -0400
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_SYSV_FS) += sysv.o
 
-sysv-objs := ialloc.o balloc.o inode.o itree.o file.o dir.o \
+sysv-y    := ialloc.o balloc.o inode.o itree.o file.o dir.o \
 	     namei.o super.o symlink.o
diff -urN linux-2.5.69-bk/fs/udf/Makefile linux/fs/udf/Makefile
--- linux-2.5.69-bk/fs/udf/Makefile	2003-04-07 13:30:39.000000000 -0400
+++ linux/fs/udf/Makefile	2003-05-18 15:57:58.000000000 -0400
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_UDF_FS) += udf.o
 
-udf-objs     := balloc.o dir.o file.o ialloc.o inode.o lowlevel.o namei.o \
+udf-y        := balloc.o dir.o file.o ialloc.o inode.o lowlevel.o namei.o \
 		partition.o super.o truncate.o symlink.o fsync.o \
 		crc.o directory.o misc.o udftime.o unicode.o
diff -urN linux-2.5.69-bk/fs/ufs/Makefile linux/fs/ufs/Makefile
--- linux-2.5.69-bk/fs/ufs/Makefile	2003-04-07 13:30:44.000000000 -0400
+++ linux/fs/ufs/Makefile	2003-05-18 15:58:02.000000000 -0400
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_UFS_FS) += ufs.o
 
-ufs-objs := balloc.o cylinder.o dir.o file.o ialloc.o inode.o \
+ufs-y    := balloc.o cylinder.o dir.o file.o ialloc.o inode.o \
 	    namei.o super.o symlink.o truncate.o util.o
diff -urN linux-2.5.69-bk/fs/umsdos/Makefile linux/fs/umsdos/Makefile
--- linux-2.5.69-bk/fs/umsdos/Makefile	2003-04-07 13:30:58.000000000 -0400
+++ linux/fs/umsdos/Makefile	2003-05-18 15:58:13.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_UMSDOS) += umsdos.o
 
-umsdos-objs := dir.o  inode.o ioctl.o mangle.o namei.o rdir.o emd.o
+umsdos-y := dir.o  inode.o ioctl.o mangle.o namei.o rdir.o emd.o
 
 p:
 	proto *.c >/usr/include/linux/umsdos_fs.p
diff -urN linux-2.5.69-bk/fs/vfat/Makefile linux/fs/vfat/Makefile
--- linux-2.5.69-bk/fs/vfat/Makefile	2003-04-07 13:32:27.000000000 -0400
+++ linux/fs/vfat/Makefile	2003-05-18 15:58:15.000000000 -0400
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_VFAT_FS) += vfat.o
 
-vfat-objs := namei.o vfatfs_syms.o
+vfat-y := namei.o vfatfs_syms.o

--------------040409060204000301090104--

