Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSLCGkm>; Tue, 3 Dec 2002 01:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSLCGkm>; Tue, 3 Dec 2002 01:40:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:11686 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265143AbSLCGki>;
	Tue, 3 Dec 2002 01:40:38 -0500
Message-ID: <3DEC53A0.C038571@digeo.com>
Date: Mon, 02 Dec 2002 22:48:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.50-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2002 06:48:01.0360 (UTC) FILETIME=[EC379500:01C29A97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.50/2.5.50-mm1/

Nothing particularly exciting here.  There are two diffs at the above
site: 2.5.50-mm1.gz is the full patch, and 2.5.50-mm1-shpte.gz is
everything up to `shpte-always-on.patch'.  The latter is for Dave to
create diffs against.


Changes since 2.5.49-mm2:

+fbcon-timer-fix.patch
+hugepage-fixes.patch

 Random fixes

+ext3-oldalloc.patch

 Add the `oldalloc' and `orlov' mount options to ext3.

 ext3 has taken a big performance hit in dbench-on-scsi-on-SMP.  This
 is due to the Orlov allocator triggering a weakness in the ext2/ext3
 block allocator design.

 For a full analysis and protopatches see
 http://sourceforge.net/mailarchive/forum.php?thread_id=1365460&forum_id=6379

 Bottom line: we need to strengthen the block allocator.  The `oldalloc'
 mount option can be used to determine whether any performance regression
 is due to this problem.  Same deal with ext2, which is also affected.

+dio-return-partial-result.patch

 A direct-IO correctness fix.

+deprecate-bdflush.patch

 Warn about use of sys_bdflush()

+suppress-write-error-warnings.patch

 Suppress some scary warnings due to write I/O errors.

+quota-smp-locks.patch

 Jan Kara's quota update - remove BKL, replace with private locking.

+shpte-always-on.patch

 Always enable shared pagetables on ia32.  If it's merged, it will
 be merged in the "always on" state, and it needs the testing.

+sync_fs.patch
+ext3_sync_fs.patch

 Fix the ext3 data=journal unmount problem.

+ext3-fsync-speedup.patch

 Small tweak to the ext3 fsync() path.

+page-walk-api-bugfix.patch

 A bugfix.  (Ingo, the page-walk API probably needs updating for
 mm/nommu.c)



All 65 patches:

 linus.patch
  cset-1.924.1.2-to-1.968.txt.gz

fbcon-timer-fix.patch
  timer fixes

hugepage-fixes.patch
  hugetlbpage.c build fix

epoll-bits-0.57.patch
  epoll bits 0.57 ( on top of 2.5.49 ) ...

kgdb.patch

ext3-oldalloc.patch
  add the `oldalloc' and `orlov' mount options to ext3

simplified-vm-throttling.patch
  Remove the final per-page throttling site in the VM

page-reclaim-motion.patch
  Move reclaimable pages to the tail ofthe inactive list on IO completion

handle-fail-writepage.patch
  Special-case fail_writepage() in page reclaim

activate-unreleaseable-pages.patch
  Move unreleasable pages onto the active list

dio-return-partial-result.patch

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-really-submit.patch
  Fix up aio-for-dio

aio-dio-deferred-dirtying.patch
  Use the deferred-page-dirtying code in the AIO-DIO code.

aio-dio-debug.patch

dio-counting.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

ipc_barriers.patch
  memory barrier work in ipc/util.c

signal-speedup.patch
  speed up signals

reiserfs-readpages.patch
  reiserfs v3 readpages support

deprecate-bdflush.patch
  deprecate use of bdflush()

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

pf_memdie.patch
  Subject: Re: [patch] 2.5: kill PF_MEMDIE

suppress-write-error-warnings.patch
  suppress some bufer-layer warnings on write IO errors

truncate-speedup.patch
  truncate speedup

spill-lru-lists.patch
  Fix interaction between batched lru addition and hot/cold pages

readdir-speedup.patch
  readdir speedup and fixes

poll-1-wqalloc.patch
  poll 1/6: reduced mempory requirements

poll-2-selectalloc.patch
  poll 2/6: put small bitmaps into a local

poll-3-alloc.patch
  poll 3/6: improved pollfd memory allocation

poll-4-fast-select.patch
  poll 4/6: select() speedups

poll-5-fast-poll.patch
  poll 5/6: poll() speedup

poll-6-merge.patch
  poll6/6: merge poll() and select() common code

bcrl-printk.patch

read_zero-speedup.patch
  speed up read_zero() for !CONFIG_MMU

nommu-rmap-locking.patch
  Fix rmap locking for CONFIG_SWAP=n

semtimedop.patch
  semtimedop - semop() with a timeout

writeback-handle-memory-backed.patch
  skip memory-backed filesystems in writeback

remove-fail_writepage.patch
  Remove fail_writepage()

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

quota-smp-locks.patch
  Subject: [PATCH] Quota SMP locks

shpte-ng.patch
  pagetable sharing for ia32

shpte-always-on.patch
  Force CONFIG_SHAREPTE=y for ia32

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

radix-tree-overflow-fix.patch
  handle overflows in radix_tree_gang_lookup()

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

sync_fs.patch
  Add a sync_fs super_block operation

ext3_sync_fs.patch
  implement ext3_sync_fs

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

dcache_rcu-2-2.5.48.patch

dcache_rcu-3-2.5.48.patch

page-walk-api.patch

page-walk-api-improvements.patch

page-walk-api-bugfix.patch
  page-walk API fixes

page-walk-scsi.patch
