Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTFTWEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFTWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 18:04:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30189 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264965AbTFTWDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 18:03:41 -0400
Date: Fri, 20 Jun 2003 19:15:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre1
Message-ID: <Pine.LNX.4.55L.0306201907070.10311@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes the first pre of 2.4.22.

It includes the new ACPI code, a big USB update, network updates, amongst
others.

The .22 cycle will be much shorter then .21. I hope that in approximately
two months we can have it stable.

Have a nice weekend


Summary of changes from v2.4.21 to v2.4.22-pre1
============================================

<baldrick@wanadoo.fr>:
  o USB: Backport of USB speedtouch driver to 2.4
  o USB speedtouch: move MOD_INC_USE_COUNT
  o USB speedtouch: discard packets for non-existant vcc's
  o USB speedtouch: bump the version number
  o USB speedtouch: crc optimization
  o USB speedtouch: compile fix
  o USB speedtouch: remove trailing semicolon
  o USB speedtouch: trivial whitespace and name changes
  o USB speedtouch: add missing #include
  o USB speedtouch: replace yield()
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: verbose debugging
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: receive code rewrite
  o USB speedtouch: remove MOD_XXX_USE_COUNT
  o USB speedtouch: set owner fields
  o USB speedtouch: parametrize the module

<bdschuym@pandora.be>:
  o [NETFILTER]: Fix ARPT_INV_MASK in arp_tables.h

<bwheadley@earthlink.net>:
  o USB: Aiptek kernel driver 1.0 for Kernel 2.4

<ccheney@cheney.cx>:
  o USB: vicam.c copyright patches

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Fix foul up in lec driver
  o [ATM]: Add Forerunner HE support

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Fix excessive stack usage in iphase driver
  o [ATM]: svcs possible race with sigd

<cweidema@indiana.edu>:
  o USB: pentax optio S

<dlstevens@us.ibm.com>:
  o [IGMP]: Backport igmpv3/mld2 support to 2.4.x
  o [IGMP]: Make sock_alloc_send_skb calls non-blocking
  o [IPV4/IPV6]: Make sure SKB has enough space while building IGMP/MLD packets
  o [IPV4/IPV6]: Fix IGMP device refcount leaks, with help from yoshfuji@linux-ipv6.org

<dwmw2@dwmw2.baythorne.internal>:
  o Switch to shared optimised CRC32 functions
  o Add config help for CONFIG_CRC32 (Duncan Sands <baldrick@wanadoo.fr>)
  o Fix CONFIG_CRC32=y when nothing in-kernel uses CRC32 functions by exporting the symbol from kernel/ksyms.c instead of lib/crc32.c, hence forcing lib/crc32.o to get pulled in during the final link.

<engebret@brule.rchland.ibm.com>:
  o [PPC64] Add biarch support and fix zImage builds deps from Matt Wilson
  o [PPC64] Search to the leaves of OF nodes for dma-window property
  o [PPC64] Cleanups & merge to 2.4.21pre7

<hanno@gmx.de>:
  o USB: Patch for Vivicam 355

<henning@meier-geinitz.de>:
  o USB: New vendor/product ids for scanner driver

<hwahl@hwahl.de>:
  o USB:  Patch for Samsung Digimax 410

<james@superbug.demon.co.uk>:
  o USB: Add support for Pentax Still Camera to linux kernel

<jengel@brule.rchland.ibm.com>:
  o update arch/ppc64 and include/asm-ppc64
  o turned off CONFIG_KDB and CONFIG_DUMP

<krkumar@us.ibm.com>:
  o [NET]: Initialize sysctl_table to NULL in neigh_parms_alloc

<kumarkr@us.ibm.com>:
  o [TCP]: Handle NLM_F_ACK in tcp_diag.c

<linux-usb@gemeinhardt.info>:
  o USB: add support for Mello MP3 Player

<nicolas@dupeux.net>:
  o USB: UNUSUAL_DEV for aiptek pocketcam

<olof@austin.ibm.com>:
  o [TCP]: tcp_twkill leaves death row list in inconsistent state over tcp_timewait_kill

<per.winkvist@telia.com>:
  o USB: more unusual_devs.h changes
  o Re: unusual_devs.h patch that was in 2.5.68

<philipp@void.at>:
  o USB: unusual_devs.h patch

<richard.curnow@superh.com>:
  o USB: ehci-hcd.c needs to include <linux/bitops.h>

<shemminger@osdl.org>:
  o [IPV4]: Replace explicit dev->refcount bumps with dev_hold

<smb@smbnet.de>:
  o USB: another usb storage addition

<stewart@inverse.wetlogic.net>:
  o USB: HIDDev uref backport for 2.4?

<thomas@osterried.de>:
  o [AX25]: AX.25 bug fixes

<vinay-rc@naturesoft.net>:
  o [NET]: Use mod_timer in dst.c
  o [PKT_SCHED]: Use mod_timer in sch_cbq.c
  o [PKT_SCHED]: Use mod_timer in sch_csz.c
  o [PKT_SCHED]: Use mod_timer in sch_htb.c

<vsu@altlinux.ru>:
  o USB: HIDDEV / UPS patches

<wahrenbruch@kobil.de>:
  o USB: kobil_sct.c added support for KAAN SIM Reader

<walter.harms@informatik.uni-oldenburg.de>:
  o USB: fixes kernel_thread
  o USB: fixes kernel_thread

Alan Stern <stern@rowland.harvard.edu>:
  o USB: US_SC_DEVICE and US_PR_DEVICE for 2.4

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [ACENIC]: Comment out netif_wake_queue from acenic watchdog
  o [IPV4]: More sane rtcache behavior

Andy Grover <agrover@groveronline.com>:
  o Remove old ACPI drivers
  o Delete acpitable.[ch] since they are no longer needed
  o ACPI interpreter update to latest (20020725)
  o Add ACPI driver files
  o This changeset adds ACPI support to 3 main areas
  o By Herbert Nachtnebel
  o Export acpi_get_firmware_table (Matthew Wilcox)
  o Fix ACPI table parsing (Bjorn Helgaas)
  o remove no-longer applicable comment
  o make "acpi=off" disable table parsing as well as interpreter init
  o update for core release version 20020815
  o Remove no-longer needed files
  o Add support for SLIT/SRAT parsing (Kochi Takayoshi)
  o New file for SLIT/SRAT support (Kochi Takayoshi)
  o ACPI interpreter updates
  o fix conditional (Giridhar Pemmasani)
  o ACPI trivial fixes (Kochi Takayoshi)
  o from 2.5: fix ACPI Config.in breakage (C. Hellwig)
  o Ensure that the ACPI interrupt has the proper trigger and polarity
  o ACPI: Remove unused functions in osl.c (Kochi Takayoshi)
  o ACPI: remove unused kdb and debugger directories
  o ACPI: When using CONFIG_ACPI_HT_ONLY, do not configure IOAPIC and LAPIC NMIs.
  o Toshiba ACPI Extras driver by John Belmonte
  o ACPI: Do not compile functions not used in HT_ONLY mode
  o ACPI: Fix possible sleeping at interrupt context (Matthew Wilcox)
  o ACPI: Blacklist improvements 1) Split blacklist code out into a separate file.
  o ACPI: New blacklist entries (Andi Kleen)
  o ACPI: Add a cmdline switch to disable ACPI PCI config (Andi Kleen)
  o ACPI
  o ACPI: Print the DSDT stats on boot, just like the other ACPI tables
  o ACPI: Interpreter update to 20020918
  o ACPI: Ensure that the ACPI SCI (system control interrupt) is set to active lov, level trigger.
  o ACPI: Make ACPI's use of fixmap use its own fixmap region, instead of the IOAPICs, since that will not be present on UP systems.
  o ACPI: change a non-critical debug message to a more appropriate level
  o ACPI: Replace ACPI_DEBUG with ACPI_DEBUG_OUTPUT in a few places we missed (Dominik Brodowski)
  o ACPI: Make the ACPI SCI interrupt get the right polarity when it is explicitly overridden in the MADT
  o ACPI: Add support for HPET tables (Andi Kleen)
  o Fix reversed logic in blacklist code (Sergio Monteiro Basto)
  o ACPI: IA64 Improvements (David Mosberger)
  o ACPI: Fix thermal management (Pavel Machek) Make thermal trip points R/W (Pavel Machek) Allow handling negative celsius values (Kochi Takayoshi)
  o ACPI: get ifdefs right in HT_ONLY case
  o ACPI: Fix MADT parsing error (Bjoern A. Zeeb)
  o ACPI: Init thermal driver timer before it is used (Knut Neumann)
  o ACPI: Interpreter update to 200201002
  o ACPI: Eliminate use of TARGET_CPUS from ACPI code
  o ACPI: Interpreter update to 200201022 release
  o ACPI: EC update
  o ACPI: Restore ARB_DIS bit after return from S1
  o ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)
  o ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)
  o ACPI: Remove too-broad blacklist entries
  o ACPI: Use dev->devfn instead of bridge->devfn to determine the pin when trying to derive a device's irq from its parent (Ville Syrjala)
  o ACPI: Add support for GPE1 block defined with no GPE0 block
  o ACPI: Try #2 at fixing the bridge swizzle (Kai Germaschewski)
  o ACPI
  o ACPI: Ensure we con't try to sleep when we shouldn't
  o ACPI: Interpreter update to (20021101)
  o ACPI: Oops, 2.4.x doesn't have in_atomic()
  o ACPI: Turn down debug messages to a tolerable level (Ernst Herzberg)
  o ACPI: Interpreter update to fix mutex wait problem This changes the timeout param around the interpreter to a u16, so that ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to mean "wait forever".
  o ACPI: Correctly init device struct, permissing proper unloading/reloading (John Cagle)
  o ACPI: Interpreter update to 20021111. Add support for SMBus OpRegions
  o ACPI: Handle module unload/reload properly w.r.t. /proc
  o ACPI: Do not compile code for EC unloading, because it cannot be unloaded atm
  o ACPI: fix debug print levels, and use down() instead of down_interruptible(), and some whitespace.
  o ACPI: Interpreter fixes Fixed memory leak in method argument resolution Fixed Index() operator to work properly with a target operand Fixed attempted double delete in the Index() code Code size improvements Improved debug/error messages and levels Fixed a problem with premature deletion of a buffer object
  o ACPI: Add ec_read and ec_write
  o ACPI: Update to 20021122 Fixed a problem with RefOf and named fields Fixed a protection fault involving Packages with Null/nested packages Fixed GPE initialization to handle a pathological case
  o ACPI: Fix IRQ assignment on Tiger (JI Lee)
  o ACPI: Remove incorrect comment
  o ACPI: Interpreter update to 20021205 Prefix more contants with ACPI_ Fixed a problem causing DSDT image corruption Fixed a problem if a method was called in an object declaration Fixed a problem in the string copy routine Broke out some code into new files Eliminate spurious unused variables warning w.r.t. ACPI_MODULE_NAME Remove unneeded file
  o ACPI: Never return a value from the PCI device's Interrupt Line field if it might be bogus -- return 0 instead.
  o ACPI: Fix check of schedule_task()'s return value (Ducrot Bruno)
  o ACPI: Get fid of progress dots if not in debug mode
  o ACPI: update to 20021212
  o ACPI: Fix oops on module insert/remove (Matthew Tippett)
  o ACPI: remove non-Linux revision on files, and make types more Linux-like
  o ACPI: More cosmetic changes to make the code more Linux-like
  o ACPI: Switch from typedefs to explicit "struct" and "union" usage
  o ACPI: Fix for now-dynamic nature of mp_irqs array (Joerg Prante)
  o ACPI: Expose lid state to userspace (Zdenek OGAR Skalak)
  o ACPI: Make button functions static (Pavel Machek)
  o ACPI: Express state of lid in words, not a number
  o ACPI: Eliminate spawning of thread from timer callback. Use schedule_work for all cases. Thanks to Ingo Oeser, Andrew Morton, and Pavel Machek for their wisdom.
  o ACPI: Update version to 20030109
  o ACPI: Fix acpiphp_glue.c for latest ACPI struct changes (Sergio Visinoni)
  o ACPI: Boot functions don't use cmdline, so don't pass it
  o ACPI: S4BIOS support (Ducrot Bruno)
  o ACPI: Move drivers/acpi/include directory to include/acpi
  o ACPI: Handle P_BLK lengths shorter than 6 more gracefully
  o ACPI: Update to 20030122
  o ACPI: Fix accidentally reverted file
  o ACPI: Fix missing declaration for s4bios support
  o ACPI: optimize for size
  o ACPI: Fix compilation on IA64 (Matthew Wilcox)
  o ACPI: Reduce errorlevel of a debug message (Matthew Wilcox)
  o ACPI: Use extended IRQ resource type when setting IRQs on link devices to more than IRQ 15 (Juan Quintela)
  o ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big thanks to John Stultz.
  o ACPI: Factor common code out of an if/else
  o ACPI: *really* fix ISO SCI override support (thanks again to John Stultz)
  o ACPI: update NUMA maintainer email
  o ACPI: change includes of ACPI headers for new location
  o ACPI: Port mochel's makefile improvements
  o ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)
  o ACPI: Support translation attribute (Bjorn Helgaas)
  o ACPI: Add ability to override predefined object values (Ducrot Bruno)
  o ACPI: Decrease size of override's static array, add a define for the length, and print a msg if used
  o ACPI: Fix printk output (Jochen Hein)
  o ACPI: Misc interpreter improvements
  o ACPI: misc sync-ups
  o ACPI: Change license from GPL to dual GPL and BSD-style
  o ACPI: Backport Toshiba driver changes from 2.5 (John Belmonte)
  o ACPI: Do not count processor objects for non-present CPUs
  o ACPI: Revert a change that allowed P_BLK lengths to be 4 or 5. This is causing us to think that some systems support C2 when they really don't.
  o ACPI: Oops, remove 2.5-ism
  o ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)
  o ACPI: Add mem= kernel parameters to allow user to specify reserved and ACPI DATA regions (Pavel Machek)
  o ACPI: Map in entire table before doing the checksum (John Stultz)
  o ACPI: update to 20030228
  o ACPI: Re-enable building w/o CONFIG_PCI (Pavel Machek)
  o ACPI: Fix off by 1 error in C2/3 detection (Ducrot Bruno)
  o ACPI: Interpreter update to 20030321
  o ACPI: Sleep updates (Ducrot Bruno)
  o ACPI: Fix compile warning
  o ACPI: Interpreter update to 20030328
  o ACPI: Interpreter update to 20030418
  o ACPI: Fix link devices on SMP systems (Dan Zink)
  o ACPI: Add missing include
  o ACPI: Update to 20030424
  o ACPI: Allow ":" in OS override string (Ducrot Bruno)
  o ACPI: Interpreter update to 20030509 Changed the subsystem initialization sequence to hold off installation of address space handlers until the hardware has been initialized and the system has entered ACPI mode.  This is because the installation of space handlers can cause _REG methods to be run.  Previously, the _REG methods could potentially be run before ACPI mode was enabled.
  o ACPI: acpi=off also implies drivers should not load (Zdenek Ogar Skalak)
  o ACPI: Update Toshiba driver to 0.15 (John Belmonte)
  o ACPI: Do not reinit ACPI irq entry in ioapic (thanks to Stian Jordet)
  o ACPI: update to 20030522 Found and fixed a reported problem where an AE_NOT_FOUND error occurred occasionally during _BST evaluation.  This turned out to be an Owner ID allocation issue where a called method did not get a new ID assigned to it.  Eventually, (after 64k calls), the Owner ID UINT16 would wraparound so that the ID would be the same as the caller's and the called method would delete the caller's namespace.
  o ACPI: Allow multiple compatible IDS for PnP matching
  o ACPI: Remove extra semicolon (Pavel Machek)
  o ACPI: Trivial name init patch (Bjorn Helgaas)
  o ACPI: Re-add acpitable.c. This makes some people happy I hope, and also (!) cleans up the code a little - a big #ifndef reduction.
  o ACPI: Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)
  o ACPI: Add missing CONFIG_ACPI_HT_ONLY entry to Configure.help
  o ACPI: Don't oops on echo 5 >sleep, but do shut down uncleanly
  o ACPI: ACPI PCI subdriver support (Matthew Wilcox)
  o ACPI: acpiphp update (Takayoshi Kochi)
  o ACPI: Interpreter update to 20030619

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: Final image strip not to strip too much
  o USB: Happ UGCI added as BADPAD for workaround
  o USB Multi-input quirk
  o USB: fix keyboard leds
  o USB: Actually Fix 2.4 HID input

Dave Hollis <dhollis@davehollis.com>:
  o USB: AX8817X Driver for 2.4 Kernels

David Brownell <david-b@pacbell.net>:
  o USB: ehci i/o watchdog
  o USB: SMP ehci-q.c 1010 BUG()
  o USB: EHCI update for 2.4

David Mosberger <davidm@napali.hpl.hp.com>:
  o [TG3]: Workaround 4g DMA bug more portably

David S. Miller <davem@nuts.ninka.net>:
  o [NET]: Use dump_stack() in neigh_destroy()
  o [ATM]: Fix some CPP pasting in ambassador driver
  o [IPV6]: Remove illogical bug check in fib6_del
  o [IPV4]: Use time_{before,after}() and proper jiffies types in route.c
  o [IPV4]: Two minor errors in jiffies changes
  o [IPV4]: Fix expiration test in rt_check_expire
  o [RTNETLINK]: extern __inline__ --> static inline
  o [TCP]: extern __inline__ --> static inline where appropriate
  o [IPV6]: extern __inline__ --> static inline
  o [SUNHME]: Use PCI config space if hm-rev property does not exist
  o [IPV6]: Memory leak found by stanford checker
  o [NET]: In dst_alloc, do not assume layout of atomic_t
  o [IPV4]: Fix fib_hash performance problems with huge route tables
  o [IPV4]: Use get_order instead of reimplementation
  o [NET]: Kill net/README, out of date and duplicates MAINTAINERS file
  o [SPARC64]: RAID_AUTORUN is a compatible ioctl
  o [SPARC64]: Fix sys_shmat handling for 64-bit binaries
  o [IPV6]: Do not invoke icmpv6_send with uninitialized skb->dev
  o [SPARC64]: Merge sysinfo32 corrections from ppc64 port
  o [IPV6]: Fix igmp6_timer_handler forward declaration
  o [NET]: Fix build failure from recent sunrpc changes
  o [NET]: Size hh_cache->hh_data more appropriately

David Woodhouse <dwmw2@infradead.org>:
  o Fix CONFIG_CRC32=m by make crc32.o export its own symbols again in that case
  o Back-port Jocke's CRC32 optimisations from 2.5
  o Fix export of crc32 symbols when CONFIG_CRC32 != y but something pulls it into the kernel image anyway

Geert Uytterhoeven <geert@linux-m68k.org>:
  o [NET]: asm/smp.h --> linux/smp.h in sch_ingress.c
  o USB: Big endian RTL8150

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for Sony DSC-P8
  o USB: attempt to track down pl2303 oopses on close
  o USB: add comment to storage/unusual_devs.h that specifies how to add new entries
  o USB: fix break control for pl2303 driver
  o USB: pegasus ethtool fixup
  o USB: add error reporting functionality to the pl2303 driver
  o USB: fixup aiptek driver for older compilers
  o USB: clean up extra whitespace in visor.c driver

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Fix offset in ICMPV6_HDR_FIELD messages
  o [IPV^]: Use correct icmp6 type in ip6_pkt_discard
  o [MAINTAINERS/CREDITS]: Add entries for USAGI hackers
  o [IPV6]: ARCnet support, driver side
  o [IPV6]: ARCnet support, protocol side
  o [IPV6]: Reworked default router selection

J. A. Magallon <jamagallon@able.es>:
  o Allow aicasm to be built with db4-devel

Jeff Garzik <jgarzik@redhat.com>:
  o [ROSE]: Kill kfree of net_device->name

Johannes Erdfelt <johannes@erdfelt.com>:
  o USB: fix 2.4 usbdevfs race

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed VERSION to .22
  o Delete autogenerated lib/crc32table.h
  o Added missing "-" to EXTRAVERSION

Martin Devera <devik@cdi.cz>:
  o [NET]: Fix jiffies races in net/sched/sch_htb.c

Neil Brown <neilb@cse.unsw.edu.au>:
  o Handle concurrent failure of two drives in raid5
  o Fix bug in /proc/mdstat
  o Fix the check for execute permissions of parent directories in NFSd
  o kNFSd: SVC sockets don't disable Nagle
  o kNFSd: TCP nfsd connection hangs when partial record header is received
  o kNFSd: Make sure an early close on a nfs/tcp connection is handled properly

Olaf Hering <olh@suse.de>:
  o USB: incorrect ethtool -i driver name
  o USB: incorrect ethtool -i driver name

Pam Delaney <pdelaney@lsil.com>:
  o Critical bug fix for fusion driver

Patrick McHardy <kaber@trash.net>:
  o [PPP] fix memory leak in ioctl error path

Paul Mackerras <paulus@samba.org>:
  o [PPP]: Fix PPP Deflate sequence number checking

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus patch

Randy Dunlap <rddunlap@osdl.org>:
  o [NET]: Spelling/typo fixes in rtnetlink.h
  o [IPV6]: Fix typos in ip6_fib.c
  o [IPV6]: Use time_after() etc. for comparing jiffies
  o [NET]: add RFC references for Linux SNMP MIBs
  o [NET]: Typo corrections only

Robert Olsson <robert.olsson@data.slu.se>:
  o [IPV4]: Add rtcache hash lookup statistics to rtstat
  o [IPV4]: In rt_intern_hash, reinit all state vars on branch to "restart"

Stephen C. Tweedie <sct@redhat.com>:
  o Fix O_DIRECT races in 2.4

Vojtech Pavlik <vojtech@suse.cz>:
  o USB: Make Olympus cameras work with usb-storage
  o USB: Fix HID logical min/max for 2.4

