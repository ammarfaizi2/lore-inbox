Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUDTWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUDTWGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbUDTWEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:04:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:53174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264582AbUDTV5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:57:38 -0400
Date: Tue, 20 Apr 2004 14:57:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.6-rc2
Message-ID: <Pine.LNX.4.58.0404201452420.1775@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of the _bulk_ of the rc1->rc2 changes is in the MIPS update, but
there's a number of merges here too, notably some networking, firewire,
irda and bluetooth updates. Oh, and the regularly scheduled network driver
updates too, of course..

The summary gives more of an idea of what changed,

		Linus

----

Summary of changes from v2.6.6-rc1 to v2.6.6-rc2
============================================

Adam Goode:
  o NMI watchdog Pentium M support

Adrian Bunk:
  o fix warning in drivers/net/tulip/timer.c

Alexander Viro:
  o remount: fs/sysv fixes
  o remount: fs/udf fixes
  o remount: fs/openpromfs
  o remount: fs/jffs2
  o remount: forced-ro filesystems
  o remount: forced-nodiratime filesystems
  o remount: mount flags filtering
  o Remove unused 'kobject' from superblock

Andi Kleen:
  o Add mqueue support to x86-64
  o [NET]: Do lazy gettimeofday for network packets
  o [IPV6]: Limit network triggerable printks

Andreas Gruenbacher:
  o [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls
    need it

Andrew Morton:
  o [SCTP]: Fix printk warnings
  o [ATM]: Fix printk warnings in ambassador driver
  o [IRDA]: Fix warnings in sir_dev.c
  o [IRDA]: Fix 32-bit pointer bug in donauboe.c
  o [NET]: Fix printk warnings in wireless/strip.c
  o [NET]: Fix printk warnings in strip driver
  o [NET]: Fix memset args in sk_mca, noticed by Jean Delvare <khali@linux-fr.org>
  o sk_mca multicast fix
  o radix-tree comment fix
  o amd8111e retval fix
  o jbd: journal_dirty_metadata locking speedup
  o set_anon_super locking fix
  o 3c509 oops fix
  o Call SET_NETDEV_DEV() in a bunch of net drivers
  o [ATM]: Warning fix for lec.h
  o [NET]: Fix pc300_drv warnings
  o From: David Gibson <david@gibson.dropbear.id.au>
  o nfs token table can be  __initdata
  o pcnet32.c build fix

Andrey Panin:
  o fix visws build

Anton Blanchard:
  o ppc64: catch branch to 0 in real mode
  o ppc64: always initialise dn->type and dn->name
  o Oprofilefs cant handle > 99 cpus

Arjan van de Ven:
  o [NET]: Add some sparse annotations to network driver stack

Art Haas:
  o [SPARC]: Add C99 initializers to Sparc frame buffer devices

Badari Pulavarty:
  o direct-IO return type fixes

Bart Samwel:
  o Add "commit=0" to reiserfs
  o Fix laptop mode writeback triggered by hdparm -y
  o Fix default value for commit interval for older reiserfs
    filesystems

Bartlomiej Zolnierkiewicz:
  o ide.c: split init_hwif_default() out of init_hwif_data()
  o ide_init_default_hwifs() -> ide_init_default_irq()
  o generic ide_init_hwif_ports()

Ben Collins:
  o [IEEE-1394] Sync IEEE-1394 to r1203
  o [SBP2]: Fix compile for older gcc's
  o [Kconfig]: eth1394 requires INET
  o [SBP2]: Sync revision

Benjamin Herrenschmidt:
  o ppc64: Fix possible duplicate MMU hash entries
  o ppc64: update g5_defconfig
  o ppc64: Fix RTAS races on pSeries
  o ppc64: Fix CPU hot unplug deadlock
  o Fix typo in previous patch
  o ppc/ppc64: Add posix message queue syscalls
  o ppc64: siginfo conversion fix

Bjorn Helgaas:
  o PCI MSI Kconfig consolidation
  o Fix hw_random build on ia64

Brian Buesker:
  o [IPSEC]: Add SPD priority for PF_KEY interface

Chas Williams:
  o [ATM]: get atm_guess_pdu2truesize() right
  o [ATM]: [nicstar] using dev_alloc_skb() (reported by Johnston,

Chris Mason:
  o reiserfs: fsync() speedup
  o reiserfs: remove final sleep_on
  o reiserfs use-after-free fix

Chris Wright:
  o mq_open() and close_on_exec
  o wan sdla:  fix probable security hole
  o remove redundant check in de2104x ->get_regs()
  o e1000: fix probable security hole
  o fix load_elf_binary error path on unshare_files error

Christoph Hellwig:
  o remove duplicated COPYING file in fs/hfs/

Daniel Ritz:
  o missing s/dev->priv/netdev_priv(dev) in drivers/net/pcmcia/

Dave Jones:
  o Fix edd driver dereferencing before pointer checks
  o Fix mprotect bogus check
  o aty128fb dereference before null check

David Gibson:
  o ppc64: hugepage cleanup
  o ppc64: yet another hugepage cleanup
  o Fix bogus get_page() calls in hugepage code

David S. Miller:
  o [TG3]: Just completely delete the disabled FTQ reset code
  o [TG3]: Kill 'force' arg to tg3_phy_reset, it is always set
  o [TG3]: At start of tg3_phy_copper_begin, force phy out of loopback mode
  o [TG3]: Do not allow illegal ethtool advertisement bits
  o [NETFILTER]: Missed these files in nf_log commit
  o [TG3]: Add missing 5704 BX workaround, and fix typo in autoneg fix
  o [TG3]: Set GRC_MISC_CFG prescaler more safely
  o [TG3]: Fix serdes cfg programming on 5704
  o [TG3]: When link is down, set stats coalescing ticks to zero
  o [TG3]: Wait a bit for BMSR/BMCR bits to settle in PHY setup
  o [TG3]: Verify link advertisement correctly on 10/100 only chips
  o [TG3]: All 5705 chips need PHY reset on link-down
  o [TG3]: More PHY programming fixes
  o [TG3]: Bump driver version and reldate
  o [TG3]: Print list of important probed capabilities at driver load
  o [TG3]: Two PHY fixes
  o [TG3]: Kill uninitialized var warning
  o [TG3]: Reset fixes
  o [TG3]: Update driver version and release date
  o [SPARC64]: hugetlbpage.c needs module.h
  o [IPV6]: In ndisc_netdev_event, handle NETDEV_DOWN
  o [ISDN]: Add missing IPPP_FILTER entry to Kconfig
  o [SPARC64]: Control -fomit-frame-pointer using CONFIG_FRAME_POINTER
  o [SPARC64]: Provide _mcount as well as mcount
  o [SPARC64]: Disable -Werror for a bit
  o [E1000]: e1000.h needs dma-mapping.h
  o [IXGB]: ixgb.h needs dma-mapping.h
  o [SPARC64]: Fix branch prediction in switch_to()
  o [BRIDGE]: br_fdb.c needs init.h
  o [IPV6]: Fix esp6.c typo in LIMIT_NETDEBUG changes

David Stevens:
  o [IPV4]: Fix IGMP version number and timer printing for procfs

Deepak Saxena:
  o PCI: Allow arch-specific pci_set_dma_mask and friends

Dely Sy:
  o PCI: Updates for PCI Express hot-plug driver
  o PCI Hotplug: Fix interpretation of 0/1 for MRL in SHPC & PCI-E
    hot-plug

Don Fry:
  o pcnet32 transmit performance fix
  o pcnet32.c add support for 79C976

Eric Brower:
  o [SPARC]: Add sysctl to control serial console power-off
    restrictions

Geert Uytterhoeven:
  o Amiga Zorro8390 Ethernet section conflict
  o ipmi build fix
  o Amiga A2065 Ethernet debug
  o Amiga Ariadne Ethernet KERN_*
  o Amiga Hydra Ethernet KERN_*
  o Amiga Zorro8390 Ethernet KERN_*

Greg Kroah-Hartman:
  o Driver Core: fix spaces instead of tabs problem in the Kconfig file
  o add sysfs support for vc devices
  o VC: fix bug in vty_init() where vcs_init() was not called early
    enough
  o Driver class: remove possible oops
  o PCI: add ability to access pci extended config space for PCI
    Express devices
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20040323051558|61282

Hanna V. Linder:
  o QIC-02 tape drive hookup to classes in sysfs
  o add class support to floppy tape driver zftape-init.c
  o added class support to stallion.c
  o added class support to istallion.c
  o add class support to dsp56k.c
  o Add sysfs class support to fs/coda/psdev.c
  o fix sysfs class support to fs/coda/psdev.c
  o Fix for patch to add class support to stallion.c
  o Fix class support to istallion.c

Harald Welte:
  o [NETFILTER]: Optimization of ip_conntrack_proto_tcp:tcp_packet()
  o [NETFILTER]: Locking optimization in ip_conntrack_core
  o [NETFILTER]: Cleanup conntrack helper API
  o [NETFILTER]: Add nf_log handler, from Jozsef Kadlecsik
  o [NETFILTER]: Add 'raw' table, from Jozsef Kadlecsik
  o [NETFILTER]: Add more debug info to TFTP helper

Herbert Xu:
  o [IPV6]: Prevent IPV6=m and IP6_NF_QUEUE=y

Hideaki Yoshifuji:
  o [IPV6]: Mark MLDv2 report as known
  o [IPV6]: Use IANA icmpv6 type for MLDv2 report

Hugh Dickins:
  o Fix vma corruption
  o rmap: flush_dcache revisited
  o rmap: swap_unplug page
  o rmap: nonlinear truncation
  o fix madvise(MADV_DONTNEED) for nonlinear vmas

J. Bruce Fields:
  o kNFSdv4: nfsd4_readdir fixes
  o kNFSdv4: Fix bad error returm from svcauth_gss_accept
  o kNFSdv4: Keep state to allow replays for 'close' to work
  o kNFSdv4: Allow locku replays aswell
  o kNFSdv4: Improve how locking copes with replays
  o kNFSdv4: Set credentials properly when puutrootfh is used
  o kNFSdv4: Implement server-side reboot recovery (mostly)

Jakub Jelínek:
  o Fix mq_notify with SIGEV_NONE notification
  o Fix mq 32-bit compatibility
  o [SPARC]: Add MQ syscall support

Jamal Hadi Salim:
  o [NET_SCHED]: Check for NULL opt in dsmark_init

James Bottomley:
  o fix 4k irqstacks on x86 (and add voyager support)
  o fix non-PC subarchs which were broken by i386 probe_roms change

Jan Kara:
  o ext3: journalled quotas

Jason Wever:
  o [SOUND]: Proper deps for SND_BIT32_EMUL
  o [SOUND]: Add amd7930 to sndmagic.h

Javier Achirica:
  o airo: Fix suspend support

Jean Tourrilhes:
  o [IRDA]: Move IRDA device headers to more appropriate place
  o [IRDA]: Convert vlsi_ir /proc/driver to seq_file
  o [IRDA]: Fix handling of RD:RSP to be spec compliant
  o [IRDA]: Get rid of local CRC table in donauboe
  o [IRDA]: Fix namespace pollution of print_ret_code
  o [IRDA]: Rename handle_filter_request to irlan_filter_request
  o [IRDA]: irlan_common cleanup
  o [IRDA]: irlan_eth cleanup
  o [IRDA]: Replace sleep_on with wait_event

Jeff Garzik:
  o Remove mention of non-existent tulip.txt from Doc/netwrk/00-INDEX
  o [BK] ignore build-generated files in scripts/basic/ and drivers/md/
  o [MAINTAINERS] remove mention of defunct linux-via mailing list
  o [net/fc iph5526] s/rx_dropped/tx_dropped/ in TX routines
  o [NET] define HAVE_NETDEV_PRIV back-compat hook
  o [netdrvr natsemi] correct DP83816 IntrHoldoff register offset
  o [libata] abstract SCSI->ATA translation a bit
  o [libata] move some PIO state init to its proper place
  o [libata sata_promise] fix taskfile delivery cases
  o [netdrvr via-rhine] Fix MII phy scanning
  o kill submit_{bh,bio} return value
  o remove buffer_error()
  o [wireless orinoco] Remove bogus !dev check
  o [hamradio baycom] Remove bogus check in interrupt handler
  o [netdrvr rcpci] Remove bogus check in ->remove handler
  o [netdrvr r8169] remove driver-local DMA_xxBIT_MASK definitions

Jens Axboe:
  o Fix CFQ elevator problem

Jim Houston:
  o idr.c: extra features enhancements

John Rose:
  o PCI Hotplug: RPA PCI Hotplug - redundant free

Jon Oberheide:
  o [CRYPTO]: ARC4 Kconfig clarification

Karsten Keil:
  o [ISDN]: Fix kernel PPP/IPPP active/passiv filter code

Kevin Corry:
  o dm: Fix 64/32 bit ioctl problems
  o dm: Check the uptodate flag in sub-bios to see if there was an
    error
  o dm: Handle interrupts within suspend
  o dm: Use wake_up() rather than wake_up_interruptible()
  o dm: Log an error if the target has unknown target type, or zero
    length
  o dm: Correctly align the dm_target_spec structures during
    retrieve_status()
  o dm: fix a comment
  o dm: avoid ioctl buffer overrun
  o dm: Use an EMIT macro in the status function

Khawar Chaudhry:
  o Update amd8111 net driver

Linda Xie:
  o kobject_set_name() doesn't allocate enough space
  o PCI Hotplug: php_phy_location.patch

Linus Torvalds:
  o Make sock_no_{get|set}opt() use the proper __user annotation
  o Add sparse __safe annotation
  o Allow non-LFS sendfile to work on LFS files
  o Fix permission problem on include/video/neomagic.h
  o Remove unnecessary declaration of inline functions
  o Linux 2.6.6-rc2

Luca Tettamanti:
  o Sysfs for framebuffer

Luiz Capitulino:
  o com20020-isa.c warning fix

Manfred Spraul:
  o [NETLINK]: Split up netlink_unicast
  o mqueue permission fix

Manfred Weihs:
  o IEEE1394/Lynx(r1182): Explicitly set LCtrl bit in phy register set

Marcel Holtmann:
  o [Bluetooth] Remove architecture specific compat ioctl's
  o [Bluetooth] Fix broken HCI security filter
  o [Bluetooth] Allocate hdev before device configuration
  o [Bluetooth] Add UART protocol id's for 3-Wire and H4DS
  o [Bluetooth] Allocate the BCM203x URB buffer seperately
  o [Bluetooth] Fix URB unlink race in the USB drivers
  o [Bluetooth] Make use of request_firmware() for the 3Com driver
  o [Bluetooth] Improve NULL pointer handling
  o [Bluetooth] Add support for Anycom CF-300
  o [Bluetooth] Allow normal users to release the previous created TTY
  o [Bluetooth] Fix race in RX complete routine of the USB drivers
  o Add sysfs class support for CAPI
  o Fix sysfs class support for CAPI
  o Fix typo in the openpromfs remount patch

Martin Schwidefsky:
  o light-weight auditing framework for s390
  o posix messages queues for s390

Masahide NAKAMURA:
  o [IPV6]: Fix IPSEC AH typo

Matt Mackall:
  o netpoll early ARP handling
  o netpoll transmit busy bugfix

Matthew Wilcox:
  o PCI Hotplug: Don't up() twice in acpiphp
  o PCI Hotplug: Rewrite acpiphp detect_used_resource

Meelis Roos:
  o [SPARC64]: Fix binfmt_elf32.c warning by redefining TASK_SIZE
  o ide-probe.c: SanDisk is flash

Michael Chan:
  o [TG3]: Jumbo frames and FTQ reset patch

Michal Ludvig:
  o [AF_KEY]: pfkey_send_new_mapping marks dest address incorrectly

Michal Schmidt:
  o USB: Fix vicam debug compile, fix user access

Nathan Lynch:
  o Increase number of dynamic inodes in procfs

Nick Piggin:
  o CPU_MASK_ALL fix

Nigel Cunningham:
  o Rename PF_IOTHREAD to PF_NOFREEZE

Noriaki Takamiya:
  o [IPV6]: Fix OOPS in udp6 with extension headers using ancillary
    data

Olaf Hering:
  o mace register_netdev printk

Paul Gortmaker:
  o [netdrvr 8390] Fix 8390 log spam

Pavel Roskin:
  o [PCMCIA] Conversion to module_param
  o Tulip endianess fix
  o Warn if module_param and MODULE_PARM mixed

Pedro Emanuel M. D. Pinto:
  o hlist_add_after() fix

Petr Vandrovec:
  o Fix exec in multithreaded application

Ralf Bächle:
  o MIPS: don't offer SERIAL_DZ on 64-bit DEC
  o MIPS: update documentation files
  o MIPS update

Randy Dunlap:
  o PCI: add DMA_{64,32}BIT constants
  o PCI: move DMA_nnBIT_MASK to linux/dma-mapping.h
  o [NET]: Update networking config menu (v3)
  o [NET]: Kill __FUNCTION__ string literal concatenation
  o floppy98.c build fixes

Roland McGrath:
  o fix for potential deadlock after posix-timers change

Romain Liévin:
  o tipar char driver (divide by zero)

Russell King:
  o etherh updates
  o [ARM] Add --no-undefined to linker command line
  o [ARM] Remove needless export of __do_softirq()
  o [ARM] Update mach-types file
  o [ARM] Add __user address space identifiers for sparse
  o [SERIAL] Remove check_region()
  o [SERIAL] Use module_param/module_param_array
  o [ARM] Add detailed documentation concerning ARM page tables
  o [ARM] Clean up ARM includes
  o fix arm/etherh.c

Rusty Russell:
  o Fix unix module
  o Print warning for common symbols in modules

Scott Feldman:
  o Update MAINTAINERS with new e100/e1000/ixgb maintainers

Shirley Ma:
  o [IPV6]: Add MIBs counters in MLD
  o [IPV6]: Provide ipv6 multicast/anycast addresses through netlink
  o [IPV6]: Add missing MIB counter increments

Sridhar Samudrala:
  o [SCTP] Fix typo in entry name of the remove_proc_entry() call
  o [SCTP] Update sctp_ulpevent structure to include assoc pointer and
  o [SCTP] Use id to ptr translation service in lib/idr.c to assign and
    validate ids of associations.

Stephen Hemminger:
  o [NET]: Mark lock_sock and release_sock as FASTCALL
  o [BRIDGE]: Allow non-root to inspect the status of a bridge
  o [BRIDGE]: Lift ioctl limits on number of bridges/ports
  o [BRIDGE]: Correctly handle up to 256 ports per bridge
  o [NET]: Use const args in eth_copy_and_sum and is_valid_ether_addr
  o [NET]: Add random_ether_addr to ether_device.h
  o [NET]: Use random address in dummy driver
  o [NET]: Use random address in usb gadget driver
  o [NET]: Use random address in usbnet driver
  o [BRIDGE]: Include file cleanup
  o [BRIDGE]: Fix rmmod race
  o [BRIDGE]: Make use of jiffies_to_clock
  o [BRIDGE]: Use ethtool to get port speed
  o [BRIDGE]: Multicast address as const
  o [BRIDGE]: Forwarding database changes
  o [BRIDGE]: STP unsigned fields
  o [BRIDGE]: Support lots of 1k ports
  o [BRIDGE]: FDB cache alloc
  o [BRIDGE]: Replace CLEAR_BITMAP with memset
  o [NET]: Fix lapbether bad scheduling while atomic
  o Mixed PCI/ISA device name conflicts
  o remove 8139too ring size option

Steve Kinneberg:
  o [IEEE1394/OHCI]: Deal with some OHCI implementations that have an
    invalid max_rec field

William Lee Irwin III:
  o ARM-related ptep_to_address() fix
  o h8300 stack bounds checking
  o m68k stack bounds checking
  o m68knommu stack bounds checking
  o ppc32 stack bounds checking
  o sparc32 stack bounds checking

