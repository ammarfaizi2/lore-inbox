Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbTAaIHg>; Fri, 31 Jan 2003 03:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTAaIHg>; Fri, 31 Jan 2003 03:07:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:32466 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267719AbTAaIHa>;
	Fri, 31 Jan 2003 03:07:30 -0500
Date: Fri, 31 Jan 2003 00:17:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm7
Message-Id: <20030131001733.083f72c5.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 08:16:49.0901 (UTC) FILETIME=[1AA5A9D0:01C2C901]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm7/

. I've split the anticipatory scheduling code out into the experimental/
  directory.  We need to get the base I/O scheduler settled down and working
  well.   Various bad things have happened to it in recent months.

  The I/O scheduler in this patchset should perform quite well.

. Futexes, direct-io and ptrace peek/poke into hugetlb pages were all
  quite broken.  Should be fixed up here.



Changes since 2.5.59-mm6:


+devfs-fix.patch

 Bring the devfs mount-at-boot fix back.

+batch-tuning.patch

 I/O scheduler tuning - split up the read and write batching settings, pick
 sane values.

+starvation-by-read-fix.patch

 Fix the reads-starve-everything problem.

+smaller-slab-batches.patch

 Fix a problem wherein slab activity can disable interrupts for too long
 when slab debug is enabled.

+printk-locking.patch

 Remove some pointless locking in do_syslog()

+jbd-documentation.patch

 Documentation for fs/jdb/*

+kernel-commandline-fix.patch

 Fix kernel commandline parsing

+user-process-count-leak.patch

 Fix interaction between kernel thread creation and user process
 accounting.

+pin_page-fix.patch

 Fix a lockup which occurs when futexes are placed in hugetlb pages.

+do_gettimeofday-speedup.patch

 Optimise do_gettimeofday() for ia32 & ia64

-anticipatory_io_scheduling-2_5_59-mm3.patch
-ant-cleanup.patch
-antsched-update-1.patch

 These are changed, rolled up and placed in the experimental/ directory.

+pte_chain_alloc-fixes.patch

 Fix some stuff which was missed out in the pte_chain_alloc() robustness
 work (spotted by Rik).

+hugetlbfs-set_page_dirty.patch

 Fix a problem with direct-IO against hugetlb pages

+compound-pages.patch

 Infrastructure for correct refcounting of higher-order pages.

+compound-pages-hugetlb.patch

 Fix up hugetlb page refcounting.



All 93 patches:

kgdb.patch

sync-fix.patch
  Fix data loss problem due to sys_sync

direct-io-ENOSPC-fix.patch
  direct-IO: fix i_size handling on ENOSPC

inode-accounting-race-fix.patch
  Fix inode size accounting race

vmlinux-fix.patch
  vmlinux fix

maestro-fix.patch
  Compile fix in sound/oss/maestro.c

devfs-fix.patch

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

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

kirq.patch

kirq-up-fix.patch
  Subject: Re: 2.5.59-mm1

agp-warning-fix.patch
  fix agp compile warning

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

slab-poisoning-fix.patch
  slab poison checking fix

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

preempt-locking.patch
  Subject: spinlock efficiency problem [was 2.5.57 IO slowdown with CONFIG_PREEMPT enabled)

wli-11_pgd_ctor.patch
  Use a slab cache for pgd and pmd pages

wli-11_pgd_ctor-update.patch
  pgd_ctor update

stack-overflow-fix.patch
  stack overflow checking fix

smaller-slab-batches.patch
  Avoid losing timer ticks when slab debug is enabled.

printk-locking.patch
  remove unneeded locking in do_syslog()

ext2-allocation-failure-fix.patch
  Subject: [PATCH] ext2 allocation failures

ext2_new_block-fixes.patch
  ext2_new_block cleanups and fixes

hangcheck-timer.patch
  hangcheck-timer

jbd-documentation.patch
  JBD Documentation

slab-irq-fix.patch
  slab IRQ fix

Richard_Henderson_for_President.patch
  Subject: [PATCH] Richard Henderson for President!

parenthesise-pgd_index.patch
  Subject: i386 pgd_index() doesn't parenthesize its arg

sendfile-security-hooks.patch
  Subject: [RFC][PATCH] Restore LSM hook calls to sendfile

kernel-commandline-fix.patch
  Subject: Re: kernel param and KBUILD_MODNAME name-munging mess

macro-double-eval-fix.patch
  Subject: Re: i386 pgd_index() doesn't parenthesize its arg

mmzone-parens.patch
  asm-i386/mmzone.h macro paren/eval fixes

blkdev-fixes.patch
  blkdev.h fixes

modversions.patch
  Subject: [PATCH] new modversions

pcmcia_timer_init.patch
  pcmcia timer initialisation fixes

no_space_in_slabnames.patch
  remove spaces from slab names

remove-will_become_orphaned_pgrp.patch
  remove will_become_orphaned_pgrp()

buffer-io-accounting.patch
  correct wait accounting in wait_on_buffer()

aic79xx-linux-2.5.59-20030122.patch
  aic7xxx update

MAX_IO_APICS-ifdef.patch
  MAX_IO_APICS #ifdef'd wrongly

dac960-error-retry.patch
  Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry

epoll-update.patch
  epoll timeout and syscall return types ...

topology-remove-underbars.patch
  Remove __ from topology macros

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

put_user-warning-fix.patch
  Subject: Re: Linux 2.5.59

hash-warnings.patch
  fix #warning's

discarded-section-fix.patch
  Subject: [PATCH] discarded section errors (2.5.59)

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

atyfb-compile-fix.patch
  atyfb compilation fix

floppy-locking-fix.patch
  floppy locking fix

lost-tick.patch
  Lost tick compensation

sound-firmware-load-fix.patch
  soundcore.c referenced non-existent errno variable

generic_file_readonly_mmap-fix.patch
  Fix generic_file_readonly_mmap()

seq_file-page-defn.patch
  Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE

user-process-count-leak.patch
  fix current->user->processes leak

exit_mmap-fix-47.patch

show_task-fix.patch
  Subject: [PATCH] 2.5.59: show_task() oops

scsi-iothread.patch
  scsi_eh_* needs to run even during suspend

numaq-ioapic-fix2.patch
  NUMAQ io_apic programming fix

misc.patch
  misc fixes

writeback-sync-cleanup.patch
  Remove unneeded code in fs/fs-writeback.c

dont-wait-on-inode.patch
  Fix latencies during writeback

unlink-latency-fix.patch
  fix i_sem contention in sys_unlink()

pin_page-fix.patch
  Fix futexes in huge pages

frlock-xtime.patch
  fast reader locks for gettimeofday() and friends

frlock-xtime-i386.patch

frlock-xtime-ia64.patch

frlock-xtime-other.patch

do_gettimeofday-speedup.patch
  do_gettimeofday() optimisations

pte_chain_alloc-fixes.patch

hugetlbfs-set_page_dirty.patch
  give hugetlbfs a set_page_dirty a_op

compound-pages.patch
  Infrastructure for correct hugepage refcounting

compound-pages-hugetlb.patch
  convert hugetlb code to use compound pages



