Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTAQIOs>; Fri, 17 Jan 2003 03:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTAQIOs>; Fri, 17 Jan 2003 03:14:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:10727 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267425AbTAQIOp>;
	Fri, 17 Jan 2003 03:14:45 -0500
Date: Fri, 17 Jan 2003 00:24:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm1
Message-Id: <20030117002451.69f1eda1.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 08:23:36.0904 (UTC) FILETIME=[BB74E480:01C2BE01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm1/

I've stripped these patches down to just those things which seriously should
go into Linus's tree.

I'm mainly interested in gathering bugfixes across the rest of this month,
but if people have more substantial things which are clearly 2.6 material and
need some testing then OK.



Changes since 2.5.58-mm1:


-deadline-np.patch
-saner-readahead.patch
-ext3-leak-fix.patch
-hugetlbfs-read-write.patch
-ext3-ino_t-cleanup.patch

 Merged

-rcf.patch

 run-child-first didn't seem to help anything, and an alarming number of
 cleanups and fixes were needed to get it working right.  Later.

-cputimes_stat.patch

 Not to Linus's taste.

-smaller-head-arrays.patch

 This was just for trolling Manfred.

+deadline-np-42.patch
+deadline-np-43.patch

 I/O scheduler changes from Nick.

-ptrace-flush.patch

 Wasn't a serious patch anyway

-rcu-stats.patch

 Not sure we need this.

+ext3-scheduling-storm.patch

 Fix the bug wherein ext3 sometimes shows blips of 100k context
 switches/sec.

-ext3-fsync-speedup.patch

 Haven't tested this yet.

-lockless-current_kernel_time.patch

 Is ia32-only.

-honour-vm_reserved.patch

 Unnecessary

+mixer-bounds-check.patch

 sound/oss/sb_mixer.c fixlets

+kirq.patch

 Nitin Kamble's rework of the ia32 SMP interrupt distribution logic.

+ext3-truncate-ordered-pages.patch

 Free truncated pages earlier from ext3 - should fix the strange "cannot
 fork" thing which Con reports.

+read_cache_pages-cleanup.patch
+remove-GFP_HIGHIO.patch

 Cleanups.

-wli-02_do_sak.patch
-wli-03_proc_super.patch
-wli-06_uml_get_task.patch
-wli-07_numaq_mem_map.patch
-wli-08_numaq_pgdat.patch
-wli-09_has_stopped_jobs.patch
-wli-10_inode_wait.patch
-wli-13_rmap_nrpte.patch

 Not convinced about these.

-dcache_rcu-2.patch
-dcache_rcu-3.patch

 Looks like nothing is happening here until Mr Viro returns.

-page-walk-api.patch
-page-walk-api-2.5.53-mm2-update.patch
-page-walk-scsi.patch
-page-walk-scsi-2.5.53-mm2.patch

 This is 2.7 material.

+stack-overflow-fix.patch

 Fix thinko in the ia32 stack overflow checker.

+Richard_Henderson_for_President.patch

 It's all right for him - he lives in Australia.

+parenthesise-pgd_index.patch
+macro-double-eval-fix.patch
+mmzone-parens.patch
+blkdev-fixes.patch

 Header file safety.



All 34 patches:

kgdb.patch

devfs-fix.patch

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

fadvise.patch
  implement posix_fadvise64()

ext3-scheduling-storm.patch
  ext3: fix scheduling storm and lockups

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

mixer-bounds-check.patch
  OSS ioctl bounds checking fix

kirq.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

prune-icache-stats.patch
  add stats for page reclaim via inode freeing

vma-file-merge.patch

mmap-whitespace.patch

read_cache_pages-cleanup.patch
  cleanup in read_cache_pages()

remove-GFP_HIGHIO.patch
  remove __GFP_HIGHIO

quota-lockfix.patch
  quota locking fix

quota-offsem.patch
  quota semaphore fix

oprofile-p4.patch

op4-fix.patch

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

stack-overflow-fix.patch
  stack overflow checking fix

Richard_Henderson_for_President.patch
  Subject: [PATCH] Richard Henderson for President!

parenthesise-pgd_index.patch
  Subject: i386 pgd_index() doesn't parenthesize its arg

macro-double-eval-fix.patch
  Subject: Re: i386 pgd_index() doesn't parenthesize its arg

mmzone-parens.patch
  asm-i386/mmzone.h macro paren/eval fixes

blkdev-fixes.patch
  blkdev.h fixes


