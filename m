Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVDDVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVDDVud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDDVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:50:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:15493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261414AbVDDVbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:31:06 -0400
Date: Mon, 4 Apr 2005 14:32:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.12-rc2
In-Reply-To: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The diffstat output tells the story: this is a lot of very small changes,
ie tons of small cleanups and bug fixes. With a few new drivers thrown in
for good measure.

This is also the point where I ask people to calm down, and not send me
anything but clear bug-fixes etc. We're definitely well into -rc land. So 
keep it quiet out there,

		Linus

----
Summary of changes from v2.6.12-rc1 to v2.6.12-rc2
==================================================

<jix:bugmachine.ca>:
  o [NETFILTER]: ipt_hashlimit: Fix bug introduced by hlist changes

adam radford:
  o 3ware 9000 driver update

Adrian Bunk:
  o [ARM] NR_CPUS: use range
  o [IPV4]: Mark a struct static in inetpeer.c
  o USB: possible cleanups
  o drivers/usb/serial/: make some functions static
  o drivers/usb/storage/: cleanups
  o drivers/usb/net/pegasus.c: make some code static
  o remove drivers/usb/image/hpusbscsi.c
  o drivers/net/sis900.c: fix a warning
  o drivers/scsi/osst.c: make code static
  o drivers/scsi/osst.c: remove unused code
  o [EQL]: Kill dead code
  o drivers/usb/core/devices.c: small corrections
  o drivers/net/wireless/airo.c: correct a wrong check
  o drivers/usb/class/usb-midi.c: remove dead code
  o drivers/usb/misc/usbtest.c: fix a NULL dereference
  o drivers/usb/media/usbvideo.c: fix a check after use
  o MAINTAINERS: remove obsolete HPUSBSCSI entry
  o drivers/pci/hotplug/cpqphp_core.c: fix a check after use
  o drivers/pci/msi.c: fix a check after use
  o kill drivers/cdrom/mcd.c
  o drivers/block/DAC960.c: fix a use after free
  o drivers/telephony/ixj: fix a use after free
  o fs/attr.c: fix check after use
  o arch/i386/kernel/smp.c: remove a pointless "inline"
  o kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL
  o [ISDN]: Fix off-by-one errors in isdn_ppp.c

Alan Cox:
  o atp870u: Re-merge cleanups
  o atp870u DMA mask fix

Alan Stern:
  o usb-midi: fix arguments to usb_maxpacket()
  o g_file_storage: add configuration and interface strings
  o USB: Prevent hub driver interference during port reset
  o USBcore updates
  o USBcore and HCD updates
  o USBcore updates
  o USBcore updates
  o USBcore updates
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o USB: fix usb file_storage gadget sparse fixes [2/5]
  o Add a scsi_device flag for RETRY_HWERROR

Alex Williamson:
  o [SERIAL] new hp diva console port

Alexander Kern:
  o Excessive atyfb debug messages

Alexander Viro:
  o Uml: little build fixes
  o [SPARC]: iomem annotations in SOC driver
  o non-portable include in coda
  o generic_serial.c portability fix
  o jsm fixes
  o usblcd portability fix
  o cpuset.c __user annotations
  o missing include in lanai.c
  o missing gameport dependencies

Alexander Zarochentcev:
  o arm atomic_sub_and_test()

Amit Gud:
  o unified spinlock initialization

Amos Waterland:
  o ppc64: fix zilog link error

Amy Fong:
  o [SERIAL] 8250/sbc8560 bug/fix

Ananth N. Mavinakayanahalli:
  o ppc64: fix kprobes calling smp_processor_id when preemptible
  o kprobe_handler should  check pre_handler function

Andi Kleen:
  o Fix mmap of /dev/kmem
  o x86_64: Update defconfig
  o x86_64: Add new AMD cpuid flags to cpuinfo
  o x86_64: Busses array is only indexed with a 8bit value, doesn't
    make sense
  o x86_64: Fix compilation with CONFIG_PROC_FS=n
  o x86_64: Move HPET selection into processor specific options
  o x86_64: Remove never used obsolete file
  o x86_64: Fix indentation in vsyscall.c. No functional changes
  o x86_64: Nop out system call instruction in vsyscall page when not
    needed
  o x86_64: Remove obsolete comments in vsyscall.c and fix some others
  o x86_64: Remove noisy printk in K8 bus detection code
  o x86_64: Remove unused and broken code in io.h
  o x86_64: Remove stale unused file
  o x86_64: Move put_user out of line
  o x86_64: Give out of line get_user better calling conventions
  o x86_64: Work around Tyan BIOS MTRR initialization bug
  o x86_64: Include PCI-Express configuration
  o x86_64: Cleanups in new backtrace code in oprofile
  o x86_64: Fix special ISA case in iounmap()
  o x86_64: Fix formatting and white space in signal code
  o x86_64: mem=XXX will now limit kernel memory to XXX instead of
    XXX+1MB
  o x86_64: resume PIT for x86_64
  o x86_64: Fix NMI RTC access race
  o x86_64: Minor fix to TLB flush IPI
  o x86_64: Always reload CR3 completely when a lazy MM thread drops a
    MM
  o x86_64: Fix LDT descriptor
  o x86_64: Change the y2069 bug in the RTC timer code to be a y2100
    bug
  o x86_64: Only free PMDs and PUDs after other CPUs have been flushed
  o x86_64: Don't enable interrupts in oopses unconditionally
  o x86_64: Fix SMP fallback to UP
  o x86_64: Fix CONFIG_PREEMPT
  o x86_64: Fix exception stack detection during backtraces
  o x86_64: Fix gcc 3.4 warning in bitops.c
  o x86_64: Fix missing delay when the TSC counter just   overflowed
  o x86_64: Clean up the IOMMU initialisation a bit
  o x86_64: Fix segment constraints

Andrea Arcangeli:
  o seccomp for ppc64
  o x86_64: avoid panic lockup

Andres Salomon:
  o Possible AMD8111e free irq issue
  o Possible VIA-Rhine free irq issue
  o fix pci_disable_device in 8139too

Andrew Morton:
  o usb hcd u64 warning fix
  o bonding needs inet
  o tty overrun time fix
  o slab: kfree(null) is unlikely
  o slab shrinkers: use vfs_cache_pressure
  o mips linkage fix
  o revert recent gconfig changes
  o [IA64] Andrew's fixes for warnings on ia64 build
  o [IA64] CONFIG_NUMA requires CONFIG_ACPI_NUMA

Andrey Panin:
  o es7000 dmi cleanup

Andy Richter:
  o s390: claw network device driver

Anton Altaparmakov:
  o uml: Fix compilation due to mismerge

Anton Blanchard:
  o ppc64: fix linkage error on G5
  o ppc64: fix semtimedop compat syscall
  o ppc64: fix pseries hcall stubs

Antonino A. Daplas:
  o fbdev: mvidia licensing clarification
  o fbcon: Stop framebuffer operations before hardware is properly
    initialized
  o nvidiafb: Maximize blit buffer capacity
  o nvidiafb: Kconfig help text update for config FB_NVIDIA
  o nvidiafb: Process boot options earlier
  o nvidiafb: Delete i2c bus on driver unload
  o pm2fb: X and VT switching crash fix
  o fbdev: Cleanups in drivers/video part 2
  o atyfb: Add boot/module option to override composite sync
  o fbdev: Kconfig fix for macmodes and PPC
  o fbdev: Convert drivers to pci_register_driver
  o sisfb: Trivial cleanups
  o tridentfb: Clean up printk()'s
  o fbcon: Save var rotate field in struct display
  o fbcon: Call set_par per fb_info once during init
  o fbcon: Do not set palette if console is not visible
  o neofb: Set hwaccel flags properly

Arnaldo Carvalho de Melo:
  o [NET] use sk_acceptq_is_full
  o [NET] make all protos partially use sk_prot

Arthur Kepner:
  o [BONDING]: Use NETIF_F_LLTX in bonding device

Ashok Raj:
  o Fix irq_affinity write from /proc for ia64

Badari Pulavarty:
  o ext3 writepages support for writeback mode
  o ext3 writeback "nobh" option

Bartlomiej Zolnierkiewicz:
  o [ide] make ide_generic_ioctl() take ide_drive_t * as an argument
  o [ide] ide-cd: add basic refcounting
  o [ide] ide-disk: add basic refcounting
  o [ide] ide-floppy: add basic refcounting
  o [ide] ide-tape: add basic refcounting
  o [ide] ide-scsi: add basic refcounting
  o [ide] ide-tape: fix character device ->open() vs ->cleanup() race
  o [ide] drive->nice1 fix
  o [ide] drive->dsc_overlap fix
  o [ide] destroy_proc_ide_device() cleanup
  o [ide] add ide_{un}register_region()
  o [ide] kill ide_drive_t->disk
  o [ide] get driver from rq->rq_disk->private_data
  o [ide] kill ide-default
  o [ide] fix via82cxxx resume failure

Ben Dooks:
  o [ARM PATCH] 2559/1: CL7500 - fix `__iomem` on VIDC_BASE
  o [ARM PATCH] 2561/1: CL7500 - core.c init call should be void
  o [ARM PATCH] 2562/2: CL7500 - iomem fixes
  o [ARM PATCH] 2563/1: RiscPC - update IOMEM annotations
  o [ARM PATCH] 2557/1: S3C2410 - fix otom/nexcoder buiilds due to
    sparse fixes
  o [ARM PATCH] 2638/1: RX3715 - allow fclk as clock source

Benjamin Herrenschmidt:
  o ppc32: Fix PowerMac cpufreq for newer machines
  o ppc32: Fix overflow in cpuinfo freq. display
  o ppc32: Update PowerMac models table
  o ppc32: Add virtual DMA support to legacy floppy driver
  o ppc32: Add pegasos ethernet support
  o ppc64: thermal control for Xserve
  o ppc32/64: Map prefetchable PCI without guarded bit
  o ppc64: Fix ethernet PHY reset on iMac G5
  o vt: don't call unblank at irq time
  o ppc32: move powermac backlight stuff to a workqueue
  o radeonfb: Implement proper workarounds for PLL accesses
  o radeonfb: DDC i2c fix
  o radeonfb: Fix mode setting on CRT monitors
  o radeonfb: Preserve TMDS setting
  o Fix atyfb build on ppc
  o ppc64: add definition for PAGE_AGP
  o ppc64: Fix boot memory corruption

Bjorn Helgaas:
  o [IA64] fix IOSAPIC destinations when CONFIG_SMP=n
  o PCI: trivial DBG tidy-up
  o Netmos parallel/serial/combo support

Bob Montgomery:
  o [IA64] fix bad emulation of unaligned semaphore opcodes The method
    used to categorize the load/store instructions in
    arch/ia64/kernel/unaligned.c is masking the entire set of
    instructions described in Table 4-33 of the 2002 Intel Itanium
    Volume 3: Instruction Set Reference.
  o [IA64] fix for unwind problem through dispatch_illegal_op_fault

Bodo Stroesser:
  o s390: signal stack bug

Brett Russ:
  o libata: support descriptor sense in ctrl page

Brian Waite:
  o ppc32: add support for Sky Computers HDPU Compute blade
  o ppc32: add support for Sky Computers HDPU Compute blade enhanced
    features
  o ppc32: fix broken compile on Sky Computers HDPU platform

Carlos Pardo:
  o sata_sil: Fix FIFO PCI Bus Arbitration

Catalin Boie:
  o [PKT_SCHED]: Fix deadlock in sch_api.c

Chas Williams:
  o [ATM]: Remove bridge/lec interdependency
  o [ATM]: [zatm] fix sparse warning
  o [ATM]: [nicstar] fix some sparse warnings
  o [ATM]: [ambassador] fix sparse warnings
  o [ATM]: [lanai] alpha build fixes
  o [ATM]: assorted cleanups

Chris Wright:
  o [NETLINK]: Remove unused netlink NL_EMULATE_DEV code
  o isofs: more defensive checks against corrupt isofs images
  o Linux 2.6.11.6

Christoph Hellwig:
  o [XFS] Don't dereference user pointers in xattr by handle ioctls
  o [XFS] Stop passing ARCH_CONVERT/ARCH_NOCONVERT around everywhere
  o [XFS] Remove INT_ZERO and INT_ISZERO
  o [XFS] pagebuf_lock_value is also needed for trace builds
  o [XFS] Fix and streamline directory inode number handling

Christoph Lameter:
  o mm counter operations through macros
  o Exports to enable clock driver modules
  o Per cpu irq stat

Christophe Saout:
  o x86-64: Fix preemption off of irq context with PREEMPT_BKL

Clemens Ladisch:
  o emi26: add another product ID for the Emi2|6/A26

Cliff Brake:
  o [ARM PATCH] 2551/1: Fix timer and CPU leds on Vibren PXA255 IDP
    Platform

Colin Leroy:
  o USB: fix missing hunk in drivers/usb/Makefile
  o USB: fix harmful typos in zd1201.c
  o USB: fix shared key auth in zd1201

Cornelia Huck:
  o s390: device unregistering

Coywolf Qi Hunt:
  o make sysrq-F call oom_kill()

Craig Shelley:
  o USB: add driver for CP2101/CP2102 RS232 adaptors

Dale Farnsworth:
  o mii: GigE support bug fixes

Daniel Drake:
  o Fix stereo mutes on Surround volume control

Daniel McNeil:
  o ppc64: fix AIO panic on PPC64 caused by is_hugepage_only_range()

Daniele Venzano:
  o Maintainer change for the sis900 driver

Darren Williams:
  o Stallion driver module clean up

Dave Airlie:
  o verify_area is deprecated, replaced by access_ok
  o drm: issue with unique for XFree86 4.3 backwards compatibility
  o drm: fix issue where agp is acquired before agp_init
  o agp: export agp_find_bridge for drm
  o drm: fixup pci ids
  o drm: Remove incorrect "drm_"-prefix from parameter description
  o Fix sparse NULL/0 warning
  o drm: change DRIVER_ to CORE_
  o drm: radeon idct defines

Dave Jones:
  o [IPV4]: Fix swapped memset args in multipath_wrandom.c

Dave Kleikamp:
  o JFS: Don't clobber wait_queue_head while there are waitors on it
  o JFS: Fix hang caused by race waking commit threads
  o JFS: Don't allow xtLookup to run against directory with inline data
  o JFS: remove aops from directory inodes

David Brownell:
  o USB: add at91_udc recognition
  o USB: usb gadget kconfig tweaks
  o USB: ohci zero length control IN transfers
  o USB: ehci and short in-bulk transfers with 20KB+ urbs
  o USB: usbnet gets status polling, uses for CDC Ethernet
  o USB: usbnet fix for Zaurus C-860
  o USB: net2280 reports correct dequeue status
  o USB: ethernet/rndis gadget driver updates
  o USB: ohci-omap update (mostly clock gating)
  o USB: pxa25x udc updates, mostly PM
  o USB: usb gadget misc sparse fixes [1/5]
  o USB: usb file_storage gadget sparse fixes [2/5]
  o USB: usb gadgetfs sparse fixes [3/5]
  o USB: gadget zero sparse fixes [5/5]
  o USB: usb rndis gadget sparse fixes [4/5]
  o USB: pegasus uses netif_msg_*() filters
  o USB: usbnet minor bugfixes
  o USB: usbnet uses netif_msg_*() ethtool filtering
  o USB: ehci split ISO fixes (full speed audio etc)
  o USB: ohci D3 resume fix

David Howells:
  o FRV: Fix TLB miss mapping cache flush
  o FRV: Cleanup unused variable
  o FRV: Fix kernel configuration
  o BDI: Provide backing device capability information [try #3]
  o BDI: Improve nommu mmap support

David Mosberger:
  o [IA64] minstate.h: fix stray backslash
  o [IA64] Initialize ar.k7 to empty_zero_page early on

David S. Miller:
  o [ARCH]: Consolidate portable unaligned.h implementations
  o [M68KNOMMU]: Use asm-generic/unaligned.h for COLDFIRE
  o [IPV4]: Make multipath algs into true drivers
  o [IPSEC]: Fix __xfrm_find_acq_byseq()
  o [SPARC64]: Eliminate g5 register usage in semaphore support code
  o [SPARC64]: Kill all smp_tune_scheduling(), totally unused
  o [SPARC64]: Kill g5 register usage from rtrap.S
  o [IPV4]: Check multipath ops func pointers against NULL
  o [SPARC64]: Eliminate g5 register usage from bitops assembly
  o [PARISC]: Fix type in unaligned.h header
  o [SPARC64]: Fix fifth arg pointer check for SEMTIMEDOP
  o [SPARC64]: Handle straddling VA space hole correctly
  o [IPV4]: The multipath select_route method must be implemented
  o [NETPOLL]: Do not use __smp_processor_id()
  o [NETPOLL]: netpoll_queue needs to be exported to modules
  o [NET]: Kill NETLINK_DEV and its only user, ethertap
  o [IRDA]: Squash warnings introduced by DEBUG cleanups
  o [TG3]: Add missing CHIPREV_5750_{A,B}X defines
  o [NETROM]: net/netrom.h now needs net/sock
  o [TG3]: Missing counter bump in tigon3_4gb_hwbug_workaround()
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Eliminate g5 register usage in rwsem
  o [SPARC64]: Move rwsem helpers into asm file
  o [SPARC64]: Eliminate g5 register usage from switch_to()
  o [NET]: Forgot to remove doc file when I killed ethertap
  o [SPARC64]: Eliminate g5 register usage from ultra.S
  o [SPARC64]: Create and use new macro, DCACHE_ALIASING_POSSIBLE
  o [SPARC64]: Make *_LOCKED_TLBENT and L1DCACHE_SIZE asm visible
  o [SPARC64]: Handle non-8K PAGE_SIZE better in TLB miss handlers
  o [SPARC64]: Kill stray reference to pgdcache_size
  o [SPARC64]: Make PAGE_SIZE configurable
  o [SPARC64]: Do not use magic constant in mmu_context.h
  o [SPARC64]: Support >=cheetah+ dual-dtlbs properly
  o [SPARC64]: FPU disabled trap needs context register patching
  o [SPARC64]: Some more cheetah+ patches needed for fptraps
  o [SPARC64]: More g5 register usage elimination
  o [SPARC64]: Kill unused header arch/sparc64/lib/VIS.h
  o [SPARC64]: Missed some cases in U1memcpy register rework
  o [SPARC64]: Simplified csum_partial() implementation
  o [SPARC64]: Add UltraSPARC-IV cpu ids
  o [SPARC64]: Simplify checksumming code
  o [SPARC64]: Kill final normal g5 register reference
  o [SPARC64]: Put per-cpu area base into register g5
  o [NBD]: Fix i_sock reference
  o [SPARC64]: Store per-cpu pointer in IMMU TSB register
  o [SPARC64]: Make sure per-cpu area address creates legal TSB value

David Vrabel:
  o [ARM PATCH] 2501/2:  ixp4xx: support edge triggered gpio irqs

David Woodhouse:
  o Fix incorrect bluetooth socket zapping

Dean Roehrich:
  o [XFS] dmapi - Execution of an offline script or binary fails.  If a
    user thread is trying to execute the file that is offline then the
    HSM won't get write access when it attempts invisible I/O to bring
    it online because the user thread has already denied write
    access...but that thread is waiting for us to write the file.... 
    So add a callout from open_exec() to give DMAPI an early notice
    that the file must be online.
  o [XFS] Update copyright to 2005
  o [XFS] fix DMAPI & NOSPACE data corruption

Deepak Saxena:
  o [ARM PATCH] 2576/1: Fix LDRD and LDRSB (Thumb) abort handling

Denis Vlasenko:
  o s390: swapped memset arguments

Dick Hollenbeck:
  o [SERIAL] sealevel 8 port RS-232/RS-422/RS-485 board

Domen Puncer:
  o arch/i386/pci/i386.c: Use new for_each_pci_dev macro
  o usb/rio500: remove interruptible_sleep_on_timeout() usage
  o usb/digi_acceleport: remove interruptible_sleep_on_timeout() usage
  o USB: compile warning cleanup
  o [CRYPTO]: Fix sparse warning in sha256
  o [CRYPTO]: Fix sparse warning in sha512
  o [CRYPTO]: Fix sparse warnings in blowfish
  o [CRYPTO]: Fix sparse warnings in tea
  o net/sk98lin: remove duplicate delay
  o cdrom/cdu31a: cleanups
  o cdrom/cdu31a: locking fixes
  o cdrom/cdu31a: use wait_event
  o i2c/i2c-ite: remove interruptible_sleep_on_timeout() usage
  o i2c/i2c-elektor: remove interruptible_sleep_on_timeout() usage

Dominik Brodowski:
  o pcmcia: properly bail out on MTD-related ioctl invocation
  o pcmcia: don't lock up in rsrc_nonstatic pcmcia_validate_mem
  o pcmcia: don't send eject request events to userspace

Einar Lueck:
  o [IPV4]: Multipath cache algorithm support

Eric Anholt:
  o drm: free kbuf if copy from user fails

Eric Brower:
  o I2C: lost arbitration detection for PCF8584

Eric Dumazet:
  o [IPV4]: Save space in struct inetpeer on 64-bit platforms

Eric Moore:
  o Make Fusion-MPT much faster as module

Eric W. Biederman:
  o x86_64: Add an 64bit entry path for exec

Finn Thain:
  o fix Jazzsonic driver build on m68k

Frank Beesley:
  o I2C: Clean up of i2c-elektor.c build

Frank Pavlic:
  o s390: qeth layer2 fixes
  o s390: qeth tcp segmentation offload

François Romieu:
  o [IPV4]: Fix early use of inline in route.c

Geert Uytterhoeven:
  o M68k: Update signal delivery handling
  o M68k/stdma: Replace sleep_on() with wait_event()
  o Zorro: replace printk() with pr_info() in drivers/zorro/zorro.c
  o Sun-3/3x: Enable Sun partition tables support by default
  o M68k: IP checksum updates
  o Mac NCR5380 SCSI: Fix bus error
  o M68k: Add missing pieces of thread info TIF_MEMDIE support
  o TPM depends on PCI
  o 3dfx DRM depends on PCI

George Anzinger:
  o x86: CMOS time update optimisation
  o Fix POSIX timers expiring before their scheduled time

Georges Toth:
  o USB: rewrite the usblcd driver

Gordon Jin:
  o fix mprotect() with len=(size_t)(-1) to return -ENOMEM
  o fix mmap() return value to conform POSIX

Grant Coady:
  o I2C: group Intel on I2C Hardware Bus support
  o I2C: Drop useless w83781d RT feature

Greg Banks:
  o [XFS] Make XFS provide encoding and decoding callbacks from knfsd
    which encode the fileid portion of the NFS filehandle differently
    than the default functions.  The new fileid formats allow
    filesystems mounted with "inode64" to be exported over NFSv3 (and
    NFSv2 if you also use the "no_subtree_check" export option).

Greg Kroah-Hartman:
  o USB: optimize the usb-storage device string logic a bit
  o USB: minor cleanup of string freeing in core code
  o USB: fix cpia_usb driver's warning messages in the syslog
  o PCI: increase the size of the pci.ids strings
  o Remove item from feature-removal-schedule.txt that was already
    removed from the kernel
  o PCI: add CONFIG_PCI_NAMES to the feature-removal-schedule.txt file
  o PCI: sync up with the latest pci.ids file from sf.net
  o USB Storage: remove unneeded unusual_devs.h entry
  o Linux 2.6.11.5
  o PCI Hotplug: enforce the rule that a hotplug slot needs a release
    function
  o USB: fix bug in visor driver with throttle/unthrottle causing
    oopses
  o USB: mark usb-serial interface GPL only
  o USB: add fossil watch ids to the visor driver
  o PCI: clean up the dynamic id logic a little bit
  o PCI: create PCI_DEBUG config option to make it easier for users to
    enable pci debugging
  o USB: mark functions static in the cp2101 driver
  o USB: Put the Kconfig and Makefile back in proper order for the
    serial drivers
  o USB: fix up a lot of sparse warnings and bugs in the pwc driver
  o PCI: revert dumb SGI patch for resource freeing

Greg Ungerer:
  o m68k-nommu: remove nowhere referenced file io_hw_swap.h
  o m68k-nommu: use vma list in nommu mmap support
  o m68k-nommu: change build process to use common head code
  o m68k-nommu: fix broken GET_MEM_SIZE macro in ColdFire head code
  o m68k-nommu: create common 68328 ROM based startup code
  o m68k-nommu: remove nowhere referenced file semp3.h
  o m68k-nommu: create common 68328 RAM based startup code
  o m68k-nommu: move PILOT platform startup code
  o m68k-nommu: remove vendor/board specific startup code
  o m68knommu: optimize trap handling asm code
  o m68knommu: add missing KM_ enums
  o m68knommu: fix spelling mistakes in mafcache.h
  o m68knommu: remove duplicate definition of THREAD_SIZE
  o m68knommu: 4k stack support
  o m68knommu: update MAINTAINERS entry
  o m68knommu: move LED variable definitions for 5272
  o m68knommu: generate asm-offsets for thread_info struct
  o m68knommu: move LED variable definitions for 5307
  o m68knommu: use generated asm-offsets in trap handlers
  o m68knommu: cleanup ColdFire specific trap handling asm code
  o m68knommu: remove unused variables in mcfserial.c

Guillermo Menguez Alvarez:
  o USB: Support for new ipod mini (and possibly others) + usb

Herbert Pötzl:
  o include cleanup in pgalloc.h

Herbert Xu:
  o [IPV4]: Send TCP reset through dst_output in ipt_REJECT
  o [IPV4]: Fix MTU check in ipmr_queue_xmit
  o [NETFILTER]: Use correct IPSEC MTU in TCPMSS
  o [IPV4]: Kill remaining unnecessary uses of dst_pmtu
  o [IPSEC]: Get ttl from child instead of path
  o [NET]: Kill unnecessary uses of dst_path_metric
  o [NET]: Kill dst_pmtu/dst_path_metric
  o [NET]: Make dst_allfrag use dst instead of dst->path
  o [CRYPTO]: Do scatterwalk_whichbuf inline
  o [CRYPTO]: Handle in_place flag in crypt()
  o [CRYPTO]: Split src/dst handling out from crypt()
  o [CRYPTO]: Eliminate most calls to scatterwalk_copychunks from
    crypt()
  o [CRYPTO]: Optimise kmap calls in crypt()
  o [CRYPTO]: Fix walk->data handling
  o [CRYPTO]: Kill obsolete iv check in cbc_process()
  o [CRYPTO]: Split cbc_process into encrypt/decrypt
  o [CRYPTO]: Remap when walk_out crosses page in crypt()
  o [IPV4]: Check mtu instead of frag_list in ip_push_pending_frames()
  o [IPV4]: Clear DF bit in ip_fragment fast path
  o Potential DOS in load_elf_library
  o [PKT_SCHED]: Memory leak in ipt.c
  o [NETLINK]: Fix sk_rmem_alloc assertion failure
  o [NETLINK]: More complete fix for race
  o [IPSEC]: Move xfrm_flush_bundles into xfrm_state GC
  o [XFRM]: Simplify xfrm_policy_kill()
  o [IPSEC]: Make IPCOMP more resilient
  o [CRYPTO]: Update MAINTAINERS entry mailing list

Hideaki Yoshifuji:
  o [IPV6]: Remove redundant NULL checks before kfree
  o [NET]: Save space for sk_alloc_slab() failure message
  o [IPV4]: Size ip_mp_alg_table[] correctly
  o [IPV6]: Fix address/interface handling according to the scoping
    architecture
  o [AF_UNIX]: unix_mkname comment

Hirofumi Ogawa:
  o FAT: set MS_NOATIME to msdos
  o FAT: Fix msdos ->[ac]{date,time}
  o read_kmem() fixes

Hirokazu Takata:
  o m32r: Update MMU-less support #1
  o m32r: Update MMU-less support #2
  o m32r: Update MMU-less support #3
  o m32r: Fix M32102 I-cache invalidation
  o m32r_sio driver update
  o [SERIAL] m32r_sio driver update
  o m32r: Fix spinlock.h for CONFIG_DEBUG_SPINLOCK
  o m32r: build fix for CONFIG_DISCONTIGMEM

Hong Liu:
  o fix mmap() return value to conform to POSIX

Hugh Dickins:
  o tasklist left locked

Ian Abbott:
  o ftdi_sio: add array to map chip type to a string
  o ftdi_sio: Support sysfs attributes for more chip
  o ftdi_sio: fix sysfs attribute permissions

Ian Campbell:
  o [ARM PATCH] 2574/1: PXA2xx: Save CCLKCFG over sleep

Ingo Molnar:
  o [XFRM]: xfrm_policy destructor fix
  o break_lock fix

Jack Steiner:
  o [IA64-SGI] [PATCH 1/2] - New chipset support for SN platform
  o [IA64-SGI] [PATCH 2/2] - New chipset support for SN platform

Jakub Jelínek:
  o Futex: make futex_wait() atomic again

Jamal Hadi Salim:
  o [PKT_SCHED]: Use proper attritbute for action stats

James Bottomley:
  o fix breakage in the SCSI generic tag code
  o Q720: fix compile warning
  o ncr53c8xx: Fix small problem with initial negotiation
  o SCSI: Re-export code incorrectly made static
  o 53c700: Alter interrupt assignment
  o 3ware driver update
  o Fix SCSI internal requests hang
  o [NET]: Missing proto_list_lock initialization
  o x86: fix subarch breakage in intel_cacheinfo.c

James Chapman:
  o i2c: new driver for ds1337 RTC
  o i2c: add adt7461 chip support to lm90 driver

Jan Kiszka:
  o [NET]: NULL pointer bug in netpoll.c

Jaroslav Kysela:
  o [ALSA] Fix ALC655/658/850 SPDIF playback route
  o [ALSA] Add DXS support for MSI K8T Neo2-FI
  o [ALSA] Fix voice allocation corruption
  o [ALSA] emu10k1 - give the subdevices descriptive names
  o [ALSA] emu10k1 - Silence the 'BUG (or not enough voices)' message
  o [ALSA] emu10k1 - copyright additions/fixes
  o [ALSA] emu10k1 - add support for p16v chip (24-bit playback)
  o [ALSA] isa/Kconfig - added SND_AD1848_LIB and SND_CS4231_LIB
    tristates
  o [ALSA] Add proper spin/irq locks to suspend
  o [ALSA] Fix suspend/resume with ATIIXP
  o [ALSA] Fix Oops with timer notifying
  o [ALSA] Fix resume of es1968
  o [ALSA] Wake up polls and signals at timer notification
  o [ALSA] ak4114 (Juli@) - increased delay between statistics update &
    rate check
  o [ALSA] Use full-digital model as default for CMI9880
  o [ALSA] Add new C-Media 9880 codec ID
  o [ALSA] documentation - clarify information about atomic callbacks
  o [ALSA] remove superfluous spin_lock_irqsave calls
  o [ALSA] fix P16V breakage for non Audigy2 cards
  o [ALSA] fix misc oopses
  o [ALSA] Fix typos
  o [ALSA] rme32 - remove superfluous spin_lock_irqsave call
  o [ALSA] fix bug with pci hotplug mode
  o [ALSA] Fix SPDIF output on CMI9880
  o [ALSA] Replace '/' with commas in ac97 codec names
  o [ALSA] rawmidi - fix locking in drop_output and drain_input
  o [ALSA] rawmidi - move output trigger into a tasklet
  o [ALSA] remove unneeded interrupt locks in rawmidi drivers
  o [ALSA] add HPET support
  o [ALSA] fix bug with pci hotplug mode
  o [ALSA] use amp capabilities from afg if amp override not set
  o [ALSA] emu10k1 external tram size
  o [ALSA] Fix 96000 SPDIF out from Audigy 2 P16V
  o [ALSA] Increase buffer sizes for the CA0106 driver
  o [ALSA] Remove unnecessary ac97 init code
  o [ALSA] Reduce stack usage
  o [ALSA] Use vprintk()
  o [ALSA] Fix Oops with joystick support
  o [ALSA] Fix Oops with joystick support
  o [ALSA] Replace with macros for gameport initialization
  o [ALSA] Add framework for better audigy sound card capabilities
    selection
  o [ALSA] Fixes AC3 output on Audigy2 sound cards
  o [ALSA] correct comment for setting widget output
  o [ALSA] Add AD1986A support
  o [ALSA] Add Mono volume controls for ALC260
  o [ALSA] Clean up the chip detection
  o [ALSA] Fix Oops in snd_emu10k1_add_controls
  o [ALSA] Fix EFX voice allocation/preparation
  o [ALSA] Add AC97_SCAP_NO_SPDIF flag
  o [ALSA] cs4281 - fix typos in the case gameport is disabled
  o [ALSA] usb - change timeout of USB control/bulk msg functions to
    msecs
  o [ALSA] seq - fix local variable initialization
  o ALSA CVS update ALSA Version release: 1.0.9rc2
  o ALSA 1.0.9rc2

Jason Davis:
  o ES7000 Legacy Mappings Update

Jason Gaston:
  o pci_ids.h correction for Intel ICH7M
  o [ide] pci_ids.h correction for Intel ICH7R
  o SATA AHCI correction Intel ICH7R

Jay Vosburgh:
  o [BONDING]: Do not drop non-VLAN traffic

Jean Delvare:
  o PCI: Quirk for Asus M5N
  o I2C: New lm92 chip driver
  o I2C: Cleanup adm1021 unused defines
  o I2C: Fix adm1021 alarms mask
  o I2C: Kill unused struct members in w83627hf driver
  o I2C: Make master_xfer debug messages more useful
  o I2C: Skip broken detection step in it87
  o I2C: Fix some i2c algorithm initialization
  o I2C: Kill outdated defines in i2c.h
  o I2C: Avoid repeated resets of i2c-viapro
  o I2C: Recognize new revision of the ADT7463 chip
  o I2C: Fix Vaio EEPROM detection
  o I2C: Delete useless instruction in it87
  o I2C: Fix race condition in it87 driver
  o I2C: i2c-s3c2410 functionality and fixes
  o i2c: add adt7461 chip support to lm90 driver's Kconfig entry
  o I2C: Fix broken force parameter handling
  o I2C: Fix indentation of lm87 driver
  o I2C: pcf8574 doesn't need a lock
  o I2C: Move functionality handling from i2c-core to i2c.h
  o I2C: Fix a common race condition in hardware monitoring

Jean Tourrilhes:
  o [IRDA]: DEBUG macro fixes

Jeff Garzik:
  o alpha build fixes
  o [libata sata_sil] Don't presume PCI cache-line-size reg is > 0

Jeff Moyer:
  o unused 'size' assignment in filemap_nopage

Jens Axboe:
  o queue <-> sdev reference counting problem

Jesper Juhl:
  o mips: convert a remaining verify_area to access_ok
  o [NET]: Remove redundant NULL pointer check before kfree in socket.c
  o rename FPU_*verify_area to FPU_*access_ok
  o remove redundant NULL checks before kfree() in drivers/video/
  o kfree() NULL pointer cleanups - no need to check - fs/ext3/

Jody McIntyre:
  o Description: Use wait_event_interruptible() instead of the
    deprecated interruptible_sleep_on(). The first change is simply to
    clean up the code a little to make it clearer. The second actually
    does a replacement, mimicking exactly the first. I removed the #if
    1/#else/endif logic, as it duplicated the same code. Patch is
    compile-tested.
  o  Change the initialization message for eth1394 to KERN_INFO,
    requested by Steffen Zieger <lkml@steffenspage.de>
  o  apply patch from Nishanth Aravamudan <nacc@us.ibm.com> to use 
    sleep_interruptible for clarity and prevent early return on
    wait_queue events.
  o  sbp2: add precautionary log notice to new exit branch from last
    patch
  o This should fix u32 vs. pm_message_t confusion in firewire. No code
    changes. Please apply, Pavel
  o Move hpsb_unregister_protocol, which fixes a hang on rmmod
    experienced by Parag Warudkar <kernel-stuff@comcast.net>
  o ohci1394.c allocates the legacy IR DMA Context on demand. This
    happens in IRQ path resulting in call to dma_pool_create from
    within interrupt. Same is true for de-allocation of the IR DMA
    Context - it happens again in IRQ path resulting in call to
    dma_pool_destroy.
  o  Description: Use wait_event_interruptible() instead of the
    deprecated interruptible_sleep_on(). Add a helper function to make
    the condition for wait_event_interruptible() sane and lock-safe.
    Patch is compile-tested.
  o  Fix a partial conversion to unlocked_ioctl().
  o Fix end of line to match linux1394.org SVN and be <80 chars
  o Fix comment to match reality
  o convert from pci_module_init to pci_register_driver

Johannes Stezenbach:
  o dvb: clarify firmware upload messages
  o dvb: dibcom: frontend fixes
  o dvb: dibusb: misc. fixes
  o dvb: skystar2: remove duplicate pci_release_region()
  o dvb: mt352: Pinnacle 300i comments
  o dvb: support Activy Budget card
  o dvb: skystar2: update email address
  o dvb: ves1x93: invert_pwm fix
  o dvb: dibusb readme update
  o dvb: dibusb: support Hauppauge WinTV NOVA-T USB2
  o dvb: nxt2002: QAM64/256 support
  o dvb: get_dvb_firmware: new unshield version
  o dvb: dib3000: corrected device naming
  o dvb: dibusb: debug changes
  o dvb: dibusb: increased the number of urbs for usb1.1 devices
  o dvb: ttusb_dec: use alternative interface to save bandwidth
  o dvb: l64781: email address fix
  o dvb: skystar2: fix MAC address reading
  o dvb: support KWorld/ADSTech Instant DVB-T USB2.0
  o dvb: cleanups, make stuff static
  o dvb: refactor sw pid filter to drop redundant code
  o dvb: nxt2002: fix max frequency
  o dvb: ttusb-budget: s/usb_unlink_urb/usb_kill_urb/
  o dvb: av7110: fix Oops when av7110_ir_init() failed
  o dvb: saa7146: static initialization
  o dvb: av7110: error handling during attach
  o dvb: corrected links to firmware files
  o dvb: support pcHDTV HD2000
  o dvb: dibusb: support nova-t usb ir
  o dvb: OREN or51211, or51132_qam and or51132_vsb firmware download
    info
  o dvb: ttusb_dec: IR support
  o dvb: dibusb: pll fix
  o dvb: tda10021: fix continuity errors
  o dvb: saa7146: remove duplicate setgpio
  o dvb: fix CAMs on Typhoon DVB-S
  o dvb: frontends: kfree() cleanup
  o dvb: clear up confusion between ids and adapters
  o dvb: dibusb: remove useless ifdef
  o dvb: support for Technotrend PCI DVB-T
  o dvb: dibusb: HanfTek UMT-010 fixes
  o dvb: vfree() checking cleanups
  o dvb: convert from pci_module_init to pci_register_driver
  o dvb: dibusb: support dtt200u (Yakumo/Typhoon/Hama) USB2.0 device
  o dvb: sparse warnings on one-bit bitfields
  o dvb: support Nova-S rev 2.2
  o dvb: ttusb_dec: cleanup
  o dvb: gcc 2.95 compile fixes
  o dvb: mt352: cleanups

John Rose:
  o [PATCH] remove redundant devices list

John W. Linville:
  o e1000: avoid sleeping in watchdog timer context
  o e1000: flush work queues on remove
  o b44: allocate tx bounce bufs as needed
  o bonding: avoid tx balance for IGMP (alb/tlb mode)
  o e1000: add MODULE_VERSION

Jon Smirl:
  o sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  o PCI: handle multiple video cards on the same bus
  o handle multiple video cards on the same bus

Jonathan Corbet:
  o doc: where to find LDD3

Jun Komuro:
  o net/Kconfig: remove unsupported network adapter names

Jörn Engel:
  o checkstack: fix sort misbehavior for long function names

Kenneth W. Chen:
  o x86_64: hugetlb fix

Kimball Murray:
  o PCI: Patch for Serverworks chips in hotplug environment

Krzysztof Halasa:
  o Fix kernel panic on receive with WAN Hitachi SCA HD6457x

Kumar Gala:
  o ppc32: Fix FEC ethernet intialization on MPC8540 ADS board
  o ppc32: Move 83xx & 85xx device and system description files
  o ppc32: Fix CONFIG_SERIAL_TEXT_DEBUG support on 83xx
  o ppc32: typo fix in load/store string emulation
  o ppc32: Report chipset version in common /proc/cpuinfo handling
  o ppc32: cleanup of Book-E exception handling
  o ppc32: CPM2 PIC cleanup
  o ppc32: CPM2 PIC cleanup irq_to_siubit array
  o ppc32: Fix MPC8555 & MPC8555E device lists (updated)
  o ppc32: rename head_e500.S to head_fsl_booke.S

Lee Revell:
  o make Documentation/oops-tracing.txt relevant to 2.6

Len Brown:
  o [ACPI] Add ACPI-based memory hot plug driver
  o [ACPI] ACPICA 20050228 from Bob Moore
  o [ACPI] CONFIG_ACPI_NUMA build fix
  o [ACPI] fix kobject_hotplug() use by ACPI processor and container
    drivers
  o [ACPI] fix ACPI container driver's notify handler
  o [ACPI] fix sysfs "eject" file
  o [ACPI] ACPICA 20050303 from Bob Moore for AE_AML_BUFFER_LIMIT issue
  o [ACPI] fix [ACPI_MTX_Hardware] AE_TIME warning which resulted from
    enabling the wake-on-RTC feature
  o [ACPI] PNPACPI should ignore vendor-defined resources
  o [ACPI] Make PCI device -> interrupt link associations explicit,
  o [ACPI] Allow 4 digits when printing PCI segments to be consistent
    with the rest of the kernel.
  o [ACPI] fix acpi_numa_init() build warning
  o [ACPI] limit scope of various globals to static
  o [ACPI] ACPICA 20050309 from Bob Moore
  o [ACPI] build fix in acpi_pci_irq_disable()

Lennert Buytenhek:
  o [ARM PATCH] 2571/1: minor time-keeping fixes for ixp2000
  o [ARM PATCH] 2572/1: remove ifdefs from enp2611.c
  o [ARM PATCH] 2573/1: simplify align[bw]() in ixp2000's io.h and
    update comments
  o [ARM PATCH] 2575/1: pass -mbig-endian/-mlittle-endian to
    invocations of cpp
  o [ARM PATCH] 2507/1: work around ixp2400 erratum #66
  o [ARM PATCH] 2577/1: more ixp2000 comment work (typo fixes and
    annotations)
  o [ARM PATCH] 2580/1: remove nonsensical comment from
    arch-ixp2000/io.h
  o [ARM PATCH] 2581/1: two more ixp2000 typo fixes
  o [ARM PATCH] 2582/1: correct thread interrupt comments in
    arch-ixp2000/irqs.h
  o [ARM PATCH] 2583/1: add several registers to
    arch-ixp2000/ixp2000-regs.h

Li Shaohua:
  o [ACPI] flush TLB in init_low_mappings()
  o Fix oops when inserting ipmi_si module

Li Yang:
  o ppc32: Update 8260_io/fcc_enet.c to function again

Linus Torvalds:
  o isofs: Handle corupted rock-ridge info slightly better
  o isofs: more "corrupted iso image" error cases
  o Undo VIA AGP TLB flush low-bits-zero patch
  o Add '__nocast' sparse annotation to allow people to mark places
    where implicit casts are not appropriate.
  o Mark "gfp" masks as "unsigned int" and use __nocast to find
    violations
  o Linux 2.6.12-rc2

Lucas Correia Villa Real:
  o [ARM PATCH] 2549/2: S3C2400 - adds EDO DRAM definitions to
    regs-mem.h
  o [ARM PATCH] 2556/1: S3C2400 - defines PHYS_OFFSET at
    include/asm-arm/arch-s3c2410/memory.h
  o [ARM PATCH] 2630/1: Fixes definition of GPB10 on S3C2410

Magnus Damm:
  o module parameter fixes

Manfred Spraul:
  o slab.[ch]: kmalloc() cleanups
  o slab: 64-bit fix
  o fix put_user for 80386

Marcel Holtmann:
  o [Bluetooth] Support HCI Extensions in BCSP driver
  o [Bluetooth] Fix session reference counting for RFCOMM
  o [Bluetooth] Kill bt_sock_alloc() and its usage
  o [Bluetooth] Remove now unneeded references to sk_protinfo
  o [Bluetooth] Make another variable static
  o [Bluetooth] Fix race condition in virtual HCI driver
  o [Bluetooth] Fix signedness problem at socket creation
  o Fix signedness problem at socket creation

Marek Marczykowski:
  o neofb: mmio fixes

Mark A. Greer:
  o ppc32: Patch for changed dev->bus_id format
  o ppc32: update Radstone ppc7d platform
  o ppc32: Clean up mv64x60 bootwrapper support
  o ppc32: Fix mv64x60 internal SRAM size
  o ppc32: Fix Sandpoint Soft Reboot
  o I2C: Fix breakage in m41t00 i2c rtc driver
  o i2c: i2c-mv64xxx - set adapter owner and class fields

Mark Haverkamp:
  o aacraid: endian cleanup

Martin Hicks:
  o vmscan: move code to isolate LRU pages into separate function

Martin Schwidefsky:
  o s390: system calls
  o s390: define atomic_sub_return
  o s390: add run_posix_cpu_timers to account_user_vtime
  o s390: missing timer ticks
  o s390: oprofile support
  o s390: kernel faults
  o posix-cpu-timers and cputime_t divisons

Martin Waitz:
  o docbook: fix escaping of kernel-doc

Mathieu Lafon:
  o Suspected information leak (mem pages) in ext2

Matt Mackall:
  o [NETPOLL]: Shorten carrier detect timeout
  o [NETPOLL]: Filter inlines
  o [NETPOLL]: Add netpoll pointer to net_device
  o [NETPOLL]: Fix ->poll() locking
  o [NETPOLL]: Add optional dropping and queueing support
  o [NETPOLL]: Handle xmit_lock recursion similarly
  o [NETPOLL]: Avoid kfree_skb() on packets with destructor
  o [NETPOLL]: Carrier clarification
  o [NETPOLL]: Fix racy dev->flags usage

Matthew Dharm:
  o USB Storage: Header reorganization
  o USB Storage: remove unneeded NULL tests
  o USB Storage: change how unusual_devs.h flags are defined
  o USB Storage: make usb-storage structures refcounted by SCSI
  o USB Storage: exit control thread immediately upon disconnect
  o USB Storage: allow disconnect to complete faster
  o USB Storage: combine waitqueues
  o USB Storage: remove RW_DETECT from being a config option

Matthew Wilcox:
  o [IA64] pci.c: PCI root busses need resources
  o PCI: 80 column lines
  o PCI busses are structs, not integers
  o Misc Lasi 700 fixes
  o Zalon updates
  o ncr53c8xx update
  o Fix small bug in scsi_transport_spi
  o New console flag: CON_BOOT
  o [NET]: Remove i_sock

Max Alekseyev:
  o fs/hpfs/*: fix HPFS support under 64-bit kernel

Maximilian Attems:
  o w6692: eliminate bad section references
  o teles3: eliminate bad section references
  o elsa eliminate bad section references
  o hfc_sx: eliminate bad section references
  o sedlbauer: eliminate bad section references

Michael Chan:
  o [TG3]: Add 5705_plus flag
  o [TG3]: Flush status block in tg3_interrupt()
  o [TG3]: Add unstable PLL workaround for 5750
  o [TG3]: Fix jumbo frames phy settings
  o [TG3]: Fix ethtool set functions
  o [TG3]: Add Broadcom copyright

Michael Ellerman:
  o ppc64: Make numa=off command line argument work again
  o ppc64: numa: Remove redundant and broken overlap check
  o ppc64: Add mem=X boot command line option

Michael Holzheu:
  o s390: s390dbf permissions

Michael Hunold:
  o Fix Oops in MXB driver (v4l2 subsystem)

Mika Kukkonen:
  o Fix compile warning in drivers/pnp/resource.c with !CONFIG_PCI

Mikael Pettersson:
  o drivers/net/arcnet/arcnet.c gcc4 fixes
  o drivers/net/depca.c gcc4 fix
  o ppc64: fix gcc4 compile error in paca.h
  o ppc64: fix compile error in prom.c
  o x86_64: fix vsyscall.c syntax error
  o drivers/char/isicom.c gcc4 fix

Mike Christie:
  o rm unused scan delay var
  o fix fc class work queue usage

Mike Kravetz:
  o ppc64: NUMA memory fixup (another try)

Miklos Szeredi:
  o Can't unmount bad inode

Mingming Cao:
  o ext3: dynamic allocation of block reservation info
  o ext3: reservation info cleanup: remove rsv_seqlock
  o ext3: move goal logical block into block allocation info structure

Nathan Scott:
  o [XFS] remove non-helpful inode shakers
  o [XFS] Steve noticed we were duplicating some work the block layer
    can do for us; switch to SYNC_READ/WRITE for some metadata buffers.
  o [XFS] reinstate a missed xfs_iget check on is_bad_inode
  o [XFS] reinstate missed copyright date updates
  o [XFS] Further improvements to the default XFS inode hash table
    sizing algorithms, resolving regressions reported with the previous
    change.
  o [XFS] Provide a mechanism for reporting ihashsize defaults via
    /proc/mounts.
  o [XFS] Fix sync mount option to also do metadata updates
    synchronously
  o [XFS] Make trivial extension to sync flag to implement dirsync,
    instead of silently ignoring it.

Nathan T. Lynch:
  o ppc64: rtasd shouldn't hold cpucontrol while sleeping

Neil Brown:
  o nlm: fix f_count leak
  o svcrpc: auth_domain documentation
  o nfsd4: fix share conflict tests
  o nfsd4: remove unneeded stateowner arguments
  o nfsd4: fix use after put() in cb_recall
  o nfsd4: allow read on open for write
  o nfsd4: factor out common open_truncate code
  o nfsd4: fix failure to truncate on some opens
  o nfsd4_remove_unused_acl_function
  o nfsd4: don't set WRITE_OWNER in either allow or deny bits
  o nfsd4: acl don't set named attrs
  o nfsd4: acl error fix
  o nfsd4: rename release_delegation
  o nfsd4: remove trailing whitespace from nfs4proc.c
  o nfsd4: fix open returns for other claim types
  o nfsd4: fix indentation in nfsd4_open

Nick Piggin:
  o sched: fix schedstats warning

Nicolas Pitre:
  o [ARM PATCH] 2552/1: ptrace support for accessing iWMMXt regs
  o [ARM PATCH] 2552/2: woops
  o [ARM PATCH] 2578/1: unsigned compare in processor and machine list
    walking
  o [ARM PATCH] 2579/1: make early boot failure more verbose
  o [ARM PATCH] 2634/1: prevent the lack of any CPU and/or machine
    record at link time

Nigel Cunningham:
  o swsusp: Add missing refrigerator calls

Nishanth Aravamudan:
  o usb/pwc-ctrl: change parameters of usb_control_msg() to msecs
  o usb/kl5kusb105: change parameters of usb_control_msg() to msecs
  o sound/usbaudio: change parameters of snd_usb_ctl_msg() to msecs
  o sound/usbmidi: change parameters of usb_bulk_msg() to msecs

Olaf Hering:
  o ppc64: missing newline/carrige return in zImage
  o USB: another broken usb floppy

Olaf Kirch:
  o USB: fix uhci irq 10: nobody cared! error

Oleg Nesterov:
  o x86: fix ESP corruption CPU bug (take 2)

Oliver Neukum:
  o USB: removal of obsolete error code from kaweth

Ollie Wild:
  o [AF_KEY]: Fix error handling in pfkey_xfrm_state2msg()

Olof Johansson:
  o PPC64: Fix LPAR IOMMU setup code for p630

Paolo 'Blaisorblade' Giarrusso:
  o kconfig: Fix kconfig docs typo: integer -> int
  o x86-64: kconfig typo
  o x86_64: remove old decl (trivial)
  o x86-64: forgot asmlinkage on sys_mmap
  o uml: cope with uml_net security fix
  o uml: fix compile
  o uml: cpu_relax fix
  o uml: extend cmd line limits
  o uml: disable more hardware kconfig opt and rename USERMODE to UML
  o uml: factor out common code in user-obj handling
  o uml - kbuild: link cmd
  o uml: add kconfig debug deps
  o uml: real fix for __gcov_init symbols
  o uml: fix "cond. expr. as lvalues" warning
  o uml: fix sigio spinlock
  o uml: gprof depends on !TT
  o uml: quick fix syscall table
  o uml: fixes a build failure with CONFIG_MODE_SKAS disabled
  o uml: fix hostfs special perm handling
  o uml: correct error message

Patrick McHardy:
  o Fix crash while reading /proc/net/route
  o [IPSEC]: Check SPI in xfrm_state_find()
  o [IPSEC]: Check if SPI exists before creating acquire state

Patrick van de Lageweg:
  o generic-serial cli() conversion
  o Specialix/IO8 cli() conversion
  o SX cli() conversion

Paul Jackson:
  o cpusets: mems generation deadlock fix
  o cpusets: alloc GFP_WAIT sleep fix
  o cpusets: special-case GFP_ATOMIC allocs
  o cpusets GFP_ATOMIC fix: tonedown panic comment

Paul Mackerras:
  o ppc64: kill might_sleep() warnings in __copy_*_user_inatomic
  o ppc64: make RTAS code usable on non-pSeries machines
  o ppc64: delete unused file no_initrd.c
  o ppc64: delete unused file iSeries_fixup.h
  o ppc64: use pSeries reconfig notifier for cpu DLPAR
  o ppc64: make cpu hotplug play well with maxcpus and smt-enabled
  o ppc64: remove unnecessary ISA ioports
  o ppc64: fix error cases in nvram partition scan
  o ppc64: allow xmon=on,off,early
  o ppc64: preliminary changes to OF fixup functions
  o ppc64: make OF node fixup code usable at runtime
  o ppc64: introduce pSeries_reconfig.[ch]
  o ppc64: prom.c: use pSeries reconfig notifier
  o ppc64: pci_dn.c: use pSeries reconfig notifier
  o ppc64: pSeries_iommu.c: use pSeries reconfig notifier
  o ppc32: use correct sysrq function
  o ppc32: eliminate gcc warning in prom.c
  o ppc32: eliminate gcc warning in xmon.c
  o ppc32: add syscall6 definition
  o ppc32: clean up arch/ppc/syslib/prom_init.c
  o ppc64: Export re{serv,leas}e_pmc_hardware() for oprofile

Pavel Machek:
  o [ACPI] enhance fan output in error path
  o Fix suspend/resume on via-velocity
  o suspend-to-ram: update video.txt with more systems
  o pm: remove obsolete pm_* from vt.c
  o swsusp: small updates
  o swsusp: kill swsusp_restore
  o Fix pm_message_t in generic code
  o Fix u32 vs. pm_message_t in USB
  o more pm_message_t fixes
  o Fix u32 vs. pm_message_t confusion in OSS
  o Fix u32 vs. pm_message_t confusion in PCMCIA
  o Fix u32 vs. pm_message_t confusion in framebuffers
  o Fix u32 vs. pm_message_t confusion in MMC
  o Fix u32 vs. pm_message_t confusion in serials
  o Fix u32 vs. pm_message_t in macintosh
  o Fix u32 vs. pm_message_t confusion in AGP
  o Remaining u32 vs. pm_message_t fixes
  o [ARM] Fix u32 vs. pm_message_t in arm

Per Christian Henden:
  o ppc32: dmasound compilation fix

Pete Zaitcev:
  o USB: Patch for ub to fix oops after disconnect
  o USB: ub static patch
  o USB: Fix baud selection in mct_u232
  o USB: usbmon - document and kill pipe from API
  o USB: Add myself to MAINTAINERS
  o USB: fix for ub for sleeping function called from invalid context
    at kernel/workqueue.c:264

Peter Osterlund:
  o Use __init and __exit in pktcdvd
  o DVD-RAM support for pktcdvd

Peter Tiedemann:
  o s390: ctc buffer size
  o s390: qeth 1920 device suppor

Petr Vandrovec:
  o Fix matroxfb on big-endian hardware

Phil Dibowitz:
  o USB unusual_devs: Add another Tekom entry
  o USB unusual_devs: add another datafab device
  o USB Storage: Remove dup in unusual_devs

Prarit Bhargava:
  o PCI Hotplug: add documentation about release pointer

Prasanna Meda:
  o pipe: save one pipe page

Prasanna S. Panchamukhi:
  o kprobes: incorrect spin_unlock_irqrestore() call in
    register_kprobe()
  o Kprobes: Allow/deny probes on int3/breakpoint instruction?

Rafael Ávila de Espíndola:
  o I2C: lsb in emc6d102 and adm1027

Ralf Bächle:
  o NetROM locking
  o [NETROM]: Get rid of sk_protinfo use
  o [ROSE]: Get rid of sk_protinfo use

Randolph Chung:
  o Missing set_fs() calls around kernel syscall

Randy Dunlap:
  o sisusb: fix arg. types
  o pwc: fix printk arg types
  o i386: add kstack=N option (from x86_64)
  o kernel-parameters: IA-32/X86-64 cleanups
  o mtrr: uaccess range checking fix
  o cciss: range chcking fix
  o io_remap_pfn_range: add for all arch-es
  o io_remap_pfn_range: convert sparc callers
  o io_remap_pfn_range: fix some callers for XEN
  o io_remap_pfn_range: convert last callers
  o scsi_sysfs: use NULL instead of 0
  o cpuset: make function decl. ANSI
  o nvidiafb: fix section references

Ravinandan Arakali:
  o S2io: Statistics fix
  o S2io: h/w initialization fixes
  o S2io: Changed copyright and added support for Xframe II

Richard Henderson:
  o alpha spinlock.h update
  o small warning fix for gcc4
  o alpha: elimitate two warnings from gcc4

Richard Purdie:
  o [ARM PATCH] 2637/1: Combine code for Sharp SL series parameter area

Rob Landley:
  o uml: Fix the console stuttering

Robert Love:
  o iput() can sleep

Roland Dreier:
  o PCI: Add PCI device ID for new Mellanox HCA
  o InfiniBand: remove unsafe use of in_atomic()

Roland McGrath:
  o x86-64 kprobes: handle %RIP-relative addressing mode

Roland Scheidegger:
  o drm: radeon driver update 1.16

Rolf Eike Beer:
  o PCI Hotplug: remove code duplication in
    drivers/pci/hotplug/ibmphp_pci.c
  o PCI Hotplug: only call ibmphp_remove_resource() if argument is not
    NULL
  o PCI: shrink drivers/pci/proc.c::pci_seq_start()
  o PCI: remove pci_find_device usage from pci sysfs code
  o Kill stupid warning when compiling riocmd.c

Roman Kagan:
  o drivers/usb/core/usb.c: add MODALIAS env var to hotplug

Roman Zippel:
  o hfs: free page buffers in releasepage
  o hfs: fix umask behaviour
  o hfs: more bnode error checks
  o hfs: fix sign problem in hfs_ext_keycmp
  o hfs: use parse library for mount options
  o hfs: add nls support
  o hfs: unicode decompose support
  o kconfig: complete cpufreq Kconfig cleanup

Ronald Bultje:
  o bt819 array indexing fix
  o zr36050 typo fix

Rudolf Marek:
  o I2C: busses documentation update 1 of 2
  o I2C: busses documentation update 2 of 2

Russ Anderson:
  o [IA64-SGI] Remove unused cpu_bte_if from pda_s

Russell King:
  o [ARM] Use select for some hidden ARM configuration symbols
  o [ARM] Use select for DMABOUNCE, SA1111, SHARP_LOCOMO and
    SHARP_SCOOP
  o [ARM] Move "common" Kconfig symbols to arch/arm/common/Kconfig
  o [ARM] Group bus support options together under own menu
  o [ARM] Group kernel features together under their own menu
  o [ARM] Group device drivers together under their own menu
  o [ARM] Group more options into their own separate menus
  o [ARM] We're always CPU_32, so remove dependencies on this symbol
  o [ARM] Simplify LEDs dependencies
  o [ARM] Remove depends on/default y from FIQ configuration
  o [ARM] Remove arch/arm/configs/a5k_defconfig
  o [ARM] Update RiscPC default configuration
  o [ARM] Update Assabet and related Neponset default configuration
  o [MMC] SD support : protocol
  o [ARM] Add vserver syscall allocation
  o [SERIAL] Allow drivers to use uart_match_port
  o [SERIAL] Set port.dev to PCMCIA device
  o [SERIAL] au1x00_uart: remove duplicate serial registration
    functions
  o [SERIAL] Add UART_CAP_UUE
  o [ARM] mach-types update
  o [ARM] Move alignment_trap/zero_fp macros into usr_entry macro
  o [ARM] Don't call force_sig_info() for kernel-mode exceptions
  o [SERIAL] Remove SERIAL_INLINE, and move debug macro to 8250_pci.c
  o [ARM] Fix ARM TLB shootdown code
  o Fix PCMCIA resume with card inserted
  o pcmcia: clean up suspend
  o [SERIAL] Remove serial8250_late_console_init
  o paport oops fix

Rusty Russell:
  o [NETFILTER]: Restore ports module parameter for ip_nat_{ftp,irq}

Sascha Hauer:
  o [ARM PATCH] 2553/1: imx __REG2 fix
  o [ARM PATCH] 2555/1: i.MX DMA fix
  o [ARM PATCH] 2635/1: i.MX serial hardware handshaking support

Seth Rohit:
  o arch hook for notifying changes in PTE protections bits

Solar Designer:
  o Enable gcc warnings for vsprintf/vsnprintf with "format" attribute

Stas Sergeev:
  o au1x00_uart deadlock fix

Stefan Nickl:
  o ppc32: MPC8555 CPM2 size/pointers for FCCs aka "All-ones problem"

Stefan Weinhuber:
  o s390: dasd preferred path support

Steffen Thoss:
  o s390: qeth blkt tuning

Stephen C. Tweedie:
  o ext2/3 file limits to avoid overflowing i_blocks
  o ext3/jbd race: releasing in-use journal_heads
  o ext3: fix journal_unmap_buffer race

Stephen D. Smalley:
  o SELinux: make code static and remove unused code
  o SELinux: allow mounting of filesystems with invalid root inode
    context
  o SELinux: audit unrecognized netlink messages
  o SELinux: add name_connect permission check
  o [SELINUX]: Fix for removal of i_sock

Stephen Hemminger:
  o Fix check for underflow
  o [TCP]: BIC not binary searching correctly
  o [PKT_SCHED]: netem: Account for packets in delayed queue in qlen

Stephen Rothwell:
  o ppc64 iSeries: cleanup viopath
  o ppc64 iSeries: cleanup iSeries_setup
  o consolidate asm/ipc.h

Steve French:
  o [CIFS] whitespace cleanup
  o [CIFS] handle passwords with multiple commas in them
  o [CIFS] remove sparse warnings
  o [CIFS] whitespace cleanups and source formatting improvements
  o [CIFS] remove redundant null pointer checks before kfrees
  o [CIFS] code cleanup, rearranging of large function
  o [CIFS] streamlining cifs open with various helper functions
  o [CIFS] add new retry on failure to legacy servers such as NT4 of
    delete of readonly files
  o [CIFS] Fix NT4 attribute setting
  o [CIFS] whitespace/formatting cleanup
  o [CIFS] clean up source code formatting
  o [CIFS] Display pool sizes in cifs stats
  o [CIFS] Check if cifs demultiplex thread valid (not exited, or
    exiting) before we wake it on unmount (otherwise can cause oops in
    send_sig)
  o [CIFS] add generic readv/writev and aio support
  o [CIFS] cleanup unnecessary casts, and redundant null pointer checks
  o [CIFS] various code formatting cleanup
  o [CIFS] Return inode numbers (from server) more consistently on
    lookup and readdir to both types of servers (whether they support
    Unix extensions or not) when serverino mount parm specified.

Steven HARDY:
  o pcnet32: 79C975 fiber fix

Sven Henkel:
  o [NETPOLL]: Align UDP packets to NET_IP_ALIGN
  o [TUN]: Align only ethernet packets to NET_IP_ALIGN

Sylvain Munaut:
  o ppc32: Add PCI bus support for Freescale MPC52xx
  o ppc32: sparse clean ups for the Freescale MPC52xx related code
  o ppc32: Remove unnecessary test in MPC52xx reset code
  o ppc32: Remove the OCP system from the Freescale MPC52xx support
  o ppc32: Change constants style in Freescale MPC52xx related code
  o ppc32: Use platform bus / ppc_sys model for Freescale MPC52xx
  o serial: Update mpc52xx_uart.c to use platform bus
  o ppc32: Adds necessary cpu init to use USB on LITE5200 Platform

Tejun Heo:
  o [ide] hdio.txt update

Thibaut Varene:
  o s1d13xxxfb: Add support for Epson S1D13806 FB

Thomas Graf:
  o Cset exclude: hadi@cyberus.ca|ChangeSet|20050325173452|50562
  o [NET]: Make primary TLV type optional
  o [PKT_SCHED]: Fix action statistics dumping in compatibility mode
  o Cset exclude: tgraf@suug.ch|ChangeSet|20050316221421|24742
  o [PKT_SCHED]: Properly return when no backward compatibility action
    statistics are to be dumped
  o [NET]: Allow dumping of application specific statistics if no
    primary TLV is used
  o [NET]: Improve gnet_stats_* dumping logic to be less error prone

Timothy Shimmin:
  o [XFS] Revokes revision 1.37 of xfs_acl.c. It caused CAPP evaluation
    to break as it always requires exec permission for directories when
    the aim was really meant for non-dir executables. See pv#930290.

Tobias Klauser:
  o [ide] drivers/ide/cs5520.c: use the DMA_{64,32}BIT_MASK constants
  o [NETFILTER]: ipt_hashlimit: Remove custom msecs_to_jiffies() macro

Tom 'spot' Callaway:
  o [SPARC]: Implement pte_read() more cleanly

Tom Rini:
  o ppc32: Fix a warning in planb video driver
  o ppc32: Delete arch/ppc/syslib/ppc4xx_serial.c
  o ppc32: Lindent include/asm-ppc/dma.h
  o ppc32: Better comment arch/ppc/syslib/cpc700.h
  o ppc32: Serial fix for PAL4
  o ppc32: Fix a typo on 8260
  o ppc32: 8xx typo fix

Tony Lindgren:
  o [ARM PATCH] 2539/1: OMAP update 1/10: Arch files
  o [ARM PATCH] 2548/1: OMAP update 2/10: Include files
  o [ARM PATCH] 2565/1: OMAP update 3/10: Clock changes, take 2
  o [ARM PATCH] 2564/1: OMAP update 4/10: Pin multiplexing updates,
    take 2
  o [ARM PATCH] 2546/1: OMAP update 5/10: GPIO interrupt changes
  o [ARM PATCH] 2544/1: OMAP update 6/10: Change OCPI to use clock
    framework
  o [ARM PATCH] 2547/1: Update OMAP 7/10: USB low-level init
  o [ARM PATCH] 2541/1: OMAP update 8/10: Leds related changes
  o [ARM PATCH] 2542/1: OMAP update 9/10: Board specific updates
  o [ARM PATCH] 2540/1: OMAP update 10/10: Add boards VoiceBlue and
    NetStar

Tony Luck:
  o [IA64] Another fix for pgd_addr_end (last one was wrong)

Trond Myklebust:
  o NFS: Fix typo in access caching code
  o SELINUX: Fix i_sock reference

Uwe Bugla:
  o cx24110 Conexant Frontend update

Venkatesh Pallipadi:
  o rtc_lock is irq-safe
  o x86, x86_64: reading deterministic cache parameters and exporting
    it in /sysfs

Vincent Sanders:
  o [ARM PATCH] 2584/1: cpufreq Kconfig menu tidyup
  o [ARM PATCH] 2585/1: missing ARCH_CLPS7500 depends in video Kconfig
  o [ARM PATCH] 2586/1: Update clps7500_defconfig default config
  o [ARM PATCH] 2587/1: Update badge4_defconfig default config
  o [ARM PATCH] 2588/1: Update bast_defconfig default config
  o [ARM PATCH] 2589/1: Update cerfcube_defconfig default config
  o [ARM PATCH] 2590/1: Update ebsa110_defconfig default config
  o [ARM PATCH] 2591/1: Update iq31244_defconfig default config
  o [ARM PATCH] 2592/1: Update iq80321_defconfig default config
  o [ARM PATCH] 2593/1: Update iq80331_defconfig default config
  o [ARM PATCH] 2594/1: Update iq80332_defconfig default config
  o [ARM PATCH] 2595/1: Update mainstone_defconfig default config
  o [ARM PATCH] 2596/1: Update mx1ads_defconfig default config
  o [ARM PATCH] 2597/1: Update netwinder_defconfig default config
  o [ARM PATCH] 2598/1: Update omap_h2_1610_defconfig default config
  o [ARM PATCH] 2599/1: Update s3c2410_defconfig default config
  o [ARM PATCH] 2600/1: Update edb7211_defconfig default config
  o [ARM PATCH] 2601/1: Update enp2611_defconfig default config
  o [ARM PATCH] 2602/1: Update integrator_defconfig default config
  o [ARM PATCH] 2603/1: Update ixdp2400_defconfig default config
  o [ARM PATCH] 2604/1: Update ixdp2401_defconfig default config
  o [ARM PATCH] 2605/1: Update ixdp2800_defconfig default config
  o [ARM PATCH] 2606/1: Update omnimeter_defconfig default config
  o [ARM PATCH] 2607/1: Update pleb_defconfig default config
  o [ARM PATCH] 2608/1: Update pxa255-idp_defconfig default config
  o [ARM PATCH] 2609/1: Update ep80219_defconfig default config
  o [ARM PATCH] 2610/1: Update epxa10db_defconfig default config
  o [ARM PATCH] 2611/1: Update footbridge_defconfig default config
  o [ARM PATCH] 2612/1: Update ixdp2801_defconfig default config
  o [ARM PATCH] 2613/1: Update ixp4xx_defconfig default config
  o [ARM PATCH] 2614/1: Update jornada720_defconfig default config
  o [ARM PATCH] 2615/1: Update shannon_defconfig default config
  o [ARM PATCH] 2616/1: Update smdk2410_defconfig default config
  o [ARM PATCH] 2617/1: Update fortunet_defconfig default config
  o [ARM PATCH] 2618/1: Update h3600_defconfig default config
  o [ARM PATCH] 2619/1: Update h7201_defconfig default config
  o [ARM PATCH] 2620/1: Update h7202_defconfig default config
  o [ARM PATCH] 2621/1: Update hackkit_defconfig default config
  o [ARM PATCH] 2622/1: Update lart_defconfig default config
  o [ARM PATCH] 2623/1: Update lpd7a400_defconfig default config
  o [ARM PATCH] 2624/1: Update lpd7a404_defconfig default config
  o [ARM PATCH] 2625/1: Update lubbock_defconfig default config
  o [ARM PATCH] 2626/1: Update versatile_defconfig default config
  o [ARM PATCH] 2627/1: Update lusl7200_defconfig default config
  o [ARM PATCH] 2628/1: Update simpad_defconfig default config
  o [ARM PATCH] 2629/1: Update shark_defconfig default config
  o [ARM PATCH] 2636/1: Missing include breaking cats build

Wen Xiong:
  o serial: Digi Neo driver

Yoichi Yuasa:
  o mips: update VR41xx RTC support

Yoshinori Sato:
  o nommu.c build error fix

Zwane Mwaikambo:
  o APM: fix interrupts enabled in device_power_up
  o x86: reduce cacheline bouncing in cpu_idle_wait
  o x86_64: reduce cacheline bouncing in cpu_idle_wait
