Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSFCB5r>; Sun, 2 Jun 2002 21:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317252AbSFCB5q>; Sun, 2 Jun 2002 21:57:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317251AbSFCB5o>; Sun, 2 Jun 2002 21:57:44 -0400
Date: Sun, 2 Jun 2002 18:56:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20
Message-ID: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ACPI merge, merges from Dave Jones, IDE updates, stuff from Andrew, PPC64
update, e100[0] driver updates, the works..

And no, I still haven't upgraded my changelog scripts, kill me.

		Linus

---
Summary of changes from v2.5.19 to v2.5.20
============================================

<achirica@ttd.net>
	o airo wireless net driver updates:

<agrover@dexter.groveronline.com>
	o more file renames
	o rename ACPI files to remove acpi_ prefix. Why did we ever name them that way?
	o Clean up code based on things flagged by lint
	o Properly (?) handle the multiple people who can find PCI root bridges
	o ACPI PCI IRQ Improvements:
	o ACPI Ancillary files update
	o move arch-dependent macros from drivers/acpi/include/platform/acenv.h
	o Code cleanups

Andrew Morton <akpm@zip.com.au>
	o direct-to-BIO writeback for writeback-mode ext3
	o remove PageSkip() macros
	o list_head debugging
	o rename block_symlink() to page_symlink()
	o remove inode.i_wait
	o buffer_boundary() for ext3
	o speed up writes
	o fix swapcache packing in the radix tree
	o dirsync support for minixfs, sysvfs and ufs
	o give swapper_space a set_page_dirty a_op
	o fix race between writeback and unlink
	o swapcache bugfixes
	o put in-memory filesystem dirty pages on the correct list
	o tmpfs bugfixes
	o rename flushpage to invalidatepage

<andersg@0x63.nu>
	o Renames struct bus_type to struct de4x5_bus_type in de4x5 net driver,

<anton@samba.org>
	o pSeries HVC console: add hvc initalisation
	o pSeries HVC console: add missing function prototype
	o ppc64 signal cleanup: remove old debug and sync with ppc32 signal code
	o pSeries HVC console: Disable interrupts in spinlock regions, fix from
	o ppc64: signal formatting cleanups
	o ppc64: SIGURG fix from Chris Yeoh
	o ppc64: cleanup 32 bit signal code
	o ppc64: SIGURG fix from Chris Yeoh
	o ppc64: update config.in
	o ppc64: fixes for 2.5.14
	o ppc64: fix compile error caused by machine type changes
	o ppc64: Add PREEMPT_ACTIVE and fix HMT macro typo
	o ppc64: missed this during Naca -> naca merge
	o ppc64: provide default_idle, we shouldnt ever actually use this but
	o ppc64: Add TIOCSTOP translation
	o ppc64: dont allow tlbiel on large pages.
	o add subsys_initcall for pcibios_init
	o ppc64: remove old code for stacking signals, its not used any more
	o ppc64: reduce differences to the ppc32 signal code.
	o ppc64: Take page_table_lock in flush_tlb_mm
	o ppc64: Be sure to zero the fpscr in a signal handler, otherwise
	o ppc64: Fix a number of problems with our exception reporting, in
	o ppc64: use common die() function in bad_page_fault, from ppc32
	o ppc64: Add Ingo's irq affinity stuff, from x86
	o ppc64: prevsp is not used any more
	o ppc64: Paul Mackerras' optimized power4 copy routines
	o ppc64: use generic debugger hooks instead of hardwiring xmon
	o ppc64: Add get/setaffinity syscalls, from sparc64
	o ppc64: dont print "xmon called", it garbles the output when multiple
	o ppc64: Up the gcc inline limited, needed for gcc 3.1
	o ppc64: No need to handle address space destruction in flush_tlb_mm,
	o ppc64: Provide a rough cache_decay_ticks.
	o ppc64 defconfig update
	o ppc64: Remove last_syscall, we can work the syscall out easily from
	o ppc64 segment table rework. We preload segments for both segment
	o ppc64: missed during segment handler rework
	o ppc64: Recent firmware removes the compatible property on pci bridges.
	o ppc64: Fix 32 bit execve to mirror recent generic changes
	o ppc64: kill MAP_NR, dont mark free_initmem as __init
	o ppc64: mask top 4 bytes of si_code
	o remove bogus panic in ppc32_select
	o ppc64: quota updates
	o ppc64: signal32 updates from Stephen Rothwell - comment changes
	o ppc64: more signal32 updates from Stephen Rothwell
	o ppc64: Add CONFIG_CMDLINE, from ppc32
	o ppc64: more signal32 updates from Stephen Rothwell - replace some
	o ppc64: last of the signal32 updates from Stephen Rothwell. Fantastic
	o ppc64: Fix clear_user, from ppc32

<anton@superego.(none)>
	o add pSeries hypervisor console

Jens Axboe <axboe@suse.de>
	o misc generic block tag fixes
	o documentation and tq_disk removals
	o Re: ufs compile error in 2.5.19]
	o update to the update

Martin Dalecki <dalecki@evision-ventures.com>
	o 2.5.19 IDE 76
	o 2.5.19 IDE 77
	o [PATCH} 2.5.19 IDE 79
	o 2.5.19 IDE 78
	o 2.5.19 IDE 82
	o 2.5.19 IDE 81
	o 2.5.19 IDE 80
	o 2.5.19 blk.h and more about the ugly kids.

<davej@suse.de>
	o dumb cpqarray init microoptimisation.
	o i386 mmx copying bug.
	o check misc_register result in efirtc
	o ps2esdi resource cleanups
	o region handling cleanups for gscd driver
	o i386 smp tweaks.
	o recognise 2 extra devices for xd.c
	o h8 janitor work
	o epca janitor work
	o dltk driver check_region -> request_region
	o ib700wdt janitor work
	o elsa check_region() -> request_region()
	o mixcomwd janitor work
	o esp janitor work
	o aztech CD driver janitor work
	o ite_gpio region handling cleanups
	o istallion janitor work
	o better sizing of queue_nr_requests
	o forward ioctls on raw devices to underlying devices
	o rtc max_user_freq sysctl
	o isicom check_region() -> request_region()
	o niccy region handling cleanups
	o teles3 region handling cleanups
	o Some includes that aren't needed.
	o Deliver SIGIO to FIFO and pipe devices
	o missing binfmt check
	o Fix deadlock in nbd
	o gazel region handling cleanups
	o Conversion of uidhash to use list_t
	o hd.c compilation fix.
	o avm_a1 check_region -> request_region cleanup
	o egcs no longer supported.
	o fill in empty hisax_fcpcipnp debug statement
	o add spinlocking to w83877f_wdt driver
	o struct super_block cleanup - adfs
	o missing GPL tags
	o Fix up agpgart.

<david-b@pacbell.net>
	o ehci remove warning if no CONFIG_USB_DEBUG

<david.nelson@pobox.com>
	o PATCH: USB Scanner Driver 0.4.8 and new maintainer

<davidm@napali.hpl.hp.com>
	o trivial keyboard driver patch
	o pass "page" pointer to clear_user_page()/copy_user_page()
	o time-offset patch
	o agp support for i460 and zx1 cleanup

<edward_peng@dlink.com.tw>
	o dl2k gige net driver updates:

<fdavis@si.rr.com>
	o 2.5.19 : drivers/mtd/nftlcore.c

<go@turbolinux.co.jp>
	o Fix pcnet32 net driver workaround for xSeries250.

<greg@kroah.com>
	o USB OHCI driver: Added SA1111 support
	o USB kernel-api documentation fix

<kai@tp1.ruhr-uni-bochum.de>
	o kbuild: Add (internal) prepare target
	o kbuild: Don't rebuild if vmlinux if nothing changed - fix
	o kbuild: clean up generation of modversions.h
	o kbuild: Clarify the CONFIG_MODVERSIONS logic
	o kbuild: Use the real instead of a phony target if we have one
	o kbuild: Group targets which need / don't need .config
	o kbuild: Get rid of -DMODVERSIONS, further cleanup

<mdharm@one-eyed-alien.net>
	o USB storage: Dead code, more abort cleanups, and detached device fix

<mochel@osdl.org>
	o PCI: Make sure id_table is passed to probe callback
	o PCI Update:
	o Device Model: Add helpers bus_for_each_dev and bus_for_each_drv
	o Device Model: Implement centralized device/driver binding
	o PCI: Put pci_match_device back for the people that are still using it.
	o USB: define usb_bus_type and register on startup 
	o driverfs update:
	o USB: Move URB request code from usb.c to urb.c 
	o USB:
	o USB: Move synchronous message passing code from usb.c to message.c
	o USB: Move configuration parsing code from usb.c to config.c
	o driverfs: Remove default 'status' file: it had no useful read information, the commands it supported were minimal and probably broken and the comments were wrong.
	o device model: remove flags parameter from struct device_driver::remove and fix all users
	o device model: Use driver_for_each_dev to unbind drivers from its devices (now that it's implemented)
	o devicemode: Implement driver_for_each_dev 

<pavel@ucw.cz>
	o suspend-to-ram: clean up according to Andy
	o eepro100 net driver trivial cleanup:

<pazke@orbita1.ru>
	o Janitor: Add __devinit markers to two net drivers, epic100 and sundance

<petr@vandrovec.name>
	o de4x5 does not compile in 2.5.19 due to bus_type conflict
	o missing argument to clear_user_page in v4l

<rmk@flint.arm.linux.org.uk>
	o [ARM] Fix makefiles for drivers/acorn/{block,char}/
	o [ARM] 2.5.18 Update ARM for TLB shootdown changes
	o [ARM] Remove redundant instruction cache code from decompressor.
	o [ARM] Tidy up context switch save area initialisation for fork
	o [ARM] Remove victor machine type
	o [ARM] cpufreq_init takes low and high frequency limits.
	o [ARM] Remove an extraneous load from atomic ops
	o [ARM] Context switch improvements
	o [ARM] Convert for() delay loops to udelay()
	o [ARM] Remove hard coded per-architecture memory, ramdisk and initrd

<romieu@cogenit.fr>
	o drivers/net/wan/dscc4.c - gross overflow

<rusty@rustcorp.com.au>
	o softirq.c per_cpu fix
	o AUDIT 2.5.19: Continuing copy_to/from_user & clear_user

<scott.feldman@intel.com>
	o Add ETHTOOL_PHYS_ID ethtool command to linux/ethtool.h.
	o e1000 net driver updates 2/4:
	o e100 net driver update:
	o e1000 net driver update 1/4:
	o e1000 net driver update 3/4:
	o e1000 net driver update 4/4:

<sfr@canb.auug.org.au>
	o APM patch for idle_period handling
	o missing bit from signal patches

<shaggy@kleikamp.austin.ibm.com>
	o Fix free-space leak truncating files in JFS.
	o JFS: cleanup dbAlloc
	o JFS: misc stuff for 2.5
	o JFS: metapage changes
	o JFS: support for kNFSD

<torvalds@home.transmeta.com>
	o Fix up ACPI makefile that got broken by the merge.
	o Fix PCI irq routing to always look up the bridge swizzling
	o Make qla1280 driver print out irq information along with bus location.
	o Allow <linux/list.h> to be used even without NULL defined yet.
	o Simplify uidhash table allocation - no need to make it dynamic,
	o idescsi initialization is done with module_init(), not
	o Proper usage of isupper/tolower for build scripts.
	o Kernel version 2.5.20
	o Felipe W Damasio: add KERN_* to 3c501 driver printk's
	o Fix missing piece of uidhash list conversion
	o Simplify tlb_flush_mmu() for exit case: makes it easier on the ia64

<trini@kernel.crashing.org>
	o Fix RAMDISK config problem
	o Missing include in drivers/base/bus.c and drivers/pci/pci-driver.c

