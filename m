Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267404AbSLRWPz>; Wed, 18 Dec 2002 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbSLRWOG>; Wed, 18 Dec 2002 17:14:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15579 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267404AbSLRWMr> convert rfc822-to-8bit; Wed, 18 Dec 2002 17:12:47 -0500
Date: Wed, 18 Dec 2002 17:22:50 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre2
Message-ID: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Better late than never, here goes -pre2.


Summary of changes from v2.4.21-pre1 to v2.4.21-pre2
============================================

<agruen@suse.de>:
  o ia64: Extended Attribute VFS syscalls

<alex_williamson@hp.com[helgaas]>:
  o ia64: If no CPE interrupt, poll periodically for CPEs

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Fix race between TLB purges and reload_context
  o ia64: Avoid holding tasklist_lock across routines that do IPIs (such as flush_tlb_all())
  o ia64: Avoid holding task lock while calling access_process_vm()
  o ia64: Update defconfig with 2.4.20 defaults, build in ext3
  o ia64: Move simeth, simserial, simscsi back to drivers/ for init ordering
  o ia64: break trap: die_if_kernel only if break value is 0
  o ia64: Alternate signal stack fix.  Patch from David Mosberger

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: Some formatting cleanups
  o ia64: Patch by Venkatesh Pallipadi to fix IA-32 signal handling to restore instruction and data pointers.
  o ia64: Fix unaligned memory access handler

<eranian@frankl.hpl.hp.com>:
  o ia64: perfmon update

<eranian@frankl.hpl.hp.com[helgaas]>:
  o ia64: perfmon: This patch adds

<grundym@us.ibm.com>:
  o 2.4.21-pre1 compile fixes for s390(x)

<jkt@helius.com>:
  o uhci corruption on usb_submit_urb when already -EINPROGRESS

<jsm@udlkern.fc.hp.com>:
  o ia64: Preserve f11-f15 around calls into firmware
  o ia64: Use virtual mem map automatically if >1GB gap found

<kernel@steeleye.com>:
  o Fix NULL pointer dereference in ide.c

<kuba@mareimbrium.org>:
  o USB: ftdi-sio update

<m.c.p@wolk-project.de>:
  o Eliminate warning in drivers/usb/hc_sl811.c

<marekm@amelek.gda.pl>:
  o Datafab KECF-USB / Sagatek DCS-CF / Simpletech UCF-100

<mikael.starvik@axis.com>:
  o CRIS architecture update for 2.4.21

<mlocke@mvista.com>:
  o serial.c fix: ELAN fix breaks others

<nobita@t-online.de>:
  o support for Sony Cybershot F717 digital camera / usb-storage

<petkan@mastika.dce.bg>:
  o set_mac_address is now added to the driver.  thanks to Orjan Friberg <orjan.friberg@axis.com>

<petkan@rakia.dce.bg>:
  o USB: pegasus: the data for the control requests is now stored in DMA able memory

<stelian@popies.net>:
  o usbnet typo

<venkatesh.pallipadi@intel.com[helgaas]>:
  o ia64: Save/Restore of IA32 fpstate in sigcontext
  o ia64: Clearing of exception status before calling IA32 user signal handler
  o ia64: IA-32 ptrace: xmm reg support, fpstate 'tag' fix, fp TOS fix

<wahrenbruch@kobil.de>:
  o USB: add kobil_sct driver
  o USB: kobil_sct driver bugfix

<willy@fc.hp.com>:
  o ia64: Remove support for HP prototypes
  o ia64: Discard *.text.exit and *.data.exit sections
  o ia64: ACPI tidy-up

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o IDE changes for CRIS
  o ppc structure mangling for ide
  o Add NS32 author to CREDITS
  o Add NinjaSCSI author to CREDITS
  o ide config tweaks
  o ninja 32 help
  o config for beos fs
  o pcigame now does ali5451
  o clean drm object
  o fix pci game double unregister
  o update serial_cs from pcmcia updates
  o update parisc gsc/hil drivers
  o ad scx200 i2c drivers
  o typo in ide config
  o fix port types to be long for IDE iops, fix ppc mess
  o ide-tape driver updates
  o fix u32->ulong for IDE bars
  o fix ali u32->ulong on bars also fix oops on boot with xmeta
  o ; more ide fixes for ulong
  o fix hpt, print message when we abort due to overclocking
  o more ide u32->ulong
  o clean up u32/ulong/mmio etc on siimage (DaveM)
  o final bits of ide pci driver fixup
  o add sf16fmr2 driver
  o fix sign bug in pms
  o make the cache line printk nicer and < 80 cols
  o config for ninja32 scsi
  o further cpqfcts fixes
  o fix section clash in in2000
  o makefile for NSP32
  o comment purpose of a blacklist entry
  o ad1889 audio driver
  o makefile for ad1889
  o midibuf data loss fixes
  o fix cirrus driver for 7548
  o add hppa fbmem rule
  o update parisc st driver
  o ugly but signed wrap isnt defined
  o make alpha use generic iops
  o more idea headers
  o the generic iops
  o x86 uses generic ios
  o bring mode ide headers back into line
  o make ia64 macro in/out safer
  o parisc ide bits
  o bring parisc system_irqsave into sync
  o bring ppc irq bits into sync
  o ide update bits for sparc
  o default iops for x86-64
  o arcnet header update
  o update core IDE to reflect ulong port
  o interrupt.h might need system.h
  o tidy misc.h
  o reserve value used in 2.5
  o reserve ident for the sf16
  o pcmcia id/header updates
  o maintainer updates
  o ide setup-pci u32->ulong for dma base
  o AGP Gart setup

Alan Cox <alan@redhat.com>:
  o SIS5513 fixes

Alex Williamson <alex_williamson@hp.com>:
  o ia64: Fix potential MCA and silent data corruption in HP zx1 IOMMU driver.

Andreas Schwab <schwab@suse.de>:
  o ia64: Add missing symbol exports for modules
  o ia64: Remove many warnings

Andrew Morton <akpm@digeo.com>:
  o ext3 deadlock fix
  o ext3 use-after-free bugfix

Arjan van de Ven <arjanv@redhat.com>:
  o USB pwc deadlock fixes

Ben Collins <bcollins@debian.org>:
  o Linux1394 Firewire

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: Reserve syscall numbers 1238-1242 for AIO
  o ia64: If more than NR_CPUS found, ignore the extras
  o ia64: Move simeth, simserial, simscsi to arch/ia64/hp/sim
  o ia64: Rename ia64_alloc_irq to ia64_alloc_vector
  o ia64: Print EFI call status in hex, not decimal
  o ia64: Remove McKinley A-step config stuff
  o ia64: Sync with pcibios_enable_device interface change
  o Remove include/asm-ia64/offsets.h
  o ia64: Add PCI_DMA_BUS_IS_PHYS definition
  o ia64: support scatterlist page/offset in sba_iommu.c
  o ia64: Remove obsolete McKinley A0 workaround
  o ia64: Reserve hugetlb syscall numbers
  o ia64: Optimize load/save FPU (Fenghua Yu, Intel)
  o ia64: more scatterlist page/offset cleanup
  o ia64: Scan PCI buses 0-255 (not 0-254)
  o ia64: Skip blind PCI probe when root bridges are reported by ACPI
  o ia64: Detect HP ZX1 AGP bridge via ACPI instead of the old, unmaintainable "fake PCI device" scheme.
  o ia64: Restore "fake PCI device" support, for XFree86.  This is intended to go away in 2.5.x.
  o ia64: Rename __flush_tlb_all() to local_flush_tlb_all()
  o ia64: Make flush_tlb_mm() work for multi-threaded address-spaces on SMP machines
  o ia64: Fix ACPI_ACQUIRE_GLOBAL_LOCK and ACPI_RELEASE_GLOBAL_LOCK
  o ia64: Fix efi_memmap_walk() to work with more complicated memory maps
  o ia64: Make mremap() work properly when returning "negative" addresses
  o ia64: Workaround for old toolchain (__get_user() in perfmon)
  o ia64: Include vendor/function ID for "Unknown" IOCs
  o ia64: Fix typo in unaligned memory access handler (no functional change)
  o joydev: fix HZ->millisecond transformation
  o Remove bogus AGP/DRM assumptions

Charles White <charles.white@hp.com>:
  o cpqfc fixes

Christoph Hellwig <hch@sgi.com>:
  o CREDITS update
  o fix small style error in arch/i386/config.in

David Brownell <david-b@pacbell.net>:
  o remove CONFIG_USB_LONG_TIMEOUT
  o usbnet:  framing, sync with 2.5

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Fix I/O macros in asm-ia64/io.h.  Based on patch by Andreas Schwab
  o ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix proposed by Dave Miller).
  o ia64: Fix return path of signal delivery for sigaltstack() case
  o ia64: Fix narrow window during which signal could be delivered with only the memory stack switched over to the alternate signal stack.
  o ia64: Fix edge-triggered IRQ handling.  See Linus's 2.5 cset 1.611 for details
  o ia64: Create dummy file include/asm-ia64/mc146818rtc.h since ide-geometry.c continues to insist on it.
  o ia64: Fix EFI runtime callbacks so they cannot corrupt fp regs
  o ia64: Make it easier to set a breakpoint in the Ski simulator right before starting the kernel (based on patch by Peter Chubb).

Greg Kroah-Hartman <greg@kroah.com>:
  o tipar: fix #include so the driver can compile
  o Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
  o Fix minor code formatting issue on mpparse.c
  o USB: pwc driver: fix compile time warning
  o USB: uhci: fix formatting problem with last patch

J.I. Lee <jung-ik.lee@intel.com>:
  o ia64: PCI hotplug changes for 2.5.39 or later

James Bottomley <james.bottomley@steeleye.com>:
  o Backport of nbd update from 2.5.50

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o IrTTP partial rewrite (credit fixes, races)
  o IrDA dongle locking context fix
  o LSAP socket close fixes
  o simultaneour IrNET connect race fix
  o SMC driver region fixes
  o return under spinlock fixes (Stanford checker)
  o Wireless Extension v15 : private command improvements

Jeff Garzik <jgarzik@redhat.com>:
  o [NET] support IPv6 over token ring (from lkml)
  o [netdrvr tg3] a fix, a cleanup, and an optimization

Jenna S. Hall <jenna.s.hall@intel.com>:
  o ia64: Minor MCA bugfixes

Jens Axboe <axboe@suse.de>:
  o cciss driver update
  o cpqarray driver update

John Stultz <johnstul@us.ibm.com>:
  o Fix gettimeofday for Summit based systems

Kenneth W. Chen <kenneth.w.chen@intel.com>:
  o ia64: Change memcpy to return dest address

Manfred Spraul <manfred@colorfullife.com>:
  o sys_poll SuS compliance fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20021217162617|02721
  o Cset exclude: Charles.White@hp.com|ChangeSet|20021217174320|03728
  o Cset exclude: bjorn_helgaas@hp.com|ChangeSet|20021217162948|02321
  o Changed EXTRAVERSION to -pre2

Matt Domsch <matt_domsch@dell.com>:
  o megaraid 1.18f

Matthew Wilcox <willy@debian.org>:
  o Add pci_bus_*() API for 2.4 [1/2]
  o Convert acpiphp to pci_bus_*() API [2/2]

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd - 1 of 7 - Release rpc response when dropping
  o knfsd - Revalidate inodes after filehandle and name lookup in nfsd
  o knfsd - Use correct value for max size for readlink response
  o knfsd - Fix problem with lockd grace period checking
  o knfsd - Ease increasing the max block size for NFS replies
  o knfs - Correct some error codes returned in nfsfh.c
  o MD - avoid races by never no releasing rdev->sb for faulty devices
  o Remove some inappropriate MD_BUG calls when hot_removing
  o Avoid buffer cache when doing IO of RAID superblock

Nemosoft Unv. <nemosoft@smcc.demon.nl>:
  o USB: PWC 8.10 for 2.4.20

Romain Lievin <rlievin@free.fr>:
  o Add tipar char driver

Rusty Russell <rusty@rustcorp.com.au>:
  o fs_reiserfs_fix_node.c, typo: resourses
  o arch_ppc_mm_tlb.c, typo: the the
  o typo: include_linux_pci_ids.h s_DEVIDE_DEVICE
  o 2.5: kconfig missing EXPERIMENTAL (14_14)
  o 2.5: kconfig spurious bool default value (3_3)
  o tiny kmem_cache_destroy doc tweak
  o Labeled elements are not a GNU extension
  o drivers_s390_block_dasd_3990_erp.c, typo: becaus(e),
  o arch_sh_kernel_irq_intc2.c, typo: the the
  o net_irda_irlmp_event.c, typos: the the, whish
  o drivers_block_ll_rw_blk.c, typo: the the
  o include_asm-ppc_semaphore.h, typo: the the
  o remove emacs settings
  o Wrong module name in help file. (fwd)
  o drivers_s390_block_dasd.c, typo: the the, capitalization
  o 2.5: kconfig choice default value
  o arch_ia64_sn_io_sn2_pcibr_pcibr_config.c, typo: the the
  o [Trivial Patch] scsi_register-006
  o [Trivial Patch] Fix misc_register()
  o Fix confusing comment
  o [patch 2.5] at1700 trivial
  o Check for misc_register() return code in wdt285
  o duplicate header in drivers_ieee1394_sbp2.c
  o drivers_net_bonding.c, typo: the the
  o backward ext3 endianness conversion
  o duplicate header in drivers_pcmcia_sa1100_generic.c
  o drivers_net_tulip_interrupt.c, typo: the the
  o arch_i386_kernel_smpboot.c, typo: wierd
  o Typo in linux_arch_i386_mm_init.c
  o Fix path in
  o drivers_isdn_isdn_ppp.c, typo: the the
  o Documentation_networking_bonding.txt, typo: the the
  o Documentation_cciss.txt, typo: the the
  o Documentation_watchdog-api.txt, typo: the the
  o drivers_sound_dmasound_dmasound_core.c, typo: wierd
  o drivers_md_lvm.c, typo: the the
  o update comments in ip_tables.c
  o include_asm-alpha_mmzone.h, typo: the the
  o silence invalidate_bdev() a bit
  o Remove duplicated entry in agpgart_be initialization table
  o include_asm-ia64_sn_alenlist.h, typo: the the
  o Fix request_region handling in epca
  o Domsch zip code change
  o sis900 doesn't free resources
  o Fix misc_register() error handling in nvram.c driver
  o 2.4.19 Documentation_Configure.help CONFIG_FB_TRIDENT
  o Remove reference to timer_exit() from kernel-locking.tmpl,
  o misc_register audit fixes on i2o_config

Stéphane Eranian <eranian@hpl.hp.com>:
  o ia64: Fix perfmon error path missing unlock
  o ia64: Fix perfmon error path leaks

Takayoshi Kouchi <t-kouchi@mvf.biglobe.ne.jp>:
  o ia64: Fix iosapic debug code
  o ia64: ACPI CRS cleanup

Tom Rini <trini@kernel.crashing.org>:
  o Correct the behavior of the int verb in scripts/Configure

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix possible SMP race in nfs_sync_page()
  o Fix accounting error in /proc/net/rpc/nfs
  o Disable Nagle algorithm for NFS over TCP

