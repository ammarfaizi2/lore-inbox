Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUC3FhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUC3FhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:37:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:2708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263129AbUC3FfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:35:23 -0500
Date: Mon, 29 Mar 2004 21:35:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.5-rc3
Message-ID: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



x86-64, arm, ppc64, ia64, s390 updates.

And agp, acpi, ISDN and watchdog.

Nothing earth-shattering, in other words.

		Linus

----

Summary of changes from v2.6.5-rc2 to v2.6.5-rc3
============================================

"Bailey, Scott":
  o [TRIVIAL] Tighten sanity in time_init to 250 ppm

"Colin Leroy":
  o therm_adt7467 update

"Petri T. Koistinen":
  o [TRIVIAL] Miata url update

Adam Belay:
  o [PARPORT] Update PC Parport Detection Code
  o [ISAPNP] Fix Device Detection Issue
  o [ISAPNP] MEM Config Fix
  o [PNP] Add some more modem IDs
  o [ISAPNP] Unmark experimental status

Adrian Bunk:
  o fix scsi_transport_spi.c compile with gcc 2.95

Alain Knaff:
  o email address update

Alan Stern:
  o Work around compiler error in proc_misc.c

Alex Williamson:
  o ia64: lost sx1000 naming in sba_iommu

Andi Kleen:
  o critical x86-64 merge
  o Hack mptfusion to work on >4GB machines
  o Two more x86-64 fixes
  o Fix x86-64 32bit getdents for new glibc
  o Don't register disabled nodes
  o Emulate deviceless bridge ioctls
  o Pass correct task to get_user_pages in ptrace
  o Disable debugging in parport daisy

Andrew Morton:
  o fix console oops/race
  o start_cpu_timer() cannot be __init
  o fix device open return values
  o rename dma_error()
  o ia64: add dma_mapping_error() support
  o null-terminate sb->s_id
  o ext2&3: use the right i_flags in find_group_orlov()
  o con_close() deadlock fix
  o write_kmem() fix
  o arch/x86_64/ia32/sys_ia32.c needs vmalloc.h
  o cciss: return -ENXIO on no-device-present
  o inode dirtying timestamp fix

Anton Blanchard:
  o ppc64: remove duplicate FBIOBLANK ioctl translation
  o ppc64: Add eeh calls to hotplug driver
  o ppc64: Remove some stale iseries code
  o ppc64: fix timebase bugs
  o ppc64: implement iommu=off for pseries
  o ppc64: clean up boot messaegs
  o ppc64: implement pci_dma_error
  o ppc64: fix mount compat translation bug
  o [PPC64] make compat filldir/getdents check for errors

Armin Schindler:
  o ISDN Eicon driver: restructured capi list and lock handling
  o ISDN Eicon driver: move workqueue to tasklet for divas dpc
  o ISDN Eicon driver: linked-list handling by kernel api list.h
  o ISDN Eicon driver: fix compilation with non __exit function
  o i386 Kconfig typo fix
  o ISDN CAPI: fix capiminor_alloc() to assign lowest free minor

Arnd Bergmann:
  o Fix missing "noinline" on x86-64

Arthur Othieno:
  o [ARM] arch/arm/boot/Makefile: s/quite_cmd_mknote/quiet_cmd_mknote/

badari:
  o ipc locking fix

Bartlomiej Zolnierkiewicz:
  o ide.c: remove unused code for hwif->mmio == 1
  o remove unused CONFIG_BLK_DEV_TIVO
  o remove unused CONFIG_DMA_NONPCI
  o remove unused ide_hwif_t->pnp_dev
  o asm-sparc{64}/ide.h cleanup (there are no standard ports)
  o asm-parisc/ide.h cleanup (there are no standard ports)

Benjamin Herrenschmidt:
  o pmac: Improved G4 "windtunnel" fan controller
  o pmac_zilog: sleep fix
  o More pmac-zilog sleep fix
  o Cosmetic fix of BMAC boot messages
  o ppc32: Fix racy access to TI_FLAGS
  o adbhid preempt/smp races
  o powerbook via-pmu races
  o dmasound close timeout
  o ppc32: arch code preempt fixes
  o ppc32: More preempt fixes
  o ppc64: syscall error test incorrect for 64 bits results

Bjorn Helgaas:
  o ia64: init IO port space, IO accessors earlier
  o clean up ACPI GSI/IRQ conversions (i386 part)
  o ia64: fix name conflict with handle_exception()
  o ia64: don't prompt for the floppy driver
  o ia64: fix kernel NULL-pointer message
  o Fix uninitialized data in EFI RTC /proc interface
  o Remove <asm/setup.h> from cmdlinepart.c

Brian King:
  o SCSI: Fix Oops in sg with lots of SG_IO activity

Chas Williams:
  o [ATM]: [lec] lec_push() races with vcc->proto_data
  o [ATM]: [nicstar] use kernel min/max (by Randy.Dunlap
    <rddunlap@osdl.org>)

Christoph Hellwig:
  o [ISAPNP] Remove uneeded MOD_INC/DEC_USE_COUNT

Colin Leroy:
  o fix oops at pmac_zilog rmmod'ing

Daniel Ritz:
  o [PCMCIA] attack of the clones

Dave Jones:
  o [AGPGART] Fix URL
  o [AGPGART] Silence serverworks CNB20HE printks
  o [AGPGART] Recognise B3 stepping 8151 in amd64 GART driver
  o [AGPGART] Add SIS 648/746 work around
  o [AGPGART] Give IA32E its own GART driver
  o [AGPGART] Move HP ZX1 registers out of agp.h
  o [AGPGART] Move other chipset vendors registers into vendor specific
    files
  o [AGPGART] More agp.h cleanups Grouping stuff, and bumping copyright
    date.
  o [AGPGART] agp.h indentation fixes
  o [AGPGART] AGPv3 generic support
  o [AGPGART] Clean up SiS648 workaround by giving it its own driver
  o [AGPGART] Make some more Intel/ia32e functions static to fix build
    when both compiled in
  o [AGPGART] Mass ia32e renaming
  o [AGPGART] Remove more unneeded routines from the new Intel driver
  o [AGPGART] Minor CodingStyle fixups

Dave Kleikamp:
  o JFS: Prevent hang in __lock_metapage
  o JFS: don't use global lock in lmLogSync when local lock is
    sufficient

David Mosberger:
  o ia64: GCC v3.5 fixes
  o ia64: Small cleanup in __kernel_sigtramp()
  o ia64: Manual merge of Andrew/Alex/Bjorn's dma_mapping_error()
    changes
  o ia64: Improve layout of cpuinfo_ia64
  o ia64: Minor formatting fix for two earlier patches
  o ia64: Correct value for PREFETCH_STRIDE
  o ia64: Fix typo in unwinder which could cause NULL-pointer
    dereferences

David S. Miller:
  o [B44]: Restore PCI state in b44_resume()
  o [SPARC64]: Handle NULL type arg properly in sys32_mount()
  o [SPARC64]: Provide d_type in sys32_getdents()
  o [SPARC64]: Do not use cast exprs as lvalues
  o [IPV4]: Zap CONFIG_INET_ECN, just always off by default
  o [SPARC64]: Update defconfig
  o [IGMP]: Do nothing in ip_mc_down() if ip_mc_up() was not called
    previously
  o [SPARC64]: Do not lvalue cast in pgd/pmd macros
  o [SPARC64]: Fix lvalue casting in signal32.c
  o [SPARC64]: Fix lvalue casting in sys_sunos32.c
  o [SPARC64]: Fix svr4_stack_t typing in svr4.h
  o [SPARC64]: Fix lvalue casting in sys_sparc32.c
  o [SPARC64]: Fix one last cast-as-lvalue, present in uniprocessor
    builds

Dmitry Torokhov:
  o [NET_SCHED]: Fix class reporting in TBF qdisc
  o [NET_SCHED]: Trailing whitespace cleanup in TBF qdisc

Felipe Alfaro Solana:
  o Add BINFMT_MISC docs for Mono .NET-based binaries

Greg Kroah-Hartman:
  o USB: Eliminate wait following interface unregistration

Hideaki Yoshifuji:
  o [XFRM] remove duplicated lines; fl->fl4_{src,dst} is already filled
    in xfrm_lookup()
  o [XFRM] remove unused argument for (*find_bundle)()

Hugh Dickins:
  o Fix /proc/swaps output alignment

James Morris:
  o [CRYPTO]: Add setkey operation for digests
  o [CRYPTO]: Add Michael MIC algorithm
  o selinux: check return value for receive node permission

James Simmons:
  o tgafb: missing include

Jeff Garzik:
  o Set PCI DMA masks in old-OSS via82cxxx audio driver
  o forgotten pci_dma_mapping_error on x86-64
  o SATA: fix and enable sata-sil
  o update i386 defconfig
  o fix SATA simulation of 6-byte read/write

Jens Axboe:
  o Broken CDROMs default to writeable
  o don't show cdroms in /proc/partitions
  o ide-cd capacity fix

Jeremy Higdon:
  o ia64: make level sensitive interrupt emulation default on SN2

Jesse Barnes:
  o ia64: quiet sn_serial driver
  o ia64: update sn2_defconfig

Joe Korty:
  o Fix posix scheduling violation for !SCHED_OTHER

john stultz:
  o adjuct cpu_khz in response to cpufreq changes

John Williams Floroiu:
  o [IPSEC]: Missing family settings in af_key and xfrm_user

Jon Oberheide:
  o [CRYPTO]: Remove confusing TODO comment in arc4.c

Julian Anastasov:
  o [IPVS] Fix connection rehashing with new cport

Kai Mäkisara:
  o Fix SCSI + st regressions problem

Keith M. Wesolowski:
  o [SPARC32]: Down with our cpu_offset.  Use regular per_cpu instead
  o [SPARC32]: Restore a.out binary format capability
  o [SPARC32]: Use correct atomic initializer for semaphore counters

Keith Owens:
  o ia64: force all kernel sections into one and the same segment
  o ia64: SN2 salinfo oemdata race fix

Kenneth W. Chen:
  o ia64: Interim pal_halt_light patch

Krishna Kumar:
  o [IPV6]: Error is option length increases amidst corking

Len Brown:
  o [ACPI] check "maxcpus=N" early -- same as NR_CPUS check
  o [ACPI] numa.c build fix (Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=2131
  o [ACPI] create disable_acpi()
  o [ACPI] fix interrupts behind yenta cardbus bridge (David Shaohua
    Li) http://bugzilla.kernel.org/show_bug.cgi?id=1564
  o [ACPI] ACPI SCI shall be level/low unless explicit over-ride
    http://bugzilla.kernel.org/show_bug.cgi?id=1622 add "acpi_sci=edge"
    and "acpi_sci=high" manual over-ride
  o [ACPI] delete POWER_OF_TWO array (Pavel Machek)
  o [ACPI] toshiba_acpi 0.18 from John Belmonte add missing copyin
  o [ACPI] share i386/kernel/acpi/boot.c with x86_64
  o [ACPI] PCI interrupt link routing (Luming Yu) use _PRS to determine
    resource type for _SRS fixes HP Proliant servers
    http://bugzilla.kernel.org/show_bug.cgi?id=1590
  o [ACPI] proposed fix for non-identity-mapped SCI override
    http://bugme.osdl.org/show_bug.cgi?id=2366
  o [ACPI] ACPICA 20040326 from Bob Moore
  o [ACPI] Linux specific updates from ACPICA 20040326
    "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

Linus Torvalds:
  o Rename therm_adt7467.c to match the new reality
  o Fix missing part of x86-64 update
  o Fix missing part of x86-64 update, part 2
  o Remove stale legacy ISDN files
  o Revert the input layer change that assumes the i8042 controller is
    always in XLATE mode.
  o Update ppc64 G5-config to something more uptodate
  o Linux 2.6.5-rc3

Luiz Fernando Capitulino:
  o cmpci warning fixes
  o fix a warning in sound/oss/opl3sa2.c

Marc-Christian Petersen:
  o Add missing uacccess checks for sysctl.c
  o mprotect return value fix

Marcel Holtmann:
  o [Bluetooth] Add missing compat ioctl's for CMTP
  o [Bluetooth] Add support for AVM BlueFRITZ! USB v2.0
  o [Bluetooth] Fix display for class of device

Marcelo Tosatti:
  o Fix cyclades async driver timeout miscalculation

Marcus Meissner:
  o ppc64: getdents patch for 32 -> 64 converter

Mark Goodwin:
  o ia64: deprecate SN2 linkstatd

Martin Devera:
  o [NET_SCHED]: HTB scheduler updates

Martin Schwidefsky:
  o s390: core fixes
  o s390: dasd driver
  o s390: z/VM monitor stream
  o s390: network driver
  o s390: tape driver
  o s390: system call speedup part 1
  o s390: system call speedup part 2

Matt Mackall:
  o make inflate use less stack space with gcc3.5

Matthew Wilcox:
  o ia64: kill unused ACPI configgery
  o [PNP] Resource Conflict Cleanup
  o ia64: Fix SAL 3.2 detection
  o consolidate compat_sys_mount

Maximilian Attems:
  o [NETFILTER]: Add MODULE_AUTHOR to ipchains_core.c

Neil Brown:
  o Fix bugs introduced by recent improvements to readdir_plus

NeilBrown:
  o md: Convert a number or "unsigned long"s to "sector_t"s

Olaf Hering:
  o don't display viocd partitions in /proc/paritions

Olof Johansson:
  o ppc64: SMT snooze fix in idle loop
  o ppc64: Fix thinko in iommu allocator
  o ppc64: Use full DART table on G5

Paul Mackerras:
  o ppc32: fix build with CONFIG_MODVERSIONS
  o Threaded core dumps for PPC32
  o fix ppc32 sys_swapcontext

Paul Mundt:
  o sh: update defconfigs
  o sh: port sh-sci driver to the new API
  o sh: DAC ODD driver
  o sh: DMA Mapping API
  o sh: hugetlb support
  o sh: sh-specific framebuffer updates
  o sh: various fixes

Pavel Machek:
  o Kill IDE debug messages during suspend

Peter Osterlund:
  o Revert UDF inode semaphore locking

Petr Baudis:
  o fbcon font cloning fix

Petri Koistinen:
  o [NETFILTER]: ipv4 Kconfig URL updates
  o [ARM] arch_arm_mach-sa1100_Kconfig URL update

Randy Dunlap:
  o [PNP] remove __init from system.c

Richard Henderson:
  o [ALPHA] Fix build in alpha_ksyms.c
  o [TRIVIAL] Remove x86 instructions on alpha
  o [ALPHA] Streamline opDEC_check and the actual fixup bits in
    do_entIF
  o [ALPHA] Update defconfig

Roman Zippel:
  o add missing <linux/config.h>

Russell King:
  o [ARM] Add support for dev->coherent_dma_mask
  o [ARM] Remove Anakin machine support
  o [ARM] Add dma_mapping_error() definition
  o [ARM] Don't conditionally include the sound configuration
  o [ARM] Remove vm_region_dump() debugging
  o [ARM] Move kmalloc() and spinlocks into vm_region_alloc()
  o [ARM] Extend DMA API on ARM for DMA-able writecombining memory
  o [ARM] Convert ARM video drivers to use (ARM extended) DMA API
  o [ARM] Remove consistent_alloc/consistent_free
  o [ARM] Clean up coherent DMA allocator from previous changes
  o [ARM] Fix Acorn RTC year handling

Sam Ravnborg:
  o kbuild ordering fix

Samuel Rydh:
  o keywest bugfix

Santiago Leon:
  o ppc64: Fix log_rtas_error

Sridhar Samudrala:
  o [SCTP] Don't do any ppid byte-order conversions as it is opaque to
    SCTP
  o [SCTP] Avoid the use of hackish CONFIG_IPV6_SCTP__ option

Srivatsa Vaddagiri:
  o Fix slab creation/destruction vs. CPU Hotplug

Stefan Holst:
  o [SPARC32]: Support memory starting at physical address other than 0
  o [SPARC32]: Clean up secondary System.map

Stephen Rothwell:
  o PPC64 iSeries kernel messages cleanup
  o ppc64: iSeries virtual cd fix
  o ppc64: iSeries virtual console cleanup (part 1)

Trent Lathiat Lloyd:
  o [NETFILTER]: Fix typo in ip_fw_compat_masq.c

Ulrich Drepper:
  o Fix error value for opening block devices

Wensong Zhang:
  o [IPVS]: Fix to hold the lock before updating a service

Wim Van Sebroeck:
  o [WATCHDOG] v2.6.5-rc2 wdt.c-patch
  o [WATCHDOG] v2.6.5-rc2 wdt_pci.c-patch
  o [WATCHDOG] v2.6.5-rc2 wd501p.h-patch
  o [WATCHDOG] v2.6.5-rc2 softdog.c-patch
  o [WATCHDOG] v2.6.5-rc2 pcwd.c-patch1
  o [WATCHDOG] v2.6.5-rc2 Kconfig-patch
  o [WATCHDOG] v2.6.5-rc2 pcwd.c-patch2
  o [WATCHDOG] v2.6.5-rc2 pcwd.c-patch3
  o [WATCHDOG] v2.6.5-rc2 pcwd.c-patch4

