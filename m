Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUC3Kfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 05:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUC3Kfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 05:35:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:63715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262497AbUC3Kej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 05:34:39 -0500
Date: Tue, 30 Mar 2004 02:34:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-mm1
Message-Id: <20040330023437.72bb5192.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm1/

- Dropped the tty locking fix.  As predicted, it deadlocked.  I also
  reverted the patch from bk-driver-core.patch which is causing this race to
  trigger more frequently.

- Added the rest of Ingo's recent CPU scheduler work.  This is for people
  to compare with 2.6.5-rc2-mm5.




Changes since 2.6.5-rc2-mm5:


 bk-alsa.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch
 bk-cpufreq.patch

 External trees

-ppc32-preempt-fixes.patch
-ppc32-sector_t-fix.patch
-nfsd-readdir_plus-fix.patch
-md-sector_t-fixes.patch
-md-sector_t-fixes-fix.patch
-SCHED_FIFO-fix.patch
-slab-vs-cpu-hotplug-fix.patch
-cmpci-warning-fixes.patch
-ptrace-use-correct-task.patch
-opl3sa2-warning-fix.patch
-cciss-MSA30-support.patch
-cciss-ENXIO-fix.patch
-stack-reductions-ice1712.patch
-ide-pm-undebug.patch
-x86-defconfig-update.patch
-proc-swaps-tidiness.patch
-viocd-proc-partitions.patch
-parport-daisy-undef-DEBUG.patch
-inode-dirtying-timestamp-fix.patch

 Merged

+sysfs-class-10-vc-revert.patch

 Avoid the tty oops

-tty-locking-again.patch

 Dropped

+sched-domain-setup-lock.patch
+sched-domain-setup-lock-ppc64-fix.patch
+sched-ingo-rollup.patch

 CPU scheduler work

+noexec-stack-ia64-fix.patch

 Make the noexec-stack code compile on ia64.

 This may be wrong, but this kernel oopses fairly quickly on ia64 anyway,
 due to problems in remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch

+early-param-i386-nolapic-fix.patch

 make the `nolapic' option an __early_param.

+fget-speedup.patch

 Save a few instructions in fget() and fget_light()

+ksoftirqd-barrier.patch

 Add missing barriers

+max_map_count-sysctl.patch

 /proc/sys/vm/max_map_count

+move-__this_module-to-modpost.patch

 Module cleanup

+support-zerobased-floppies.patch

 Support floppies which start at sector 0

+loop-bd_setsize-fix.patch

 Fix setting of the size of loop devices

+yenta-TI-irq-routing-fix.patch

 PCMCIA IRQ routing fix

+earlier-page_address_init.patch

 Run page_address_init() earlier.

+remove-bitmap-length-limits.patch

 bitmap stuff.

+pdflush-nice-0.patch

 Run pdflush at `nice 0'.

+rw_swap_page_sync-fix.patch

 Really add pages to swapcache in rw_swap_page_sync().  Will fix BUG() with
 swsusp resume.

+early-identify-cpu.patch

 Identify the x86 CPU capabilities much earlier: we need to know these
 things during early bootup.





All 326 patches:


bk-alsa.patch

bk-driver-core.patch

bk-i2c.patch

bk-ieee1394.patch

bk-input.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

bk-cpufreq.patch

mm.patch
  add -mmN to EXTRAVERSION

gcc-35-epautoconf-build-fix.patch
  drivers/usb/gadget/epautoconf.c gcc-3.5 build fix

sysfs-class-10-vc-revert.patch
  revert the sysfs-class-for-vc's patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-configuration-logic-fix.patch
  kgdboe: fix configuration of MAC address

kgdboe-configuration-logic-fix-fix.patch

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

vt-cleanup.patch
  vt.c cleanup

con_open-speedup.patch
  con_open() speedup/cleanup

remove-down_tty_sem.patch
  remove down_tty_sem()

kconfig-url-fixes.patch
  Fix URLs in Kconfig files

Lindent-devfs.patch
  feed devfs through Lindent

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

i4l-kernelcapi-rework.patch
  i4l: kernelcapi receive workqueue and locking rework

types_h-needs-config_h.patch
  types.h needs config.h

ppc64-reloc_hide.patch

quota-locking-fixes.patch
  Quota locking fixes

quota-locking-fixes-update.patch
  quota locking fix - new version

ext3-journalled-quotas.patch
  Journalled quota patch

ext3-journalled-quotas-export.patch
  ext3-journalled-quotas export

inode-cleanup.patch
  fs/inode.c list_head cleanup

initramfs-search-for-init-orig.patch
  search for /init for initramfs boots

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

nfs-01-prepare_nfspage.patch
  Subject: [PATCH] Prepare NFS asynchronous read/write structures for 	rsize/wsize < PAGE_SIZE

nfs-02-small_rsize.patch
  Subject: [PATCH] Add asynchronous read support for rsize<PAGE_SIZE

nfs-02-small_rsize-warning-fixes.patch
  Fix nfs-02-small_rsize ppc64 warnings

nfs-03-small_wsize.patch
  Subject: [PATCH] Add asynchronous write support for wsize<PAGE_SIZE

nfs-03-small_wsize-warning-fixes.patch
  Fix ppc64 warnings in nfs-03-small_wsize patch

nfs-04-congestion.patch
  Subject: [PATCH] Throttle writes when memory pressure forces a flush

nfs-05-unrace.patch
  Subject: [PATCH] Remove a couple of races in RPC layer...

nfs-06-rpc_throttle.patch
  Subject: [PATCH] add fair queueing to the RPC scheduler.

nfs-07-rpc_fixes.patch
  Subject: [PATCH] Close some potential scheduler races in rpciod.

nfs-08-short_rw.patch
  Subject: [PATCH] Add support for short reads/writes (< rsize/wsize)

nfsv4-updates.patch
  nfsv4 updates

knfsd-01-oops-fix.patch
  knfsd: Return -EOPNOTSUPP when unknown mechanism name encountered

knfsd-02-auth-error-return-fix.patch
  knfsd: Minor fix to error return when updating server authentication information

knfsd-03-auth_error-formatting-fix.patch
  knfsd: fix a problem with incorrectly formatted auth_error returns.

knfsd-04-remove-name_lookup_h.patch
  knfsd: Remove name_lookup.h that noone is using anymore.

knfsd-05-mounted_on_fileid-support.patch
  knfsd: Add server-side support for the nfsv4 mounted_on_fileid attribute.

knfsd-06-UTF8-improvements.patch
  knfsd: Improve UTF8 checking.

knfsd-07-auth_gss-export.patch
  knfsd: Export a symbol needed by auth_gss

knfsd-08-gss-integrity.patch
  knfsd: Add data integrity to serve rside gss

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

sched-domain-setup-lock-ppc64-fix.patch

sched-ingo-rollup.patch
  sched: Ingo's leftover bits

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

lightweight-auditing-framework.patch
  Light-weight Auditing Framework

lightweight-auditing-framework-update-1.patch
  Light-weight Auditing Framework update

lightweight-auditing-framework-warning-fix.patch
  lightweight-auditing-framework warning fixes

lightweight-auditing-framework-receive-filter-fixes.patch
  Light-weight Auditing Framework receive filter fixes

lightweight-auditing-framework-receive-filter-fixes-fix.patch
  lightweight-auditing-framework-receive-filter-fixes compile fix

selinux-compute_sid-fixes.patch
  selinux: Audit compute_sid errors

selinux-remove-ratelimit.patch
  selinux: remove ratelimit from avc

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

mq-01-codemove.patch
  posix message queues: code move

mq-02-syscalls.patch
  posix message queues: syscall stubs

mq-03-core.patch
  posix message queues: implementation

mq-03-core-update.patch
  posix message queues: update to core patch

mq-04-linuxext-poll.patch
  posix message queues: linux-specific poll extension

mq-05-linuxext-mount.patch
  posix message queues: made user mountable

mq-update-01.patch
  posix message queue update

mq-security-fix.patch
  security bugfix for mqueue

queue-congestion-callout.patch
  Add queue congestion callout

queue-congestion-dm-implementation.patch
  Implement queue congestion callout for device mapper
  devicemapper: use rwlock for map alterations
  Another DM maplock implementation

dm-remove-__dm_request.patch
  dmL remove __dm_request
  per-backing dev unplugging

per-backing_dev-unplugging.patch
  per-backing dev unplugging
  dm plug buglet
  per-backing-dev unplugging: fix BIO_RW_SYNC handling
  per-backing dev unplugging oops fix #42
  fix md for per-address_space unplugging
  more backing_dev unplug functions
  plugged bit

per-backing_dev-unplugging-unplug_delay.patch
  per address_space unplug: tunesup, kill debug code.

correct-unplugs-on-nr_queued.patch
  Correct unplugs on nr_queued
  correct-unplugs-on-nr_queued fix

siimage-update.patch
  ide: update for siimage driver

ipmi-updates-3.patch
  IPMI driver updates

ipmi-acpi-build-fix.patch
  ipmi build fix

ipmi-socket-interface.patch
  IPMI: socket interface

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

move-job-control-stuff-tosignal_struct.patch
  move job control fields from task_struct to signal_struct
  s390 fix for move-job-control-stuff-tosignal_struct.patch
  Subject: [PATCH] 2.6.4-mm1 for ia64
  move-job-control-stuff-tosignal_struct-sparc64-fix

move-job-control-stuff-tosignal_struct-ebtables-fix.patch
  move-job-control-stuff-tosignal_struct-ebtables-fix

devinet-ctl_table-fix.patch
  devinet_ctl_table[] null termination

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

lower-zone-protection-numa-fix.patch
  Fix page allocator lower zone protection for NUMA

ext3-fsync-speedup.patch
  ext3 fsync() and fdatasync() speedup

ext2-fsync-speedup-2.patch
  speed up ext2 fsync() and fdatasync()

jbd-commit-ordered-fix.patch
  jbd: fix ordered-data writeout logic

jbd-move-locked-buffers.patch
  JBD: ordered-data commit cleanup

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jbd-iobuf-error-handling-fix.patch
  jbd: fix I/O error handling

readv-writev-check-fix.patch
  readv/writev range checking fix

kerneldoc-handle-attributes.patch
  Fix scripts/kernel-doc to handle __attribute__

slab-alignment-rework.patch
  slab: updates for per-arch alignments
  slab-alignment-rework merge fix

set-mod-waiter-before-calling-stop_machine.patch
  Set mod->waiter Before Calling stop_machine

procfs-comment-fixes.patch
  fs/proc/proc_tty.c comment fixes

sb_mixer-bounds-checking.patch
  sb_mixer bounds checking

powernow-k8-update.patch
  powernow-k8 update

pmdisk-store-handling-fix.patch
  pmdisk: fix strcmp in sysfs store

file-operations-fcntl.patch
  add file_operations.fcntl

file-operations-fcntl-tidies.patch
  file-operations-fcnt tidies

O_LARGEFILE-fix.patch
  Hide forced O_LARGEFILE from userspace

jgarzik-warnings.patch

sys_time-subtick-correction-fix.patch
  Fix sys_time() to get subtick correction from the new xtime

bitmap_parse-fix.patch
  Broken bitmap_parse for ncpus > 32

ver_linux-fix.patch
  ver_linux fix

codingstyle-fix-for-emacs.patch
  Update CodingStyle hints for Emacs users.

document-unused-i386-pte-bits.patch
  document unused pte bits on i386

docbook-sgml-quotes-fix.patch
  Consistently use quotes for SGML attributes

sgml-close-tags.patch
  SGML: close tag with ">"

sch_ingress-help-fix.patch
  fix sch_ingress help

i386-irq-cleanup.patch
  i386 irq.c ifdef cleanup

firmware-loader-docs-fix.patch
  Fix firmware loader docs

trivial-patches-in-maintainers.patch
  Trivial Patch Monkey should be in MAINTAINERS

genksyms-parser-fix.patch
  Fix genksyms parsing

CONFIG_X86_GENERIC-help-fix.patch
  CONFIG_X86_GENERIC description fixup

credits-update.patch
  updating email info in CREDITS

device-h-duplicate-include.patch
  Kill duplicate #include <linux_ioport.h>

unmapped-CPU-node-number-fix.patch
  Use valid node number when unmapping x86 CPUs

submitting-trivial-patches.patch
  Add CC Trivial Patch Monkey to SubmittingPatches

ne2k-pic-build-fix.patch
  ne2k-pci.c compile fix on ppc[64]

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

doc-changes-update.patch
  Update Documentation/Changes

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fixes-ppc.patch
  signal-race fixes for ppc32 and ppc64

BLKPREP_KILL-fix.patch
  Fix BLKPREP_KILL

autofs-dnotify-signal-fix.patch
  dnotify + autofs may create signal/restart syscall loop

bio_pair_end-fix.patch
  catch errors when completing bio pairs

posix-timers-thread.patch
  fix posix-timers to have proper per-process scope

md-merging-fix.patch
  md: merge_bvec_fn needs to know about partitions.

noexec-stack.patch
  Non-Exec stack support

noexec-stack-ia64-fix.patch
  PAGE_COPY_EXEC for ia64

drm-put_user-fixes.patch
  i830 DRM missing put_user

ext3-transaction-batching-fix.patch
  Fix ext3 transaction batching

si_band-is-long.patch
  siginfo.si_band is long

warn-on-mdelay-in-irq-handlers.patch
  Warn on mdelay() in irq handlers

reiserfs-nesting-02.patch
  reiserfs: support for nested transactions

reiserfs-journal-writer.patch
  reiserfs: cleanups

reiserfs-logging.patch
  reiserfs: logging rework

reiserfs-jh-2.patch
  reiserfs: data=ordered support

reiserfs-prealloc.patch
  reiserfs: preallocation support

reiserfs-tail-jh.patch
  reiserfs: tail repacking fix

reiserfs-writepage-ordered-race.patch
  reiserfs: fix race with writepage

reiserfs-file_write_hole_sd.diff.patch
  reiserfs: sparse file handling fix

reiserfs-laptop-mode.patch
  reiserfs: laptop-mode support

reiserfs-truncate-leak.patch
  reiserfs: truncate leak fix

reiserfs-ordered-lat.patch
  reiserfs: scheduling latency improvements

reiserfs-dirty-warning.patch
  reiserfs: fix dirty-buffer warnings

reiserfs_kfree-warning-fix.patch
  reiserfs_kfree warning fix

reiserfs-writepage-race-fix.patch
  reiserfs writepage race with data=ordered

export-complete_all.patch
  export complete_all()

urandom-scalability-fix.patch
  /dev/urandom scalability improvement

load_elf_binary-overflow-detection-fix.patch
  binfmt_elf.c fix for 32-bit apps with large bss

stack-reductions-ide-cd.patch
  stack reduction: ide-cd

stack-reductions-ide.patch
  stack reductions: ide

stack-reductions-isdn.patch
  stack reduction: ISDN

stack-reductions-nfsread.patch
  stack reductions: nfs read

stack-reductions-nfsroot.patch
  stack reductions: nfs root

stack-reductions-sk98lin.patch
  stack reduction: sk98lin

early-param-core.patch
  Add __early_param for all arches

early-param-core-retval-fix.patch
  Support error return for early command line parsing

early-param-i386.patch
  __early_param for i386

early-param-i386-nolapic-fix.patch

early-param-ppc.patch
  __early_param for ppc

early-param-ppc-fixes.patch
  ppc: further early_param fixes

early-param-arm.patch
  __early_param for arm

early-param-alpha.patch
  __early_param for alpha

early-param-arm26.patch
  __early_param for arm26

early-param-cris.patch
  __early_param for cris

early-param-h8300.patch
  __early_param for h8300

early-param-ia64.patch
  __early_param for ia64

early-param-m68k.patch
  __early_param for m68k

early-param-m68knommu.patch
  __early_param for m68knommu

early-param-mips.patch
  __early_param for mips

early-param-parisc.patch
  __early_param for parisc

early-param-ppc64.patch
  __early_param for ppc64

early-param-s390.patch
  __early_param for s390

early-param-sh.patch
  __early_param for SH

early-param-sparc.patch
  __early_param for sparc

early-param-sparc64.patch
  __early_param for sparc64

early-param-um.patch
  __early_param for UM

early-param-v850.patch
  __early_param for v850

early-param-x86_64.patch
  __early_param for x86_64

early-param-x86_64-fix.patch
  Fix x86-64 early command line parsing

probe_roms-01-move-stuff.patch
  i386 probe_roms(): preparation

probe_roms-02-fixes.patch
  i386 probe_roms(): fixes

hugetlb-overcommit-fix.patch
  Fix hugetlb-vs-memory overcommit

remove-__ARCH_SI_BAND_T.patch
  remove __ARCH_SI_BAND_T

8250-resource-management-fix.patch
  Subject: pcmcia/serial release of memory I/O twice

speed-up-sata.patch
  speed up SATA

cpu5wdt-warning-fix.patch
  cpu5wdt.c warning fix

fget-speedup.patch
  speed up fget() and fget_light()

ksoftirqd-barrier.patch
  ksoftirqd: missing barrier

max_map_count-sysctl.patch
  Replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count

move-__this_module-to-modpost.patch
  Move __this_module to modpost

support-zerobased-floppies.patch
  Support for floppies whose sectors are numbered from zero instead of one

loop-bd_setsize-fix.patch
  loop setup calling bd_set_size too soon

yenta-TI-irq-routing-fix.patch
  yenta: interrupt routing for TI briges

earlier-page_address_init.patch
  run page_address_init() earlier

remove-bitmap-length-limits.patch
  Remove bitmap_shift_*() bitmap length limits

pdflush-nice-0.patch
  Make pdflush run at nice 0

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix
  AIO/direct-io oops fix

rw_swap_page_sync-fix.patch
  rw_swap_page_sync(): placxe the pages in swapcache

radix-tree-tagging.patch
  radix-tree tags for selective lookup

irq-safe-pagecache-lock.patch
  make the pagecache lock irq-safe.

tag-dirty-pages.patch
  tag dirty pages as such in the radix tree

tag-writeback-pages.patch
  tag writeback pages as such in their radix tree

stop-using-dirty-pages.patch
  stop using the address_space dirty_pages list

kupdate-function-fix.patch
  fix the kupdate function

stop-using-io-pages.patch
  remove address_space.io_pages

stop-using-locked-pages.patch
  Stop using address_space.locked_pages
  stop-using-locked-pages fix
  wait_on_page_writeback_range fix

stop-using-clean-pages.patch
  stop using address_space.clean_pages

unslabify-pgds-and-pmds.patch
  revert the slabification of i386 pgd's and pmd's

slab-stop-using-page-list.patch
  slab: stop using page.list

page_alloc-stop-using-page-list.patch
  stop using page.list in the page allocator

hugetlb-stop-using-page-list.patch
  stop using page->list in the hugetlbpage implementations

hugetlb-stop-using-page-list-sh.patch

pageattr-stop-using-page-list.patch
  stop using page.list in pageattr.c

readahead-stop-using-page-list.patch
  stop using page.list in readahead

compound-pages-stop-using-lru.patch
  stop using page->lru in compound pages

arm-stop-using-page-list.patch
  arm: stop using page->list

m68k-stop-using-page-list.patch
  switch the m68k pointer-table code over to page->lru

remove-page-list.patch
  remove page.list

clear_page_dirty_for_io.patch
  fdatasync integrity fix

block_write_full_page-redirty.patch
  don't permit background writes to hide dirty buffers

writeback-search-start.patch
  writeback efficiency and QoS improvements

mpage_writepages-latency-fix.patch
  Add mpage_writepages() scheduling point

kswapd-remove-pages-scanned.patch
  kswapd: remove pages_scanned local

laptop-mode-3.patch
  laptop mode

xfs-sync-fix.patch
  xfs sync fix

vmscan-less-sleepiness.patch
  vmscan: Fix up the determination of when to throttle

tunable-pagefault-readaround.patch
  Honour the readahead tunable in filemap_nopage()

laptop-mode-readahead.patch
  Update laptop-mode documentation to describe readahead usage

filemap_nopage-busywait-fix.patch
  Fix logic in filemap_nopage()

swp_entry-vs-swap_pte-fix.patch
  Fix swp_entry_t encoding

swp_entry-vs-swap_pte-fix-fix.patch

remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
  per-page protections for remap_file_pages()

remap_file_pages-errno-fix.patch
  remap_file_pages error retun fix

ppc32-pgtable-fixes.patch
  ppc32 pgtable.h fixes for -mm4

remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
  remap_file_pages page-prot implementation for ia64

remap-file-pages-prot-s390.patch
  s390: remap-file-pages-prot support

remap-file-pages-prot-sparc64.patch
  remap-file-pages-prot: sparc64 support

remap-file-pages-prot-ppc64.patch
  remap-file-pages-page-prot ppc64 support

remap-file-pages-prot-ppc64-more.patch

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

ia32-4k-stacks.patch
  ia32: 4Kb stacks (and irqstacks) patch

ia32-4k-stacks-remove-44-dependency.patch

4k-stacks-4g4g-interaction-fix.patch
  fix interaction between 4k stacks and 4g:4g

ia32-4k-stacks-build-fix.patch
  4k stacks build fix

4k-stacks-in-modversions-magic.patch
  Add 4k stacks to module version magic

4k-stacks-always-on.patch
  Permanently enable 4k stacks on ia32

reslabify-pgds-and-pmds-2.patch

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix
  zap_low_mappings() cannot be __init
  4g/4g: remove printk at boot
  4g4g: fix handle_BUG()
  4g4g: acpi sleep fixes

4g4g-sched-warning-fix.patch
  sched.c warning fixes

4g4g-restore-4k-stacks-stuff.patch
  4g4g: make it play with 4k stacks

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

4g4g-variable-stack-size.patch
  Fix 4G/4G w/ 8k+ stacks

early-identify-cpu.patch
  early CPU identification



