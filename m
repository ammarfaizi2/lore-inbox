Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSLNRu4>; Sat, 14 Dec 2002 12:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLNRu4>; Sat, 14 Dec 2002 12:50:56 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:64903 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265197AbSLNRtK>; Sat, 14 Dec 2002 12:49:10 -0500
Message-ID: <3DFB70E2.1030409@quark.didntduck.org>
Date: Sat, 14 Dec 2002 12:56:50 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH] Remove Rules.make from Makefiles (3/3)
Content-Type: multipart/mixed;
 boundary="------------040705050501020306000908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705050501020306000908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Makefiles no longer need to include Rules.make, which is currently an 
empty file.  This patch removes it from the remaining Makefiles, and 
removes the empty Rules.make file.

--------------040705050501020306000908
Content-Type: text/plain;
 name="rules.make-other-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rules.make-other-1"

diff -urN linux-2.5.51-bk1/Rules.make linux/Rules.make
--- linux-2.5.51-bk1/Rules.make	Sat Dec 14 12:31:47 2002
+++ linux/Rules.make	Wed Dec 31 19:00:00 1969
@@ -1 +0,0 @@
-
diff -urN linux-2.5.51-bk1/crypto/Makefile linux/crypto/Makefile
--- linux-2.5.51-bk1/crypto/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/crypto/Makefile	Sat Dec 14 12:38:56 2002
@@ -22,5 +22,3 @@
 obj-$(CONFIG_CRYPTO_SERPENT) += serpent.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/Makefile linux/fs/Makefile
--- linux-2.5.51-bk1/fs/Makefile	Sat Dec 14 12:32:05 2002
+++ linux/fs/Makefile	Sat Dec 14 12:38:56 2002
@@ -94,5 +94,3 @@
 obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/adfs/Makefile linux/fs/adfs/Makefile
--- linux-2.5.51-bk1/fs/adfs/Makefile	Sun Sep 15 22:18:16 2002
+++ linux/fs/adfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_ADFS_FS) += adfs.o
 
 adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/affs/Makefile linux/fs/affs/Makefile
--- linux-2.5.51-bk1/fs/affs/Makefile	Sun Sep 15 22:18:54 2002
+++ linux/fs/affs/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_AFFS_FS) += affs.o
 
 affs-objs := super.o namei.o inode.o file.o dir.o amigaffs.o bitmap.o symlink.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/afs/Makefile linux/fs/afs/Makefile
--- linux-2.5.51-bk1/fs/afs/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/fs/afs/Makefile	Sat Dec 14 12:38:56 2002
@@ -24,5 +24,3 @@
 	volume.o
 
 obj-$(CONFIG_AFS_FS)  := kafs.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/autofs/Makefile linux/fs/autofs/Makefile
--- linux-2.5.51-bk1/fs/autofs/Makefile	Sun Sep 15 22:19:10 2002
+++ linux/fs/autofs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_AUTOFS_FS) += autofs.o
 
 autofs-objs := dirhash.o init.o inode.o root.o symlink.o waitq.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/autofs4/Makefile linux/fs/autofs4/Makefile
--- linux-2.5.51-bk1/fs/autofs4/Makefile	Sun Sep 15 22:18:33 2002
+++ linux/fs/autofs4/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
 
 autofs4-objs := init.o inode.o root.o symlink.o waitq.o expire.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/befs/Makefile linux/fs/befs/Makefile
--- linux-2.5.51-bk1/fs/befs/Makefile	Sat Dec 14 12:31:49 2002
+++ linux/fs/befs/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_BEFS_FS) += befs.o
 
 befs-objs := datastream.o btree.o super.o inode.o debug.o io.o linuxvfs.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/bfs/Makefile linux/fs/bfs/Makefile
--- linux-2.5.51-bk1/fs/bfs/Makefile	Sun Sep 15 22:18:48 2002
+++ linux/fs/bfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_BFS_FS) += bfs.o
 
 bfs-objs := inode.o file.o dir.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/cifs/Makefile linux/fs/cifs/Makefile
--- linux-2.5.51-bk1/fs/cifs/Makefile	Sat Dec 14 12:31:41 2002
+++ linux/fs/cifs/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,5 +4,3 @@
 obj-$(CONFIG_CIFS) += cifs.o
 
 cifs-objs := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o link.o misc.o netmisc.o smbdes.o smbencrypt.o transport.o asn1.o md4.o md5.o cifs_unicode.o nterr.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/coda/Makefile linux/fs/coda/Makefile
--- linux-2.5.51-bk1/fs/coda/Makefile	Sun Sep 15 22:18:43 2002
+++ linux/fs/coda/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,6 +10,3 @@
 # If you want debugging output, please uncomment the following line.
 
 # EXTRA_CFLAGS += -DDEBUG -DDEBUG_SMB_MALLOC=1
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/cramfs/Makefile linux/fs/cramfs/Makefile
--- linux-2.5.51-bk1/fs/cramfs/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/fs/cramfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_CRAMFS) += cramfs.o
 
 cramfs-objs := inode.o uncompress.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/devfs/Makefile linux/fs/devfs/Makefile
--- linux-2.5.51-bk1/fs/devfs/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/fs/devfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,9 +13,6 @@
 TOPDIR = ../..
 endif
 
-include $(TOPDIR)/Rules.make
-
-
 # Rule to build documentation
 doc:	base.c util.c
 	@echo '$$PACKAGE devfs' > devfs.doc
diff -urN linux-2.5.51-bk1/fs/devpts/Makefile linux/fs/devpts/Makefile
--- linux-2.5.51-bk1/fs/devpts/Makefile	Sun Sep 15 22:18:41 2002
+++ linux/fs/devpts/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_DEVPTS_FS) += devpts.o
 
 devpts-objs := inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/efs/Makefile linux/fs/efs/Makefile
--- linux-2.5.51-bk1/fs/efs/Makefile	Sun Sep 15 22:18:24 2002
+++ linux/fs/efs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_EFS_FS) += efs.o
 
 efs-objs := super.o inode.o namei.o dir.o file.o symlink.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/exportfs/Makefile linux/fs/exportfs/Makefile
--- linux-2.5.51-bk1/fs/exportfs/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/fs/exportfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 obj-$(CONFIG_EXPORTFS) += exportfs.o
 
 exportfs-objs := expfs.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ext2/Makefile linux/fs/ext2/Makefile
--- linux-2.5.51-bk1/fs/ext2/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/fs/ext2/Makefile	Sat Dec 14 12:38:56 2002
@@ -16,5 +16,3 @@
 ifeq ($(CONFIG_EXT2_FS_POSIX_ACL),y)
 ext2-objs += acl.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ext3/Makefile linux/fs/ext3/Makefile
--- linux-2.5.51-bk1/fs/ext3/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/fs/ext3/Makefile	Sat Dec 14 12:38:56 2002
@@ -16,5 +16,3 @@
 ifeq ($(CONFIG_EXT3_FS_POSIX_ACL),y)
 ext3-objs += acl.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/fat/Makefile linux/fs/fat/Makefile
--- linux-2.5.51-bk1/fs/fat/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/fs/fat/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_FAT_FS) += fat.o
 
 fat-objs := cache.o dir.o file.o inode.o misc.o fatfs_syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/freevxfs/Makefile linux/fs/freevxfs/Makefile
--- linux-2.5.51-bk1/fs/freevxfs/Makefile	Sun Sep 15 22:19:00 2002
+++ linux/fs/freevxfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 freevxfs-objs := vxfs_bmap.o vxfs_fshead.o vxfs_immed.o vxfs_inode.o \
 		 vxfs_lookup.o vxfs_olt.o vxfs_subr.o vxfs_super.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/hfs/Makefile linux/fs/hfs/Makefile
--- linux-2.5.51-bk1/fs/hfs/Makefile	Sun Sep 15 22:19:09 2002
+++ linux/fs/hfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 	    bnode.o brec.o btree.o catalog.o dir.o dir_cap.o dir_dbl.o \
 	    dir_nat.o extent.o file.o file_cap.o file_hdr.o inode.o mdb.o \
             part_tbl.o string.o super.o sysdep.o trans.o version.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/hpfs/Makefile linux/fs/hpfs/Makefile
--- linux-2.5.51-bk1/fs/hpfs/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/fs/hpfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 hpfs-objs := alloc.o anode.o buffer.o dentry.o dir.o dnode.o ea.o file.o \
 	     inode.o map.o name.o namei.o super.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/hugetlbfs/Makefile linux/fs/hugetlbfs/Makefile
--- linux-2.5.51-bk1/fs/hugetlbfs/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/fs/hugetlbfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_HUGETLBFS) += hugetlbfs.o
 
 hugetlbfs-objs := inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/intermezzo/Makefile linux/fs/intermezzo/Makefile
--- linux-2.5.51-bk1/fs/intermezzo/Makefile	Sat Dec 14 12:31:43 2002
+++ linux/fs/intermezzo/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,6 +9,3 @@
 	           journal_obdfs.o journal_reiserfs.o journal_tmpfs.o journal_xfs.o \
 	           kml_reint.o kml_unpack.o methods.o presto.o psdev.o replicator.o \
 	           super.o sysctl.o upcall.o vfs.o
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/isofs/Makefile linux/fs/isofs/Makefile
--- linux-2.5.51-bk1/fs/isofs/Makefile	Sun Sep 15 22:19:07 2002
+++ linux/fs/isofs/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
 isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
 isofs-objs			:= $(isofs-objs-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/jbd/Makefile linux/fs/jbd/Makefile
--- linux-2.5.51-bk1/fs/jbd/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/fs/jbd/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 obj-$(CONFIG_JBD) += jbd.o
 
 jbd-objs := transaction.o commit.o recovery.o checkpoint.o revoke.o journal.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/jffs/Makefile linux/fs/jffs/Makefile
--- linux-2.5.51-bk1/fs/jffs/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/fs/jffs/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,6 +9,3 @@
 jffs-y 				:= jffs_fm.o intrep.o inode-v23.o
 jffs-$(CONFIG_JFFS_PROC_FS)	+= jffs_proc.o
 jffs-objs			:= $(jffs-y)
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/jffs2/Makefile linux/fs/jffs2/Makefile
--- linux-2.5.51-bk1/fs/jffs2/Makefile	Sun Sep 15 22:18:23 2002
+++ linux/fs/jffs2/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,6 +18,3 @@
 
 jffs2-objs := $(COMPR_OBJS) $(JFFS2_OBJS) $(VERS_OBJS) $(NAND_OBJS-y) \
 	      $(LINUX_OBJS-$(VERSION)$(PATCHLEVEL))
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/jfs/Makefile linux/fs/jfs/Makefile
--- linux-2.5.51-bk1/fs/jfs/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/fs/jfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 endif
 
 EXTRA_CFLAGS += -D_JFS_4K
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/lockd/Makefile linux/fs/lockd/Makefile
--- linux-2.5.51-bk1/fs/lockd/Makefile	Sun Sep 15 22:18:19 2002
+++ linux/fs/lockd/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 	        svcproc.o svcsubs.o mon.o xdr.o lockd_syms.o
 lockd-objs-$(CONFIG_LOCKD_V4) += xdr4.o svc4proc.o
 lockd-objs		      := $(lockd-objs-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/minix/Makefile linux/fs/minix/Makefile
--- linux-2.5.51-bk1/fs/minix/Makefile	Sun Sep 15 22:18:23 2002
+++ linux/fs/minix/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_MINIX_FS) += minix.o
 
 minix-objs := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/msdos/Makefile linux/fs/msdos/Makefile
--- linux-2.5.51-bk1/fs/msdos/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/fs/msdos/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_MSDOS_FS) += msdos.o
 
 msdos-objs := namei.o msdosfs_syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ncpfs/Makefile linux/fs/ncpfs/Makefile
--- linux-2.5.51-bk1/fs/ncpfs/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/fs/ncpfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -17,5 +17,3 @@
 # EXTRA_CFLAGS += -DDEBUG_NCP=1
 
 CFLAGS_ncplib_kernel.o := -finline-functions
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/nfs/Makefile linux/fs/nfs/Makefile
--- linux-2.5.51-bk1/fs/nfs/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/fs/nfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 nfs-$(CONFIG_NFS_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o
 nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
 nfs-objs		:= $(nfs-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/nfsd/Makefile linux/fs/nfsd/Makefile
--- linux-2.5.51-bk1/fs/nfsd/Makefile	Sat Dec 14 12:31:41 2002
+++ linux/fs/nfsd/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,5 +9,3 @@
 nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o
 nfsd-objs		:= $(nfsd-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/nls/Makefile linux/fs/nls/Makefile
--- linux-2.5.51-bk1/fs/nls/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/fs/nls/Makefile	Sat Dec 14 12:38:56 2002
@@ -45,5 +45,3 @@
 obj-$(CONFIG_NLS_KOI8_U)	+= nls_koi8-u.o nls_koi8-ru.o
 obj-$(CONFIG_NLS_ABC)		+= nls_abc.o
 obj-$(CONFIG_NLS_UTF8)		+= nls_utf8.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ntfs/Makefile linux/fs/ntfs/Makefile
--- linux-2.5.51-bk1/fs/ntfs/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/fs/ntfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -14,6 +14,3 @@
 ifeq ($(CONFIG_NTFS_RW),y)
 EXTRA_CFLAGS += -DNTFS_RW
 endif
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/openpromfs/Makefile linux/fs/openpromfs/Makefile
--- linux-2.5.51-bk1/fs/openpromfs/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/fs/openpromfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_SUN_OPENPROMFS) += openpromfs.o
 
 openpromfs-objs := inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/partitions/Makefile linux/fs/partitions/Makefile
--- linux-2.5.51-bk1/fs/partitions/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/fs/partitions/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,6 +18,3 @@
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/fs/proc/Makefile linux/fs/proc/Makefile
--- linux-2.5.51-bk1/fs/proc/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/fs/proc/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,5 +12,3 @@
 ifeq ($(CONFIG_PROC_DEVICETREE),y)
 proc-objs    += proc_devtree.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/qnx4/Makefile linux/fs/qnx4/Makefile
--- linux-2.5.51-bk1/fs/qnx4/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/fs/qnx4/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_QNX4FS_FS) += qnx4.o
 
 qnx4-objs := inode.o dir.o namei.o file.o bitmap.o truncate.o fsync.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ramfs/Makefile linux/fs/ramfs/Makefile
--- linux-2.5.51-bk1/fs/ramfs/Makefile	Sun Sep 15 22:19:05 2002
+++ linux/fs/ramfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_RAMFS) += ramfs.o
 
 ramfs-objs := inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/reiserfs/Makefile linux/fs/reiserfs/Makefile
--- linux-2.5.51-bk1/fs/reiserfs/Makefile	Sun Sep 15 22:19:06 2002
+++ linux/fs/reiserfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -19,8 +19,6 @@
 EXTRA_CFLAGS := -O1
 endif
 
-include $(TOPDIR)/Rules.make
-
 TAGS:
 	etags *.c
 
diff -urN linux-2.5.51-bk1/fs/romfs/Makefile linux/fs/romfs/Makefile
--- linux-2.5.51-bk1/fs/romfs/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/fs/romfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_ROMFS_FS) += romfs.o
 
 romfs-objs := inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/smbfs/Makefile linux/fs/smbfs/Makefile
--- linux-2.5.51-bk1/fs/smbfs/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/fs/smbfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -17,8 +17,6 @@
 #EXTRA_CFLAGS += -DDEBUG_SMB_TIMESTAMP
 #EXTRA_CFLAGS += -Werror
 
-include $(TOPDIR)/Rules.make
-
 #
 # Maintainer rules
 #
diff -urN linux-2.5.51-bk1/fs/sysfs/Makefile linux/fs/sysfs/Makefile
--- linux-2.5.51-bk1/fs/sysfs/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/fs/sysfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 export-objs	:= inode.o
 
 obj-y		:= inode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/sysv/Makefile linux/fs/sysv/Makefile
--- linux-2.5.51-bk1/fs/sysv/Makefile	Sun Sep 15 22:18:43 2002
+++ linux/fs/sysv/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 sysv-objs := ialloc.o balloc.o inode.o itree.o file.o dir.o \
 	     namei.o super.o symlink.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/udf/Makefile linux/fs/udf/Makefile
--- linux-2.5.51-bk1/fs/udf/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/fs/udf/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 udf-objs     := balloc.o dir.o file.o ialloc.o inode.o lowlevel.o namei.o \
 		partition.o super.o truncate.o symlink.o fsync.o \
 		crc.o directory.o misc.o udftime.o unicode.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/ufs/Makefile linux/fs/ufs/Makefile
--- linux-2.5.51-bk1/fs/ufs/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/fs/ufs/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 ufs-objs := balloc.o cylinder.o dir.o file.o ialloc.o inode.o \
 	    namei.o super.o symlink.o truncate.o util.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/umsdos/Makefile linux/fs/umsdos/Makefile
--- linux-2.5.51-bk1/fs/umsdos/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/fs/umsdos/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,8 +6,6 @@
 
 umsdos-objs := dir.o  inode.o ioctl.o mangle.o namei.o rdir.o emd.o
 
-include $(TOPDIR)/Rules.make
-
 p:
 	proto *.c >/usr/include/linux/umsdos_fs.p
 
diff -urN linux-2.5.51-bk1/fs/vfat/Makefile linux/fs/vfat/Makefile
--- linux-2.5.51-bk1/fs/vfat/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/fs/vfat/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_VFAT_FS) += vfat.o
 
 vfat-objs := namei.o vfatfs_syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/fs/xfs/Makefile linux/fs/xfs/Makefile
--- linux-2.5.51-bk1/fs/xfs/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/fs/xfs/Makefile	Sat Dec 14 12:38:56 2002
@@ -157,5 +157,3 @@
 endif
 
 CFLAGS_xfsidbg.o += -Iarch/$(ARCH)/kdb
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/init/Makefile linux/init/Makefile
--- linux-2.5.51-bk1/init/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/init/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,8 +7,6 @@
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h
 
-include $(TOPDIR)/Rules.make
-
 # dependencies on generated files need to be listed explicitly
 
 $(obj)/version.o: include/linux/compile.h
diff -urN linux-2.5.51-bk1/ipc/Makefile linux/ipc/Makefile
--- linux-2.5.51-bk1/ipc/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/ipc/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-y   := util.o
 
 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/kernel/Makefile linux/kernel/Makefile
--- linux-2.5.51-bk1/kernel/Makefile	Sat Dec 14 12:32:13 2002
+++ linux/kernel/Makefile	Sat Dec 14 12:38:56 2002
@@ -31,5 +31,3 @@
 # to get a correct value for the wait-channel (WCHAN in ps). --davidm
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/lib/Makefile linux/lib/Makefile
--- linux-2.5.51-bk1/lib/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/lib/Makefile	Sat Dec 14 12:38:56 2002
@@ -31,5 +31,3 @@
 include $(TOPDIR)/drivers/usb/class/Makefile.lib
 include $(TOPDIR)/fs/Makefile.lib
 include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/lib/zlib_deflate/Makefile linux/lib/zlib_deflate/Makefile
--- linux-2.5.51-bk1/lib/zlib_deflate/Makefile	Sun Sep 15 22:18:41 2002
+++ linux/lib/zlib_deflate/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate.o
 
 zlib_deflate-objs := deflate.o deftree.o deflate_syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/lib/zlib_inflate/Makefile linux/lib/zlib_inflate/Makefile
--- linux-2.5.51-bk1/lib/zlib_inflate/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/lib/zlib_inflate/Makefile	Sat Dec 14 12:38:56 2002
@@ -19,5 +19,3 @@
 
 zlib_inflate-objs := infblock.o infcodes.o inffast.o inflate.o \
 		     inftrees.o infutil.o inflate_syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/802/Makefile linux/net/802/Makefile
--- linux-2.5.51-bk1/net/802/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/net/802/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_HIPPI)	+=                 hippi.o
 obj-$(CONFIG_IPX)	+= p8022.o psnap.o
 obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/8021q/Makefile linux/net/8021q/Makefile
--- linux-2.5.51-bk1/net/8021q/Makefile	Sun Sep 15 22:19:00 2002
+++ linux/net/8021q/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_VLAN_8021Q) += 8021q.o
 
 8021q-objs := vlan.o vlanproc.o vlan_dev.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/Makefile linux/net/Makefile
--- linux-2.5.51-bk1/net/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/net/Makefile	Sat Dec 14 12:38:56 2002
@@ -41,5 +41,3 @@
 obj-$(CONFIG_MODULES)		+= netsyms.o
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/appletalk/Makefile linux/net/appletalk/Makefile
--- linux-2.5.51-bk1/net/appletalk/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/appletalk/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 
 appletalk-y			:= aarp.o ddp.o atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/atm/Makefile linux/net/atm/Makefile
--- linux-2.5.51-bk1/net/atm/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/net/atm/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_ATM_LANE) += lec.o
 obj-$(CONFIG_ATM_MPOA) += mpoa.o
 obj-$(CONFIG_PPPOATM) += pppoatm.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ax25/Makefile linux/net/ax25/Makefile
--- linux-2.5.51-bk1/net/ax25/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/ax25/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,6 +11,3 @@
 	    ax25_subr.o ax25_timer.o ax25_uid.o af_ax25.o
 ax25-$(CONFIG_AX25_DAMA_SLAVE) += ax25_ds_in.o ax25_ds_subr.o ax25_ds_timer.o
 ax25-$(CONFIG_SYSCTL) += sysctl_net_ax25.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/bluetooth/Makefile linux/net/bluetooth/Makefile
--- linux-2.5.51-bk1/net/bluetooth/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/net/bluetooth/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_BT_BNEP)	+= bnep/
 
 bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_proc.o lib.o syms.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/bluetooth/bnep/Makefile linux/net/bluetooth/bnep/Makefile
--- linux-2.5.51-bk1/net/bluetooth/bnep/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/net/bluetooth/bnep/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_BT_BNEP) += bnep.o
 
 bnep-objs := core.o sock.o netdev.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/bluetooth/rfcomm/Makefile linux/net/bluetooth/rfcomm/Makefile
--- linux-2.5.51-bk1/net/bluetooth/rfcomm/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/bluetooth/rfcomm/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 rfcomm-y			:= core.o sock.o crc.o
 rfcomm-$(CONFIG_BT_RFCOMM_TTY)	+= tty.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/bridge/Makefile linux/net/bridge/Makefile
--- linux-2.5.51-bk1/net/bridge/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/bridge/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 endif
 
 obj-$(CONFIG_BRIDGE_NF_EBTABLES) += netfilter/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/bridge/netfilter/Makefile linux/net/bridge/netfilter/Makefile
--- linux-2.5.51-bk1/net/bridge/netfilter/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/net/bridge/netfilter/Makefile	Sat Dec 14 12:38:56 2002
@@ -17,4 +17,3 @@
 obj-$(CONFIG_BRIDGE_EBT_DNAT) += ebt_dnat.o
 obj-$(CONFIG_BRIDGE_EBT_REDIRECT) += ebt_redirect.o
 obj-$(CONFIG_BRIDGE_EBT_MARK_T) += ebt_mark.o
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/core/Makefile linux/net/core/Makefile
--- linux-2.5.51-bk1/net/core/Makefile	Sat Dec 14 12:32:13 2002
+++ linux/net/core/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,5 +21,3 @@
 obj-$(CONFIG_NET_RADIO) += wireless.o
 # Ugly. I wish all wireless drivers were moved in drivers/net/wireless
 obj-$(CONFIG_NET_PCMCIA_RADIO) += wireless.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/decnet/Makefile linux/net/decnet/Makefile
--- linux-2.5.51-bk1/net/decnet/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/decnet/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,6 +5,3 @@
 decnet-$(CONFIG_DECNET_ROUTER) += dn_fib.o dn_rules.o dn_table.o
 decnet-$(CONFIG_DECNET_FW) += dn_fw.o
 decnet-y += sysctl_net_decnet.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/econet/Makefile linux/net/econet/Makefile
--- linux-2.5.51-bk1/net/econet/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/net/econet/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,6 +5,3 @@
 obj-$(CONFIG_ECONET) += econet.o
 
 econet-objs := af_econet.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/ethernet/Makefile linux/net/ethernet/Makefile
--- linux-2.5.51-bk1/net/ethernet/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/net/ethernet/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 obj-$(CONFIG_SYSCTL)			+= sysctl_net_ether.o
 obj-$(subst m,y,$(CONFIG_IPX))		+= pe2.o
 obj-$(subst m,y,$(CONFIG_ATALK))	+= pe2.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ipv4/Makefile linux/net/ipv4/Makefile
--- linux-2.5.51-bk1/net/ipv4/Makefile	Sat Dec 14 12:32:03 2002
+++ linux/net/ipv4/Makefile	Sat Dec 14 12:38:56 2002
@@ -23,5 +23,3 @@
 obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 
 obj-y += xfrm_policy.o xfrm_state.o xfrm_input.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ipv4/netfilter/Makefile linux/net/ipv4/netfilter/Makefile
--- linux-2.5.51-bk1/net/ipv4/netfilter/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/ipv4/netfilter/Makefile	Sat Dec 14 12:38:56 2002
@@ -93,5 +93,3 @@
 obj-$(CONFIG_IP_NF_COMPAT_IPFWADM) += ipfwadm.o
 
 obj-$(CONFIG_IP_NF_QUEUE) += ip_queue.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ipv6/Makefile linux/net/ipv6/Makefile
--- linux-2.5.51-bk1/net/ipv6/Makefile	Sat Dec 14 12:31:43 2002
+++ linux/net/ipv6/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 		ip6_flowlabel.o ipv6_syms.o
 
 obj-$(CONFIG_NETFILTER)	+= netfilter/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ipv6/netfilter/Makefile linux/net/ipv6/netfilter/Makefile
--- linux-2.5.51-bk1/net/ipv6/netfilter/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/net/ipv6/netfilter/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,5 +18,3 @@
 obj-$(CONFIG_IP6_NF_TARGET_MARK) += ip6t_MARK.o
 obj-$(CONFIG_IP6_NF_QUEUE) += ip6_queue.o
 obj-$(CONFIG_IP6_NF_TARGET_LOG) += ip6t_LOG.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/ipx/Makefile linux/net/ipx/Makefile
--- linux-2.5.51-bk1/net/ipx/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/ipx/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 ipx-y			:= af_ipx.o ipx_proc.o
 ipx-$(CONFIG_SYSCTL)	+= sysctl_net_ipx.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/irda/Makefile linux/net/irda/Makefile
--- linux-2.5.51-bk1/net/irda/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/irda/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 	  discovery.o parameters.o irsyms.o
 irda-$(CONFIG_PROC_FS) += irproc.o
 irda-$(CONFIG_SYSCTL) += irsysctl.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/irda/ircomm/Makefile linux/net/irda/ircomm/Makefile
--- linux-2.5.51-bk1/net/irda/ircomm/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/net/irda/ircomm/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 
 ircomm-objs := ircomm_core.o ircomm_event.o ircomm_lmp.o ircomm_ttp.o
 ircomm-tty-objs := ircomm_tty.o ircomm_tty_attach.o ircomm_tty_ioctl.o ircomm_param.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/irda/irlan/Makefile linux/net/irda/irlan/Makefile
--- linux-2.5.51-bk1/net/irda/irlan/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/net/irda/irlan/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_IRLAN) += irlan.o
 
 irlan-objs := irlan_common.o irlan_eth.o irlan_event.o irlan_client.o irlan_provider.o irlan_filter.o irlan_provider_event.o irlan_client_event.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/irda/irnet/Makefile linux/net/irda/irnet/Makefile
--- linux-2.5.51-bk1/net/irda/irnet/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/net/irda/irnet/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_IRNET) += irnet.o
 
 irnet-objs := irnet_ppp.o irnet_irda.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/key/Makefile linux/net/key/Makefile
--- linux-2.5.51-bk1/net/key/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/net/key/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 obj-$(CONFIG_NET_KEY) += af_key.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/lapb/Makefile linux/net/lapb/Makefile
--- linux-2.5.51-bk1/net/lapb/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/net/lapb/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 obj-$(CONFIG_LAPB) += lapb.o
 
 lapb-objs := lapb_in.o lapb_out.o lapb_subr.o lapb_timer.o lapb_iface.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/llc/Makefile linux/net/llc/Makefile
--- linux-2.5.51-bk1/net/llc/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/llc/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,5 +21,3 @@
 
 # Objects that export symbols.
 export-objs := llc_if.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/netlink/Makefile linux/net/netlink/Makefile
--- linux-2.5.51-bk1/net/netlink/Makefile	Sun Sep 15 22:18:26 2002
+++ linux/net/netlink/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,5 +4,3 @@
 
 obj-y  				:= af_netlink.o
 obj-$(CONFIG_NETLINK_DEV)	+= netlink_dev.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/netrom/Makefile linux/net/netrom/Makefile
--- linux-2.5.51-bk1/net/netrom/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/netrom/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 netrom-y		:= af_netrom.o nr_dev.o nr_in.o nr_loopback.o \
 			   nr_out.o nr_route.o nr_subr.o nr_timer.o
 netrom-$(CONFIG_SYSCTL)	+= sysctl_net_netrom.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/packet/Makefile linux/net/packet/Makefile
--- linux-2.5.51-bk1/net/packet/Makefile	Sun Sep 15 22:18:22 2002
+++ linux/net/packet/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 obj-$(CONFIG_PACKET) += af_packet.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/rose/Makefile linux/net/rose/Makefile
--- linux-2.5.51-bk1/net/rose/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/rose/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 rose-y	  := af_rose.o rose_dev.o rose_in.o rose_link.o rose_loopback.o \
 	     rose_out.o rose_route.o rose_subr.o rose_timer.o
 rose-$(CONFIG_SYSCTL) += sysctl_net_rose.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/rxrpc/Makefile linux/net/rxrpc/Makefile
--- linux-2.5.51-bk1/net/rxrpc/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/net/rxrpc/Makefile	Sat Dec 14 12:38:56 2002
@@ -23,5 +23,3 @@
 endif
 
 obj-$(CONFIG_RXRPC) := rxrpc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/sched/Makefile linux/net/sched/Makefile
--- linux-2.5.51-bk1/net/sched/Makefile	Sun Sep 15 22:18:29 2002
+++ linux/net/sched/Makefile	Sat Dec 14 12:38:56 2002
@@ -28,5 +28,3 @@
 obj-$(CONFIG_NET_CLS_RSVP6)	+= cls_rsvp6.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
 obj-$(CONFIG_NET_CLS_FW)	+= cls_fw.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/sctp/Makefile linux/net/sctp/Makefile
--- linux-2.5.51-bk1/net/sctp/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/sctp/Makefile	Sat Dec 14 12:38:56 2002
@@ -22,5 +22,3 @@
 sctp-$(CONFIG_SYSCTL) += sysctl.o
 
 sctp-$(subst m,y,$(CONFIG_IPV6))	+= ipv6.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/sunrpc/Makefile linux/net/sunrpc/Makefile
--- linux-2.5.51-bk1/net/sunrpc/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/sunrpc/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 	    sunrpc_syms.o cache.o
 sunrpc-$(CONFIG_PROC_FS) += stats.o
 sunrpc-$(CONFIG_SYSCTL) += sysctl.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/unix/Makefile linux/net/unix/Makefile
--- linux-2.5.51-bk1/net/unix/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/unix/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,6 +6,3 @@
 
 unix-y			:= af_unix.o garbage.o
 unix-$(CONFIG_SYSCTL)	+= sysctl_net_unix.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/net/wanrouter/Makefile linux/net/wanrouter/Makefile
--- linux-2.5.51-bk1/net/wanrouter/Makefile	Sun Sep 15 22:18:20 2002
+++ linux/net/wanrouter/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 obj-$(CONFIG_WAN_ROUTER) += wanrouter.o
 
 wanrouter-objs :=  wanproc.o wanmain.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/net/x25/Makefile linux/net/x25/Makefile
--- linux-2.5.51-bk1/net/x25/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/net/x25/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 			   x25_link.o x25_out.o x25_route.o x25_subr.o \
 			   x25_timer.o x25_proc.o
 x25-$(CONFIG_SYSCTL)	+= sysctl_net_x25.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/scripts/kconfig/Makefile linux/scripts/kconfig/Makefile
--- linux-2.5.51-bk1/scripts/kconfig/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/scripts/kconfig/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,8 +21,6 @@
 clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
 		   zconf.tab.c zconf.tab.h lex.zconf.c
 
-include $(TOPDIR)/Rules.make
-
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
diff -urN linux-2.5.51-bk1/security/Makefile linux/security/Makefile
--- linux-2.5.51-bk1/security/Makefile	Sat Dec 14 12:32:13 2002
+++ linux/security/Makefile	Sat Dec 14 12:38:56 2002
@@ -14,5 +14,3 @@
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= root_plug.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/Makefile linux/sound/Makefile
--- linux-2.5.51-bk1/sound/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/sound/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,5 +12,3 @@
 endif
 
 soundcore-objs  := sound_core.o sound_firmware.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/arm/Makefile linux/sound/arm/Makefile
--- linux-2.5.51-bk1/sound/arm/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/sound/arm/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-sa11xx-uda1341.o 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/Makefile linux/sound/core/Makefile
--- linux-2.5.51-bk1/sound/core/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/sound/core/Makefile	Sat Dec 14 12:38:56 2002
@@ -103,5 +103,3 @@
 obj-$(CONFIG_SND_USB_AUDIO) += snd-pcm.o snd-timer.o snd.o snd-rawmidi.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/ioctl32/Makefile linux/sound/core/ioctl32/Makefile
--- linux-2.5.51-bk1/sound/core/ioctl32/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/core/ioctl32/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,5 +9,3 @@
 endif
 
 obj-$(CONFIG_SND_BIT32_EMUL) += snd-ioctl32.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/oss/Makefile linux/sound/core/oss/Makefile
--- linux-2.5.51-bk1/sound/core/oss/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/sound/core/oss/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,5 +12,3 @@
 
 obj-$(CONFIG_SND_MIXER_OSS) += snd-mixer-oss.o
 obj-$(CONFIG_SND_PCM_OSS) += snd-pcm-oss.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/seq/Makefile linux/sound/core/seq/Makefile
--- linux-2.5.51-bk1/sound/core/seq/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/sound/core/seq/Makefile	Sat Dec 14 12:38:56 2002
@@ -76,5 +76,3 @@
 obj-$(CONFIG_SND_USB_AUDIO) += snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/seq/instr/Makefile linux/sound/core/seq/instr/Makefile
--- linux-2.5.51-bk1/sound/core/seq/instr/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/core/seq/instr/Makefile	Sat Dec 14 12:38:56 2002
@@ -42,5 +42,3 @@
 obj-$(CONFIG_SND_YMFPCI) += snd-ainstr-fm.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/core/seq/oss/Makefile linux/sound/core/seq/oss/Makefile
--- linux-2.5.51-bk1/sound/core/seq/oss/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/core/seq/oss/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
   obj-$(CONFIG_SND_SEQUENCER) += snd-seq-oss.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/drivers/Makefile linux/sound/drivers/Makefile
--- linux-2.5.51-bk1/sound/drivers/Makefile	Sun Sep 15 22:18:43 2002
+++ linux/sound/drivers/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_SND_MTPAV) += snd-mtpav.o
 
 obj-$(CONFIG_SND) += opl3/ mpu401/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/drivers/mpu401/Makefile linux/sound/drivers/mpu401/Makefile
--- linux-2.5.51-bk1/sound/drivers/mpu401/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/sound/drivers/mpu401/Makefile	Sat Dec 14 12:38:56 2002
@@ -41,5 +41,3 @@
 obj-$(CONFIG_SND_YMFPCI) += snd-mpu401-uart.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/drivers/opl3/Makefile linux/sound/drivers/opl3/Makefile
--- linux-2.5.51-bk1/sound/drivers/opl3/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/drivers/opl3/Makefile	Sat Dec 14 12:38:56 2002
@@ -66,5 +66,3 @@
 endif
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/i2c/Makefile linux/sound/i2c/Makefile
--- linux-2.5.51-bk1/sound/i2c/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/sound/i2c/Makefile	Sat Dec 14 12:38:56 2002
@@ -16,5 +16,3 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_INTERWAVE_STB) += snd-tea6330t.o snd-i2c.o
 obj-$(CONFIG_SND_ICE1712) += snd-cs8427.o snd-i2c.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/i2c/l3/Makefile linux/sound/i2c/l3/Makefile
--- linux-2.5.51-bk1/sound/i2c/l3/Makefile	Sun Sep 15 22:18:31 2002
+++ linux/sound/i2c/l3/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 
 # Module Dependency
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-uda1341.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/Makefile linux/sound/isa/Makefile
--- linux-2.5.51-bk1/sound/isa/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/isa/Makefile	Sat Dec 14 12:38:56 2002
@@ -22,5 +22,3 @@
 
 obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
 		     sb/ wavefront/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/ad1816a/Makefile linux/sound/isa/ad1816a/Makefile
--- linux-2.5.51-bk1/sound/isa/ad1816a/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/sound/isa/ad1816a/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AD1816A) += snd-ad1816a.o snd-ad1816a-lib.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/ad1848/Makefile linux/sound/isa/ad1848/Makefile
--- linux-2.5.51-bk1/sound/isa/ad1848/Makefile	Sun Sep 15 22:18:26 2002
+++ linux/sound/isa/ad1848/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-ad1848-lib.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/cs423x/Makefile linux/sound/isa/cs423x/Makefile
--- linux-2.5.51-bk1/sound/isa/cs423x/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/sound/isa/cs423x/Makefile	Sat Dec 14 12:38:56 2002
@@ -24,5 +24,3 @@
 obj-$(CONFIG_SND_WAVEFRONT) += snd-cs4231-lib.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/es1688/Makefile linux/sound/isa/es1688/Makefile
--- linux-2.5.51-bk1/sound/isa/es1688/Makefile	Sun Sep 15 22:18:43 2002
+++ linux/sound/isa/es1688/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ES1688) += snd-es1688.o snd-es1688-lib.o
 obj-$(CONFIG_SND_GUSEXTREME) += snd-es1688-lib.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/gus/Makefile linux/sound/isa/gus/Makefile
--- linux-2.5.51-bk1/sound/isa/gus/Makefile	Sun Sep 15 22:19:01 2002
+++ linux/sound/isa/gus/Makefile	Sat Dec 14 12:38:56 2002
@@ -34,5 +34,3 @@
 endif
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/opti9xx/Makefile linux/sound/isa/opti9xx/Makefile
--- linux-2.5.51-bk1/sound/isa/opti9xx/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/sound/isa/opti9xx/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,5 +11,3 @@
 obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-opti92x-ad1848.o
 obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-opti92x-cs4231.o
 obj-$(CONFIG_SND_OPTI93X) += snd-opti93x.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/sb/Makefile linux/sound/isa/sb/Makefile
--- linux-2.5.51-bk1/sound/isa/sb/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/isa/sb/Makefile	Sat Dec 14 12:38:56 2002
@@ -33,5 +33,3 @@
 endif
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/isa/wavefront/Makefile linux/sound/isa/wavefront/Makefile
--- linux-2.5.51-bk1/sound/isa/wavefront/Makefile	Sun Sep 15 22:18:37 2002
+++ linux/sound/isa/wavefront/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_WAVEFRONT) += snd-wavefront.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/oss/Makefile linux/sound/oss/Makefile
--- linux-2.5.51-bk1/sound/oss/Makefile	Sat Dec 14 12:32:08 2002
+++ linux/sound/oss/Makefile	Sat Dec 14 12:38:56 2002
@@ -100,8 +100,6 @@
 clean-files := maui_boot.h msndperm.c msndinit.c pndsperm.c pndspini.c \
                pss_boot.h trix_boot.h
 
-include $(TOPDIR)/Rules.make
-
 # Firmware files that need translation
 #
 # The translated files are protected by a file that keeps track
diff -urN linux-2.5.51-bk1/sound/oss/cs4281/Makefile linux/sound/oss/cs4281/Makefile
--- linux-2.5.51-bk1/sound/oss/cs4281/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/sound/oss/cs4281/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,5 +4,3 @@
 obj-$(CONFIG_SOUND_CS4281) += cs4281.o
 
 cs4281-objs += cs4281m.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/oss/dmasound/Makefile linux/sound/oss/dmasound/Makefile
--- linux-2.5.51-bk1/sound/oss/dmasound/Makefile	Sun Sep 15 22:18:23 2002
+++ linux/sound/oss/dmasound/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 obj-$(CONFIG_DMASOUND_AWACS)  += dmasound_core.o dmasound_awacs.o
 obj-$(CONFIG_DMASOUND_PAULA)  += dmasound_core.o dmasound_paula.o
 obj-$(CONFIG_DMASOUND_Q40)    += dmasound_core.o dmasound_q40.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/oss/emu10k1/Makefile linux/sound/oss/emu10k1/Makefile
--- linux-2.5.51-bk1/sound/oss/emu10k1/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/sound/oss/emu10k1/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 ifdef CONFIG_MIDI_EMU10K1
     EXTRA_CFLAGS += -DEMU10K1_SEQUENCER
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/Makefile linux/sound/pci/Makefile
--- linux-2.5.51-bk1/sound/pci/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/sound/pci/Makefile	Sat Dec 14 12:38:56 2002
@@ -35,5 +35,3 @@
 obj-$(CONFIG_SND_VIA82XX) += snd-via82xx.o
 
 obj-$(CONFIG_SND) += ac97/ ali5451/ cs46xx/ emu10k1/ korg1212/ nm256/ rme9652/ trident/ ymfpci/ ice1712/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/ac97/Makefile linux/sound/pci/ac97/Makefile
--- linux-2.5.51-bk1/sound/pci/ac97/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/sound/pci/ac97/Makefile	Sat Dec 14 12:38:56 2002
@@ -26,5 +26,3 @@
 obj-$(CONFIG_SND_YMFPCI) += snd-ac97-codec.o
 
 obj-m := $(sort $(obj-m))
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/ali5451/Makefile linux/sound/pci/ali5451/Makefile
--- linux-2.5.51-bk1/sound/pci/ali5451/Makefile	Sun Sep 15 22:18:51 2002
+++ linux/sound/pci/ali5451/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALI5451) += snd-ali5451.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/cs46xx/Makefile linux/sound/pci/cs46xx/Makefile
--- linux-2.5.51-bk1/sound/pci/cs46xx/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/sound/pci/cs46xx/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_CS46XX) += snd-cs46xx.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/emu10k1/Makefile linux/sound/pci/emu10k1/Makefile
--- linux-2.5.51-bk1/sound/pci/emu10k1/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/sound/pci/emu10k1/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
   obj-$(CONFIG_SND_EMU10K1) += snd-emu10k1-synth.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/ice1712/Makefile linux/sound/pci/ice1712/Makefile
--- linux-2.5.51-bk1/sound/pci/ice1712/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/sound/pci/ice1712/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,5 +9,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/korg1212/Makefile linux/sound/pci/korg1212/Makefile
--- linux-2.5.51-bk1/sound/pci/korg1212/Makefile	Sun Sep 15 22:18:29 2002
+++ linux/sound/pci/korg1212/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_KORG1212) += snd-korg1212.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/nm256/Makefile linux/sound/pci/nm256/Makefile
--- linux-2.5.51-bk1/sound/pci/nm256/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/sound/pci/nm256/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_NM256) += snd-nm256.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/rme9652/Makefile linux/sound/pci/rme9652/Makefile
--- linux-2.5.51-bk1/sound/pci/rme9652/Makefile	Sun Sep 15 22:18:38 2002
+++ linux/sound/pci/rme9652/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,5 +12,3 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_RME9652) += snd-rme9652.o snd-hammerfall-mem.o
 obj-$(CONFIG_SND_HDSP) += snd-hdsp.o snd-hammerfall-mem.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/trident/Makefile linux/sound/pci/trident/Makefile
--- linux-2.5.51-bk1/sound/pci/trident/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/sound/pci/trident/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
   obj-$(CONFIG_SND_TRIDENT) += snd-trident-synth.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/pci/ymfpci/Makefile linux/sound/pci/ymfpci/Makefile
--- linux-2.5.51-bk1/sound/pci/ymfpci/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/sound/pci/ymfpci/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_YMFPCI) += snd-ymfpci.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/ppc/Makefile linux/sound/ppc/Makefile
--- linux-2.5.51-bk1/sound/ppc/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/sound/ppc/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_POWERMAC) += snd-powermac.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/sparc/Makefile linux/sound/sparc/Makefile
--- linux-2.5.51-bk1/sound/sparc/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/sound/sparc/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 obj-$(CONFIG_SND_SUN_AMD7930) += snd-sun-amd7930.o
 #obj-$(CONFIG_SND_SUN_DBRI) += snd-sun-dbri.o
 obj-$(CONFIG_SND_SUN_CS4231) += snd-sun-cs4231.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/synth/Makefile linux/sound/synth/Makefile
--- linux-2.5.51-bk1/sound/synth/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/sound/synth/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 endif
 
 obj-$(CONFIG_SND) += emux/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/synth/emux/Makefile linux/sound/synth/emux/Makefile
--- linux-2.5.51-bk1/sound/synth/emux/Makefile	Sun Sep 15 22:18:29 2002
+++ linux/sound/synth/emux/Makefile	Sat Dec 14 12:38:56 2002
@@ -16,5 +16,3 @@
   obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
   obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
 endif
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/sound/usb/Makefile linux/sound/usb/Makefile
--- linux-2.5.51-bk1/sound/usb/Makefile	Sat Dec 14 12:31:50 2002
+++ linux/sound/usb/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o
-
-include $(TOPDIR)/Rules.make

--------------040705050501020306000908--

