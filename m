Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbSKPVhw>; Sat, 16 Nov 2002 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSKPVhw>; Sat, 16 Nov 2002 16:37:52 -0500
Received: from verein.lst.de ([212.34.181.86]:16655 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267372AbSKPVgz>;
	Sat, 16 Nov 2002 16:36:55 -0500
Date: Sat, 16 Nov 2002 22:43:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include mount.h explicitly were needed
Message-ID: <20021116224348.B26097@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to get rid of the implicit includes in
dcache.h and fs_struct.h.


===== fs/binfmt_misc.c 1.16 vs edited =====
--- 1.16/fs/binfmt_misc.c	Tue Sep 24 18:09:20 2002
+++ edited/fs/binfmt_misc.c	Sat Nov 16 21:13:10 2002
@@ -25,6 +25,7 @@
 #include <linux/file.h>
 #include <linux/pagemap.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 
===== fs/block_dev.c 1.110 vs edited =====
--- 1.110/fs/block_dev.c	Sun Nov 10 19:35:26 2002
+++ edited/fs/block_dev.c	Sat Nov 16 20:41:20 2002
@@ -20,6 +20,7 @@
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 
===== fs/dcache.c 1.35 vs edited =====
--- 1.35/fs/dcache.c	Thu Nov 14 18:56:33 2002
+++ edited/fs/dcache.c	Sat Nov 16 20:43:55 2002
@@ -23,7 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/cache.h>
 #include <linux/module.h>
-
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 #define DCACHE_PARANOIA 1
===== fs/eventpoll.c 1.7 vs edited =====
--- 1.7/fs/eventpoll.c	Thu Nov 14 07:11:33 2002
+++ edited/fs/eventpoll.c	Sat Nov 16 20:45:27 2002
@@ -29,13 +29,14 @@
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/eventpoll.h>
+#include <linux/mount.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/mman.h>
 #include <asm/atomic.h>
-#include <linux/eventpoll.h>
 
 
 
===== fs/exec.c 1.55 vs edited =====
--- 1.55/fs/exec.c	Fri Nov  8 05:38:16 2002
+++ edited/fs/exec.c	Sat Nov 16 20:42:05 2002
@@ -43,6 +43,7 @@
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
===== fs/file_table.c 1.18 vs edited =====
--- 1.18/fs/file_table.c	Thu Nov 14 07:02:54 2002
+++ edited/fs/file_table.c	Sat Nov 16 20:40:07 2002
@@ -14,6 +14,8 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
+#include <linux/mount.h>
+
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {0, 0, NR_FILE};
===== fs/namei.c 1.57 vs edited =====
--- 1.57/fs/namei.c	Thu Oct 31 02:28:40 2002
+++ edited/fs/namei.c	Sat Nov 16 20:43:09 2002
@@ -24,7 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
-
+#include <linux/mount.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
===== fs/namespace.c 1.30 vs edited =====
--- 1.30/fs/namespace.c	Sun Nov 10 18:03:21 2002
+++ edited/fs/namespace.c	Sat Nov 16 20:44:27 2002
@@ -19,7 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
-
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 extern struct vfsmount *do_kern_mount(const char *type, int flags, char *name, void *data);
===== fs/nfsctl.c 1.3 vs edited =====
--- 1.3/fs/nfsctl.c	Wed May 22 11:48:12 2002
+++ edited/fs/nfsctl.c	Sat Nov 16 20:46:31 2002
@@ -12,6 +12,7 @@
 #include <linux/nfsd/syscall.h>
 #include <linux/linkage.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 /*
===== fs/open.c 1.29 vs edited =====
--- 1.29/fs/open.c	Mon Oct 28 13:34:30 2002
+++ edited/fs/open.c	Sat Nov 16 20:39:59 2002
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
 #include <linux/security.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 
===== fs/pipe.c 1.22 vs edited =====
--- 1.22/fs/pipe.c	Sun Nov  3 14:49:39 2002
+++ edited/fs/pipe.c	Sat Nov 16 20:42:38 2002
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
===== fs/super.c 1.84 vs edited =====
--- 1.84/fs/super.c	Mon Oct 28 14:57:58 2002
+++ edited/fs/super.c	Sat Nov 16 20:40:24 2002
@@ -28,6 +28,7 @@
 #include <linux/quotaops.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>		/* for fsync_super() */
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 #include <linux/security.h>
===== fs/autofs4/expire.c 1.3 vs edited =====
--- 1.3/fs/autofs4/expire.c	Tue Feb  5 02:41:04 2002
+++ edited/fs/autofs4/expire.c	Sat Nov 16 20:47:42 2002
@@ -12,6 +12,7 @@
  * ------------------------------------------------------------------------- */
 
 #include "autofs_i.h"
+#include <linux/mount.h>
 
 /*
  * Determine if a subtree of the namespace is busy.
===== fs/devpts/inode.c 1.13 vs edited =====
--- 1.13/fs/devpts/inode.c	Sat Sep 28 11:36:22 2002
+++ edited/fs/devpts/inode.c	Sat Nov 16 20:48:51 2002
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
===== fs/fat/inode.c 1.55 vs edited =====
--- 1.55/fs/fat/inode.c	Tue Nov  5 10:36:01 2002
+++ edited/fs/fat/inode.c	Sat Nov 16 20:50:35 2002
@@ -18,6 +18,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
+#include <linux/mount.h>
 #include <asm/unaligned.h>
 
 /*
===== fs/nfs/inode.c 1.65 vs edited =====
--- 1.65/fs/nfs/inode.c	Fri Nov  8 21:00:27 2002
+++ edited/fs/nfs/inode.c	Sat Nov 16 20:53:41 2002
@@ -32,6 +32,7 @@
 #include <linux/lockd/bind.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/mount.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== fs/nfsd/nfsfh.c 1.37 vs edited =====
--- 1.37/fs/nfsd/nfsfh.c	Thu Oct 10 22:00:11 2002
+++ edited/fs/nfsd/nfsfh.c	Sat Nov 16 20:56:20 2002
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/dcache.h>
+#include <linux/mount.h>
 #include <asm/pgtable.h>
 
 #include <linux/sunrpc/svc.h>
===== fs/proc/base.c 1.32 vs edited =====
--- 1.32/fs/proc/base.c	Wed Oct 30 23:09:21 2002
+++ edited/fs/proc/base.c	Sat Nov 16 20:59:38 2002
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/kallsyms.h>
+#include <linux/mount.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
===== fs/proc/generic.c 1.17 vs edited =====
--- 1.17/fs/proc/generic.c	Thu Oct 10 13:48:10 2002
+++ edited/fs/proc/generic.c	Sat Nov 16 21:00:38 2002
@@ -8,15 +8,14 @@
  * Copyright (C) 1997 Theodore Ts'o
  */
 
-#include <asm/uaccess.h>
-
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
-#define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/smp_lock.h>
+#include <asm/uaccess.h>
 #include <asm/bitops.h>
 
 static ssize_t proc_file_read(struct file * file, char * buf,
===== fs/sysfs/inode.c 1.59 vs edited =====
--- 1.59/fs/sysfs/inode.c	Wed Oct 30 15:27:35 2002
+++ edited/fs/sysfs/inode.c	Sat Nov 16 21:01:34 2002
@@ -34,7 +34,7 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/kobject.h>
-
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 /* Random magic number */
===== fs/sysv/itree.c 1.15 vs edited =====
--- 1.15/fs/sysv/itree.c	Tue Oct  8 14:40:47 2002
+++ edited/fs/sysv/itree.c	Sat Nov 16 20:18:12 2002
@@ -6,6 +6,7 @@
  */
 
 #include <linux/buffer_head.h>
+#include <linux/mount.h>
 #include "sysv.h"
 
 enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
===== fs/xfs/linux/xfs_ioctl.c 1.4 vs edited =====
--- 1.4/fs/xfs/linux/xfs_ioctl.c	Mon Oct 14 17:06:32 2002
+++ edited/fs/xfs/linux/xfs_ioctl.c	Sat Nov 16 21:30:05 2002
@@ -35,6 +35,7 @@
 #include <xfs_dfrag.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 
 
 extern int xfs_change_file_space(bhv_desc_t *, int,
===== fs/xfs/linux/xfs_super.c 1.16 vs edited =====
--- 1.16/fs/xfs/linux/xfs_super.c	Wed Nov  6 15:33:29 2002
+++ edited/fs/xfs/linux/xfs_super.c	Sat Nov 16 21:09:43 2002
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/ctype.h>
 #include <linux/seq_file.h>
+#include <linux/mount.h>
 #include "xfs_version.h"
 
 /* xfs_vfs[ops].c */
===== init/do_mounts.c 1.30 vs edited =====
--- 1.30/init/do_mounts.c	Thu Nov 14 21:06:59 2002
+++ edited/init/do_mounts.c	Sat Nov 16 20:21:21 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
+#include <linux/mount.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
===== kernel/exit.c 1.73 vs edited =====
--- 1.73/kernel/exit.c	Thu Oct 17 03:48:55 2002
+++ edited/kernel/exit.c	Sat Nov 16 20:26:59 2002
@@ -20,6 +20,7 @@
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
 #include <linux/profile.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
===== kernel/futex.c 1.18 vs edited =====
--- 1.18/kernel/futex.c	Tue Oct 15 15:41:06 2002
+++ edited/kernel/futex.c	Sat Nov 16 20:27:28 2002
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/futex.h>
 #include <linux/vcache.h>
+#include <linux/mount.h>
 
 #define FUTEX_HASHBITS 8
 
===== kernel/kmod.c 1.16 vs edited =====
--- 1.16/kernel/kmod.c	Fri Nov  8 23:08:33 2002
+++ edited/kernel/kmod.c	Sat Nov 16 20:27:15 2002
@@ -29,7 +29,7 @@
 #include <linux/completion.h>
 #include <linux/file.h>
 #include <linux/workqueue.h>
-
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 extern int max_threads, system_running;
===== kernel/ksyms.c 1.162 vs edited =====
--- 1.162/kernel/ksyms.c	Fri Nov 15 18:09:46 2002
+++ edited/kernel/ksyms.c	Sat Nov 16 20:29:58 2002
@@ -53,6 +53,7 @@
 #include <linux/percpu.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/mount.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
===== mm/shmem.c 1.98 vs edited =====
--- 1.98/mm/shmem.c	Sat Nov  9 04:49:52 2002
+++ edited/mm/shmem.c	Sat Nov 16 20:35:17 2002
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/shmem_fs.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 
===== net/socket.c 1.35 vs edited =====
--- 1.35/net/socket.c	Thu Nov 14 09:48:50 2002
+++ edited/net/socket.c	Sat Nov 16 21:23:48 2002
@@ -77,6 +77,7 @@
 #include <linux/highmem.h>
 #include <linux/wireless.h>
 #include <linux/divert.h>
+#include <linux/mount.h>
 
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
===== net/unix/af_unix.c 1.30 vs edited =====
--- 1.30/net/unix/af_unix.c	Mon Nov 11 12:07:58 2002
+++ edited/net/unix/af_unix.c	Sat Nov 16 21:29:35 2002
@@ -112,6 +112,7 @@
 #include <linux/poll.h>
 #include <linux/smp_lock.h>
 #include <linux/rtnetlink.h>
+#include <linux/mount.h>
 #include <net/checksum.h>
 
 int sysctl_unix_max_dgram_qlen = 10;
