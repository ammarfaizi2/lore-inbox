Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262231AbSIZHwy>; Thu, 26 Sep 2002 03:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262232AbSIZHwy>; Thu, 26 Sep 2002 03:52:54 -0400
Received: from packet.digeo.com ([12.110.80.53]:51931 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262231AbSIZHws>;
	Thu, 26 Sep 2002 03:52:48 -0400
Message-ID: <3D92BE07.B6CDFE54@digeo.com>
Date: Thu, 26 Sep 2002 00:57:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.38-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 07:57:59.0242 (UTC) FILETIME=[6E428AA0:01C26532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm3/

Includes a SARD update from Rick.  The SARD disk accounting is
pretty much final now.

I moved the remaining disk accounting numbers (pgpgin, pgpgout) out of
/proc/stat and this will confuse vmstat.  Again.  Updated versions
are at http://surriel.com/procps, but they're not uptodate enough.

To get a current procps, grab the cygnus CVS (instructions are at
Rik's site) and then apply 
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm3/vmstat.patch


Since 2.5.38-mm2:

-ide-block-fix-1.patch

 Merged (Jens)

-ext3-htree.patch
+ext3-dxdir.patch

 Switch to Ted's ext3-htree patch.

-might_sleep.patch
-unbreak-writeback-mode.patch
-queue-congestion.patch
-nonblocking-ext2-preread.patch
-nonblocking-pdflush.patch
-nonblocking-vm.patch
-set_page_dirty-locking-fix.patch
-prepare_to_wait.patch
-vm-wakeups.patch
-sync-helper.patch
-slabasap.patch

 Merged

+misc.patch

 A comment fix.

+topology_fixes.patch

 Some topology API fixlets from Matthew

+dio-bio-add-page.patch

 Convert direct-io.c to use bio_add_page().  (Badari)

 It will now build BIOs as large as the device supports.

+dio-bio-fixes.patch

 Some alterations to the above.

-read-latency.patch

 "I have to say, that elevator thing is the ugliest code I've seen
  in a long while."  -- Linus

+deadline-update.patch

 Latest deadline scheduler fixes from Jens.

+akpm-deadline.patch

 Expose the deadline scheduler tunables into /proc/sys/vm, and set
 the default fifo_batch to 16.



linus.patch
  cset-1.579.3.4-to-1.605.1.31.txt.gz

ide-high-1.patch

scsi_hack.patch
  Fix block-highmem for scsi

ext3-dxdir.patch

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

misc.patch
  misc fixes

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

topology_fixes.patch
  topology-api cleanups

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

dio-bio-add-page.patch
  Use bio_add_page() in direct-io.c

dio-bio-fixes.patch
  dio-bio-add-page fixes

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

deadline-update.patch
  deadline scheduler updates

akpm-deadline.patch
