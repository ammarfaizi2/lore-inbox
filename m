Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJAJ1F>; Tue, 1 Oct 2002 05:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJAJ1F>; Tue, 1 Oct 2002 05:27:05 -0400
Received: from packet.digeo.com ([12.110.80.53]:62676 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261321AbSJAJ1C>;
	Tue, 1 Oct 2002 05:27:02 -0400
Message-ID: <3D996BA3.24E8B007@digeo.com>
Date: Tue, 01 Oct 2002 02:32:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.40-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 09:32:19.0899 (UTC) FILETIME=[705700B0:01C2692D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.40/2.5.40-mm1/

Mainly a resync.

- A few minor problems in the per-cpu-pages code have been fixed.

- Updated dcache RCU code.

- Significant brain surgery on the SARD patch.

- Decreased the disk scheduling tunable `fifo_batch' from 32 to 16 to
  improve disk read latency.

- Updated ext3 htree patch from Ted.

- Included a patch from Mala Anand which _should_ speed up kernel<->userspace
  memory copies for Intel ia32 hardware.  But I can't measure any difference
  with poorly-aligned pagecache copies.


-scsi_hack.patch
-might_sleep-2.patch
-slab-fix.patch
-hugetlb-doc.patch
-get_user_pages-PG_reserved.patch
-move_one_page_fix.patch
-zab-list_heads.patch
-remove-gfp_nfs.patch
-buddyinfo.patch
-free_area.patch
-per-node-kswapd.patch
-topology-api.patch
-topology_fixes.patch

 Merged

+misc.patch

 Trivia

+ioperm-fix.patch

 Fix the sys_ioperm() might-sleep-while-atomic bug

-sard.patch
+bd-sard.patch

 Somewhat rewritten to not key everything off minors and majors - use
 pointers instead.

+bio-get-nr-vecs.patch

 use bio_get_nr_vecs in fs/mpage.c

+dio-nr-segs.patch

 use bio_get_nr_vecs in fs/direct-io.c

-per-node-zone_normal.patch
+per-node-mem_map.patch

 Renamed

+free_area_init-cleanup.patch

 Clean up some mm init code.

+intel-user-copy.patch

 Supposedly faster copy_*_user.



ext3-dxdir.patch
  ext3 htree

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

misc.patch
  misc

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

ioperm-fix.patch
  sys_ioperm() atomicity fix

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

bd-sard.patch

dio-bio-add-page.patch
  Use bio_add_page() in direct-io.c

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

bio-get-nr-vecs.patch
  use bio_get_nr_vecs() in fs/mpage.c

dio-nr-segs.patch
  Use bio_get_nr_vecs() in direct-io.c

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

per-node-mem_map.patch
  ia32 NUMA: per-node ZONE_NORMAL

alloc_pages_node-cleanup.patch
  alloc_pages_node cleanup

free_area_init-cleanup.patch
  free_area_init_node cleanup

batched-slab-asap.patch
  batched slab shrinking

akpm-deadline.patch
  deadline scheduler tweaks

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation
  EDEC
  
  Hot/Cold pages and zone->lock amortisation
  

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

intel-user-copy.patch

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
