Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265831AbSIRIZx>; Wed, 18 Sep 2002 04:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265832AbSIRIZx>; Wed, 18 Sep 2002 04:25:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:36068 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265831AbSIRIZv>;
	Wed, 18 Sep 2002 04:25:51 -0400
Message-ID: <3D8839B5.B37DF31C@digeo.com>
Date: Wed, 18 Sep 2002 01:30:45 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.36-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 08:30:45.0335 (UTC) FILETIME=[AED68670:01C25EED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.36/2.5.36-mm1/

A reminder that this changes /proc files.  Updated top(1) and
vmstat(1) source is available at http://surriel.com/procps/

A simple coding bug in the VM has been fixed.  This has increased
swapout bandwidth and halved the runtime for memset(malloc(huge_amount))
type benchmarks.

An initial version of the sard accounting patch is included.

Some VM changes which clean up some code and attempt to sort out
some undesirable dependencies between the direct-reclaim and kswapd
functions has been added.

 
-madvise-move.patch
-split-vma.patch
-mmap-fixes.patch
-buffer-ops-move.patch
-slab-stats.patch

 Merged

+vm-mapping-fix.patch

 Dumb bug.

+writev-fix.patch

 Fix the bounds checking on entry to readv and writev.

+misc.patch

 misc fixes

+highmem-huge-tlb.patch

 Allow hugetlbpages to be allocated from highmem

+sard.patch

 Extended disk accounting

+remove-gfp_nfs.patch

 A little cleanup via Rustie Rustle.

+per-zone-vm.patch

 kswapd-versus-direct-reclaim rework.




linus.patch
  cset-1.547-to-1.565.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

writeback-control.patch
  Cleanup and extension of the writeback paths

free_area_init-cleanup.patch
  free_area_init() code cleanup

alloc_pages-cleanup.patch
  alloc_pages cleanup and optimisation

statm_pgd_range-sucks.patch
  Remove the pagetable walk from /proc/stat

remove-sync_thresh.patch
  Remove /proc/sys/vm/dirty_sync_thresh

vm-mapping-fix.patch
  shrink_list bugfix

taka-writev.patch
  Speed up writev

writev-fix.patch
  readv/writev bounds checking fixes

pf_nowarn.patch
  Fix up the handling of PF_NOWARN

misc.patch
  Misc fixlets

release_pages-speedup.patch
  Reduced locking in release_pages()

highmem-huge-tlb.patch
  Allocate huge TLB pages in highmem

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

prepare_to_wait.patch
  New sleep/wakeup API

vm-wakeups.patch
  Use the faster wakeups in the VM and block layers

sync-helper.patch
  Speed up sys_sync() against multiple spindles

slabasap.patch
  Early and smarter shrinking of slabs

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

buddyinfo.patch
  Add /proc/buddyinfo - stats on the free pages pool

free_area.patch
  Remove struct free_area_struct and free_area_t, use `struct free_area'

per-node-kswapd.patch
  Per-node kswapd instance

topology-api.patch
  NUMA topology API

radix_tree_gang_lookup.patch
  radix tree gang lookup

truncate_inode_pages.patch
  truncate/invalidate_inode_pages rewrite

proc_vmstat.patch
  Move the vm accounting out of /proc/stat

kswapd-reclaim-stats.patch
  Add kswapd_steal to /proc/vmstat

iowait.patch
  I/O wait statistics

sard.patch
  SARD disk accounting

remove-gfp_nfs.patch
  remove GFP_NFS

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

swapoff-deadlock.patch
  Fix a tmpfs swapoff deadlock

dirty-and-uptodate.patch
  page state cleanup

shmem_rename.patch
  shmem_rename() directory link count fix

dirent-size.patch
  tmpfs: show a non-zero size for directories

tmpfs-trivia.patch
  tmpfs: small fixlets

per-zone-vm.patch
  separate the kswapd and direct reclaim code paths
