Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSIEIFL>; Thu, 5 Sep 2002 04:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSIEIFL>; Thu, 5 Sep 2002 04:05:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317282AbSIEIFJ>;
	Thu, 5 Sep 2002 04:05:09 -0400
Message-ID: <3D77143F.E441133D@zip.com.au>
Date: Thu, 05 Sep 2002 01:22:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.33-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm3/

+filemap-integration.patch

  Cleanup and code consolidation for readv and writev: generic_file_read()
  and generic_file_write() take an iovec, and tons of code goes away.

  A work in progress.

+direct-io-alignment.patch

  Allow finer-than-fs-blocksize alignment for O_DIRECT.

  A work in progress, which has a bit of a correctness problem, actually.

+mmap-fixes.patch

  Some cleanups and fixes from Christoph.


Also quite a lot of fiddling with the new non-blocking page reclaim
code.  This works well.



linus.patch
  cset-1.575-to-1.600.txt.gz

scsi_hack.patch
  Fix block-highmem for scsi

ext3-htree.patch
  Indexed directories for ext3

zone-pages-reporting.patch
  Fix the boot-time reporting of each zone's available pages

enospc-recovery-fix.patch
  Fix the __block_write_full_page() error path.

fix-faults.patch
  Back out the initial work for atomic copy_*_user()

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

refill-rate.patch
  refill the inactive list more quickly

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
  Downward adjustments to the default dirtymemory thresholds

buffer-strip.patch
  Limit the consumption of ZONE_NORMAL by buffer_heads

rmap-speedup.patch
  rmap pte_chain space and CPU reductions

wli-highpte.patch
  Resurrect CONFIG_HIGHPTE - ia32 pagetables in highmem

readv-writev.patch
  O_DIRECT support for readv/writev

filemap-integration.patch
  Clean up readv/writev

direct-io-alignment.patch
  Reduced direct-IO alignment requirements

slablru.patch
  age slab pages on the LRU

slablru-speedup.patch
  slablru optimisations

llzpr.patch
  Reduce scheduling latency across zap_page_range

buffermem.patch
  Resurrect buffermem accounting

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lpp.patch
  ia32 huge tlb pages

ext3-sb.patch
  u.ext3_sb -> generic_sbp

oom-fix.patch
  Fix an OOM condition on big highmem machines

tlb-cleanup.patch
  Clean up the tlb gather code

dump-stack.patch
  arch-neutral dump_stack() function

wli-cleanup.patch
  random cleanups

madvise-move.patch
  move mdavise implementation into mm/madvise.c

split-vma.patch
  VMA splitting patch

mmap-fixes.patch
  mmap.c cleanup and lock ranking fixes

buffer-ops-move.patch
  Move submit_bh() and ll_rw_block() into fs/buffer.c

writeback-control.patch
  Cleanup and extension of the writeback paths

queue-congestion.patch
  Infrastructure for communicating request queue congestion to the VM

nonblocking-pdflush.patch
  non-blocking writeback infrastructure, use it for pdflush

nonblocking-vm.patch
  Non-blocking page reclaim
