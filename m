Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTAXAcP>; Thu, 23 Jan 2003 19:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTAXAcP>; Thu, 23 Jan 2003 19:32:15 -0500
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:19980 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id <S267421AbTAXAcL>; Thu, 23 Jan 2003 19:32:11 -0500
Date: Thu, 23 Jan 2003 16:41:20 -0800 (PST)
From: Lamont Granquist <lamont@scriptkiddie.org>
X-X-Sender: lamont@uswest-dsl-142-38.cortland.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4.20] dead code: remove /proc/sys/vm/kswapd
In-Reply-To: <001901c2c30b$775263e0$0200a8c0@wsl3>
Message-ID: <20030123163816.G62371-100000@uswest-dsl-142-38.cortland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/proc/sys/vm/kswapd does nothing to affect kswapd behavior in 2.4.20, this
patch will remove it.

diff -urN linux-2.4.20/arch/arm/mm/init.c linux-2.4.20-modified/arch/arm/mm/init.c
--- linux-2.4.20/arch/arm/mm/init.c	Thu Oct 11 09:04:57 2001
+++ linux-2.4.20-modified/arch/arm/mm/init.c	Thu Jan 23 15:59:23 2003
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -urN linux-2.4.20/arch/mips/mm/init.c linux-2.4.20-modified/arch/mips/mm/init.c
--- linux-2.4.20/arch/mips/mm/init.c	Thu Nov 28 15:53:10 2002
+++ linux-2.4.20-modified/arch/mips/mm/init.c	Thu Jan 23 15:58:59 2003
@@ -24,7 +24,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/blk.h>

 #include <asm/bootinfo.h>
diff -urN linux-2.4.20/arch/mips64/mm/init.c linux-2.4.20-modified/arch/mips64/mm/init.c
--- linux-2.4.20/arch/mips64/mm/init.c	Thu Nov 28 15:53:10 2002
+++ linux-2.4.20-modified/arch/mips64/mm/init.c	Thu Jan 23 15:59:32 2003
@@ -21,7 +21,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -urN linux-2.4.20/arch/sparc/mm/init.c linux-2.4.20-modified/arch/sparc/mm/init.c
--- linux-2.4.20/arch/sparc/mm/init.c	Thu Nov 28 15:53:12 2002
+++ linux-2.4.20-modified/arch/sparc/mm/init.c	Thu Jan 23 15:58:48 2003
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -urN linux-2.4.20/arch/sparc64/mm/init.c linux-2.4.20-modified/arch/sparc64/mm/init.c
--- linux-2.4.20/arch/sparc64/mm/init.c	Thu Nov 28 15:53:12 2002
+++ linux-2.4.20-modified/arch/sparc64/mm/init.c	Thu Jan 23 15:59:12 2003
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/blk.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
diff -urN linux-2.4.20/fs/buffer.c linux-2.4.20-modified/fs/buffer.c
--- linux-2.4.20/fs/buffer.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/fs/buffer.c	Thu Jan 23 15:56:36 2003
@@ -35,7 +35,6 @@
 #include <linux/locks.h>
 #include <linux/errno.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
diff -urN linux-2.4.20/fs/coda/sysctl.c linux-2.4.20-modified/fs/coda/sysctl.c
--- linux-2.4.20/fs/coda/sysctl.c	Fri Aug  2 17:39:45 2002
+++ linux-2.4.20-modified/fs/coda/sysctl.c	Thu Jan 23 15:56:52 2003
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff -urN linux-2.4.20/fs/inode.c linux-2.4.20-modified/fs/inode.c
--- linux-2.4.20/fs/inode.c	Fri Aug  2 17:39:45 2002
+++ linux-2.4.20-modified/fs/inode.c	Thu Jan 23 15:56:42 2003
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/cache.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>

diff -urN linux-2.4.20/fs/intermezzo/sysctl.c linux-2.4.20-modified/fs/intermezzo/sysctl.c
--- linux-2.4.20/fs/intermezzo/sysctl.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/fs/intermezzo/sysctl.c	Thu Jan 23 15:57:01 2003
@@ -27,7 +27,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff -urN linux-2.4.20/include/linux/swapctl.h linux-2.4.20-modified/include/linux/swapctl.h
--- linux-2.4.20/include/linux/swapctl.h	Mon Sep 17 16:15:02 2001
+++ linux-2.4.20-modified/include/linux/swapctl.h	Wed Dec 31 16:00:00 1969
@@ -1,13 +0,0 @@
-#ifndef _LINUX_SWAPCTL_H
-#define _LINUX_SWAPCTL_H
-
-typedef struct pager_daemon_v1
-{
-	unsigned int	tries_base;
-	unsigned int	tries_min;
-	unsigned int	swap_cluster;
-} pager_daemon_v1;
-typedef pager_daemon_v1 pager_daemon_t;
-extern pager_daemon_t pager_daemon;
-
-#endif /* _LINUX_SWAPCTL_H */
diff -urN linux-2.4.20/include/linux/sysctl.h linux-2.4.20-modified/include/linux/sysctl.h
--- linux-2.4.20/include/linux/sysctl.h	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/include/linux/sysctl.h	Thu Jan 23 15:53:21 2003
@@ -137,7 +137,6 @@
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
 	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
-	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
 	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
diff -urN linux-2.4.20/kernel/sysctl.c linux-2.4.20-modified/kernel/sysctl.c
--- linux-2.4.20/kernel/sysctl.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.20-modified/kernel/sysctl.c	Thu Jan 23 15:57:14 2003
@@ -21,7 +21,6 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
@@ -265,8 +264,6 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
-	{VM_PAGERDAEMON, "kswapd",
-	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PGT_CACHE, "pagetable_cache",
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster",
diff -urN linux-2.4.20/mm/bootmem.c linux-2.4.20-modified/mm/bootmem.c
--- linux-2.4.20/mm/bootmem.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/bootmem.c	Thu Jan 23 15:58:27 2003
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -urN linux-2.4.20/mm/filemap.c linux-2.4.20-modified/mm/filemap.c
--- linux-2.4.20/mm/filemap.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/filemap.c	Thu Jan 23 15:58:21 2003
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/iobuf.h>
diff -urN linux-2.4.20/mm/memory.c linux-2.4.20-modified/mm/memory.c
--- linux-2.4.20/mm/memory.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/memory.c	Thu Jan 23 15:58:14 2003
@@ -40,7 +40,6 @@
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/smp_lock.h>
-#include <linux/swapctl.h>
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
diff -urN linux-2.4.20/mm/mmap.c linux-2.4.20-modified/mm/mmap.c
--- linux-2.4.20/mm/mmap.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/mmap.c	Thu Jan 23 15:58:05 2003
@@ -8,7 +8,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/file.h>
diff -urN linux-2.4.20/mm/oom_kill.c linux-2.4.20-modified/mm/oom_kill.c
--- linux-2.4.20/mm/oom_kill.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/oom_kill.c	Thu Jan 23 15:58:00 2003
@@ -18,7 +18,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/timex.h>

 /* #define DEBUG */
diff -urN linux-2.4.20/mm/page_alloc.c linux-2.4.20-modified/mm/page_alloc.c
--- linux-2.4.20/mm/page_alloc.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/page_alloc.c	Thu Jan 23 15:57:54 2003
@@ -15,7 +15,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
diff -urN linux-2.4.20/mm/page_io.c linux-2.4.20-modified/mm/page_io.c
--- linux-2.4.20/mm/page_io.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/page_io.c	Thu Jan 23 15:57:47 2003
@@ -14,7 +14,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/locks.h>
-#include <linux/swapctl.h>

 #include <asm/pgtable.h>

diff -urN linux-2.4.20/mm/swap.c linux-2.4.20-modified/mm/swap.c
--- linux-2.4.20/mm/swap.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/swap.c	Thu Jan 23 15:57:40 2003
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>

@@ -26,12 +25,6 @@

 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
-
-pager_daemon_t pager_daemon = {
-	512,	/* base number for calculating the number of tries */
-	SWAP_CLUSTER_MAX,	/* minimum number of tries */
-	8,	/* do swap I/O in clusters of this size */
-};

 /*
  * Move an inactive page to the active list.
diff -urN linux-2.4.20/mm/swap_state.c linux-2.4.20-modified/mm/swap_state.c
--- linux-2.4.20/mm/swap_state.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/swap_state.c	Thu Jan 23 15:57:32 2003
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
diff -urN linux-2.4.20/mm/swapfile.c linux-2.4.20-modified/mm/swapfile.c
--- linux-2.4.20/mm/swapfile.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.20-modified/mm/swapfile.c	Thu Jan 23 15:58:32 2003
@@ -9,7 +9,6 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/blkdev.h> /* for blk_size */
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
diff -urN linux-2.4.20/mm/vmscan.c linux-2.4.20-modified/mm/vmscan.c
--- linux-2.4.20/mm/vmscan.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.20-modified/mm/vmscan.c	Thu Jan 23 15:57:23 2003
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>

