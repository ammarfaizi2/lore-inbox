Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbTCXXRj>; Mon, 24 Mar 2003 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTCXXRj>; Mon, 24 Mar 2003 18:17:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36612 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262573AbTCXXRT>; Mon, 24 Mar 2003 18:17:19 -0500
Date: Mon, 24 Mar 2003 15:26:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.66
Message-ID: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A lot of changes all over. Most notably probably the fbcon updates, it's 
really all over the map - mostly a lot of very small fixes.

		Linus


Summary of changes from v2.5.65 to v2.5.66
============================================

Adrian Bunk <bunk@fs.tum.de>:
  o [NF/IPV6]: Remove all ipv6_ext_hdrs from ip6tables

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Remove NO_VERSION from S390x exec32
  o __NO_VERSION_ for ati_pcigart
  o __NO_VERSION__ for used bits of dri
  o __NO_VERSION__ for ftape
  o Move ipmi to new struct stuff
  o fix bogus C in ite_gpio
  o merge lp driver for PC98xx systems
  o remove ifs from ancient backcompat in mwave driver
  o rio __NO_VERSION__
  o newer boards put other hw at rtc + 0x08
  o real time clock support for PC9800 systems
  o unbreak the acquirewdt
  o fc4 doesnt need __NO_VERSION__ any more
  o fix all the other watchdogs Dave's changes broke the same
  o fix ide-geometry bogus printk level
  o remove legacy probe code
  o add hd98 driver (equivalent to hd.c for old PC9800)
  o clean up ht6560 legacy ide driver
  o module for legacy PC9800 ide
  o remove old style probe from other legacy ide
  o Update ide/legacy makefile to match changes
  o fix proc handling in serverworks and sc1200 ide
  o fix proc handling in sis, siimageand slc90e66
  o fix /proc handling in via82cxxx
  o move mac-hid to C99
  o remove __NO_VERSION__ from radio drivers
  o remove __NO_VERSION__ from saa7134 driver
  o fix GTUNER on w9966
  o Fix i2o_scsi hang
  o fix 3c501 typo
  o remove unused ali-ircc variable
  o sk98 typo fix
  o typo fix for tulip
  o fix pcmcia crash with hostap
  o fix pcmcia __NO_VERSION__
  o pnpbios doesnt want __NO_VERSION__
  o fix bogus if in advansys driver
  o fix time types in aha152x
  o fix buffer overrun in aha1542
  o fix leak in cpqfc
  o gdth update from Intel
  o junkfilter sym53c41
  o PC9800 has a slight funny on 8250_pnp
  o serial driver for PC9800 systems
  o xjack memory leak fixes
  o __NO_VERSION__ for autofs
  o typo fix for befs
  o remove __NO_VERSION__ in cifs
  o typo fix for expfs
  o fix fat handling of some weirder variants
  o remove __NO_VERSION__ from intermezzo
  o remove __NO_VERSION__ from intermezzo #2
  o remove __NO_VERSION__ from jffs
  o remove __NO_VERSION__ from lockd
  o Add NEC PC9800 partition tables
  o remove __NO_VERSION__ from procfs
  o Alpha folks said my change was wrong, revert it and note the funny
  o add a new dmi flag for broken pnpbios
  o add another clock tick rate variant
  o add headers for upd4990a rtc/clock driver
  o S/390 typo fixes
  o Remove i2o pci abstractions
  o update i2o build rules for change
  o remove __NO_VERSION__ in mtd
  o kill off IDE_DEBUG, add pc9800 ide type
  o update compaq idents, correct and update intel idents
  o add pc9800 port types
  o no arch specific headers for upd4990a
  o update Achim's address
  o fix typo in oom_kill
  o tidy up make rpm
  o fix typo in net/core/neighbour
  o unless this is a backward spanish inquisition joke
  o pc9800 CS4232 driver
  o fix up opti92x-ad1848
  o clean up es968, fix build
  o fix  __NO_VERSION__ in audio_syms
  o fix ";" in cs46xx
  o fix i810 ifs
  o fix incorrect bracketing in maestro
  o __NO_VERSION__ for midi_syms
  o mpu401 uses __init vars during __exit
  o more __NO_VERSION__ in audio
  o update emu10k1 driver (SB Live, Audigy etc)
  o update emu10k1 config help
  o boot code for PC9800 systems
  o handle exploding pnpbios
  o add pc9800 setup and topology code
  o Make pci-bios function ids per machine type
  o arch pre/post setup for pc9800
  o PC9800 system common area definition
  o sysfs typo fix
  o remove odd blank line and add noacpi
  o ide-default driver
  o __NO_VERSION__ for ide-lib
  o ide-probe update
  o FOr efficient non posted I/O people need to know the target
  o add __ide_set_handler to fix abort race
  o use new outbsync when sending commands
  o rework the reset code to fix posting and races
  o remove special cases from ide_proc
  o update ide-tape to match changes
  o printk, version etc for ide-taskfile
  o ide should check dma_on
  o update ide core
  o update ide-cd to new changes, add abort() handlers
  o update ide-disk to changes, remove all the driver ifs
  o update ide-dma support
  o fix tuning of alim15x3
  o fix /proc for amd ide
  o fix cmd640 ide locking
  o fix more proc and other oddments
  o add ICH5 and Centrino to PIIX4
  o add ide-default to the build
  o fix aec proc handling
  o remove __NO_VERSION__ from bttv
  o remove lots of now dead code (no features though!)
  o cpia -maintainers update
  o remove __NO_VERSION__ from drm
  o update ide headers to match changes
  o redo the n_tty fix
  o make opl3sa2 build again
  o clean up the mess someone merged into 3wxxx scsi
  o abstract out mach_reboot for x86 platforms
  o use right object for i2o_config - kernel not user copy
  o add checks to pc9800 ide reserve
  o ide typo fixes #3
  o Merge PC9800 keyboard driver
  o ide typo fixes #2
  o i2o_pci is dead
  o parallel port
  o merge PC9800 keyboard controller chip support
  o merge PC9800 mouse driver
  o ide typo fixes
  o eisa reports "0 device" not "0 devices"
  o Fix IDE disable_irq() deadlock
  o 3ware fixups from Adam Radford
  o Osamu's updates to boot98
  o remove NUL v NULL confusion
  o Achim is now Intel (they bought GDT)
  o PC98 has its own floppy (not yet merged)
  o Christoph felt the IDE_HD v PC9800 was ugly
  o isapnp change
  o missing config bits for PC9800 audio
  o Make ide use proper removal-safe list handling (removes endless
    looping / hang)

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Update for usb-skeleton

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [NET]: hard_header reservation
  o [NET]: miscellaneous fixes
  o [IPSEC]: fragmentation & tcp mss calculation
  o [IPV6]: Correct CHECKSUM_HW handling in tcp_v6_send_check

Allen Curtis <acurtis@onz.com>:
  o PPC32: Updates for the 8260 embedded processor and the EST and TQM
    boards
  o PPC32: Further 8260 update; one file was missed in the previous
    commit

Andrew Morton <akpm@digeo.com>:
  o [NET]: Use fancy wakeups where applicable
  o Fix noirqbalance
  o Pass the load address into ELF_PLAT_INIT()
  o remove unused block congestion code
  o timer code cleanup
  o timer re-addition lockup fix
  o use set_current_state in fs
  o use set_current_state in mm
  o Fix memory leak in copy_thread
  o file_list_lock contention fixes
  o file->f_list locking in tty_io.c
  o file_list cleanup
  o file_table: remove the private freelist
  o file_list: less locking
  o stack reduction in drivers/char/vt_ioctl.c
  o a few missing stubs for !CONFIG_MMU
  o slab changes for !CONFIG_MMU
  o memleak in fs/nfs/inode.c::nfs_get_sb()
  o Memleak in fs/ufs/util.c
  o posix timers update
  o OOPS instance counters
  o io-apic.c: DO_ACTION cleanup
  o fix oprofile timer race
  o pgd_index/pmd_index/pte_index commentary
  o /proc/sysrq-trigger: trigger sysrq functions via
  o Tighten CONFIG_NUMA preconditions
  o Fix nfsd_symlink() failure path
  o Add error checking get_disk()
  o sys_nanosleep() fix
  o NMI watchdog fix
  o fix nanosleep() granularity bumps
  o add write_seqlock to cpufreq change notifier for TSC
  o cs46xx minor fixes
  o Add missing put_user checks in n_tty
  o Fail setup_irq for unconfigured IRQs
  o raw driver: rewrite i_mapping only on final close
  o raw driver: cleanups and small fixes
  o slab: tune batchcounts for large objects
  o Fix floppy oops on forced unload
  o Make nonlinear mappings fully pageable
  o filemap_populate speedup
  o x86_64: support for file offsets in pte's
  o ppc64 support for file file-offset-in-pte
  o inode a/c/mtime modification speedup
  o Implement a/c/time speedup in ext2 & ext3
  o remove lock_kernel() from inode_setattr's
  o speed up vm_enough_memory()
  o remove lock_kernel() from readdir implementations
  o __bdevname atomicity fix
  o register_blkdev() fixes
  o make the bdevname() API sane
  o mwave oops fixes
  o dev_t [1/3]: kill cdev
  o dev_t [2/3] - remove MAX_CHRDEV
  o dev_t [3/3]: major.h cleanups
  o timer simplification
  o simplify the timer lockup avoidance code
  o pagecache accounting speedup
  o ext3: fix use-after-free bug
  o make list.h barriers smp-only
  o sync_filesystems commentary and latency fix
  o fix .text.exit error in OSS awe_wave.c
  o Make arch-independent syscalls return long
  o More syscalls-returning-long
  o remove the "half of memory" limit on mlock() and
  o ptrace_notify() locking
  o reenable interrupts in parport code
  o warning fixes
  o asm-generic/tlb.h needs swap.h
  o d_lookup forgotten spin_unlock()

Art Haas <ahaas@airmail.net>:
  o Add C99 initializers to net/ipv4/netfilter
  o Add C99 initializers for net/ipv6/netfilter code

Bart De Schuymer <bdschuym@pandora.be>:
  o [ebtables] bugfix in ebt_ip.c
  o [EBTABLES] hold usage count on table module when it contains rules

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: Add image target

Charles Fumuso <cwf@sgi.com>:
  o [XFS] fix getdents so that xfs_da_read_buf doesn't return an
    EFSCORRUPTED except when there is a real problem.

Chas Williams <chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Fix idt77252/sch_atm/pppoatm compilation
  o [ATM]: cleanup nicstat, suni and idt77105
  o [ATM] nicstar doesnt count all dropped pdus and powerpc fixup
  o [ATM] s/uni driver overwrites 8-/16-bit mode

Christoph Hellwig <hch@sgi.com>:
  o fix waitqueue leak in devfs_d_revalidate_wait
  o rempove CONFIG_DVB_DEVFS_ONLY
  o make devfs_put() static to fs/devfs/base.c
  o remove DEVFS_FL_REMOVABLE
  o get rid of __MOD_INC_USE_COUNT/__MOD_DEC_USE_COUNT
  o devfs_mk_symlink simplification
  o cleanup input_register_minor
  o don't include swap.h in mm.h
  o convert remaining register_pcmcia_driver users
  o bring back Al's devfs changes in dv1394
  o devfs_mk_dir simplification
  o misc devfs_register cleanups
  o make devfs_alloc_unique_number private to devfs
  o fix usb_devfs_handle abuse
  o [XFS] remove an unused variable
  o [XFS] remove VFS_DOUNMOUNT
  o [XFS] time_after takes an unsigned long
  o [XFS] Minor header shuffling, removing a bunch of already-included
    files and allowing 2.4/2.5 to be slightly more in sync.

Dave Jones <davej@codemonkey.org.uk>:
  o [CPUFREQ] Remove duplicate test. (Already done in longhaul_init())
  o [CPUFREQ] Remove duplicate cpuid check from AMD powernow-k6 driver
  o [CPUFREQ] Remove duplicate cpuid check from longrun driver
  o [CPUFREQ] remove duplicate cpuid check from p4 clockmod driver
  o [CPUFREQ] No need to export cpufreq_governor_list, so it can be
    static
  o fix obvious thinko
  o cciss unregister cleanup
  o 3ware vendor update
  o Remove old DRM4.0 code
  o piix compile fix for CONFIG_PROC_FS=n
  o documentation for userspace access
  o fix acpi write throttle seq file breakage
  o Sysfs not handling show errors
  o make nbd working in 2.5.x
  o Several logic bugs
  o Add missing intel cache descriptor
  o Make cpuid driver preempt safe
  o CCISS ID updates
  o cyclades region handling updates from 2.4
  o add another transparent bridge
  o make x86 MSR driver preempt safe
  o Update K6 bug URL
  o plug DRM memory leak on exit paths
  o x86-64: Add missing tlb flush after change_page_attr
  o fix wrong return type on parisc eisa_eeprom_llseek
  o fix asm constraints in ffs
  o various PCI ID updates
  o Add missing time initialisation to get_cramfs_inode
  o bring sparc riowatchdog in sync with 2.4
  o mark context switch wrmsr path unlikely
  o fix decnet compile error on newer gcc's
  o add support for 8 port lava octo cards to 8250_pci
  o __ipv6_regen_rndid typo fix
  o Bose sound support for cs4232 OSS driver
  o Add __copy_from_user checks to emu10k1
  o bring OSS mad16 in sync with 2.4
  o back out broken bits of previous cyclades patch
  o guard mad16 debug macro

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, prink tweaks

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Move sparc64_init_timers into time.c
  o [SPARC64]: Kill SPARC64_USE_STICK and use real timer drivers
  o [SPARC64]: Fix timer quotient calcs
  o [SPARC64]: Convert Cheetah scheduler tuning to use tick_ops
  o [SPARC64]: Do not allow cache_decay_ticks to be zero
  o [SPARC64]: Initial cut at Hummingbird STICk support
  o [SPARC64]: kernel/time.c needs asm/smp.h
  o [SPARC64]: Fix typo in __hbird_read_stick asm
  o [SPARC64]: Fix hbtick softint_mask
  o [SPARC64]: Fix __hbird_read_stick signedness, also hbird
    softint_mask
  o [SPARC64]: In __hbird_write_compare, write high then low part
  o [SPARC64]: Make TICK comparisons wrap-around safe by using jiffies
    macros
  o [SPARC64]: Ignore bit 63 of Hummingbird STICK when computing
    COMPARE register values
  o [SPARC64]: Do a dummy write to STICK in hbird_init_tick
  o [FB ATY]: CONFIG_FB_ATY needs cfbcopyarea.o
  o [SPARC64]: Sanitize all TICK privileged bit handling in tick
    drivers
  o [SPARC64]: Clear tick_cmpr ints properly in bootup assembly
  o [IPV6]: ndisc_recv_ns returns void
  o [IPV6]: Undo __constant_{n,h}to{n,h}l from anycast patch
  o [NET]: Kill NETIF_F_DYNALLOC, based upon ideas from Adam J. Richter
  o [SPARC]: Add die_counter changes
  o [SPARC64]: Fix thread_info offsets to match restart_block layout
    changes
  o [CRYPTO]: Include linux/errno.h as appropriate
  o [IPSEC]: Export xfrm_user_policy
  o [IPSEC]: net/xfrm.h needs net/sock.h
  o [IPSEC]: Fix socket leak in TCP/v6 when policy lookup fails
  o [SOUND]: Fix build of SBUS code in memalloc.c
  o [FB SBUS]: sbuslib.c needs linux/mm.h
  o [VT]: vc_pos needs to be unsigned long
  o [SOUND]: Fix ioctl32 build by using compat_timespec
  o [SOUND]: Fix rawmidi32 build by using compat_timespec
  o [FB]: 64-bit cfbimgblt.c changes do not even build
  o [FB FFB/CG6]: Fix image->data const typing
  o [SOUND]: Fix timer32.c build by using compat_timespec
  o [SPARC64]: Update defconfig
  o [IPSEC]: Fix minor mispatch of xfrm splitup patch
  o [SPARC64]: Fix typos in uptr changes
  o [SCTP]: Match ipproto->handler changes for ipv6
  o [COMPAT]: Fix net/compat.c build
  o [SPARC64]: Implement file-offset-in-pte

David Stevens <dlstevens@us.ibm.com>:
  o [IPV6]: Add anycast support

Davide Libenzi <davidel@xmailserver.org>:
  o epoll with selectable ET/LT behaviour

Dean Roehrich <roehrich@sgi.com>:
  o [XFS] fix dmapi POSTCREATE event in xfs_create/xfs_mkdir
  o [XFS] linvfs_file_mmap was updating the linux inode's atime twice

Dominik Brodowski <linux@brodo.de>:
  o pcmcia: check return values of driver_register
  o pcmcia: add bus_type pcmcia_bus_type
  o pcmcia: register drivers with bus
  o pcmcia: remove single linked list of drivers
  o pcmcia: convert pccard_cs driver to new registration interface

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: cosmetic comment changes
  o USB speedtouch: get rid of atmsar

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Fix indices into xfs_min/xfs_max for sysctls in 2.5.x
  o [XFS] Last of the dir2 backmerges from Irix
  o [XFS] Remove #if(n)def __KERNEL__ from xfs_error.c, not needed
  o [XFS] Turn on random() if INDUCE_IO_ERROR is defined
  o [XFS] use get/put_unaligned() to avoid unaligned accesses in the
    extents code on 64-bit machines
  o [XFS] Bump the reporting threshold on calls to XFS_ERROR_REPORT
    which are most likely due to a simple user error.

Geert Uytterhoeven <geert@linux-m68k.org>:
  o M68k exported symbols
  o M68k ISA memory for Amiga PCMCIA
  o M68k POSIX timers
  o M68k: Add new kmap types
  o Amiga PCMCIA Ethernet clean up
  o M68k ifpsp060 updates
  o M68k syscall updates
  o M68k: Signal updates
  o M68k heartbeat update
  o M68k PAGE_SIZE warnings
  o Q40: local_irq*() update
  o ADB: Fix spelling of sigprocmask
  o M68k Apollo I/O updates
  o M68k gcc-3.2 warnings
  o M68k struct page fix
  o IDE_ARCH_ACK_INTR duplicate
  o WD33c93 missing export
  o M68k net warnings
  o M68k SCSI warnings
  o M68k NCR5380 SCSI updates
  o Amiga serial updates
  o Genrtc updates
  o M68k SCSI driver updates
  o Sun-3 linkfile fix
  o Sun-3 memory zones
  o Sun-3 first page
  o Sun-3 NCR5380 SCSI warning
  o Amiga NCR53c7xx SCSI: use z_ioremap()
  o Amifb wrong interrupt
  o Amiga RTC updates
  o wd33c93 SCSI merge error
  o Sun-3 NCR5380 SCSI printk tags
  o M68k core spelling fixes
  o Affs sizeof()
  o M68k timekeeping update
  o console_initcall() return type
  o Port amifb to new fbdev API
  o Amiflop mod_timer()

Geoffrey Wehrman <gwehrman@sgi.com>:
  o [XFS] Fix target_linkzero calculation

Glen Overby <overby@sgi.com>:
  o [XFS] Add error reporting calls in error paths that return
    EFSCORRUPTED
  o [XFS] Fix freespace entry search to handle holes in the freespace
    area correctly
  o [XFS] Rearrange leaf space allocation
  o [XFS] getdents fix for dir v2
  o [XFS] Add stack trace print to xfs_error_report, warning cleanup
  o [XFS] In open, check the inode for extents after getting the shared
    lock on the inode.  The inode could have changed since before the
    lock.

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c i2c-i801.c: remove #ifdefs and fix all printk() to use dev_*()
  o i2c i2c-i801.c: remove check_region() usage
  o i2c i2c-i801.c: fix up the pci id matching, and change to use
    proper pci ids
  o i2c i2c-i801.c: fix up formatting and whitespace issues
  o i2c i2c-piix4.c: remove check_region() call
  o i2c i2c-piix4: remove #ifdefs and fix all printk() to use dev_*()
  o i2c i2c-piix4.c: fix up formatting and whitespace issues
  o i2c i2c-ali15x3.c: remove #ifdefs and fix all printk() to use
    dev_*()
  o i2c i2c-ali15x3.c: remove check_region() call
  o i2c i2c-ali15x3.c: fix up formatting and whitespace issues
  o i2c i2c-amd756.c: remove some #ifdefs and fix all printk() to use
    dev_*()
  o i2c i2c-amd8111.c: change a few printk() to dev_warn()
  o i2c i2c-amd8111.c: change the pci driver name to have "2" in it
    based on previous comments
  o i2c: added i2c-isa bus controller driver
  o i2c: add initial driver model support for i2c drivers
  o USB: whiteheat bugfix (bugzilla.kernel.org #314)
  o USB: pegasus: fix up GFP_DMA usages.  (bugzilla.kernel.org #418)

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB: new ids for scanner driver

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Use RFC2553 constant variable
  o [IPSEC]: Fix obvious typo in xfrm_sk_clone_policy
  o [IPSEC]: Split up XFRM Subsystem
  o [IPV6]: Use "const" qualifier
  o [IPV6]: Use ipv6_addr_any() for testing unspecified address
  o [IPV6]: Fix BUG 483, do not call crypto_alloc_tfm from illegal
    context
  o [IPSEC]: Fix bug in xfrm_parse_spi()

Ingo Molnar <mingo@elte.hu>:
  o mm/swapfile.c manual reschedule
  o posix-timers-cleanup-2.5.65-A5

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o [PCI] Make setup-bus.c aware of cardbus bridges
  o [PCI] Fix incorrect PCI cache line size assumptions
  o [PCI] Don't call pci_update_resource() for bridge resources

James Morris <jmorris@intercode.com.au>:
  o [IPSEC]: fix skb leak in ah and esp
  o [IPSEC]: return error when no dst in ah & esp output
  o [IPSEC]: Fix parsing of 16-bit ipcomp cpi
  o [IPSEC] Add initial compression support for pfkey and xfrm_algo
  o [CRYPTO]: Make use of crypto_exit_ops() during crypto_free_tfm()

James Simmons <jsimmons@kozmo.(none)>:
  o [NEOMAGIC FBDEV] Fix to work with no 21xx versions of the chip
  o [FBCON] More struct display cleanup. Also killed off static buffer
    for accel_putcs
  o [ATY128 FBDEV] Moved aty128fb to aty/ and a few minor changes so
    aty128fb.c compiles with the newest compiler standards
  o [FBDEV] Enhanced data buffer management for drawing very large
    images
  o [FBDEV] Menu cleanups. Added in depenedency needed. More cleanup in
    fbcon layer
  o [CONSOLE] Nuked a few gloabl variables. Now that the console system
    supports different sized screens these gloabl variables are a bad
    idea
  o [FBCON] Killing off more cursor fields in struct display. Use what
    is in struct vc_data
  o [FBCON] Cursor handling clean up. I nuked several static variables
  o [FBCON]More optimizations. Removed moving struct display around
  o [FBDEV] Killed of a static buffer in the generic software cursor.
    We didn't need it and it is a bad idea to have a static buffer is
    we have more than one framebuffer
  o [AMIGA FBDEV] Ported over to new api
  o [CONTROL/PLATNIUM FBDEV] Small cleanups to latest changes
  o [FBCON] Nuked the final gloabl variables for the cursor code
  o [GENERIC ACCELERATION] Fixed the generic image drawing function
    tfor 64 bit machines
  o Accel rountines pass in constant data into each function. The
    reason being was some of the code in the upper layers depended on
    the data being passed to the low level function not be altered
    because the upper layers was altering the data themselves
  o [RADEON FBDEV] Add cursor support. Now the cursor is back
  o [RIVA FBDEV] SUpprot Directcolor mode. Needed for some cards
  o [ATY FBDEV] Updates to support Rage Mobility Chipstes
  o [ATY FBDEV] Reversed mobilty patches. They busted every other card
  o [FBCON] Removal of useless code
  o [LOGO] New better logo code
  o [FBDEV] Data in struct fb_image is now const
  o Removed obsolete functions in fbcon.c and re-enabled mapping
    console(s) to a framebuffer device. A few compile fixes for rivafb
    and using standard macros for vgacon.c
  o [FBDEEV] Need to add support to build pnmtologo
  o [FBDEV] Minor fixes for logo code
  o [ATY FBDEV] Rage XL cards can now be booted with needed the BIOS
    :-)
  o [FRAMEBUFFER]: cfbcopyarea accesses fb without using
    FB_{READ,WRITE}L
  o [GENRIC ACCEL] Megred David Millers changes with my own
  o [FBDEV] Accelerated functions pass in const structs
  o [FBDEV] Updates for the SIS fbdev driver to the new api. Removed
    poll. We wil use signals in the future instead
  o [FBCON] Help clear margins for modes where the resolution does
    quite fit the console size
  o [TWIN TURBO FBDEV] Ported over to new api
  o [SIS FBDEV] Make it compile as a module
  o [SIS FBDEV] More sisfb driver updates
  o [FBDEV] Standardized using xxfb for setup strings
  o [SIS FBDEV] Added Maintiner for SIS fbdev driver
  o [FBDEV] If a colormap contains no transparency information,
    fb_set_cmap() calls fb_setcolreg() with trans = 0. This causes all
    CLUT entries to be fully transparent on hardware that does have
    transparency information in the CLUT registers.
  o [FBDEV] Ug!!! For some reason BK keeps removing this change. I hope
    this is the last time I have to add it

Jaroslav Kysela <perex@suse.cz>:
  o ALSA update
  o ALSA update (0.9.2)

Jason McMullan <jmcmullan@linuxcare.com>:
  o USB HID: Ignore P5 Data Glove (2.4 and 2.5 patches)

Jeb Cramer <cramerj@intel.com>:
  o [E1000] Documentation/networking/e1000.txt updates
  o [E1000] Version, copyright, changelog and MAINTAINERS
  o [E1000] Spd/dplx abstraction; eeprom size changes
  o [E1000] IRQ registration fix
  o [E1000] Added 82541 & 82547 support
  o [E1000] Added MII support
  o [E1000] Modulus math removed
  o [E1000] Perform single PCI read per interrupt
  o [E1000] Tx Descriptor cleanup
  o [E1000] Read/Write register macro optimizations
  o [E1000] Compaq to HP branding change
  o [E1000] Whitespace changes
  o [E1000] Added Tx FIFO flush routine
  o [E1000] Added Interrupt Throttle Rate tuning support
  o [E1000] Controller wake-up thru ASF fix
  o [E1000] whitespace fix from previous patches
  o [E1000] NAPI re-insertion w/ changes

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] fix memleak in DMA test
  o [via-rhine] note that Roger is maintainer, in MAINTAINERS

Jens Axboe <axboe@suse.de>:
  o cdrom buffer too small
  o Check remailing length in ide-cd.c correctly

Jon Grimm <jgrimm2@us.ibm.com>:
  o [IPSEC]: Fix SKB alloc len in ip6_build_xmit
  o [SCTP] Add SCTP_SET_PEER_PRIMARY get/setsockopt
  o [SCTP]  Supported address types should be based on pf_family
  o [SCTP] Only consider C-E bundling up until C-E has been sent
  o [SCTP] Fix typo in tsnmap.c  (Norbert Kiesel)
  o [SCTP] Add SCTP_NODELAY sockopt and message delay (ardelle.fan)
  o [SCTP] Fix out_qlen (pending data) count
  o [SCTP] Receiver SWS prevention
  o [SCTP] Fix panic on close()

Jonathan Corbet <corbet@lwn.net>:
  o Request queue micropatch

Joshua Uziel <uzi@uzix.org>:
  o [SPARC64]: Fix up_clock_tick export

KANDA Mitsuru <mk@linux-ipv6.org>:
  o [IPV6]: Process all extension headers via ipproto->handler

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix a rather theoretical race if an NMI happens when a debug fault
    happens exactly on the sysenter entry path before the kernel stacks
    have been switched to the proper ones.
  o Fix sound driver timeout types. Again
  o Avoid warning with modern gcc's in xfrm_policy.c
  o Alan broke the build. Fix it thusly
  o Use '#ifdef' instead of '#if' to test CONFIG_xxxx variables. It
    works both ways, but anal compilers will warn about using
    identifiers that have never been defined in preprocessor expression
    statements.
  o Use '#ifdef' to check for CONFIG_xxx definitions
  o Avoid using the gcc-ism of creating an anonymous structure directly
    by having a cast followed by an initializer. It seems even gcc
    can't do it right anyway in some versions (as reported by Jens
    Axboe).

Luis F. Ortiz <lfo@polyad.org>:
  o [SPARC64]: Define IDE MAX_HWIFS like x86

Matthew Wilcox <willy@debian.org>:
  o PARISC update
  o [NET]: Optimize handling of CONFIG_NET=n

Nathan Scott <nathans@sgi.com>:
  o [XFS] First stage of behavior code cleanup - removes a bunch of
    unused macros related to read/write locking the behavior change.
  o [XFS] Export end_buffer_async_write, needed for unwritten extent
    support in XFS
  o [XFS] Implement support for unwritten extents in XFS
  o [XFS] Find more appropriate homes for uuid_t, timespec_t and
    xfs_dirent_t defs
  o [XFS] Remove unneeded initialisations to zero, formatting cleanups,
    remove a no-longer-correct-comment, fix up symlink error path code,
    several minor changes to help keep this code more in sync with 2.4.
  o [XFS] Fix permission checks for some ioctls.  Its now possible for
    ordinary users to use the preallocation calls if unwritten extents
    are enabled, and a couple of places where we were allowing
    operations if unwritten extents are enabled, but shouldn't have
    been, have been closed up.

Neil Brown <neilb@cse.unsw.edu.au>:
  o Fix a few MD bugs
  o Remove obsolete NFSD syscall varients

Oleg Drokin <green@linuxhacker.ru>:
  o USB: Memleak in drivers/usb/hub.c::usb_reset_device

Oliver Neukum <oliver@neukum.name>:
  o USB: fix to synchronous API regarding memory allocation

Osamu Tomita <tomita@cinet.co.jp>:
  o Support PC-9800 subarchitecture (9/14) NIC

Paul Mackerras <paulus@samba.org>:
  o PPC32: Make a ppc32 version of pcibios_resource_to_bus, which adds
    an offset where needed.
  o PPC32: Makefile tidy-up, mostly from Sam Ravnborg
  o PPC32: Fix asm/rtc.h so drivers/char/genrtc.c compiles
  o PPC32: Convert uses of ide_ioreg_t to unsigned long
  o PPC32: Fix ide_init_hwif_ports for powermac
  o update macintosh-specific headers
  o update via-cuda driver
  o SMP-safe macserial driver
  o update via-pmu driver
  o update MESH scsi driver
  o update mac53c94 scsi driver
  o fix powerbook media bay

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix ncpfs and rpcgss order in fs/Kconfig

Randy Dunlap <randy.dunlap@verizon.net>:
  o USB: reduce stack usage in cdc-ether
  o reduce stack in cdrom/optcd.c
  o reduce stack in wireless/airo.c

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Minor updates/fixes to ARM PCI support code
  o [ARM] Fix timeouts to use the correct type
  o [ARM] Remove explicit IRQ disable/enable in PXA timer IRQ
  o [ARM] Add typechecking to local_irq_save()
  o [ARM] Update CLPS7500 support
  o [ARM] Distinguish between the various oops messages better
  o [ARM] Ensure transmitter starts before leaving ssp_write_word()
  o [ARM] Fix more timeouts to use correct type
  o [ARM] Add L1_CACHE_SHIFT to asm-arm/cache.h
  o [ARM] Update Acorn SCSI drivers
  o [ARM] Fix CONFIG_CPU_FREQ_GOV_USERSPACE warning
  o [ARM] Remove head-netwinder.S

Scott Feldman <scott.feldman@intel.com>:
  o [E100] back out memleak patch cuz it messed up following
  o [E100] Update Documentation/networking/e100.txt
  o [E100] update version, copyright year, changelog
  o [E100] Spelling mistakes
  o [E100] Add support for VLAN hw offload
  o [E100] Clean up #include order
  o [E100] Bug fix on setting up Tx csum
  o [E100] Banish strong branding marketing strings
  o [E100] forced speed/duplex link recover
  o [E100] ICH5 support added
  o [E100] Honor WOL settings in EEPROM
  o [E100] interrupt handler free fix
  o [E100] Validate updates to MAC address
  o [E100] ethtool EEPROM and GSTRING fixes
  o [E100] ASF wakeup enabled, but only if set in EEPROM
  o [E1000] Increase default Rx descriptors to 256

Sridhar Samudrala <sri@us.ibm.com>:
  o [SCTP] accept() support for TCP-style SCTP sockets
  o [SCTP] Minor changes for tcp-style socket support

Stephen Lord <lord@sgi.com>:
  o [XFS] initialize the iovec length in symlink cases
  o [XFS] If cmn_err is called with a CR character at the end of the
    input then do not add one.
  o [XFS] remove _KERNEL from the flags used to turn macros into
    functions
  o [XFS] rework readdir to be closer to the irix model internally, do
    all the filldir fixup at the linvfs layer. This is the V2 directory
    component, the V1 code still needs fixing up. We now return the
    same directory offsets as Irix does.
  o [XFS] validate_fields is called on a vnode to update directory
    related fields after a create/remove etc. Make sure we pass in all
    the flags for the status fields we want. NBLOCKS was missing and
    working by accident.
  o [XFS] prevent readdir from returning offsets of more than 2^31,
    these confuse user space. This limits the maximum amount of names
    in a directory on linux to 2Gbytes, which should not be a problem.
  o [XFS] remove a couple more sync transactions from xfs
  o [XFS] fix a couple of kmem issues, check for OOM in kmem_relalloc
    more and in the out of mem case, panic in the sleep case, not the 
    non-sleep case.
  o [XFS] remove bad debug code
  o [XFS] move vn_alloc stat from xfs_iget to vn_initialize
  o [XFS] reduce byte swapping and spinlock usage in log write path
  o [XFS] remove some unbounded loops from the unwritten and unmapped
    page processing code. As files get larger, these code paths have
    the potential to hog the cpu for long periods of time. Just cap the
    unmapped page case, and the unwritten one is supposed to be
    stopping at the end of the extent anyway.

Stephen Rothwell <sfr@canb.auug.org.au>:
  o compat_uptr_t and compat_ptr
  o [COMPAT] cleanups in net/compat.c and related files
  o fix typo in compat_ptr
  o another fix for compat_ptr

Steven Cole <elenstev@mesatop.com>:
  o i2c: spelling corrections for drivers/i2c

Thomas Walpuski <thomas@bender.thinknerd.de>:
  o [IPSEC]: Fix null authentication/encryption

Tom Lendacky <toml@us.ibm.com>:
  o [IPSEC]: Add IPV6_{IPSEC,XFRM}_POLICY socket option support
  o [IPSEC]: IPV6 source address not set correctly in xfrm_state

Ulrich Drepper <drepper@redhat.com>:
  o more generic syscall return value type fixes

