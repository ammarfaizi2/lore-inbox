Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265509AbSJSEUy>; Sat, 19 Oct 2002 00:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265510AbSJSEUx>; Sat, 19 Oct 2002 00:20:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11789 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265509AbSJSEUo>; Sat, 19 Oct 2002 00:20:44 -0400
Date: Fri, 18 Oct 2002 21:24:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.44 - and offline for a week
Message-ID: <Pine.LNX.4.44.0210182117500.12531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've merged stuff from more people, and 2.5.44 is out there. We're 
getting closer, folks.

And for the ext 8 days (starting _now_) it is totally unnecessary to try
to send me patches or cc me on the discussions about what needs to be
merged or not. I won't read it, and when I get back I will likely just
flush the whole inbox, since there's no way I can try to catch up _and_
try to merge some final pieces before the feature freeze at the same time.

I've asked various people to act as merge-points for me while I'm gone,
and to avoid having them mailbombed or pressured into accepting stuff they
don't really want to, I won't even tell who they are ;)

Anyway, the 2.5.44 patches are all over the map, see for yourself in the
appended changelog.

I repeat: while I'm gone, please use linux-kernel as a central point for
discussion, and I assume that all the normal suspects will maintain their
own set of fixes for it. Don't fill my inbox,

		Linus

----

Summary of changes from v2.5.43 to v2.5.44
============================================

<adam@kroptech.com>:
  o cpqarray IDA_LOCK compile fix

<akropel1@rochester.rr.com>:
  o 2.5.43: cpqarray compile fix

Adam Belay <ambx1@neo.rr.com>:
  o PnP Rewrite V0.9 - 2.5.43

William Adamson <andros@citi.umich.edu>:
  o kNFSd: NFSv4 patch for new setclientid, setclientid_confirm

Angus Sawyer <angus.sawyer@dsl.pipex.com>:
  o Fix for raid1 against 2.5.43

Cort Dougan <cort@fsmlabs.com>:
  o PPC32: Fixes for Force PowerCore boards

Dave Jones <davej@codemonkey.org.uk>:
  o net/ipv4/udp.c: Log short packets more verbosely
  o updated MAINTAINERS
  o gscd printk's wrong type
  o CONFIG_DEBUG_STACKOVERFLOW
  o bluesmoke incorrectly calls function twice
  o Remove duplicate config.help
  o Elan BIOS quirk workaround
  o Silence epat init
  o Missing checks in sis drm
  o ens1370 uses wrong printk type
  o Typos
  o Make sbpcd look more like 2.5 driver
  o Add printk levels
  o 64bit fixes for smbfs
  o extern inline -> static inline
  o Correct indentation on x86-64 MTRR driver

Dan Streetman <ddstreet@ieee.org>:
  o uhci: slight docs update
  o uhci: remove qh from qh->list
  o change devio-disconnect no-driver error code
  o uhci interrupt resubmit fixes

Dipankar Sarma <dipankar@in.ibm.com>:
  o RCU helper patchset 1/2
  o RCU helper patchset 2/2

Jeb Cramer <jeb.j.cramer@intel.com>:
  o e1000 update 1 - 10

<jgmyers@netscape.com>:
  o aio updates

Alexey Kuznetsov <kuznet@mops.inr.ac.ru>:
  o [NET]: Prepare for zerocopy NFS and IPSEC
  o [IPv4]: More output path work

Mark Haverkamp <markh@osdl.org>:
  o 2.5.43 aacraid driver

Randy Dunlap <randy.dunlap@verizon.net>:
  o 2.5.42 HID-BP menu

<sparker@sun.com>:
  o drivers/net/eepro100.c: simplify wait_for_cmd_done(), better errors
  o drivers/net/eepro100.c: only set priv->last_rx_time if we did work
  o drivers/net/eepro100.c: mask the interrupt and do a small delay on
    close()

<sridhar@dyn9-47-18-140.beaverton.ibm.com>:
  o sctp: Fixes a couple of sctp_peeloff() issues
  o sctp: VTAG checks for ABORT & SHUTDOWN_COMPLETE chunks
    (ardelle.fan)
  o sctp: Fixes Bug#623286 - zero vtag in SHUTDOWN_COMPLETE chunk
    (samudrala)
  o sctp: Fixes a bug in the calculation of highest new tsn in sack

Steven Whitehouse <steve@chygwyn.com>:
  o [DECNET]: Update to support timeouts

Adrian Bunk <bunk@fs.tum.de>:
  o don't #include tqueue.h in rio_linux.c

Alexander Viro <viro@math.psu.edu>:
  o infrastructure
  o cdrom helpers
  o compile fixes
  o pd.c cleaned up
  o pcd.c cleaned up
  o pf.c cleaned up
  o probes
  o ide.c cleaned up
  o md.c
  o mfmhd.c
  o loop.c
  o sr.c
  o sd.c
  o ftl.c
  o aztcd.c
  o cdu31a.c
  o cm206.c
  o gscd.c
  o mcd.c
  o mcdx.c
  o optcd.c
  o sbpcd.c
  o sjcd.c
  o sonycd535.c
  o acsi.c
  o ubd
  o cciss
  o umem
  o swim_iop
  o swim3
  o acorn floppy
  o amiga floppy
  o atari floppy
  o DAC960
  o cpqarray
  o floppy
  o i2o
  o old methods removal
  o compile fixes
  o jsfd converted to use of private queue
  o nbd converted to private queue
  o stram switched to private queue

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Handle passive resets correctly in SYN-RECV
  o [IPv4]: More output path work

Andi Kleen <ak@muc.de>:
  o x86-64 updates for 2.5.43
  o add linux/ioctl32.h header for 2.5.43

Andrew Morton <akpm@digeo.com>:
  o ia32 uniprocessor compile fixes
  o fix the build for CONFIG_MD
  o disable 64-bit sector_t on ppc32
  o fix oops in reiserfs_ioctl()
  o fix a VM lockup
  o simple_rename() link count fix
  o make filemap_sync static
  o don't allocate an extra page in vmalloc
  o don't make writers wait on their writeback in page reclaim
  o uninline somethings in fs/*.c
  o uninline the ia32 highmem functions
  o ramdisk fix
  o 3com driver fix

Anton Blanchard <anton@samba.org>:
  o ppc64: fix dump_stack
  o ppc64: sigcontext_struct -> sigcontext, from Stephen Rothwell
  o ppc64: updates for Ingo's signal changes
  o ppc64: add might_sleep to semaphore code
  o ppc64: move pci_device_to_OF_node so radeonfb can get at it
  o ppc64: remove pciconfig_iobase, its broken when IO resources are >
    4GB
  o ppc64: update in_atomic definition
  o ppc64: only enable eeh if something supports it
  o ppc64: dont mark openpic_setup_lock as __initdata, we need it for
    cpu add
  o ppc64: clean up exception table code, we werent taking the
    modlist_lock
  o ppc64: Only do an exception check if an 0x380 ends up in
    do_page_fault
  o ppc64: some xmon fixes for SLB faults, also store breakpoint
    address in a long
  o ppc64: local_irq_restore was missing a gcc barrier
  o ppc64: reduce stack usage of prom_instantiate_rtas
  o ppc64: update defconfig
  o ppc64: early printk support from Todd Inglett
  o ppc64: merge status indicator update from 2.4
  o ppc64: use generic debugger hooks in smp_call_function, busy loop
    instead of udelay
  o ppc64: disable ancient select syscalls
  o ppc64: merge some xmon updates from ppc32
  o ppc64: update to match recent kbuild changes
  o ppc64: ipc fixes from Peter Bergner and 64bit types updates from
    2.4
  o ppc64: fix Makefile so it actually works
  o ppc64: remove 64bit old uname syscall
  o ppc64: limit NR_CPUS to 32 temporarily, need to hunt down the 500kB
    of bloat it causes
  o ppc64: Handle some broken ioctls that do _IO(,,sizeof(struct foo))
    instead of just struct foo
  o ppc64: Dont allow us to recursively call printk, spotted by Milton
    Miller
  o ppc64: fix an IPC bug
  o ppc64: Fix for copy_tofrom_user from Paul Mackerras
  o ppc64: Fix semctl return code, also msgrcv/msgsnd fixes courtesy of
    Andi
  o ppc64: fix from ppc32 for sugsuspend bug
  o ppc64: Fix pgd_index overflow in free_pgtables and move stack up to
    2^41
  o ppc64: fix ptrace GETREGS/SETREGS
  o ppc64: add missing include
  o AIO
  o ppc64: defconfig update

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o ipv4: udp seq_file support: produce only one record per seq_show
  o ipv4: make arp seq_file show method only produce one record per
    call
  o ipv4: remove the hack, using seq->private to hold state
  o ipv4: remove the hack, make udp seq_file functions use
    seq->private
  o Add support for JTEC FA8101 USB to Ethernet device

Benjamin LaHaise <bcrl@redhat.com>:
  o get rid of a double free in aio.c introduced by a merge mistake
  o adds more aio exports for filesystems

Christoph Hellwig <hch@infradead.org>:
  o make LSM register functions GPLonly exports
  o remove LSM file_llseek hook
  o XFS: fix a makefile comment
  o kNFSd: minor knfsd cleanups
  o kNFSd: switch knfsd to vfs_read/vfs_write
  o XFS: add synch I/O entry points

Daisy Chang <daisy@teetime.dynamic.austin.ibm.com>:
  o sctp: Fix bug 611919 - should ignore the cwnd value for fast
    retransmit

Dan Cox <danc@mvista.com>:
  o PPC32: Add support for the SBS Palomar 4 embedded board

David Brownell <david-b@pacbell.net>:
  o LDM and driver binding
  o one liner, anti-oops

David Howells <dhowells@redhat.com>:
  o do_generic_file_read / readahead adjustments
  o missing put in AFS client

David S. Miller <davem@nuts.ninka.net>:
  o [NET]: Kill final traces of csum_partial_copy_fromuser
  o [SPARC64]: On broken cheetah, enable p-cache around large copies
  o [NET]: Cleanup now that sockfd_lookup/sockfd_put are exported
  o arch/sparc64/solaris/socket.c: Kill more sockfd_{lookup,put}
    redefinitions
  o net/ipv4/udp.c: proto sendpage returns int not size_t
  o net/bluetooth/bnep/sock.c: Kill another sockfd_lookup
    re-implementation
  o net/ipv4/ip_proc.c: Fix 64-bit warnings
  o arch/sparc64/kernel/time.c: Include linux/profile.h
  o arch/sparc/kernel/time.c: Include linux/profile.h
  o [SPARC]: Export memchr
  o [NET]: Apply missed parts of csum_partial_copy killing patch
  o arch/{i386,sh}/lib/Makefile: Kill old-checksum.o
  o [SPARC]: Add sys_lookup_dcookie
  o drivers/net/3c59x.c: Do not forget to set AddUDPChksum
  o arch/sparc{,64}/vmlinux.lds.S: Update for init section name changes
  o net/ipv6/mcast.c: Remove unused variable addr_type
  o [SPARC64]: Disable old cheetah pcache optimization
  o De-bloat linux/fs/aio.c
  o Fix scsi breakage
  o Fix scsi OOPS on bootup

Frank Davis <fdavis@si.rr.com>:
  o [IPV4]: Fix CONFIG_NET_FASTROUTE compile
  o drivers/block/xd.c compile

Greg Kroah-Hartman <greg@kroah.com>:
  o Cset exclude: david-b@pacbell.net|ChangeSet|20021015071026|11647
  o driver core: fix up merge mess
  o USB: fix problem with removing a USB root hub

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o net/ipv6/mcast.c: Fix source address selection of MLD Report/Done
    messages
  o [IPV6]: Several MLD fixes

James Bottomley <jejb@mulgrave.(none)>:
  o [SCSI] bring block TCQ helpers into line with new TCQ code
  o [SCSI 53c700] update with new TCQ code
  o [SCSI sd] make cache probe sensitive to unsupported mode page
  o [SCSI sd] correct wrong prink statement

Jens Axboe <axboe@suse.de>:
  o sym2 get host
  o make SCSI understand REQ_BLOCK_PC
  o make calling scsi_cmd_ioctl() part of generic cdrom_ioctl
  o block cleanups

Johannes Erdfelt <johannes@erdfelt.com>:
  o 2.5 uhci remove correct proc directory
  o 2.5 uhci remove urb from lists on error
  o 2.5 uhci proc path
  o 2.5 uhci breadth first traversal for low speed
  o 2.5 uhci control and interrupt queuing

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o sctp: in sendmsg: on err, only free asoc if init failed. (jgrimm)
  o sctp:  Fix restart address add prevention logic (jgrimm)
  o sctp: Various invalid address check fixes. (jgrimm)
  o sctp:  Fix small data can bypass pending rtx data bug.  (jgrimm)

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o Move kallsyms section next to other read-only sections
  o Clean up arch/i386/vmlinux.lds.S
  o kbuild: Add build dep for UML
  o kbuild: More cleaning work
  o ISDN: new xmit handling for ISDN net interfaces
  o ISDN: Move generic xmit/recv handling into isdn_net_lib.c
  o ISDN: Unclutter isdn_net.h
  o ISDN/PPP: Adapt sync-PPP
  o ISDN/PPP: Rename struct 'ippp_struct' to 'struct ipppd'
  o ISDN/PPP: Move state from ipppd to isdn_net_dev/isdn_net_local
  o ISDN/PPP: Move CCP related stuff into isdn_ppp_ccp.c
  o ISDN: Named initializers for isdn_bsdcomp.c
  o ISDN: Bug fixes for the isdnloop driver
  o ISDN/PPP: Remove bogus header handling
  o ISDN/PPP: PPP header cleanups
  o ISDN/PPP: CCP flags handling
  o ISDN/PPP: Move rest of CCP reset handling into isdn_ppp_ccp.c
  o ISDN: Start refcounting for per-ipppd data
  o ISDN/PPP: Reference struct ipppd directly
  o ISDN/PPP: dynamically allocate struct ipppd, further cleanups
  o ISDN/PPP: cosmetics
  o ISDN/PPP: clean up ipppd_write() and ipppd_ioctl()
  o kbuild: Speed up new "make clean/mrproper"
  o kbuild: More "make clean" cosmetics
  o kbuild: another "make clean" micro-optimization
  o kbuild: Fix temporary hack

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix IDE init order dependency problem, noted by Jens Axboe
  o Make x86 UP "set_mb()" use a lighter barrier than doing a full
    locked "xchg". It only needs a compiler barrier on UP.
  o Make a polite version of BUG_ON() - WARN_ON() which doesn't kill
    the machine.
  o Fix up sym53c8xx driver for new scsi_host_hn_get() infrastructure.

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o [NET]: Export sockfd_lookup
  o Fix files that escaped CONFIG_BLUEZ_XXX -> CONFIG_BT_XXX cleanup
  o Users must have CAP_NET_ADMIN capability in order to create
  o Just like many other parts of the kernel Bluetooth code was abusing
    typedefs for non opaque objects. This changeset cleans up L2CAP
    code and headers. In addition it optimizes sendmsg for L2CAP
    sockets.
  o Just like many other parts of the kernel Bluetooth code was abusing
    typedefs for non opaque objects. This Changeset cleanups Bluetoth
    HCI code and headers.
  o Consistent naming for Bluetooth HCI events, commands and parameters
  o Correct RFCOMM modem status implementation

Marcel Holtmann <marcel@holtmann.org>:
  o Use kernel crc32 for BlueZ BNEP

Martin Diehl <lists@mdiehl.de>:
  o usbtest updates

Matt Domsch <Matt_Domsch@dell.com>:
  o EDD: x86 BIOS Enhanced Disk Drive support

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o Fixes to CB/CBI and compilation problems

Matthew Wilcox <willy@debian.org>:
  o Fix file locking yield()
  o Allow compilation with -ffunction-sections

Mike Anderson <andmike@us.ibm.com>:
  o scsi host cleanup 1/3 (base) (corrected)
  o scsi host cleanup 2/3 (mid lvl changes)
  o scsi host cleanup 3/3 (driver changes)
  o scsi_debug new scan fix

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd: Reorganise rpc program version management
  o kNFSd: Export news symbols in sunrpc
  o kNFSd: Fix problems when releasing cache item
  o kNFSd: Change names of some exported functions
  o kNFSd: Unregister export caches in proper order
  o md: Register mergeable function for linear so requests
    don't cross device boundries

Patrick Mansfield <patmans@us.ibm.com>:
  o Re: [PATCH] SCSI-2 LUN setting consolidation

Patrick Mochel <mochel@osdl.org>:
  o driver model: make device_unregister() only mark device as !present
  o driver model: make driverfs an implicit initcall
  o driver model: change bus refcounting scheme to match devices'
  o driver model: make driver refcounting similar to devices'
  o driver model: change class reference counting to be like devices'
  o driver model: replace rwlock in struct bus_type with a rwsem
  o driver model: make sure device has driver when we add it to the
    class
  o driver model: simplify device/driver binding
  o driver model: make sure we call device_unregister() and not
    put_device() when removing system and platform devices.
  o driver model: add per-class rwsem and protect list accesses with it
  o driver model: add struct device_driver::shutdown() method and
    device_present() helper
  o driver model: protect drivers' device list accesses with bus's
    rwsem
  o driver model: clean up bus_for_each_{dev,drv}
  o driver model: introduce device_sem to protect global device list
    instead of device_lock
  o driver model: power management/shutdown cleanup
  o driver model: change struct device::present to enumerated value
    with multiple states
  o driver model (pci): change call of remove_driver to
    driver_unregister
  o driver model (scsi): change calls of remove_driver() to
    driver_unregister()
  o driver model(usb): change calls of remove_driver() to
    driver_unregister()
  o driver model (arm): change calls of remove_driver() to
    driver_unregister()
  o driver model: use list_for_each_safe() when removing devices from a
    driver
  o add sysfs filesystem, maintaining the driverfs revision history
  o sysfs: modify enough names to get it build and link w/o conflicts
  o sysfs: copy driverfs_fs.h to sysfs.h
  o sysfs: search replace to convert remaining names from driverfs* to
    sysfs*
  o sysfs: clean up a couple of remaining driverfs references in
    sysfs.h
  o sysfs: do kern_mount() on init
  o sysfs: copy driverfs documentation to be sysfs documentation
  o driver model: make sure we only try to bind drivers to devices that
    don't have a driver
  o driver model: fix matching bug
  o driver model: device removal

Paul Mackerras <paulus@samba.org>:
  o PPC32: make xchg take volatile *, remove duplicate xchg_u32 defn
  o PPC32: export open/read/lseek/close for the sake of ALSA modules
  o PPC32: Update boot wrapper Makefiles
  o PPC32: fix a typo in mpc10x.h
  o PPC32: Add some extra kernel debugging options
  o PPC32: make do_div handle all 64 bits of the dividend (not just 32)
  o PPC32: allow for host bridges that have a type field in the addr
    word

Pete Zaitcev <zaitcev@redhat.com>:
  o arch/sparc/boot/Makefile: Use libs-y
  o [sparc] Use Kai's way to make asm_offsets.h

Randy Dunlap <rddunlap@osdl.org>:
  o 2.5.43 IO APIC bit fields
  o cpia fix for older compilers
  o fix sysrq typos

Rob Radez <rob@osinvestor.com>:
  o [NET]: Remove final traces of csum_partial_copy

Romain Lievin <rlievin@free.fr>:
  o char tipar driver minor update

Russell King <rmk@arm.linux.org.uk>:
  o set_task_state() UP memory barriers
  o [ARM] time.c needs to include profile.h time.c handles the kernel
    profiling, and references prof_buffer/ prof_len/prof_shift.
  o [ARM] Convert ARM makefiles to new kbuild (Sam Ravnborg, Kai, rmk)
  o [ARM] Kill compiler warning in decompressor
  o [SERIAL] Fix missing parens in serial_core.h
  o [ARM] Update ARM SA1111 pci_pool implementation 2.5.43 removed the
    mem_flags parameter to pci_pool_create.  The ARM SA1111
    implementation needs to follow for the usbo hci implementation.

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: Distributed clean infrastructure
  o scsi+aic7xxx: Utilise distributed clean List files to be deleted
    during make clean where they are created
  o drivers/{atm,char,pci,video,zorro}: ditributed clean Move list of
    files to be deleted during make clean out where they are made.
    host-progs files taken care of automagically
  o drivers/net/hamradio/soundmodem: distributed clean Move list of
    files out where it belongs
  o kbuild: Distributed clean, misc
  o docbook: Makefile cleanup

Scott Feldman <scott.feldman@intel.com>:
  o e100 update 1 - 4

Stephen Lord <lord@sgi.com>:
  o XFS: busylist fixups
  o XFS: fix previous change, the wrong xfs_alloc_mark_busy call was
    removed
  o XFS: fix byte ordering issues with earlier allocator fix
  o XFS: fix xfs build on big endian architectures and cleanup

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [SPARC]: Move over to generic siginfo
  o [SPARC]: arch specific copy_siginfo_to_user no longer needed

Steven Whitehouse <steve@gw.chygwyn.com>:
  o [NET]: Kill old sklist_foo interfaces

Tim Hockin <thockin@freakshow.cobalt.com>:
  o drivers/net/eepro100.c
  o drivers/net/mii.c: only call netif_carrier_{on,off} if there is a
    state change
  o drivers/net/natsemi.c: init msg_enable in proper way
  o drivers/net/eepro100.c: eliminate speedo_intrmask

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Update section names to .foo.text/.foo.data form
  o PPC32: improve the memory size detection for PReP machines

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS typos in 2.5.43
  o Fix 'long long' != u64 in NFSv4 debugging printks


