Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289537AbSAJQj4>; Thu, 10 Jan 2002 11:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289539AbSAJQjr>; Thu, 10 Jan 2002 11:39:47 -0500
Received: from bidu.ime.usp.br ([143.107.45.12]:53680 "HELO bidu.ime.usp.br")
	by vger.kernel.org with SMTP id <S289537AbSAJQjh>;
	Thu, 10 Jan 2002 11:39:37 -0500
Date: Thu, 10 Jan 2002 14:39:22 -0200
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pager_daemon removal
Message-ID: <20020110143922.A12252@ime.usp.br>
In-Reply-To: <20020110161035.GC1780@vinci> <Pine.LNX.4.33L.0201101426110.2985-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33L.0201101426110.2985-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Jan 10, 2002 at 02:27:05PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 02:27:05PM -0200, Rik van Riel wrote:
> On Thu, 10 Jan 2002, Rodrigo Souza de Castro wrote:
> 
> > Comments?
> 
> You're not allowed to renumber sysctl defines, it's ok
> to remove the VM_PAGER_DAEMON thing, but the following
> defines should stay the same number ...

Oops, you are right, thanks. New patch follows.

Regards,
Rodrigo

diff -Naur -X exclude-files orig/arch/arm/mm/init.c linux/arch/arm/mm/init.c
--- orig/arch/arm/mm/init.c	Thu Jan 10 14:19:07 2002
+++ linux/arch/arm/mm/init.c	Thu Jan 10 13:25:22 2002
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- orig/arch/mips/mm/init.c	Thu Jan 10 14:19:07 2002
+++ linux/arch/mips/mm/init.c	Thu Jan 10 13:24:57 2002
@@ -24,7 +24,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/mips64/mm/init.c linux/arch/mips64/mm/init.c
--- orig/arch/mips64/mm/init.c	Thu Jan 10 14:19:07 2002
+++ linux/arch/mips64/mm/init.c	Thu Jan 10 13:25:38 2002
@@ -21,7 +21,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/sparc/mm/init.c linux/arch/sparc/mm/init.c
--- orig/arch/sparc/mm/init.c	Thu Jan 10 14:19:07 2002
+++ linux/arch/sparc/mm/init.c	Thu Jan 10 13:24:41 2002
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/sparc64/mm/init.c linux/arch/sparc64/mm/init.c
--- orig/arch/sparc64/mm/init.c	Thu Jan 10 14:19:07 2002
+++ linux/arch/sparc64/mm/init.c	Thu Jan 10 13:25:11 2002
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/blk.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
diff -Naur -X exclude-files orig/fs/buffer.c linux/fs/buffer.c
--- orig/fs/buffer.c	Thu Jan 10 14:19:07 2002
+++ linux/fs/buffer.c	Thu Jan 10 13:20:41 2002
@@ -35,7 +35,6 @@
 #include <linux/locks.h>
 #include <linux/errno.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
diff -Naur -X exclude-files orig/fs/coda/sysctl.c linux/fs/coda/sysctl.c
--- orig/fs/coda/sysctl.c	Thu Jan 10 14:19:07 2002
+++ linux/fs/coda/sysctl.c	Thu Jan 10 13:21:07 2002
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff -Naur -X exclude-files orig/fs/inode.c linux/fs/inode.c
--- orig/fs/inode.c	Thu Jan 10 14:19:07 2002
+++ linux/fs/inode.c	Thu Jan 10 13:20:49 2002
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/cache.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>
 
diff -Naur -X exclude-files orig/fs/intermezzo/sysctl.c linux/fs/intermezzo/sysctl.c
--- orig/fs/intermezzo/sysctl.c	Thu Jan 10 14:19:07 2002
+++ linux/fs/intermezzo/sysctl.c	Thu Jan 10 13:21:28 2002
@@ -8,7 +8,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff -Naur -X exclude-files orig/include/linux/swapctl.h linux/include/linux/swapctl.h
--- orig/include/linux/swapctl.h	Thu Jan 10 14:19:07 2002
+++ linux/include/linux/swapctl.h	Wed Dec 31 21:00:00 1969
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
diff -Naur -X exclude-files orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- orig/include/linux/sysctl.h	Thu Jan 10 14:19:07 2002
+++ linux/include/linux/sysctl.h	Thu Jan 10 14:33:04 2002
@@ -137,7 +137,6 @@
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
 	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
-	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
 	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
        VM_MIN_READAHEAD=12,    /* Min file readahead */
diff -Naur -X exclude-files orig/kernel/sysctl.c linux/kernel/sysctl.c
--- orig/kernel/sysctl.c	Thu Jan 10 14:19:07 2002
+++ linux/kernel/sysctl.c	Thu Jan 10 13:21:43 2002
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
diff -Naur -X exclude-files orig/mm/bootmem.c linux/mm/bootmem.c
--- orig/mm/bootmem.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/bootmem.c	Thu Jan 10 13:23:50 2002
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/mm/filemap.c linux/mm/filemap.c
--- orig/mm/filemap.c	Thu Jan 10 14:33:40 2002
+++ linux/mm/filemap.c	Thu Jan 10 13:38:12 2002
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/iobuf.h>
diff -Naur -X exclude-files orig/mm/memory.c linux/mm/memory.c
--- orig/mm/memory.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/memory.c	Thu Jan 10 13:22:05 2002
@@ -40,7 +40,6 @@
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/smp_lock.h>
-#include <linux/swapctl.h>
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
diff -Naur -X exclude-files orig/mm/mmap.c linux/mm/mmap.c
--- orig/mm/mmap.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/mmap.c	Thu Jan 10 13:22:21 2002
@@ -8,7 +8,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/file.h>
diff -Naur -X exclude-files orig/mm/oom_kill.c linux/mm/oom_kill.c
--- orig/mm/oom_kill.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/oom_kill.c	Thu Jan 10 13:24:23 2002
@@ -18,7 +18,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/timex.h>
 
 /* #define DEBUG */
diff -Naur -X exclude-files orig/mm/page_alloc.c linux/mm/page_alloc.c
--- orig/mm/page_alloc.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/page_alloc.c	Thu Jan 10 13:22:50 2002
@@ -12,7 +12,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/mm/page_io.c linux/mm/page_io.c
--- orig/mm/page_io.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/page_io.c	Thu Jan 10 14:02:19 2002
@@ -14,13 +14,11 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/locks.h>
-#include <linux/swapctl.h>
 
 #include <asm/pgtable.h>
 
 /*
  * Reads or writes a swap page.
- * wait=1: start I/O and wait for completion. wait=0: start asynchronous I/O.
  *
  * Important prevention of race condition: the caller *must* atomically 
  * create a unique swap cache entry for this swap page before calling
diff -Naur -X exclude-files orig/mm/swap.c linux/mm/swap.c
--- orig/mm/swap.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/swap.c	Thu Jan 10 13:22:14 2002
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
diff -Naur -X exclude-files orig/mm/swap_state.c linux/mm/swap_state.c
--- orig/mm/swap_state.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/swap_state.c	Thu Jan 10 13:23:40 2002
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
diff -Naur -X exclude-files orig/mm/swapfile.c linux/mm/swapfile.c
--- orig/mm/swapfile.c	Thu Jan 10 14:19:07 2002
+++ linux/mm/swapfile.c	Thu Jan 10 13:23:34 2002
@@ -9,7 +9,6 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/blkdev.h> /* for blk_size */
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
diff -Naur -X exclude-files orig/mm/vmscan.c linux/mm/vmscan.c
--- orig/mm/vmscan.c	Thu Jan 10 14:33:40 2002
+++ linux/mm/vmscan.c	Thu Jan 10 13:38:12 2002
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
