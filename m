Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSH1EHE>; Wed, 28 Aug 2002 00:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSH1EHE>; Wed, 28 Aug 2002 00:07:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318661AbSH1EG4>;
	Wed, 28 Aug 2002 00:06:56 -0400
Message-ID: <3D6C500E.426B163A@zip.com.au>
Date: Tue, 27 Aug 2002 21:22:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.32-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm1/

Since 2.5.31-mm1:

- A bunch of things from 2.5.31-mm1 were merged.

- The BKL consolidation patch is dropped because Linus did it too.

- The `might_sleep()' debug patch lost its supporting infrastructure
  and I've dropped it for now.

- The configurable PAGE_OFFSET patch ran aground on some kbuild changes and
  needs some more work.

- The following patches have been added

	discontig-cleanup-1.patch
	discontig-cleanup-2.patch
	writeback-thresholds.patch
	buffer-strip.patch
	daniel-rmap-speedup.patch
	rmap-speedup.patch
	wli-highpte.patch


func-fix.patch
  gcc-2.91.66 does not support __func__

ext3-htree.patch
  Indexed directories for ext3

misc.patch
  page_alloc.c fixlets

tlb-speedup.patch
  Reduce typical global TLB invalidation frequency by 35%

buffer-slab-align.patch
  Don't align the buffer_head slab on hardware cacheline boundaries

zone-rename.patch
  Rename zone_struct->zone, zonelist_struct->zonelist.  Remove zone_t,
  zonelist_t.

per-zone-lru.patch
  Per-zone page LRUs

per-zone-lock.patch
  Per-zone LRU list locking

l1-max-size.patch
  Infrastructure for determining the maximum L1 cache size which the kernel
  may have to support.

zone-lock-alignment.patch
  Pad struct zone to ensure that the lru and buddy locks are in separate
  cachelines.

put_page_cleanup.patch
  Clean up put_page() and page_cache_release().

anon-batch-free.patch
  Batched freeing and de-LRUing of anonymous pages

writeback-sync.patch
  Writeback fixes and tuneups

ext3-inode-allocation.patch
  Fix an ext3 deadlock

ext3-o_direct.patch
  O_DIRECT support for ext3.

discontig-paddr_to_pfn.patch
  Convert page pointers into pfns for i386 NUMA

discontig-setup_arch.patch
  Rework setup_arch() for i386 NUMA

discontig-mem_init.patch
  Restructure mem_init for i386 NUMA

discontig-i386-numa.patch
  discontigmem support for i386 NUMA

cleanup-mem_map-1.patch
  Clean up lots of open-coded uese of mem_map[].  For ia32 NUMA

zone-pages-reporting.patch
  Fix the boot-time reporting of each zone's available pages

enospc-recovery-fix.patch
  Fix the __block_write_full_page() error path.

fix-faults.patch
  Back out the initial work for atomic copy_*_user()

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

copy_user_atomic.patch

kmap_atomic_reads.patch
  Use kmap_atomic() for generic_file_read()

kmap_atomic_writes.patch
  Use kmap_atomic() for generic_file_write()

throttling-fix.patch
  Fix throttling of heavy write()rs.

dirty-state-accounting.patch
  Make the global dirty memory accounting more accurate

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

discontig-cleanup-1.patch
  i386 discontigmem coding cleanups

discontig-cleanup-2.patch
  i386 discontigmem cleanups

writeback-thresholds.patch
  Downward adjustments to the default dirty memory thresholds

buffer-strip.patch
  Limit the consumption of ZONE_NORMAL by buffer_heads

daniel-rmap-speedup.patch
  Hashed locking for rmap pte_chains

rmap-speedup.patch
  rmap pte_chain space and CPU reductions

wli-highpte.patch
  Resurrect CONFIG_HIGHPTE - ia32 pagetables in highmem
