Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbTIJVQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbTIJVQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:16:09 -0400
Received: from mx02.qsc.de ([213.148.130.14]:7662 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265736AbTIJVO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:14:57 -0400
Date: Wed, 10 Sep 2003 23:17:34 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030910211734.GE1583@gmx.de>
References: <20030908235028.7dbd321b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20030908235028.7dbd321b.akpm@osdl.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

still errors with uncared irq with test5-mm1:

Sep 10 21:36:13 kakerlak kernel: irq 7: nobody cared!
Sep 10 21:36:13 kakerlak kernel: Call Trace:
Sep 10 21:36:13 kakerlak kernel:  [__report_bad_irq+42/144] __report_bad_ir=
q+0x2a/0x90
Sep 10 21:36:13 kakerlak kernel:  [note_interrupt+108/176] note_interrupt+0=
x6c/0xb0
Sep 10 21:36:13 kakerlak kernel:  [do_IRQ+288/304] do_IRQ+0x120/0x130
Sep 10 21:36:13 kakerlak kernel:  [common_interrupt+24/32] common_interrupt=
+0x18/0x20
Sep 10 21:36:13 kakerlak kernel:  [do_softirq+64/160] do_softirq+0x40/0xa0
Sep 10 21:36:13 kakerlak kernel:  [do_IRQ+252/304] do_IRQ+0xfc/0x130
Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60
Sep 10 21:36:13 kakerlak kernel:  [common_interrupt+24/32] common_interrupt=
+0x18/0x20
Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60=20
Sep 10 21:36:13 kakerlak kernel:  [acpi_processor_idle+213/455] acpi_proces=
sor_idle+0xd5/0x1c7
Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60=20
Sep 10 21:36:13 kakerlak kernel:  [cpu_idle+44/64] cpu_idle+0x2c/0x40
Sep 10 21:36:13 kakerlak kernel:  [start_kernel+332/352] start_kernel+0x14c=
/0x160
Sep 10 21:36:13 kakerlak kernel:  [unknown_bootoption+0/256] unknown_bootop=
tion+0x0/0x100
Sep 10 21:36:13 kakerlak kernel:=20
Sep 10 21:36:13 kakerlak kernel: handlers:
Sep 10 21:36:13 kakerlak kernel: [acpi_irq+0/22] (acpi_irq+0x0/0x16)
Sep 10 21:36:13 kakerlak kernel: Disabling IRQ #7

kernel booted with pci=3Dnoacpi, lspci attached

On Mon, Sep 08, 2003 at 11:50:28PM -0700, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5=
/2.6.0-test5-mm1/
>=20
>=20
> Small fixes, mainly.
>=20
>=20
>=20
>=20
> Changes since 2.6.0-test4-mm6:
>=20
>=20
> -sysfs-memleak-fix.patch
> -large-dev_t-2nd-01.patch
> -large-dev_t-2nd-02.patch
> -large-dev_t-2nd-03.patch
> -large-dev_t-2nd-04.patch
> -large-dev_t-2nd-05.patch
> -large-dev_t-2nd-06.patch
> -large-dev_t-2nd-07.patch
> -large-dev_t-2nd-08.patch
> -large-dev_t-2nd-09.patch
> -large-dev_t-2nd-10.patch
> -large-dev_t-2nd-11.patch
> -large-dev_t-2nd-12.patch
> -large-dev_t-2nd-13.patch
> -large-dev_t-2nd-14.patch
> -large-dev_t-2nd-15.patch
> -kobject-unlimited-name-lengths.patch
> -kobject-unlimited-name-lengths-use-after-free-fix.patch
> -remove-version_h.patch
> -remove-__SMP__.patch
> -make-init_mister-static.patch
> -skfddi-copy_user-checks.patch
> -ll_rw_blk-comment-corrections.patch
> -sc520_wdt-ioremap-checking.patch
> -paride-error-return-handling.patch
> -init-exit-cleanups.patch
> -qla1280-pci-alloc-free-checking.patch
> -saa7134-core-ioremap-checking.patch
> -acpi-pci-routing-fixes.patch
>=20
>  Merged
>=20
> +tg3-poll_controller.patch
> +kgdb-eth-reattach.patch
> +kgdb-skb_reserve-fix.patch
>=20
>  kgdb-over-ethernet fixes
>=20
> -fix-io-hangs.patch
> -as-insert-here-fix.patch
>=20
>  Obsoleted
>=20
> +acpi-irq-fixes.patch
>=20
>  Andrew de Quincey's ACPI changes
>=20
> -cfq-3.patch
> -cfq-3-fixes.patch
> +cfq-4.patch
>=20
>  Reworked CFQ IO scheduler
>=20
> -thread-pgrp-fix-2.patch
>=20
>  Obsoleted by group_leader-rework.patch
>=20
> +group_leader-rework.patch
>=20
>  Use the thread group leader's pgrp rather than the current thread's pgrp
>  everywhere.
>=20
> +timer_tsc-cyc2ns_scale-fix.patch
>=20
>  ia32 timer fixlet
>=20
> +ppp-oops-fix.patch
>=20
>  Fix an oops in the PPP driver (with devfs)
>=20
> +d_delete-d_lookup-race-fix.patch
>=20
>  dentry race fix
>=20
> +idle-using-monitor-mwait.patch
> +idle-using-monitor-mwait-tweaks.patch
>=20
>  Support for using the new ia32 monitor/mwait instructions in the idle lo=
op.
>=20
> +remap_file_pages-MAP_NONBLOCK-fix.patch
> +install_page-use-after-unmap-fix.patch
>=20
>  remap_file_pages() fixes
>=20
> +agp-build-fix.patch
>=20
>  Compile fix
>=20
> +inflate-error-cleanup.patch
>=20
>  Error message consistencies.
>=20
> +slab-debug-additions.patch
>=20
>  Slab debug enhancements, including: make sure that objects are aligned at
>  the highest possible address within their page, so overruns are more lik=
ely
>  to trigger the page unmapping debug feature.
>=20
> +mwave-locking-fixes.patch
>=20
>  mwave driver fixes
>=20
> +summit-includes-fix.patch
>=20
>  Build fix
>=20
> +random-lock-contention.patch
>=20
>  Fix lock contention in the new random driver locking on monster SMP.
>=20
> +agp-warning-fix.patch
>=20
>  Fix some warning
>=20
> +ifdown-lockup-fix.patch
>=20
>  Fix network device close hang
>=20
> +fadvise-needs-asmlinkage.patch
>=20
>  Missing asmlinkage
>=20
> +ufs-build-fix.patch
>=20
>  Purge C++isms
>=20
> -put_task_struct-debug.patch
>=20
>  This broke, but the bug was fixed anyway.
>=20
> -sparc64-lockmeter-fix.patch
> -sparc64-lockmeter-fix-2.patch
>=20
>  Folded into lockmeter.patch
>=20
> +4g4g-copy_mount_options-fix.patch
> +4g4g-pagetable-accounting-fix.patch
>=20
>  4G/4G fixes
>=20
>=20
>=20
>=20
>=20
> All 173 patches:
>=20
>=20
> mm.patch
>   add -mmN to EXTRAVERSION
>=20
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>=20
> kgdb-warning-fix.patch
>   kgdbL warning fix
>=20
> kgdb-build-fix.patch
>=20
> kgdb-spinlock-fix.patch
>=20
> kgdb-fix-debug-info.patch
>   kgdb: CONFIG_DEBUG_INFO fix
>=20
> kgdb-cpumask_t.patch
>=20
> kgdb-x86_64-fixes.patch
>   x86_64 fixes
>=20
> kgdb-over-ethernet.patch
>   kgdb-over-ethernet patch
>=20
> kgdb-over-ethernet-fixes.patch
>   kgdb-over-ethernet fixlets
>=20
> kgdb-CONFIG_NET_POLL_CONTROLLER.patch
>   kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers
>=20
> kgdb-handle-stopped-NICs.patch
>   kgdb: handle netif_stopped NICs
>=20
> eepro100-poll-controller.patch
>=20
> tlan-poll_controller.patch
>=20
> tulip-poll_controller.patch
>=20
> tg3-poll_controller.patch
>   kgdb: tg3 poll_controller
>=20
> kgdb-eth-smp-fix.patch
>   kgdb-over-ethernet: fix SMP
>=20
> kgdb-eth-reattach.patch
>=20
> kgdb-skb_reserve-fix.patch
>   kgdb-over-ethernet: skb_reserve() fix
>=20
> acpi-irq-fixes.patch
>   Next round of ACPI IRQ fixes (VIA ACPI fixed)
>=20
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes
>=20
> no-unit-at-a-time.patch
>   Use -fno-unit-at-a-time if gcc supports it
>=20
> calibrate_tsc-consolidation.patch
>   calibrate_tsc() fix and consolidation
>=20
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
>=20
> ppc64-build-fixes.patch
>   Fix ppc64 breakage
>=20
> ppc64-bar-0-fix.patch
>   Allow PCI BARs that start at 0
>=20
> ppc64-reloc_hide.patch
>=20
> ppc64-semaphore-reimplementation.patch
>   ppc64: use the ia32 semaphore implementation
>=20
> ppc64-local.patch
>   ppc64: local.h implementation
>=20
> sym-do-160.patch
>   make the SYM driver do 160 MB/sec
>=20
> rt-tasks-special-vm-treatment.patch
>   real-time enhanced page allocator and throttling
>=20
> rt-tasks-special-vm-treatment-2.patch
>=20
> input-use-after-free-checks.patch
>   input layer debug checks
>=20
> fbdev.patch
>   framebbuffer driver update
>=20
> cursor-flashing-fix.patch
>   fbdev: fix cursor letovers
>=20
> slab-hexdump.patch
>   slab: hexdump structures when things go wrong
>=20
> aic7xxx-parallel-build-fix.patch
>   fix parallel builds for aic7xxx
>=20
> group_leader-rework.patch
>   Fix setpgid and threads
>   use group_leader->pgrp (was Re: setpgid and threads)
>=20
> ramdisk-cleanup.patch
>=20
> delay-ksoftirqd-fallback.patch
>   Try harded in IRQ context before falling back to ksoftirqd
>=20
> intel8x0-cleanup.patch
>   intel8x0 cleanups
>=20
> claim-serio-early.patch
>   Serio: claim serio early
>=20
> mark-devfs-obsolete.patch
>   mark devfs obsolete
>=20
> VT8231-router-detection.patch
>   VT8231 IRQ router detection
>=20
> block-devfs-conversions.patch
>   Initialise devfs_name in various block drivers
>=20
> timer_tsc-cyc2ns_scale-fix.patch
>   monolitic_clock, timer_{tsc,hpet} and CPUFREQ
>=20
> test4-pm1.patch
>   power management update
>=20
> ide-pm-oops-fix.patch
>   IDE power management oops fix
>=20
> swsusp-fpu-fix.patch
>   swsusp fpu management fix
>=20
> ricoh-mask-fix.patch
>   pcmcia: ricoh.h mask fix
>   EDEC
>   From: KOMURO <komujun@nifty.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
>  =20
>   RL5C4XX_16BIT_MEM_0 was wrong.
>=20
> dac960-devfs_name-fix.patch
>   dac960 devfs_name initialisation fix
>=20
> dac960-warning-fixes.patch
>   compiler warning fixes for DAC960 on alpha
>=20
> ikconfig-gzipped-2.patch
>   Move ikconfig to /proc/config.gz
>   ikconfig cleanup
>=20
> flush-invalidate-fixes.patch
>   memory writeback/invalidation fixes
>=20
> flush-invalidate-fixes-warning-fix.patch
>=20
> ide_floppy-maybe-fix.patch
>   might fix ide_floppy
>=20
> reiserfs-direct-io.patch
>   resierfs direct-IO support
>=20
> pdflush-diag.patch
>=20
> joydev-exclusions.patch
>   joydev is too eager claiming input devices
>=20
> might_sleep-diags.patch
>=20
> imm-fix-fix.patch
>   Fix imm.c again
>=20
> selinux-option-config-option.patch
>   make selinux enable param config option, enabled by default
>=20
> sound-remove-duplicate-includes.patch
>   sound: remove duplicate includes
>=20
> kernel-remove-duplicate-includes.patch
>   remove duplicate includes in kernel/
>=20
> utime-on-immutable-file-fix.patch
>   disallow utime{s}() on immutable or append-only files
>=20
> add-daniele-to-credits.patch
>   add Daniele to CREDITS
>=20
> NR_CPUS-overflow-fix.patch
>   Handle NR_CPUS overflow
>=20
> ppp-oops-fix.patch
>   ppp oops fix
>=20
> d_delete-d_lookup-race-fix.patch
>   d_delete-d_lookup race fix
>=20
> idle-using-monitor-mwait.patch
>   idle using PNI monitor/mwait
>=20
> idle-using-monitor-mwait-tweaks.patch
>=20
> remap_file_pages-MAP_NONBLOCK-fix.patch
>   remap file pages MAP_NONBLOCK fix
>=20
> install_page-use-after-unmap-fix.patch
>   install_page pte use-after-unmap fix
>=20
> agp-build-fix.patch
>   AGPGART_MINOR needs <linux/agpgart.h>
>=20
> really-use-english-date-in-version-string.patch
>   really use english date in version string
>=20
> inflate-error-cleanup.patch
>   tidy up lib/inflate.c error messages
>=20
> slab-debug-additions.patch
>   Move slab objects to the end of the real allocation
>=20
> mwave-locking-fixes.patch
>   mwave locking fixes
>=20
> summit-includes-fix.patch
>   fix Summit srat.h includes
>=20
> random-lock-contention.patch
>   Redue random driver lock contention
>=20
> agp-warning-fix.patch
>   AGP warning fix
>=20
> ifdown-lockup-fix.patch
>=20
> fadvise-needs-asmlinkage.patch
>=20
> ufs-build-fix.patch
>   fs/ufs/namei.c build fix
>=20
> p00001_synaptics-restore-on-close.patch
>=20
> p00002_psmouse-reset-timeout.patch
>=20
> p00003_synaptics-multi-button.patch
>=20
> p00004_synaptics-optional.patch
>=20
> p00005_synaptics-pass-through.patch
>=20
> p00006_psmouse-suspend-resume.patch
>=20
> p00007_synaptics-old-proto.patch
>=20
> synaptics-mode-set.patch
>   Synaptics mode setting
>=20
> syn-multi-btn-fix.patch
>   synaptics multibutton fix
>=20
> keyboard-resend-fix.patch
>   keyboard resend fix
>=20
> psmouse_ipms2-option.patch
>   Force mouse detection as imps/2 (and fix my KVM switch)
>=20
> i8042-history.patch
>   debug: i8042 history dumping
>=20
> linux-isp-2.patch
>=20
> linux-isp-2-fix-again.patch
>   lost feral fix
>=20
> feral-bounce-fix.patch
>   Feral driver - highmem issues
>=20
> feral-bounce-fix-2.patch
>   Feral driver bouncing fix
>=20
> list_del-debug.patch
>   list_del debug check
>=20
> print-build-options-on-oops.patch
>   print a few config options on oops
>=20
> show_task-free-stack-fix.patch
>   show_task() fix and cleanup
>=20
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
>=20
> lockmeter.patch
>=20
> printk-oops-mangle-fix.patch
>   disentangle printk's whilst oopsing on SMP
>=20
> 20-odirect_enable.patch
>=20
> 21-odirect_cruft.patch
>=20
> 22-read_proc.patch
>=20
> 23-write_proc.patch
>=20
> 24-commit_proc.patch
>=20
> 25-odirect.patch
>=20
> nfs-O_DIRECT-always-enabled.patch
>   Force CONFIG_NFS_DIRECTIO
>=20
> sched-CAN_MIGRATE_TASK-fix.patch
>   CAN_MIGRATE fix
>=20
> sched-balance-fix-2.6.0-test3-mm3-A0.patch
>   sched-balance-fix-2.6.0-test3-mm3-A0
>=20
> sched-2.6.0-test2-mm2-A3.patch
>   sched-2.6.0-test2-mm2-A3
>=20
> ppc-sched_clock.patch
>=20
> ppc64-sched_clock.patch
>   ppc64: sched_clock()
>=20
> sparc64_sched_clock.patch
>=20
> x86_64-sched_clock.patch
>   Add sched_clock for x86-64
>=20
> sched-warning-fix.patch
>=20
> sched-balance-tuning.patch
>   CPU scheduler balancing fix
>=20
> sched-no-tsc-on-numa.patch
>   Subject: Re: Fw: Re: 2.6.0-test2-mm3
>=20
> o12.2int.patch
>   O12.2int for interactivity
>=20
> o12.3.patch
>   O12.3 for interactivity
>=20
> o13int.patch
>   O13int for interactivity
>=20
> o13.1int.patch
>   O13.1int
>=20
> o14int.patch
>   O14int
>=20
> o14int-div-fix.patch
>   o14int 64-bit-divide fix
>=20
> o14.1int.patch
>   O14.1int
>=20
> o15int.patch
>   O15int for interactivity
>=20
> o16int.patch
>   From: Con Kolivas <kernel@kolivas.org>
>   Subject: [PATCH] O16int for interactivity
>=20
> o16.1int.patch
>   O16.1int for interactivity
>=20
> o16.2int.patch
>   O16.2int
>=20
> o16.3int.patch
>   O16.3int
>=20
> o18int.patch
>   O18int
>=20
> o18.1int.patch
>   O18.1int
>=20
> sched-cpu-migration-fix.patch
>   sched: task migration fix
>=20
> o19int.patch
>   O19int
>=20
> o20int.patch
>   O20int
>=20
> 4g-2.6.0-test2-mm2-A5.patch
>   4G/4G split patch
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>=20
> 4g4g-cyclone-timer-fix.patch
>=20
> 4g4g-copy_mount_options-fix.patch
>   use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>=20
> 4g4g-pagetable-accounting-fix.patch
>   4g/4g pagetable accounting fix
>=20
> ppc-fixes.patch
>   make mm4 compile on ppc
>=20
> aic7xxx_old-oops-fix.patch
>=20
> aio-01-retry.patch
>   AIO: Core retry infrastructure
>=20
> io_submit_one-EINVAL-fix.patch
>   Fix aio process hang on EINVAL
>=20
> aio-02-lockpage_wq.patch
>   AIO: Async page wait
>=20
> aio-03-fs_read.patch
>   AIO: Filesystem aio read
>=20
> aio-04-buffer_wq.patch
>   AIO: Async buffer wait
>=20
> aio-05-fs_write.patch
>   AIO: Filesystem aio write
>=20
> aio-05-fs_write-fix.patch
>=20
> aio-06-bread_wq.patch
>   AIO: Async block read
>=20
> aio-06-bread_wq-fix.patch
>=20
> aio-07-ext2getblk_wq.patch
>   AIO: Async get block for ext2
>=20
> O_SYNC-speedup-2.patch
>   speed up O_SYNC writes
>=20
> aio-09-o_sync.patch
>   aio O_SYNC
>=20
> aio-10-BUG-fix.patch
>   AIO: fix a BUG
>=20
> aio-11-workqueue-flush.patch
>   AIO: flush workqueues before destroying ioctx'es
>=20
> aio-12-readahead.patch
>   AIO: readahead fixes
>=20
> aio-dio-no-readahead.patch
>   aio O_DIRECT no readahead
>=20
> lock_buffer_wq-fix.patch
>   lock_buffer_wq fix
>=20
> unuse_mm-locked.patch
>   AIO: hold the context lock across unuse_mm
>=20
> aio-take-task_lock.patch
>   task task_lock in use_mm()
>=20
> aio-O_SYNC-fix.patch
>   Unify o_sync changes for aio and regular writes
>=20
> aio-O_SYNC-fix-missing-bit.patch
>   aio-O_SYNC-fix bits got lost
>=20
> O_SYNC-speedup-nolock-fix.patch
>=20
> aio-writev-nsegs-fix.patch
>   aio: writev nr_segs fix
>=20
> aio-remove-lseek-triggerable-BUG_ONs.patch
>=20
> aio-readahead-rework.patch
>   Unified page range readahead for aio and regular reads
>=20
> aio-readahead-speedup.patch
>   Readahead issues and AIO read speedup
>=20
> aio-osync-fix-2.patch
>   More AIO O_SYNC related fixes
>=20
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards,

Wiktor Wodecki

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d9000000-dbffffff
	Prefetchable memory behind bridge: dc000000-dcffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 7
	Capabilities: <available only to root>

00:09.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
	Subsystem: Triones Technologies, Inc. HPT370A
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
	Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b000 [disabled] [size=256]
	Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:0b.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at b400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at dd001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0d.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 02)
	Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at dd002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at c000 [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] AGP (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0100
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at da000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>


--uXxzq0nDebZQVNAZ--

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/X5Tu6SNaNRgsl4MRAhbpAKCux79PvRtx0O8kJVMrNawsBgCfywCgrozY
3YKOlo5OqcOD6K+FJ8S6wfc=
=6LlQ
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
