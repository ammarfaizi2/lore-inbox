Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTANHea>; Tue, 14 Jan 2003 02:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTANHea>; Tue, 14 Jan 2003 02:34:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:61416 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261173AbTANHe1> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 02:34:27 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.58-mm1
Date: Mon, 13 Jan 2003 23:43:53 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301132343.53532.akpm@digeo.com>
X-OriginalArrivalTime: 14 Jan 2003 07:43:12.0563 (UTC) FILETIME=[97329030:01C2BBA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.58/2.5.58-mm1/

. Added an implementation of posix_fadvise().

  This can be used for providing the kernel hints about desired readahead
  patterns, and for launching asynchronous readahead (what sys_readahead
  does).

  But its main application is for program-directed freeing of pagecache
  against large streamed files.  This is what O_STREAMING gives, only
  posix_fadvise() is harder to use, less efficient and standards-based.

  There is a test app in
    http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

. The direct-to-BIO readahead for reiserfs works fine.

. Ported one of Andrea's -aa patches into 2.5: merging of file-backed VMAs.



Changes since 2.5.56-mm1:

-rbtree-iosched.patch
-deadline-fixes.patch
-deadline-sysfs-fix.patch
-pentium-II.patch

 Merged

+deadline-np.patch

 Another I/O scheduler tweak from Nick.  This solves some potential
 read-starves-read problems and may provide decreased latencies for some
 workloads.

+saner-readahead.patch

 Be smarter about how much readahead the user may start.

+fadvise.patch

 Implement posix_fadvise64().

+honour-vm_reserved.patch

 This shouldn't be here.

+prune-icache-stats.patch

 Add vm statistics on how much pagecache is being freed via prune_icache(). 
 Interestingly, under some workloads, 50% of page reclaim happens here.

+vma-file-merge.patch

 Merging of file-backed VMAs

+mmap-whitespace.patch

 make mm/mmap.c human-readable.

+quota-lockfix.patch
+quota-offsem.patch

 Quota bugfixes.

-smalldevfs.patch

 Dropped - I had only two reports, both unsuccessful.




All 57 patches


kgdb.patch

rcf.patch
  run-child-first after fork

devfs-fix.patch

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

ext3-ino_t-cleanup.patch
  Subject: [PATCH] 2.5 ext3 ino_t removal

smaller-head-arrays.patch

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

deadline-np.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

saner-readahead.patch
  factor free memory into max_sane_readahead()

fadvise.patch
  implement posix_fadvise64()

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

ext3-leak-fix.patch
  fix ext3 memory leak

hugetlbfs-read-write.patch
  hugetlbfs: don't implement read/write file_ops

honour-vm_reserved.patch
  Don't unmap pte's againt VM_RESERVED VMA's

prune-icache-stats.patch
  add stats for page reclaim via inode freeing

vma-file-merge.patch

mmap-whitespace.patch

quota-lockfix.patch
  quota locking fix

quota-offsem.patch
  quota semaphore fix

oprofile-p4.patch

op4-fix.patch

wli-02_do_sak.patch
  (undescribed patch)

wli-03_proc_super.patch
  (undescribed patch)

wli-06_uml_get_task.patch
  (undescribed patch)

wli-07_numaq_mem_map.patch
  (undescribed patch)

wli-08_numaq_pgdat.patch
  (undescribed patch)

wli-09_has_stopped_jobs.patch
  (undescribed patch)

wli-10_inode_wait.patch
  (undescribed patch)

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

wli-13_rmap_nrpte.patch
  (undescribed patch)

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-api-2.5.53-mm2-update.patch
  pagewalk API update

page-walk-scsi.patch

page-walk-scsi-2.5.53-mm2.patch
  pagewalk scsi update



