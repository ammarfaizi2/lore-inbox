Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUAWJi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUAWJiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:38:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:7647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266279AbUAWJgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:36:50 -0500
Date: Fri, 23 Jan 2004 01:37:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.2-rc1-mm2
Message-Id: <20040123013740.58a6c1f9.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm2/


- There is a new debug check in here which drops a stack trace when a piece
  of code calls one of the sleep_on() functions without lock_kernel() held. 
  This is almost certainly a bug.  Please try to identify (from the trace)
  which subsystem is the culprit and copy its maintainer when reporting such
  traces.

  After ten such warnings the diagnostic shuts itself up.

- A big SiS framebuffer driver update.  Please test, and include Thomas
  Winischhofer <thomas@winischhofer.net> in any reports.

- Included the latest ACPI test tree.  Please copy
  acpi-devel@lists.sourceforge.net on any ACPI-related reports.

- Another MD update.


Changes since 2.6.2-rc1-mm1:


 linus.patch

 Latest Linus tree

-dummy-init-fix.patch
-raid6-3.patch
-raid6-doc-fix.patch
-ppc64-missing-sched_balance_exec.patch
-ppc64-include-i2c-in-config.patch
-pcmcia-update.patch

 Merged

 netdev.patch

 Latest netdev tree

+speedo-warning-fix.patch

 Fix a warning in it.

+raid6-ia64-fix.patch

 RAID6 fix

+ppc32-signal-context-fixes.patch
+ppc32-MBX-mac-address-fix.patch
+ppc32-watchdog-defines-fixes.patch

 ppc32 fix

+big-pmac-update.patch

 Rolled-up Power Mac update

-acpi-20031203.patch
+acpi.patch

 Latest ACPI test tree

+ppc64-use-preferred-console.patch

 PPC64 console selection.  Undocumented in kernel-parameters.txt :(

+update-post-halloween-url.patch
+restore-24-mtrr-feature.patch
+pci-probing-typo.patch
+aty128fb-logic-error.patch
+remove-unused-CONFIG-symbol.patch
+decruft-ATM-HE-driver.patch
+radeonfb-logic-error.patch
+xfs-logic-error.patch
+OOSTORE-needs-MTRR.patch

 2.4 syncups from Dave Jones.

+use-pmtmr-for-delay_pmtmr.patch

 Fix a boot-time crash which occurs when testing the APIC timer when using
 the ACPI PM timer.  This causes bogomips to be reported at 50% of what it
 used to be.

-sysfs-class-06-raw.patch

 Dropped - it had problems and the raw driver isn't really an area for new
 development.

+sched-arch_init_sched_domains-fix.patch
+sched-find_busiest_group-clarification.patch
+sched-remove-noisy-printks.patch

 CPU scheduler cleanups and fixes

-sis-DRM-floating-point-removal.patch

 This was wrong.

+fix-blockdev-getro.patch

 fix `blockdev --getro'

+RAW_GETBIND-compat_ioctl-fix.patch

 Fix RAW_GETBIND 32->64 bit wrapper.

+simplify-flow_c-cpu-handling.patch

 Simplify cpu handling in net/core/flow.c

+flow-cpucontrol-fix.patch

 Fix it for uniprocessor builds

+remove-kstat-cpu-notifiers.patch

 Remove unused CPU notifiers.

+support-wider-consoles.patch

 Support consoles up to 255 columns

+remove-valid_addr_bitmap.patch

 Remove unused valid_addr_bitmap

+osst-warning-fix.patch

 Fix a warning in the OSST driver

+request_firmware-del_timer-fix.patch

 Use del_timer_sync()

+sisfb-update.patch

 Updated SiS fb driver

+init-cpu_vm_mask-in-init_mm.patch

 Initialise init_mm.cpu_vm_mask

+raw-is-obsolete.patch

 Mark the raw driver as obsolete, say rude things about it in Kconfig

+sleep_on-needs_lock_kernel.patch

 Emit diagnostics when the sleep_on() functions are used without
 lock_kernel()

+dvb-mailing-list.patch

 MAINTAINERS update

+ncpfs-stack-usage-fix.patch

 Reduced stack usage in the ncpfs driver.

+remove_suid-fix.patch

 Fix performance problems with remove_suid()

+md-01-shutdown-hang-fix.patch
+md-02-preferred_minor-fix.patch
+md-03-debugging-output-cleanup.patch
+md-04-personality-stats-collection.patch
+md-05-device-in-error-printing-fix.patch
+md-06-allow-partitioning.patch
+md-07-md-appear-in-proc-partitions.patch

 MD update

+remove-SIIG-PCI-IDs-from-parport_pc.patch

 Remove defunct PCI IDs

+i830-agp-pm-fix.patch

 Fixup for the Intel i830 AGP driver





All 299 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

alsa-101.patch
  ALSA 1.0.1

alsa-cmipci-joystick-fix.patch

netdev.patch

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

kgdb-x86_64-support.patch
  kgdb for x86_64 2.6 kernels

kgdb-x86_64-build-fix.patch
  fix x86_64 build with CONFIG_KGDB=n

kgdb-warning-fixes.patch
  kgdb warning fixes

lsi-megaraid-pci-id.patch
  LSI Logic MegaRAID3 PCI ID

raid6-ia64-fix.patch
  RAID-6 fix for IA-64

ppc32-signal-context-fixes.patch
  ppc32: Fixes to the signal context code

ppc32-MBX-mac-address-fix.patch
  ppc32: MBX MAC address fix

ppc32-watchdog-defines-fixes.patch
  ppc32: watchdog definition fixes

big-pmac-update.patch
  big PMAC update

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

acpi.patch

acpi-20031203-fix.patch

acpi-frees-irq0.patch
  acpi frees free irq0

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

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

update-post-halloween-url.patch
  Update post-halloween doc url.

restore-24-mtrr-feature.patch
  Restore 2.4 MTRR feature.

pci-probing-typo.patch
  PCI probing typo?

aty128fb-logic-error.patch
  logic error in aty128fb

remove-unused-CONFIG-symbol.patch
  Remove unused CONFIG symbol.

decruft-ATM-HE-driver.patch
  Little cleanups to ATM HE driver.

radeonfb-logic-error.patch
  logic error in radeonfb.

xfs-logic-error.patch
  logic error in XFS

OOSTORE-needs-MTRR.patch
  OOSTORE needs MTRR.

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

acpi-pm-timer-3.patch
  ACPI PM timer version 3

acpi-pm-timer-kill-printks.patch

use-pmtmr-for-delay_pmtmr.patch
  Subject: Re: pester mingo@redhat.com

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

ide-siimage-seagate.patch

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

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

limit-hash-table-sizes.patch
  Limit hash table size

disable-G400-DRM-on-x86_64.patch
  Disable G400 DRM driver on x86-64

x86_64-merge.patch
  x86-64 merge for 2.6.1

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

kbuild-unmangle-include-options.patch
  kbuild: Unmangle include options for gcc

sunrpc-sleep_on-removal.patch
  remove sleep_on from sunrpc

use-funit-at-a-time.patch
  Use -funit-at-a-time when possible

add-config-for-mregparm-3-ng.patch
  Add CONFIG for -mregparm=3

fix-x86_64-gcc-34-warnings.patch
  Fix gcc 3.4 warnings in x86-64

fix-more-gcc-34-warnings.patch
  Fix more gcc 3.4 warnings

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

bitmap-parsing-printing-v4.patch
  bitmap parsing/printing routines, version 4

bitmap-parsing-cleanup.patch
  bitmap parsing/printing routines cleanup

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

fix-improve-modular-ide.patch
  fix/improve modular IDE

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

aha1542-warning-fix.patch
  aha1542.c warning fix

x86_64-kconfig-i2c-menu.patch
  kconfig: no i2c on amd64

ide-legacy-build-fix.patch
  Fix compile error with IDE legacy driver

readX_relaxed.patch
  add readX_relaxed() interface

kconfig-use-select.patch
  kconfig: Improve warnings related to select

kconfig-remove-enable.patch
  kconfig/wireless: Replace enable with select

use-attribute-const-everywhere.patch
  use __attribute_const__ everywhere

edd-disksig.patch
  EDD: read disk80 MBR signature, export through edd module

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

ia64-include-i2c-in-config.patch
  ia64: include i2c in config

hugetlbfs_remove_dirent.patch
  hugetlbfs directory entry cleanup

libfs_timestamp_fixes.patch
  libfs mtime/ctime updates

hugetlbfs_cleanup.patch
  hugetlbfs cleanup

w9966-stack-usage-fix.patch
  Fix large stack allocation in w9966 driver.

ttusb-stack-space-fix.patch
  Fix up 4KB stack allocation in DVB USB driver.

console_driver-definition-fix.patch
  missing `console_driver' with CONFIG_VT && !CONFIG_VT_CONSOLE

partition-naming-fix.patch
  Make naming of parititions in sysfs match /proc/partitions.

ppc32-1000-hz.patch
  ppc32: Set HZ to 1000 on ppc32

rq_for_each_bio-fix-again.patch
  Fix rq_for_each_bio() macro again

fix-blockdev-getro.patch
  fix blockdev --getro for sr, sd, ide-floppy

RAW_GETBIND-compat_ioctl-fix.patch
  The RAW_GETBIND compat_ioctl fails

simplify-flow_c-cpu-handling.patch
  Simplify net/flow.c

flow-cpucontrol-fix.patch

remove-kstat-cpu-notifiers.patch
  Remove kstat cpu notifiers

support-wider-consoles.patch
  console: support for > 127 chars

remove-valid_addr_bitmap.patch
  remove valid_addr_bitmap

osst-warning-fix.patch
  osst.c: suppress page allocation failure warnings

request_firmware-del_timer-fix.patch
  request_firmware(): use del_timer_sync()

sisfb-update.patch
  sisfb update

init-cpu_vm_mask-in-init_mm.patch
  initialise cpu_vm_mask in init_mm

raw-is-obsolete.patch
  deprecate the raw driver

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

dvb-mailing-list.patch
  linux-dvb open mailing list

ncpfs-stack-usage-fix.patch
  Fix deep stack usage in ncpfs

remove_suid-fix.patch
  remove_suid() fix

md-01-shutdown-hang-fix.patch
  md: Fix possible hang in raid shutdown.

md-02-preferred_minor-fix.patch
  md: Move the test in preferred_minor to where it is used.

md-03-debugging-output-cleanup.patch
  md: Fixes to make debuging output nicer.

md-04-personality-stats-collection.patch
  md: Collect device IO statistics for MD personalities.

md-05-device-in-error-printing-fix.patch
  md: Change the way the name of an md device is printed in error messages.

md-06-allow-partitioning.patch
  md: Allow partitioning of MD devices.

md-07-md-appear-in-proc-partitions.patch
  md: Make sure md devices appear in /proc/partitions

remove-SIIG-PCI-IDs-from-parport_pc.patch
  remove SIIG combo cards PCI ids from parport_pc

i830-agp-pm-fix.patch
  Intel i830 AGP fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

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



