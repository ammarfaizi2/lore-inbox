Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSKREew>; Sun, 17 Nov 2002 23:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSKREew>; Sun, 17 Nov 2002 23:34:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261449AbSKREem>; Sun, 17 Nov 2002 23:34:42 -0500
Date: Sun, 17 Nov 2002 20:41:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.48
Message-ID: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. All over the place, best you see the changelog. Lots of small 
cleanups (remove unnecessary header files etc), but a few more fundamental 
changes too. Times in nsecs in stat64(), for example, and the 
oft-discussed kernel module loader changes..

		Linus


Summary of changes from v2.5.47 to v2.5.48
============================================

<aebr@win.tue.nl>:
  o Add 'needed for mouse and keyboard' comments to Kconfig to make
    configuration of mouse and keyboard support more obvious.

<khaho@koti.soon.fi>:
  o Re: USB scanner fix for 2.5.47 was not good  ?

<kronos@kronoz.cjb.net>:
  o I found a missing '\n' in serio.c:118. This prevents the next
    printk to be interpreted correctly.

<mikal@stillhq.com>:
  o Handle return values from interface_register() and misc_register()
    in the input drivers.

<pasky@ucw.cz>:
  o Add defaults for the most needed keyboard/mouse options

<varenet@parisc-linux.org>:
  o Remove unused variable

Adrian Bunk <bunk@fs.tum.de>:
  o trivial compile fix for pxa-regs.h

Alexander Viro <viro@math.psu.edu>:
  o CLONE_NEWNS fix
  o sys_swapoff() cleanup
  o paride/pseudo.h cleanup
  o late-boot cleanups
  o dm_ioctl() fix
  o >pmtu compile fix
  o bdevname() cleanups
  o bd_dev cleanups
  o dasd fixe and cleanups
  o misc cleanups
  o dv1394 devfs use
  o dm use of devfs
  o paride.c fed through Lindent
  o eliminated use of devfs_auto_unregister() in checks.c
  o cleaned up callers of devfs_mk_dir()
  o devfs_register_tape() cleanup
  o gratitious MOD_INC_USE_COUNT
  o paride protocols switched to ->owner
  o late-boot fixes
  o devfs_remove() helper
  o more bogus MOD_INC_USE_COUNT removals
  o fix for rescan_partitions()

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPSEC]: More fixes and corrections
  o [UDP]: silly bug, local input policy did not work on udp sockets
  o [IPSEC]: ah/esp, 0 was used as  tunnels protocol
  o [IPSEC]: authentication signature for MD5/SHA was not truncated to
    conform RFC
  o [IPSEC]: More pfkey2 semantic fixes

Andi Kleen <ak@muc.de>:
  o nanosecond stat timefields

Andrew Morton <akpm@digeo.com>:
  o timers: drivers/
  o timers: sound/
  o timers: fs/
  o [NET]: More timer init fixes
  o direct-io bio_add_page fix
  o mbcache: add gfp_mask parameter to free() callback,
  o run flush_cache_page while pte is valid
  o unlock_page when get_swap_bio fails
  o handle pages which alter their ->mapping
  o misc fixes
  o hugetlb cleanups
  o more hugetlb fixes
  o improved slab error diagnostics
  o try to remove buffer_heads from to-be-reaped inodes
  o kmap->kmap_atomic in mpage.c
  o better inode reclaim balancing

Andy Grover <agrover@groveronline.com>:
  o ACPI: Interpreter update to fix mutex wait problem This changes the
    timeout param around the interpreter to a u16, so that
    ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to
    mean "wait forever".
  o ACPI: bus.c needed device.h included
  o ACPI: Correctly init device struct, permissing proper
    unloading/reloading (John Cagle)
  o ACPI: Interpreter update to 20021111 - Adds support for SMBus
    OpRegions
  o ACPI: Make unload/reload of modules work properly w.r.t. /proc
  o ACPI: Do not compile code for EC unloading, because it cannot be
    unloaded atm

Anton Blanchard <anton@samba.org>:
  o [SPARC64]: In sys32_sched_getaffinity, put mask back to user if
    ret > 0

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o arp: fix seq_file support
  o ipv4: convert /proc/net/netstat to seq_file
  o ipv4: convert /proc/net/snmp to seq_file
  o ipv4: convert /proc/net/sockstat to seq_file
  o ipv4: convert /proc/net/raw to seq_file
  o Fix up after header file cleanups: add <linux/mount.h> to quota
    that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to cifs that
    got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to hugetlbfs
    that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to
    intermezzo that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to jffs2
    that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to ntfs that
    got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to
    pci_hotplug_core that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to smbfs
    that got it implicitly before.
  o Fix up after header file cleanups: add <linux/mount.h> to dquot
    that got it implicitly before.
  o ps2esdi: fixups after header file cleanups
  o xd: fixup after header files cleanups: add include
    <linux/interrupt.h>
  o cpqarray/cciss: fixup after header files cleanups: add include
    <linux/interrupt.h>
  o mcd/mcdx: fixup after header files cleanups: add include
    <linux/interrupt.h>
  o tp3870i: fixup after header files cleanups: add include
    <linux/interrupt.h>
  o mtpav: fix up header file cleanup: add include
    <linux/interrupt.h>
  o ncpfs: fix up header cleanup: forward declare struct sock
  o sound: fix up header cleanups: add include <linux/interrupt.h>
  o char: fix up header cleanups: include linux/interrupt.h

Art Haas <ahaas@airmail.net>:
  o C99 designated initializers for arch/s390
  o C99 designated initializers for arch/mips64
  o C99 designated initializers for drivers/ide/pci (2 of 2)
  o C99 designated initializers for arch/arm
  o C99 designated initializers for arch/ppc64
  o C99 designated initializers for arch/v850
  o C99 designated initializers for arch/mips
  o C99 designated initializer for arch/alpha/kernel/sys_jensen.c
  o C99 designated initializers for arch/s390x
  o C99 designated initializers for arch/cris
  o C99 designated initializers for drivers/ide/pci (1 of 2)
  o C99 designated initializers for drivers/char/agp
  o C99 designated initializers for drivers/macintosh
  o C99 designated initializer for drivers/usb/media/vicam.c
  o C99 designated initializers for arch/i386

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: Do not NULL conswitchp when serial_console
  o [TG3]: TG3_HW_STATUS_SIZE should be 0x50 not 0x80

Ben Fennema <bfennema@falcon.csc.calpoly.edu>:
  o UDF sync with CVS

Brian Gerst <bgerst@didntduck.org>:
  o Emu10k1 gameport fix

Christoph Hellwig <hch@lst.de>:
  o get rid of ->detect for upper layer drivers
  o remove some dead declarations from the scsi headers
  o move all procfs code to scsi_proc
  o nuke some crap from fs.h
  o include mount.h explicitly were needed
  o don't include mount.h in dcache.h
  o move mount.h out of fs_struct.h
  o fork.c bits for uClinux
  o don't include net.h in fs.h
  o move scsi_reset_provider to scsi_error.c
  o pull even more crap out of fs.h

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o Add fs/jfs/acl.c

David Brownell <david-b@pacbell.net>:
  o <linux/device.h> KERN_WARN(ING)
  o usbtest, add some unlink testcases
  o usbnet Kconfig helptext
  o USB: update usb hotplug documentation
  o ehci-hcd, use dummy td when queueing
  o usb problems (ohci-hcd + printer)
  o usb sysfs shows bNumConfigurations
  o usb_new_device() sets up dev->dev earlier
  o cleanup usb hcd unlink code
  o ohci-hcd, driverfs files work again, less debug output
  o HID patches for MGE UPS

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Fix accidental clobbering of register on cheetahplus
  o net/ipv4/arp.c: Fix compiler warning
  o [IPSEC]: Make netlink user interface header
  o kernel/module.c: Kill warnings on egcs-2.9x and 64-bit
  o drivers/net/sk98lin/skge.c: Kill useless init_module/cleanup_module
    forward declarations
  o drivers/net/skfp/skfddi.c: Kill useless init_module/cleanup_module
    forward declarations
  o drivers/net/tulip/de4x5.c: Kill useless init_module/cleanup_module
    forward declarations
  o [SPARC]: Updated module support
  o net/ipv6/af_inet6.c: Remove extraneous #endef
  o [SPARC]: More new modules work
  o [IPSEC]: Netlink xfrm configuration interface
  o [XFRM_USER]: Fix xfrm_find_acq args
  o [XFRM_USER]: Destroy netlink socket on shutdown
  o [XFRM]: Add family member to state/policy structs
  o Fix tg3 net driver to properly disable interrupts during some TX
    operations

David Woodhouse <dwmw2@infradead.org>:
  o psmouse.c: First check for a Synaptics touchpad, other probes
    confuse it enough to disable the trackpoint.

Davide Libenzi <davidel@xmailserver.org>:
  o remove code duplication from fs/eventpoll.c
  o epoll bits 0.46
  o epoll bit 0.47
  o epoll - just when you think it's over

Doug Ledford <dledford@aladin.rdu.redhat.com>:
  o mptscsih.h: compile fix
  o scsi.c
  o Update high level scsi drivers to use struct list_head in templates
    Update scsi.c for struct list_head in upper layer templates Update
    scsi.c for new module loader semantics
  o aic7xxx_old: fix check_region/request_region usage so that the
    module may be loaded/unloaded/reloaded
  o Christoph Hellwig posted a patch that conflicted with a lot of my
    own changes, so this is the merge of his work into my own.
  o module.c: allow modules to enter themselves during mod init
  o pci/setup-bus.c: Fix compile bustage from pci header cleanup

Douglas Gilbert <dougg@torque.net>:
  o scsi_debug 1.64 , remove detect(), "hotplug" hosts
  o scsi_mid_low_api.txt
  o scsi_debug 1.64 against 2.5.47
  o [update] scsi_mid_low_api.txt

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Fix dyslexia in Amiga keyboard driver

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fixed up the wording of the bluetty driver's help entry to be
    stronger
  o USB: changed USB_UHCI_HCD_ALT to USB_UHCI_HCD as there is only one
    driver
  o kernel.h: changed #if DEBUG to #ifdef DEBUG to play nicer with
    compilers
  o USB: hcd.c: move #ifdef CONFIG_USB_DEBUG statement around a bit
  o USB: fixup previous missed hunk in vicam patch

Hugh Dickins <hugh@veritas.com>:
  o loop sendfile retval

Ingo Molnar <mingo@elte.hu>:
  o threading fix, tid-2.5.47-A3

Jeff Dike <jdike@uml.karaya.com>:
  o A bunch of miscellaneous changes - mostly fixes from 2.4 and
    updates to 2.5.43.
  o A number of small fixes
  o The block driver supports partitions again
  o Merged the 2.5.44 ubd driver changes
  o Updated to work as 2.5.44
  o Updated to 2.5.45
  o A small Makefile change
  o Updates to 2.5.47

James Bottomley <jejb@mulgrave.(none)>:
  o add request prep functions to SCSI
  o warn (and don't attach) if no error handling
  o [SCSI] downgrade lack of eh to warning and stack dump
  o [SCSI] minor fixes
  o fix potential panic due to scsi_init_io failure [axboe@kernel.dk]
  o move sd_init_onedisk so that the disk name is usable
  o final tidy up of hch/dledford merger
  o Tidy up compile warnings in scsi.c

James Morris <jmorris@intercode.com.au>:
  o [AF_KEY]: Fix alloc_skb args

Jens Axboe <axboe@suse.de>:
  o incorrect block layer segment accounting

Jes Sorensen <jes@trained-monkey.org>:
  o rrunner PCI DMA mappings

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: config update
  o ISDN: Missed conversion in drivers/isdn/i4l/isdn_net_lib.c
  o ISDN: Fix some typos
  o ISDN: Eicon driver fixes
  o ISDN: Eicon driver indent
  o ISDN: More Eicon driver cosmetics
  o kbuild: Indicate building modules in non-verbose mode
  o ISDN: Fix Kconfig typo

Linus Torvalds <torvalds@home.transmeta.com>:
  o Re-introduce __MODULE_STRING, since some drivers depend on it
  o Fix impressive call gate misuse DoS reported on bugtraq
  o Duh. Fix the other lcall entry point too
  o Merge Radeon driver updates from DRI CVS (add support for R200 cube
    map registers)
  o Update r128 driver to DRI CVS tree. Add getparam and vblank irq
    handling.
  o MGA driver update to DRI CVS (3.0.2 -> 3.1.0). Add vblank
    interrupt, DMA blit and getparam support.
  o i810 driver update to DRI CVS tree: use pci_alloc_consistent
    instead of home-brew PCI allocations.
  o i830 driver update to DRI CVS tree: use pci_alloc_consistent
    instead of home-brew PCI allocations.
  o Merge with DRI CVS tree: handle lack of AGP gracefully
  o Fix up after pci name removal
  o Fix up after header file cleanups: add <linux/mount.h> to NFSD
    users that got it implicitly before.
  o Make sure we clean user_tid when we've released the memory space it
    was associated with.
  o Fix up missing "struct iovec" declaration that was lost in
    <linux/fs.h> cleanups
  o Add forgotten system call number for set_tid_address()
  o Initialize exception tables early - don't use an initcall, since
    they are needed for early arch initialization.
  o Fix up devfs handling for when it is disabled
  o Fix more CONFIG_MODULE_UNLOAD issues

Maciej W. Rozycki <macro@ds2.pg.gda.pl>:
  o Make it clearer that the atkbd.c driver is for PS/2 keyboards as
    well in the Kconfig help text.

Manfred Spraul <manfred@colorfullife.com>:
  o additional cleanup for f_op->poll
  o yenta resource handling bugs
  o drivers/char/raw.c
  o fs/autofs/dirhash.c
  o drivers/pcmcia/i8???.c

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb storage: remmove unneeded abort checks
  o usb storage: remove duplicate functions
  o usb storage: fix aborted auto-sense
  o usb storage: fix spelling, comments
  o usb storage: remove unneeded workaround for START_STOP

Matthew Wilcox <willy@debian.org>:
  o Mux driver for PA-RISC
  o Remove d_path from sched.h
  o Move fd-related functions from sched.h to file.h
  o Move request_irq & free_irq to interrupt.h
  o Move wait queue handling from sched.h to wait.h
  o remove sched.h from blkdev.h
  o remove sched.h from atmdev.h
  o remove sched.h from input.h
  o remove sched.h from nfsd/cache.h
  o remove sched.h from parport.h
  o eliminate pci_dev name
  o remove sched.h from if_pppox.h
  o remove sched.h from i2c.h
  o remove sched.h from ftape.h
  o remove sched.h from elf.h
  o remove sched.h from coda_linux.h
  o Add some missing includes to drivers/base
  o Run timers as softirqs, not tasklets

Patrick Mansfield <patmans@us.ibm.com>:
  o dynamic device info flag entries
  o remove scsi_host_hn_list

Pavel Machek <pavel@ucw.cz>:
  o swsusp: rewrite critical parts to assembly

Pete Zaitcev <zaitcev@redhat.com>:
  o include/asm-sparc/elf.h: Include uaccess.h
  o [SPARC]: Move LDFLAGS_BLOD define out from NEW_GAS test
  o [sparc] Fix off-by-one in s/g handling

Randy Dunlap <randy.dunlap@verizon.net>:
  o usblp buffer allocation (2.5.47)

Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>:
  o [PATCH 0/2] clean up scsi documentation
  o clean up scsi documentation
  o clean up scsi documentation

Russell King <rmk@arm.linux.org.uk>:
  o Here's a patch that makes the RiscPC input bits work in 2.5

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Cleanup ARM configuration
  o [ARM] Clean up includes
  o [ARM] Fix flush_dcache_page()
  o [ARM] Optimise set_pmd
  o [ARM] Finally kill old ecard device discovery interfaces
  o [ARM] Move ARMv4 wbi functions to separate file

Rusty Russell <rusty@rustcorp.com.au>:
  o [Trivial Patch] scsi_register 1-8
  o KBUILD_MODNAME define for build system
  o In-kernel Module Loader
  o New Module Loader: x86 support
  o Fix module loader compile bug
  o Sparc and Sparc64 Module updates
  o module_name macro
  o separate out moduleloader.h
  o Allocate struct module using special allocator
  o add strcspn() library function
  o Forced module unload
  o Export module_dummy_usage

Sam Ravnborg <sam@mars.ravnborg.org>:
  o [ARM] makefile cleanup Added prerequisite FORCE in several rules,
    now kbuild build a kernel even the second time you try.

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o cleanup: switch to passing *(struct rpc_procinfo) in rpc_message
  o More rpc cleanup

Vojtech Pavlik <vojtech@suse.cz>:
  o Rescan a serio port in serio.c only when a character comes from it
  o Add Logitech Wheel Mouse to the list of Logitech mice that have a
    wheel in mousedev.c
  o atkbd.c: Only issue the set LED command during probe when
    absolutely needed
  o Remove dead logibusmouse.h
  o hid-input.c:  Back out a (wrong) find_next_zero_bit() patch from
    Arnaldo Carvalho de Melo
  o Fix open counting in usbkbd.c and usbmouse.c in case the irq urb
    submit fails. Bug spotted by Thiemo Seufer.
  o Some fixes after conflict merge, in rpcmouse.c and rpckbd.c


