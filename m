Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWJaE1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWJaE1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWJaE1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:27:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422701AbWJaE1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:27:23 -0500
Date: Mon, 30 Oct 2006 20:27:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.19-rc4
Message-ID: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another week, another -rc4.

Before I forget, I'd like to thank Adrian Bunk for his regressions 
listings, and ask people who are involved with those (both on the blamer 
and blamee sides) to follow them, and keep making sure that we get them 
resolved - if only by reminding people about the issues, and testing that 
things that are claimed to be resolved really are.

-rc4 is mostly some driver (scsi, and random smattering of other stuff) 
and architecture (avr32, power, arm, with some mips and x86 noise) 
updates, with various random fixes thrown in. The shortlog (appended) is 
about as descriptive as they get - nothing earth-shattering. Things do 
seem to be calming down, although I hope they do so even more for -rc5 if 
we want to have a timely release.

		Linus

---
Adrian Bunk (2):
      [SCSI] aic7xxx: cleanups
      [SCSI] aic79xx: make ahd_set_tags() static

Akinobu Mita (2):
      [WATCHDOG] sc1200wdt.c pnp unregister fix.
      isdn/gigaset: avoid cs->dev null pointer dereference

Al Viro (5):
      [IPV4] ipconfig: fix RARP ic_servaddr breakage
      uml: mconsole fixes
      IOC4 should depend on PCI
      missing include of dma-mapping.h
      missing includes of io.h

Alan Cox (3):
      intel fb: switch to pci_get API
      [SCSI] Switch fdomain to the pci_get API
      JMB 368 PATA detection

Alan Stern (1):
      workqueue: update kerneldoc

Albert Cahalan (1):
      fix i386 regparm=3 RT signal handlers on x86_64

Alexey Dobriyan (4):
      [SCSI] scsi_lib.c: use BUILD_BUG_ON
      CONFIG_PM=n slim: drivers/pcmcia/*
      i82092: wire up errors from pci_register_driver()
      cryptocop: double spin_lock_irqsave()

Amol Lad (3):
      drm: ioremap balanced with iounmap for drivers/char/drm
      [SCSI] drivers/scsi: Handcrafted MIN/MAX macro removal
      ioremap balanced with iounmap for drivers/pcmcia

Andrew Morton (5):
      vmlinux.lds: consolidate initcall sections
      drivers: wait for threaded probes between initcall levels
      ioc4_serial: irq flags fix
      uml: fix compilation options for USER_OBJS
      fix "sunrpc: fix refcounting problems in rpc servers"

Andrew Vasquez (5):
      [SCSI] Maintain module-parameter name consistency with qla2xxx/qla4xxx.
      [SCSI] qla2xxx: Check return value of sysfs_create_bin_file() usage.
      [SCSI] qla2xxx: Workaround D3 power-management issues.
      [SCSI] qla2xxx: Correct QUEUE_FULL handling.
      [SCSI] qla2xxx: Update version number to 8.01.07-k3.

Andrey Mirkin (1):
      [SCSI] megaraid_{mm,mbox}: 64-bit DMA capability fix

Andrey Panin (1):
      visws build fix

Anton Vorontsov (2):
      [ARM] 3897/1: corgi_bl fix module compiling
      [ARM] 3898/1: corgi_bl fix module loading

Arnd Bergmann (2):
      [POWERPC] spufs: fix another off-by-one bug in spufs_mbox_read
      [POWERPC] cell: update defconfig

Auke Kok (3):
      e1000: FIX: 82542 doesn't support WoL
      e1000: Increment version to 7.2.9-k4
      e100: account for closed interface when shutting down

Ben Nizette (1):
      AVR32: add io{read,write}{8,16,32}{be,} support

Benjamin Herrenschmidt (7):
      [POWERPC] Consolidate feature fixup code
      [POWERPC] Support nested cpu feature sections
      [POWERPC] Support feature fixups in vdso's
      [POWERPC] Support feature fixups in modules
      [POWERPC] Cell timebase bug workaround
      [POWERPC] Fix device_is_compatible() const warning
      [POWERPC] Fix CHRP platforms with only 8259

bibo,mao (1):
      fix efi_memory_present_wrapper()

Bruce Allan (1):
      e1000: FIX: fix wrong txdctl threshold bitmasks

Christophe Saout (1):
      Fix dmsetup table output change

Cornelia Huck (2):
      [S390] cio: css_probe_device() must be called enabled.
      [S390] cio: Make ccw_device_register() static.

Craig Hughes (1):
      [ARM] 3902/1: Enable GPIO81-84 on PXA255

Dave Jones (2):
      fix return code in error case.
      PCI: x86-64: mmconfig missing printk levels

David Brownell (1):
      pcmcia: at91_cf update

David Howells (1):
      VFS: Fix an error in unused dentry counting

David S. Miller (4):
      [ATM] horizon: read_bia() needs to be __devinit
      [SPARC64]: Fix central/FHC bus handling on Ex000 systems.
      [SPARC64]: Fix memory corruption in pci_4u_free_consistent().
      [SPARC]: Fix bus_id[] string overflow.

Dominik Brodowski (2):
      pcmcia: add more IDs to hostap_cs.c
      PCMCIA: fix __must_check warnings

Doug Maxey (1):
      [SCSI] qla4xxx: fix double printk on load

Dwayne Grant Mcconnell (1):
      [POWERPC] spufs: fix signal2 file to report signal2

Eiichiro Oiwa (1):
      PCI: fix pci_fixup_video as it blows up on sparc64

Eric Sandeen (2):
      jbd: journal_dirty_data re-check for unmapped buffers
      jbd2: journal_dirty_data re-check for unmapped buffers

Eric Sesterhenn (2):
      Remove unnecessary check in drivers/video/intelfb/intelfbhw.c
      [SCSI] lpfc: check before dereference in lpfc_ct.c

Eric W. Biederman (2):
      x86-64: Simplify the vector allocator.
      x86-64: Only look at per_cpu data for online cpus.

FUJITA Tomonori (1):
      [SCSI] replace u8 and u32 with __u8 and __u32 in scsi.h for user space

Gavin McCullagh (1):
      [TCP] H-TCP: fix integer overflow

Geert Uytterhoeven (1):
      m68k: consolidate initcall sections

Gerald Schaefer (1):
      [S390] Initialize interval value to 0.

Gerrit Renker (1):
      [DCCP]: Update documentation references.

Giridhar Pemmasani (2):
      __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
      Fix GFP_HIGHMEM slab panic

Guennadi Liakhovetski (1):
      [SCSI] tmscsim: set max_sectors

Haavard Skinnemoen (7):
      AVR32: Minor Makefile cleanup
      AVR32: Silence some compile warnings
      AVR32: Don't try to iounmap P2 segment addresses
      AVR32: Fix oversize immediates in atomic.h
      AVR32: Implement and export __raw_{read,write}s[bwl]
      AVR32: Use __raw MMIO access for internal peripherals
      AVR32: Update defconfig

Hannes Reinecke (6):
      [SCSI] aic7xxx: Adjust .max_sectors
      [SCSI] scsi_debug: support REPORT TARGET PORT GROUPS
      [SCSI] aic79xx: Fixup external device reset
      [SCSI] aic79xx: set precompensation
      [SCSI] aic7xxx: Remove slave_destroy
      [SCSI] aic79xx: Print out signalling

Heiko Carstens (1):
      [S390] uaccess error handling.

Henne (3):
      [SCSI] Scsi_Cmnd convertion in sun3-driver
      [SCSI] Scsi_Cmnd conversion in qlogicfas408 driver
      [SCSI] fix typo in previous Scsi_Cmnd convertion in aic7xxx_old.c

Henrik Kretzschmar (3):
      [SCSI] Scsi_Cmnd conversion in psi240i driver
      [SCSI] convert ninja driver to struct scsi_cmnd
      [SCSI] fc4: Conversion to struct scsi_cmnd in fc4

Hugh Dickins (3):
      hugetlb: fix size=4G parsing
      hugetlb: fix prio_tree unit
      hugetlb: fix absurd HugePages_Rsvd

Jake Moilanen (1):
      [POWERPC] Add 970GX cputable entry

James Bottomley (1):
      [SCSI] add can_queue to host parameters

Jan Dittmer (1):
      Add missing space in module.c for taintskernel

Jeff Garzik (2):
      drm: fix error returns, sysfs error handling
      PCMCIA: handle sysfs, PCI errors

Jens Axboe (2):
      CFQ: use irq safe locking in cfq_cic_link()
      CFQ: bad locking in changed_ioprio()

Jes Sorensen (1):
      [SCSI] qla1280 bus reset typo

Jesper Juhl (1):
      silence 'make xmldocs' warning by adding missing description of 'raw' in nand_base.c:1485

Jesse Brandeburg (4):
      e1000: FIX: don't poke at manageability registers for incompatible adapters
      e1000: FIX: Disable Packet Split for non jumbo frames
      e1000: FIX: Don't limit descriptor size to 4kb for PCI-E adapters
      e1000: FIX: move length adjustment due to crc stripping disabled.

Jim Houston (1):
      time_adjust cleared before use

Jonathan McDowell (1):
      Export soc_common_drv_pcmcia_remove to allow modular PCMCIA.

Jun'ichi Nomura (2):
      fix bd_claim_by_kobject error handling
      clean up add_bd_holder()

Kai Makisara (1):
      [SCSI] st: Fixup -ENOMEDIUM

Karsten Wiese (1):
      PCI: Remove quirk_via_abnormal_poweroff

Kaustav Majumdar (1):
      pcmcia: update alloc_io_space for conflict checking for multifunction PC card

Keith Packard (1):
      Merge headphone and speaker volume controls for Panasonic R4 laptop

Kevin Hilman (1):
      [ARM] 3909/1: Disable UWIND_INFO for ARM (again)

Kristian Mueller (1):
      APM: URL of APM 1.2 specs has changed

Kristoffer Ericson (1):
      [ARM] 3914/1: [Jornada7xx] - Typo Fix in cpu-sa1110.c (b != B)

Lennert Buytenhek (1):
      [ARM] 3913/1: n2100: fix IRQ routing for second ethernet port

Linus Torvalds (2):
      Revert "r8169: mac address change support"
      Linux 2.6.19-rc4

Liu Dave-r63238 (1):
      [POWERPC] Fix the UCC rx/tx clock of QE

Manish Lachwani (1):
      [MIPS] Make SB1 cache flushes not to use on_each_cpu

Mark A. Greer (1):
      [POWERPC] Don't require execute perms on wrapper when building zImage.initrd

Martin Bligh (2):
      vmscan: Fix temp_priority race
      Use min of two prio settings in calculating distress for reclaim

Mel Gorman (1):
      Calculation fix for memory holes beyong the end of physical memory

Michael Holzheu (1):
      strstrip remove last blank fix

Michael Karcher (1):
      drm: savage: dev->agp_buffer_map is not initialized for AGP DMA on savages

Michael Reed (1):
      [SCSI] mptfc: stall eh handlers if resetting while rport blocked

Mike Christie (5):
      [SCSI] iscsi class: fix slab corruption during restart
      [SCSI] libiscsi: fix oops in connection create failure path
      [SCSI] libiscsi: fix missed iscsi_task_put in xmit error path
      [SCSI] libiscsi: fix aen support
      [SCSI] libiscsi: fix logout pdu processing

MUNEDA Takahiro (1):
      acpiphp: fix latch status

Neil Brown (1):
      sunrpc: fix refcounting problems in rpc servers

NeilBrown (3):
      md: fix bug where spares don't always get rebuilt properly when they become live
      md: simplify checking of available size when resizing an array
      md: fix up maintenance of ->degraded in multipath

Nick Piggin (1):
      mm: clean up pagecache allocation

Olaf Hering (1):
      [POWERPC] Fix hang in start_ldr if _end or _edata is unaligned

Oleg Nesterov (10):
      fill_tgid: fix task_struct leak and possible oops
      bacct_add_tsk: fix unsafe and wrong parent/group_leader dereference
      taskstats_tgid_free: fix usage
      taskstats_tgid_alloc: optimization
      taskstats: kill ->taskstats_lock in favor of ->siglock
      taskstats: don't use tasklist_lock
      fill_tgid: cleanup delays accounting
      taskstats: fix sk_buff leak
      taskstats: fix sk_buff size calculation
      xacct_add_tsk: fix pure theoretical ->mm use-after-free

Olof Johansson (1):
      [POWERPC] Make sure __cpu_preinit_ppc970 gets called on 970GX processors

Om Narasimhan (1):
      pcmcia: au1000_generic fix

Paolo 'Blaisorblade' Giarrusso (1):
      Fix "Remove the use of _syscallX macros in UML"

Patrick McHardy (4):
      [XFRM]: Fix xfrm_state accounting
      [NETFILTER]: Fix ip6_tables protocol bypass bug
      [NETFILTER]: Fix ip6_tables extension header bypass bug
      [CRYPTO] users: Select ECB/CBC where needed

Paul Mundt (1):
      [S390] sys_getcpu compat wrapper.

Pavel Emelianov (1):
      Fix potential OOPs in blkdev_open()

Peter Zijlstra (1):
      lockdep: annotate DECLARE_WAIT_QUEUE_HEAD

Ralf Baechle (11):
      [MIPS] Oprofile: fix on non-VSMP / non-SMTC SMP configurations.
      [MIPS] Oprofile: Fix MIPSxx counter number detection.
      [MIPS] SMTC: Make 8 the default number of processors.
      [MIPS] Wire up getcpu(2) and epoll_wait(2) syscalls.
      [MIPS] Ocelot G: Fix build error and numerous warnings.
      [MIPS] EMMA 2 / Markeins: Fix build wreckage due to genirq wreckage.
      [MIPS] EMMA 2 / Markeins: Formitting fixes split from actual address fixes.
      [MIPS] EMMA 2 / Markeins: Convert to name struct resource initialization.
      [MIPS] EMMA 2 / Markeins: struct resource takes physical addresses.
      [MIPS] JMR3927: Fixup another victim of the irq pt_regs cleanup.
      [MIPS] MIPS doesn't need compat_sys_getdents.

Ralph Wuerthner (1):
      [S390] Improve AP bus device removal.

Randy Dunlap (11):
      [SCSI] lpfc: fix printk format warning
      pcmcia/ds: driver layer error checking
      [BRIDGE]: correct print message typo
      ext4: fix printk format warnings
      md: fix printk format warnings, seen on powerpc64:
      ioc4: fix printk format warning
      cciss: fix printk format warning
      move SYS_HYPERVISOR inside the Generic Driver menu
      ndiswrapper: don't set the module->taints flags
      MTD: fix last kernel-doc warning
      docbook: make a filesystems book

Roland Scheidegger (1):
      drm: radeon: only allow specific type-3 packetss through verifier

Russell King (8):
      [ARM] Fix breakage in 7281c248f797723f66244b7ecef204620f664648
      [ARM] Comment out missing configuration symbols
      [ARM] Fix SMP irqflags support
      [ARM] Add realview SMP default configuration
      [ARM] Add __must_check to uaccess functions
      [ARM] Fix i2c-pxa slave mode support
      [ARM] Fix suspend oops caused by PXA2xx PCMCIA driver
      [ARM] Add KBUILD_IMAGE target support

Santiago Leon (1):
      [SCSI] ibmvscsi: correctly reenable CRQ

Satoru Takeuchi (1):
      cpu-hotplug: release `workqueue_mutex' properly on CPU hot-remove

Scott Wood (1):
      [POWERPC] IPIC: Fix spinlock recursion in set_irq_handler

Sergei Shtylyov (1):
      [MIPS] Au1xx0 code sets incorrect mips_hpt_frequency

Sergey Kononenko (1):
      [SCSI] aic94xx: Supermicro motherboards support

Sergey Vlasov (1):
      drivers/ide/pci/generic.c: add missing newline to the all-generic-ide message

Shaohua Li (1):
      PCI: reset pci device state to unknown state for resume

Srinivasa Ds (1):
      [POWERPC] Fix build breakage with CONFIG_PPC32

Stefan Richter (1):
      ieee1394: ohci1394: revert fail on error in suspend

Stephen Hemminger (1):
      [TCP] cubic: scaling error

Stephen Rothwell (2):
      [POWERPC] Simplify stolen time calculation
      Constify compat_get_bitmap argument

Swen Schillig (1):
      [SCSI] zfcp: initialize scsi_host_template.max_sectors with appropriate value

Takashi Ohmasa (2):
      [ARM] 3899/1: Fix the normalization of the denormal double precision number.
      [ARM] 3900/1: Fix VFP Division by Zero exception handling.

Tilman Sauerbeck (1):
      drm: mga: set dev_priv_size

Timur Tabi (1):
      [POWERPC] Fix spelling errors in ucc_fast.c and ucc_slow.c

Vasily Averin (1):
      missing unused dentry in prune_dcache()?

Yasunori Goto (1):
      memory hotplug: __GFP_NOWARN is better for __kmalloc_section_memmap()

Yoichi Yuasa (3):
      [MIPS] Fix warning about unused definition in c-sb1.c
      [MIPS] Au1000: Fix warning about unused variable.
      [MIPS] Fix return value of TXX9 SPI interrupt handler

Zang Roy-r61911 (1):
      [POWERPC] Fix compiler warning message on get_property call

