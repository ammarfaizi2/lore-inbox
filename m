Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319281AbSHVCOA>; Wed, 21 Aug 2002 22:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHVCN7>; Wed, 21 Aug 2002 22:13:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319281AbSHVCN6>;
	Wed, 21 Aug 2002 22:13:58 -0400
Message-ID: <3D644C70.6D100EA5@zip.com.au>
Date: Wed, 21 Aug 2002 19:29:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: MM patches against 2.5.31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've uploaded a rollup of pending fixes and feature work
against 2.5.31 to

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/2.5.31-mm1/

The rolled up patch there is suitable for ongoing testing and
development.  The individual patches are in the broken-out/
directory and should all be documented.


broken-out/linus.patch
  Incremental BK patch from Linus' tree

broken-out/page_reserved.patch
  Test PageReserved in pagevec_release()

broken-out/scsi_hack.patch
  Fix block-highmem for scsi

broken-out/page_cache_release_lru_fix.patch
  Fix a race between __page_cache_release() and shrink_cache().

broken-out/page_cache_release_fix.patch
  Fix __page_cache_release() bugs

broken-out/mvm.patch
  Fix vmalloc bugs

broken-out/pte-chain-fix.patch
  Fix a VM lockup on uniprocessors

broken-out/func-fix.patch
  gcc-2.91.66 does not support __func__

broken-out/ext3-htree.patch
  Indexed directories for ext3

broken-out/rmap-mapping-BUG.patch
  Fix a BUG_ON(page->mapping == NULL) in try_to_unmap()

broken-out/misc.patch
  misc fixlets

broken-out/tlb-speedup.patch
  Reduce typical global TLB invalidation frequency by 35%

broken-out/buffer-slab-align.patch
  Don't align the buffer_head slab on hardware cacheline boundaries

broken-out/zone-rename.patch
  Rename zone_struct->zone, zonelist_struct->zonelist.  Remove zone_t,
  zonelist_t.

broken-out/per-zone-lru.patch
  Per-zone page LRUs

broken-out/per-zone-lock.patch
  Per-zone LRU list locking

broken-out/l1-max-size.patch
  Infrastructure for determining the maximum L1 cache size which the kernel
  may have to support.

broken-out/zone-lock-alignment.patch
  Pad struct zone to ensure that the lru and buddy locks are in separate
  cachelines.

broken-out/put_page_cleanup.patch
  Clean up put_page() and page_cache_release().

broken-out/anon-batch-free.patch
  Batched freeing and de-LRUing of anonymous pages

broken-out/writeback-sync.patch
  Writeback fixes and tuneups

broken-out/ext3-inode-allocation.patch
  Fix an ext3 deadlock

broken-out/ext3-o_direct.patch
  O_DIRECT support for ext3.

broken-out/jfs-bio.patch
  Convert JFS to use direct-to-BIO I/O

broken-out/discontig-paddr_to_pfn.patch
  Convert page pointers into pfns for i386 NUMA

broken-out/discontig-setup_arch.patch
  Rework setup_arch() for i386 NUMA

broken-out/discontig-mem_init.patch
  Restructure mem_init for i386 NUMA

broken-out/discontig-i386-numa.patch
  discontigmem support for i386 NUMA

broken-out/cleanup-mem_map-1.patch
  Clean up lots of open-coded uese of mem_map[].  For ia32 NUMA

broken-out/zone-pages-reporting.patch
  Fix the boot-time reporting of each zone's available pages

broken-out/enospc-recovery-fix.patch
  Fix the __block_write_full_page() error path.

broken-out/fix-faults.patch
  Back out the initial work for atomic copy_*_user()

broken-out/bkl-consolidate.patch
  Consolidation per-arch lock_kenrel() implementations.

broken-out/might_sleep.patch
  Infrastructure to detect sleep-inside-spinlock bugs

broken-out/spin-lock-check.patch
  spinlock/rwlock checking infrastructure

broken-out/atomic-copy_user.patch
  Support for atomic copy_*_user()

broken-out/kmap_atomic_reads.patch
  Use kmap_atomic() for generic_file_read()

broken-out/kmap_atomic_writes.patch
  Use kmap_atomic() for generic_file_write()

broken-out/config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

broken-out/throttling-fix.patch
  Fix throttling of heavy write()rs.

broken-out/dirty-state-accounting.patch
  Make the global dirty memory accounting more accurate

broken-out/rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)
