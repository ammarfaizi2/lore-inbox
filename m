Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTCFG4F>; Thu, 6 Mar 2003 01:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTCFG4F>; Thu, 6 Mar 2003 01:56:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:43997 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267853AbTCFGz7>;
	Thu, 6 Mar 2003 01:55:59 -0500
Date: Wed, 5 Mar 2003 23:07:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm1
Message-Id: <20030305230712.5a0ec2d4.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 07:06:24.0923 (UTC) FILETIME=[E668AEB0:01C2E3AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm1/

. Included Ingo's file-offset-in-pte patch which allows pages which are in
  nonlinear mappings to be reestablished by the kernel's pagefault handler. 
  This is enabled against all mappings for testing purposes.

. No functional changes to the anticipatory scheduler this time.  Just
  stabilisation work.  It doesn't seem to oops any more.

. A bunch of buxfixes plus the usual sweepings off the factory floor.




Changes since 2.5.63-mm2:

 linus.patch

 Latest from Linus

-separate.patch
-ppc64-e100-fix.patch
-deadline-dispatching-fix.patch
-loop-hack.patch
-oprofile-up-fix.patch
-presto_get_sb-fix.patch
-on_each_cpu.patch
-on_each_cpu-ldt-cleanup.patch
-notsc-panic.patch
-alloc_pages_cleanup.patch
-ext2-handle-htree-flag.patch
-mpparse-typo-fix.patch
-i386-no-swap-fix.patch
-remove-hugetlb_key.patch
-hugetlbpage-doc-update.patch
-hugetlb-valid-page-ranges.patch
-cciss-startup-problem-fix.patch
-cciss-retry-bus-reset.patch
-cciss-add-cmd-type.patch
-cciss-getluninfo-ioctl.patch
-cciss-passthrough-ioctl.patch

 Merged

+balance_irq-cleanup.patch

 Clean up some stuff in io_apic.c

+balance_irq-fix.patch

 Fix a system lockup.

-sysfs-dget-fix-2.patch

 Dropped - fixed in 2.5.64.

-irq-sharing-fix.patch

 Dropped - mixing SA_INTERRUPT and SA_SHIRQ handlers is illegal anyway.

+shared-irq-warning.patch

 Warn about mixed SA_INTERRUPT & SA_SHIRQ handlers.

+as-naming-comments-BUG.patch
+as-unnecessary-test.patch
+as-atomicity-fix.patch

 Anticipatory scheduler work.

-update_atime-speedup.patch
-ext2-update_atime_speedup.patch
-ext3-update_atime_speedup.patch
-UPDATE_ATIME-to-update_atime.patch

 Dropped.  Was junk.

+objrmap-atomic_t-fix.patch

 Tighten up objrmap's handling of page->pte.mapcount

+scheduler-tunables.patch

 Put the CPU scheduler tunables back (/proc/sys/sched)

+rtc-locking-fix.patch

 rtc.c lock ranking bugfix

+yellowfin-set_bit-fix.patch

 Don't do set_bit() on a ushort.

+sk98-build-fix.patch

 Don't do 64-bit divides

+cciss-pci-hotplug-fix.patch

 cciss fix

+export-pfn_to_nid.patch

 An EXPORT_SYMBOL for discontigmem

+move-CONFIG_SWAP.patch

 Tidy up the config menus.

+random-stack-use.patch

 Reduce stack use in the random driver

+inode-pruning-fix.patch

 Fix the icache shrinking logic

+remap-file-pages-2.5.63-a1.patch

 Allow pages in nonlinear mappings to be faulted back in by the kernel.

+pte_file-always.patch

 Force the new remap-file-pages logic to apply to _all_ mappings, for
 testing.

+remove-__pgd_offset.patch
+remove-__pmd_offset.patch
+remove-__pte_offset.patch

 Cleanups

+htree-lock_kernel-fix.patch

 Missing unlock_kernel() on htree error path

+pci-1.patch
+pci-2.patch
+pci-3.patch
+pci-4.patch
+pci-5.patch

 PCI/Cardbus handling changes

+elf_core_dump-stack-size-reduction.patch

 Reduce stack size in elf core dumping code

+uninline-binfmt_elf.patch

 Nuke some inlines

+htree-nfs-fix.patch

 Maybe fix the NFS-server-on-ext3/htree problems

+bonding-zerodiv-fix.patch

 Fix a div-by-zero in the bonding driver

+update_atime-ng.patch

 Speed up update_atime, and mtime and ctimes too.  (Haven't tested that this
 is actually working yet).

+one-sec-times.patch

 Implement the above for ext2 and ext3.




All 83 patches:

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

balance_irq-cleanup.patch
  i386 IRQ balancing cleanup

balance_irq-fix.patch
  balance_irq lockup fix

rpc_rmdir-fix.patch
  Fix nfs oops during mount

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Subject: 64bit exec

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

limit-write-latency.patch
  fix possible latency in balance_dirty_pages()

reiserfs_file_write-5.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix-2.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

nfs-sendfile.patch
  Implement sendfile() for NFS

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

aic-makefile-fix.patch
  aicasm Makefile fix

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

flock-fix.patch
  flock fixes for 2.5.62

shared-irq-warning.patch
  detect and warn about attempts to share SA_INTERRUPT handlers

as-iosched.patch
  anticipatory I/O scheduler

as-random-fixes.patch
  Subject: [PATCH] important fixes

as-comment-fix.patch
  AS: comment fix

as-naming-comments-BUG.patch
  AS: fix up naming, comments, add more BUGs

as-unnecessary-test.patch

as-atomicity-fix.patch

readahead-shrink-to-zero.patch
  Allow VFS readahead to fall to zero

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-X-fix.patch
  objrmap fix for X

objrmap-nr_mapped-fix.patch
  objrmap: fix /proc/meminfo:Mapped

objrmap-mapped-mem-fix-2.patch
  fix objrmap mapped mem accounting again

objrmap-atomic_t-fix.patch
  Make objrmap mapcount non-atomic

per-cpu-disk-stats.patch
  Make diskstats per-cpu using kmalloc_percpu

sched-b3.patch
  HT scheduler, sched-2.5.63-B3

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

use-after-free-check.patch
  slab use-after-free detector

reiserfs-fix-memleaks.patch
  ReiserFS: fix memleaks on journal opening failures

copy_page_range-invalid-page-fix.patch
  Fix copy_page_range()'s handling of invalid pages

rtc-locking-fix.patch
  rtc lock ranking fix

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

sk98-build-fix.patch
  sk98lin 64-bit divide fix

cciss-pci-hotplug-fix.patch
  cciss: fix initialization for PCI hotplug

export-pfn_to_nid.patch
  export pfn_to_nid to modules

move-CONFIG_SWAP.patch
  move the CONFIG_SWAP menu option to somewhere logical

random-stack-use.patch
  Reduced stack usage in random.c

inode-pruning-fix.patch
  fix inode reclaim imbalance.

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

pte_file-always.patch
  enable file-offset-in-pte's for all mappings

remove-__pgd_offset.patch
  remove __pgd_offset

remove-__pmd_offset.patch
  remove __pmd_offset

remove-__pte_offset.patch
  remove __pte_offset

htree-lock_kernel-fix.patch
  missed unlock_kernel() in ext3+htree

pci-1.patch
  PCI probing for cardbus (1/5)

pci-2.patch
  PCI probing for cardbus (2/5)

pci-3.patch
  PCI probing for cardbus (3/5)

pci-4.patch
  PCI probing for cardbus (4/5)

pci-5.patch
  PCI probing for cardbus (5/5)

elf_core_dump-stack-size-reduction.patch
  reduce stack size: elf_core_dump()

uninline-binfmt_elf.patch
  uninlining in fs/binfmt_elf.c

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

bonding-zerodiv-fix.patch
  Subject: [PATCH][bonding] division by zero bug

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3



