Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTGBVW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTGBVW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:22:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264494AbTGBVWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:22:08 -0400
Date: Wed, 2 Jul 2003 14:36:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.74
Message-ID: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updates all over, the patch itself is big largely because of a MIPS/MIPS64
merge (and SH, for that matter).

Network driver updates, USB updates, PnP, SCTP, s390, you name it. See the
changelog for more details.

		Linus

----

Summary of changes from v2.5.73 to v2.5.74
============================================

<felixb:sgi.com>:
  o [XFS] Modified to always pass NULL as data parameter to
    VOP_ATTR_GET(), whenever ATTR_KERNOVAL flag is used. 

Adam Belay:
  o [PNP] pnp_init_resource_table compile fix
  o [PNP] Locking Fixes

Adrian Bunk:
  o PCI Hotplug: fix buggy comparison in cpqphp_pci.c
  o remove an unused variable from fd_mcs.c
  o remove an unused function declaration from sym53c416.h
  o ibmmca cleanup
  o remove an unused function from nsp32.c
  o seagate cleanup
  o NCR53C9x compile fix
  o integer constants in sym53c8xx_2/sym_glue.c too big for int
  o postfix two constants in ips.c with ULL

Alan Cox:
  o [NET]: Add EDP2 ethernet protocol ID

Alan Stern:
  o Fix scsi host attributes
  o USB: Reconcile unusual_devs.h in 2.4 and 2.5

Alex Tsariounov:
  o ia64: cleanup xor build rule to take advantage of lib-m

Andi Kleen:
  o x86-64 merge for 2.5.73
  o Fix ACPI compilation for 2.5.73
  o Change 64bit epoll ABI for AMD64
  o x86-64 merge for 2.5.73-bk9
  o Fix IPC ABI for AMD64
  o Disable a.out for AMD64

Andrew Morton:
  o __devinitdata declarations should not be marked const
  o GCC 2.95.4 needs the spinlock workaround
  o show_stack fix
  o setscheduler needs to force a reschedule
  o misc fixes
  o AT_SECURE auxv entry
  o common name for the kernel DSO
  o get_unmapped_area() speedup
  o dentry->d_count fixes: d_invalidate
  o dentry->d_count fixes: nfs_unlink
  o dentry->d_count fixes: hpfs
  o workaround for smb_proc_getattr oops
  o Column counting fix in n_tty.c
  o normalise node load for NUMA
  o compat_sys_old_getrlimit() depends on
  o ext3: fix page lock vs journal_start ranking bug
  o ext3: fix memory leak
  o correct mail addresses for visws support
  o NCR53C9x compile fix
  o htree: set the dir index bit in the right place
  o export flush_tlb_all for drm modules
  o Typo after 8250_cs update (SERIAL)
  o check for presence of readpage() in the readahead code
  o Fix reiserfs BUG
  o Fix syslog(2) EFAULT reporting
  o Fix ide-cd rw mounts
  o Remove check_region and MOD_*_USE_COUNT from
  o Remove racy check_mem_region() call from arc-rimi.c
  o kmem_cache_destroy() forgets to drain all objects
  o ext3: remove the version number
  o cdrom eject scribbles on the request flags
  o nmclan_cs compile fix

Andries E. Brouwer:
  o loop.c cleanups
  o loop.c - part 2 of N

Anton Blanchard:
  o ppc64: implement any_online_cpu
  o ppc64: Fix sysinfo translation, spotted by Dave Miller
  o ppc64: Convert from K+R to ansi
  o ppc64: small __access_ok optimisation
  o ppc64: remove memset/memcpy function prototypes in eeh header file
  o ppc64: memset destination if access_ok fails in copy_from_user
  o ppc64: pci domain support
  o ppc64: fix some compile warnings
  o ppc64: add dabr and iabr cpu features
  o ppc64: merge Paul's interrupt-map parsing code
  o ppc64: remove ERESTARTNOHAND code in syscall exit, from ppc32
  o remove a bogus check in sym2 driver
  o ppc64: any_online_cpu returns NR_CPUS on fail
  o fix return value after hugetlb mmap failure

Art Haas:
  o [NET] Remove some 0 initializers

Bart De Schuymer:
  o [NETFILTER]: Missing return in arp_packet_match()
  o [NETFILTER]: Add arptables mangle module

Bartlomiej Zolnierkiewicz:
  o do not take ide_setting_sem under ide_lock
  o fix use-after-free in ide_unregister()
  o build fix for pdc4030 without taskfile IO
  o fix compilation of NS SC1x00 driver without procfs
  o call setup_driver_defaults() only once for each driver
  o ide: TCQ initialization fixes
  o ide: fix IRQ handler returns
  o ide: fix drive->unmask handling for taskfile PIO
  o ide: proper allocation of hwif->io_ports resources
  o ide: tiny cleanup of "ideX=ata66" parameter handling in ide_setup()
  o ide: remove dead code from ide_raw_build_sglist()
  o ide: remove dead and broken ide_diag_taskfile() variant
  o ide: tiny cleanup of ide_init(), it is called only _once_
  o Mark taskfile EXPERIMENTAL again

Ben Collins:
  o Update IEEE1394 (r972)
  o Update IEEE1394 (r986)
  o Spelling fix
  o Use KALLSYMS for scripts/kallsyms

Bernardo Innocenti:
  o [IPV4]: Trim the includes used in util.c

Chad Talbott:
  o ia64: early_printk for SGI SN2

Charles Fumuso:
  o [XFS] Close window to prevent a file with delayed write extents
    from being converted to a realtime file.

Chas Williams:
  o [ATM]: Move vccs to global sk-based linked list

Christoph Hellwig:
  o check for can_queue != 0 in scsi_host_alloc
  o add scsi_driver.h
  o use generic dma direction bits in scsi
  o fix an aha1740 merge error

Dan Aloni:
  o avoid Oops in net/core/dev.c

Daniel Ritz:
  o alloc_etherdev for 3c574_cs
  o alloc_etherdev for 3c589_cs
  o alloc_etherdev for fmvj18x_cs
  o alloc_etherdev for nmclan_cs
  o alloc_etherdev for smc91c92_cs
  o module ref counting for airo.c
  o strip.c: don't allocate net_device as part of private struct
  o alloc_etherdev for netwave_cs.c

Dave Jones:
  o [CPUFREQ] speedstep_detect_speed might not reenable interrupts
  o [CPUFREQ] speedstep cleanups
  o [CPUFREQ] Speedstep support for P4M/533 From Dominik Brodowski.
  o [CPUFREQ] Silence debug output on centrino speedstep driver
  o [AGPGART] Add missing pte masking in NVIDIA nForce driver
  o [AGPGART] SiS 655 support

David Brownell:
  o USB: GFDL in the kernel tree

David Dillow:
  o Use a non-zero rx_copybreak to avoid charging a full MTU to the
    socket on tiny packets.
  o Fix misreporting of card type and spurious "already scheduled"
    messages

David Gibson:
  o Fix compile with !CONFIG_VT

David Mosberger:
  o ia64: Drop obsolete ACPI SPCR support
  o ia64: Two more minor cleanups for 2.5.72
  o ia64: Minor cleanups; fix non-SMP build
  o ia64: Simplify the script to use only $CC and $OBJDUMP.  Besides
    being simpler, this also ensure we really do test the linker which
    will be used when building the gate DSO.
  o Kconfig
  o ia64: Fix a alternate-signal-stack bug which could corrupt RNaT
    bits when bspstore happened to point to an RNaT-slot.
  o ia64: More perfmon fixes
  o ia64: Rename init_thread_union to init_task_mem to avoid
    conflicting declration in <linux/sched.h>.
  o Drop pcibios_update_resource() #warning
  o ia64: Rename irq_desc() to irq_descp() to avoid conflict with
    variable
  o ia64: Update defconfig.  Add missing include to <asm-ia64/tlb.h>. 
    Fix compiler warning in perfmon.c.
  o small patch for sym53c8xx_2

David S. Miller:
  o [SPARC64]: Update struct compat_statfs
  o [SPARC64]: Update solaris compat layer for vfs_statfs() changes
  o [SPARC]: Update for show_stack() changes
  o [SPARC]: Add {f,}statfs64 syscall entries
  o [XFS]: Fix build error on big-endian
  o [SEQ_FILE]: Export seq_path() to modules
  o [USB]: Use linux/dma-mapping.h not asm/dma-mapping.h in kaweth.c
  o [PCI]: Export pci_enable_device_bars to modules
  o [SPARC64]: Update defconfig
  o [SERIAL]: Sanitize sparc serial console configuration
  o [SPARC64]: Update defconfig
  o [NET]: Define LL_RESERVED_SPACE in terms of HH_DATA_MOD
  o [TCP]: Sanitize initcwnd calculation, add new metrics
  o [NET]: Kill skb_linearize() and bogus feature flag settings in
    eth1394.c
  o [TCP]: Handle lack of cached dst in tcp_init_cwnd()
  o [TCP]: If we have a lot of time-wait sockets to kill, do it via
    workqueue
  o [NET]: Scale DST/ipv6 intervals like we did for ipv4
  o [SPARC64]: Fix build error from OBP parsing patch
  o [IPV6]: Fix two ipv6_addr_addr failure checks

David Stevens:
  o [IPV{4,6}]: Fix "slow multicast on 2.5.69" bug

David Woodhouse:
  o MTD driver cleanups
  o Replace mtd_blktrans ->ioctl() method with ->getgeo() and ->flush()
  o Trivia: use JFFS2 PAD() macro instead of masking manually
  o Fix jffs2_statfs w.r.t. statfs64
  o Remove superfluous debugging in mtd_blkdevs.c
  o DiskOnChip Millennium Plus translation layer fixes
  o Add missing prototype in drivers/mtd/chips/gen_probe.c

Dominik Brodowski:
  o [PCMCIA] TI1520 cardbus patch for 2.4.x
  o [PCMCIA] ti113x - fall back to PCI interrupt (from 2.4.-ac)

Douglas Gilbert:
  o REQUEST SENSE 254->252 byte response

Eduardo Pereira Habkost:
  o Fix compilation of ip2main

Eric Sandeen:
  o [XFS] Remove test for impossible condition (unsigned 8-bit >= 256)

François Romieu:
  o [netdrvr sk98lin] PCI API conversion, and some cleanups
  o [NETFILTER]: Fix leaks in error paths of ip_recent_ctrl

Glen Overby:
  o [XFS] Remove a use after free which was introduced in the debug
    build.
  o [XFS] Ensure that when we unlock a log item when there is someone
    waiting for log space, we give at least one thread a chance to
    flush metadata and free more log space.

Greg Kroah-Hartman:
  o USB: delete cdc-ether driver as it's no longer needed
  o USB: pl2303: add ability to report CTS and DSR status to userspace
  o I2C: add i2c-ali1535 bus driver
  o USB: add support for 50 baud to io_edgeport.c
  o PCI Hotplug: fix core problem with kobject lifespans
  o IBM PCI Hotplug: fixes found by sparse
  o PCI Hotplug: add fake PCI hotplug driver
  o PCI Hotplug: pcihp_skeleton: fix delete bug and add release()
    callback
  o PCI Hotplug: acpiphp: add release() callback
  o PCI Hotplug: cpci: fix delete bug and add release() callback
  o PCI Hotplug: cpqphp: add release() callback and other minor
    cleanups
  o PCI Hotplug: ibmphp: add release() callback and other minor
    cleanups
  o PCI Hotplug: acpiphp: stupid typo fixes
  o Cset exclude: cweidema@indiana.edu|ChangeSet|20030621162021|08529
  o USB: turn down some debugging messages in uhci-hcd
  o USB: make struct usb_bus a struct class_device
  o USB: move ehci's sysfs files to the class device instead of the pci
    device
  o USB: move ohci's sysfs files to the class device instead of the pci
    device

Greg Ungerer:
  o define KCORE_ELF in m68knommu/Kconfnig
  o fix do_settimeofday() for 'struct timespec' argument
  o fix arguments of show_stack()
  o conditional ROMfs copy for M5206eLITE board
  o conditional ROMfs copy for NETtel/5272 board
  o conditional ROMfs copy for Motorola M5282EVB board
  o fix compile warnings ColdFire PIT timer
  o selection of boot parameters at configure time for Motorola 5307
    targets
  o conditional ROMfs copy for Arnewsh 5307 board
  o rework 68360 interrupt handling code
  o clean up m68knommu bitops.h
  o fix ColdFire 5249 dma support
  o fix broken MARK parity define for ColdFire UART

Harald Welte:
  o `cat msg`
  o [NETFILTER]: Forward port cosmetic fixes from 2.4.x
  o [NETFILTER]: Enhancement for ip{,6}_tables, add new /proc files
  o [NETFILTER]: Fix conntrack master_ct refcounting

Henk Vergonet:
  o I2C: add i2c-prosavage driver

Herbert Xu:
  o [IPSEC]: Add encap_oa member to struct xfrm_encap_tmpl
  o [IPSEC]: Close SADB_ADD race and add XFRM_MSG_UPDSA (SADB_UPDATE
    equivalent)
  o [XFRM] Set port/proto in acquire messages
  o [XFRM] Set SA saddr correctly
  o [IPSEC] split xfrm_state_replace + fixes

Hideaki Yoshifuji:
  o [IPV6]: Clean-up advmss calculation
  o [IPV6] use macro for maximum payload length
  o [IPV6] Fix large packet length check
  o [IPV6] DAD has to be destined to solicited node mulitcast address
  o [IPV6] DAD must not have source link-layer option
  o [IPV6]: Inappropriate static variable in net/ipv6/ndisc.c
  o [IPV6]: Make several ndisc private stuff static
  o [IPV6] Fixed fragment check in ip6_output.c:ip6_fragment()
  o [IPV6] Don't set M flag in last fragment
  o [IPV6] Use macro for M-Flag and clean-up
  o [IPV6] Convert /proc/net/ip6_flowlabel to seq_file
  o [XFRM] Fix typo
  o [IPV6] put ipv6_rcv_saddr_equal() common place
  o [NET] fixed /proc/net/raw{,6} seq_file support
  o [IPV6] Fix bug in /proc/net/ip6_flowlabel seq_file conversion
  o [NET] convert /proc/net/igmp to seq_file
  o [NET] convert /proc/net/igmp6 to seq_file
  o [NET] convert /proc/net/mcfilter to seq_file
  o [NET] convert /proc/net/mfilter6 to seq_file
  o [NET] convert /proc/net/anycast6 to seq_file
  o [IPV6]: One too many ipv6_addr_type() calls in ndisc_recv_ns()

Ivan Kokshaysky:
  o PCI: fix non-hotplug build
  o PCI: fix alpha for reimplement pci proc name
  o [NET]: Need sys_socket cond_syscall() entry
  o [ALPHA] Set HAE-4 for SABLE/LYNX

Jamal Hadi Salim:
  o [NET]: Fix OOPSes with RSVP

James Bottomley:
  o SCSI: abstract mode_sense 6 and 10 out completely
  o scsi_mid_low_api.txt update
  o SCSI 53c700: add module_exit routine otherwise module isn't
    removable
  o Add remove method to lasi700.c
  o SCSI: Add missing scsi/scsi_driver.h file
  o Fix scsi drivers needing to include <linux/pci.h>
  o Remove linux/pci.h dependency in SCSI 53c700
  o Fix SCSI data direction issues in aha1740 merger
  o Fix up data direction in SCSI abstracted mode sense
  o SCSI: Move can_queue == 0 check
  o Eliminate really old ncr53c8xx driver
  o Add NCR Quad 720 SCSI driver
  o Fix logic reversal in scsi_host_alloc
  o move sg_dma_ macros out of asm-i386/pci.h
  o update show_stack() in voyager for new prototype
  o Fix scsi device starvation handling

Jeff Garzik:
  o [irda] add driver for mips Alchemy Au1000 SIR/FIR

Jeff Smith:
  o [NET]: Trivial patch to netfilter Kconfig

Jens Axboe:
  o ide-cd: capability flag for MO drives

Jes Sorensen:
  o ia64: fix static initializers

Jesse Barnes:
  o ia64: bitshift fix
  o ia64: mark_idle() fixes for sn2
  o ia64: hwgfs fix for sn2
  o ia64: PCI fixes for sn2
  o ia64: generic kernel support for sn2
  o ia64: sn2 updates for 2.5.72

Joe Thornber:
  o dm: fix memory leak
  o dm: remove bogus yields

Johannes Erdfelt:
  o USB: fix UHCI debug kmalloc() usage

Jon Grimm:
  o [SCTP] Break out sctp_assoc_valid() from sctp_id2assoc()
  o [SCTP] Change sysctl settable timers to ms granularity
    (rmlayer@us.ibm.com)
  o [SCTP] OOTB Cookie-Echo path does not like stale cookie vtag fix
  o [SCTP] Add ASSOCINFO and RTOINFO sockopts. (Ryan Layer and Anup
    Pemmaiah)
  o [SCTP] Fix wrong logic in hlist change
  o [SCTP] Remove some unused source modules
  o [SCTP] Minor warning cleanups
  o [SCTP] More typedef removals
  o [SCTP] More typedef & name cleanup
  o [SCTP] Shorten SACK generation path
  o [SCTP] Don't search gap ack blocks past max_tsn_seen
  o [SCTP] Peeled off/accepted sockets not in the right bind_bucket

Joy Latten:
  o [IPV6] Make ipsec tunnel work with ext hdrs

Judd Montgomery:
  o USB: add module paramater to visor driver for new devices

Kai Makisara:
  o scsi_ioctl_send_command fix

Kay Sievers:
  o USB: usb-skeleton.c usb_buffer_free() not called

Kevin Cernekee:
  o USB: Desknote/ECS UCR-61S2B card reader (2.5.72 patched)

Linus Torvalds:
  o Remove SGI subdirectory from driver Makefile, since it is now gone.
  o Fix the code that checks for PCI IDE controller "native" vs
    "legacy" modes. 

Lou Langholtz:
  o fix nbd driver for 2.5 block layer

Maciej Soltysiak:
  o [IPV4]: Be more verbose about invalid ICMPs sent to broadcast

Marc Zyngier:
  o aha1740 update
  o [netdrvr de2104x] quiet link timer

Mark Haverkamp:
  o clean up aacraid use of SCSI constants
  o Fix aacraid status returns

Martin Diehl:
  o fix vlsi_ir.c compile if !CONFIG_PROC_FS

Martin Josefsson:
  o fix use-after-free in e100

Martin Schwidefsky:
  o s390: base fixes
  o s390: 31 bit compat
  o s390: common i/o layer
  o s390: dasd driver
  o s390: set module owner
  o s390: typos
  o s390: tty3215_init
  o s390: semtimedop
  o s390: ptrace
  o s390: online attribute
  o s390: processor type
  o s390: thin interrupts
  o s390: qeth network driver

Matthew Dharm:
  o USB storage: unusual_devs.h cleanups
  o USB storage: create associate_dev(), more US_*_DEVICE printout
  o USB storage: avoid sending URBs when disconnecting
  o USB storage: create private I/O buffer
  o USB storage: Cosmetic cleanups
  o USB storage: General purpose I/O buffer allocation and management
  o USB storage: logic cleanup

Matthew Wilcox:
  o PCI: unconfuse arch/i386/pci/Makefile
  o PCI: pci_raw_ops devfn
  o [SERIAL] Missing Kconfig dependencies
  o PCI: [PATCH] pcibios_scan_acpi()
  o PCI documentation
  o PCI: more PCI gubbins
  o PCI: fixes for pci/probe.c
  o remove *_segments() dummy functions again
  o Make SCSI selfcontained
  o PCI: i386/pci/direct.c fixes
  o PCI: create pci_name()
  o [KCONFIG] Make cdrom Kconfig selfcontained

Michael Hunold:
  o update the generic saa7146 driver
  o update dvb subsystem core
  o update the av7110 and budget drivers
  o update dvb frontend drivers
  o add a new driver for the cx24110 frontend
  o add dvb subsystem as a crc32 lib user
  o update analog saa7146 drivers mxb and dpc7146
  o correct the i2c address of saa7111
  o clean up the parts according to the comments on kernel mailing list

Mickaël Grigouze:
  o USB: zaurus SL-C700

Mikael Pettersson:
  o enable local APIC on P4

Nathan Scott:
  o [XFS] Fix an assert in log init code
  o [XFS] V2 log update - tighten checks for corrupt log during
    recovery
  o [XFS] Version 2 log code fixes in recovery
  o [XFS] Turn log head/tail check into an assert - this condition
    should never be true here
  o [XFS] Fix some remaining unaligned access issues on 64 bit
    platforms
  o [XFS] Add in benign missing sector flag to SB version macro
  o [XFS] Fix remount readonly so it really wont write dummy log
    records

Neil Brown:
  o Fix bug in rpc cache_clean introduced by previous patch
  o Always flush rpc caches after an update
  o Include update mode in declaration of RPC information caches
  o Add some tracing when showing the content of an RPC cache
  o Define cache_show methods for export and filehandle cache in nfsd
  o Use schedule_work to regular cache cleaning
  o Fix byte counting for NFSv3 readdir replies
  o Get buf size and page count right for RPC services
  o Use new svc_export_show to implement e_show for
    /proc/fs/nfs/exports
  o Remove path buffer passed around by cache_show routines
  o NFSv4 server OPEN_CONFIRM
  o NFSv4 server Close state
  o NFSv4 server - open-downgrade
  o NFSv4 server  - Read "share" state
  o NFSv4 server - Write "share" state
  o NFSv4 server - setattr share state
  o NFSv4 server - missing locking
  o NFSv4  server - Removed duplicate #define
  o Provoide refrigerator support for nfsd

Oliver Neukum:
  o USB: fix kaweth warnings
  o USB: highdma support for kaweth
  o USB: make kaweth deal with ENOMEM

Patrick Mansfield:
  o fix return value of scsi_device rescan attribute

Paul Mackerras:
  o PPC32: Implement force_successful_syscall_return
  o PPC32: Implement 2-argument show_stack()
  o PPC32: remove check for ERESTARTNOHAND in syscall return path

Paul Mundt:
  o SH Merge

Ralf Bächle:
  o MIPS merge, generic mips bits
  o MIPS merge, generic mips64 bits
  o SGI IP22 bits
  o PCI code
  o 2.7.73 SGI IP27 update
  o Code for Galileo boards
  o Sibyte updates
  o Alchemy update
  o Update for MIPS Inc's eval boards
  o TX49xx update
  o Baget update
  o DEC update
  o NEC DDB update
  o NEC VR41xx update
  o JMR3927 update
  o Update Cobalt support
  o Add support for SGI IP32
  o Momentum update
  o drivers/sgi update
  o ARC update
  o Lasat support
  o Remove Nino support
  o [netdrvr] add driver "meth", for SGI O2 MACE fast eth
  o [netdrvr] sgiseeq update
  o [netdrvr] update ioc3_eth
  o [netdrvr] update declance
  o [netdrvr] au1000_eth update
  o [netdrvr] update sb1250-mac
  o [netdrvr tulip] add mips cobalt support
  o [netdrvr] misc small mips updates

Randy Dunlap:
  o unexpected IO-APIC update
  o Unionize IO-APIC registers
  o remove IO APIC newline

Richard Henderson:
  o [ALPHA] Don't print all interrupts in /proc/stat
  o [ALPHA] Define memset via symbol copy for ev6 as well
  o [ALPHA] No, really fix memset.  Really
  o [ALPHA] Set wall_to_monotonic on timer_init and settimeofday
  o [ALPHA] Eliminate struct declared in prototype warnings in
    asm/elf.h
  o [ALPHA] Fix SETTLS -- read TLS value to install before clobbering
    it

Rob Radez:
  o [SPARC]: Fix LIBS_Y
  o [SPARC]: Do not use __builtin_trap() on sparc until gcc is fixed

Russell King:
  o [SERIAL] Fix 8250 revision width
  o [PCMCIA] Fix ide-cs driver name (for PCMCIA binding)
  o [SERIAL] 8250_cs update - remove serial_info_t
  o [SERIAL] 8250_cs update - remove work queue
  o [SERIAL] 8250_cs update - incorporate pcmcia-cs 3.1.34 serial_cs
    fixes
  o [PCMCIA] Move "owner" field to pcmcia_socket
  o [PCMCIA] Ref-count the socket driver module on card
    insertion/removal
  o [PCMCIA] Remove original module use accounting in register_callback
  o [PCMCIA] Add work-around for bouncy card detect signals
  o [PCMCIA] Allow socket drivers call pcmcia_parse_events directly
  o [PCMCIA] Remove now obsolete work queues, spinlocks and variables

Rusty Russell:
  o Workqueue Exit Neatening
  o {PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_fr.c
  o [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_ppp.c
  o [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_x25.c
  o [PATCH 2.5.72] Use mod_timer in drivers_net_wan_sdla_chdlc.c
  o Trivial patch for scsi_error.c
  o Use Local Percpu Macros for Local Percpu Variables
  o Identify Code Section Of Modules for kallsyms
  o Make runqueues a per-cpu variable

Scott Feldman:
  o Remove CAP_NET_ADMIN check for SIOCETHTOOL's

Simon Evans:
  o pcmciamtd update

Sridhar Samudrala:
  o [SCTP] Fix for incorrect vtag in the stale cookie ERROR chunk

Stephen Frost:
  o [NETFILTER]: Add "recent" iptables facility

Stephen Hemminger:
  o [NET]: PPPoE cleanup [TRIVIAL]
  o [NET]: Fix oops on /proc/net/pppoe
  o [NET]: Convert PPPoE to new style protocol
  o [NET]: Update teql scheduler to dynamic net device
  o 2.5.70 - eepro100 - use alloc_etherdev
  o [NET] remove skb_linearize from igmp.c
  o [NET][IPMR] ipmr fixes
  o [NET]: Fix PPP async regression
  o [BRIDGE]: Ethernet bridge fixes

Stephen Lord:
  o [XFS] optimize the code used to initialize inodes during their
    allocation
  o [XFS] When flushing inodes in to free log space, make the flush
    async rather than delayed write.
  o [XFS] fix sign of error return in mount update and statfs
    operations, mount update could have returned either sign, and
    statfs was  just wrong.
  o [XFS] Update linux directory inode contents after the initial
    mkdir, right now size shows up as zero which is wrong.
  o [XFS] if we remount the fs readonly, there is no need to put
  o [XFS] make doing an iread from a bad location less chatty by
    default as some code paths can actually do this and handle the
    result.
  o [XFS] break dependency between CONFIG_PROCFS and CONFIG_SYSCTL in
    xfs
  o [XFS] SYNC_FSDATA and SYNC_REFCACHE are supposed to be distinct
    values, they ended up the same somehow.
  o [XFS] Move the pagebuf_runall_queues out from under a spinlock, if
    it sleeps (which it might), this is not the right place for it to
    be. There is also no reason for it to be under a spinlock.
  o [XFS] Fix deadlock between xfs_finish_reclaim and xfs_iget_core. An
    inode being reclaimed and removed from memory by one thread while
    another thread is attempting to reuse the inode and bring it back
    to life. There was a window between the iget starting to reuse the
    inode and the reclaim starting. Close the window by marking the
    inode as being reused under the hash lock, and by abandoning the
    reclaim if this is detected when it obtains the hash lock.
  o [XFS] really delete kmem.c
  o [XFS] Remove a dead code path from mount, noticed by Al Viro
  o [XFS] Fix deadlock caused by race between xfs_iunpin marking an
    inode dirty, and the same inode being reallocated and reused by
    create.
  o Fix XFS proc interface initializers

Stephen Rothwell:
  o fix type in compat_sys_fcntl64

Tom 'spot' Callaway:
  o [SPARC64]: Fix OBP version parsing on newer systems

Tony Battersby:
  o make sym53c8xx_2 not reject autosense IWR


