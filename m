Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUAVJfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUAVJfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:35:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:57311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264471AbUAVJeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:34:20 -0500
Date: Thu, 22 Jan 2004 01:35:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.2-rc1-mm1
Message-Id: <20040122013501.2251e65e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm1/


- Nothing very exciting, just lots of random fixes.

- The x86 gcc-3.4/gcc-3.5 support seems pretty much complete now.  There
  are enough fixes here to get a reasonably clean build with my .config but a
  full kernel build still will need work.

- I've uploaded patch-scripts-0.14 to

	http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.14/

  The main change is the addition of the new `patch-bomb' script.  It
  uses a little standalone SMPT client written by Bryan Henderson to mail
  patches to a victim, with an optional Cc to the people who wrote each of
  the patches.  See docco.txt for details.


Changes since 2.6.1-mm5:

 linus.patch

 Latest Linus tree

-net-jiffy-normalisation-fix.patch
-input-fixes-and-updates.patch
-synaptics-rate-switching.patch
-psmouse-timeout-parity-fixes.patch
-ppc64-execve-error-path-fix.patch
-ppc64-iseries-fixes.patch
-ppc64-hugepages-fix.patch
-ppc64-iseries-virtual-console.patch
-asus-L5-fix.patch
-loop-module-alias.patch
-epoll-oneshot-support.patch
-2.6.1-bk2-libata1.patch
-raid6-20040107.patch
-raid6-readahead-fix.patch
-raid6-rebuild-needs-yield.patch
-raid6-x86_64-build-fix.patch
-truncated-module-check-2.patch
-md-01-set_disk_faulty-return-code-fix.patch
-md-02-rebuild-needs-yield.patch
-md-03-resync-interrupt-fix.patch
-md-04-typo-fix.patch
-md-05-recovery-fix.patch
-md-06-do_md_run-fix.patch
-md-06-do_md_run-fix-fix.patch
-md-07-superblock-writing-fixes.patch
-md-08-remove-disks-array.patch
-md-09-discard-mddev_map-array.patch
-md-10-use-bd_disk-private_data.patch
-bridge-build-fix.patch
-move-XATTR_SECURITY_PREFIX.patch
-XATTR_SECURITY_PREFIX-default-hooks.patch
-powermate-payload-size-fix.patch
-x86_64-ptrace-fix.patch
-sendfile-locks_verify_area-fix.patch
-pc300_tty-is-broken.patch
-dvb-01-update-documentation.patch
-dvb-02-update-saa7146.patch
-dvb-03-update-core.patch
-dvb-04-splitup-av7110-driver.patch
-dvb-05-TTUSB-update.patch
-ide-scsi-use-after-free-fix.patch
-janitor-01-amd74xx-fix.patch
-janitor-02-apm-kernel_thread-check.patch
-janitor-03-mca-handle-oom.patch
-janitor-06-md-procfs-fixes.patch
-janitor-10-vm-doc-fix.patch
-janitor-11-unix98-spelling.patch
-janitor-12-md-ifdef-cleanup.patch
-janitor-13-stat-remove-flags.patch
-janitor-14-floppy-outb-macro-fixes.patch
-ext3-chattr-aops-update.patch
-generic-exception-table-sorting-2-fix.patch
-ipv6-sysctl-oops-fix.patch
-reiserfs-cleanup_bitmap_list-oops-fix.patch
-usb-legacy-support-doc.patch
-isdn-url-fix.patch
-p4-clockmod-more-than-two-siblings.patch
-limit-IO-error-printk-storms.patch
-quota-locking-accounting-fix.patch
-smbfs-fix-noisiness.patch
-sunrpc-rmmod-oops-fix.patch

 Merged

+dummy-init-fix.patch

 Fix drivers/net/dummy.c linkage problem

+raid6-3.patch
+raid6-doc-fix.patch

 RAID6 updates

+ppc64-missing-sched_balance_exec.patch
+ppc64-include-i2c-in-config.patch
+ppc64-include_guards.patch
+ppc64-lparcfg_write.patch
+ppc64-no_device_tree.patch
+ppc64-ppc32_timer_create.patch
+ppc64-defconfig_update.patch

 PPC64 fixes

+acpi-pm-timer-kill-printks.patch

 Remove some debug stuff

-CardServices-compatibility-layer.patch

 Dropped - not sure we need a back-compat layer for CardServices.

+p4-clockmod-more-than-two-siblings.patch

 Don't assume that there are only two siblings per package in p4-clockmod.

+sched-domain-tweak.patch
+sched-no-drop-balance.patch

 More CPU scheduler work.

+laptop-mode-doc-update-4.patch

 Documentation

+i386-default-to-n.patch

 Don't enable 386's by default

+vmscan-remove-priority.patch

 Kill unused function args

-add-noinline-attribute.patch

 Not needed now we sort the exception tables.

-add-config-for-mregparm-3.patch
-add-config-for-mregparm-3-make-EXPERIMENTAL.patch
-add-module-magic-for-mregparm3.patch
+add-config-for-mregparm-3-ng.patch

 Rework the logic surrounding the `-mregparm=3' i386 compile option.  It now
 works out the compiler version and turns off regparm=3 if you're using
 gcc-2.x (it crashes).

+bitmap-parsing-cleanup.patch

 Clean up/fix/rework the bitmap parsing and printing library code.

+bonding-alias-revert-and-docco-fix.patch

 Revert bonding MODULE_ALIAS, update documentation

+printk-rate_limit-fixes.patch

 Generalise printk_ratelimit(), use it for net_ratelimit().

+x86_64-kconfig-i2c-menu.patch

 Add i2c back to the x86_64 config system.

+ide-legacy-build-fix.patch

 IDE compile fix.

+readX_relaxed.patch

 Add the readX_relaxed() API: read[bwl] without the implicit ordering.

+kconfig-use-select.patch

 Use select statements where appropriate

+kconfig-remove-enable.patch

 Remove vestiges of kbuild's old `enable' statement.

+use-attribute-const-everywhere.patch

 Use __attribute_const__ instead of open-coding it.

+edd-disksig.patch

 EDD Disk signatures

+swsusp-stop-DMA-on-resume.patch
+swsusp-stop-DMA-on-resume-fix.patch
+swsusp-trivial-cleanups.patch
+swsusp-more-cleanups.patch
+swsusp-software_suspend-retval-fix.patch

 swsusp updates

+vmalloc-address-offset-fix.patch

 Fix the rmap back-pointers in pagetable pages which are established by
 vmalloc().

+ia64-include-i2c-in-config.patch

 Add i2c back to the ia64 config system.
 
+hugetlbfs_remove_dirent.patch

 Remove hugetlbfs's pseudo-directory-size code.

+libfs_timestamp_fixes.patch

 Update [uac]times correctly in libfs.

+hugetlbfs_cleanup.patch

 hugetlbfs can noe use more libfs boilerplate.

+w9966-stack-usage-fix.patch
+ttusb-stack-space-fix.patch

 Use less stack

+console_driver-definition-fix.patch

 Build fix

+partition-naming-fix.patch

 Be consistent about how we name partitions in sysfs.

+ppc32-1000-hz.patch

 Set PPC32's HZ to 1000

+ppc32-signal-context-fixes.patch

 Fix up ppc32 signal handling.

+rq_for_each_bio-fix-again.patch

 Third time lucky.




All 263 patches

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

alsa-101.patch
  ALSA 1.0.1

alsa-cmipci-joystick-fix.patch

netdev.patch

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

dummy-init-fix.patch
  dummy.c: __exit section fix

raid6-3.patch
  RAID-6 fixes

raid6-doc-fix.patch
  document RAID-6 support in mdadm-1.5.0

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

acpi-20031203.patch

acpi-20031203-fix.patch

acpi-frees-irq0.patch
  acpi frees free irq0

ppc64-missing-sched_balance_exec.patch
  ppc64: add missing sched_balance_exec() call

ppc64-include-i2c-in-config.patch
  ppc64: include i2c in config

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

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

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

sysfs-class-06-raw.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for raw devices [06/10]

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

sis-DRM-floating-point-removal.patch
  Remove float from sis DRM

drm-include-fix.patch

kthread-primitive.patch
  kthread primitive

kthread-block-all-signals.patch
  kthread: block all signals

use-kthread-primitives.patch
  Use kthread primitives

lsi-megaraid-pci-id.patch
  LSI Logic MegaRAID3 PCI ID

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

nuke-noisy-printks.patch
  quiet down SMP boot messages

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

pcmcia-update.patch
  PCMCIA updates

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

ppc32-signal-context-fixes.patch
  ppc32: Fixes to the signal context code

rq_for_each_bio-fix-again.patch
  Fix rq_for_each_bio() macro again

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



