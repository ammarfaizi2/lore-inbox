Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTEEGDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEEGDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:03:00 -0400
Received: from [12.47.58.20] ([12.47.58.20]:34414 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261879AbTEEGCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:02:53 -0400
Date: Sun, 4 May 2003 23:16:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm1
Message-Id: <20030504231650.75881288.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 06:15:15.0634 (UTC) FILETIME=[B1C15920:01C312CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm1/

Various random fixups, cleanps and speedups.  Mainly a resync to 2.5.69.




Changes since 2.5.68-mm4:


-compat-ioctl-fix.patch

 Merged

+generic-subarch-numaq-fix.patch

 Compile fix for the generic subarch patch

+3c59x-irq-fix.patch

 Fix IRQ strangeness with old-style 3com cards

-semop-race-fix.patch
+semop-race-fix-2.patch

 Updated patch from Mingming

+nfs-writeback-tweak.patch

 NFS writeout stability

+sysrq-fs-cleanups.patch
+sysrq-fs-cleanups-fixes.patch

 Clean up crufty sysrq handling code

+UPDATE_ATIME-update_atime.patch

 Remove UPDATE_ATIME()

+irqreturn-pcmcia_cs.patch

 Teach pcmcia_cs about new IRQ API

+printscreen-fix.patch

 Fix up ALT-sysrq keystroke decoding

+disk_name-no-devfs.patch

 Don't use devfs-style names in disk_name() if devfs is enabled.

+nobody-listens-to-wli.patch

 set_pgd() fixups

-slab_store_user-large-objects.patch
+slab-debugging-improvement.patch

 Enhancements to slab debugging infrastructure

+fget-speedup.patch
+fget-speedup-inline-fput_light.patch

 Speed up fastpaths in filesystem syscalls

+devfs-01-api-change.patch

 Internal devfs API rationalisation




All 110 patches


mm.patch
  add -mmN to EXTRAVERSION

generic-subarch.patch
  generic subarchitecture for ia32

generic-subarch-fix.patch
  generic subarch: SMP only

generic-subarch-missing-bit.patch
  generic subarch: missing chunk

generic-subarch-numaq-fix.patch
  generic subarch: NUMAQ fix

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-ppc64-fix.patch

irqreturn-kgdb-ga.patch

irqreturn-drivers-net.patch

kgdb-ga-smp_num_cpus.patch

kgdb-ga-discontigmem-fixup.patch
  kgdb: discontigmem fixup

slab-magazine-layer.patch
  magazine layer for slab

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-update.patch
  ppc64 update

ppc64-update-fixes.patch

ppc64-irqfixes.patch

ppc64-pci-bogons.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

misc.patch
  misc fixes

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

config-PAGE_OFFSET-025G.patch
  3.75G config option

fat-speedup.patch
  fat cluster search speedup

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

semop-race-fix-2.patch
  semop race fix #2

nfs-writeback-tweak.patch
  Tweak to NFS memory management for writes...

sysrq-fs-cleanups.patch
  sysrq-S, sysrq-U cleanups

sysrq-fs-cleanups-fixes.patch

UPDATE_ATIME-update_atime.patch
  s/UPDATE_ATIME/update_atime/ cleanup

irqreturn-pcmcia_cs.patch
  irqreturn_t for drivers/net/pcmcia

printscreen-fix.patch
  keyboard.c Fix CONFIG_MAGIC_SYSRQ+PrintScreen

reiserfs_file_write-5.patch

disk_name-no-devfs.patch
  Don't use devfs names in disk_name()

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

dcache_lock-vs-tasklist_lock-take-2.patch
  Fix dcache_lock/tasklist_lock ranking bug

clone-retval-fix.patch
  copy_process return value fix

de_thread-fix.patch
  de_thread memory corruption fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

386-access_ok-race-fix.patch
  access_ok() race fix for 80386.

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

swapfile-hold-i_sem.patch
  hold i_sem on swapfiles

dont-set-kernel-pgd-on-PAE.patch
  remove unnecessary PAE pgd set

nobody-listens-to-wli.patch
  set_pgd() update

shrink_slab-accounting.patch
  account for slab reclaim in try_to_free_pages()

slab-debugging-improvement.patch
  slab: additional debug checks

rq-dyn-works.patch
  rq-dyn, dynamic request allocation

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-use-completion.patch
  AS use completion notifier

as-remove-debug-checks.patch
  AS: remove debug checks

as-iosched-dyn.patch
  AS: update to dynamic request allocation API

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

cfq-iosched-dyn.patch
  CFQ: update to rq-dyn API

unmap-page-debugging.patch
  unmap unused pages for debugging

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

fget-speedup.patch
  reduced overheads in fget/fput

fget-speedup-inline-fput_light.patch
  inline fput_light()

devfs-01-api-change.patch
  devfs: API changes

sched-2.5.68-B2.patch
  HT scheduler, sched-2.5.68-B2

sched_idle-typo-fix.patch
  fix sched_idle typo

kgdb-ga-idle-fix.patch

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

i8042-share-irqs.patch
  allow i8042 interrupt sharing

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

select-speedup-fix.patch
  select() sleedup fix

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

security_d_instantiate-movement.patch
  Move security_d_instantiate hook calls

ext3-security-xattr.patch
  ext3 xattr handler for security modules

ext2-security-xattr.patch
  ext2 xattr handler for security modules

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

pcmcia-deadlock-fix-2.patch
  Fix PCMCIA deadlock (rev. 2)

pcmcia-fix.patch

kexec.patch
  kexec



