Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSKDXHe>; Mon, 4 Nov 2002 18:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSKDXHe>; Mon, 4 Nov 2002 18:07:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14608 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262877AbSKDXH2>; Mon, 4 Nov 2002 18:07:28 -0500
Date: Mon, 4 Nov 2002 15:13:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.46
Message-ID: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, our dear master.kernel.org seems to be back from the dead, which means 
that I can punish it some more and upload stuff to it again. 

2.5.46 merges some more stuff (yeah, I still have stuff in my mailbox, but
I'm calmer now that I don't forsee any more huge issues), and is pretty
much all over the map. Merges with Alan, Al and Andrew, and m68k stuff
from Geert. Sysfs from Pat, and ext2/3 updates from Ted.

		Linus

----

Summary of changes from v2.5.45 to v2.5.46
============================================

Adam Radford <adam@nmt.edu>:
  o 3ware driver update for 2.5.46, sync cache, 64-bit, etc

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Alpha escaped pcibios
  o kill debug printk we dont need now
  o kill pcibios in m6k8
  o kill pcibios in m68k pci code
  o 32/64bit device mapper ioctl maps for mips64
  o kill pcibios in ppc32
  o device mapper ioctls for ppc64
  o device mapper 64/32bit ioctl maps for S/390x
  o fix warnings
  o add voyager specific extra key map
  o use longer delays on 3c509
  o warning fixes
  o kill stupid search and destroy error
  o without this tulip doesn't build non modular
  o move de4x5 to new pci api
  o fix filters types on winbond 840
  o remove more tqueue.h
  o eata update from maintainer
  o restore inia100.h abort/reset
  o restore missing error handlers for ncr53c8xx
  o ditto error handling for qla1280
  o ditto for sym53c8xx
  o update the u14-34f driver to maintainer updates
  o make afs build with gcc 2.9x
  o add includes for voyager interrupt chip
  o header update to match m68k pci change
  o update MAINTAINERS
  o make rxrpc build with gcc 2.x
  o some trident needs longer delays to power up codecs
  o fix i810 printk error
  o MAINTAINERS entries for UcLinux platforms
  o UCLinux generic memory mapped MTD driver
  o UCLINUX ethernet driver for 68360 on board ethernet
  o Kconfig and makfile goo for new net drivers
  o UCLINUX ethernet driver for Coldfire onboard 100Mbit ethernet
  o arch specific files for MMUless NEC v850 port
  o add machine ident for the V850 from NEC
  o UCLINUX "flat" binary loader
  o UCLINUX (forgot one) - header file for binfmt_flat
  o 2.5.45 UCLinux merge M680x0 mmuless arch and include/asm

Alexander Viro <viro@math.psu.edu>:
  o fix 2.5.45 initrd breakage
  o tape_name() in osst.c
  o tape_name() in st.c
  o file->private_data in st.c and osst.c
  o osst template
  o st template
  o sr template
  o sd template
  o sg template
  o scsi_get_request_dev() cleanup
  o >rq_dev in aacraid
  o generic uses of ->rq_dev
  o uses of ->rq_dev in printks
  o remaining uses of ->rq_dev
  o death of ->rq_dev

Andi Kleen <ak@muc.de>:
  o Make x86-64 compile

Andrew Morton <akpm@digeo.com>:
  o hugetlbpages: factor out some code for hugetlbfs
  o Move hugetlb declarations into their own header
  o hugetlb fixes andhugetlb fixes and cleanups cleanups
  o fix hugetlb thinko
  o hugetlbfs file system
  o hugetlbfs backing for SYSV shared memory
  o Orlov block allocator for ext2
  o speedup heuristic for get_unmapped_area
  o uninline some things in mm/*.c
  o flush_dcache_page in get_user_pages()
  o lru_add_active(): for starting pages on the active list
  o start anon pages on the active list (properly this time)
  o empty the deferred lru-addition buffers in swapin_readahead
  o exempt swapcahe pages from "use once" handling
  o strip pagecache from to-be-reaped inodes
  o sys_remap_file_pages
  o tmpfs support for remap_file_pages
  o use RCU for IPC locking
  o uninlining in ipc/*
  o make kernel_stat use per-cpu infrastructure
  o additional arch support for per-cpu kernel_stat
  o direct-io build fix
  o use bd_claim in the raw driver
  o faster wakeups in the pipe code
  o improved space efficiency in dcache
  o disable PF_MEMALLOC for interrupt allocations
  o ext3 build fix
  o page accounting atomicity fix
  o Update/Create core files for DriverFS Topology
  o i386 driverfs Topology
  o NUMA meminfo for driverfs Topology
  o create memblk_online_map
  o create node_online_map
  o driverfs topology cleanup

Andy Grover <agrover@groveronline.com>:
  o ACPI
  o ACPI: Ensure we don't try to sleep when we shouldn't
  o ACPI: Interpreter update to (20021101)

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o isapnp: fix typo in isapnp_proc_done when CONFIG_PROC_FS is not set

Christoph Hellwig <hch@lst.de>:
  o add CONFIG_MMU and CONFIG_SWAP
  o make swap code conditional
  o filemap.c bits for uClinux
  o page_alloc.c uClinux bits

Daniel Jacobowitz <drow@nevyn.them.org>:
  o Factor out common ptrace code and PTRACE_SETOPTIONS Support
    PTRACE_O_TRACESYSGOOD on all platforms
  o Add CLONE_UNTRACED to the flags forced by kernel_thread
  o Add new ptrace event tracing mechanism
  o Define CLONE_UNTRACED in more architecture files and correct PA
    typo

Dave Jones <davej@codemonkey.org.uk>:
  o Clean up capabilities printing
  o max_cpus overflow
  o Double x86 initialise fix

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: forced metadata pages were not being flushed to disk
  o JFS: add posix acls

David Howells <dhowells@cambridge.redhat.com>:
  o AFS compile breakage

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Hook up sys_lookup_dcookie()
  o ia64: Sync up with 2.5.45
  o ia64: Update defconfig

David S. Miller <davem@redhat.com>:
  o Fix partitions build failure

Davide Libenzi <davidel@xmailserver.org>:
  o epoll update r3

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: update HyperThreading support in p4-clockmod.c driver
  o cpufreq: /proc/sys/cpu and /proc/cpufreq can be used simultaneously

Erich Focht <efocht@ess.nec.de>:
  o ia64: 2.5.44 NUMA fixups

Geert Uytterhoeven <geert@linux-m68k.org>:
  o C99 designated initializers for include/asm-m68k/thread_info.h
  o M68k speaker driver can be a modular
  o m68k IP checksum fix
  o M68k epoll
  o Fix dyslexia in Amiga keyboard driver
  o M68k misc compile fixes
  o M68k dump_stack() updates
  o M68k genrtc updates
  o vesafb 6x11 font fix
  o M68k IDE lock fixes
  o HP9000/300 I/O access fixes
  o M68k INIT_SIGNALS() update
  o Enable console on m68k
  o M68k: Fix missing/superfluous includes
  o Convert m68k cache macros to inline functions
  o M68k ISA DMA update
  o M68k: fix init_task section
  o M68k irq updates
  o m68k asm/kmap_types.h
  o M68k *_mksound() prototypes
  o M68k local_irq*() updates
  o M68k linker file updates
  o M68k build fixes
  o m68k do_fork() update
  o Atari nvram fix
  o Export m68k_memoffset
  o M68k asm/percpu.h
  o Allow to disable macfb
  o Q40/Q60 RTC update
  o M68k input drivers cleanup
  o M68k needs WANT_PAGE_VIRTUAL
  o M68k iomap cleanup
  o M68k virt/phys fallback removal
  o mac8390 Ethernet
  o IDE: kill warning
  o Amiga serial: static function
  o contact update
  o Sun-3 ioremap()
  o Sun-3 doc updates
  o Mac/m68k spelling
  o M68k: optimize stacked irq check
  o M68k TIF_SYSCALL_TRACE
  o Sun-3 SCSI updates
  o Z2ram: Add missing closing brace
  o Sun-3 vectored interrupts
  o Sun-3/3x updates
  o Zorro ID update
  o Fix rwsemtrace() message
  o m68k xtime update
  o Sun-3 VME support
  o Zorro loff_t
  o Sun-3 DVMA debugging
  o m68k unused cruft removal

Gerd Knorr <kraxel@bytesex.org>:
  o videobuf update
  o add v4l2 api
  o tv tuner driver update
  o bttv documentation update
  o bttv update
  o new v4l2 driver: saa7134

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha ISA dma and MAX_DMA_ADDRESS
  o more alpha build fixes
  o alpha: common ev6/ev7 machine check handler

Jeff Garzik <jgarzik@redhat.com>:
  o Fix alpha build
  o Minimal initramfs support (based on Al Viro's work)
  o Kill stupid bug in initramfs that prevented it from working

John Levon <levon@movementarian.org>:
  o fix timer_pit.c warning
  o oprofile: tiny makefile tidy
  o fix sys_lookup_dcookie prototype
  o fix APIC errors on oprofile restore

John Stultz <johnstul@us.ibm.com>:
  o linux-2.5.45_notsc-warning_A0

Jun Nakajima <jun.nakajima@intel.com>:
  o fixes for building kernel 2.5.45 using Intel compiler

Linus Torvalds <torvalds@home.transmeta.com>:
  o Needs <linux/smp_lock.h> for "in_atomic()" test
  o Add a "cmd_len" parameter to the request, so that device drivers
    don't have to try to figure it out for themselves.
  o Remove last vestiges of ide-cd.c "struct packet_command". It's been
    empty for a while now, and nothing uses it.
  o Set command length for the START_STOP command
  o Missed <linux/init.h> in CONFIG_SWAP changes
  o BK ignore kconfig and initramfs files
  o Make ide-cd.c use the request command length information
  o Move SCSI command size information into <scsi/scsi.h>, where the
    commands themselves already are.
  o Fix mbcache config dependency: if either EXT2 or EXT3 is
    compiled-in, mbcache should be too. 
  o Make presense of old/style EH routines cause warnings, not a
    compile failure.
  o Fix compile warning in slab.c

Luca Barbieri <ldb@ldb.ods.org>:
  o Clear TLS on execve

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Initialize hw broadcast so that BNEP multicast filter can be
    properly initialized.
  o Cleanup Bluetooth kernel messages
  o Bluetooth HCI UART driver fixes
  o Improved support for /proc/bluetooth

Manfred Spraul <manfred@colorfullife.com>:
  o complete the move of the LDT code into

Marcel Holtmann <marcel@holtmann.org>:
  o Don't use typedefs for non opaque HCI objects
  o Module description cleanup

Matthew Dharm <mdharm-scsi@one-eyed-alien.net>:
  o test for media-change like "popular" OSes

Matthew Wilcox <willy@debian.org>:
  o HPUX emulation updates
  o Allocate a personality for HPUX
  o drivers/parisc
  o binfmt_som
  o fix rd.c compilation
  o PA-RISC updates
  o parport_gsc
  o remove *_segments() dummy functions from all other architectures

Patrick Mochel <mochel@osdl.org>:
  o driver model: convert devices to use kobjects and sysfs
  o driver model: convert bus drivers to use kobjects and sysfs
  o driver model: convert drivers to use kobject and sysfs
  o driver model: convert device classes to use struct kobject and
    sysfs
  o driver model: convert interfaces to use kobject and sysfs
  o driver model: remove remaining driverfs glue
  o convert block devices and partitions to use kobject & sysfs
  o convert do_mounts.c to use sysfs instead of driverfs
  o create firmware subsystem and register it on startup
  o acpi: convert to use kobjects and sysfs
  o make sure block device_init() is called before part_init()
  o driver model: remove few remaining references to driverfs
  o convert edd to use kobjects and sysfs
  o driverfs: die die die
  o turn off kobject debugging by default
  o kobject: don't create directory for kobject/subsystem if name is
    NULL

Richard Henderson <rth@twiddle.net>:
  o Fix fallout from oprofile patches
  o Save and restore CIA window configuration data
  o New file to debug clobbers of "current"
  o Fix up Alpha for initramfs changes
  o Misc Alpha compilation fixes
  o Don't clear pcb.unique if CLONE_SETTLS is not set
  o Fill in siginfo_t
  o Update clone syscall for TID and TLS arguments

Robert Love <rml@tech9.net>:
  o hyper-threading info in /proc/cpuinfo
  o decoded wchan in /proc
  o fix UP proc.c compile warning

Roman Zippel <zippel@linux-m68k.org>:
  o check QT only if needed

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix init section naming 2.5.44 changed .text.init to
    .init.text (and other similar section names).  This cset fixes the
    ARM parts to work with the new names.
  o [ARM] Fix ARM IRQ probe code
  o [ARM] Fix another usage of the now defunct 'tick'
  o [ARM] Add kallsyms support for ARM This cset adds support for
    kallsyms for the ARM kernel, and ensures that we have a reliable
    function prolog for backtracing.
  o [ARM] Only decend into mach-* if $(MACHINE) is defined
  o [ARM] Fix up some ARM PCI handling
  o [ARM] Make ARMv5 architecture select ARMv4 rather than ARMv3 IO
  o [ARM] Miscellaneous fixes
  o [ARM] Re-work L1 pagetable bit handling
  o [ARM] Replace __backtrace() with dump_stack()
  o [ARM] 2.5.45 updates
  o [SERIAL] Rename uart_event() to uart_write_wakeup() uart_event()
    only has one purpose, which is to wake up any pending writers via
    the line discipline.  Rename it to reflect its real functionality,
    and drop EVT_WRITE_WAKEUP.
  o [SERIAL] Remove struct pci_board from init_fn Traditionally, we
    allocated the private array of port parameters based on the
    detected board->num_ports, and then called the init_fn with the
    board pointer (which points into the global table.)  Some init_fn
    implementations modify num_ports, which therefore affects the
    global table.  Unfortunately, this means that if the init_fn
    increases num_ports (because we have two almost identical cards,
    the first with a smaller number of ports than the second), we will
    overwrite memory which hasn't been allocated to us.
  o [SERIAL] Fix two incorrect uses of __FUNCTION__
  o [SERIAL] Fix up 8250 IRQ chain handling
  o [SERIAL] Fix up formatting of serial names The tty layer's tty_name
    requires formatting codes in driver->name for the devfs and
    non-devfs cases.
  o [SERIAL] Make ALPHA_KLUDGE_MCR more generic for bluetooth modems,
    etc In addition to the Alpha OUT1/OUT2 kludge, devices like
    Bluetooth modems connected to serial ports make use of the modem
    control lines in non-standard ways.  Therefore, we implement a more
    flexible way to allow the modem control outputs to be forced to
    particular values irrespective of the normal usage of these
    signals.
  o [SERIAL] Tidy up 8250 port type detection The original port
    detection code was one large function with many tests without any
    clear structure.
  o [SERIAL] Fix build errors and warnings
  o [SERIAL] Set port->type to unknown only when using autoconfig
  o [SERIAL] [PARISC] add support for GSC serial Add discovery for
    PA-RISC 16550 serial ports.
  o [ARM] Fix various build errors in bk-cur
  o [ARM PATCH] 1300/1: more efficient irq number retrieval for PXA due
    to ARMv5 instructions
  o [ARM PATCH] 1301/1: detection of more XScale chips Adds detection
    of:
  o [ARM PATCH] 1312/1: BadgePAD 4 mach-sa1100 update
  o [ARM PATCH] 1310/1: Make SA-1100 IR compile
  o [ARM PATCH] 1298/1: display various PXA250 clocks on boot for
    better bug diagnosis Since it's easy to overclock that chip we'd
    better know why some board is  crashing randomly due to signal
    integrity problems.
  o [ARM PATCH] 1299/1: display various PXA250 clocks (part 2) Patch
    #1298/1 will be much more useful if the code is actually called.

Sam Ravnborg <sam@ravnborg.org>:
  o kbuild: Compatible with old bash, fix help, make clean fix
  o docbook: *docs targets fixed, clean ok for html
  o aic7xxx: Simplified cleaning, fixed firmware build

Steve French <stevef@smfhome1.austin.rr.com>:
  o Fix locking of global smb list.  Add missing rc checks
  o Merge fixes from version 0.58 of cifs vfs

Theodore Ts'o <tytso@mit.edu>:
  o Fixup Orlov block allocator for ext2
  o Orlov block allocator for ext3
  o Default mount options from superblock for ext2/3 filesystems
  o Ext2/3 forward compatibility: on-line resizing
  o Ext2/3 forward compatibility: inode size
  o Port of the 0.8.50 xattr-mbcache patch to 2.5.  (Shrinker API, hch
    cleanups) (now uses struct block_device * to index devices, and
    uses hash.h for hash function)
  o Port of (bugfixed) 0.8.50 xattr-ext3 to 2.5 (w/ hch cleanups.
    mbcache API)
  o Port of (bugfixed) 0.8.50 xattr-ext2 to 2.5 (w/ hch cleanups.
    mbcache API)
  o Port of 0.8.50 acl patch to 2.5
  o Port of 0.8.50 acl-ms-posixacl patch to 2.5
  o Port 0.8.50 acl-xattr patch to 2.5 (harmonize header file with
    SGI/XFS)
  o Port of (bugfixed) 0.8.50 acl-ext3 to 2.5
  o Port of (bugfixed) 0.8.50 acl-ext2 to 2.5

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o another kmap imbalance in 2.4.x/2.5.x RPC


