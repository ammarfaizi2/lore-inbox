Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLaIhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 03:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLaIhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 03:37:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:24708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262228AbTLaIgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 03:36:52 -0500
Date: Wed, 31 Dec 2003 00:36:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc1
Message-ID: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've merged a lot of pending patches into 2.6.1-rc1, and will now calm 
down for a while again, to make sure that the final 2.6.1 is ok. 

Most of the updates is for stuff that has been in -mm for a long while and 
is stable, along with driver updates (SCSI, network, i2c and USB).

		Linus

----

Summary of changes from v2.6.0 to v2.6.1-rc1
============================================

<alexander:all-2.com>:
  o USB storage: patch for unusual_devs.h

<arief_m_utama:telkomsel.co.id>:
  o psmouse pm resume fix

<berentsen:sent5.uni-duisburg.de>:
  o USB storage: Minolta Dimage S414 usb patch

<dancy:dancysoft.com>:
  o USB: add TIOCMIWAIT support to pl2303 driver

<dhylands:com.rmk.(none)>:
  o [ARM] Fix minor bug in bitwise expression

<elf:com.rmk.(none)>:
  o [ARM] Add ARMv4T cache support for decompressor

<erlend-a:ux.his.no>:
  o [CRYPTO]: Clean up tcrypt module, part 2

<fello:libero.it>:
  o USB storage: patch for Fujifilm EX-20

<jlut:cs.hut.fi>:
  o [IPV6]: Neighbour discovery bypasses netfilter

<jmorris:redhat.com>:
  o [CRYPTO]: Allow tcrypt module to be unloaded

<luca:libero.it>:
  o USB: add W996[87]CF driver

<mail:de.rmk.(none)>:
  o [ARM PATCH] 1718/1: vidc.c: remove vidc_mksound, add external
    reference clock

<marr:flex.com>:
  o Status Query On My MCT-U232 Patch

<rask:sygehus.dk>:
  o aha1740.c: Allow level triggered interrupts to be shared

<stephane.galles:free.fr>:
  o USB storage: patch for Kyocera S5 camera

<tchen:on-go.com>:
  o USB: fix io_edgeport driver alignment issues
  o USB: fix bug when errors happen in ioedgeport driver

<tspat:de.ibm.com>:
  o [COMPAT]: Add support for AIO system calls, with help from Arun
    Sharma (arun.sharma@intel.com)
  o [S390]: Add in compat AIO syscall support

<webvenza:libero.it>:
  o [netdrvr sis900] add suspend/resume support

<woody:org.rmk.(none)>:
  o [ARM PATCH] 1736/1: Here is a working config file: the hard disk,
    ethernet, serial and sound are working OK, no modules
  o [ARM PATCH] 1737/1: GNU assembler 2.12.90.0.1 on Debian aborts on
    "'" character

<_nessuno_:katamail.com>:
  o USB storage: Medion 6047 Digital Camera

Adam Kropelin:
  o USB: Stop hiddev generating empty events

Adrian Bunk:
  o fix some dependencies for TMS380TR=m

Alan Stern:
  o USB storage: Command failure codes for sddr09 driver
  o USB storage: Issue CBI clear_halt and fix BBB residue
  o USB storage: Fix logic error in raw_bulk.c:us_copy_to_sgbuf()
  o USB: khubd optimization
  o USB: Fix khubd synchronization
  o USB storage: Remove unneeded scatter-gather operations in sddr09
  o USB storage: Enhance sddr09 to work with 64 MB SmartMedia cards
  o USB storage: Remove dead code from debug.c
  o USB storage: Fix scatter-gather buffer access in usb-storage core
  o USB storage: Change sddr09 to use the new s-g access routine
  o USB storage: Convert datafab to use the new s-g routines
  o USB storage: Convert jumpshot to use the new s-g routines
  o USB storage: Another utility scatter-gather routine
  o USB storage: Update scatter-gather handling in the isd200 driver
  o USB storage: Update scatter-gather handling in the shuttle-usbat
  o USB storage: Convert sddr55 to use the new s-g routines
  o USB storage: Remove unneeded raw_bulk.[ch] files, change Makefile
  o USB storage: Add comments explaining new s-g usage
  o USB storage: unusual_devs.h entry revision
  o USB storage: Another unusual_devs.h update
  o USB storage: Unusual_devs.h addition
  o USB: Allow configuration #0

Alexander Schulz:
  o [ARM PATCH] 1693/1: Shark: new defconfig

Alexander Viro:
  o [netdrvr] remove manual driver poisoning of net_device
  o [NET]: Fix missing netdev unregister/free in netrom and rose
    protocols
  o [netdrvr bonding] use destructor to properly free net device

Andi Kleen:
  o Fix 64bit warnings in BusLogic driver
  o Mark correct aha152x driver (PCMCIA) as !64BIT
  o Mark aha152x as ISA and !64BIT driver II
  o Mark Ninja SCSI driver as !64BIT

Andrew Morton:
  o Re: Deadlock in 3c574_cs.c (fwd)
  o [netdrvr 8139too] Don't hold the lock across pci_set_power_state()
    - it can sleep
  o unshare_files
  o use new unshare_files helper
  o add steal_locks helper
  o use new steal_locks helper
  o fix unsigned issue with env_end - env_start
  o fix suid leak in /proc
  o make /proc/tty/driver/ S_IRUSR | S_IXUSR for root only
  o futex uninlining
  o ia32 Message Signalled Interrupt support
  o EFI support for ia32
  o compat_ioctl for i2c
  o sqrt() fixes
  o scale the initial value of min_free_kbytes
  o Use __GFP_REPEAT for cdrom buffer
  o make name_to_dev_t __init
  o ext3 scheduling latency fix
  o cmpci.c: remove pointless set_fs()
  o Fix dcache and icache bloat with deep directories
  o NSL config fixes
  o Fix init_i82365 sysfs ordering oops
  o Fix proc_pid_lookup vs exit race
  o Add `gcc -Os' config option
  o Fix sysenter disabling in vm86 mode
  o serial console registration bugfix
  o vmscan: reset refill_counter after refilling the inactive list
  o Be verbose about the ia32 time source
  o Get modpost to work properly with vmlinux in a different directory
  o Restore /proc/pid/maps formatting
  o ia32 WP test cleanup
  o Fix for more than 256 CPUs
  o Use NODES_SHIFT to calculate ZONE_SHIFT
  o optimize ia32 memmove
  o Fix writev atomicity on pipe/fifo
  o lockless semop
  o use alloc_percpu in percpu_counters
  o find_busiest_queue() commentary fix
  o fix SOUND_CMPCI Configure help entry
  o eicon/ and hardware/eicon/ drivers using the same symbols
  o seq_file version of /proc/interrupts
  o Intel 440gx PCI IDs
  o support centrino 1GHz
  o document elevator= parameter
  o missing padding in cpio_mkfile in usr/gen_init_cpio.c
  o watchdog write() return value fixes
  o Minor bug fixes to the compat layer
  o ide-tape update
  o PIIX5 Doesn't work on IA64
  o Can't disable IDE DMA
  o IDE MMIO fix
  o IDE capability elevation fix
  o Add lib/parser.c kernel-doc
  o cpumask.h reorg
  o new /proc/irq cpumask format; consolidate cpumask display and input
    code
  o Add support for SGI's IOC4 chipset
  o Remove CLONE_FILES from init kernel thread creation
  o pagefault accounting fix
  o fix oops in proc_kill_inodes()
  o remove lock_kernel() from proc_bus_pci_lseek()
  o remove include recursion from linux/pagemap.h
  o ext3: bd_claim for journal device
  o dm and bounce buffer panic fix
  o statfs64 fix
  o Add a.out support for x86-64
  o Critical x86-64 IOMMU fixes for 2.6.0
  o Fix CPUID compilation on x86-64
  o Fix sysrq-t on x86-64
  o Fix 32bit truncate on x86-64
  o Add more paranoid checking in x86-64 prefetch checker
  o Merge i386 fix for page fault to x86-64
  o Signal fixes for x86-64
  o Don't panic in mpparse on x86-64
  o Fix 32bit siginfo problems on x86-64
  o remove mm->swap_address
  o sis comparison / assignment operator fix
  o Fix possible oops in vfs_quota_sync()
  o Ext3+quota deadlock fix
  o BINFMT_ELF=m is not an option
  o md: Limit max_sectors on md when merge_bvec_fn defined on
    underlying device
  o md: set ra_pages for raid0/raid5 devices properly
  o Erronous use of tick_usec in do_gettimeofday
  o fix ELF exec with huge bss
  o O_DIRECT memory leak fix
  o JBD: b_committed_data locking fix
  o dvb i2c timeout fix
  o more correct get_compat_timespec interface
  o MAINTAINERS vger.rutgers.edu
  o list_empty_careful() documentation
  o Clear dirty bits etc on compound frees
  o Allow unimap change on non fg console
  o fix outdated comment in jiffies.h
  o slab reclaim accounting fix
  o struct_cpy compilation warning
  o More MODULE_ALIASes
  o nr_slab accounting fix
  o isdn_ppp_ccp.c uses uninitialized spinlock
  o fix userspace compiles with nbd.h
  o DAC960 request queue per disk
  o synchronize use of mm->core_waiters
  o Rename legacy_bus to platform_bus
  o Fix ioctl related warnings in userspace
  o Winbond w83627hf driver
  o update sn2 MAINTAINERS file entry
  o SCC warning fix
  o cycx_drv warning fix
  o VIA audio fixes
  o Kernel Locking Documentation update
  o name_to_dev_t() fix
  o dm: fix block device resizing
  o dm: remove dynamic table resizing
  o dm: make v4 of the ioctl interface the default
  o dm: set io restriction defaults
  o dm: dm_table_event() sleep on spinlock bug
  o ia32 jiffy wrapping fixes
  o fix non-ia32 `make rpm'
  o psmouse warning fix
  o Fix ext3 space accounting bug on ENOSPC
  o dvb: av7110 firmware removal patch
  o dvb: Update saa7146 capture core
  o dvb: Add new dvb bt8xx driver
  o dvb: Update Skystar2 DVB driver
  o dvb: Update DVB core
  o dvb: Update DVB frontend drivers
  o dvb: Update av7110 driver
  o dvb: Add firmware loading support to av7110 driver
  o dvb: Update TTUSB DEC driver
  o dvb: Cleanup patch to remove 2.4 crud
  o dvb: Firmware_class update
  o dvb: Add DVB documentation
  o dvb Kconfig fix
  o Fix SELinux build for "make O=..."
  o Reduce SELinux check on KDSKBENT/SENT ioctls
  o Remove use of nameidata by selinux_inode_permission
  o Add signal state inheritance control to SELinux
  o isdn/eicon/eicon_mod.c build fix
  o Fix X86_GENERICARCH & NUMA compile error
  o Fix Summit EBDA parsing
  o ./README typo fix
  o fatfs: fix printk storm during I/O errors
  o make gconfig warning removal
  o Fix via686a/KX133 TSC failure
  o Fix es7000 compile
  o Fix double logical operator drivers/char/sx.c
  o Put fixmaps into /proc/pid/maps via a pseudo-vma
  o relax check of page/bh state on I/O error
  o init/main.c trivial cleanups
  o FAT: More relax FATFS validity tests (1/10)
  o FAT: Fix the tailing dots on the utf8 path (2/10)
  o FAT: add readv/writev support to FAT (3/10)
  o FAT: trivial printk format fix (4/10)
  o FAT: include/linux/msdos_fs.h cleanup
  o FAT: Fix ->prev_free of fat (6/10)
  o FAT: Add count of clusters check in fat_fill_super() (7/10)
  o FAT: misc cleanups/fixes
  o FAT: empty path by fat_striptail_len returns the -ENOENT
  o FAT: Use just printk() instead of unneeded fat_fs_panic()
  o lib/inflate.c fix
  o Fix memleak on execve failure
  o H8/300 bitops.h update
  o add SpeedStep zero-page usage documentation
  o change two annoying messages from framebuffer drivers
  o ppdev MODULES_ALIAS
  o Small copy-paste typo in floppy.c
  o Fix another dm and bio problem
  o Check for preemption in kunmap_atomic()
  o hugepage pagetable freeing fix
  o SubmittingDrivers update
  o Fix static build of drivers/mtd/chips/jedec_probe.c
  o ALI ircc vendor update (add support for newer chipset) to FIR
    driver
  o Remove iso9660 check for sbsector < 660Mb
  o (workaround): avoid raid1 crash during resync with qlogic
    controllers
  o fix pci_update_resource() / IORESOURCE_UNSET on PPC
  o log_buf_len_setup() irq fix
  o shrink_slab acounts for seeks incorrectly
  o Typo: 2.6.0 docs about kbuild
  o CONFIG_GAMEPORT documentation
  o Fix reiserfs handling of `silent' option
  o reiserfs commit_max_age mount option
  o reiserfs_rename ctime update
  o Fix 2.6.0's broken documentation references
  o readahead: multiple performance fixes
  o parisc /proc/interrupts uninitialised var
  o Fix booting on a number of Motorola PPC32 machines
  o ppc: netboot build fixes
  o PPC32: Fix compilation of ppc_ksyms.c on !CONFIG_PPC_STD_MMU
  o PPC32: Fix the mkprep util to work correctly on Solaris 8
  o dhinds is not 2.6 PCMCIA maintainer
  o fix yenta printk logging levels
  o pcnet_cs driver bug fix / update
  o fix for 16-bit PCMCIA interrupt selection
  o reduce kernel stack usage in PCMCIA CIS parsing
  o strip out PCI cruft from i82365 driver
  o call_usermodehelper retval fix

Arnaldo Carvalho de Melo:
  o [NET]: Uninline {lock,release}_sock()

Arnaud Quette:
  o USB: disable hiddev support for MGE UPS

Arun Sharma:
  o ia64: ia32 sigaltstack() fix

Bart De Schuymer:
  o [BRIDGE]: Add 4 sysctl entries for bridge netfilter behavioral
    control
  o [BRIDGE]: Fix loopback over bridge port
  o [BRIDGE]: Always copy and save the vlan header in bridge-nf

Ben Collins:
  o [SPARC64]: Fix kernel-debug config option dependencies
  o Many files
  o MAINTAINERS
  o video1394.c

Bjorn Helgaas:
  o ia64: Fix PCI root bridge resources to handle prior allocations
  o ia64: Remove extraneous printks (we get the same information from
    ACPI)
  o ia64: Remove unused ACPI functions
  o ia64: Force generic and hp kernels to use 16MB granules
  o ia64: Prevent SAL calls from being preempted

Christoph Hellwig:
  o convert inia100 to new probing API
  o aacraid updates for new probing APIs

Christopher Hoover:
  o [ARM PATCH] 1726/1: Add additional constants  to km_type enum to
    match other platforms
  o [ARM PATCH] 1724/1: Fix name of ttySA0 and ttySA1 under devfs
  o [ARM PATCH] 1720/1: SA-1111 IRQ fix (for OHCI USB HC)

David Brownell:
  o USB: usbcore, better heuristic for choosing configs
  o USB: change cdc-acm to do RX URB processing in a tasklet
  o USB: ohci, fix iso "bad entry" bug + misc
  o USB: usb_hcd_unlink_urb() test for list membership
  o USB: usb driver binding fixes
  o USB: <linux/usb_ch9.h> new descriptor codes, types
  o USB: <linux/usb_gadget.h> doc updates
  o USB: gadget zero updates
  o USB: ethernet gadget supports goku_udc
  o USB: let USB_{PEGASUS,USBNET} depend on NET_ETHERNET

David Dillow:
  o Bug fixes

David Glance:
  o USB: Add Lego USB Infrared Tower driver

David Mosberger:
  o ia64: Fix a bug in sigtramp() which corrupted ar.rnat when
    unwinding across a signal trampoline (in user space).  Reported by
    Laurent Morichetti.
  o ia64: Jim Wilson says that gcc v3.3 also supports marking ar.pfs as
    clobbered, so use ia64_spinlock_contention() for any GCC with v3.3
    or newer.
  o ia64: Switch places for the gate pages and the guard page.  This
    improves backwards-compatibility with older (broken) versions of
    GCC which recognize a signal-handler only if it is in the address
    range from 0xa000000000000100. to 0xa000000000020000.
  o ia64: Based on patch by Jerome Marchand: Add ia64-optimized
    atomic_dec_and_lock().  Actually, this could be the generic version
    for any platform that has cmpxchg().
  o ia64: Fix bug discovered by Bill Nottingham & Jakub Jelinek where
    put_user() arguments with function-calls would cause the macro to
    return unexpected values.  Fixed by avoiding macro argument
    evaluation while r8/r9 are in use for exception-handling purposes. 
    Also, consolidated access-macros so that GCC and Intel compiler use
    90% the same code.
  o ia64: Fix ivt overflow that occurred when turning on
    CONFIG_DISABLE_VHPT.
  o ia64: Fix compiler warning in intrinsics.h
  o ia64: Bring export of spin-lock contention-routines in sync with
    this change:  Jim Wilson says that gcc v3.3 also supports marking
    ar.pfs as clobbered, so use ia64_spinlock_contention() for any GCC
    with v3.3 or newer.
  o ia64: hugepage_free_pgtables() bug-fix

David S. Miller:
  o [SPARC64]: Add in compat AIO syscall support
  o [SPARC64]: Update defconfig
  o [SPARC64]: On Sabre, only access PCI controller config space
    specially
  o Cset exclude: wesolows@foobazco.org|ChangeSet|20031222074047|57357
  o [SPARC64]: Fix build after show_interrupts() changes
  o [SPARC32]: Fix build after show_interrupts() changes

David T. Hollis:
  o USB: ax8817x additional ethtool support in usbnet
  o USB: Mark AX8817x usbnet driver as non-experimental

Deepak Saxena:
  o [ARM PATCH] 1732/1: Fix put_unaligned type in BE mode

Dmitry Torokhov:
  o Fwd: Re: Atmel - possible SKB leak?
  o serio: rename serio_[un]register_slave_port to
    __serio_[un]register_port
  o serio: possible race between port removal and kseriod
  o Add black list to handler<->device matching
  o Synaptics: code cleanup
  o serio: reconnect facility
  o Synaptics: use serio_reconnect
  o Input: unregister i8042 port when writing to control register fails
  o input: fix atkbd_softrepeat
  o Input: add psmouse_proto parameter
  o Input: implement resume methods
  o Input: add atkbd reconnect method
  o Input: psmouse fixes
  o Input: add serio_[un]register_port_delayed to fix deadlock
  o Input: remove synaptics config option
  o Input: synaptics protocol discovery

Douglas Gilbert:
  o scsi_debug lk 2.6.0t6
  o sg Bugfixes

Eric Brower:
  o [SPARC64]: SUNW,lombus device has nonstandard ebus child regs too

Grant Grundler:
  o [libata] use sg_dma_xxx macros

Greg Kroah-Hartman:
  o USB: fix up formatting problems in the legotower driver
  o USB: give legotower driver a real USB minor, and remove unneeded
    ioctl function
  o USB: 64bit fixups for legousbtower driver
  o USB: add support for Protego devices to ftdi_sio driver
  o USB: fix up compiler warning in usblp driver caused by previous
    patches
  o USB storage: remove the raw_bulk.c and raw_bulk.h files as they are
    no longer needed
  o USB: add support for another pl2303 device
  o USB: add support for Sony UX50 device to visor driver
  o I2C: removed #include <linux/i2c.h> from sa1100_stork.c as it's not
    needed

Harald Welte:
  o [NETFILTER]: Sanitize ip_ct_tcp_timeout_close_wait value, from
    2.4.x

Henning Meier-Geinitz:
  o USB scanner driver: new device ids

Herbert Xu:
  o [XFRM]: Handle device down/unregister events
  o [XFRM]: Check whether a dst is still valid before adding it to a
    bundle
  o [SCTP]: Fix sm.h/sctp.h header include loop
  o USB Storage: freecom dvd-rw fx-50 usb-ide patch

Hideaki Yoshifuji:
  o [IPV6]: Fix ipv4 mapped address calculation in udpv6_sendmsg()
  o [NET]: Fix mis-spellings in net/core/neighbour.c
  o [IPV6]: Do not update MTU by invalid value in RA message
  o [NET]: Missing sysctl strategy entries in net/{core,ipv6,appletalk}

Hirofumi Ogawa:
  o [TCP]: Fix OOPS when seeking in /proc/net/tcp

Ingo Molnar:
  o Fix context switch accounting
  o [TCP]: Make tcp_sk() do type checking

Jack Steiner:
  o ia64: prevent buffer-overrun in acpi_numa_memory_affinity_init()
  o ia64: fix ia64_ctx.lock deadlock

Jakub Jelínek:
  o ia64: fix typo in vmlinux.lds.S

James Bottomley:
  o sym 2.1.18f
  o MPT Fusion driver 2.05.00.05 update
  o sg: char_devs + seq_file lk2.6.0t9
  o sg: fix hch/dougg mismerge
  o Fix another sg mismerge
  o SCSI: Fix tmscsim driver
  o [v2] aha152x cmnd->device oops
  o More Initio 9100u fixes
  o Updated osst driver for 2.6.x
  o Update aic79xx to 1.3.11, aic7xxx to 6.2.36
  o Make aic7xxx -Werror conditional on make flag
    WARNINGS_BECOME_ERRORS
  o Megaraid compile fix

Jean Delvare:
  o I2C: Add lm83 chip driver
  o I2C: i2c documentation (1 of 2)
  o I2C: i2c documentation (2 of 2)
  o I2C: Fix i2c-algo-bit for adapers that cannot read SCL back
  o I2C: sysfs interface documentation
  o I2C: make I2C chipset drivers use temp_hyst[1-3]
  o I2C: fix author of i2c-savage4.c driver
  o I2C: add Serverworks CSB6 support to i2c-piix4
  o I2C: add KT600 support to i2c-viapro driver
  o I2C: it87 and via686a alarms
  o I2C: fix i2c-amd8111 driver
  o I2C: restore support for AMD8111 in i2c-amd756 driver
  o I2C: remove bus scan logic from i2c chip drivers
  o I2C: Fix SCx200 dependancies
  o I2C: velleman typo
  o I2C: lm83 driver updates

Jeff Garzik:
  o [libata] Fix PDC20621: we only have one Host DMA engine, not one
    per port
  o [libata] fix use-after-free
  o [netdrvr pcnet32] fix oops on unload
  o [libata promise] Properly initialize DIMM, on SX4
  o [libata] move geometry code to libata-scsi
  o [libata] update new geometry code for 2.6.x specifics not present
    in 2.4
  o [libata promise] fix another ugly bug
  o [libata] some cleanups suggested by Christoph
  o [netdrvr e100] remove __devinit markers, fixing oops

Jeroen Vreeken:
  o [NET]: AX25, netrom, and rose bug fixes for 2.6.0

Jesse Barnes:
  o ia64: make cpu_to_node_map unsigned
  o ia64: update sn2 MAINTAINERS file entry
  o ia64: make NODES_SHIFT a little biggger
  o ia64: initialize bootmem maps in reverse order
  o ia64: sn2 defconfig file

Kai Mäkisara:
  o Add char_devs to st This patch adds support for cdevs to the st
    driver. The changes are based on Doug Gilbert's corresponding
    changes to the sg driver. Using cdevs brings the following
    advantanges:

Kartikey Mahendra Bhatt:
  o [CRYPTO]: Clean up tcrypt module, part 1

Keith M. Wesolowski:
  o [SPARC32]: Add myself as maintainer
  o [SPARC32]: Enable KALLSYMS
  o [SPARC]: Fix serial console selection

Keith Owens:
  o ia64: sync pal/sal/salinfo/mca with 2.4 code
  o ia64: fix deadlock in ia64_mca_cmc_int_caller()
  o ia64: Convert cmc deadlock avoidance patch from 2.4 to 2.6
  o ia64: Avoid double clear of CMC/CPE records

Linus Torvalds:
  o Add support for checking before-the-fact whether an IRQ is already
    registered or not. The x86 PCI layer wants this for its
    availability testing.
  o Release the mmap semaphore in the legacy 80386 "verify_area()" if
    an error happens.
  o Turn off UHCI interrupts at initialization
  o Don't print out I/O error warnings for non-filesystem requests
  o Fix ATA 64-bit divides with CONFIG_LBD
  o Make IDE DRQ and READY timeouts longer
  o Linux 2.6.1-rc1

Mark D. Studebaker:
  o I2C: fix amd756 byte writes

Mark M. Hoffman:
  o I2C: improve chip detection in w83781d.c driver
  o I2C: remove initialization of limits by w83781d driver
  o I2C: remove initialization of limits by lm75 driver
  o I2C: lm75 chip driver conversion routine fixes

Martin Pool:
  o USB storage: add unusual storage device entry for Minolta DiMAGE

Matthew Dharm:
  o USB: don't send any MODE SENSE commands to usb mass storage devices

Matthew Wilcox:
  o PA-RISC update for 2.6.0
  o fix make config help

Michael E. Brown:
  o [libata] fake geometry for partition tables / setups that need such

Mike Christie:
  o [RFC]  fix compile erros in ini9100 driver

Nemosoft Unv.:
  o USB: PWC 8.12 driver update

Nicolas Pitre:
  o [ARM PATCH] 1678/1: correct and better do_div() implementation for
    ARM
  o [ARM PATCH] 1729/1: workaround for PXA timer delay problem

Oliver Neukum:
  o USB: fix error return codes in usblp
  o USB: further cleanup in usblp
  o USB: sleeping problems in cyberjack driver

Patrick Mansfield:
  o consolidate and log scsi command on send and completion

Patrick McHardy:
  o [PKT_SCHED]: Fix module refcount and mem leaks in classful qdiscs
  o [PKT_SCHED]: Remove backlog accounting from TBF, pass limit to
    default inner bfifo qdisc only

Paul Jackson:
  o ia64: fix samp_affinity user-space accesses

Pavlin Radoslavov:
  o [RTNETLINK]: Add RTPROT_XORP

Per Winkvist:
  o USB storage: Make Pentax Optio S4 work

Pete Zaitcev:
  o [SPARC]: When sun4c OOPSes, do not watchdog reset by accident
  o [SPARC]: Get kbd/mouse working again with sunzilog serial
  o USB: fix comment in usblp
  o [SPARC]: Get sun4c functional again in 2.6.0

Peter Chubb:
  o ia64: make perfmon CONFIG_PREEMPT-safe again
  o ia64: enable out-of-tree compilation for IA64

Peter Osterlund:
  o synaptics powerpro fix

Petko Manolov:
  o USB: pegasus driver update

Randy Dunlap:
  o cpqfcTSinit cleanup
  o buslogic: use EH, remove some dup. docs

Russell King:
  o [ARM] Remove unnecessary head-integrator.o object
  o [ARM] Correct flush_user_cache_range comments
  o [ARM] Ensure that /proc/uptime returns sensible figures
  o [ARM] Add new timer/clock/statfs/tgkill/utimes/fadvise syscalls
  o [ARM] Fix a small typo in SA1100 time.h

Stephen Hemminger:
  o [NETFILTER]: Trivial -- Get rid of warnings in netfilter if /proc
    is not configured on
  o [PPPOE]: Add missing MODULE_ALIAS_NETPROTO
  o [ROSE]: Fix use after free in socket destruction
  o [BLUETOOTH]: Put MODULE_ALIAS_NETPROTO for PF_BLUETOOTH in
    af_bluetooth.c
  o [IPV6]: Build fix and dst entry leak in neighbour discovery
  o [AF_PACKET]: Drop SKB route of packets queued to userspace

Tom Rini:
  o [SERIAL] Fix a problem with 8250 UARTs on PPC
  o I2C: make i2c-piix4 fix optional

Tony Luck:
  o ia64: enable recovery from TLB errors
  o ia64: clean up MCA TLB error recovery code

Vojtech Pavlik:
  o Fixes for keyboard 2.4 compatibility

Wim Van Sebroeck:
  o Watchdog update

