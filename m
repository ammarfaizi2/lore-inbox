Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752600AbWAHFvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbWAHFvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbWAHFvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:51:20 -0500
Received: from xenotime.net ([66.160.160.81]:56266 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752600AbWAHFvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:51:19 -0500
Date: Sat, 7 Jan 2006 21:51:15 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 2/4] capable/capability.h (fs/)
Message-Id: <20060107215115.7e6cb2a2.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

fs: Use <linux/capability.h> where capable() is used.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/attr.c                      |    1 +
 fs/autofs/root.c               |    1 +
 fs/autofs4/root.c              |    1 +
 fs/buffer.c                    |    1 +
 fs/compat_ioctl.c              |    1 +
 fs/dcookies.c                  |    1 +
 fs/dquot.c                     |    1 +
 fs/ext2/acl.c                  |    1 +
 fs/ext2/balloc.c               |    1 +
 fs/ext2/ioctl.c                |    1 +
 fs/ext2/xattr_trusted.c        |    1 +
 fs/ext3/acl.c                  |    1 +
 fs/ext3/balloc.c               |    1 +
 fs/ext3/ioctl.c                |    1 +
 fs/ext3/xattr_trusted.c        |    1 +
 fs/fat/file.c                  |    1 +
 fs/fcntl.c                     |    1 +
 fs/file_table.c                |    1 +
 fs/hfsplus/ioctl.c             |    1 +
 fs/hugetlbfs/inode.c           |    1 +
 fs/ioctl.c                     |    1 +
 fs/ioprio.c                    |    1 +
 fs/jffs2/fs.c                  |    1 +
 fs/jfs/xattr.c                 |    1 +
 fs/namei.c                     |    1 +
 fs/namespace.c                 |    1 +
 fs/ncpfs/ioctl.c               |    1 +
 fs/ocfs2/file.c                |    1 +
 fs/open.c                      |    1 +
 fs/proc/base.c                 |    1 +
 fs/proc/kcore.c                |    1 +
 fs/quota.c                     |    1 +
 fs/reiserfs/ioctl.c            |    1 +
 fs/reiserfs/xattr.c            |    1 +
 fs/reiserfs/xattr_acl.c        |    1 +
 fs/reiserfs/xattr_trusted.c    |    1 +
 fs/smbfs/proc.c                |    1 +
 fs/sysfs/inode.c               |    1 +
 fs/udf/file.c                  |    1 +
 fs/ufs/balloc.c                |    1 +
 fs/xfs/linux-2.6/xfs_ioctl.c   |    1 +
 fs/xfs/linux-2.6/xfs_iops.c    |    1 +
 fs/xfs/quota/xfs_qm_syscalls.c |    3 +++
 fs/xfs/xfs_acl.c               |    1 +
 fs/xfs/xfs_attr.c              |    3 +++
 fs/xfs/xfs_vnodeops.c          |    3 +++
 46 files changed, 52 insertions(+)

--- linux-2615-g3.orig/fs/attr.c
+++ linux-2615-g3/fs/attr.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/capability.h>
 #include <linux/fsnotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
--- linux-2615-g3.orig/fs/autofs/root.c
+++ linux-2615-g3/fs/autofs/root.c
@@ -10,6 +10,7 @@
  *
  * ------------------------------------------------------------------------- */
 
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/stat.h>
 #include <linux/param.h>
--- linux-2615-g3.orig/fs/autofs4/root.c
+++ linux-2615-g3/fs/autofs4/root.c
@@ -12,6 +12,7 @@
  *
  * ------------------------------------------------------------------------- */
 
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/stat.h>
 #include <linux/param.h>
--- linux-2615-g3.orig/fs/buffer.c
+++ linux-2615-g3/fs/buffer.c
@@ -26,6 +26,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/capability.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/quotaops.h>
--- linux-2615-g3.orig/fs/compat_ioctl.c
+++ linux-2615-g3/fs/compat_ioctl.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
+#include <linux/capability.h>
 #include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
--- linux-2615-g3.orig/fs/dcookies.c
+++ linux-2615-g3/fs/dcookies.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/mount.h>
+#include <linux/capability.h>
 #include <linux/dcache.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
--- linux-2615-g3.orig/fs/dquot.c
+++ linux-2615-g3/fs/dquot.c
@@ -77,6 +77,7 @@
 #include <linux/kmod.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>
+#include <linux/capability.h>
 #include <linux/quotaops.h>
 
 #include <asm/uaccess.h>
--- linux-2615-g3.orig/fs/fcntl.c
+++ linux-2615-g3/fs/fcntl.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/capability.h>
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
--- linux-2615-g3.orig/fs/file_table.c
+++ linux-2615-g3/fs/file_table.c
@@ -16,6 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/rcupdate.h>
 #include <linux/mount.h>
+#include <linux/capability.h>
 #include <linux/cdev.h>
 #include <linux/fsnotify.h>
 
--- linux-2615-g3.orig/fs/ioctl.c
+++ linux-2615-g3/fs/ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
--- linux-2615-g3.orig/fs/ioprio.c
+++ linux-2615-g3/fs/ioprio.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/ioprio.h>
 #include <linux/blkdev.h>
+#include <linux/capability.h>
 #include <linux/syscalls.h>
 
 static int set_task_ioprio(struct task_struct *task, int ioprio)
--- linux-2615-g3.orig/fs/namei.c
+++ linux-2615-g3/fs/namei.c
@@ -28,6 +28,7 @@
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/capability.h>
 #include <linux/file.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
--- linux-2615-g3.orig/fs/namespace.c
+++ linux-2615-g3/fs/namespace.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/quotaops.h>
 #include <linux/acct.h>
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
--- linux-2615-g3.orig/fs/open.c
+++ linux-2615-g3/fs/open.c
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include <linux/capability.h>
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
--- linux-2615-g3.orig/fs/quota.c
+++ linux-2615-g3/fs/quota.c
@@ -15,6 +15,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/buffer_head.h>
+#include <linux/capability.h>
 #include <linux/quotaops.h>
 
 /* Check validity of generic quotactl commands */
--- linux-2615-g3.orig/fs/fat/file.c
+++ linux-2615-g3/fs/fat/file.c
@@ -6,6 +6,7 @@
  *  regular file handling primitives for fat-based filesystems
  */
 
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
--- linux-2615-g3.orig/fs/hfsplus/ioctl.c
+++ linux-2615-g3/fs/hfsplus/ioctl.c
@@ -12,6 +12,7 @@
  * hfsplus ioctls
  */
 
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/xattr.h>
--- linux-2615-g3.orig/fs/hugetlbfs/inode.c
+++ linux-2615-g3/fs/hugetlbfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/capability.h>
 #include <linux/backing-dev.h>
 #include <linux/hugetlb.h>
 #include <linux/pagevec.h>
--- linux-2615-g3.orig/fs/jffs2/fs.c
+++ linux-2615-g3/fs/jffs2/fs.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/capability.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2615-g3.orig/fs/jfs/xattr.c
+++ linux-2615-g3/fs/jfs/xattr.c
@@ -17,6 +17,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/posix_acl_xattr.h>
--- linux-2615-g3.orig/fs/ncpfs/ioctl.c
+++ linux-2615-g3/fs/ncpfs/ioctl.c
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 
 #include <asm/uaccess.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
--- linux-2615-g3.orig/fs/proc/base.c
+++ linux-2615-g3/fs/proc/base.c
@@ -55,6 +55,7 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
+#include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
--- linux-2615-g3.orig/fs/proc/kcore.c
+++ linux-2615-g3/fs/proc/kcore.c
@@ -14,6 +14,7 @@
 #include <linux/proc_fs.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
+#include <linux/capability.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/vmalloc.h>
--- linux-2615-g3.orig/fs/reiserfs/ioctl.c
+++ linux-2615-g3/fs/reiserfs/ioctl.c
@@ -2,6 +2,7 @@
  * Copyright 2000 by Hans Reiser, licensing governed by reiserfs/README
  */
 
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/time.h>
--- linux-2615-g3.orig/fs/reiserfs/xattr.c
+++ linux-2615-g3/fs/reiserfs/xattr.c
@@ -30,6 +30,7 @@
  */
 
 #include <linux/reiserfs_fs.h>
+#include <linux/capability.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/errno.h>
--- linux-2615-g3.orig/fs/reiserfs/xattr_acl.c
+++ linux-2615-g3/fs/reiserfs/xattr_acl.c
@@ -1,3 +1,4 @@
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/posix_acl.h>
 #include <linux/reiserfs_fs.h>
--- linux-2615-g3.orig/fs/reiserfs/xattr_trusted.c
+++ linux-2615-g3/fs/reiserfs/xattr_trusted.c
@@ -1,4 +1,5 @@
 #include <linux/reiserfs_fs.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
--- linux-2615-g3.orig/fs/smbfs/proc.c
+++ linux-2615-g3/fs/smbfs/proc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
--- linux-2615-g3.orig/fs/sysfs/inode.c
+++ linux-2615-g3/fs/sysfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include <linux/capability.h>
 #include "sysfs.h"
 
 extern struct super_block * sysfs_sb;
--- linux-2615-g3.orig/fs/udf/file.c
+++ linux-2615-g3/fs/udf/file.c
@@ -31,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/string.h> /* memset */
+#include <linux/capability.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
--- linux-2615-g3.orig/fs/ocfs2/file.c
+++ linux-2615-g3/fs/ocfs2/file.c
@@ -23,6 +23,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/slab.h>
--- linux-2615-g3.orig/fs/ufs/balloc.c
+++ linux-2615-g3/fs/ufs/balloc.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
+#include <linux/capability.h>
 #include <linux/sched.h>
 #include <linux/bitops.h>
 #include <asm/byteorder.h>
--- linux-2615-g3.orig/fs/xfs/xfs_acl.c
+++ linux-2615-g3/fs/xfs/xfs_acl.c
@@ -36,6 +36,7 @@
 #include "xfs_mac.h"
 #include "xfs_attr.h"
 
+#include <linux/capability.h>
 #include <linux/posix_acl_xattr.h>
 
 STATIC int	xfs_acl_setmode(vnode_t *, xfs_acl_t *, int *);
--- linux-2615-g3.orig/fs/xfs/xfs_attr.c
+++ linux-2615-g3/fs/xfs/xfs_attr.c
@@ -15,6 +15,9 @@
  * along with this program; if not, write the Free Software Foundation,
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+
+#include <linux/capability.h>
+
 #include "xfs.h"
 #include "xfs_fs.h"
 #include "xfs_types.h"
--- linux-2615-g3.orig/fs/xfs/xfs_vnodeops.c
+++ linux-2615-g3/fs/xfs/xfs_vnodeops.c
@@ -15,6 +15,9 @@
  * along with this program; if not, write the Free Software Foundation,
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+
+#include <linux/capability.h>
+
 #include "xfs.h"
 #include "xfs_fs.h"
 #include "xfs_types.h"
--- linux-2615-g3.orig/fs/xfs/quota/xfs_qm_syscalls.c
+++ linux-2615-g3/fs/xfs/quota/xfs_qm_syscalls.c
@@ -15,6 +15,9 @@
  * along with this program; if not, write the Free Software Foundation,
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
+
+#include <linux/capability.h>
+
 #include "xfs.h"
 #include "xfs_fs.h"
 #include "xfs_bit.h"
--- linux-2615-g3.orig/fs/xfs/linux-2.6/xfs_ioctl.c
+++ linux-2615-g3/fs/xfs/linux-2.6/xfs_ioctl.c
@@ -52,6 +52,7 @@
 #include "xfs_dfrag.h"
 #include "xfs_fsops.h"
 
+#include <linux/capability.h>
 #include <linux/dcache.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
--- linux-2615-g3.orig/fs/xfs/linux-2.6/xfs_iops.c
+++ linux-2615-g3/fs/xfs/linux-2.6/xfs_iops.c
@@ -51,6 +51,7 @@
 #include "xfs_buf_item.h"
 #include "xfs_utils.h"
 
+#include <linux/capability.h>
 #include <linux/xattr.h>
 #include <linux/namei.h>
 
--- linux-2615-g3.orig/fs/ext2/acl.c
+++ linux-2615-g3/fs/ext2/acl.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001-2003 Andreas Gruenbacher, <agruen@suse.de>
  */
 
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
--- linux-2615-g3.orig/fs/ext2/balloc.c
+++ linux-2615-g3/fs/ext2/balloc.c
@@ -16,6 +16,7 @@
 #include <linux/quotaops.h>
 #include <linux/sched.h>
 #include <linux/buffer_head.h>
+#include <linux/capability.h>
 
 /*
  * balloc.c contains the blocks allocation and deallocation routines
--- linux-2615-g3.orig/fs/ext2/ioctl.c
+++ linux-2615-g3/fs/ext2/ioctl.c
@@ -8,6 +8,7 @@
  */
 
 #include "ext2.h"
+#include <linux/capability.h>
 #include <linux/time.h>
 #include <linux/sched.h>
 #include <asm/current.h>
--- linux-2615-g3.orig/fs/ext2/xattr_trusted.c
+++ linux-2615-g3/fs/ext2/xattr_trusted.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/ext2_fs.h>
--- linux-2615-g3.orig/fs/ext3/acl.c
+++ linux-2615-g3/fs/ext3/acl.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/ext3_fs.h>
--- linux-2615-g3.orig/fs/ext3/balloc.c
+++ linux-2615-g3/fs/ext3/balloc.c
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/time.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
--- linux-2615-g3.orig/fs/ext3/ioctl.c
+++ linux-2615-g3/fs/ext3/ioctl.c
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/jbd.h>
+#include <linux/capability.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/time.h>
--- linux-2615-g3.orig/fs/ext3/xattr_trusted.c
+++ linux-2615-g3/fs/ext3/xattr_trusted.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/ext3_jbd.h>


---
