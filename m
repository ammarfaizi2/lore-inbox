Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUA1Hee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 02:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbUA1Hee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 02:34:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:41871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265837AbUA1Hdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 02:33:45 -0500
Date: Tue, 27 Jan 2004 23:34:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.2-rc2-mm1
Message-Id: <20040127233402.6f5d3497.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/


- From now on, -mm kernels will contain the latest contents of:

	Linus's tree:		linus.patch
	The ACPI tree:		acpi.patch
	Vojtech's tree:		input.patch
	Jeff's tree:		netdev.patch
	The ALSA tree:		alsa.patch

  If anyone has any more external trees which need similar treatment,
  please let me know.

- Various fixes.  Nothing stands out.




Changes since 2.6.2-rc1-mm3:


 linus.patch

 Latest linus tree

-alsa-101.patch
+alsa.patch

 Latest ALSA tree
 
 netdev.patch

 Latest net-drivers tree

+input.patch

 Latest input driver tree

-spinlock-debugging-fix.patch
-ide-pdc4030-build-fix.patch
-acpi-support-FADT-rev3-XDSDT-table.patch
-acpi-frees-irq0.patch
-gcc-35-lmc.patch
-gcc-35-ne2k-pci.patch
-ia64-include-i2c-in-config.patch

 Merged into Linus's tree

-alsa-cmipci-joystick-fix.patch

 Merged into ALSA tree

-r8169-race-fix.patch

 Merged into net driver tree

+kgdb-x86_64-support.patch

 x86_64 KGDB support

+kernel_flag-fixes.patch

 Clean up the spinlock debugging fix

+pmdisk-needs-uts_name.patch

 Build fix

-big-pmac-update.patch
+big-pmac-3.patch

 Updated powermac patch

+ppc64-config_h.patch
+ppc64-export_symbols.patch
+ppc64-lparcfg_fixes.patch
+ppc64-slb_rewrite.patch
+ppc64-xmon-sysrq.patch

 PPC64 work

-sysfs-pin-kobject.patch

 Dropped - was implicated in some oopses.

+vm-rss-limit-enforcement.patch

 Attempt to enforce per-process resident set size limits.

+add-noinline-attribute.patch
+dont-inline-rest_init.patch
+kernel_thread_helper-section-fix.patch

 More fiddling with gcc options.

+gcc-35-netlink.patch
+gcc-35-packet.patch
+gcc-35-x86_64.patch

 More gcc-3.5 fixes

+ide-pdc4030-build-fix.patch

 IDE compile fix

-kconfig-use-select.patch
+kconfig-use-select-2.patch

 Updated

+edd-url-fix.patch

 Documentation fix

-md-06-allow-partitioning.patch

 Dropped - crashy.

-md-07-md-appear-in-proc-partitions.patch

 Dropped - we're doing this differently.

+proc-partitions-omit-removable-media.patch

 Skip removable media in /proc/paritions.

+posix-timers-fixes.patch

 posix timers cleanups and fixes

-SIGRTMAX-fix.patch

 Included in posix-timers-fixes.patch

-ufs-mount-noisiness.patch
-ufs-doc-update.patch

 Dropped - we can solve this problem by trying reiserfs earlier in boot.

+futex-redundant-test.patch

 Remove unneeded futex code.

+CONFIG_SYSRQ-fixes.patch

 Somearchitectures were using the wrong CONFIG option

+dz-verify_area-removal.patch

 Driver cleanup

+oss-c99-fixes.patch

 c99ify some OSS drivers

+usb-sddr09-documentation.patch

 Document some SmartMedia internals

+console-makefile-cleanup.patch

 Makefile fixes

+oprofile-ringbuffer-wrap-fix.patch
+oprofile-alpha-fix.patch

 oprofile fixes

+copy_namespace-enomem-fix.patch

 Handle ENOMEM

+vgastate-missing-iounmaps.patch
+vga16fb-missing-iounmap.patch

 Add some missing iounmap()s on error paths

+compat_siginfo-consolidation.patch

 Consolidate some compat layer code.

+compat_siginfo-consolidation-fix.patch

 Fix a warning in it

+d_path-needs-vfsmount_lock.patch
+namei-needs-vfsmount_lock.patch

 Avoid some possible lookup-vs-[u]mount races

+try-reiserfs-earlier.patch

 Try reiserfs much earlier in the boot sequence - reiserfs puts its
 superblock in a weird place and tends to get false positives.  (Should be
 fixed in mkreiserfs!)

+ufs-use-silent.patch

 Honour the `silent' option in ufs_fill_super().

+time-rounding-accuracy.patch

 Improve rounding accuracy in the timekeeping code

+proc-stat-btime-fix-2.patch

 Make /proc/stat:btime stay still

+menuconfig-choice-display-fix.patch

 menufix help text fixes

+use-uint32_t-for-crosscompiling.patch

 cross-compilation fix

+ac97-remove-fix.patch

 Avoid oopses when removing the ac97 OSS driver

+show_task-fix.patch

 Part-fix possible oops in show_task.




All 376 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

alsa.patch

netdev.patch

input.patch

speedo-warning-fix.patch
  eepro100.c warning fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdb-doc-fix.patch
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

x86_64-warnings-fix.patch
  Fix two warnings on x86-64

kernel_flag-fixes.patch
  Fix kernel_flag again

pmdisk-needs-uts_name.patch
  pmdisk.c needs utsname.h

ppc32-MBX-mac-address-fix.patch
  ppc32: MBX MAC address fix

ppc32-watchdog-defines-fixes.patch
  ppc32: watchdog definition fixes

big-pmac-3.patch

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

ppc64-include_guards.patch
  ppc64: add missing include guards, from Nathan Lynch

ppc64-lparcfg_write.patch
  ppc64: lparcfg_write

ppc64-no_device_tree.patch
  ppc64: fixes for compile with CONFIG_PROC_DEVICETREE=n, from Nathan Lynch

ppc64-ppc32_timer_create.patch
  ppc64: missing set_fs(KERNEL_DS) in ppc32_timer_create, from Marcus Meissner

ppc64-defconfig_update.patch
  ppc64: defconfig update

ppc64-use-preferred-console.patch
  ppc64: Use preferred_console to select a reasonable default console

ppc64-config_h.patch
  ppc64: add/remove config.h

ppc64-export_symbols.patch
  ppc64: export memchr and csum_partial

ppc64-lparcfg_fixes.patch
  ppc64: fix && vs & bugs in lparcfg, from Julie DeWandel

ppc64-slb_rewrite.patch
  ppc64: SLB rewrite

ppc64-xmon-sysrq.patch

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

nuke-noisy-printks.patch
  quiet down SMP boot messages

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

get_user_pages-handle-VM_IO.patch

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

loop-remove-redundant-assignment.patch
  loop: remove redundant initialisation

acpi-pm-timer-3.patch
  ACPI PM timer version 3

acpi-pm-timer-kill-printks.patch

use-pmtmr-for-delay_pmtmr.patch
  Subject: Re: pester mingo@redhat.com

use-TSC-for-delay_pmtmr.patch
  use-tsc-for-delay_pmtmr.patch

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alsa-pnp-fix.patch
  ALSA pnp fix

sysfs-class-10-vc.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for vc devices [10/10]

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-clock-fixes.patch
  fix sched_clock()

sched-build-fix.patch
  sched: fix for NR_CPUS > BITS_PER_LONG

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

p4-clockmod-sibling-map-fix.patch
  p4-clockmod sibling_map fix

p4-clockmod-more-than-two-siblings.patch
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

sched-find_busiest_group-fix.patch
  sched: Fix CONFIG_SMT oops on UP

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-arch_init_sched_domains-fix.patch
  Change arch_init_sched_domains to use cpu_online_map

sched-find_busiest_group-clarification.patch
  sched: clarify find_busiest_group

sched-remove-noisy-printks.patch

acpi-numa-printk-level-fixes.patch
  ACPI NUMA quiet printk and cleanup

futex-wakeup-debug.patch

ide-siimage-seagate.patch

ide-ali-UDMA6-support.patch
  IDE: Add support of UDMA6 on ALi rev > 0xc4

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates

laptop-mode-doc-update-4.patch
  Laptop mode documentation addition

vt-locking-fixes-2.patch
  VT locking fixes

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

kthread-primitive.patch
  kthread primitive

kthread-block-all-signals.patch
  kthread: block all signals

use-kthread-primitives.patch
  Use kthread primitives

ide-pci-modules-fix.patch
  fix issues with loading PCI IDE drivers as modules

limit-hash-table-sizes.patch
  Limit hash table size

slab-poison-hex-dumping.patch
  slab: hexdump for check_poison

pentium-m-support.patch
  add Pentium M and Pentium-4 M options

old-gcc-supports-k6.patch
  gcc 2.95 supports -march=k6 (no need for check_gcc)

amd-elan-is-a-different-subarch.patch
  AMD Elan is a different subarch

better-i386-cpu-selection.patch
  better i386 CPU selection

cpu-options-default-to-y.patch
  cpu options default to "yes"

i386-default-to-n.patch

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

ia32-MSI-vector-handling-fix.patch
  ia32 MSI vector handling fix

aha152x-update.patch
  aha152x update

aha152x-update-fix.patch
  aha152x update fix

PP0-full_list-RC1.patch
  parport fixes [1/5]

PP1-parport_locking-RC1.patch
  parport fixes [2/5]

PP2-enumerate1-RC1.patch
  parport fixes [3/5]

PP2-enumerate1-RC1-fix.patch

PP3-parport_gsc-RC1.patch
  parport fixes [4/5]

PP4-bwqcam-RC1.patch
  parport fixes [5/5]

bw-qcam-typo-fix.patch
  bw-qcam typo fix

PP5-daisy-RC1.patch
  parport fixes [2/5]

PI0-schedule_claimed-RC1.patch
  paride cleanups and fixes [1/24]

PI1-expansion-RC1.patch
  paride cleanups and fixes [2/24]

PI2-crapectomy-RC1.patch
  paride cleanups and fixes [3/24]

PI3-ps_ready-RC1.patch
  paride cleanups and fixes [4/24]

PI4-pd_busy-RC1.patch
  paride cleanups and fixes [5/24]

PI5-do_pd_io-RC1.patch
  paride cleanups and fixes [6/24]

PI6-bogus_requests-RC1.patch
  paride cleanups and fixes [7/24]

PI7-claim_reorder-RC1.patch
  paride cleanups and fixes [8/24]

PI8-do_pd_request1-RC1.patch
  paride cleanups and fixes [9/24]

PI9-run_fsm-RC1.patch
  paride cleanups and fixes [10/24]

PI10-action-RC1.patch
  paride cleanups and fixes [2/24]

PI11-disconnect-RC1.patch
  paride cleanups and fixes [12/24]

PI12-unclaim-RC1.patch
  paride cleanups and fixes [13/24]

PI13-run_fsm-loop-RC1.patch
  paride cleanups and fixes [14/24]

PI14-next_request-RC1.patch
  paride cleanups and fixes [15/24]

PI15-do_pd_io-gone-RC1.patch
  paride cleanups and fixes [16/24]

PI16-pd_claimed-RC1.patch
  paride cleanups and fixes [17/24]

PI17-connect-RC1.patch
  paride cleanups and fixes [18/24]

PI18-reorder-RC1.patch
  paride cleanups and fixes [19/24]

PI19-special1-RC1.patch
  paride cleanups and fixes [20/24]

PI20-gendisk_setup-RC1.patch
  paride cleanups and fixes [21/24]

PI21-present-RC1.patch
  paride cleanups and fixes [22/24]

PI22-pd_init_units-RC1.patch
  paride cleanups and fixes [23/24]

PI23-special2-RC1.patch
  paride cleanups and fixes [24/24]

PI24-paride64-RC1.patch
  paride cleanups and fixes [25/24]

IMM0-lindent-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [1/8]

IMM1-references-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [2/8]

IMM2-claim-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [3/8]

IMM3-scsi_module-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [4/8]

IMM4-imm_probe-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [5/8]

IMM5-imm_wakeup-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [6/8]

IMM6-imm_hostdata-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [7/8]

IMM7-imm_attach-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [8/8]

PPA0-ppa_lindent-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [1/9]

PPA1-ppa_references-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [2/9]

PPA2-ppa_claim-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [3/9]

PPA3-ppa_scsi_module-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [4/9]

PPA4-ppa_probe-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [5/9]

PPA5-ppa_wakeup-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [6/9]

PPA6-ppa_hostdata-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [7/9]

PPA7-ppa_attach-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [8/9]

PPA8-ppa_lock_fix-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [9/9]

nfs-01-rpc_pipe_timeout.patch
  NFSv4/RPCSEC_GSS: userland upcall timeouts

nfs-02-auth_gss.patch
  RPCSEC_GSS: More fixes to the upcall mechanism.

nfs-03-pipe_close.patch
  RPCSEC_GSS: detect daemon death

nfs-04-fix_nfs4client.patch
  NFSv4: oops fix

nfs-05-fix_idmap.patch
  NFSv4: client name fixes

nfs-06-fix_idmap2.patch
  NFSv4: Bugfixes and cleanups client name to uid mapper.

nfs-07-gss_krb5.patch
  RPCSEC_GSS: Make it safe to share crypto tfms among multiple threads.

nfs-08-gss_missingkfree.patch
  RPCSEC_GSS: Oops. Major memory leak here.

nfs-09-memleaks.patch
  RPCSEC_GSS: Fix two more memory leaks found by the stanford checker.

nfs-10-refleaks.patch
  RPCSEC_GSS: Fix yet more memory leaks.

nfs-11-krb5_cleanup.patch
  RPCSEC_GSS: krb5 cleanups

nfs-12-gss_nokmalloc.patch
  RPCSEC_GSS: memory allocation fixes

nfs-13-krb5_integ.patch
  RPCSEC_GSS: Client-side only support for rpcsec_gss integrity protection.

nfs-14-clnt_seqno_to_req.patch
  RPCSEC_GSS: gss sequence number history fixes

nfs-15-encode_pages_tail.patch
  XDR: page encoding fix

nfs-16-rpc_clones.patch
  RPC: transport sharing

nfs-17-rpc_clone2.patch
  NFSv4/RPCSEC_GSS: use RPC cloning

nfs-18-renew_xdr.patch
  NFSv4: make RENEW a standalone RPC call

nfs-19-renewd.patch
  NFSv4: make lease renewal daemon per-server

nfs-20-fsinfo_xdr.patch
  NFSv4: Split the code for retrieving static server information out of the GETATTR compound.

nfs-21-setclientid_xdr.patch
  NFSv4: Make SETCLIENTID and SETCLIENTID_CONFIRM standalone operations

nfs-22-errno.patch
  NFSv4: errno fixes

nfs-23-open_reclaim.patch
  NFSv4: Preparation for the server reboot recovery code.

nfs-24-state_recovery.patch
  NFSv4: Basic code for recovering file OPEN state after a server reboot.

nfs-25-soft.patch
  RPC/NFSv4: Allow lease RENEW calls to be soft

nfs-26-sock_disconnect.patch
  RPC: TCP timeout fixes

nfs-27-atomic_open.patch
  NFSv4: Atomic open()

nfs-28-open_owner.patch
  NFSv4: Share open_owner structs

nfs-29-fix_idmap3.patch
  NFSv4: fix multi-partition mount oops

nfs_idmap-warning-fix.patch

nfs-30-lock.patch
  NFSv4: Add support for POSIX file locking.

nfs-old-gcc-fix.patch
  NFS: fix for older gcc's

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

ghash.patch
  ghash.h from 2.4

tty_io-uml-fix.patch
  uml: make tty_init callable from UML functions

uml-update.patch
  UML update

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-rss-limit-enforcement.patch
  RSS limit enforcement for 2.6

kbuild-unmangle-include-options.patch
  kbuild: Unmangle include options for gcc

sunrpc-sleep_on-removal.patch
  remove sleep_on from sunrpc

sisfb-update.patch
  sisfb update

add-config-for-mregparm-3-ng.patch
  Add CONFIG for -mregparm=3

add-config-for-mregparm-3-ng-fixes.patch
  arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes

use-funit-at-a-time.patch
  Use -funit-at-a-time on ia32

add-noinline-attribute.patch
  Add noinline attribute

dont-inline-rest_init.patch
  use noinline for rest_init()

kernel_thread_helper-section-fix.patch
  Force kernel_thread_helper() into .text

fix-more-gcc-34-warnings.patch
  Fix more gcc 3.4 warnings

gcc-35-netlink.patch
  gcc-3.5: netlink

gcc-35-packet.patch
  gcc-3.5: af_packet

gcc-34-string-fixes.patch
  string fixes for gcc 3.4

gcc-35-bio_phys_segments.patch
  gcc-3.5: fix extern inline decls

gcc-35-ident-warnings.patch
  gcc-3.5: #ident fixes

gcc-35-binfmt_elf-warning-fix.patch
  gcc-3.5: binfmt_elf warning fix

gcc-35-pcm_misc-warnings.patch
  gcc-3.5: pcm_misc.c warnings

gcc-35-pcm_plugin-warnings.patch

gcc-35-reiserfs-fixes.patch
  gcc-3.5: reiserfs fixes

gcc-35-tcp_put_port-fix.patch
  gcc-3.5: tcp_put_port() fix

gcc-35-ip6-ndisc-fix.patch
  gcc-3.5: ipv6/ndisc.c fixes

gcc-35-ide-fix.patch
  gcc-3.5: ide.h fixes

gcc-35-elevator.patch
  gcc-3.5: elevator.h fixes

gcc-35-keyboard-fixes.patch
  gcc-3.5: keyboard.c fixes

gcc-35-exit-fix.patch
  gcc-3.5: _exit fix

gcc-35-parport.patch
  Fix inlining failure (all GCCs) in parport

gcc-34-compilation-fixes.patch
  More 3.4 compilation fixes

gcc-35-seq_clientmgr.patch
  gcc-3.5: sound/core/seq/seq_clientmgr.c

gcc-35-tg3.patch
  gcc-3.5: tg3.c warnings

gcc-35-parport2.patch
  gcc-3.5: parport warnings

gcc-35-i810_accel.patch
  gcc-3.5: i810_accel fix

gcc-35-puts-fix.patch
  gcc-3.5: misc.c warning fix

gcc-35-filesystems.patch
  gcc-3.5: fsfilter.h, ntfs.h

gcc-35-zatm-fix.patch
  gcc-3.5: zatm.c fix

gcc-35-vxfs-idents.patch
  gcc-3.5: vxfs fixes

gcc-35-hfs-fix.patch
  gcc-3.5: hfs fixes

gcc-35-uPD98402.patch
  gcc-3.5: drivers/atm/uPD98402.c

gcc-35-intermezzo.patch
  gcc-3.5: intermezzo

gcc-35-iphase.patch
  gcc-3.5: iphase.c

gcc-35-suni.patch
  gcc-3.5: suni.c

gcc-35-fore2000e.patch
  gcc-3.5: drivers/atm/fore200e.c

gcc-35-ncpfs.patch
  gcc-3.5: ncpfs

gcc-35-eni.patch
  gcc-3.5: drivers/atm/eni.c

gcc-35-xfs.patch
  gcc-3.5: XFS fixes

gcc-35-idt77105.patch
  gcc-3.5: drivers/atm/idt77105.c

gcc-35-atmtcp.patch
  gcc-3.5: drivers/atm/atmtcp.c

gcc-35-appletalk.patch
  gcc-3.5: appletalk

gcc-35-he.patch
  gcc-3.5: drivers/atm/he.c

gcc-35-atm-common.patch
  gcc-3.5: net/atm/common.c

gcc-35-it87.patch
  gcc-3.5: drivers/i2c/chips/it87.c

gcc-35-econet.patch
  gcc-3.5: econet

gcc-35-decnet.patch
  gcc-3.5: decnet

gcc-35-radeon.patch
  gcc-3.5: radeon

gcc-35-sc1200.patch
  gcc-3.5: drivers/ide/pci/sc1200.c

gcc-35-ipx.patch
  gcc-3.5: ipx

gcc-35-irda.patch
  gcc-3.5: irda

gcc-35-raid6x86.patch
  gcc-3.5: raid6

gcc-35-mtd.patch
  gcc-3.5: mtd

gcc-35-dvb.patch
  gcc-35: DVB

gcc-35-bonding.patch
  gcc-3.5: bonding

gcc-35-ax25.patch
  gcc-3.5: ax25

gcc-35-pcmcia.patch
  gcc-3.5: PCMCIA

gcc-35-video.patch
  gcc-3.5: video

gcc-35-net-key.patch
  gcc-3.5: net/key/af_key.c

gcc-35-netrom.patch
  gcc-3.5: netrom

gcc-35-llc.patch
  gcc-3.5: llc

gcc-35-pnpbios.patch
  gcc-3.5: pnpbios

gcc-35-rose.patch
  gcc-3.5: net/rose

gcc-35-53c700.patch
  gcc-3.5: drivers/scsi/53c700

gcc-35-advansys.patch
  gcc-3.5: advansys.c

gcc-35-sctp-attribute_packed-fix.patch
  gcc-3.5: sctp

gcc-35-atp870u.patch
  gcc-3.5: atp870u.c

gcc-35-gdth.patch
  gcc-3.5: gdth.c

gcc-35-pppoe.patch
  gcc-3.5: pppoe

gcc-35-uss720.patch
  gcc-3.5: drivers/usb/misc/uss720.c

gcc-35-net2280.patch
  gcc-3.5: drivers/usb/gadget/net2280.c

gcc-35-hid-core.patch
  gcc-3.5: drivers/usb/input/hid-core.c

gcc-35-fbcon.patch
  gcc-3.5: fbcon.c

gcc-35-riva-fbdev.patch
  gcc-3.5: drivers/video/riva/fbdev.c

gcc-35-usb-storage-usb.patch
  gcc-3.5: drivers/usb/storage/usb.c

gcc-35-video-cfbimgblt.patch
  gcc-3.5: drivers/video/cfbimgblt.c

gcc-35-video-vgastate.patch
  gcc-3.5: drivers/video/vgastate.c

gcc-35-traps.patch
  gcc-3.5: arch/i386/kernel/traps.c

gcc-35-x86_64.patch
  x86-64 fixes for gcc 3.5

bitmap-parsing-printing-v4.patch
  bitmap parsing/printing routines, version 4

bitmap-parsing-cleanup.patch
  bitmap parsing/printing routines cleanup

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

fix-improve-modular-ide.patch
  fix/improve modular IDE

ide-pdc4030-build-fix.patch

janitor-09-i387-usercopy-check.patch
  i387: handle copy_from_user() error

doc-remove-modules-conf-references.patch
  Documentation: remove /etc/modules.conf refs

more-MODULE_ALIASes.patch
  add some more MODULE_ALIASes

bonding-alias-revert-and-docco-fix.patch
  bonding alias revert and documentation fix

simplify-net_ratelimit.patch
  simplify net_ratelimit()

printk-rate_limit-fixes.patch
  printk_ratelimit() tweaks

readX_relaxed.patch
  add readX_relaxed() interface

kconfig-use-select-2.patch
  Kconfig: use select statements

kconfig-remove-enable.patch
  kconfig/wireless: Replace enable with select

use-attribute-const-everywhere.patch
  use __attribute_const__ everywhere

edd-disksig.patch
  EDD: read disk80 MBR signature, export through edd module

edd-url-fix.patch
  EDD report URL change

swsusp-stop-DMA-on-resume.patch
  swsusp does not stop DMA properly during resume

swsusp-stop-DMA-on-resume-fix.patch

swsusp-trivial-cleanups.patch
  Trivial cleanups for swsusp

swsusp-more-cleanups.patch
  More cleanups for swsusp

swsusp-software_suspend-retval-fix.patch
  Allow software_suspend to fail

vmalloc-address-offset-fix.patch
  vmalloc address offset fix

hugetlbfs_remove_dirent.patch
  hugetlbfs directory entry cleanup

libfs_timestamp_fixes.patch
  libfs mtime/ctime updates

hugetlbfs_cleanup.patch
  hugetlbfs cleanup

console_driver-definition-fix.patch
  missing `console_driver' with CONFIG_VT && !CONFIG_VT_CONSOLE

partition-naming-fix.patch
  Make naming of parititions in sysfs match /proc/partitions.

ppc32-1000-hz.patch
  ppc32: Set HZ to 1000 on ppc32

fix-blockdev-getro.patch
  fix blockdev --getro for sr, sd, ide-floppy

remove-kstat-cpu-notifiers.patch
  Remove kstat cpu notifiers

workqueue-cleanup-2.patch
  Minor workqueue.c cleanup

remove-more-cpu-notifiers.patch
  Remove More Unneccessary CPU Notifiers

use-CPU_UP_PREPARE-properly.patch
  Use CPU_UP_PREPARE properly

support-wider-consoles.patch
  console: support for > 127 chars

remove-valid_addr_bitmap.patch
  remove valid_addr_bitmap

osst-warning-fix.patch
  osst.c: suppress page allocation failure warnings

init-cpu_vm_mask-in-init_mm.patch
  initialise cpu_vm_mask in init_mm

raw-is-obsolete.patch
  deprecate the raw driver

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

ncpfs-stack-usage-fix.patch
  Fix deep stack usage in ncpfs

remove_suid-fix.patch
  remove_suid() fix

md-02-preferred_minor-fix.patch
  md: Move the test in preferred_minor to where it is used.

md-03-debugging-output-cleanup.patch
  md: Fixes to make debuging output nicer.

md-04-personality-stats-collection.patch
  md: Collect device IO statistics for MD personalities.

md-05-device-in-error-printing-fix.patch
  md: Change the way the name of an md device is printed in error messages.

proc-partitions-omit-removable-media.patch
  /proc/paritions: omit removable media

remove-SIIG-PCI-IDs-from-parport_pc.patch
  remove SIIG combo cards PCI ids from parport_pc

i830-agp-pm-fix.patch
  Intel i830 AGP fix

remove-memblks.patch
  Remove memblks from the kernel

8250_pnp-cleanup.patch
  8250_pnp rmmod cleanup

scsi-tape-fixes.patch
  SCSI tape cdev fixes

raid-makefile-cleanup.patch
  Clean up raid6 kbuild output

fancy-lost-ticks-message.patch
  Better "Losing Ticks" Error Message

x86_64-make-xconfig-fix.patch
  Fix make xconfig on /lib64 systems

reserve-NUMA-API-syscall-slots.patch
  Reserve system calls for NUMA API

posix-timers-fixes.patch
  posix_timers fixes

mount-option-overrun-fix.patch
  Zero last byte of mount option page.

futex-redundant-test.patch
  futex: remove redundant test

CONFIG_SYSRQ-fixes.patch
  [janitor] change a few SYSRQ to MAGIC_SYSRQ

dz-verify_area-removal.patch
  [janitor] dz: verify_area() removal

oss-c99-fixes.patch
  [janitor] sound/oss: use C99 inits.

usb-sddr09-documentation.patch
  add comments to sddr09.c

console-makefile-cleanup.patch
  console cleanup

oprofile-ringbuffer-wrap-fix.patch
  oprofile per-cpu buffer overrun

oprofile-alpha-fix.patch
  oprofile, typo in alpha driver

copy_namespace-enomem-fix.patch
  copy_namespace ENOMEM fix

vgastate-missing-iounmaps.patch
  [janitor] vgastate: cleanup iounmap() usage

vga16fb-missing-iounmap.patch
  [janitor] vga16fb: add missing iounmap()

d_path-needs-vfsmount_lock.patch
  __d_path needs vfsmount_lock

namei-needs-vfsmount_lock.patch
  namei.c: take vfsmount_lock

try-reiserfs-earlier.patch
  try reiserfs before other filesystems

ufs-use-silent.patch
  UFS: honour `silent' parameter.

time-rounding-accuracy.patch
  Fine tune the time conversion to eliminate conversion errors.

proc-stat-btime-fix-2.patch
  /proc/stat:btime fix

menuconfig-choice-display-fix.patch
  fix menuconfig choice item help display

use-uint32_t-for-crosscompiling.patch
  u_int32_t causes cross-compile problems

ac97-remove-fix.patch
  ac97 OSS driver removal fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

show_task-fix.patch
  show_task() is not SMP safe

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ia64-lockmeter-fix.patch

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

zap_low_mappings-fix.patch
  zap_low_mappings() cannot be __init

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes
  dio-aio fix fix

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms



