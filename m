Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTAANrb>; Wed, 1 Jan 2003 08:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTAANrb>; Wed, 1 Jan 2003 08:47:31 -0500
Received: from verein.lst.de ([212.34.181.86]:26123 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267243AbTAANrS>;
	Wed, 1 Jan 2003 08:47:18 -0500
Date: Wed, 1 Jan 2003 14:55:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include <linux/vfs.h> only in files actually needing it
Message-ID: <20030101145542.B2723@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs.h only needs the forward-declaration of struct statfs


--- 1.23/arch/alpha/kernel/osf_sys.c	Thu Nov 21 06:38:43 2002
+++ edited/arch/alpha/kernel/osf_sys.c	Wed Jan  1 01:32:35 2003
@@ -35,6 +35,7 @@
 #include <linux/ipc.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
+#include <linux/vfs.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
--- 1.34/arch/ia64/ia32/sys_ia32.c	Mon Dec 30 07:35:56 2002
+++ edited/arch/ia64/ia32/sys_ia32.c	Wed Jan  1 01:33:10 2003
@@ -48,6 +48,7 @@
 #include <linux/stat.h>
 #include <linux/ipc.h>
 #include <linux/compat.h>
+#include <linux/vfs.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
===== arch/mips/kernel/sysirix.c 1.8 vs edited =====
--- 1.8/arch/mips/kernel/sysirix.c	Sun Nov 17 15:18:07 2002
+++ edited/arch/mips/kernel/sysirix.c	Wed Jan  1 01:33:40 2003
@@ -22,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/utsname.h>
 #include <linux/file.h>
+#include <linux/vfs.h>
 
 #include <asm/ptrace.h>
 #include <asm/page.h>
===== arch/mips64/kernel/linux32.c 1.9 vs edited =====
--- 1.9/arch/mips64/kernel/linux32.c	Wed Dec 11 19:14:42 2002
+++ edited/arch/mips64/kernel/linux32.c	Wed Jan  1 01:34:10 2003
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <linux/vfs.h>
 #include <net/sock.h>
 
 #include <asm/uaccess.h>
===== arch/parisc/hpux/sys_hpux.c 1.4 vs edited =====
--- 1.4/arch/parisc/hpux/sys_hpux.c	Sun Jul 21 06:08:49 2002
+++ edited/arch/parisc/hpux/sys_hpux.c	Wed Jan  1 01:34:28 2003
@@ -10,6 +10,7 @@
 #include <linux/smp_lock.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/vfs.h>
 
 #include <asm/errno.h>
 #include <asm/pgalloc.h>
===== arch/parisc/kernel/sys_parisc32.c 1.3 vs edited =====
--- 1.3/arch/parisc/kernel/sys_parisc32.c	Sun Nov 17 15:18:06 2002
+++ edited/arch/parisc/kernel/sys_parisc32.c	Wed Jan  1 01:35:00 2003
@@ -52,6 +52,7 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/vfs.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
===== arch/s390x/kernel/linux32.c 1.27 vs edited =====
--- 1.27/arch/s390x/kernel/linux32.c	Mon Dec 30 00:09:33 2002
+++ edited/arch/s390x/kernel/linux32.c	Wed Jan  1 01:35:32 2003
@@ -57,6 +57,7 @@
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
 #include <linux/compat.h>
+#include <linux/vfs.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
===== arch/sparc64/kernel/sys_sparc32.c 1.52 vs edited =====
--- 1.52/arch/sparc64/kernel/sys_sparc32.c	Fri Dec 20 21:46:48 2002
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Wed Jan  1 01:35:56 2003
@@ -52,6 +52,7 @@
 #include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/compat.h>
+#include <linux/vfs.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
===== arch/sparc64/solaris/fs.c 1.13 vs edited =====
--- 1.13/arch/sparc64/solaris/fs.c	Mon Nov 18 17:12:29 2002
+++ edited/arch/sparc64/solaris/fs.c	Wed Jan  1 01:36:12 2003
@@ -20,6 +20,7 @@
 #include <linux/resource.h>
 #include <linux/quotaops.h>
 #include <linux/mount.h>
+#include <linux/vfs.h>
 
 #include <asm/uaccess.h>
 #include <asm/string.h>
===== arch/x86_64/ia32/sys_ia32.c 1.12 vs edited =====
--- 1.12/arch/x86_64/ia32/sys_ia32.c	Sat Dec 21 12:36:34 2002
+++ edited/arch/x86_64/ia32/sys_ia32.c	Wed Jan  1 01:36:36 2003
@@ -58,6 +58,7 @@
 #include <linux/init.h>
 #include <linux/aio_abi.h>
 #include <linux/compat.h>
+#include <linux/vfs.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
--- 1.13/fs/libfs.c	Sun Dec 29 17:33:41 2002
+++ edited/fs/libfs.c	Wed Jan  1 01:18:35 2003
@@ -4,7 +4,7 @@
  */
 
 #include <linux/pagemap.h>
-#include <linux/smp_lock.h>
+#include <linux/vfs.h>
 
 int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		   struct kstat *stat)
===== fs/open.c 1.34 vs edited =====
--- 1.34/fs/open.c	Sat Dec 14 13:19:46 2002
+++ edited/fs/open.c	Wed Jan  1 01:19:19 2003
@@ -18,7 +18,7 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 #include <linux/mount.h>
-
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
===== fs/super.c 1.91 vs edited =====
--- 1.91/fs/super.c	Sat Dec 21 11:24:23 2002
+++ edited/fs/super.c	Wed Jan  1 01:18:52 2003
@@ -30,6 +30,7 @@
 #include <linux/buffer_head.h>		/* for fsync_super() */
 #include <linux/mount.h>
 #include <linux/security.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 
 
===== fs/adfs/super.c 1.20 vs edited =====
--- 1.20/fs/adfs/super.c	Mon Oct  7 13:27:57 2002
+++ edited/fs/adfs/super.c	Wed Jan  1 01:32:11 2003
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
===== fs/affs/super.c 1.31 vs edited =====
--- 1.31/fs/affs/super.c	Sun Nov 17 15:04:35 2002
+++ edited/fs/affs/super.c	Wed Jan  1 01:32:02 2003
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
===== fs/befs/linuxvfs.c 1.3 vs edited =====
--- 1.3/fs/befs/linuxvfs.c	Sat Dec 14 18:12:11 2002
+++ edited/fs/befs/linuxvfs.c	Wed Jan  1 01:31:33 2003
@@ -12,6 +12,7 @@
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
+#include <linux/statfs.h>
 
 #include "befs.h"
 #include "btree.h"
===== fs/bfs/inode.c 1.22 vs edited =====
--- 1.22/fs/bfs/inode.c	Sun Nov 17 14:53:57 2002
+++ edited/fs/bfs/inode.c	Wed Jan  1 01:31:24 2003
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include "bfs.h"
 
===== fs/cifs/cifsfs.c 1.4 vs edited =====
--- 1.4/fs/cifs/cifsfs.c	Sun Nov 17 04:28:45 2002
+++ edited/fs/cifs/cifsfs.c	Wed Jan  1 01:30:34 2003
@@ -31,6 +31,7 @@
 #include <linux/version.h>
 #include <linux/list.h>
 #include <linux/seq_file.h>
+#include <linux/vfs.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
===== fs/cifs/cifsproto.h 1.4 vs edited =====
--- 1.4/fs/cifs/cifsproto.h	Thu Nov 21 17:58:06 2002
+++ edited/fs/cifs/cifsproto.h	Wed Jan  1 01:30:56 2003
@@ -22,6 +22,8 @@
 #define _CIFSPROTO_H
 #include <linux/nls.h>
 
+struct statfs;
+
 /*
  *****************************************************************
  * All Prototypes
===== fs/cifs/cifssmb.c 1.5 vs edited =====
--- 1.5/fs/cifs/cifssmb.c	Thu Nov 21 17:58:06 2002
+++ edited/fs/cifs/cifssmb.c	Wed Jan  1 01:30:45 2003
@@ -25,6 +25,7 @@
 
 #include <linux/fs.h>
 #include <linux/kernel.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
===== fs/coda/inode.c 1.22 vs edited =====
--- 1.22/fs/coda/inode.c	Fri Oct 11 23:05:02 2002
+++ edited/fs/coda/inode.c	Wed Jan  1 01:30:13 2003
@@ -17,6 +17,7 @@
 #include <linux/unistd.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
+#include <linux/vfs.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== fs/coda/upcall.c 1.12 vs edited =====
--- 1.12/fs/coda/upcall.c	Wed Nov 20 06:19:02 2002
+++ edited/fs/coda/upcall.c	Wed Jan  1 01:30:04 2003
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <asm/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/vfs.h>
 
 #include <linux/coda.h>
 #include <linux/coda_linux.h>
===== fs/cramfs/inode.c 1.24 vs edited =====
--- 1.24/fs/cramfs/inode.c	Mon Oct  7 13:27:57 2002
+++ edited/fs/cramfs/inode.c	Wed Jan  1 01:29:46 2003
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/cramfs_fs_sb.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/semaphore.h>
 
 #include <asm/uaccess.h>
--- 1.14/fs/efs/super.c	Mon Oct  7 13:27:57 2002
+++ edited/fs/efs/super.c	Wed Jan  1 01:29:28 2003
@@ -13,6 +13,7 @@
 #include <linux/efs_fs_sb.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 
 static struct super_block *efs_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
===== fs/ext2/super.c 1.42 vs edited =====
--- 1.42/fs/ext2/super.c	Thu Nov 21 16:10:50 2002
+++ edited/fs/ext2/super.c	Wed Jan  1 01:29:14 2003
@@ -25,6 +25,7 @@
 #include <linux/random.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include "ext2.h"
 #include "xattr.h"
===== fs/ext3/super.c 1.48 vs edited =====
--- 1.48/fs/ext3/super.c	Sat Dec 14 12:41:38 2002
+++ edited/fs/ext3/super.c	Wed Jan  1 01:28:39 2003
@@ -29,6 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 #include "xattr.h"
 #include "acl.h"
===== fs/fat/inode.c 1.59 vs edited =====
--- 1.59/fs/fat/inode.c	Sat Dec 14 12:42:09 2002
+++ edited/fs/fat/inode.c	Wed Jan  1 01:28:22 2003
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
+#include <linux/vfs.h>
 #include <asm/unaligned.h>
 
 /*
===== fs/freevxfs/vxfs_super.c 1.12 vs edited =====
--- 1.12/fs/freevxfs/vxfs_super.c	Mon Oct  7 13:27:57 2002
+++ edited/fs/freevxfs/vxfs_super.c	Wed Jan  1 01:28:05 2003
@@ -41,6 +41,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/vfs.h>
 
 #include "vxfs.h"
 #include "vxfs_extern.h"
===== fs/hfs/super.c 1.19 vs edited =====
--- 1.19/fs/hfs/super.c	Mon Oct  7 13:27:57 2002
+++ edited/fs/hfs/super.c	Wed Jan  1 01:27:43 2003
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/vfs.h>
 
 MODULE_LICENSE("GPL");
 
===== fs/hpfs/hpfs_fn.h 1.12 vs edited =====
--- 1.12/fs/hpfs/hpfs_fn.h	Thu Nov 21 13:02:12 2002
+++ edited/fs/hpfs/hpfs_fn.h	Wed Jan  1 01:27:01 2003
@@ -162,6 +162,8 @@
 	return 0;
 }
 
+struct statfs;
+
 /* alloc.c */
 
 int hpfs_chk_sectors(struct super_block *, secno, int, char *);
===== fs/hpfs/super.c 1.23 vs edited =====
--- 1.23/fs/hpfs/super.c	Sun Nov 17 14:53:57 2002
+++ edited/fs/hpfs/super.c	Wed Jan  1 01:27:16 2003
@@ -11,6 +11,7 @@
 #include "hpfs_fn.h"
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/vfs.h>
 
 /* Mark the filesystem dirty, so that chkdsk checks it when os/2 booted */
 
===== fs/isofs/inode.c 1.29 vs edited =====
--- 1.29/fs/isofs/inode.c	Sun Nov 17 14:53:57 2002
+++ edited/fs/isofs/inode.c	Wed Jan  1 01:26:02 2003
@@ -28,7 +28,7 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
-
+#include <linux/vfs.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
===== fs/jffs/inode-v23.c 1.43 vs edited =====
--- 1.43/fs/jffs/inode-v23.c	Sat Dec 14 18:13:02 2002
+++ edited/fs/jffs/inode-v23.c	Wed Jan  1 01:25:46 2003
@@ -48,6 +48,7 @@
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
+#include <linux/vfs.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
===== fs/jffs2/fs.c 1.10 vs edited =====
--- 1.10/fs/jffs2/fs.c	Tue Nov 19 09:16:17 2002
+++ edited/fs/jffs2/fs.c	Wed Jan  1 01:25:18 2003
@@ -20,6 +20,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
+#include <linux/vfs.h>
 #include "nodelist.h"
 
 int jffs2_statfs(struct super_block *sb, struct statfs *buf)
===== fs/jffs2/os-linux.h 1.7 vs edited =====
--- 1.7/fs/jffs2/os-linux.h	Tue Nov 19 06:39:43 2002
+++ edited/fs/jffs2/os-linux.h	Wed Jan  1 01:25:05 2003
@@ -96,6 +96,7 @@
 #define jffs2_flash_write_oob(c, ofs, len, retlen, buf) ((c)->mtd->write_oob((c)->mtd, ofs, len, retlen, buf))
 #define jffs2_flash_read_oob(c, ofs, len, retlen, buf) ((c)->mtd->read_oob((c)->mtd, ofs, len, retlen, buf))
 
+struct statfs;
 
 /* wbuf.c */
 int jffs2_flash_writev(struct jffs2_sb_info *c, const struct iovec *vecs, unsigned long count, loff_t to, size_t *retlen);
===== fs/jfs/super.c 1.30 vs edited =====
--- 1.30/fs/jfs/super.c	Tue Dec 10 16:22:22 2002
+++ edited/fs/jfs/super.c	Wed Jan  1 01:24:49 2003
@@ -21,7 +21,9 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/completion.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
+
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
===== fs/minix/inode.c 1.31 vs edited =====
--- 1.31/fs/minix/inode.c	Sat Dec 14 12:42:09 2002
+++ edited/fs/minix/inode.c	Wed Jan  1 01:24:23 2003
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
+#include <linux/vfs.h>
 
 static void minix_read_inode(struct inode * inode);
 static void minix_write_inode(struct inode * inode, int wait);
===== fs/ncpfs/inode.c 1.38 vs edited =====
--- 1.38/fs/ncpfs/inode.c	Tue Nov 26 11:53:25 2002
+++ edited/fs/ncpfs/inode.c	Wed Jan  1 01:24:11 2003
@@ -28,6 +28,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/vfs.h>
 
 #include <linux/ncp_fs.h>
 
===== fs/nfs/inode.c 1.68 vs edited =====
--- 1.68/fs/nfs/inode.c	Mon Nov 18 09:29:11 2002
+++ edited/fs/nfs/inode.c	Wed Jan  1 01:23:52 2003
@@ -33,6 +33,7 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/mount.h>
+#include <linux/vfs.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== fs/nfsd/nfs3xdr.c 1.27 vs edited =====
--- 1.27/fs/nfsd/nfs3xdr.c	Thu Nov 21 19:21:21 2002
+++ edited/fs/nfsd/nfs3xdr.c	Wed Jan  1 01:23:19 2003
@@ -14,7 +14,7 @@
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
-
+#include <linux/vfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
===== fs/nfsd/nfs4xdr.c 1.6 vs edited =====
--- 1.6/fs/nfsd/nfs4xdr.c	Fri Nov 22 00:05:53 2002
+++ edited/fs/nfsd/nfs4xdr.c	Wed Jan  1 01:23:31 2003
@@ -48,7 +48,7 @@
 #include <linux/compatmac.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
-
+#include <linux/vfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/clnt.h>
===== fs/nfsd/nfsxdr.c 1.21 vs edited =====
--- 1.21/fs/nfsd/nfsxdr.c	Wed Nov 20 17:43:02 2002
+++ edited/fs/nfsd/nfsxdr.c	Wed Jan  1 01:23:09 2003
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs.h>
-
+#include <linux/vfs.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
===== fs/nfsd/vfs.c 1.53 vs edited =====
--- 1.53/fs/nfsd/vfs.c	Thu Nov 21 19:21:21 2002
+++ edited/fs/nfsd/vfs.c	Wed Jan  1 01:22:51 2003
@@ -34,7 +34,7 @@
 #include <linux/in.h>
 #include <linux/module.h>
 #include <linux/namei.h>
-
+#include <linux/vfs.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #ifdef CONFIG_NFSD_V3
===== fs/ntfs/super.c 1.121 vs edited =====
--- 1.121/fs/ntfs/super.c	Mon Oct  7 13:27:58 2002
+++ edited/fs/ntfs/super.c	Wed Jan  1 01:22:36 2003
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
--- 1.27/fs/qnx4/inode.c	Sat Dec 14 12:42:09 2002
+++ edited/fs/qnx4/inode.c	Wed Jan  1 01:22:21 2003
@@ -25,7 +25,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
-
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 
 #define QNX4_VERSION  4
===== fs/reiserfs/super.c 1.56 vs edited =====
--- 1.56/fs/reiserfs/super.c	Sat Dec  7 05:19:52 2002
+++ edited/fs/reiserfs/super.c	Wed Jan  1 01:22:00 2003
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
===== fs/smbfs/inode.c 1.36 vs edited =====
--- 1.36/fs/smbfs/inode.c	Sun Nov 17 20:12:26 2002
+++ edited/fs/smbfs/inode.c	Wed Jan  1 01:21:44 2003
@@ -24,7 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <linux/net.h>
-
+#include <linux/vfs.h>
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
 #include <linux/smb_mount.h>
===== fs/smbfs/proc.c 1.26 vs edited =====
--- 1.26/fs/smbfs/proc.c	Sun Nov 17 20:12:26 2002
+++ edited/fs/smbfs/proc.c	Wed Jan  1 01:21:27 2003
@@ -19,7 +19,7 @@
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
 #include <linux/net.h>
-
+#include <linux/vfs.h>
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
 #include <linux/smb_mount.h>
===== fs/smbfs/proto.h 1.7 vs edited =====
--- 1.7/fs/smbfs/proto.h	Mon Nov 18 07:43:51 2002
+++ edited/fs/smbfs/proto.h	Wed Jan  1 01:21:17 2003
@@ -4,6 +4,7 @@
 
 struct smb_request;
 struct sock;
+struct statfs;
 
 /* proc.c */
 extern int smb_setcodepage(struct smb_sb_info *server, struct smb_nls_codepage *cp);
===== fs/sysv/inode.c 1.24 vs edited =====
--- 1.24/fs/sysv/inode.c	Sun Nov 17 15:18:09 2002
+++ edited/fs/sysv/inode.c	Wed Jan  1 01:20:33 2003
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/byteorder.h>
 #include "sysv.h"
 
===== fs/udf/super.c 1.30 vs edited =====
--- 1.30/fs/udf/super.c	Mon Nov 18 19:49:50 2002
+++ edited/fs/udf/super.c	Wed Jan  1 01:20:22 2003
@@ -56,6 +56,7 @@
 #include <linux/nls.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 #include <asm/byteorder.h>
 
 #include <linux/udf_fs.h>
===== fs/ufs/super.c 1.32 vs edited =====
--- 1.32/fs/ufs/super.c	Sun Nov 17 15:18:08 2002
+++ edited/fs/ufs/super.c	Wed Jan  1 01:20:07 2003
@@ -81,6 +81,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/vfs.h>
 
 #include "swab.h"
 #include "util.h"
===== fs/xfs/linux/xfs_linux.h 1.10 vs edited =====
--- 1.10/fs/xfs/linux/xfs_linux.h	Wed Dec 11 14:12:09 2002
+++ edited/fs/xfs/linux/xfs_linux.h	Wed Jan  1 01:19:39 2003
@@ -42,6 +42,7 @@
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <linux/major.h>
+#include <linux/vfs.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
===== include/linux/coda_psdev.h 1.5 vs edited =====
--- 1.5/include/linux/coda_psdev.h	Wed Nov 20 06:19:02 2002
+++ edited/include/linux/coda_psdev.h	Wed Jan  1 01:17:45 2003
@@ -6,6 +6,8 @@
 
 #define CODA_SUPER_MAGIC	0x73757245
 
+struct statfs;
+
 struct coda_sb_info
 {
 	struct venus_comm * sbi_vcomm;
===== include/linux/efs_fs.h 1.7 vs edited =====
--- 1.7/include/linux/efs_fs.h	Mon Oct  7 13:27:58 2002
+++ edited/include/linux/efs_fs.h	Wed Jan  1 01:17:28 2003
@@ -49,6 +49,8 @@
 	return sb->s_fs_info;
 }
 
+struct statfs;
+
 extern struct inode_operations efs_dir_inode_operations;
 extern struct file_operations efs_dir_operations;
 extern struct address_space_operations efs_symlink_aops;
===== include/linux/ext3_fs.h 1.20 vs edited =====
--- 1.20/include/linux/ext3_fs.h	Sun Nov 17 14:00:57 2002
+++ edited/include/linux/ext3_fs.h	Wed Jan  1 01:16:59 2003
@@ -20,6 +20,9 @@
 #include <linux/ext3_fs_i.h>
 #include <linux/ext3_fs_sb.h>
 
+
+struct statfs;
+
 /*
  * The second extended filesystem constants/structures
  */
===== include/linux/fs.h 1.207 vs edited =====
--- 1.207/include/linux/fs.h	Mon Dec 30 12:39:00 2002
+++ edited/include/linux/fs.h	Tue Dec 31 23:32:48 2002
@@ -11,7 +11,6 @@
 #include <linux/limits.h>
 #include <linux/wait.h>
 #include <linux/types.h>
-#include <linux/vfs.h>
 #include <linux/kdev_t.h>
 #include <linux/ioctl.h>
 #include <linux/list.h>
@@ -25,6 +25,7 @@
 struct nameidata;
 struct pipe_inode_info;
 struct poll_table_struct;
+struct statfs;
 struct vm_area_struct;
 struct vfsmount;
 
--- 1.21/include/linux/msdos_fs.h	Sun Nov 17 14:00:17 2002
+++ edited/include/linux/msdos_fs.h	Wed Jan  1 01:16:31 2003
@@ -8,6 +8,9 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+struct statfs;
+
+
 #define SECTOR_SIZE	512		/* sector size (bytes) */
 #define SECTOR_BITS	9		/* log2(SECTOR_SIZE) */
 #define MSDOS_DPB	(MSDOS_DPS)	/* dir entries per block */
===== include/linux/nfsd/xdr.h 1.7 vs edited =====
--- 1.7/include/linux/nfsd/xdr.h	Wed Nov  6 18:12:49 2002
+++ edited/include/linux/nfsd/xdr.h	Wed Jan  1 01:47:03 2003
@@ -8,6 +8,7 @@
 #define LINUX_NFSD_H
 
 #include <linux/fs.h>
+#include <linux/vfs.h>
 #include <linux/nfs.h>
 
 struct nfsd_fhandle {
--- 1.15/kernel/acct.c	Wed Nov 27 18:13:29 2002
+++ edited/kernel/acct.c	Wed Jan  1 01:15:55 2003
@@ -50,6 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <linux/security.h>
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 
 /*
===== mm/shmem.c 1.103 vs edited =====
--- 1.103/mm/shmem.c	Sat Dec 14 12:42:09 2002
+++ edited/mm/shmem.c	Wed Jan  1 00:06:12 2003
@@ -32,7 +32,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/mount.h>
 #include <linux/writeback.h>
-
+#include <linux/vfs.h>
 #include <asm/uaccess.h>
 
 /* This magic number is used in glibc for posix shared memory */
