Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTBXT06>; Mon, 24 Feb 2003 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTBXT06>; Mon, 24 Feb 2003 14:26:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267383AbTBXT0o>; Mon, 24 Feb 2003 14:26:44 -0500
Date: Mon, 24 Feb 2003 11:32:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.63
Message-ID: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Nothing really fundamental here - various updates all over 
(architecture updates, networking, usb, acpi, bluetooth, the usual 
suspects).

The task structure reference counting seems to have broken alpha, Richard 
is still chasing that one down.

		Linus

Summary of changes from v2.5.62 to v2.5.63
============================================

<bde@bwlink.com>:
  o [SPARC64]: Fix ocndition code handling in do_rt_sigreturn

<bwa@us.ibm.com>:
  o [SCTP/IPV6]: Move sockaddr storage and in6addr_{any,loopback} to
    generic places

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Add MAINTAINERS entry

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: use sock timestamp
  o [ATM]: Remove cli from lec.c
  o [ATM]: empty tx queue in lec when flush complete the lane spec says
    the following about path switching:
  o [ATM]: prevent compiler warning when compiling w/o bridging

<eike-kernel@sf-tec.de>:
  o typo in 53c700.c

<faikuygur@ttnet.net.tr>:
  o /proc/ide/triflex returns incomplete data

<falk.hueffner@student.uni-tuebingen.de>:
  o [OPROF] Support EV67 ProfileMe

<ishikawa@linux.or.jp>:
  o aic79xx build and lun detect problem fix

<jakub@redhat.com>:
  o [SPARC64]: Fix typo in sparc64_get_context (G7 register is saved
    wrongly)

<louis.zhuang@linux.co.intel.com>:
  o PCI: list code cleanup

<mk@linux-ipv6.org>:
  o [IPSEC]: Add missing credit and include to xfrm_user ipv6 changes

<overby@sgi.com>:
  o [XFS] fix one more set of transaction callback ordering issues,
    this was always there, but exposed by the last change in this area
    and made much more likely.

<pam.delaney@lsil.com>:
  o Fusion Driver 2.05.00.03 against 2.5.62bk3

<shields@msrl.com>:
  o Re: Griffin Powermate: Aluminum

<tinglett@vnet.ibm.com>:
  o need archmrproper
  o 64bit dynamic app fix (still needs binfmt_elf.c patch to work)
  o zImage now holds vmlinux, System.map and config in sections
  o handle RI for GQ processors
  o ignore files for new zImage build
  o Cset exclude: tinglett@vnet.ibm.com|ChangeSet|20030207200510|30566

Adam Belay <ambx1@neo.rr.com>:
  o Preparations and Cleanups
  o This patch contains an improved resource management algorithm.  It
    is capable of resolving nearly any conflict between two or more PnP
    devices.
  o Moves the resource parsing functions to a new location "support.c".
     These resource parsing functions contain many improvements
    including the ability to set resources according to actual value
    rather than dependent functions.
  o Interface Updates
  o ISAPnP Updates
  o PnPBIOS Updates
  o Trivial Card Service Fix
  o Radio-Cadet PnP Update
  o IDE PnP Update
  o Trivial C99 Update
  o PnP Bug Fixes
  o OSS Sound Blaster Update from Paul Laufer
  o Large Stack Usage Fix
  o Resource Management Performance Fix

Adrian Bunk <bunk@fs.tum.de>:
  o remove an unneeded #if from net/ipv6/af_inet6.c

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ide resync
  o add generic ide iops
  o eliminate use of ide_ioreg_t on ARM
  o update ide.c
  o remove old style and unused bad drive list
  o clean up the IDE iops, add ones for a dead iface
  o fix ide_ioreg_t and ifdefs in iops
  o add ide_execute_command but do not use it yet
  o remove ide_ioreg_t
  o ide-probe updates
  o ide-proc - fix crash on identify
  o add new settings locks to ide-proc
  o ide-tape no longer needs this ifdef
  o fix path of file
  o path/ide_ioreg_t fixes for legacy drivers
  o fix int for i/o in pcmcia ide_cs
  o fix the rest of the names/ide_ioreg_t in ide legacy
  o rmeove ide_ioreg_t from PCI ide
  o fix path names and printks in IDE pci
  o add a 'NO_IRQ' definition to IDE
  o exterminate unused io_ops structures and switch to ulong
  o add pio_speed
  o kill more ioregs, add OUTBSYNC
  o resync externs, add execute command remove is_flashcard
  o copy idesync
  o use ide_execute_command for CD
  o add a reminder for vdma on non disk
  o clean up DMA reference, new style ONLYDISK
  o ide-dma, fix bogus inc of waiting_for_dma
  o update ide-floppy for new style onlydisk
  o fix ALi 32bitisms, fix ALi FIFO, fix ALi IRQ crash
  o fix some escaped globals
  o don't force enable generic IDE controllers
  o part fix the highpoint timing/overclock bug
  o clean up siimage, use generic mmio ops
  o update sis driver
  o make the sl82c105 work again
  o ndelay() for x86

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patches for the ECONNRESET error (2.5)

Andi Kleen <ak@muc.de>:
  o x86-64 update for 2.5.62-bk4
  o Fix some 64bit warnings
  o Allow xtime_lock declaration in arch specific code for x86-64
  o [NET]: Make skbuff.h -W clean, skb_headlen should return unsigned
    quantity
  o Fix x86-64 loose ends

Andrew Morton <akpm@digeo.com>:
  o signal warning and uninitialised variable fix
  o MPT Fusion build fix
  o fix for uninitialized timer in drm_drv.h
  o export add_to_page_cache() and __pagevec_lru_add to
  o Move mk_pte_huge() into pgtable.h
  o fix kirq for clustered apic mode
  o Remove MAX_BLKDEV from nfsd
  o Fix warnings for XFS
  o Fix warnings for NTFS
  o allow SMP kernel build without io_apic.c
  o export some functions from i8259.c
  o make startup_32 kernel entry point
  o export boottime gdt descriptor
  o visws: boot changes
  o visws: move header file into asm/arch-visws
  o visws: add missing mach_apic.h file
  o visws: pci support
  o visws: core
  o visws: framebuffer driver update
  o visws: sound update
  o visws: MAINTAINERS file update
  o visws: i386/KConfig update
  o fix a visws compile warning
  o consolidate and cleanup profiling code
  o more ia32 profiler cleanups
  o TTY module refcounting fix
  o remove (start|end)_lazy_tlb()
  o lib/idr.c 64-bit fixes
  o posix-timers: fix callback address truncation
  o Keep interrupts enabled in exit path
  o Don't call mmdrop under a spinlock
  o ppc64: Someone removed NR_syscalls from <linux/sys.h>
  o ppc64: fix the build for posix timer changes
  o pnp compile fix
  o make drivers/pnp/interface.c compile

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o remove BSD_PARTITION

Andy Grover <agrover@groveronline.com>:
  o ACPI: Use extended IRQ resource type when setting IRQs on link
    devices to more than IRQ 15 (Juan Quintela)
  o ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big
    thanks to John Stultz.
  o ACPI: Factor common code out of an if/else
  o ACPI: *really* fix ISO SCI override support (thanks again to John
    Stultz)
  o ACPI: Change NUMA maintainer email
  o ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)
  o ACPI: Support translation attribute (Bjorn Helgaas)
  o ACPI: Add ability to override predefined object values (Ducrot
    Bruno)
  o ACPI: Decrease size of override's static array, add a define for
    the length, and print a msg if used
  o ACPI: Fix printk output (Jochen Hein)
  o ACPI: Misc interpreter improvements
  o ACPI: misc cleanups
  o ACPI: Change license from GPL to dual GPL and BSD-style
  o ACPI: Toshiba ACPI device update (John Belmonte)

Anton Blanchard <anton@samba.org>:
  o ppc64: IPIs must run with interrupts off so tag them with
    SA_INTERRUPT
  o ppc64: fix some -Wundef warnings
  o ppc64: allow pSeries LPAR insert_pte to fail
  o ppc64: fix compile warning
  o ppc64: update for recent changes that require switch_to to return
    prev
  o ppc64: add some bluetooth ioctls and clean up some warnings
  o ppc64: Add posix timer syscalls
  o ppc64: zero all registers in ELF_PLAT_INIT now we dont in
    start_thread
  o ppc64: quieten new boot wrapper to match old 2.5 one
  o ppc64: defconfig update

Art Haas <ahaas@airmail.net>:
  o [IPV4]: Reformat ipv4_route_table
  o C99 initializer for net/ipv6/icmp.c
  o C99 initializer for net/rose/sysctl_net_rose.c
  o C99 initializer for net/netrom/sysctl_net_netrom.c
  o C99 initializer for net/rxrpc/sysctl.c

Brian Gerst <bgerst@didntduck.org>:
  o Use mempool_alloc/free_slab
  o Clean up list head usage in sysrq.c
  o Trival patch to i386 enter_lazy_tlb()
  o Remove checkhelp.pl and header.tk
  o remove old double fault handler
  o Unused variable warning in ac97_codec.c
  o Better test for GCC alignment options
  o Fix up slabinfo code

Christoph Hellwig <hch@lst.de>:
  o further sim710 updates
  o fix wd7000 for scsi command block changes
  o remove cpqioctl.c
  o remove remaining queueing-related code from scsi.c to
  o remove eata_dma driver
  o remove scsi_set_pci_device
  o remove some dead mtrr code
  o handles possible failures in scsi initialization
  o two new device list entries
  o wd7000 updates
  o remove an escaped __MOD_DEC_USE_COUNT
  o eata_pio updates
  o fix that devfs mess
  o drop scsi_register_blocked_host()
  o move over exposing host attributes from sg/procfs to sysfs
  o Coding Style police for scsi_error.c
  o [NET]: Remove __NO_VERSION__ from networking code

Christoph Hellwig <hch@sgi.com>:
  o [XFS] make pagebuf_delwri_queue static
  o [XFS] insert dirty buffers at the tail of the inode queue
  o [XFS] Under heavy load, there are not enough hash buckets to deal
    with the number of metadata buffers. Use the same techniques as the
    regular linux buffer cache here.
  o i2c sanity
  o get rid of some kdevname abuse
  o kill EXPORT_NO_SYMBOLS
  o try_module_get(THIS_MODULE) is bogus
  o fix module refcounting of pcmcia socket drivers

Dave Hansen <haveblue@us.ibm.com>:
  o make io_apic.c use named initializers

David Brownell <david-b@pacbell.net>:
  o USB: sg_complete() warning downgrade
  o USB: USB keyboard works after reboot (ehci-hcd)

David S. Miller <davem@nuts.ninka.net>:
  o [NET]: Fix length in skb_padlen
  o [SPARC]: Add timer_t and clockid_t
  o [SOUND]: ac97_codec.c needs linux/pci.h
  o [SPARC]: Fixup asm/ide.h headers for Alans recent IDE merge
  o [IPSEC]: Move xfrm6 policy code to net/ipv4/xfrm_policy.c
  o [IPSEC]: Export xfrm6 type registry interfaces
  o [IPSEC]: Remove xfrm6 exports from ipv6_syms.c
  o [SPARC64]: oprofile/timer_int.c needs linux/profile.h
  o [SPARC64]: Be like Alpha and turn on -Werror in sparc64
    subdirectories
  o [SPARC64]: Implement STICK synchronization using ia64 port
    algorithms
  o [NETLINK]: Remove buggy and useless rcv queue wakeup tests
  o [BLUETOOTH]: net/bluetooth/bnep/sock.c needs linux/init.h
  o [IPV6]: Cure typo in ipv6_addr_prefix
  o [IPV6]: ipv6_count_addresses is static
  o [IPV{4,6}]: Make icmp_socket per-cpu and simplify locking

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: move Kconfig entries (Marc-Christian Petersen)
  o cpufreq: x86 driver updates (speedstep, longrun, p4-clockmod)
  o pcmcia: add socket_offset for multiple pci_sockets, correct
    suspend&resume

Douglas Gilbert <dougg@torque.net>:
  o aic79xxx_osm.c in 2.5.59-bk3
  o scsi_mid_low_api.txt

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: trivial speedtouch changes
  o USB speedtouch: Fix atmsar memory leak
  o USB speedtouch: fix speedtouch micro race
  o USB speedtouch: Fix speedtouch maxi race
  o USB speedtouch: Update CREDITS and MAINTAINERS
  o USB speedtouch: add help text for speedtouch
  o USB speedtouch: speedtouch 330 support
  o USB speedtouch: minor speedtouch changes
  o USB speedtouch: replace speedtouch crc routines
  o USB speedtouch: speedtouch stability fix fix
  o USB speedtouch: speedtouch cleanups

Duncan Sands <duncan.sands@math.u-psud.fr>:
  o USB speedtouch: Even more trivial speedtouch change
  o USB speedtouch: yet another trivial speedtouch change
  o USB speedtouch: infrastructure for new speedtouch send path
  o USB speedtouch: expose crc defs to speedtouch
  o USB speedtouch: More infrastructure for new speedtouch send path
  o USB speedtouch: on-the-fly AAL5/ATM encoding for speedtouch
  o USB speedtouch: new speedtouch send path
  o USB speedtouch: speedtouch dead code elimination
  o USB speedtouch: Missing speedtouch bits

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Remove unused init_spinlock #define

George Anzinger <george@mvista.com>:
  o POSIX clocks & timers

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: add "present" flag to usb_device structure
  o USB serial: fix locking logic
  o USB: serial core fix to solve ordering issues when destroying our
    objects
  o USB: added sched.h to usb.h
  o USB: usbnet driver also needs the crc32 code
  o PCI: remove large stack usage in pci_do_scan_bus()
  o PCI i386: remove large stack usage in pci_sanity_check()
  o PCI i386: remove large stack usage in pcibios_fixup_peer_bridges()

Greg Ungerer <gerg@snapgear.com>:
  o init sighand in m68knommu init_task
  o add exception table support for m68knommu architecture
  o m68knommu cacheflush.h cleanup
  o fixup use of sighand in m68knommu signal.c
  o bounds check and no argv/envp support for binfmt_flat load
  o add extable.c to Makefile for m68knommu architecture
  o fix m68knommu/ColdFire serial port hang
  o add m68knommu serial console support into tty_io.c
  o add missing m68knommu/68VZ328/ucdimm/config.c
  o reformat m68knommu 68360/uCquicc crt0_rom.S
  o create common vector setup code for m68knommu/ColdFire
  o reformat m68knommu 68328/pilot crt0_rom.S
  o create an architecture specific flat header for v850
  o include the architecture flat file header in common flat header
  o inline unsued functions for MMUless configuration
  o reformat m68knommu 68360/uCquicc crt0_ram.S
  o use local RODATA setup for m68knommu linker script
  o clean up compiler warnings in m68knommu machdep.h
  o remove duplicate memory size option in m68knommu Kconfig
  o fix text and data sizing in MMUless task_nommu.c
  o create an architecture specific flat header for m68knommu
  o add missing page_referenced() for MMUless configs

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [AF_KEY]: Add missing credit
  o [NET]: Convert dst->{input,output}() fully to dst_{input,output}()
  o [IPV6]: Export ip6_route_me_harder for netfilter and add
    ipv6_addr_prefix
  o [IPV6]: Privacy Extensions for Stateless Address Autoconfiguration

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o [IPV4]: rt_cache_stat initialization fix

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o numa fixes

James Bottomley <jejb@raven.il.steeleye.com>:
  o Minor fixes to scsi/sim710.c
  o Add #include <linux/pci.h> to scsi_lib.c (needed for
    PCI_DMA_BUS_IS_PHYS)
  o Add back SCSI subsystem initialisation prints
  o Remove dead code from 53c700
  o Update 53c700 error handling
  o Correct uninitialised timer in scsi_error.c
  o update sim710.c for new eisa sysfs registration returns

James Morris <jmorris@intercode.com.au>:
  o [NET]: Add myself as co-maintainer
  o [NETLINK]: Un-duplicate rcv wakeup logic

Jay Vosburgh <fubar@us.ibm.com>:
  o [BONDING]: Add MAINTAINERS entry

Jeff Garzik <jgarzik@pobox.com>:
  o report luns default

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr 8139too] add to the list of supported boards
  o [netdrvr] Remove superceded wireless driver aironet4500
  o Move the old wireless drivers into drivers/net/wireless

Johannes Erdfelt <johannes@erdfelt.com>:
  o usb_get_driver_np() gives wrong driver name (usb_mouse)

John Levon <levon@movementarian.org>:
  o oprofile author needs to learn C

Keith Owens <kaos@sgi.com>:
  o [XFS] XFS patches from 2.5.60-mm1

Kunihiro Ishiguro <kunihiro@ipinfusion.com>:
  o [IPSEC]: Add ipv6 support to ipsec netlink sockets

Linus Torvalds <torvalds@home.transmeta.com>:
  o Add doublefault handling with a task gate
  o Fix x86 "switch_to()" to properly set the previous task
    information, which is needed to keep track of process usage counts
    correctly and efficiently.
  o Fix "make clean" to remove scripts/elfconfig.h
  o We don't need to wait for task in-activity in release_task() any
    more, since we now properly reference-count the allocations and
    thus can't be freeing the thread structures from underneath the
    task running on another CPU.
  o Fix up incorrect __exit marking for SCSI functions that are called
    from non-exit code.
  o Add support for forcing default signal handlers to
    flush_signal_handlers()
  o Add ndelay() compatibility macro. If the architecture doesn't
    define ndelay(), fall back on udelay().

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Add BCSP TXCRC option to drivers/bluetooth/Kconfig
  o Bluetooth Kconfigs. Cleanup things missed by automatic converter
  o l2cap_do_connect() should be static
  o Fix L2CAP client/server PSM clash
  o Fix hci_get_dev_list() for big endian machines
  o Ordinary users are not allowed to use raw L2CAP sockets
  o BNEP extension headers handling fix
  o Remove duplicated include in HCI H4 driver
  o Convert Bluetooth HCI devices to new module refcounting
  o arch/sparc64/ioctl32.c Put Bluetooth ioctls at the end, right
    before the translation table.
  o Kill old BNEP ioctls
  o [Bluetooth] Cleanup and fix __init and __exit functions.

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Don't do wakeup if protocol is not set
  o [Bluetooth] Fix operator precedence for modem status
  o [Bluetooth] Check for signals while waiting for DLC
  o [Bluetooth] Fix some bits of the modem status handling
  o [Bluetooth] Free skbs with kfree_skb() instead of kfree()
  o [Bluetooth] Add HCI id for Bluetooth PCI cards
  o [Bluetooth] Fix another operator precedence for modem status
  o [Bluetooth] Add HCI UART PC Card driver
  o [Bluetooth] Fix return with a value, in function returning void
  o [Bluetooth] Add the needed call of init_timer()
  o [Bluetooth] Remove EXPORT_NO_SYMBOLS
  o [Bluetooth] Don't use %d notation for non devfs name field of
    tty_driver
  o [Bluetooth] Another cleanup of the Kconfig files
  o [Bluetooth] Convert dlci and channel variables to u8
  o [Bluetooth] Add some COMPATIBLE_IOCTL for SPARC64
  o [Bluetooth] Make READ_VOICE_SETTING available for normal users
  o [Bluetooth] Replace info message about SCO MTU with BT_DBG
  o [Bluetooth] Remove wrong check for size value in rfcomm_wmalloc()
  o [Bluetooth] Disable HCI flow control for vendor commands
  o [Bluetooth] Get rid of hci_send_raw()

Mark W. McClelland <mark@alpha.dyndns.org>:
  o USB: ov511 bugfixes/cleanup

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390: base fixes
  o s390: common i/o layer
  o s390: ctc network driver
  o s390: dasd block device driver
  o s390: documentation
  o s390: unified extable code
  o s390: gcc 3.3 adaptions
  o s390: iucv network driver
  o s390: configuration
  o s390: bogus zfcp header, small scsi change
  o s390: trivial bug fixes
  o s390: kernel module loader
  o s390: 31 bit compatability layer

Matthew Wilcox <willy@debian.org>:
  o Two small fixes for sym53c8xx_2
  o [wireless airo] call pci_enable_device, pci_set_master as needed

Mike Anderson <andmike@us.ibm.com>:
  o fix scsi/ppa.c
  o scsi_error handler update. (1-4)
  o scsi/pcmcia compile fix
  o scsi_error update take 2

Miles Bader <miles@lsi.nec.co.jp>:
  o Handle null OLD argument in nb85e_uart's nb85e_uart_set_termios
    function
  o Fix up some left-over sig->sighand issues on the v850
  o Add v850 version of `init_irq_proc' for sysctl
  o Set child process initial stack-pointers correctly on the v850
  o Remove unused compile-time configuration options on v850
  o Use .balign rather than .align for v850 asm funcs
  o v850 kernel entry fixes and cleanup
  o Implement <asm/bug.h> for v850
  o Add a v850 config option to pass illegal insn traps to the kernel
  o Force v850 interrupt vector parts into their correct locations

Nathan Scott <nathans@sgi.com>:
  o [XFS] Extra check on the mount path - ensure we don't attempt to
    mount XFS fs's with sector sizes smaller than those the device
    supports.  Tripped a BUG in pagebuf, should now be resolved.

Neil Brown <neilb@cse.unsw.edu.au>:
  o Bounds checking for NFSv3 readdirplus
  o Keep track of which page is the 'tail' of an NFSd reply
  o Fix handling of error code in NFSv4 replies
  o Fix problem where knfsd wouldn't release filesystem on unexport
  o Make kNFSd pre/post_[acm]time use struct timespec
  o Convert fs/nfsctl.c to use C99 named initiailzers
  o Fix bug in md superblock sanity checking
  o linear.c fix for gcc bug
  o Small bug fix for multipath
  o C99 initializers for drivers/md/md.c
  o Add name of md device to name of thread managing that device
  o Provide a 'safe-mode' for soft raid

Oliver Neukum <oliver@neukum.name>:
  o USB: added device id for kaweth
  o USB: kaweth fix

Patrick McHardy <kaber@trash.net>:
  o [IPV{4,6}]: lru queue for ip_fragment evictor

Paul Mackerras <paulus@samba.org>:
  o PPC32: add system calls for POSIX timer stuff
  o PPC32: provide __ide_mm_insw etc
  o PPC32: Add definition of ndelay()
  o PPC32: Make switch_to return the previous task in the `last'
    argument

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Kconfig help update
  o [SPARC]: Add rtc_lock

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus update (2.5)

Petri Koistinen <petri.koistinen@iki.fi>:
  o update README file to current realities

Randy Dunlap <randy.dunlap@verizon.net>:
  o USB: cdc-acm memory leak
  o scsi/imm.c compile errors in 2.5.60
  o fix scsi/aha15*.c for 2.5.60
  o convert /proc/io{mem,ports} to seq_file

Richard Henderson <rth@twiddle.net>:
  o [PCI] Correctly size hardwired empty BARs
  o [OPROFILE] First cut at oprofile support for Alpha
  o [ALPHA] Mirror i386 change to include asm-generic/ide_iops.h
  o [ALPHA] Add clockid_t and timer_t for posix clocks
  o [OPROF] Update for change to cpu_type interface
  o [OPROF] Fix arguments to oprofile_add_sample
  o [OPROF] Display banner message on startup
  o [OPROF] Fix alpha/ev6 proc_mode setting
  o [OPROF] Tidy model handle_interrupt handling
  o [ALPHA] Sync with i386 ptrace changes
  o [ALPHA] Implement ndelay
  o [ALPHA] Collection of warning fixes
  o [ALPHA] Turn on -Werror in alpha subdirectories
  o [ALPHA] Use more compiler builtins instead of inline assembly
  o [ALPHA] Fix typo in __kernel_cmpbge
  o [ALPHA] More CFLAGS a-la Sam
  o [ALPHA] Fix switch_to semantics wrt LAST
  o eliminate warnings in generated module files

Rob Radez <rob@osinvestor.com>:
  o [SPARC] Fix compilation of sunsu.c and sunzilog.c

Russell King <rmk@arm.linux.org.uk>:
  o Alternative tty fasync fix
  o kernel/pm.c requires <linux/init.h>
  o Remove dummy cb_config() and cb_release()
  o Remove unused "dev" argument from cb_setup_cis_mem
  o Remove "fn" argument from read_cb_mem()
  o Remove pci_{read,write}[bwl]
  o Remove stack allocation of struct pci_dev
  o Always re-read vendor for each function

Rusty Russell <rusty@rustcorp.com.au>:
  o Enable signals for usermode helpers

Sam Ravnborg <sam@ravnborg.org>:
  o Alpha CFLAGS fix

Sridhar Samudrala <sri@us.ibm.com>:
  o [IPV4/IPV6]: Fix to avoid overriding TCP/UDP with a new protocol of
    same type

Stelian Pop <stelian@popies.net>:
  o sonypi and input subsystem
  o meye suspend/resume capabilities
  o use correct gcc flags when compiling for Crusoe

Stephen Lord <lord@sgi.com>:
  o [XFS] cleanup delayed allocate write path a little and fix some
    small bugs in there.
  o [XFS] fix a couple of memory leaks found by stanford checker

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [COMPAT]: compat_sys_futex sparc64

Steve French <stevef@smfhome1.austin.rr.com>:
  o Remove compiler warnings and allow reconnection of tids after
    temporary tcp session failure

Steve French <stevef@steveft21.ltcsamba>:
  o Fix caching of directory inodes (was always querying server on
    directory inodes).  Reconnect fids (file ids) after session
    reconnection e.g. due to temporary server or network failure
  o Fix freeing of captive thread at unmount time (which  was causing
    unmount warning).
  o Fix search handle leak on search rewind.  Fix setting of uid and
    gid in local inode (not just remote)

Steven Cole <elenstev@mesatop.com>:
  o USB: trivial help texts for drivers/usb/serial/Kconfig
  o spelling fix accessable -> accessible
  o spelling fix adress/addres -> address
  o spelling fix for interupt -> interrupt
  o spelling fix for compatable -> compatible
  o spelling fix for propogate -> propagate
  o various spelling fixes


