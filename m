Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUHCWLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUHCWLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHCWLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:11:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:50581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263806AbUHCWJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:09:14 -0400
Date: Tue, 3 Aug 2004 15:09:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc3
Message-ID: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tons of small fixes all around the tree.

There's an optimized assembly AES implementation for x86 (from Brian 
Gladman), and a number of driver updates, all of which are reasonably 
minor.

It would be good if people only sent serious stuff for a while, and we can 
do a real 2.6.8, ok?

		Linus

-----
Summary of changes from v2.6.8-rc2 to v2.6.8-rc3
============================================

<aegl:agluck-lia64.sc.intel.com>:
  o #   Signed-off-by: Gordon Jin <gordon.jin@intel.com>

<bgerst:quark.didntduck.org>:
  o remove boot98
  o Remove symbol_is()

<gdavis:mvista.com>:
  o kbuild: Allow `make O=<obj> {cscope,tags}` to work

<j.blunck:tu-harburg.de>:
  o ext2_readdir() return value fix

<josha:sgi.com>:
  o ia64: fix obsolete and now misleading comment

<js:convergence.de>:
  o dvb_usercopy() fix

<linville:redhat.com>:
  o [sound/oss i810] add MMIO DSP support
  o [sound/oss i810] misc small changes

<macro:linux-mips.org>:
  o MAINTAINERS update

<master:sectorb.msk.ru>:
  o Fix UNIX98 pty indices leak

<mbp:sourcefrog.net>:
  o lost error code in rescan_partitions
  o trivial doc patch for partitions

<michael.kerrisk:gmx.net>:
  o Off-by-one error for SIGXCPU / RLIMIT_CPU checking

<miklos:szeredi.hu>:
  o fix readahead breakage for sequential after random reads

<nacc:us.ibm.com>:
  o [SPARC]: bbc_envctrl: Replace schedule_timeout() with msleep()
  o [SPARC]: envctrl: Replace schedule_timeout() with msleep()
  o [NET]: Use msleep() in sungem driver
  o macintosh/adb: replace schedule_timeout() with msleep()
  o ide/pmac: replace schedule_timeout() with msleep()
  o macintosh/mediabay: replace schedule_timeout() with msleep()

<rhim:cc.gatech.edu>:
  o Remove dead comment in mm/filemap.c

<roman.fietze:telemotive.de>:
  o clean up n_tty alloc_buf()

<rsa:us.ibm.com>:
  o ppc64: HVCS driver

<samuel.thibault:ens-lyon.org>:
  o front buttons wouldn't mute ESS Maestro

<shrybman:aei.ca>:
  o page_cache_readahead unused variable

<suckfish:ihug.co.nz>:
  o [IPV6]: Trivial fix for ipv6_addr_hash()

<tnt:246tnt-laptop.lan.ayanami.246tnt.com>:
  o [ppc] Add basic support for the Freescale MPC52xx embedded CPU and
    the LITE5200 platform
  o [serial/ppc] Add support for MPC52xx PSCs

Adrian Bunk:
  o [NET]: Update NET_SCH_NETEM Kconfig help text
  o remove outdated reference to Documentation/arm/SA1100/PCMCIA
  o Canonically reference files in Documentation/ code comments part

Alan Cox:
  o DVB major number
  o Subject: PATCH: fix bogus ioctl return in mtrr
  o Fix HPT366 crash and support HPT372N
  o fdomain_cs ISA fix

Alan Hourihane:
  o [AGPGART] Intel I915 support

Alexander Viro:
  o Missing mnt_namespace update in copy_namespace()
  o sparse: simplify and tighten sparse typechecking
  o size_t portability fixes
  o appletalk SIOCADDRT fix
  o rndis fix
  o bluetooth annotations
  o more NULL noise removal in sound/*
  o #if abuse is sound/*
  o tea575 fix
  o check_region fixes
  o dmasound annotation
  o misc sound/* fixes
  o broken stuff in sound/* marked as such in Kconfig
  o security/selinux/hooks.c compile fix
  o openpromfs annotation
  o more NULL noise removal in fs/*
  o bpck6 compile fix on ppc
  o impi annotation
  o mtd fixes
  o NULL noise removal in drivers/net/*
  o #if abuse in drivers/net/*
  o solaris emulation annotated
  o sparc32 emulation annotated
  o NULL noise removal on ppc
  o drm/gamma_old_dma.h fix
  o NULL noise removal in drivers/*
  o CONFIG_MCOUNT fix for sparc64
  o #if abuses in drivers/*
  o annotations for arch/ppc and include/asm-ppc
  o cciss compat ioctl fix
  o zoran switched to seq_file
  o dpt_i2o annotations
  o via-velocity switched use of to if_mii()
  o drivers/macintosh annotations
  o pointer-to-int conversion fixes
  o ffb_context annotation
  o asm-ppc/reg.h namespace pollution fixes
  o missing (void) in reiserfs on big-endian boxen
  o broken stuff marked as such in Kconfig
  o drivers/ieee1394 annotation
  o signed char fixes in drivers/*
  o inline reordering in drivers/*
  o cpumask updates in open_pic.c (ppc)
  o wrong ifdef in ppc/kernel/setup.c (nvram)
  o con_font_op split
  o con_font_default sanitized
  o con_font_copy sanitized
  o con_set_font sanitized
  o fbcon_do_set_font() sanitized
  o con_get_font sanitized
  o console_font_op annotated
  o fb_cursor() fixes
  o cmap annotations
  o inline fixes in net/*
  o annotations in drivers/video
  o sparse: ftape
  o sparse: istallion
  o sparse: stallion
  o sparse: drivers/char/*
  o NULL noise removal in skfp
  o #if abuses
  o ARM initial annotations
  o sparse: more in isdn
  o sparse: more in drivers/net
  o size_t portability fixes
  o signed char portability fix
  o sparse: misc cleanups

Alexey Dobriyan:
  o Fix menuconfig partial inability to show help texts

Andi Kleen:
  o x86-64 fixes
  o [PATCH 1/8] gcc-3.5 fixes
  o [PATCH 2/8] gcc-3.5 fixes
  o [PATCH 3/8] gcc-3.5 fixes
  o [PATCH 4/8] gcc-3.5 fixes
  o [PATCH 5/8] gcc-3.5 fixes
  o [PATCH 6/8] gcc-3.5 fixes
  o [PATCH 7/8] gcc-3.5 fixes
  o [PATCH 8/8] gcc-3.5 fixes
  o Documentation fix for NMI watchdog

Andrea Arcangeli:
  o writepages drops bh on not uptodate page

Andreas Schwab:
  o kbuild: scripts/genksyms/parse.c_shipped needs to be rebuilt

Andrew Chew:
  o [ata] fix reversed bit definitions in linux/ata.h

Andrew Morton:
  o ncpfs: setattr return value fix
  o slab memory shrinking balancing fix
  o oom-killer: call show_free_areas
  o [BRIDGE]: Build fix for gcc-2.95.x

Andy Whitcroft:
  o is_highmem() and WANT_PAGE_VIRTUAL

Anton Blanchard:
  o Fix ppc64 max_pfn issue
  o Fix ppc64 max_pfn issue - again
  o ppc64: exception path optimisations
  o [NET]: Use NET_IP_ALIGN in acenic
  o ppc64: remove multiple IRQ optimisation
  o sched: use for_each_cpu
  o ppc64: fix hotplug irq migration code

Armin Schindler:
  o ISDN Eicon driver: use msleep()

Arnd Bergmann:
  o DVB: "errno" undefined

Art Haas:
  o [SPARC32]: Remove duplicate pci_dma_mapping_error()

Arun Sharma:
  o compat_clock_getres shouldn't return -EFAULT if res == NULL

Bart Samwel:
  o Add documentation about /proc/sys/vm/laptop_mode to various docs

Benjamin Herrenschmidt:
  o ppc64: hash table races fixes
  o ppc64: fix memcpy_to/from_io
  o ppc32: Workaround new MPC745x CPU erratas
  o ppc32: Fix problem with spurrious edge interrupts on old
  o ppc64: Start the FCU in therm_pm72.c

Bert Hubert:
  o [IPSEC]: Fix UDP decap code

Bjorn Helgaas:
  o Fix up HP copyright & license text
  o rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
  o HPET copyrights, cleanup

Brian Gerst:
  o kbuild: Move modpost files to a new subdir scripts/mod
  o remove scripts/mkconfigs

Chas Williams:
  o [ATM]: use try_module_get appropriately (from Stephen Hemminger
    <shemminger@osdl.org>)
  o [ATM]: [lec] remove unnecessary inlines (from Adrian Bunk
    <bunk@fs.tum.de>)

Chris Wright:
  o ethtool_get_regs copy right number of bytes to user

Christoph Hellwig:
  o modular swim3
  o Fix modular anscd

Con Kolivas:
  o [IPV6]: Fix route.c gcc-3.4.x inlining error
  o [IPV6]: Fix gcc-341 inlining for real

Corey Minyard:
  o convert ipmi_watchdog to use module option nowayout

Dave Hansen:
  o ppc64: __make_room() warning fix
  o ppc64: fix off-by-one in mem_init()

Dave Jones:
  o [AGPGART] VIA K8T890 Host Bridge support
  o [AGPGART] VIA VT838x [K8T800/K8M800/K8N800] support
  o [AGPGART] VIA KT880 support
  o [AGPGART] VIA VT83xx/VT87xx/KTxxx/Px8xx support
  o [AGPGART] VIA P4M800 support
  o [AGPGART] Add support for SiS 5591

David Dillow:
  o [SPARC64]: Handle SBUS dma allocations larger than 1MB

David Eger:
  o pmac_zilog: serial minors taken failure path fix

David Gibson:
  o page align emergency stack
  o ppc64: fix RAS irq handlers
  o ppc64: remove #include processor.h from div64.S

David Howells:
  o PPC openpic driver cpumask_t changes

David Mosberger:
  o ia64: Nuke two compiler-warnings
  o NX: allow architectures to select legacy mode dynamically
  o ia64: Clean up arch/ia64/kernel/irq.c a bit
  o ia64: Oops, SN2 needs pending_irq_cpumask to be global
  o ia64: Update defconfig
  o ia64: Update for elf_read_implies_exec() macro changes in mainline
    tree
  o Make get_user_pages() work again for ia64 gate area
  o comment "ptrace_list" and "children" members

David S. Miller:
  o [TG3]: Delay both before and after PCI cfg space readback after
    reset
  o [TG3]: Bump driver version and reldate
  o [SPARC64]: Export __copy_in_user to modules
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix allnoconfig build, based upon a patch from Roland
    Dreier
  o [IPV4]: Make raw sockets behave like udp wrt. MSG_TRUNC
  o [ATM]: Update Marko Kiiskila's email address
  o [TCP]: Do not overflow 16-bit window field in tcp_select_window()
  o [SPARC64]: Uninline _raw_spin_lock too, saves ~30K in defconfig
    image
  o [PKT_SCHED]: Alpha not studly enough for SCH_CLK_CPU
  o Cset exclude: shemminger@osdl.org|ChangeSet|20040722205059|21273
  o [SCTP]: Fix mis-merge
  o Cset exclude:
    davem@nuts.davemloft.net|ChangeSet|20040723204655|22654
  o [SPARC64]: Kill all this silly inline memcpy handling
  o [SPARC]: bbc_envctrl.c needs linux/delay.h
  o [SPARC64]: Simplify and optimize ultra3 memory copies
  o [SPARC64]: Update defconfig
  o [SPARC64]: Do not duplicate compat dirent code
  o [SPARC]: sparc64 openpromio.h needs compiler.h, sync sparc32
  o [NET]: Decrease skb->cb[] to 40 bytes
  o [XFRM]: Declare xfrm6_output in net/xfrm.h
  o [DMA]: Fix example code in DMA-mapping.txt
  o [SPARC64]: Update defconfig
  o [NET]: Kill NET_FASTROUTE, does nothing and suffers from major
    bitrot

David Woodhouse:
  o WindRiver SBC8560: Set all internal IRQs level-triggered
  o Fix UART detection on WindRiver SBC8560
  o Fix UART initialisation on WindRiver SBC8560

Dax Kelson:
  o Config file for laptop mode

Deepak Saxena:
  o [ARM] IXP4xx: platform_add_device() to platform_add_devices()
    conversion
  o [ARM] Export ixp42xx_pci_read/write so PCI driver modules load
  o [ARM] Fix _find_next_bit_be prototype to use 'const' qualifier
  o Watchdog driver for Intel IXP2000 Network Processor

Dominik Brodowski:
  o Asus M2N notebook hides SMBus device

Geert Uytterhoeven:
  o M68k 68060 errata I14
  o M68k ifpsp060
  o m68k sparse missing void
  o m68k sparse #if vs. #ifdef
  o m68k sparse void return
  o m68k sparse extern
  o m68k sparse inline
  o dsp56k sparse const
  o m68k sparse floating point
  o dnfb sparse struct init
  o amifb sparse &=
  o m68k hardirq.h
  o dmasound paths
  o M68k bitops
  o M68k checksum include
  o M68k pgalloc fixup
  o M68k Maintainership
  o depends on PCI: Multi-Tech, SyncLink, Applicom serial
  o !PCI warnings: Moxa serial
  o !PCI warnings: Specialix serial
  o depends on PCI: VIA686A i2c
  o depends on PCI DMA API: IEEE1394 core and SBP-2
  o depends on PCI: Fritz!PCI/PCIv2/PnP and HYSDN
  o !PCI warnings: Hisax ISDN
  o depends on PCI: Guillemot MAXI Radio FM 2000
  o depends on PCI: Technisat Skystar2 PCI
  o depends on PCI DMA API: Cisco/Aironet 34X/35X/4500/4800
  o depends on PCI: Toshiba and VIA FIR
  o depends on PCI: Matrox 1-wire
  o Dallas 1-wire delay.h
  o cirrusfb: update for amiga (zorro)
  o remove faulty __init's from drivers/video/fbmem.c

Greg Edwards:
  o kbuild: build binary rpm from pre-built tree

Guido Guenther:
  o Fix rivafb's NV_ARCH_, cleanup DEBUG, backlight control on ppc

Harald Welte:
  o [NETFILTER]: Fix compilation of ip_nat_snmp_basic.c

Heiko Carstens:
  o s390: zfcp host adapter

Herbert Xu:
  o [CRYPTO]: Fix stack overrun in crypt()
  o [IPSEC]: Fix IPCOMP6 ICMP type check
  o [INET]: Create enum of ECN bits
  o [IPSEC]: Missing unlock in policy timer
  o [AH6]: Disallow mutable bits after AH header
  o [AH4]: Save daddr iff options are present
  o [AH6]: Replace skb by iph in clear_mutable_options
  o [AH6]: Get things working again
  o [NET]: Allow MD5 to be a module
  o [AH6]: Rearrange routing headers
  o [IPSEC]: Move generic encap code into xfrm6_output
  o [IPSEC]: Fix SPI generation by netlink_get_spi()
  o [IPSEC]: Remove redundant check in xfrm_state_add()
  o [IPSEC]: xfrm_alloc_spi always succeeds on non-trivial range
  o [PF_KEY]: spirange should be in host byte order
  o [IPSEC]: Remove unnecessary inet_ecn.h inclusions
  o [IPSEC]: Move xfrm[46]_tunnel_check_size into xfrm[46]_output.c

Hideaki Yoshifuji:
  o [NET] convert storage for MIB from struct member to array item
  o [NET] use SNMP_MIB_ITEM for MIB description
  o [NET] fold long comment lines
  o [NET] use seq_puts() where appropriate
  o [IPV4] Look up route with appropriate protocol when we connect()
  o [IPV6] remove rather pointless comment
  o [IPV6] fix typoes in macro definitions
  o [IPV6] remove unused macro
  o [IPV6] fix the order of icmpv6 definitions for consistency
  o [IPV6] add missing known icmpv6 types

Hirofumi Ogawa:
  o FAT: kill nls default

Hugh Dickins:
  o install_page vs. vmtruncate
  o swapoff mmap_sem deadlock

Ingo Molnar:
  o NX: clean up legacy binary support

Jack Steiner:
  o ia64: Update function prototype for sn_io_addr
  o sched: initialize sched domain table

Jamal Hadi Salim:
  o [PKT_SCHED]: Fix pkt_cls.h incompatabilities

James Morris:
  o [CRYPTO]: Add i586 optimized AES

Jan Topinski:
  o Automatically disable laptop mode when battery almost runs out

Jeff Garzik:
  o [BK] Selectively ignore drivers/video/logo/*.c
  o [BK] Ignore build-generated files Module.symvers,
    drivers/net/wan/wanxlfw.inc

Jens Axboe:
  o BIO page refcounting fix
  o fix cdrom cdda rip single frame dma fall back
  o bio_copy_user() cleanups and fixes

Jesse Barnes:
  o ia64: make madt parsing quieter
  o ia64:  update sn2_defconfig to include new console
  o ia64: sn2 requires a 3.40 or better PROM
  o quieten down per-zone memory stats

Joel Schopp:
  o ppc64: cpu hotplug fix
  o ppc64 SMT bugfix

John Rose:
  o ppc64: struct pci_controller cleanup

Keith Owens:
  o ia64: Extend oem section types for SN mca records

Kenji Kaneshige:
  o ia64: fix bug in irq_affinity_write_proc()

Khalid Aziz:
  o ipmi_msghandler module load failure fix

Kornilios Kourtis:
  o kbuild: Two simple kbuild patches

Kumar Gala:
  o ppc32: reworked cpm alloc functions
  o ppc32: reworked CPM uart driver to work for properly for all CPMs
  o ppc32: Support for MPC8560 CPU and boards
  o ppc32: support for MPC8555 CPU and board
  o ppc32: fix e500 SPE saving of context

Linus Torvalds:
  o Make "install_page()" able to handle truncated pages
  o ppc64: fix more 0/NULL confusion
  o Linux 2.6.8-rc3

Luiz Capitulino:
  o remove dead code from copy_process()

Marcel Holtmann:
  o [Bluetooth] Add support for another ALPS module
  o [Bluetooth] Make use of usb_kill_urb()
  o [Bluetooth] Add missing entry for the HIDP support
  o [Bluetooth] Use a signed integer for the RSSI value
  o [Bluetooth] Replace BCSP retransmitting message with BT_DBG
  o [Bluetooth] Replace schedule_timeout() with msleep()
  o [Bluetooth] Send HCI_Reset for ISSC USB dongles
  o [Bluetooth] Fix resetting to default filters

Margit Schubert-While:
  o prism54 Fix reference to uninitialized pointer
  o prism54 Refix TRDY/RETRY_TIMEOUT
  o prism54 Fix initialization with older firmware
  o prism54 Fix null pointer reference (Bug 100)

Martin Schwidefsky:
  o s390: core changes

Masahide Nakamura:
  o [IPSEC]: xfrm_user code forgets to call xfrm_probe_algs()

Matt Porter:
  o ppc32: Fix PPC44x early uart setup
  o ppc32: export some DMA API symbols

Maximilian Attems:
  o drivers/macintosh/macserial.c MIN/MAX removal

Mika Kukkonen:
  o sign fix in swapfile.c

Mikael Pettersson:
  o [PATCH 1/1]: net/sunrpc/xprt.c gcc341 inlining fix

Miles Bader:
  o v850: Define find_first_bit

Nathan Lynch:
  o fixes for rcu_offline_cpu, rcu_move_batch

Nicolas Kaiser:
  o ppc32: fix comment in arch/ppc/platforms/pmac_pci.c

Olaf Hering:
  o ppc32: snd-powermac requires i2c
  o mark swim3 floppy controller as removable device

Oleg Nesterov:
  o populate nonlinear mappings unconditionally
  o hugetlbfs vm_pgoff bugs

Pat Gefre:
  o sn_console.c

Pat LaVarre:
  o SATAPI despite no data

Patrick McHardy:
  o [PKT_SCHED]: Remove dead timer code
  o [PKT_SCHED]: Use get_cycles() for PSCHED_CPU clock source
  o [PKT_SCHED]: Make clock source configurable
  o [IPV4/IPV6]: Add myself to MAINTAINERS
  o [XFRM]: Wake up km_waitq once per gc-run instead of once per state
  o [NET]: Remove useless variable in rtnetlink_rcv_msg

Paul Mackerras:
  o ppc64: Fix RAS irq handlers
  o ppc64: whitespace cleanup in prom.c
  o ppc64: ISA device tree node refcount fix
  o ppc64: improve SLB reload
  o PPC8xx Maintainer patch

Pavel Machek:
  o radeonfb x86_64 fix
  o swsusp: documentation update

Pawel Sikora:
  o fdomain_cs needs ISA

Robin Holt:
  o bte_error.c

Roland Dreier:
  o Export all functions in lib/string.c
  o MSI: stop using dev->bus->ops directly in msi.c

Russell King:
  o cirrusfb: discarded in section `.exit.text' from drivers/built-in.o

Sam Ravnborg:
  o kbuild: Rebuild .spec file when kernel version changes
  o kbuild: Less intrusive LANG override, fixes menuconfig
  o kbuild: Fix up moving of modpost
  o drivers: move STANDALONE to drivers/base/Kconfig
  o kbuild: Create Makefile in output directory if != kernel tree
  o kbuild: Introduce source symlink in /lib/modules/.../

Samuel Thibault:
  o [UDP]: Return true length if user specifies MSG_TRUNC

Sridhar Samudrala:
  o [SCTP] Set/Get default SCTP_PEER_ADDR_PARAMS for endpoint when
    associd and peer address are 0.
  o [SCTP] Fix data not being delivered to user in SHUTDOWN_SENT state
  o [SCTP] Fix issues with handling stale cookie error over multihoming
    associations.
  o [SCTP] Use idr_get_new_above() with a starting id of 1 to avoid
    returning an associd of 0.
  o [SCTP] Fix missing '+' in the computation of sack chunk size in
    sctp_sm_pull_sack().
  o [SCTP] Mark chunks as ineligible for fast retransmit after they are
    retransmitted. Also mark any chunks that could not be fit in the
    PMTU sized packet as ineligible for fast retransmit.

Srivatsa Vaddagiri:
  o ppc64: Fix cpu_up race

Stephen D. Smalley:
  o selinux: fix clearing of new personality bit on security
    transitions

Stephen Hemminger:
  o [PKT_SCHED]: Make sch_netem classful
  o [PKT_SCHED]: Missing qdisc destroy in sch_netem
  o [PKT_SCHED]: Need delayed packet limit in sch_netem
  o [IPV6]: Missing sparse annotation in addrconf
  o [IPVS]: Convert to module_param
  o [NET]: eql sparse cleanup
  o [PKT_SCHED]: de-inline qdiscipline locking functions
  o [NET]: Kill rtnl_exlock stubs
  o [NET]: Convert ethertap to use module_param
  o [NET]: Convert pktgen to use module_param
  o hlist_for_each_safe cleanup
  o [BRIDGE]: Propagate bridge internal MTU changes
  o [BRIDGE]: dev_xmit cleanup
  o [BRIDGE]: linkstate handling
  o [BRIDGE]: forwarding table RCU
  o [BRIDGE]: RCU fix
  o [NET]: Convert ROSE to use module_param
  o [NET]: Convert netrom to use module_param
  o [TCP]: BIC tcp congestion calculation timestamp

Steve Dickson:
  o nsf4 oops fixes

Steve French:
  o CIFS: Add missing mount option for optionally cifs perm checks when
    uids on server and client do not match and for optionally
    overriding server setting default uid/gid of new cifs files and
    directories.
  o [CIFS] remove unneeded, unused prototypes.  Suggested by Carl
    Spalletta
  o [CIFS] xattr suport part 2: add listxattr support
  o [CIFS] xattr support part 3 add query EA support to retrieve
    individual xattr values
  o [CIFS] xattr support part 4   add set EA support
  o [CIFS] xattr support for cifs filesystem part 5 of 5, add
    removexattr capability
  o [CIFS] Resize cifs request buffer mempools as tcp sessions are
    added to avoid potential deadlocks
  o [CIFS] fix smb return code
  o [CIFS] remove sparse pointer warning
  o [CIFS] Update readme and todo lists for cifs vfs

Stéphane Eranian:
  o ia64: fix perfmon bug that could result in kernel hang
  o fix for buffer limit for long in sysctl.c

Tim Schmielau:
  o Fix BSD accounting cross-platform compatibility

Tom 'spot' Callaway:
  o [SPARC]: Fix copy_user.S with gcc 3.3
  o [SPARC]: Add pci_dma_mapping_error to pci.h

Tom L. Nguyen:
  o MSI: MSI/MSI-X API updates

Tom Rini:
  o PPC32: Typo fix in m8xx serial driver
  o PPC32: Finish support for the EmbeddedPlanet RPX8260 board
  o ppc32: add gcc-3.4+binutils-2.14 check
  o ppc32: fix compilation with binutils-2.15

Tommi Virtanen:
  o [BRIDGE]: Fix typo in br_stp.c

Ursula Braun-Krahl:
  o s390: network driver changes

Willem Riede:
  o MAINTAINERS: update mailing list for osst

William Lee Irwin III:
  o [SPARC32]: Mark William Lee Irwin III as maintainer

Zwane Mwaikambo:
  o Recommend 'noapic' when timer via IOAPIC fails

