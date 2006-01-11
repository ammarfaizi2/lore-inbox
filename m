Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWAKBbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWAKBbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWAKBbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:31:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47116 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932761AbWAKBbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:31:13 -0500
Date: Wed, 11 Jan 2006 02:31:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060111013111.GD29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following changes:

Adrian Bunk:
      MAINTAINERS: sh: update the mailing list
      drivers/net/gianfar_sysfs.c: update email address of Kumar Gala

Jesper Juhl:
      Tiny esthetic changes to Documentation/laptop-mode.txt
      add missing printk loglevel in mm/swapfile.c
      missing printk loglevel and tiny tiny whitespace change in binfmt_elf()
      add loglevel to printk in fs/afs/cmservice.c

Luiz Fernando Capitulino:
      ext2: trivial indentation fix.

Nicolas Kaiser:
      netfilter: headers included twice
      xfs: header included twice
      asm-powerpc: header included twice
      fs/attr.c: header included twice
      fs/proc/vmcore.c: header included twice

Paul Jackson:
      cpuset two little doc fixes



 Documentation/cpusets.txt                    |    4 ++--
 Documentation/laptop-mode.txt                |    6 +++---
 MAINTAINERS                                  |    2 +-
 drivers/net/gianfar_sysfs.c                  |    2 +-
 fs/afs/cmservice.c                           |    2 +-
 fs/attr.c                                    |    1 -
 fs/binfmt_elf.c                              |    8 ++++----
 fs/ext2/dir.c                                |    2 +-
 fs/proc/vmcore.c                             |    1 -
 fs/xfs/xfs_iomap.c                           |    1 -
 include/asm-powerpc/elf.h                    |    1 -
 mm/swapfile.c                                |    2 +-
 net/decnet/netfilter/dn_rtmsg.c              |    2 --
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |    1 -
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c  |    1 -
 net/ipv4/netfilter/ip_conntrack_proto_udp.c  |    1 -
 16 files changed, 14 insertions(+), 23 deletions(-)


diff --git a/Documentation/cpusets.txt b/Documentation/cpusets.txt
index 9e49b1c..990998e 100644
--- a/Documentation/cpusets.txt
+++ b/Documentation/cpusets.txt
@@ -135,7 +135,7 @@ Cpusets extends these two mechanisms as 
 The implementation of cpusets requires a few, simple hooks
 into the rest of the kernel, none in performance critical paths:
 
- - in main/init.c, to initialize the root cpuset at system boot.
+ - in init/main.c, to initialize the root cpuset at system boot.
  - in fork and exit, to attach and detach a task from its cpuset.
  - in sched_setaffinity, to mask the requested CPUs by what's
    allowed in that tasks cpuset.
@@ -146,7 +146,7 @@ into the rest of the kernel, none in per
    and related changes in both sched.c and arch/ia64/kernel/domain.c
  - in the mbind and set_mempolicy system calls, to mask the requested
    Memory Nodes by what's allowed in that tasks cpuset.
- - in page_alloc, to restrict memory to allowed nodes.
+ - in page_alloc.c, to restrict memory to allowed nodes.
  - in vmscan.c, to restrict page recovery to the current cpuset.
 
 In addition a new file system, of type "cpuset" may be mounted,
diff --git a/Documentation/laptop-mode.txt b/Documentation/laptop-mode.txt
index dc4e810..f42e4c0 100644
--- a/Documentation/laptop-mode.txt
+++ b/Documentation/laptop-mode.txt
@@ -3,7 +3,7 @@ How to conserve battery power using lapt
 
 Document Author: Bart Samwel (bart@samwel.tk)
 Date created: January 2, 2004
-Last modified: July 10, 2004
+Last modified: December 06, 2004
 
 Introduction
 ------------
@@ -33,7 +33,7 @@ or anything. Simply install all the file
 laptop mode will automatically be started when you're on battery. For
 your convenience, a tarball containing an installer can be downloaded at:
 
-http://www.xs4all.nl/~bsamwel/laptop_mode/tools
+http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
 
 To configure laptop mode, you need to edit the configuration file, which is
 located in /etc/default/laptop-mode on Debian-based systems, or in
@@ -912,7 +912,7 @@ void usage()
     exit(0);
 }
 
-int main(int ac, char **av)
+int main(int argc, char **argv)
 {
     int fd;
     char *disk = 0;
diff --git a/MAINTAINERS b/MAINTAINERS
index 090e10b..b6416a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2487,7 +2487,7 @@ P:	Paul Mundt
 M:	lethal@linux-sh.org
 P:	Kazumoto Kojima
 M:	kkojima@rr.iij4u.or.jp
-L:	linux-sh@m17n.org
+L:	linuxsh-dev@lists.sourceforge.net
 W:	http://www.linux-sh.org
 W:	http://www.m17n.org/linux-sh/
 W:	http://www.rr.iij4u.or.jp/~kkojima/linux-sh4.html
diff --git a/drivers/net/gianfar_sysfs.c b/drivers/net/gianfar_sysfs.c
index 10d34cb..51ef181 100644
--- a/drivers/net/gianfar_sysfs.c
+++ b/drivers/net/gianfar_sysfs.c
@@ -7,7 +7,7 @@
  * Based on 8260_io/fcc_enet.c
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala (galak@kernel.crashing.org)
  *
  * Copyright (c) 2002-2005 Freescale Semiconductor, Inc.
  *
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 0a57fd7..9eef6bf 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -118,7 +118,7 @@ static int kafscmd(void *arg)
 	_SRXAFSCM_xxxx_t func;
 	int die;
 
-	printk("kAFS: Started kafscmd %d\n", current->pid);
+	printk(KERN_INFO "kAFS: Started kafscmd %d\n", current->pid);
 
 	daemonize("kafscmd");
 
diff --git a/fs/attr.c b/fs/attr.c
index b347325..d63e509 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -14,7 +14,6 @@
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
-#include <linux/time.h>
 
 /* Taken over from the old code... */
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a4f6f57..f979ebb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1634,17 +1634,17 @@ static int elf_core_dump(long signr, str
 	ELF_CORE_WRITE_EXTRA_DATA;
 #endif
 
-	if ((off_t) file->f_pos != offset) {
+	if ((off_t)file->f_pos != offset) {
 		/* Sanity check */
-		printk("elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
-		       (off_t) file->f_pos, offset);
+		printk(KERN_WARNING "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
+		       (off_t)file->f_pos, offset);
 	}
 
 end_coredump:
 	set_fs(fs);
 
 cleanup:
-	while(!list_empty(&thread_list)) {
+	while (!list_empty(&thread_list)) {
 		struct list_head *tmp = thread_list.next;
 		list_del(tmp);
 		kfree(list_entry(tmp, struct elf_thread_status, list));
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 5b5f528..7442bdd 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -592,7 +592,7 @@ int ext2_make_empty(struct inode *inode,
 		goto fail;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
-       memset(kaddr, 0, chunk_size);
+	memset(kaddr, 0, chunk_size);
 	de = (struct ext2_dir_entry_2 *)kaddr;
 	de->name_len = 1;
 	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(1));
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 5378d7c..124e354 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -14,7 +14,6 @@
 #include <linux/a.out.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
-#include <linux/proc_fs.h>
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
 #include <linux/init.h>
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 45a77a3..ca7afc8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -40,7 +40,6 @@
 #include "xfs_ialloc.h"
 #include "xfs_btree.h"
 #include "xfs_bmap.h"
-#include "xfs_bit.h"
 #include "xfs_rtalloc.h"
 #include "xfs_error.h"
 #include "xfs_itable.h"
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index c5a635d..45f2af6 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -92,7 +92,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <asm/ptrace.h>
 
 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
 #define ELF_NFPREG	33	/* includes fpscr */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6544565..d8a5afc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1442,7 +1442,7 @@ asmlinkage long sys_swapon(const char __
 	else if (!memcmp("SWAPSPACE2",swap_header->magic.magic,10))
 		swap_header_version = 2;
 	else {
-		printk("Unable to find swap-space signature\n");
+		printk(KERN_ERR "Unable to find swap-space signature\n");
 		error = -EINVAL;
 		goto bad_swap;
 	}
diff --git a/net/decnet/netfilter/dn_rtmsg.c b/net/decnet/netfilter/dn_rtmsg.c
index 1ab94c6..16a5a31 100644
--- a/net/decnet/netfilter/dn_rtmsg.c
+++ b/net/decnet/netfilter/dn_rtmsg.c
@@ -26,8 +26,6 @@
 #include <net/dn.h>
 #include <net/dn_route.h>
 
-#include <linux/netfilter_decnet.h>
-
 static struct sock *dnrmg = NULL;
 
 
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c b/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
index f2a90e2..3021af0 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
@@ -16,7 +16,6 @@
 #include <linux/skbuff.h>
 #include <net/ip.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
index ea2b39c..e0dc370 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -32,7 +32,6 @@
 
 #include <net/tcp.h>
 
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_udp.c b/net/ipv4/netfilter/ip_conntrack_proto_udp.c
index 004003f..55b7d32 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_udp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_udp.c
@@ -15,7 +15,6 @@
 #include <linux/udp.h>
 #include <linux/seq_file.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
 

