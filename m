Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUA3RbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUA3RbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:31:00 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:42973 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S262055AbUA3RZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:25:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm2
Date: Fri, 30 Jan 2004 12:25:02 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040130014108.09c964fd.akpm@osdl.org>
In-Reply-To: <20040130014108.09c964fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401301225.03149.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.53.166] at Fri, 30 Jan 2004 11:25:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 January 2004 04:41, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-
>rc2/2.6.2-rc2-mm2/
>
>
>- I added a few late-arriving patches.  Usually this breaks things.

Consider this a dozen roses.  Now running 2.6.2-mm2 here.

Well, so far it looks as if the only thing broken is ksysguard, which 
cannot open its display.  I suspect that hunting down .ksysguardrc 
and deleting it will fix that at the expense of having to rebuild its 
display.  Seems that file is too easily fubar'd.  The last thing I 
did was to adjust a sensor alarm threshold earlier this morning.

Interactivity is much much improved, many thanks to the detective that 
found that perp lurking in the futex stuff.  This makes a huge 
difference to the "usability". :) :) :)

>- Added a few external development trees (USB, XFS).
>
>- PNP update
>
>
>
>
>
>Changes since 2.6.2-rc2-mm1:
>
>
> linus.patch
>
> Latest Linus tree
>
>+bk-alsa.patch
>
> Latest ALSA tree
>
>+bk-netdev.patch
>
> Latest experimental netdev tree
>
>+bk-input.patch
>
> Latest input tree
>
>+bk-acpi.patch
>
> Latest ACPI tree
>
>+bk-usb.patch
>
> Latest USB tree
>
>+bk-xfs.patch
>
> Latest XFS tree
>
>-x86_64-warnings-fix.patch
>-kernel_flag-fixes.patch
>-pmdisk-needs-uts_name.patch
>
> Merged
>
>+ppc64-hugepage-cleanups.patch
>
> PPC64 hugetlbpage implementation cleanup
>
>-use-pmtmr-for-delay_pmtmr.patch
>-use-TSC-for-delay_pmtmr.patch
>+use-TSC-for-delay_pmtmr-2.patch
>
> Rolled together.
>
>-pnp-fix-2.patch
>-pnp-fix-3.patch
>-alsa-pnp-fix.patch
>-8250_pnp-cleanup.patch
>+pnp-8250_pnp-fix.patch
>+pnp-resource-flags-reorganisation.patch
>+pnp-BIOS-workaround.patch
>+pnp-avoid-static-allocations.patch
>+pnp-move-ID-declarations.patch
>+pnp-file2alias-update.patch
>+pnp-update-matching-code.patch
>+pnp-additional-sysfs-info.patch
>+pnp-config-cleanup.patch
>
> PNP update
>
>-sysfs-class-10-vc.patch
>
> This triggers mystery oopses in the TTY layer.  Drop it for now.
>
>+sched-directed-migration.patch
>+sched-domain-debugging.patch
>
> CPU scheduler work.
>
>-futex-wakeup-debug.patch
>
> This was wrong, and needs some work to make it right.
>
>+lock_cpu_hotplug-fixes.patch
>
> Clean up lock_cpu_hotplug()
>
>+module-removal-use-kthread.patch
>
> Use kthreads for module removal.
>
>+kthread-affinity-fix.patch
>+call_usermodehelper-affinity-fix.patch
>
> Don't inherit CPU affinity from parent threads.
>
>-gcc-35-uss720.patch
>-gcc-35-net2280.patch
>-gcc-35-hid-core.patch
>-gcc-35-usb-storage-usb.patch
>
> Merged into bk-usb.patch
>
>+ppc32-ide-build-fix.patch
>
> Another build fix against fix-improve-modular-ide.patch
>
>+swsusp-software_suspend-retval-fix-fix.patch
>
> Fix ppc32 build breakage due to
> swsusp-software_suspend-retval-fix.patch
>
>+is_subdir-locking-fix.patch
>+proc_check_root-locking-fix.patch
>
> Additional VFS mount tree locking
>
>+pcnet32-locking-fix.patch
>
> Fix locking in this net driver
>
>+ide-cd-MO-write-protect.patch
>
> Add write-protect handling and support for other-than-2k blocksizes
> to ide-cd.
>
>+s390-general-update.patch
>+s390-inline-assembly-constraints.patch
>+s390-sclp-fixes.patch
>
> s390 update
>
>+nr_free_pages-is-expensive.patch
>
> Reduce the nr_free_pages() call frequency.
>
>+mmap-use-address-hint.patch
>
> Use the address hint for mmap(MAP_FIXED)
>
>+shrink_list-swapcache-check-fix.patch
>
> Small fix to page reclaim
>
>+as-docco-update.patch
>
> Anticipatory scheduler documentation update
>
>+cscope-use-inverted-index.patch
>
> Speed up cscope usage.
>
>+nfs-server-in-root_server_path.patch
>
> Forward-port the "extract NFS server IP address from
> roo_server_path" ip autoconfig thing from 2.4
>
>+pcix-enhanced.patch
>
> Support for pCiXe
>
>+Lindent-goodness.patch
>
> make Lindent generate more CodingStyle-compliant output.
>
>+increase-NGROUPS.patch
>+increase-NGROUPS-cleanup.patch
>
> Lots of groups.
>
>+intermezzo-NGROUPS-is-broken.patch
>
> It killed intermezzo.  We don't know how to fix it and nobody is
> working on intermezzo in 2.6.  Yet, at least.  Mark intermezzo as
> broken.
>
>+move-cpu_vm_mask.patch
>
> Microoptimise mm_struct layout.
>
>+compat-signal-noarch-2004-01-29.patch
>+compat-signal-ppc64-2004-01-29.patch
>+compat-signal-ia64-2004-01-29.patch
>
> Consolidation of the 32->64 bit signal compatibility code.
>
>+pci-scan-all-functions.patch
>
> Add a hook to the PCI layer for logically-partitioned PPC64
> strangeness.
>
>
>
>
>
>All 406 patches:
>
>
>linus.patch
>
>bk-alsa.patch
>
>bk-netdev.patch
>
>bk-input.patch
>
>bk-acpi.patch
>
>bk-usb.patch
>
>bk-xfs.patch
>
>mm.patch
>  add -mmN to EXTRAVERSION
>
>speedo-warning-fix.patch
>  eepro100.c warning fix
>
>kgdb-ga.patch
>  kgdb stub for ia32 (George Anzinger's one)
>  kgdbL warning fix
>  kgdb buffer overflow fix
>  kgdbL warning fix
>  kgdb: CONFIG_DEBUG_INFO fix
>  x86_64 fixes
>
>kgdb-doc-fix.patch
>  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
>
>kgdboe-netpoll.patch
>  kgdb-over-ethernet via netpoll
>
>kgdboe-non-ia32-build-fix.patch
>
>kgdb-warning-fixes.patch
>  kgdb warning fixes
>
>kgdb-x86_64-support.patch
>  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
>
>ppc32-MBX-mac-address-fix.patch
>  ppc32: MBX MAC address fix
>
>ppc32-watchdog-defines-fixes.patch
>  ppc32: watchdog definition fixes
>
>big-pmac-3.patch
>
>must-fix.patch
>  must fix lists update
>  must fix list update
>  mustfix update
>
>must-fix-update-5.patch
>  must-fix update
>
>psmouse-drop-timed-out-bytes.patch
>  psmouse: log and discard timed out bytes
>
>ppc64-include_guards.patch
>  ppc64: add missing include guards, from Nathan Lynch
>
>ppc64-lparcfg_write.patch
>  ppc64: lparcfg_write
>
>ppc64-no_device_tree.patch
>  ppc64: fixes for compile with CONFIG_PROC_DEVICETREE=n, from
> Nathan Lynch
>
>ppc64-ppc32_timer_create.patch
>  ppc64: missing set_fs(KERNEL_DS) in ppc32_timer_create, from
> Marcus Meissner
>
>ppc64-defconfig_update.patch
>  ppc64: defconfig update
>
>ppc64-use-preferred-console.patch
>  ppc64: Use preferred_console to select a reasonable default
> console
>
>ppc64-config_h.patch
>  ppc64: add/remove config.h
>
>ppc64-export_symbols.patch
>  ppc64: export memchr and csum_partial
>
>ppc64-lparcfg_fixes.patch
>  ppc64: fix && vs & bugs in lparcfg, from Julie DeWandel
>
>ppc64-slb_rewrite.patch
>  ppc64: SLB rewrite
>
>ppc64-xmon-sysrq.patch
>
>ppc64-hugepage-cleanups.patch
>  Trivial cleanups to hugepage support
>
>ppc64-bar-0-fix.patch
>  Allow PCI BARs that start at 0
>
>ppc64-reloc_hide.patch
>
>nuke-noisy-printks.patch
>  quiet down SMP boot messages
>
>invalidate_inodes-speedup.patch
>  invalidate_inodes speedup
>  more invalidate_inodes speedup fixes
>
>cfq-4.patch
>  CFQ io scheduler
>  CFQ fixes
>
>config_spinline.patch
>  uninline spinlocks for profiling accuracy.
>
>ramdisk-cleanup.patch
>
>intel8x0-cleanup.patch
>  intel8x0 cleanups
>
>pdflush-diag.patch
>
>zap_page_range-debug.patch
>  zap_page_range() debug
>
>get_user_pages-handle-VM_IO.patch
>
>support-zillions-of-scsi-disks.patch
>  support many SCSI disks
>
>pci_set_power_state-might-sleep.patch
>
>CONFIG_STANDALONE-default-to-n.patch
>  Make CONFIG_STANDALONE default to N
>
>extra-buffer-diags.patch
>
>CONFIG_SYSFS.patch
>  From: Pat Mochel <mochel@osdl.org>
>  Subject: [PATCH] Add CONFIG_SYSFS
>
>CONFIG_SYSFS-boot-from-disk-fix.patch
>
>slab-leak-detector.patch
>  slab leak detector
>
>loop-remove-blkdev-special-case.patch
>
>loop-highmem.patch
>  remove useless highmem bounce from loop/cryptoloop
>
>loop-bio-handling-fix.patch
>  loop: BIO handling fix
>
>loop-init-fix.patch
>  loop.c doesn't fail init gracefully
>
>loop-remove-redundant-assignment.patch
>  loop: remove redundant initialisation
>
>acpi-pm-timer-3.patch
>  ACPI PM timer version 3
>
>acpi-pm-timer-kill-printks.patch
>
>use-TSC-for-delay_pmtmr-2.patch
>  Use TSC for delay_pmtmr()
>
>scale-nr_requests.patch
>  scale nr_requests with TCQ depth
>
>truncate_inode_pages-check.patch
>
>local_bh_enable-warning-fix.patch
>
>pnp-8250_pnp-fix.patch
>  Fix oops due to 8250_pnp module unload
>
>pnp-resource-flags-reorganisation.patch
>  pnp: resource flag reorganisation
>
>pnp-BIOS-workaround.patch
>  PNP: work around BIOS device disabling bugs
>
>pnp-avoid-static-allocations.patch
>  pnp: avoid static resource allocation requests
>
>pnp-move-ID-declarations.patch
>  pnp: move device ID declarations
>
>pnp-file2alias-update.patch
>  pnp: file2alias update
>
>pnp-update-matching-code.patch
>  pnp: update matching code
>
>pnp-additional-sysfs-info.patch
>  pnp: add additional sysfs info
>
>pnp-config-cleanup.patch
>  pnp: Kconfig cleanup
>
>sched-find_busiest_node-resolution-fix.patch
>  sched: improved resolution in find_busiest_node
>
>sched-domains.patch
>  sched: scheduler domain support
>
>sched-clock-fixes.patch
>  fix sched_clock()
>
>sched-build-fix.patch
>  sched: fix for NR_CPUS > BITS_PER_LONG
>
>sched-sibling-map-to-cpumask.patch
>  sched: cpu_sibling_map to cpu_mask
>
>p4-clockmod-sibling-map-fix.patch
>  p4-clockmod sibling_map fix
>
>p4-clockmod-more-than-two-siblings.patch
>  p4-clockmod: handle more than two siblings
>
>sched-domains-i386-ht.patch
>  sched: implement domains for i386 HT
>
>sched-find_busiest_group-fix.patch
>  sched: Fix CONFIG_SMT oops on UP
>
>sched-domain-tweak.patch
>  i386-sched-domain code consolidation
>
>sched-no-drop-balance.patch
>  sched: handle inter-CPU jiffies skew
>
>sched-arch_init_sched_domains-fix.patch
>  Change arch_init_sched_domains to use cpu_online_map
>
>sched-find_busiest_group-clarification.patch
>  sched: clarify find_busiest_group
>
>sched-remove-noisy-printks.patch
>
>sched-directed-migration.patch
>  sched_balance_exec(): don't fiddle with the cpus_allowed mask
>
>sched-domain-debugging.patch
>  sched_domain debugging
>
>acpi-numa-printk-level-fixes.patch
>  ACPI NUMA quiet printk and cleanup
>
>ide-siimage-seagate.patch
>
>ide-ali-UDMA6-support.patch
>  IDE: Add support of UDMA6 on ALi rev > 0xc4
>
>fa311-mac-address-fix.patch
>  wrong mac address with netgear FA311 ethernet card
>
>laptop-mode-2.patch
>  laptop-mode for 2.6, version 6
>  Documentation/laptop-mode.txt
>  laptop-mode documentation updates
>
>laptop-mode-doc-update-4.patch
>  Laptop mode documentation addition
>
>vt-locking-fixes-2.patch
>  VT locking fixes
>
>pid_max-fix.patch
>  Bug when setting pid_max > 32k
>
>use-soft-float.patch
>  Use -msoft-float
>
>DRM-cvs-update.patch
>  DRM cvs update
>
>drm-include-fix.patch
>
>lock_cpu_hotplug-fixes.patch
>  ock_cpu_hotplug only if CONFIG_CPU_HOTPLUG
>
>kthread-primitive.patch
>  kthread primitive
>
>kthread-block-all-signals.patch
>  kthread: block all signals
>
>use-kthread-primitives.patch
>  Use kthread primitives
>
>module-removal-use-kthread.patch
>  Module removal to use kthread
>
>kthread-affinity-fix.patch
>  Affinity of kthread fix
>
>call_usermodehelper-affinity-fix.patch
>  Affinity of call_usermode_helper fix
>
>ide-pci-modules-fix.patch
>  fix issues with loading PCI IDE drivers as modules
>
>limit-hash-table-sizes.patch
>  Limit hash table size
>
>slab-poison-hex-dumping.patch
>  slab: hexdump for check_poison
>
>pentium-m-support.patch
>  add Pentium M and Pentium-4 M options
>
>old-gcc-supports-k6.patch
>  gcc 2.95 supports -march=k6 (no need for check_gcc)
>
>amd-elan-is-a-different-subarch.patch
>  AMD Elan is a different subarch
>
>better-i386-cpu-selection.patch
>  better i386 CPU selection
>
>cpu-options-default-to-y.patch
>  cpu options default to "yes"
>
>i386-default-to-n.patch
>
>serial-02-fixups.patch
>  serial fixups (untested)
>  serial-02 fixes
>  serial-02 fixes
>
>serial-03-fixups.patch
>  more serial driver fixups
>  serial-03 fixes
>  serial-03 fixes
>
>ia32-MSI-vector-handling-fix.patch
>  ia32 MSI vector handling fix
>
>aha152x-update.patch
>  aha152x update
>
>aha152x-update-fix.patch
>  aha152x update fix
>
>PP0-full_list-RC1.patch
>  parport fixes [1/5]
>
>PP1-parport_locking-RC1.patch
>  parport fixes [2/5]
>
>PP2-enumerate1-RC1.patch
>  parport fixes [3/5]
>
>PP2-enumerate1-RC1-fix.patch
>
>PP3-parport_gsc-RC1.patch
>  parport fixes [4/5]
>
>PP4-bwqcam-RC1.patch
>  parport fixes [5/5]
>
>bw-qcam-typo-fix.patch
>  bw-qcam typo fix
>
>PP5-daisy-RC1.patch
>  parport fixes [2/5]
>
>PI0-schedule_claimed-RC1.patch
>  paride cleanups and fixes [1/24]
>
>PI1-expansion-RC1.patch
>  paride cleanups and fixes [2/24]
>
>PI2-crapectomy-RC1.patch
>  paride cleanups and fixes [3/24]
>
>PI3-ps_ready-RC1.patch
>  paride cleanups and fixes [4/24]
>
>PI4-pd_busy-RC1.patch
>  paride cleanups and fixes [5/24]
>
>PI5-do_pd_io-RC1.patch
>  paride cleanups and fixes [6/24]
>
>PI6-bogus_requests-RC1.patch
>  paride cleanups and fixes [7/24]
>
>PI7-claim_reorder-RC1.patch
>  paride cleanups and fixes [8/24]
>
>PI8-do_pd_request1-RC1.patch
>  paride cleanups and fixes [9/24]
>
>PI9-run_fsm-RC1.patch
>  paride cleanups and fixes [10/24]
>
>PI10-action-RC1.patch
>  paride cleanups and fixes [2/24]
>
>PI11-disconnect-RC1.patch
>  paride cleanups and fixes [12/24]
>
>PI12-unclaim-RC1.patch
>  paride cleanups and fixes [13/24]
>
>PI13-run_fsm-loop-RC1.patch
>  paride cleanups and fixes [14/24]
>
>PI14-next_request-RC1.patch
>  paride cleanups and fixes [15/24]
>
>PI15-do_pd_io-gone-RC1.patch
>  paride cleanups and fixes [16/24]
>
>PI16-pd_claimed-RC1.patch
>  paride cleanups and fixes [17/24]
>
>PI17-connect-RC1.patch
>  paride cleanups and fixes [18/24]
>
>PI18-reorder-RC1.patch
>  paride cleanups and fixes [19/24]
>
>PI19-special1-RC1.patch
>  paride cleanups and fixes [20/24]
>
>PI20-gendisk_setup-RC1.patch
>  paride cleanups and fixes [21/24]
>
>PI21-present-RC1.patch
>  paride cleanups and fixes [22/24]
>
>PI22-pd_init_units-RC1.patch
>  paride cleanups and fixes [23/24]
>
>PI23-special2-RC1.patch
>  paride cleanups and fixes [24/24]
>
>PI24-paride64-RC1.patch
>  paride cleanups and fixes [25/24]
>
>IMM0-lindent-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [1/8]
>
>IMM1-references-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [2/8]
>
>IMM2-claim-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [3/8]
>
>IMM3-scsi_module-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [4/8]
>
>IMM4-imm_probe-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [5/8]
>
>IMM5-imm_wakeup-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [6/8]
>
>IMM6-imm_hostdata-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [7/8]
>
>IMM7-imm_attach-RC1.patch
>  drivers/scsi/imm.c cleanups and fixes [8/8]
>
>PPA0-ppa_lindent-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [1/9]
>
>PPA1-ppa_references-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [2/9]
>
>PPA2-ppa_claim-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [3/9]
>
>PPA3-ppa_scsi_module-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [4/9]
>
>PPA4-ppa_probe-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [5/9]
>
>PPA5-ppa_wakeup-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [6/9]
>
>PPA6-ppa_hostdata-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [7/9]
>
>PPA7-ppa_attach-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [8/9]
>
>PPA8-ppa_lock_fix-RC1.patch
>  drivers/scsi/ppa.c cleanups and fixes [9/9]
>
>nfs-01-rpc_pipe_timeout.patch
>  NFSv4/RPCSEC_GSS: userland upcall timeouts
>
>nfs-02-auth_gss.patch
>  RPCSEC_GSS: More fixes to the upcall mechanism.
>
>nfs-03-pipe_close.patch
>  RPCSEC_GSS: detect daemon death
>
>nfs-04-fix_nfs4client.patch
>  NFSv4: oops fix
>
>nfs-05-fix_idmap.patch
>  NFSv4: client name fixes
>
>nfs-06-fix_idmap2.patch
>  NFSv4: Bugfixes and cleanups client name to uid mapper.
>
>nfs-07-gss_krb5.patch
>  RPCSEC_GSS: Make it safe to share crypto tfms among multiple
> threads.
>
>nfs-08-gss_missingkfree.patch
>  RPCSEC_GSS: Oops. Major memory leak here.
>
>nfs-09-memleaks.patch
>  RPCSEC_GSS: Fix two more memory leaks found by the stanford
> checker.
>
>nfs-10-refleaks.patch
>  RPCSEC_GSS: Fix yet more memory leaks.
>
>nfs-11-krb5_cleanup.patch
>  RPCSEC_GSS: krb5 cleanups
>
>nfs-12-gss_nokmalloc.patch
>  RPCSEC_GSS: memory allocation fixes
>
>nfs-13-krb5_integ.patch
>  RPCSEC_GSS: Client-side only support for rpcsec_gss integrity
> protection.
>
>nfs-14-clnt_seqno_to_req.patch
>  RPCSEC_GSS: gss sequence number history fixes
>
>nfs-15-encode_pages_tail.patch
>  XDR: page encoding fix
>
>nfs-16-rpc_clones.patch
>  RPC: transport sharing
>
>nfs-17-rpc_clone2.patch
>  NFSv4/RPCSEC_GSS: use RPC cloning
>
>nfs-18-renew_xdr.patch
>  NFSv4: make RENEW a standalone RPC call
>
>nfs-19-renewd.patch
>  NFSv4: make lease renewal daemon per-server
>
>nfs-20-fsinfo_xdr.patch
>  NFSv4: Split the code for retrieving static server information out
> of the GETATTR compound.
>
>nfs-21-setclientid_xdr.patch
>  NFSv4: Make SETCLIENTID and SETCLIENTID_CONFIRM standalone
> operations
>
>nfs-22-errno.patch
>  NFSv4: errno fixes
>
>nfs-23-open_reclaim.patch
>  NFSv4: Preparation for the server reboot recovery code.
>
>nfs-24-state_recovery.patch
>  NFSv4: Basic code for recovering file OPEN state after a server
> reboot.
>
>nfs-25-soft.patch
>  RPC/NFSv4: Allow lease RENEW calls to be soft
>
>nfs-26-sock_disconnect.patch
>  RPC: TCP timeout fixes
>
>nfs-27-atomic_open.patch
>  NFSv4: Atomic open()
>
>nfs-28-open_owner.patch
>  NFSv4: Share open_owner structs
>
>nfs-29-fix_idmap3.patch
>  NFSv4: fix multi-partition mount oops
>
>nfs_idmap-warning-fix.patch
>
>nfs-30-lock.patch
>  NFSv4: Add support for POSIX file locking.
>
>nfs-old-gcc-fix.patch
>  NFS: fix for older gcc's
>
>nfs-31-attr.patch
>  NFSv2/v3/v4: New attribute revalidation code
>
>ghash.patch
>  ghash.h from 2.4
>
>tty_io-uml-fix.patch
>  uml: make tty_init callable from UML functions
>
>uml-update.patch
>  UML update
>
>blk_congestion_wait-return-remaining.patch
>  return remaining jiffies from blk_congestion_wait()
>
>vmscan-remove-priority.patch
>  mm/vmscan.c: remove unused priority argument.
>
>kswapd-throttling-fixes.patch
>  kswapd throttling fixes
>
>vm-rss-limit-enforcement.patch
>  RSS limit enforcement for 2.6
>
>kbuild-unmangle-include-options.patch
>  kbuild: Unmangle include options for gcc
>
>sunrpc-sleep_on-removal.patch
>  remove sleep_on from sunrpc
>
>sisfb-update.patch
>  sisfb update
>
>add-config-for-mregparm-3-ng.patch
>  Add CONFIG for -mregparm=3
>
>add-config-for-mregparm-3-ng-fixes.patch
>  arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes
>
>use-funit-at-a-time.patch
>  Use -funit-at-a-time on ia32
>
>add-noinline-attribute.patch
>  Add noinline attribute
>
>dont-inline-rest_init.patch
>  use noinline for rest_init()
>
>kernel_thread_helper-section-fix.patch
>  Force kernel_thread_helper() into .text
>
>fix-more-gcc-34-warnings.patch
>  Fix more gcc 3.4 warnings
>
>gcc-35-netlink.patch
>  gcc-3.5: netlink
>
>gcc-35-packet.patch
>  gcc-3.5: af_packet
>
>gcc-34-string-fixes.patch
>  string fixes for gcc 3.4
>
>gcc-35-bio_phys_segments.patch
>  gcc-3.5: fix extern inline decls
>
>gcc-35-ident-warnings.patch
>  gcc-3.5: #ident fixes
>
>gcc-35-binfmt_elf-warning-fix.patch
>  gcc-3.5: binfmt_elf warning fix
>
>gcc-35-pcm_misc-warnings.patch
>  gcc-3.5: pcm_misc.c warnings
>
>gcc-35-pcm_plugin-warnings.patch
>
>gcc-35-reiserfs-fixes.patch
>  gcc-3.5: reiserfs fixes
>
>gcc-35-tcp_put_port-fix.patch
>  gcc-3.5: tcp_put_port() fix
>
>gcc-35-ip6-ndisc-fix.patch
>  gcc-3.5: ipv6/ndisc.c fixes
>
>gcc-35-ide-fix.patch
>  gcc-3.5: ide.h fixes
>
>gcc-35-elevator.patch
>  gcc-3.5: elevator.h fixes
>
>gcc-35-keyboard-fixes.patch
>  gcc-3.5: keyboard.c fixes
>
>gcc-35-exit-fix.patch
>  gcc-3.5: _exit fix
>
>gcc-35-parport.patch
>  Fix inlining failure (all GCCs) in parport
>
>gcc-34-compilation-fixes.patch
>  More 3.4 compilation fixes
>
>gcc-35-seq_clientmgr.patch
>  gcc-3.5: sound/core/seq/seq_clientmgr.c
>
>gcc-35-tg3.patch
>  gcc-3.5: tg3.c warnings
>
>gcc-35-parport2.patch
>  gcc-3.5: parport warnings
>
>gcc-35-i810_accel.patch
>  gcc-3.5: i810_accel fix
>
>gcc-35-puts-fix.patch
>  gcc-3.5: misc.c warning fix
>
>gcc-35-filesystems.patch
>  gcc-3.5: fsfilter.h, ntfs.h
>
>gcc-35-zatm-fix.patch
>  gcc-3.5: zatm.c fix
>
>gcc-35-vxfs-idents.patch
>  gcc-3.5: vxfs fixes
>
>gcc-35-hfs-fix.patch
>  gcc-3.5: hfs fixes
>
>gcc-35-uPD98402.patch
>  gcc-3.5: drivers/atm/uPD98402.c
>
>gcc-35-intermezzo.patch
>  gcc-3.5: intermezzo
>
>gcc-35-iphase.patch
>  gcc-3.5: iphase.c
>
>gcc-35-suni.patch
>  gcc-3.5: suni.c
>
>gcc-35-fore2000e.patch
>  gcc-3.5: drivers/atm/fore200e.c
>
>gcc-35-ncpfs.patch
>  gcc-3.5: ncpfs
>
>gcc-35-eni.patch
>  gcc-3.5: drivers/atm/eni.c
>
>gcc-35-xfs.patch
>  gcc-3.5: XFS fixes
>
>gcc-35-idt77105.patch
>  gcc-3.5: drivers/atm/idt77105.c
>
>gcc-35-atmtcp.patch
>  gcc-3.5: drivers/atm/atmtcp.c
>
>gcc-35-appletalk.patch
>  gcc-3.5: appletalk
>
>gcc-35-he.patch
>  gcc-3.5: drivers/atm/he.c
>
>gcc-35-atm-common.patch
>  gcc-3.5: net/atm/common.c
>
>gcc-35-it87.patch
>  gcc-3.5: drivers/i2c/chips/it87.c
>
>gcc-35-econet.patch
>  gcc-3.5: econet
>
>gcc-35-decnet.patch
>  gcc-3.5: decnet
>
>gcc-35-radeon.patch
>  gcc-3.5: radeon
>
>gcc-35-sc1200.patch
>  gcc-3.5: drivers/ide/pci/sc1200.c
>
>gcc-35-ipx.patch
>  gcc-3.5: ipx
>
>gcc-35-irda.patch
>  gcc-3.5: irda
>
>gcc-35-raid6x86.patch
>  gcc-3.5: raid6
>
>gcc-35-mtd.patch
>  gcc-3.5: mtd
>
>gcc-35-dvb.patch
>  gcc-35: DVB
>
>gcc-35-bonding.patch
>  gcc-3.5: bonding
>
>gcc-35-ax25.patch
>  gcc-3.5: ax25
>
>gcc-35-pcmcia.patch
>  gcc-3.5: PCMCIA
>
>gcc-35-video.patch
>  gcc-3.5: video
>
>gcc-35-net-key.patch
>  gcc-3.5: net/key/af_key.c
>
>gcc-35-netrom.patch
>  gcc-3.5: netrom
>
>gcc-35-llc.patch
>  gcc-3.5: llc
>
>gcc-35-pnpbios.patch
>  gcc-3.5: pnpbios
>
>gcc-35-rose.patch
>  gcc-3.5: net/rose
>
>gcc-35-53c700.patch
>  gcc-3.5: drivers/scsi/53c700
>
>gcc-35-advansys.patch
>  gcc-3.5: advansys.c
>
>gcc-35-sctp-attribute_packed-fix.patch
>  gcc-3.5: sctp
>
>gcc-35-atp870u.patch
>  gcc-3.5: atp870u.c
>
>gcc-35-gdth.patch
>  gcc-3.5: gdth.c
>
>gcc-35-pppoe.patch
>  gcc-3.5: pppoe
>
>gcc-35-fbcon.patch
>  gcc-3.5: fbcon.c
>
>gcc-35-riva-fbdev.patch
>  gcc-3.5: drivers/video/riva/fbdev.c
>
>gcc-35-video-cfbimgblt.patch
>  gcc-3.5: drivers/video/cfbimgblt.c
>
>gcc-35-video-vgastate.patch
>  gcc-3.5: drivers/video/vgastate.c
>
>gcc-35-traps.patch
>  gcc-3.5: arch/i386/kernel/traps.c
>
>gcc-35-x86_64.patch
>  x86-64 fixes for gcc 3.5
>
>bitmap-parsing-printing-v4.patch
>  bitmap parsing/printing routines, version 4
>
>bitmap-parsing-cleanup.patch
>  bitmap parsing/printing routines cleanup
>
>non-readable-binaries.patch
>  Handle non-readable binfmt_misc executables
>
>fix-improve-modular-ide.patch
>  fix/improve modular IDE
>
>ide-pdc4030-build-fix.patch
>
>ppc32-ide-build-fix.patch
>  ppc32 IDE build fix
>
>janitor-09-i387-usercopy-check.patch
>  i387: handle copy_from_user() error
>
>doc-remove-modules-conf-references.patch
>  Documentation: remove /etc/modules.conf refs
>
>more-MODULE_ALIASes.patch
>  add some more MODULE_ALIASes
>
>bonding-alias-revert-and-docco-fix.patch
>  bonding alias revert and documentation fix
>
>simplify-net_ratelimit.patch
>  simplify net_ratelimit()
>
>printk-rate_limit-fixes.patch
>  printk_ratelimit() tweaks
>
>readX_relaxed.patch
>  add readX_relaxed() interface
>
>kconfig-use-select-2.patch
>  Kconfig: use select statements
>
>kconfig-remove-enable.patch
>  kconfig/wireless: Replace enable with select
>
>use-attribute-const-everywhere.patch
>  use __attribute_const__ everywhere
>
>edd-disksig.patch
>  EDD: read disk80 MBR signature, export through edd module
>
>edd-url-fix.patch
>  EDD report URL change
>
>swsusp-stop-DMA-on-resume.patch
>  swsusp does not stop DMA properly during resume
>
>swsusp-stop-DMA-on-resume-fix.patch
>
>swsusp-trivial-cleanups.patch
>  Trivial cleanups for swsusp
>
>swsusp-more-cleanups.patch
>  More cleanups for swsusp
>
>swsusp-software_suspend-retval-fix.patch
>  Allow software_suspend to fail
>
>swsusp-software_suspend-retval-fix-fix.patch
>
>vmalloc-address-offset-fix.patch
>  vmalloc address offset fix
>
>hugetlbfs_remove_dirent.patch
>  hugetlbfs directory entry cleanup
>
>libfs_timestamp_fixes.patch
>  libfs mtime/ctime updates
>
>hugetlbfs_cleanup.patch
>  hugetlbfs cleanup
>
>console_driver-definition-fix.patch
>  missing `console_driver' with CONFIG_VT && !CONFIG_VT_CONSOLE
>
>partition-naming-fix.patch
>  Make naming of parititions in sysfs match /proc/partitions.
>
>ppc32-1000-hz.patch
>  ppc32: Set HZ to 1000 on ppc32
>
>fix-blockdev-getro.patch
>  fix blockdev --getro for sr, sd, ide-floppy
>
>remove-kstat-cpu-notifiers.patch
>  Remove kstat cpu notifiers
>
>workqueue-cleanup-2.patch
>  Minor workqueue.c cleanup
>
>remove-more-cpu-notifiers.patch
>  Remove More Unneccessary CPU Notifiers
>
>use-CPU_UP_PREPARE-properly.patch
>  Use CPU_UP_PREPARE properly
>
>support-wider-consoles.patch
>  console: support for > 127 chars
>
>remove-valid_addr_bitmap.patch
>  remove valid_addr_bitmap
>
>osst-warning-fix.patch
>  osst.c: suppress page allocation failure warnings
>
>init-cpu_vm_mask-in-init_mm.patch
>  initialise cpu_vm_mask in init_mm
>
>raw-is-obsolete.patch
>  deprecate the raw driver
>
>sleep_on-needs_lock_kernel.patch
>  sleep_on(): check for lock_kernel
>
>ncpfs-stack-usage-fix.patch
>  Fix deep stack usage in ncpfs
>
>remove_suid-fix.patch
>  remove_suid() fix
>
>md-02-preferred_minor-fix.patch
>  md: Move the test in preferred_minor to where it is used.
>
>md-03-debugging-output-cleanup.patch
>  md: Fixes to make debuging output nicer.
>
>md-04-personality-stats-collection.patch
>  md: Collect device IO statistics for MD personalities.
>
>md-05-device-in-error-printing-fix.patch
>  md: Change the way the name of an md device is printed in error
> messages.
>
>proc-partitions-omit-removable-media.patch
>  /proc/paritions: omit removable media
>  Mark floppies as being removeable
>
>remove-SIIG-PCI-IDs-from-parport_pc.patch
>  remove SIIG combo cards PCI ids from parport_pc
>
>i830-agp-pm-fix.patch
>  Intel i830 AGP fix
>
>remove-memblks.patch
>  Remove memblks from the kernel
>
>scsi-tape-fixes.patch
>  SCSI tape cdev fixes
>
>raid-makefile-cleanup.patch
>  Clean up raid6 kbuild output
>
>fancy-lost-ticks-message.patch
>  Better "Losing Ticks" Error Message
>
>x86_64-make-xconfig-fix.patch
>  Fix make xconfig on /lib64 systems
>
>reserve-NUMA-API-syscall-slots.patch
>  Reserve system calls for NUMA API
>
>posix-timers-fixes.patch
>  posix_timers fixes
>
>mount-option-overrun-fix.patch
>  Zero last byte of mount option page.
>
>futex-redundant-test.patch
>  futex: remove redundant test
>
>CONFIG_SYSRQ-fixes.patch
>  [janitor] change a few SYSRQ to MAGIC_SYSRQ
>
>dz-verify_area-removal.patch
>  [janitor] dz: verify_area() removal
>
>oss-c99-fixes.patch
>  [janitor] sound/oss: use C99 inits.
>
>usb-sddr09-documentation.patch
>  add comments to sddr09.c
>
>console-makefile-cleanup.patch
>  console cleanup
>
>oprofile-ringbuffer-wrap-fix.patch
>  oprofile per-cpu buffer overrun
>
>oprofile-alpha-fix.patch
>  oprofile, typo in alpha driver
>
>copy_namespace-enomem-fix.patch
>  copy_namespace ENOMEM fix
>
>vgastate-missing-iounmaps.patch
>  [janitor] vgastate: cleanup iounmap() usage
>
>vga16fb-missing-iounmap.patch
>  [janitor] vga16fb: add missing iounmap()
>
>d_path-needs-vfsmount_lock.patch
>  __d_path needs vfsmount_lock
>
>namei-needs-vfsmount_lock.patch
>  namei.c: take vfsmount_lock
>
>try-reiserfs-earlier.patch
>  try reiserfs before other filesystems
>
>ufs-use-silent.patch
>  UFS: honour `silent' parameter.
>
>time-rounding-accuracy.patch
>  Fine tune the time conversion to eliminate conversion errors.
>
>proc-stat-btime-fix-2.patch
>  /proc/stat:btime fix
>
>menuconfig-choice-display-fix.patch
>  fix menuconfig choice item help display
>
>use-uint32_t-for-crosscompiling.patch
>  u_int32_t causes cross-compile problems
>
>ac97-remove-fix.patch
>  ac97 OSS driver removal fix
>
>is_subdir-locking-fix.patch
>  is_subdir locking fix
>
>proc_check_root-locking-fix.patch
>  proc_check_root() locking fix
>
>pcnet32-locking-fix.patch
>  pcmet32 locking fixes
>
>ide-cd-MO-write-protect.patch
>  ide-cd mo write protect
>
>s390-general-update.patch
>  s390: general update.
>
>s390-inline-assembly-constraints.patch
>  s390: inline assembly constraints.
>
>s390-sclp-fixes.patch
>  s390: sclp bug fixes.
>
>nr_free_pages-is-expensive.patch
>  rate limit nr_free_pages
>
>mmap-use-address-hint.patch
>  Use address hint in mmap for search
>
>shrink_list-swapcache-check-fix.patch
>  shrink_list(): check PageSwapCache() after add_to_swap()
>
>as-docco-update.patch
>  as-iosched.txt update
>
>cscope-use-inverted-index.patch
>  enable fast symbol lookup via an inverted index in cscope
>
>nfs-server-in-root_server_path.patch
>  Pull NFS server address out of root_server_path
>
>pcix-enhanced.patch
>  PCI Express Enhanced Config Patch
>
>Lindent-goodness.patch
>  Lindent fixed to match reality
>
>increase-NGROUPS.patch
>  NGROUPS 2.6.2rc2 + fixups
>
>increase-NGROUPS-cleanup.patch
>  NGROUPS: remove TASK_SIZE usage
>
>intermezzo-NGROUPS-is-broken.patch
>
>move-cpu_vm_mask.patch
>  Move cpu_vm_mask to be closer to mmu_context_t in struct mm
>
>compat-signal-noarch-2004-01-29.patch
>
>compat-signal-ppc64-2004-01-29.patch
>
>compat-signal-ia64-2004-01-29.patch
>
>pci-scan-all-functions.patch
>  PCI Scan all functions
>
>list_del-debug.patch
>  list_del debug check
>
>print-build-options-on-oops.patch
>
>show_task-free-stack-fix.patch
>  show_task() fix and cleanup
>
>show_task-fix.patch
>  show_task() is not SMP safe
>
>oops-dump-preceding-code.patch
>  i386 oops output: dump preceding code
>
>lockmeter.patch
>
>ia64-lockmeter-fix.patch
>
>4g-2.6.0-test2-mm2-A5.patch
>  4G/4G split patch
>  4G/4G: remove debug code
>  4g4g: pmd fix
>  4g/4g: fixes from Bill
>  4g4g: fpu emulation fix
>  4g/4g usercopy atomicity fix
>  4G/4G: remove debug code
>  4g4g: pmd fix
>  4g/4g: fixes from Bill
>  4g4g: fpu emulation fix
>  4g/4g usercopy atomicity fix
>  4G/4G preempt on vstack
>  4G/4G: even number of kmap types
>  4g4g: fix __get_user in slab
>  4g4g: Remove extra .data.idt section definition
>  4g/4g linker error (overlapping sections)
>  4G/4G: remove debug code
>  4g4g: pmd fix
>  4g/4g: fixes from Bill
>  4g4g: fpu emulation fix
>  4g4g: show_registers() fix
>  4g/4g usercopy atomicity fix
>  4g4g: debug flags fix
>  4g4g: Fix wrong asm-offsets entry
>  cyclone time fixmap fix
>  4G/4G preempt on vstack
>  4G/4G: even number of kmap types
>  4g4g: fix __get_user in slab
>  4g4g: Remove extra .data.idt section definition
>  4g/4g linker error (overlapping sections)
>  4G/4G: remove debug code
>  4g4g: pmd fix
>  4g/4g: fixes from Bill
>  4g4g: fpu emulation fix
>  4g4g: show_registers() fix
>  4g/4g usercopy atomicity fix
>  4g4g: debug flags fix
>  4g4g: Fix wrong asm-offsets entry
>  cyclone time fixmap fix
>  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>  4G/4G might_sleep warning fix
>  4g/4g pagetable accounting fix
>  Fix 4G/4G and WP test lockup
>  4G/4G KERNEL_DS usercopy again
>  Fix 4G/4G X11/vm86 oops
>  Fix 4G/4G athlon triplefault
>  4g4g SEP fix
>  Fix 4G/4G split fix for pre-pentiumII machines
>  4g/4g PAE ACPI low mappings fix
>
>zap_low_mappings-fix.patch
>  zap_low_mappings() cannot be __init
>
>4g4g-locked-userspace-copy.patch
>  Do a locked user-space copy for 4g/4g
>
>ppc-fixes.patch
>  make mm4 compile on ppc
>
>O_DIRECT-race-fixes-rollup.patch
>  DIO fixes forward port and AIO-DIO fix
>  O_DIRECT race fixes comments
>  O_DRIECT race fixes fix fix fix
>  DIO locking rework
>  O_DIRECT XFS fix
>
>dio-aio-fixes.patch
>  direct-io AIO fixes
>  dio-aio fix fix
>
>aio-fallback-bio_count-race-fix-2.patch
>  AIO+DIO bio_count race fix
>
>aio-sysctl-parms.patch
>  aio sysctl parms
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
