Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSJPDkE>; Tue, 15 Oct 2002 23:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbSJPDkE>; Tue, 15 Oct 2002 23:40:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264839AbSJPDjz>; Tue, 15 Oct 2002 23:39:55 -0400
Date: Tue, 15 Oct 2002 20:44:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.43
Message-ID: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A huge merging frenzy for the feature freeze, although I also spent a few
days getting rid of the need for ide-scsi.c and the SCSI layer to burn
CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
those off to the maintainer).

The most fundamental stuff is probably RCU and oprofile, but there's stuff 
all over the map here..

		Linus

------

Summary of changes from v2.5.42 to v2.5.43
============================================

<barryn@pobox.com>:
  o USB: 2.5.42 partial fix for older pl2303

Benjamin LaHaise <bcrl@bob.home.kvack.org>:
  o net-kiocb.diff
  o clean up whitespace and patch import errors from net-kiocb patch
  o remove an inaccurate comment from sock.h

<ddstreet@ieee.org>:
  o fix usbfs mount count

Dave Hinds <dhinds@sonic.net>:
  o Small PCMCIA patch

<dilinger@mp3revolution.net>:
  o drivers/scsi/esp.c: Fix the build

Dipankar Sarma <dipankar@in.ibm.com>:
  o Read-Copy Update infrastructure

<ebiederm@xmission.com>:
  o Update changes to point to make 3.78

Jeff Dike <jdike@uml.karaya.com>:
  o Cleaned up a bunch of things noticed while merging the SMP support
  o This is the merge of the initial 2.4 SMP support
  o config.in now defines CONFIG_NR_CPUS
  o Added some code to arch/um/kernel/tempfile.c
  o Made a small fix to arch/um/kernel/Makefile
  o Fixed the non-SMP build
  o Fixed a bug caused by moving the location of the include of the
    arch and os Makefiles.
  o Fixed some locking bugs spotted by Oleg Drokin

<joe@wavicle.org>:
  o USB: Vicam driver update/rewrite

Randy Dunlap <randy.dunlap@verizon.net>:
  o "nousb" for in-kernel USB
  o 2.5.42 Doc/kernel-parameters

<rread@clusterfs.com>:
  o InterMezzo for 2.5

Richard Henderson <rth@are.twiddle.net>:
  o From Art Haas: C99 initializers for arch/alpha
  o Fix warnings of the form warning: long int format, different type
    arg (arg 5) by casting ino_t arguments to unsigned long for printf
    formats.
  o Fix warnings of the form warning: right shift count >= width of
    type by casting to long before shifting by HIGH_BITS_OFFSET.
  o Fix illegal use of short keyword
  o Fix three alpha gcc 3.3 warnings
  o Fix two defined but not used warnings by wrapping the variables in
    #if RTC_IRQ.
  o Fix hordes of printf format warnings by changing loff_t to long
    long
  o Fix defined but not used warnings by marking variables with
    attribute unused.

<sarolaht@cs.helsinki.fi>:
  o [TCP]: Add F-RTO support
  o [TCP]: Turn F-RTO off by default

<stevef@smfhome1.austin.rr.com>:
  o Correct compiler warnings for 64 bit platforms and minor formatting
    cleanup and remove debug function that was causing a conflict with
    a function of the same name in SCSI
  o change name of debug function to not conflict with optional jfs
    debug function

<timw@splhi.com>:
  o Forward port of 2.4 fsync_buffers_list() fix

Adam J. Richter <adam@yggdrasil.com>:
  o linux-2.5.41/drivers/usb/core/hub.c called down() from interrupt
    context

Adrian Bunk <bunk@fs.tum.de>:
  o Fix cpufreq compile
  o ATM build fix

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o update dmi support
  o two trivial doc fixeds
  o synclink updates
  o remove unused crap from ide
  o make eicon build
  o update cpia to match 2.4
  o some mtdblock_ro fixes
  o i2o-scsi next installment
  o mpt fusion update from vendor
  o fix up syncppp locking
  o ricoh performance fix
  o aacraid makefile fix
  o cpqfc vendor update
  o correct NCR5380 locking bug
  o sym53c416 updates
  o fix zs sysrq
  o last jffs/jffs2 signal fix was wrong
  o make devfs cdrom appear in the right place
  o fix qnx4 inits to C99
  o __ret is deprecated
  o remove unused work queue
  o hack fix for an obvious dmabuf bogon
  o configurable corename
  o forward port of the various scsi fixes from 2.4

Alexander Viro <viro@math.psu.edu>:
  o early allocation of ->part
  o disk->minor_shift cleanup
  o device_register() splitup
  o block ioctl cleanup
  o preparation to use of driverfs refcounts, part 1 - partitions
  o preparation to use of driverfs refcounts, part 2 - disk
  o refcounts for gendisks
  o bdev->bd_disk introduced
  o bunch of ->open() killed

Andi Kleen <ak@muc.de>:
  o x86-64 ACPI
  o x86-64 Bootloader updates
  o x86-64 - new memory map handling
  o x86-64 IA32 emulation updates
  o x86-64 IOMMU & PCI updates
  o Remove global cli stuff for x86-64
  o reboot.c for x86-64
  o library functions updates for x86-64
  o hotplug cpu changes for x86-64
  o Time changes for x86-64
  o Misc core changes for x86-64/2.5.42

Andrew Morton <akpm@digeo.com>:
  o scsi compile fix
  o n_r3964.c fix
  o /proc/meminfo alterations for hugetlbpages
  o direct-io bio_add_page fix
  o page freeing function for swsusp
  o small-machine writer throttling fix
  o propagate pte reference into page reference during
  o reduced and tunable swappiness
  o start anon pages on the active list
  o rename /proc/sys/vm/dirty_async_ratio to dirty_ratio
  o reduce the dirty threshold when there's a lot of mapped
  o batched slab shrink and registration API
  o fix disk IO stats for 512-byte IOs
  o discontigmem: zero out the per-node zone structures at boot
  o enable 64-bit sector_t config option
  o msync correctness fixes
  o remove kiobufs

Arjan van de Ven <arjanv@redhat.com>:
  o net/llc/llc_proc.c: Do not mark llc_proc_exist with __exit

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o o pppoe: use seq_file for proc stuff
  o [ipv4] move proc init to newly created net/ipv4/ip_proc.c
  o o ipv4: convert /proc/net/arp to seq_file
  o o ipv4: convert /proc/net/route to seq_file
  o o ipv4: convert /proc/net/udp to seq_file

Art Haas <ahaas@neosoft.com>:
  o C99 designated initializers for drivers/usb
  o C99 designated initializers for arch/sh

Ben Collins <bcollins@debian.org>:
  o Linux IEEE-1394 Updates
  o Dv1394 fix

Benjamin LaHaise <bcrl@redhat.com>:
  o eliminate a compiler warning for aio_write in net/socket.c
  o correct sock_aio_write prototype

Brian Gerst <bgerst@didntduck.org>:
  o convert tty_drivers to list_heads

Christoph Hellwig <hch@sgi.com>:
  o XFS: More mount cleanups
  o XFS: I/O path cleanups
  o XFS: Don't reset blocksize on umount
  o XFS: Set inode operations later in xfs_iget_core
  o XFS: Handle NULL pagebufs gracefully in pagebuf_geterror
  o XFS: Remove a dead variable
  o XFS: Remove leftovers of long-dead iocore methods
  o XFS: Remove struct pm entirely - it was never defined in the Linux
    port
  o XFS: Don't update i_rdev and i_generation in vn_revalidate
  o XFS: Revert VMAP() to the old IRIX prototype
  o XFS: Switch from iget_locked to ilookup in vn_get

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: return code from sb_bread was incorrectly checked
  o JFS: change name of get_index() to read_index()

David Brownell <david-b@pacbell.net>:
  o usbcore doc + minor fixes

David Howells <dhowells@redhat.com>:
  o AFS filesystem (1/2)
  o AFS filesystem 2/2

David S. Miller <davem@nuts.ninka.net>:
  o arch/sparc64/defconfig: Update
  o [TCP]: Only non-zero inits are necessary in tcp_vX_init_sock
  o arch/sparc64/kernel/ebus.c: Cure __FUNCTION__ usage
  o [IPV4]: Use generic struct flowi as routing key
  o net/ipv6/netfilter/ip6table_mangle.c: Fix wrong cast
  o net/ipv4/af_inet.c: Include linux/igmp.h
  o [ia64/ppc64/s390x/sparc64/x86_64]: Update for sock->ops->recvmsg
    AIO changes
  o drivers/net/pppoe.c: Update for new sendmsg/recvmsg AIO args
  o include/linux/net.h: Update SOCKOPS_WRAPPED to new AIO
    recvmsg/sendmsg args
  o net/appletalk/ddp.c: Update SOCKOPS_WRAPPED to new AIO
    recvmsg/sendmsg args
  o net/socket.c: Do not reference dev_ioctl unless CONFIG_NET
  o include/net/bluetooth/bluetooth.h: Fixup recmsg args
  o net/bluetooth/hci_sock.c: Fix recvmsg/sendmsg args
  o net/bluetooth/bnep/core.c: Update for new sendmsg args
  o net/bluetooth/rfcomm/core.c: Update for new sendmsg args
  o net/ipv6/udp.c: Update for new sendmsg/recvmsg args
  o net/ipv6/raw.c: Update for new recvmsg/sendmsg args
  o net/sctp/socket.c: Update for new sendmsg/recvmsg args
  o net/bluetooth/l2cap.c: Update for new sendmsg args
  o net/bluetooth/sco.c: Update for new sendmsg args
  o net/bluetooth/rfcomm/sock.c: Update for new sendmsg/recvmsg args
  o include/net/tcp.h: Declare tcp_enter_frto
  o net/irda/af_irda.c: Update for new sendmsg/recvmsg args
  o fs/smbfs/sock.c: Update for new sendmsg/recvmsg args
  o net/irda/af_irda.c: Fix sendmsg/recvmsg args in comments too
  o fs/aio.c: Export wait_on_sync_kiocb
  o fs/smbfs/sock.c: Fix the build
  o [SPARC64]: Kill some port-specific bloat
  o net/llc/llc_proc.c: Kill other __exit tag too

Doug Ledford <dledford@redhat.com>:
  o another TCQ update
  o ips TCQ update
  o SCSI update
  o Advansys TCQ update
  o qla1280 TCQ update
  o eata TCQ update
  o more driver updates (aacraid)
  o more driver updates (aic7xxx)
  o dpt_i2o TCQ update
  o two driver updates, one core update

Eric Sandeen <sandeen@sgi.com>:
  o XFS: Allow quota inode creation on a read-only filesystem
  o XFS: Get xfs debug module back in sync with current pagebuf flags
  o XFS: Add missing newlines to cmn_err messages
  o XFS: Rearrange how xfs deals with read-only mounts vs. read-only
    devices
  o XFS: Fix sysctl values, add PB_CLEAR_OWNER debugging line
  o XFS: Check rtdev as well when testing for read-only devices
  o XFS: Export xfs_bmbt_get_all for the last fix in xfsidbg.c
  o XFS: Remove unused pagebuf flags
  o XFS: Re-sync pagebuf flags in xfsidbg (missed last time...)
  o XFS: Clean up xfs' log message printing
  o XFS: More XFS debug-related fixes

Gerd Knorr <kraxel@bytesex.org>:
  o bttv driver compile fix

Greg Kroah-Hartman <greg@kroah.com>:
  o deleted drivers/usb/media/vicamurbs.h as it's no longer needed
  o USB: fix up previous pl2303 fix
  o USB: visor.c: changed USB_DT_DEVICE to USB_RECIP_INTERFACE, as
    that's the proper #define to use

Harald Welte <laforge@gnumonks.org>:
  o net/ipv6/netfilter/ip6t_LOG.c: Display ipv4 encapsulation properly
  o net/ipv4/netfilter/ip_conntrack_core.c: Fix
    ip_conntrack_change_expect locking
  o [NETFILTER]: Avoid nesting readlocks in conntrack code
  o net/ipv4/netfilter/ipt_unclean.c: Source port is allowed to be zero

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o fix error code which fat_fill_super() returns (1/5)
  o merges parse_options() of fat and parse_options() of vfat (2/5)
  o removes posix option of fat (3/5)
  o add show_options to fat (4/5)
  o adds dmask option to fat (5/5)

Ingo Molnar <mingo@elte.hu>:
  o futex-2.5.42-A2

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha fixes

Jaroslav Kysela <perex@suse.cz>:
  o ALSA updates

John Levon <levon@movementarian.org>:
  o net/ipv4/af_inet.c: Kill inaccurate comment
  o oprofile - hooks
  o oprofile - dcookies
  o oprofile - timer hook
  o oprofile - NMI hook
  o oprofile - MSR defines
  o oprofile - core
  o oprofile - i386 driver
  o oprofile - dcookies need to use u32

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix UML build

Kai Makisara <Kai.Makisara@kolumbus.fi>:
  o SCSI tape door lock and reset fixes

Linus Torvalds <torvalds@home.transmeta.com>:
  o Merge with DRI CVS tree
  o When opening a CD-ROM device with O_NONBLOCK (for setup and ioctl),
    we should allow read-write accesses - it's used for control, not
    data.
  o Fix type - it used to be "__u8 short", which previous versions
  o "tv_sec" is unsigned long
  o Make ide-cd handle a REQ_BLOCK_PC packet command completion
    properly (which is to say the same as REQ_PC).
  o Block layer ioctl cleanups
  o Remove unused variable warning
  o Remove ide-cd reliance on "struct packet_struct", make it use the
    native "struct request" fields instead.
  o Oops, fix over-eager search-and-replace

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Fix typo in HCI_FILTER get/setsockopt
  o Increase BNEP thread priority
  o Now that the module name bluetooth.o is not used by USB subsystem
    anymore we can rename bluez.o to what it should have been from the
    begging  bluetoth.o
  o Consistent naming for Bluetooth function and constants
  o Get rid of the MIN() thing in Bluetooth code and use min_t()
    instead
  o Support for suspend/resume interface for the HCI devices

Manfred Spraul <manfred@colorfullife.com>:
  o oneliner race fix for ldt updates

Martin J. Bligh <Martin.Bligh@us.ibm.com>:
  o Summit: config options and hooks
  o Summit: infrastructure
  o Summit: APIC limits
  o Summit: MPS table detection
  o Summit: APIC ID mapping

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o Fix SCSI mode sense size
  o usb-storage: cache pipe values
  o usb-storage: generalize transfer functions
  o usb-storage: convert to common transfer functions
  o usb-storage: convert to common transfer functions

Nathan Scott <nathans@sgi.com>:
  o XFS: Sysctl updates
  o XFS: Global search and replace of the b* memory routines to their
    mem* equivalents
  o XFS: remove a no-longer-used conditional macro

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Fix build of timer routines

Peter Chubb <peter@chubb.wattle.id.au>:
  o Compile failure (gcc 2.96 bug?). 2.5.42 raid0.c

Romain Lievin <rlievin@free.fr>:
  o char driver: added tipar driver

Russell King <rmk@flint.arm.linux.org.uk>:
  o [SERIAL] Fix Sparc32/64 handling of CONFIG_SERIAL_CORE{,_CONSOLE}
    SPARC was unconditionally setting CONFIG_SERIAL_CORE_CONSOLE to y
    and conditionally setting CONFIG_SERIAL_CORE depending on the Sparc
    sub-drivers.  In addition, the core serial driver for SPARC is
    always built, so we end up with link errors.
  o [ARM] Move TEXTADDR and DATAADDR out of vmlinux.lds.S These two
    variables are used by more than just the linker; they're also used
    by head.S to know where it can safely place the page tables.  We
    therefore need to export it from the Makefile.
  o [ARM] Allow CONFIG_ZBOOT_ROM=y image to be relocated to RAM Since
    the decompressor supports PIC, even for CONFIG_ZBOOT_ROM, we can
    easily allow an image which has been linked to run at a particular
    address in ROM to be moved to RAM.  We just need to make sure that
    we don't relocate the GOT entries for the BSS segment.
  o [ARM] Ensure deselected config variables are defined to 'n' To keep
    the Config.in files relatively clean, we use the following
    construct:
  o [ARM] Update timekeeping functions to use tick_nsec/1000 This
    updates the ARM time keeping functions to use tick_nsec/1000
    instead of tick.
  o [ARM] Update pcibios_enable_device, supply pci_mmap_page_range()
    Update pcibios_enable_device to only enable requested resources,
    mainly for IDE.  Supply a pci_mmap_page_range() function to allow
    user space to mmap PCI regions.
  o [ARM] Update for signal handling changes
  o [ARM] Update RiscPC decompressor for PIC changes This cset fixes
    the RiscPC decompressor code for the PIC changes.
  o [ARM] Optimise ARM TLB handling Sanitise includes of
    asm/tlbflush.h, asm/cacheflush.h, asm/proc-fns.h Implement
    ARM-specific TLB "shootdown" code.  It turns out that it is overall
    more efficient to unconditionally invalidate the whole TLB rather
    than entry by entry when removing areas.
  o [ARM] Update neponset/sa1111 for Linux device model updates
  o [ARM] Other updates for changes in 2.5.42 This adds ARM support for
    in_atomic() and asm/numnodes.h
  o [ARM] IDE updates
  o [ARM] Fix iop310-pci compilation errors
  o [ARM] Remove second serial port address
  o [ARM] cpufreq updates for ARM This updates the Integrator cpufreq
    code to use the new interfaces, and makes the sa1100 cpufreq round
    up the requested frequency.
  o Convert acorn expansion card probing code to the Linux device model
  o [ARM] Update Acorn ethernet expansion cards This cset implements
    validity checks on the ethernet MAC address when the device is
    opened, and refuses to open the device if this check fails.  We
    also provide the set_mac_address method to allow ifconfig to change
    the mac address to something valid.
  o [ARM] Acorn serial port driver update This cset combines the
    Atomwide and The Serial Port 16550 driver modules into one
    "8250_acorn.c" driver.  This new module takes full advantage of the
    LDM-based expansion card facilities.
  o [ARM] Remove old Acorn iomd-based keyboard and mouse drivers
  o [ARM] Fix up NCR5380-based Acorn SCSI drivers This cset updates (as
    much as is possible) the NCR5380-based Acorn SCSI drivers, mainly
    converting them to the new error handling code.
  o [ARM] Rudimentary support for Thumb ptracing
  o [ARM] dump_stack and show_trace_task dump_stack() got used by the
    generic code.  Call our version __dump_stack since we're running
    out of other descriptive names.
  o [ARM] Remove non-existent USB gadget code from mach-sa1100/Makefile
    The USB gadget code now lives in arch/arm/mach-sa1100/usb, and
    isn't in a mergable state.  We remove the old makefile entries
    which are never going to be satisfied, and leave a placeholder for
    the usb directory.
  o [ARM] Convert boot-time memory permission selection to table
  o [ARM] Update fd1772.c Remove unnecessary use of __inline__, and
    remove a few unnecessary prototypes.  copy_buffer is moved before
    use.
  o [ARM] Fix fas216 use of __FUNCTION__ macro
  o [ARM] Update acorn scsi code wrt global irq and bitops This cset
    removes the global irq handling in the AcornSCSI driver, and makes
    the target type for bitops an unsigned long array rather than an
    unsigned char array.
  o [ARM] Fix entry-armv.S Prevent the assembler putting constant pools
    in the middle of code.
  o [ARM] Update ARM cache type decoding
  o [ARM ADFS] C99 designated initialisers (Patch from Art Haas) Here's
    a small set of patches that switch the code to use C99 desiginated
    initializers. Patches are against 2.5.42.
  o [ARM] Convert sa1100 PCMCIA drivers to C99 initializers (Art Haas)
    The patches convert drivers/pcmcia to use C99 named initializers,
    and all the patches are against 2.5.42. There are 25 patches in
    total, and the "cat"ing them together they're more that 20K, so I'm
    sending the patches as a compressed attachment. The patches were
    CC'd to Linus in the first mail that bounced.
  o [ARM] Make the assabet machine always use the same uart mapping
  o [ARM] Add Xscale ADIFCC and IOP310 documentation
  o [ARM] Update sa1100 PCMCIA support We removed asm/mach-types.h from
    asm/hardware.h.  This means we must now include asm/mach-types.h
    where its used.
  o [ARM] Update acornfb driver to 2.5.42 fbcon
  o [ARM] Update clps711x fbcon driver
  o [ARM] Update cyber2000fb for 2.5 fbcon
  o [ARM] Update AFS mtd partition parsing
  o [ARM] Update integrator-flash.c from MTD CVS Keep the partition
    information around for the lifetime of the module.
  o [MTD] Update 2.5 MTD code from MTD CVS and ARM tree This cset
    updates the 2.5 MTD code from the MTD CVS.  David Woodhouse is
    happy with me sending this.

Stephen Lord <lord@sgi.com>:
  o XFS: Rework dev_t and linux inode handling
  o XFS: fix xmount command in xfsidbg
  o XFS: fix parsing of extents by debug code
  o XFS: fix 2.5 specific code for small block size filesystems, there
    was a
  o XFS: add some tracing calls in the read/write path
  o XFS: simplify the xfs flush and flushinvalidate calls down the what
  o XFS: ensure inode size is correct after making a symlink
  o XFS: bring the 32 bit inode flag back into line with the Irix
    version
  o XFS: remove some bit shifting constants we do not use
  o XFS: remove some 'temporary debugging code'
  o XFS: Switch to native endian internal representation for extents
  o XFS: remove debug print statements
  o XFS: merge strategy and bmap calls, they are two aspects of the
    same operation
  o XFS: fix some off by one errors in the busy list search code
  o XFS: Fix a couple of nasty log problems

Stuart MacDonald <stuartm@connecttech.com>:
  o USB Whiteheat driver patches

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o A basic NFSv4 client for 2.5.x

William Lee Irwin III <wli@holomorphy.com>:
  o remove unused variable in wacom driver


