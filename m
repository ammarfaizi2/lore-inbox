Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTCOJHU>; Sat, 15 Mar 2003 04:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCOJHU>; Sat, 15 Mar 2003 04:07:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:42887 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261335AbTCOJHN>;
	Sat, 15 Mar 2003 04:07:13 -0500
Date: Sat, 15 Mar 2003 01:17:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.64-mm7
Message-Id: <20030315011758.7098b006.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 09:17:49.0553 (UTC) FILETIME=[BFBB7E10:01C2EAD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm7/

  kernel.org rsync seems broken, so it is also at

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.64/2.5.64-mm7/


. Niggling bugs in the anticipatory scheduler are causing problems.  I've
  reset the default to elevator=deadline until we get these fixed up.

. Added Alex's ext2 lock_super-removal patches

. The brlock removal patches are back

. Added /proc/sysrq-trigger.  Writing a character to this has the same
  effect as typing ALT-sysrq-that_character.

  This is so that sysrq facilities are available remotely.

. Lots of new PCI handling code here from Russell King <rmk@arm.linux.org.uk>




Changes since 2.5.64-mm6:


-nfsd-disable-softirq.patch
-lockd-lockup-fix-2.patch
-reiserfs-fix-memleaks.patch
-nfsd-memleak-fix.patch

 Merged

+as-eject-BUG-fix.patch

 Fix an anticipatory scheduler BUG when cdroms are ejected

+deadline-default.patch

 Default to deadline scheduler

+scheduler-starvation-fixes.patch

 CPU scheduler tweaks

+timer-cleanup.patch
+timer-readdition-fix.patch

 Fix timer livelock

+oprofile-timer-fix.patch

 Oprofile fix

+htree-nfs-fix-2.patch

 Another fix for ext3/htree on NFS servers

+ext2-balloc-fix.patch

 Fix logic in the ext2 block allocator

+ext2-no-lock_super.patch
+ext2-no-lock-super-whitespace-fixes.patch
+ext2-no-lock_super-fix-1.patch
+ext2-no-lock_super-fix-2.patch
+ext2-no-lock_super-fix-3.patch
+ext2-no-lock_super-fix-4.patch
+ext2-no-lock_super-fix-5.patch
+ext2-no-lock_super-fix-6.patch
+ext2-no-lock_super-fix-7.patch

 Removal of lock_super in the ext2 block allocator

+brlock-removal-1.patch
+brlock-removal-2.patch
+brlock-removal-3.patch
+brlock-removal-4.patch
+brlock-removal-5.patch

 Second pass of the brlock removal patches

+pgd_index-comments.patch

 Add some comments

+pci-6.patch
+pci-7.patch
+pci-8.patch
+pci-9.patch
+pci-10.patch
+pci-11.patch
+pci-12.patch
+pci-13.patch
+pci-14.patch
+pci-15.patch

 Some of Russell King's PCI patches.

+proc-sysrq-trigger.patch

 Create /proc/sysrq-trigger

+aio-bits-fix.patch

 AIO fixes

+clean-inode-fix.patch

 Forgot to initialise inode->i_rdev




All 116 patches:

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

kgdb.patch

noirqbalance-fix.patch
  Fix noirqbalance

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Pass the load address into ELF_PLAT_INIT()

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-compat-flock.patch
  compat_sys_fcntl{,64} 2/9 ppc64 part

ppc64-eeh-fix.patch
  ppc64 build fix

ppc64-socketcall-fix.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

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

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

as-iosched.patch
  anticipatory I/O scheduler

as-debug-BUG-fix.patch

as-eject-BUG-fix.patch
  AS: don't go BUG during cdrom eject

cfq-2.patch
  CFQ scheduler, #2

deadline-default.patch
  deafult to deadline IO scheduler

smalldevfs.patch
  smalldevfs

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

hugh-remap-fix.patch
  hugh's file-offset-in-pte fix

fremap-limit-offsets.patch
  fremap: limit remap_file_pages() file offsets

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

filemap_populate-speedup.patch
  filemap_populate speedup

file-offset-in-pte-x86_64.patch
  x86_64: support for file offsets in pte's

file-offset-in-pte-ppc64.patch

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-nonlinear-fixes.patch
  objrmap fix for nonlinear

scheduler-tunables.patch
  scheduler tunables

scheduler-starvation-fixes.patch
  CPU scheduler starvation fixes

timer-cleanup.patch
  timer code cleanup

timer-readdition-fix.patch
  timer re-addition lockup fix

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

task_prio-fix.patch
  simple task_prio() fix

register-tty_devclass.patch
  Register tty_devclass before use

set_current_state-fs.patch
  use set_current_state in fs

set_current_state-mm.patch
  use set_current_state in mm

copy_thread-leak-fix.patch
  Fix memory leak in copy_thread

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

file_list_lock-contention-fix.patch
  file_list_lock contention fixes

tty_files-fixes.patch
  file->f_list locking in tty_io.c

file_list_cleanup.patch
  file_list cleanup

file_list-remove-free_list.patch
  file_table: remove the private freelist

file-list-less-locking.patch
  file_list: less locking

vt_ioctl-stack-use.patch
  stack reduction in drivers/char/vt_ioctl.c

fix-mem-equals.patch
  Fix mem= options

no-mmu-stubs.patch
  a few missing stubs for !CONFIG_MMU

nommu-slab.patch
  slab changes for !CONFIG_MMU

nfs-memleak-fix.patch
  memleak in fs/nfs/inode.c::nfs_get_sb()

ufs-memleak-fix.patch
  Memleak in fs/ufs/util.c

hugetlb-unmap_vmas-fix.patch
  fix the fix for unmap_vmas & hugepages

early-writeback-init.patch
  Early writeback initialisation

posix-timers-update.patch
  posix timers update

e100-memleak-fix.patch
  Memleak in e100 driver

pcmcia-1-kill-get_foo_map.patch
  pcmcia: 1/6 kill get_*_map

pcmcia-2-remove-bus_foo-abstractions.patch
  pcmcia: 2/6: Remove bus_* abstractions

pcmcia-3-add-SOCKET_CARDBUS_CONFIG.patch
  pcmcia: 3/6: add SOCKET_CARDBUS_CONFIG flag

pcmcia-4-add-locking.patch
  pcmcia: 4/6: Add some locking to rsrc_mgr.c

pcmcia-5-add-CONFIG_PCMCIA_PROBE.patch
  pcmcia 5/6: Introduce CONFIG_PCMCIA_PROBE

pcmcia-6-remove-old-cardbus-clients.patch
  pcmcia: 6/6: Remove support for old cardbus clients

oops-counters.patch
  OOPS instance counters

io_apic-DO_ACTION-cleanup.patch
  io-apic.c: DO_ACTION cleanup

ext2-ext3-noatime-fix.patch
  Ext2/3 noatime and dirsync sometimes ignored

oprofile-timer-fix.patch
  fix oprofile timer race

htree-nfs-fix-2.patch
  htree nfs fix

ext2-balloc-fix.patch
  ext2: block allocation fix

ext2-no-lock_super.patch
  concurrent block allocation for ext2

ext2-no-lock-super-whitespace-fixes.patch

ext2-no-lock_super-fix-1.patch

ext2-no-lock_super-fix-2.patch

ext2-no-lock_super-fix-3.patch

ext2-no-lock_super-fix-4.patch

ext2-no-lock_super-fix-5.patch

ext2-no-lock_super-fix-6.patch

ext2-no-lock_super-fix-7.patch

brlock-removal-1.patch
  Brlock removal 1/5 - core

brlock-removal-2.patch
  brlock removal 2/5: remove brlock from snap and vlan

brlock-removal-3.patch
  brlock removal 3/5: remove brlock from bridge

brlock-removal-4.patch
  brlock removal 4/5: removal from ipv4/ipv6

brlock-removal-5.patch
  brlock removal 5/5: remove brlock code

pgd_index-comments.patch
  pgd_index/pmd_index/pte_index commentary

pci-6.patch

pci-7.patch

pci-8.patch

pci-9.patch

pci-10.patch

pci-11.patch

pci-12.patch

pci-13.patch

pci-14.patch

pci-15.patch

proc-sysrq-trigger.patch
  /proc/sysrq-trigger: trigger sysrq functions via /proc

aio-bits-fix.patch
  kiocbClear should use clear_bit instead of set_bit

clean-inode-fix.patch
  initialise inode->i_rdev



