Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVAITQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVAITQn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVAITQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:16:43 -0500
Received: from lakermmtao07.cox.net ([68.230.240.32]:161 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261706AbVAITO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:14:29 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <ADDF3B61-6272-11D9-A217-000393ACC76E@mac.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-289331529
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] [RFC] [2.6] Replace linux/vfs.h inclusions with linux/statfs.h
From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Sun, 9 Jan 2005 14:14:26 -0500
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-289331529
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

This patch removes some unneeded inclusions of linux/vfs.h and converts 
others
to include linux/statfs.h, the equivalent of including linux/vfs.h, 
then removes the
unused vfs.h header.

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>


--Apple-Mail-3-289331529
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="remove-useless-vfs-header.patch"
Content-Disposition: attachment;
	filename=remove-useless-vfs-header.patch

Index: arch/alpha/kernel/osf_sys.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/alpha/kernel/osf_sys.c,v
retrieving revision 1.40
diff -u -r1.40 osf_sys.c
--- arch/alpha/kernel/osf_sys.c	23 Sep 2004 05:59:47 -0000	1.40
+++ arch/alpha/kernel/osf_sys.c	6 Jan 2005 00:29:41 -0000
@@ -36,7 +36,7 @@
 #include <linux/ipc.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
Index: arch/ia64/ia32/sys_ia32.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/ia64/ia32/sys_ia32.c,v
retrieving revision 1.73
diff -u -r1.73 sys_ia32.c
--- arch/ia64/ia32/sys_ia32.c	8 Oct 2004 02:57:28 -0000	1.73
+++ arch/ia64/ia32/sys_ia32.c	6 Jan 2005 00:32:20 -0000
@@ -48,7 +48,6 @@
 #include <linux/stat.h>
 #include <linux/ipc.h>
 #include <linux/compat.h>
-#include <linux/vfs.h>
 #include <linux/mman.h>
 
 #include <asm/intrinsics.h>
Index: arch/ia64/kernel/perfmon.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/ia64/kernel/perfmon.c,v
retrieving revision 1.65
diff -u -r1.65 perfmon.c
--- arch/ia64/kernel/perfmon.c	14 Dec 2004 20:50:01 -0000	1.65
+++ arch/ia64/kernel/perfmon.c	6 Jan 2005 00:32:47 -0000
@@ -34,7 +34,6 @@
 #include <linux/list.h>
 #include <linux/file.h>
 #include <linux/poll.h>
-#include <linux/vfs.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/version.h>
Index: arch/mips/kernel/linux32.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/mips/kernel/linux32.c,v
retrieving revision 1.14
diff -u -r1.14 linux32.c
--- arch/mips/kernel/linux32.c	7 Aug 2004 23:08:23 -0000	1.14
+++ arch/mips/kernel/linux32.c	6 Jan 2005 00:30:36 -0000
@@ -36,7 +36,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/compat.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <net/sock.h>
 #include <net/scm.h>
Index: arch/mips/kernel/sysirix.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/mips/kernel/sysirix.c,v
retrieving revision 1.32
diff -u -r1.32 sysirix.c
--- arch/mips/kernel/sysirix.c	2 Dec 2004 01:07:46 -0000	1.32
+++ arch/mips/kernel/sysirix.c	6 Jan 2005 00:31:00 -0000
@@ -25,7 +25,7 @@
 #include <linux/smp_lock.h>
 #include <linux/utsname.h>
 #include <linux/file.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/namei.h>
 #include <linux/socket.h>
 #include <linux/security.h>
Index: arch/parisc/hpux/sys_hpux.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/parisc/hpux/sys_hpux.c,v
retrieving revision 1.11
diff -u -r1.11 sys_hpux.c
--- arch/parisc/hpux/sys_hpux.c	25 Feb 2004 16:12:24 -0000	1.11
+++ arch/parisc/hpux/sys_hpux.c	6 Jan 2005 00:33:31 -0000
@@ -29,7 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/errno.h>
 #include <asm/pgalloc.h>
Index: arch/parisc/kernel/sys_parisc32.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/parisc/kernel/sys_parisc32.c,v
retrieving revision 1.32
diff -u -r1.32 sys_parisc32.c
--- arch/parisc/kernel/sys_parisc32.c	19 Oct 2004 05:53:35 -0000	1.32
+++ arch/parisc/kernel/sys_parisc32.c	6 Jan 2005 00:34:25 -0000
@@ -44,7 +44,6 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
-#include <linux/vfs.h>
 #include <linux/ptrace.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
Index: arch/s390/kernel/compat_linux.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/s390/kernel/compat_linux.c,v
retrieving revision 1.28
diff -u -r1.28 compat_linux.c
--- arch/s390/kernel/compat_linux.c	19 Oct 2004 05:53:35 -0000	1.28
+++ arch/s390/kernel/compat_linux.c	6 Jan 2005 00:35:45 -0000
@@ -56,7 +56,6 @@
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
 #include <linux/compat.h>
-#include <linux/vfs.h>
 #include <linux/ptrace.h>
 
 #include <asm/types.h>
Index: arch/sparc64/kernel/sys_sparc32.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/sparc64/kernel/sys_sparc32.c,v
retrieving revision 1.99
diff -u -r1.99 sys_sparc32.c
--- arch/sparc64/kernel/sys_sparc32.c	19 Oct 2004 05:53:35 -0000	1.99
+++ arch/sparc64/kernel/sys_sparc32.c	6 Jan 2005 00:36:26 -0000
@@ -50,7 +50,6 @@
 #include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/compat.h>
-#include <linux/vfs.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/ptrace.h>
 #include <linux/highuid.h>
Index: arch/sparc64/solaris/fs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/sparc64/solaris/fs.c,v
retrieving revision 1.22
diff -u -r1.22 fs.c
--- arch/sparc64/solaris/fs.c	19 Oct 2004 05:53:09 -0000	1.22
+++ arch/sparc64/solaris/fs.c	6 Jan 2005 00:37:50 -0000
@@ -20,7 +20,7 @@
 #include <linux/resource.h>
 #include <linux/quotaops.h>
 #include <linux/mount.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/uaccess.h>
 #include <asm/string.h>
Index: arch/x86_64/ia32/sys_ia32.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/arch/x86_64/ia32/sys_ia32.c,v
retrieving revision 1.76
diff -u -r1.76 sys_ia32.c
--- arch/x86_64/ia32/sys_ia32.c	2 Dec 2004 01:08:01 -0000	1.76
+++ arch/x86_64/ia32/sys_ia32.c	6 Jan 2005 00:38:28 -0000
@@ -57,7 +57,6 @@
 #include <linux/aio_abi.h>
 #include <linux/aio.h>
 #include <linux/compat.h>
-#include <linux/vfs.h>
 #include <linux/ptrace.h>
 #include <linux/highuid.h>
 #include <linux/vmalloc.h>
Index: fs/compat.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/compat.c,v
retrieving revision 1.48
diff -u -r1.48 compat.c
--- fs/compat.c	10 Dec 2004 17:57:53 -0000	1.48
+++ fs/compat.c	6 Jan 2005 00:39:13 -0000
@@ -23,7 +23,7 @@
 #include <linux/fcntl.h>
 #include <linux/namei.h>
 #include <linux/file.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/ioctl32.h>
 #include <linux/init.h>
 #include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
Index: fs/libfs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/libfs.c,v
retrieving revision 1.36
diff -u -r1.36 libfs.c
--- fs/libfs.c	26 Oct 2004 01:14:02 -0000	1.36
+++ fs/libfs.c	6 Jan 2005 00:39:29 -0000
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/mount.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/uaccess.h>
 
 int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
Index: fs/open.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/open.c,v
retrieving revision 1.73
diff -u -r1.73 open.c
--- fs/open.c	19 Oct 2004 05:54:02 -0000	1.73
+++ fs/open.c	6 Jan 2005 00:39:45 -0000
@@ -18,7 +18,7 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 #include <linux/mount.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
Index: fs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/super.c,v
retrieving revision 1.120
diff -u -r1.120 super.c
--- fs/super.c	20 Oct 2004 01:26:30 -0000	1.120
+++ fs/super.c	6 Jan 2005 00:39:58 -0000
@@ -33,7 +33,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
 #include <linux/kobject.h>
Index: fs/adfs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/adfs/super.c,v
retrieving revision 1.33
diff -u -r1.33 super.c
--- fs/adfs/super.c	20 Oct 2004 15:39:25 -0000	1.33
+++ fs/adfs/super.c	6 Jan 2005 00:40:14 -0000
@@ -17,7 +17,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
 
Index: fs/befs/linuxvfs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/befs/linuxvfs.c,v
retrieving revision 1.27
diff -u -r1.27 linuxvfs.c
--- fs/befs/linuxvfs.c	8 Sep 2004 14:59:08 -0000	1.27
+++ fs/befs/linuxvfs.c	6 Jan 2005 00:40:29 -0000
@@ -12,7 +12,7 @@
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/namei.h>
 
Index: fs/bfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/bfs/inode.c,v
retrieving revision 1.31
diff -u -r1.31 inode.c
--- fs/bfs/inode.c	17 Sep 2004 19:03:20 -0000	1.31
+++ fs/bfs/inode.c	6 Jan 2005 00:40:43 -0000
@@ -12,7 +12,7 @@
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/uaccess.h>
 #include "bfs.h"
 
Index: fs/cifs/cifsfs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/cifs/cifsfs.c,v
retrieving revision 1.46
diff -u -r1.46 cifsfs.c
--- fs/cifs/cifsfs.c	16 Dec 2004 23:28:41 -0000	1.46
+++ fs/cifs/cifsfs.c	6 Jan 2005 00:40:56 -0000
@@ -30,7 +30,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/seq_file.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/mempool.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
Index: fs/cifs/cifssmb.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/cifs/cifssmb.c,v
retrieving revision 1.65
diff -u -r1.65 cifssmb.c
--- fs/cifs/cifssmb.c	16 Dec 2004 23:28:41 -0000	1.65
+++ fs/cifs/cifssmb.c	6 Jan 2005 00:41:19 -0000
@@ -29,7 +29,7 @@
 
 #include <linux/fs.h>
 #include <linux/kernel.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/posix_acl_xattr.h>
 #include <asm/uaccess.h>
 #include "cifspdu.h"
Index: fs/coda/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/coda/inode.c,v
retrieving revision 1.37
diff -u -r1.37 inode.c
--- fs/coda/inode.c	24 Aug 2004 18:34:08 -0000	1.37
+++ fs/coda/inode.c	6 Jan 2005 00:57:03 -0000
@@ -17,7 +17,7 @@
 #include <linux/unistd.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: fs/coda/upcall.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/coda/upcall.c,v
retrieving revision 1.21
diff -u -r1.21 upcall.c
--- fs/coda/upcall.c	3 Sep 2004 17:35:56 -0000	1.21
+++ fs/coda/upcall.c	6 Jan 2005 00:57:10 -0000
@@ -29,7 +29,7 @@
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/vmalloc.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <linux/coda.h>
 #include <linux/coda_linux.h>
Index: fs/cramfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/cramfs/inode.c,v
retrieving revision 1.39
diff -u -r1.39 inode.c
--- fs/cramfs/inode.c	16 Apr 2004 21:27:28 -0000	1.39
+++ fs/cramfs/inode.c	6 Jan 2005 00:57:24 -0000
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/cramfs_fs_sb.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/semaphore.h>
 
 #include <asm/uaccess.h>
Index: fs/efs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/efs/super.c,v
retrieving revision 1.27
diff -u -r1.27 super.c
--- fs/efs/super.c	19 Nov 2004 22:59:55 -0000	1.27
+++ fs/efs/super.c	6 Jan 2005 00:57:37 -0000
@@ -13,7 +13,7 @@
 #include <linux/efs_fs_sb.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 static int efs_statfs(struct super_block *s, struct kstatfs *buf);
 static int efs_fill_super(struct super_block *s, void *d, int silent);
Index: fs/ext2/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/ext2/super.c,v
retrieving revision 1.64
diff -u -r1.64 super.c
--- fs/ext2/super.c	4 Jan 2005 04:12:49 -0000	1.64
+++ fs/ext2/super.c	6 Jan 2005 00:57:45 -0000
@@ -26,7 +26,7 @@
 #include <linux/random.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/uaccess.h>
 #include "ext2.h"
 #include "xattr.h"
Index: fs/ext3/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/ext3/super.c,v
retrieving revision 1.102
diff -u -r1.102 super.c
--- fs/ext3/super.c	4 Jan 2005 04:13:03 -0000	1.102
+++ fs/ext3/super.c	6 Jan 2005 00:57:59 -0000
@@ -30,7 +30,7 @@
 #include <linux/parser.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/random.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
Index: fs/fat/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/fat/inode.c,v
retrieving revision 1.108
diff -u -r1.108 inode.c
--- fs/fat/inode.c	20 Oct 2004 15:16:56 -0000	1.108
+++ fs/fat/inode.c	6 Jan 2005 00:58:10 -0000
@@ -19,7 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/parser.h>
 #include <asm/unaligned.h>
 
Index: fs/freevxfs/vxfs_super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/freevxfs/vxfs_super.c,v
retrieving revision 1.23
diff -u -r1.23 vxfs_super.c
--- fs/freevxfs/vxfs_super.c	3 Sep 2004 17:29:39 -0000	1.23
+++ fs/freevxfs/vxfs_super.c	6 Jan 2005 00:58:29 -0000
@@ -39,7 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include "vxfs.h"
 #include "vxfs_extern.h"
Index: fs/hfs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/hfs/super.c,v
retrieving revision 1.33
diff -u -r1.33 super.c
--- fs/hfs/super.c	26 Oct 2004 01:21:43 -0000	1.33
+++ fs/hfs/super.c	6 Jan 2005 00:58:48 -0000
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
Index: fs/hfsplus/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/hfsplus/super.c,v
retrieving revision 1.5
diff -u -r1.5 super.c
--- fs/hfsplus/super.c	26 Oct 2004 01:21:43 -0000	1.5
+++ fs/hfsplus/super.c	6 Jan 2005 00:58:57 -0000
@@ -15,7 +15,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 static struct inode *hfsplus_alloc_inode(struct super_block *sb);
 static void hfsplus_destroy_inode(struct inode *inode);
Index: fs/isofs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/isofs/inode.c,v
retrieving revision 1.48
diff -u -r1.48 inode.c
--- fs/isofs/inode.c	24 Aug 2004 18:39:40 -0000	1.48
+++ fs/isofs/inode.c	6 Jan 2005 00:59:40 -0000
@@ -30,7 +30,7 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/parser.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: fs/jffs/inode-v23.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/jffs/inode-v23.c,v
retrieving revision 1.64
diff -u -r1.64 inode-v23.c
--- fs/jffs/inode-v23.c	11 Jul 2004 17:08:48 -0000	1.64
+++ fs/jffs/inode-v23.c	6 Jan 2005 00:59:50 -0000
@@ -41,7 +41,7 @@
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
Index: fs/jffs2/fs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/jffs2/fs.c,v
retrieving revision 1.20
diff -u -r1.20 fs.c
--- fs/jffs2/fs.c	15 Jul 2004 17:19:18 -0000	1.20
+++ fs/jffs2/fs.c	6 Jan 2005 00:59:59 -0000
@@ -20,7 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/crc32.h>
 #include "nodelist.h"
 
Index: fs/jfs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/jfs/super.c,v
retrieving revision 1.53
diff -u -r1.53 super.c
--- fs/jfs/super.c	19 Oct 2004 15:05:13 -0000	1.53
+++ fs/jfs/super.c	6 Jan 2005 00:56:48 -0000
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/completion.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/moduleparam.h>
 #include <asm/uaccess.h>
 
Index: fs/minix/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/minix/inode.c,v
retrieving revision 1.44
diff -u -r1.44 inode.c
--- fs/minix/inode.c	17 Sep 2004 19:03:20 -0000	1.44
+++ fs/minix/inode.c	6 Jan 2005 00:56:38 -0000
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 static void minix_read_inode(struct inode * inode);
 static int minix_write_inode(struct inode * inode, int wait);
Index: fs/ncpfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/ncpfs/inode.c,v
retrieving revision 1.51
diff -u -r1.51 inode.c
--- fs/ncpfs/inode.c	6 Oct 2004 14:54:02 -0000	1.51
+++ fs/ncpfs/inode.c	6 Jan 2005 00:56:27 -0000
@@ -28,7 +28,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <linux/ncp_fs.h>
 
Index: fs/nfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/nfs/inode.c,v
retrieving revision 1.106
diff -u -r1.106 inode.c
--- fs/nfs/inode.c	17 Sep 2004 19:03:20 -0000	1.106
+++ fs/nfs/inode.c	6 Jan 2005 00:56:16 -0000
@@ -34,7 +34,7 @@
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <linux/nfs_idmap.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: fs/nfsd/nfs3xdr.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/nfsd/nfs3xdr.c,v
retrieving revision 1.51
diff -u -r1.51 nfs3xdr.c
--- fs/nfsd/nfs3xdr.c	23 Aug 2004 20:02:30 -0000	1.51
+++ fs/nfsd/nfs3xdr.c	6 Jan 2005 00:56:06 -0000
@@ -16,7 +16,7 @@
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
Index: fs/nfsd/nfs4xdr.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/nfsd/nfs4xdr.c,v
retrieving revision 1.59
diff -u -r1.59 nfs4xdr.c
--- fs/nfsd/nfs4xdr.c	20 Oct 2004 15:25:26 -0000	1.59
+++ fs/nfsd/nfs4xdr.c	6 Jan 2005 00:55:59 -0000
@@ -47,7 +47,7 @@
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/clnt.h>
Index: fs/nfsd/nfsxdr.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/nfsd/nfsxdr.c,v
retrieving revision 1.32
diff -u -r1.32 nfsxdr.c
--- fs/nfsd/nfsxdr.c	11 Aug 2004 23:48:02 -0000	1.32
+++ fs/nfsd/nfsxdr.c	6 Jan 2005 00:55:53 -0000
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
Index: fs/nfsd/vfs.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/nfsd/vfs.c,v
retrieving revision 1.94
diff -u -r1.94 vfs.c
--- fs/nfsd/vfs.c	20 Oct 2004 15:24:28 -0000	1.94
+++ fs/nfsd/vfs.c	6 Jan 2005 00:55:46 -0000
@@ -35,7 +35,7 @@
 #include <linux/in.h>
 #include <linux/module.h>
 #include <linux/namei.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #ifdef CONFIG_NFSD_V3
Index: fs/ntfs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/ntfs/super.c,v
retrieving revision 1.56
diff -u -r1.56 super.c
--- fs/ntfs/super.c	10 Nov 2004 12:45:33 -0000	1.56
+++ fs/ntfs/super.c	6 Jan 2005 00:55:27 -0000
@@ -27,7 +27,7 @@
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/moduleparam.h>
 #include <linux/smp_lock.h>
 
Index: fs/qnx4/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/qnx4/inode.c,v
retrieving revision 1.37
diff -u -r1.37 inode.c
--- fs/qnx4/inode.c	17 Sep 2004 19:03:20 -0000	1.37
+++ fs/qnx4/inode.c	6 Jan 2005 00:54:45 -0000
@@ -25,7 +25,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/uaccess.h>
 
 #define QNX4_VERSION  4
Index: fs/reiserfs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/reiserfs/super.c,v
retrieving revision 1.89
diff -u -r1.89 super.c
--- fs/reiserfs/super.c	4 Jan 2005 04:13:18 -0000	1.89
+++ fs/reiserfs/super.c	6 Jan 2005 00:54:32 -0000
@@ -23,7 +23,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/namespace.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
Index: fs/romfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/romfs/inode.c,v
retrieving revision 1.37
diff -u -r1.37 inode.c
--- fs/romfs/inode.c	6 Oct 2004 14:51:50 -0000	1.37
+++ fs/romfs/inode.c	6 Jan 2005 00:54:23 -0000
@@ -74,7 +74,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include <asm/uaccess.h>
 
Index: fs/smbfs/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/smbfs/inode.c,v
retrieving revision 1.54
diff -u -r1.54 inode.c
--- fs/smbfs/inode.c	19 Nov 2004 23:02:14 -0000	1.54
+++ fs/smbfs/inode.c	6 Jan 2005 00:54:14 -0000
@@ -24,7 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <linux/net.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/highuid.h>
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
Index: fs/smbfs/proc.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/smbfs/proc.c,v
retrieving revision 1.44
diff -u -r1.44 proc.c
--- fs/smbfs/proc.c	19 Nov 2004 23:02:14 -0000	1.44
+++ fs/smbfs/proc.c	6 Jan 2005 00:54:06 -0000
@@ -19,7 +19,7 @@
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
 #include <linux/net.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
 #include <linux/smb_mount.h>
Index: fs/sysv/inode.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/sysv/inode.c,v
retrieving revision 1.33
diff -u -r1.33 inode.c
--- fs/sysv/inode.c	17 Sep 2004 19:03:20 -0000	1.33
+++ fs/sysv/inode.c	6 Jan 2005 00:53:54 -0000
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <asm/byteorder.h>
 #include "sysv.h"
 
Index: fs/udf/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/udf/super.c,v
retrieving revision 1.45
diff -u -r1.45 super.c
--- fs/udf/super.c	9 Sep 2004 23:10:01 -0000	1.45
+++ fs/udf/super.c	6 Jan 2005 00:44:26 -0000
@@ -56,7 +56,7 @@
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
Index: fs/ufs/super.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/ufs/super.c,v
retrieving revision 1.46
diff -u -r1.46 super.c
--- fs/ufs/super.c	20 Oct 2004 15:39:25 -0000	1.46
+++ fs/ufs/super.c	6 Jan 2005 00:44:57 -0000
@@ -85,7 +85,7 @@
 #include <linux/parser.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 
 #include "swab.h"
 #include "util.h"
Index: fs/xfs/linux-2.6/xfs_linux.h
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/xfs/linux-2.6/xfs_linux.h,v
retrieving revision 1.5
diff -u -r1.5 xfs_linux.h
--- fs/xfs/linux-2.6/xfs_linux.h	23 Dec 2004 21:59:37 -0000	1.5
+++ fs/xfs/linux-2.6/xfs_linux.h	6 Jan 2005 00:43:38 -0000
@@ -82,7 +82,6 @@
 #include <linux/bitops.h>
 #include <linux/major.h>
 #include <linux/pagemap.h>
-#include <linux/vfs.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/list.h>
Index: fs/xfs/linux-2.6/xfs_vfs.h
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/fs/xfs/linux-2.6/xfs_vfs.h,v
retrieving revision 1.4
diff -u -r1.4 xfs_vfs.h
--- fs/xfs/linux-2.6/xfs_vfs.h	13 Oct 2004 03:30:49 -0000	1.4
+++ fs/xfs/linux-2.6/xfs_vfs.h	6 Jan 2005 00:44:07 -0000
@@ -32,7 +32,7 @@
 #ifndef __XFS_VFS_H__
 #define __XFS_VFS_H__
 
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include "xfs_fs.h"
 
 struct fid;
Index: include/linux/vfs.h
===================================================================
RCS file: include/linux/vfs.h
diff -N include/linux/vfs.h
--- include/linux/vfs.h	21 Jun 2003 16:21:13 -0000	1.3
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,6 +0,0 @@
-#ifndef _LINUX_VFS_H
-#define _LINUX_VFS_H
-
-#include <linux/statfs.h>
-
-#endif
Index: include/linux/nfsd/xdr.h
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/include/linux/nfsd/xdr.h,v
retrieving revision 1.11
diff -u -r1.11 xdr.h
--- include/linux/nfsd/xdr.h	16 Jul 2004 19:05:10 -0000	1.11
+++ include/linux/nfsd/xdr.h	6 Jan 2005 00:43:10 -0000
@@ -8,7 +8,7 @@
 #define LINUX_NFSD_H
 
 #include <linux/fs.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/nfs.h>
 
 struct nfsd_fhandle {
Index: kernel/acct.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/kernel/acct.c,v
retrieving revision 1.38
diff -u -r1.38 acct.c
--- kernel/acct.c	26 Oct 2004 01:18:37 -0000	1.38
+++ kernel/acct.c	6 Jan 2005 00:42:50 -0000
@@ -50,7 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <linux/security.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/jiffies.h>
 #include <linux/times.h>
 #include <linux/syscalls.h>
Index: mm/shmem.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/mm/shmem.c,v
retrieving revision 1.163
diff -u -r1.163 shmem.c
--- mm/shmem.c	19 Nov 2004 22:52:39 -0000	1.163
+++ mm/shmem.c	6 Jan 2005 00:42:23 -0000
@@ -39,7 +39,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/mount.h>
 #include <linux/writeback.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/swapops.h>
Index: mm/tiny-shmem.c
===================================================================
RCS file: /home/kyle/bklinux/cvs/linux-2.5/mm/tiny-shmem.c,v
retrieving revision 1.3
diff -u -r1.3 tiny-shmem.c
--- mm/tiny-shmem.c	19 Oct 2004 15:02:40 -0000	1.3
+++ mm/tiny-shmem.c	6 Jan 2005 00:42:01 -0000
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
-#include <linux/vfs.h>
 #include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/mm.h>

--Apple-Mail-3-289331529
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

--Apple-Mail-3-289331529--

