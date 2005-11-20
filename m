Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVKTDkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVKTDkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVKTDkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:40:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751177AbVKTDkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:40:32 -0500
Date: Sat, 19 Nov 2005 19:40:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.15-rc2
Message-ID: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There it is (or will soon be - the tar-ball and patches are still 
uploading, and mirroring can obviously take some time after that).

It's slightly bigger than I'd like, but that's partly because I had (once 
more) missed a merge that was actually sent in well before the -rc1 
cut-off, so the x86-64 merge is from there and was delayed due to yours 
truly, not Andi Kleen.

Apart from the x86-64 merge and various fixups, I've let MIPS, PARISC and 
PowerPC merge up some more.

The shortlog speaks for itself. 

		Linus

----
Adrian Bunk:
      arch/i386/mm/init.c: small cleanups

Al Viro:
      m68k: introduce task_thread_info
      m68k: introduce setup_thread_stack() and end_of_stack()
      m68k: thread_info header cleanup
      m68k: m68k-specific thread_info changes

Albert Lee:
      libata: honor the transfer cycle time speficied by the EIDE device

Alexey Dobriyan:
      alim15x3: use KERN_WARNING

Amit Gud:
      cs5520: fix return value of cs5520_init_one()

Andi Kleen:
      x86_64: Update defconfig
      x86_64: Add 4GB DMA32 zone
      x86_64: Set compatibility flag for 4GB zone on IA64
      x86_64: Make i386 compile again with fourth DMA32 zone
      x86_64: When cpu_up fails clean up page allocator properly
      x86_64: Account mem_map in VM holes accounting
      x86_64: Fix up outdated pfn_to_page comment
      x86_64: Remove obsolete ARCH_HAS_ATOMIC_UNSIGNED and page_flags_t
      x86_64: Use the DMA32 zone for dma_alloc_coherent()/pci_alloc_consistent
      x86_64: Fix gcc 4 warning in aperture.c
      x86_64: Speed up numa_node_id by putting it directly into the PDA
      x86_64: Don't apply __PHYSICAL_MASK to page frame numbers
      x86_64: Only use asm/sections.h to declare section symbols
      x86_64: Replace cpu_pda extern with include
      x86_64: Replace swiotlb extern with include
      x86_64: Some clarifications for Documention/x86_64/mm.txt
      x86_64: Use int operations in spinlocks to support more than 128 CPUs spinning.
      x86_64: New heuristics to find out hotpluggable CPUs.
      AGP: Support ULI/ALI 1689 bridge on AMD64
      AGP: Try unsupported AGP chipsets on x86-64 by default
      AGP: Make gart iterator in K8 AGP driver SMP safe
      x86_64: Allow modular build of ia32 aout loader
      x86_64: Formatting fixes for arch/x86_64/kernel/process.c
      x86_64: Don't enable interrupt unconditionally in reboot path
      x86_64: Fix NUMA node lookup debug code which had bitrotted
      x86_64: Reduce number of retries for reset through keyboard controller
      x86_64: Remove optimization for B stepping AMD K8
      x86_64: Remove asm-x86_64/rwsem.h
      x86_64: Log machine checks from boot on Intel systems
      x86_64: Remove CONFIG_CHECKING and add command line option for pagefault tracing
      x86_64: Increase the maximum number of local APICs to the maximum

Andrew Morton:
      nv_of.c build fix
      rpaphp_pci build fix
      pciehp_hpc build fix
      shpchp_hpc build fix
      powerpc-xmon-build-fix
      acct.h needs jiffies.h
      v4l-944-added-driver-for-saa7127-video-tidy
      hfc_usb: fix usb device table
      USB: usbdevfs_ioctl 32bit fix
      usb devio warning fix
      git-netdev-all-ieee80211_get_payload-warning-fix

Andrey Volkov:
      [SERIAL] Fix mpc52xx_uart.c
      [DRIVER MODEL] Fix typo in ohci-ppc-soc.c
      Fix copy-paste bug in ohci-ppc-soc.c

Andy Whitcroft:
      ppc64 need HPAGE_SHIFT when huge pages disabled

Antonino A. Daplas:
      fbdev: fix module dependency loop
      nvidiafb: Fix bug in nvidiafb_pan_display

Antti Andreimann:
      USB: Maxtor OneTouch button support for older drives

Arnaud Giersch:
      [MIPS] IP32: Export mace symbol.
      [MIPS] IP32 Fix and complete IP32 parport definitions
      [MIPS] IP32: Fix sparse warnings.
      [MIPS] Add const qualifier to writes##bwlq.
      [MIPS] Fix documentation typos.

Ashok Raj:
      x86_64: Remove duplicate __cpuinit define

Aurelien Jarno:
      sis5513: enable ATA133 for the SiS965 southbridge

Bartlomiej Zolnierkiewicz:
      ide: remove duplicate documentation for ide_do_drive_cmd()
      ide: remove unused ide_action_t:ide_next
      ide: remove dead DEBUG_TASKFILE code
      ide: remove dead code from flagged_taskfile()
      ide: add missing __init tags to device drivers

Ben Collins:
      Add missing EXPORT_SYMBOLS() for __ide_mm_* functions on powerpc
      Update location of ll_rw_blk.c in docs

Ben Dooks:
      [ARM] 3161/1: BAST - fix commas on end of structs
      [ARM] 3162/1: S3C2410 - updated defconfig

Benjamin Herrenschmidt:
      powerpc: Always rebuild arch/powerpc/include/asm symlink
      powerpc: vdso fixes (take #2)
      powerpc: kill ppc64 rtc.c, use genrtc instead
      powerpc: update defconfigs
      powerpc: pci_64 fixes & cleanups
      ppc: Fix boot with yaboot with ARCH=ppc
      ppc: Fix build with CONFIG_CHRP not set
      powerpc: Make the vDSO functions set error code (#2)
      powerpc: Workaround for offb on 64 bits platforms
      powerpc: merge align.c
      powerpc: Fix setting MPIC priority

Bill Pechter:
      v4l:: (936) Support for sabrent bt848 version

Bjorn Helgaas:
      [SERIAL] Claim Wacom tablet device on HP tc1100 tablet

Bob Picco:
      cpuset: fix return without releasing semaphore
      x86_64: Fix sparse mem

Bryan Ford:
      x86_64: Save/restore CS in 64bit signal handlers and force __USER_CS for CS

Carlos O'Donell:
      [PARISC] Document some register usages in assembly files

Chen, Kenneth W:
      ia64: cpu_idle performance bug fix
      [IA64] 4 level page table bug fix in vhpt_miss
      [IA64] polish comments for tlb fault handler in ivt.S

Chris Wright:
      VFS: local denial-of-service with file leases

Christoph Hellwig:
      [SPARC]: Fix RTC compat ioctl kernel log spam.
      [SBUSFB]: implement ->compat_ioctl
      fix task_struct leak in ptrace
      v850: use generic hardirq code
      [PARISC] move PA perf driver over to ->compat_ioctl
      [PARISC] remove drm compat ioctls handlers

Christoph Lameter:
      slab: remove alloc_pages() calls

Clemens Buchacher:
      arch/mips/au1000/common/usbdev.c: don't concatenate __FUNCTION__ with strings

Constantine Gavrilov:
      x86: fix sigaddset() inline asm memory constraint

Corey Minyard:
      ipmi: bump-driver-version

Coywolf Qi Hunt:
      [BLOCK] new block/ directory comment tidy

Daniel Drake:
      usb-storage: Fix detection of kodak flash readers in shuttle_usbat driver
      via82cxxx IDE: remove /proc/via entry
      via82cxxx IDE: support multiple controllers

Daniel Jacobowitz:
      [ARM] 3168/1: Update ARM signal delivery and masking

Dave Jones:
      v4l: saa711x driver doesn't need segment.h
      oops-tracing: mention extended VGA

David Brownell:
      USB: onetouch doesn't suspend yet

David Gibson:
      powerpc: Remove imalloc.h

David S. Miller:
      [DVB] cinergyT2: cinergyt2_register_rc() should return 0 on success
      [DVB]: Add compat ioctl handling.
      [COMPAT]: Add ext3 ioctl translations.
      [LLC]: Fix compiler warnings introduced by TX window scaling changes.
      [IPV6]: Fib dump really needs GFP_ATOMIC.
      [COMPAT]: EXT3_IOC_SETVERSION is _IOW() not _IOR().

David Woodhouse:
      Avoid use of uninitialised spinlock in EEH.

Deepak Saxena:
      Fix IXP4xx I2C driver build breakage

Denis Lunev:
      ext3: journal handling on error path in ext3_journalled_writepage()

Diego Calleja:
      oops-tracing: mention digital photos

Dmitry Torokhov:
      I8K: fix /proc reporting of blank service tags
      USB: fix 'unused variable' warning

Dominik Brodowski:
      [PCMCIA] i82365: use new platform_device helpers
      [PCMCIA] inform user of insertion and ejection events

Eric Dumazet:
      reorder struct files_struct
      x86_64: Optimize NUMA node hash function

Florin Malita:
      [SERIAL] sa1100_start_tx spinlock recursion

Francois Romieu:
      r8169: fix printk_ratelimit in the interrupt handler
      r8169: do not abort when the power management capabilities are disabled

Gabriel A. Devenyi:
      drivers/net/wireless/hermes.c unsigned int comparision

George Anzinger:
      timespec: normalize off by one errors

Grant Coady:
      cciss_scsi warning fix

Grant Grundler:
      [PARISC] Disable nesting of interrupts
      [PARISC] irq_affinityp[] only available for SMP builds
      [PARISC] Remove unused variable in signal.c

Greg Kroah-Hartman:
      USB: fix build breakage in dummy_hcd.c
      USB Serial: rename ChangeLog.old
      USB: move CONFIG_USB_DEBUG checks into the Makefile
      USB: delete the nokia_dku2 driver
      USB: add the anydata usb-serial driver
      Add HOWTO do kernel development document to the Documentation directory
      update Documentation/00-INDEX

Guido Guenther:
      PowerBook 6,1: headphone not detected after suspend
      [SPARC64]: Oops in pci_alloc_consistent with cingergyT2

Hanna Linder:
      alim15x3: replace pci_find_device() with pci_dev_present()

Hans Reiser:
      re-export clear_page_dirty_for_io()

Hans Verkuil:
      v4l: (944) added driver for saa7127 video decoder
      v4l: (945) adds a new include for internal v4l2 ioctls and api
      v4l: (946) adds support for cx25840 video decoder
      v4l: (948) adds support for saa7115 video decoder
      v4l: (966) Authorship fixes for new Modules
      v4l: 976: ensure consistent v4l firmware prefixes

Harald Welte:
      New Omnikey Cardman 4040 driver
      New Omnikey Cardman 4000 driver
      [NETFILTER] nfnetlink: unconditionally require CAP_NET_ADMIN
      Make sysctl.h (again) usable from userspace
      [NETFILTER] ip_conntrack: fix ftp/irc/tftp helpers on ports >= 32768

Hartmut Hackmann:
      v4l: (949) Added support for secam l'

Heiko Carstens:
      signal handling: revert sigkill priority fix

Herbert Xu:
      [IPV6]: Fix rtnetlink dump infinite loop
      USB: fix race in kaweth disconnect

Ingo Molnar:
      rcutorture: renice to low priority

J. Bruce Fields:
      VFS: Fix memory leak with file leases

Jacob Shin:
      x86_64: Support for AMD specific MCE Threshold.

James Bottomley:
      [PARISC] Make sure timer and IPI execute with interrupts disabled
      [PARISC] Fix our interrupts not to use smp_call_function
      [PARISC] Add IRQ affinities
      [PARISC] Fix our spinlock implementation
      ide: fix ide_toggle_bounce() to not try to bounce if we have an IOMMU

James Cleverdon:
      i386/x86-64: Share interrupt vectors when there is a large number of interrupt sources

James Ketrenos:
      ipw2100: Fix 'Driver using old /proc/net/wireless...' message

Jan Beulich:
      i386: NMI pointer comparison fix
      make vesafb build without CONFIG_MTRR
      x86_64: Adjust, correct, and complete the HPET definitions for x86-64.

Jeff Garzik:
      [libata ahci, qstor] fix miscount of scatter/gather entries
      [libata ahci] set port ATAPI bit correctly
      [libata sata_mv] minor fixes
      [libata sata_mv] trim trailing whitespace
      [libata sata_mv] note driver is "HIGHLY EXPERIMENTAL" in Kconfig
      [libata sata_mv] implement a bunch of errata workarounds
      [libata sata_mv] move code around
      [libata sata_mv] mv_hw_ops for hardware families; new errata
      [libata sata_mv] hardware initialization work
      [libata sata_mv] move code around
      [libata sata_mv] call phy fixups during init, as well as phy reset
      [libata sata_mv] fix tons of 50XX bugs
      move pm_register/etc. to CONFIG_PM_LEGACY, pm_legacy.h
      [libata ahci] error handling fixes
      [libata] fix bugs in ATAPI padding DMA mapping code
      [libata] minor fixes, new helpers
      [libata] REQUEST SENSE handling fixes
      [libata ahci] command completion fixes, improved debug msgs
      [libata ahci] tone down ATAPI errors
      [libata] bump versions
      [libata] add timeout to commands for which we call wait_completion()
      [libata sata_mv] SATA probe, DMA boundary fixes
      [libata sata_mv] handle lack of hardware nIEN support
      [libata sata_mv] update copyright, driver version
      [wireless hermes] build fix
      siimage: docs urls

Jens Axboe:
      [BLOCK] Document the READ/WRITE splitup of the disk stats
      VM: fix zone list restart in page allocatate
      [PATCH 2/3] cciss: bug fix for BIG_PASS_THRU

Jesper Juhl:
      README: add info about -stable to README and point at applying-patches.txt

Jesse Brandeburg:
      e100: re-enable microcode with more useful defaults

Jochen Friedrich:
      [LLC]: Fix TX window scaling
      [LLC]: Make core block on remote busy.
      [LLC]: Fix typo

Jody McIntyre:
      Add SCM info to MAINTAINERS

Johann Lombardi:
      ext2: remove duplicate newlines in ext2_fill_super

John W. Linville:
      i82593.h: make header comment GPL-compatible
      fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx

Josef Balatka:
      USB: cp2101.c: Jablotron usb serial interface identification

Karsten Wiese:
      x86_64 two timer entries in /sys

Kirill Korotaev:
      mm: __GFP_NOFAIL fix
      stop_machine() vs. synchronous IPI send deadlock

KOVACS Krisztian:
      [NETFILTER] nf_conntrack: Add missing code to TCP conntrack module
      [NETFILTER] Remove nf_conntrack stat proc file when cleaning up
      [NETFILTER] Free layer-3 specific protocol tables at cleanup

Krzysztof Halasa:
      Generic HDLC WAN drivers - disable netif_carrier_off()

Krzysztof Oledzki:
      [NETFILTER]: link 'netfilter' before ipv4

Kumar Gala:
      Update email address for Kumar
      ppc32: Add support for handling PCI interrupts on MPC834x PCI expansion card
      powerpc: replace page_to_virt() with lowmem_page_address() for Book-E
      ppc: Fix warnings related to seq_file
      ppc: Fix MPC83xx device table
      ppc: Fix warnings related to seq_file

Kyle McMartin:
      [PARISC] Fix uniprocessor build by dummying smp_send_all_nop()
      [PARISC] Make superio.c initialize before any driver needs it
      [PARISC] Update CREDITS entries

Kylene Jo Hall:
      tpm: necessary PPC64 function exports
      tpm: updates for new hardware
      tpm: dev_mask handling fix
      tpm: locking fix
      tpm: use flush_scheduled_work()
      tpm: use ioread8 and iowrite8
      tpm: remove PCI kconfig dependency

Laurent Riffard:
      ide: remove ide_driver_t.owner field

Lennert Buytenhek:
      [SERIAL] don't disable xscale serial ports after autoconfig

Linus Torvalds:
      Revert "fbcon: Add rl (Roman Large) font"
      x86: Fix silly typo in recent <asm/signal.h> fixes
      Fix ACPI processor power block initialization
      Linux v2.6.15-rc2

Luiz Capitulino:
      [IPV6]: Fixes sparse warning in ipv6/ipv6_sockglue.c

Luiz Fernando Capitulino:
      Fix sparse warning in proc/task_mmu.c
      USB: pl2303: adds new IDs.
      USB: pl2303: updates pl2303_update_line_status()

Maciej W. Rozycki:
      [MIPS] zs.c: Resurrect the deceased zs.c for now.

Magnus Damm:
      x86_64: Make node boundaries consistent

Marcel Holtmann:
      USB: Delete leftovers from bluetty driver

Marcelo Tosatti:
      ppc32 8xx: update_mmu_cache() needs unconditional tlbie

Mark Lord:
      libata: fix comments on ata_tf_from_fis()
      [libata passthru] address slave devices correctly

Mark Weaver:
      v4l: (939) Support for nebula rc5 based gpio remote

Martin Schwidefsky:
      s390: fix class_device_create calls in 3270 the driver

Martin Waitz:
      DocBook: allow to mark structure members private
      DocBook: include printk documentation
      DocBook: comment about paper type
      DocBook: revert xmlto use for .ps and .pdf documentation

Mathias Kretschmer:
      via82cxxx: add VIA VT6410 IDE support

Matt Domsch:
      ipmi: missing NULL test for kthread

Matthew Wilcox:
      [PARISC] Return PDC_OK when alloc_pa_dev fails to enumerate all devices
      [PARISC] Improve the error message when we get a clashing mod path
      [PARISC] Fix some compile problems in ptrace.c
      [PARISC] Always spinlock tlb flush operations to ensure preempt safety
      [PARISC] Fix compile warning caused by conflicting types of expand_upwards()
      [PARISC] Make Serial MUX depend on a specific bus type.
      [PARISC] Mention PA-RISC in NS87415 help
      [PARISC] Mark hisax and pcbit ISDN drivers as not for parisc

matthieu castet:
      fix leaks in request_firmware_nowait

Mauro Carvalho Chehab:
      v4l: (926.1) Added compiling options for wm8775 and cs53l32a chips
      v4l: (943) added secam l video standard
      v4l: (950) Added compiler options for cx25840 saa7115 and saa7127
      v4l: (963) em28xx IR fixup
      v4l: (966.1) Removes Obsoleted i2c-compat.h from newer drivers
      v4l: 977: fix broken dependency needed for sa7134 module

Michael Ellerman:
      powerpc: Merge page.h
      powerpc: Turn cpu_irq_down into kexec_cpu_down
      powerpc: Export htab start/end via device tree
      powerpc: Fixup debugging in lmb.c
      powerpc: More debugging fixups
      powerpc: Fix typo in topology.h

Michael Krufky:
      v4l: (963.1) hybrid v4l/dvb: remove duplicated code
      v4l: 974: saa7134 shouldn't DEPEND on SND_PCM_OSS. Instead, SELECT it.

Michael S. Tsirkin:
      IB/mthca: Safer max_send_sge/max_recv_sge calculation

Mike Kravetz:
      Remove SPAN_OTHER_NODES config definition

Mike Krufky:
      v4l: prevent saa7134 alsa undefined warnings

mikem:
      [PATCH 1/3] cciss: bug fix for hpacucli
      [PATCH 3/3] cciss: add put_disk into cleanup routines

Miles Bader:
      v850: Fix show_interrupts
      v850: Add missing include in hardirq.h

Neil Brown:
      md: don't pass a NULL file* into ->prepare_write()

NeilBrown:
      knfsd: make sure nfsd doesn't hog a cpu forever
      md: mark START_ARRAY deprecated with a date
      md: make md threads interruptible again
      md: fix is_mddev_idle calculation now that disk/sector accounting happens when request completes

Nick Piggin:
      mm: highmem watermarks
      i386: generic cmpxchg
      atomic: cmpxchg
      atomic: inc_not_zero
      powerpc: Fix database regression due to scheduler changes

Nickolay V. Shmyrev:
      v4l: (937) Included missing interrupt.h at saa7134-alsa.c

Nicolas Pitre:
      [ARM] 3165/1: fix atomic_cmpxchg() implementation for ARMv6+
      smc91x: fix one source of spurious interrupts

OGAWA Hirofumi:
      usbfs: usbfs_dir_inode_operations cleanup

Olaf Hering:
      ppc boot: replace string labels with numbers

Oliver Neukum:
      USB: Adapt microtek driver to new scsi features

Olof Johansson:
      ppc: add support for new powerbooks
      powerpc: add new powerbooks to feature table

Pablo Neira Ayuso:
      [NETFILTER] ctnetlink: use size_t to make gcc-4.x happy
      [NETFILTER] nfnetlink: skip size check if size not specified (== 0)
      [NETFILTER] ctnetlink: More thorough size checking of attributes

Pantelis Antoniou:
      [MIPS] Alchemy: Console output fixup

Paolo 'Blaisorblade' Giarrusso:
      Kbuild: index asm-$(SUBARCH) headers for UML
      uml: remove bogus WARN_ON, triggerable harmlessly on a page fault race
      uml: micro fixups to arch Kconfig
      uml: fixups for "reuse i386 cpu-specific tuning"
      uml: fix mcast network driver error handling
      uml console channels: remove console_write wrappers
      uml console channels: fix the API of console_write
      uml: fix access_ok
      uml: fix daemon transport exit path bug
      x86_64: Set ____cacheline_maxaligned_in_smp alignment to 128 bytes
      x86_64: Use common sys_time64

Patrick McHardy:
      [NETFILTER]: Fix nf_conntrack compilation with CONFIG_NETFILTER_DEBUG

Paul E. McKenney:
      add success/failure indication to RCU torture test

Paul Fulghum:
      synclink: update to use DMA mapping API

Paul Jackson:
      mm: gfp_noreclaim cleanup

Paul Mackerras:
      powerpc: Move a bunch of ppc64 headers to include/asm-powerpc
      powerpc: Move most remaining ppc64 files over to arch/powerpc
      powerpc: Export a couple of prom functions
      powerpc: Mark PREP and embedded as broken for now
      powerpc: Fix 32-bit compile: PPC_MEMSTART was undeclared
      powerpc: Fix clearing of the FPSCR when invoking a signal handler
      powerpc: Remove an extraneous and incorrect declaration of pmac_nvram_init.
      powerpc: Remove __init from a function used in suspend/resume.
      powerpc: Fix sparsemem with memory holes [was Re: ppc64 oops..]
      powerpc: Move ppc64 boot wrapper code over to arch/powerpc
      powerpc: Fix delay functions for 601 processors
      powerpc: Move remaining .c files from arch/ppc64 to arch/powerpc
      powerpc: Fix compile error on pSeries arising from delay.h changes
      powerpc: time-of-day fixes for 32-bit CHRP systems
      powerpc: Fix a couple of compile warnings for 32-bit compiles
      powerpc: Move defconfig over and remove remaining arch/ppc64 files
      offb: Fix compile error on ppc32 systems
      powerpc: Trivially merge several headers from asm-ppc64 to asm-powerpc
      powerpc: Merge pci.h
      powerpc: move include/asm-ppc64/ptrace-common.h to arch/powerpc/kernel
      powerpc: Merge spinlock.h
      powerpc: Fix bug in timebase synchronization on 32-bit SMP powermac

Paul Mundt:
      Shut up per_cpu_ptr() on UP

Pavel Machek:
      [ARM] Fix collie for -rc1
      USB: kill unneccessary usb-storage blacklist entries

Pekka Enberg:
      slab: convert cache to page mapping macros
      ipw2200: disallow direct scanning when device is down

Peter Osterlund:
      packet writing oops fix

Ping Cheng:
      USB: add new wacom devices to usb hid-core list
      USB: wacom tablet driver update

Prakash Punnoor:
      fix b2c2 dvb undefined symbol

Ralf Baechle:
      [SERIAL] dz: Nuke trailing whitespace
      [SERIAL] dz: Use CKSEG1ADDR to setup mappings.
      [MIPS] Delete duplicate definitions of break codes.
      [MIPS] feature-removal-schedule.txt: Schedule au1x00_uart for removal.
      [MIPS] Add missing arch defines for the Alchemy MTD driver.
      Add definitions for the Dallas DS17287 RTC.
      Add definitions for the Dallas DS1742 RTC / non-volatile memory.
      [MIPS] IP32: No need to include <asm/io.h>.
      [MIPS] DDB5477: Fix unused variable warning.
      [MIPS] JMR3927: Undo accidental rename.
      [MIPS] JMR3927: Fix syntax error.
      [IDE] Add driver for Sibyte Swarm evaluation board
      [MIPS] JMR3927: It's ops-tx3927.o not ops-jmr3927.o
      [MIPS] JMR3927: need include/asm-mips/mach-jmr3927 in it's include path.
      [MIPS] JMR3927: Fix compilation by including <linux/ds1742rtc.h>.
      [MIPS] JMR3927: Fix include wrapper symbol.
      [MIPS] Ocelot G: Use CPU_MASK_NONE instead of 0 to initialize cpu mask.
      [MIPS] SEAD: Delete seadint_init() prototype.
      [MIPS] TX3927: Try to glue the PCI code.
      [MIPS] SEAD: More build fixes.
      [MIPS] Update defconfigs
      IOC3: Replace obsolete PCI API
      au1000_eth: Include <linux/config.h>
      SAA9730: Add missing header bits.
      ide: make comment match reality

Ravikiran G Thirumalai:
      x86_64: Make ACPI NUMA and NUMA emulation peers of K8_NUMA in Kconfig

Ricardo Cerqueira:
      v4l: (930) Alsa fixes and improvements
      v4l: (935) Moved common IR stuff to ir-common.c
      v4l: (951) Make saa7134-oss as a stand-alone module
      v4l: (962) Added new saa7134 card (MSI TV@anywhere plus)
      v4l: 975: apply saa7134-alsa fixes

Richard Purdie:
      [ARM] 3149/1: SharpSL: Add Akita (SL-C1000) machine support
      [ARM] 3154/1: SharpSL PM Driver updates
      [ARM] 3158/1: SharpSL: Add PM device driver for the SL-C7x0 machines.
      [ARM] 3159/1: SharpSL: Add PM device driver for the SL-Cx00 machines.
      [ARM] 3160/1: SharpSL: Add driver for Akita specific GPIOs
      w100fb: platform device conversion fixup
      USB: OHCI lh7a404 platform device conversion fixup

Robin Holt:
      mm: ZAP_BLOCK causes redundant work

Roger While:
      prism54 : Remove extraneous udelay/register read

Rohit Seth:
      mm: __alloc_pages cleanup

Roland Dreier:
      [IB] srp: increase max_luns
      [IB] srp: don't post receive if no send buf available
      [IB] mthca: don't disable RDMA writes if no responder resources
      IB/umad: make sure write()s have sufficient data

Roman Zippel:
      m68k: convert thread flags to use bit fields
      [NET]: Sanitize NET_SCHED protection in /net/sched/Kconfig

Russell King:
      [ARM] Fix Footbridge-based machines
      [ARM] Fix broken sl82c105 DMA prevention
      [ARM] Restore apparant pointless change in arch/arm/kernel/smp.c
      [MMC] mmci doesn't need asm/irq.h
      [ARM] Ensure sl82c105 IDE interfaces are serialized when using DMA
      [ARM] Use correct IO operations for Pleb
      [ARM] Re-fix footbridge
      [SERIAL] Fix Bug 4900: S3 resume oops with irattach - Thinkpad A21m
      [ARM] Use kernel/power/Kconfig
      [ARM] Initialise SA1111 core before SA1111 PCMCIA
      [ARM] Fix arch-realview/system.h to use __io_address()
      [ARM] Include asm/hardware.h instead of asm/arch/hardware.h
      [ARM] compressed/head.S debugging defaults to asm/arch/debug-macro.S
      [ARM] Add linux/compiler.h includes where required
      [ARM] Move zone adjustment for SA1111 on SA11x0 platforms
      [ARM] Use unsigned long not u32 in atomic_cmpxchg
      [ARM] sa1111.c needs asm/sizes.h
      [ARM] No need to include asm/proc-fns.h into asm/system.h
      [DRIVER MODEL] Fix merge clashes with ARM ixp2000 / ixp4xx platforms
      [ARM] Improve comment about ASSERT()s in vmlinux.lds.S
      [ARM] Drivers should not make use of architecture private __ioremap
      [ARM] __ioremap doesn't use 4th argument
      [ARM] Fix some corner cases in new mm initialisation
      [ARM] Fix get_user when passed a const pointer
      smc91x: fix bank mismatch
      [SERIAL] Fix status reporting with PL011 serial driver
      [SERIAL] Remove unused variable in sa1100.c

Ryan Bradetich:
      [PARISC] Make redirecting irq messages less noisy
      [PARISC] Compile fixups for serial/mux.c
      [PARISC] Define port->timeout to fix a long msleep in mux.c

Sean Young:
      [MTD] maps: Replace dependency on non existing config option

Segher Boessenkool:
      powerpc: Maple: request I/O resource.

Shaohua Li:
      x86_64: Force correct address space size for MTRR on some 64bit Intel Xeons

Siddha, Suresh B:
      x86_64: fix tss limit
      x86_64: Unmap NULL during early bootup
      x86-64/i386: Intel HT, Multi core detection fixes
      x86_64: x86_64/i386 fix Intel cache detection code assumption about threads sharing

Stephen Hemminger:
      [TCP]: More spelling fixes.
      [TCP]: TCP highspeed build error

Stephen Rothwell:
      powerpc: make iSeries use generic virtual irq mapping
      powerpc: have only one definition of __irq_offset_value
      powerpc: iSeries build fixes
      ppc32: move some dma routines
      powerpc: merge dma-mapping.h

Suresh Siddha:
      x86-64/i386: Fix CPU model for family 6

Tejun Heo:
      [BLOCK] elevator: run queue in elevator_switch
      [BLOCK] cfq-iosched: cfq forced dispatching fix
      [BLOCK] Implement elv_drain_elevator for improved switch error detection
      [BLOCK] fix string handling in elv_iosched_store
      [BLOCK] cfq-iosched: fix slice_left calculation
      [BLOCK] noop-iosched: reimplementation of request dispatching
      [BLOCK] elevator: elv_latter/former_request update
      sil24: add missing ata_pad_free()
      sil24: add constants
      sil24: add sil24_restart_controller
      sil24: use SRST for phy_reset
      sil24: add ATAPI support
      sil24: make error_intr less verbose

Thibaut VARENE:
      pmac IDE: don't release empty interfaces
      aec62xxx: remove all dead (#if0'd) code

Thomas Gleixner:
      [JFFS2] Remove broken and useless debug code

Thomas Graf:
      [IPV6]: Fix unnecessary GFP_ATOMIC allocation in fib6 dump

Tim Mann:
      x86: fix cpu_khz with clock=pit

Toni Mueller:
      sdladrv.c build fix

Tyler Trafford:
      v4l: (958) Make cx25840 use firmware image named 'cx25840.fw'

Vitaly Bordug:
      ppc32: add missing define for fs_enet Ethernet driver

Vivek Goyal:
      drop "i386 kexec-on-panic: Don't shutdown the apics"

Vlad Drukker:
      [NETFILTER] {ip,nf}_conntrack TCP: Accept SYN+PUSH like SYN

Yan Zheng:
      [IPV6]: small fix for ipv6_dev_get_saddr(...)

Yasuyuki Kozakai:
      [NETFILTER]: cleanup IPv6 Netfilter Kconfig
      [NETFILTER]: fix type of sysctl variables in nf_conntrack_ipv6
      [NETFILTER] nf_conntrack: fix possibility of infinite loop while evicting nf_ct_frag6_queue
      [NETFILTER] fix leak of fragment queue at unloading nf_conntrack_ipv6
      [IPV4,IPV6]: replace handmade list with hlist in IPv{4,6} reassembly

Yoichi Yuasa:
      Add GT64111 PCI ID back

Zach Brown:
      aio: remove kioctx from mm_struct
      aio: replace locking comments with assert_spin_locked()
      aio: don't ref kioctx after decref in put_ioctx

Zachary Amsden:
      [BLOCK] elevator init fixes
      [BLOCK] elevator init fixes #2

Zhu Yi:
      ipw2200: fix error log offset calculation

