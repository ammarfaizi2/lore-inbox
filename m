Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264210AbSIWEP5>; Mon, 23 Sep 2002 00:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264257AbSIWEP5>; Mon, 23 Sep 2002 00:15:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:53240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264210AbSIWEPy>;
	Mon, 23 Sep 2002 00:15:54 -0400
Message-ID: <3D8E96AA.C2FA7D8@digeo.com>
Date: Sun, 22 Sep 2002 21:20:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.38-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 04:20:58.0915 (UTC) FILETIME=[9E4D0F30:01C262B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm2/

+linus.patch

 Linus's current diff.

-filemap-fixes.patch

 Merged

+unbreak-writeback-mode.patch

 ext3 in data=writeback mode was oopsing on writeback of MAP_SHARED
 data.

+read-latency.patch

 Fix the writer-starves-reader elevator problem.  This is basically
 the read_latency2 patch from -ac kernels.

 On IDE it provides a 100x improvement in read throughput when there
 is heavy writeback happening.  40x on SCSI.  You need to disable
 tagged command queueing on scsi - it appears to be quite stupidly
 implemented.


linus.patch
  cset-1.580.1.4-to-1.597.txt.gz

ide-high-1.patch

ide-block-fix-1.patch

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

might_sleep.patch
  debug code to detect might-sleep-inside-spinlock bugs

unbreak-writeback-mode.patch
  Fix ext3's data=writeback mode

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-ext2-preread.patch
  avoid ext2 inode prereads if the queue is congested

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim

set_page_dirty-locking-fix.patch
  don't call __mark_inode_dirty under spinlock

prepare_to_wait.patch
  prepare_to_wait/finish_wait: new sleep/wakeup API

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
  Simple topology API

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

swsusp-feature.patch
  add shrink_all_memory() for swsusp

adaptec-fix.patch
  partial fix for aic7xxx error recovery

remove-page-virtual.patch
  remove page->virtual for !WANT_PAGE_VIRTUAL

dirty-memory-clamp.patch
  sterner dirty-memory clamping

mempool-wakeup-fix.patch
  Fix for stuck tasks in mempool_alloc()

remove-write_mapping_buffers.patch
  Remove write_mapping_buffers

buffer_boundary-scheduling.patch
  IO schduling for indirect blocks

ll_rw_block-cleanup.patch
  cleanup ll_rw_block()

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

discontig-no-contig_page_data.patch
  undefine contif_page_data for discontigmem

per-node-zone_normal.patch
  ia32 NUMA: per-node ZONE_NORMAL

alloc_pages_node-cleanup.patch
  alloc_pages_node cleanup

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache

read-latency.patch
  Elevator fix for writes-starving-reads
