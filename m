Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSHAV1X>; Thu, 1 Aug 2002 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHAV1X>; Thu, 1 Aug 2002 17:27:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17165 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317140AbSHAV1R>; Thu, 1 Aug 2002 17:27:17 -0400
Date: Thu, 1 Aug 2002 14:30:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.30
Message-ID: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tons of stuff all over the map again. Lots of merging with various people.

The most noticeable fix (for me personally) was Trond fixing a nasty RPC
problem that caused the NFS client to return bogus dentry pointers that
hung the VFS layer hard on SMP machines.

But as you can see from the "short" changelog version (the full one is 
63kB), there's a lot of other stuff there.

		Linus

----

Summary of changes from v2.5.29 to v2.5.30
============================================

<ahaas@neosoft.com>:
  o designated initializer patches for

<colpatch@us.ibm.com>:
  o Adaptec Starfire config fix

<da-x@gmx.net>:
  o Make s390 and s390x print the right freed init memory size

Martin Dalecki <dalecki@evision.ag>:
  o 2.5.29 IDE 108 - 111

<dgibson@samba.org>:
  o PPC32: clean up the initial mapping of RAM, allow for large-page
    mappings

<felipewd@terra.com.br>:
  o [PATCH[ 8139cp comment fix

<gbarzini@virata.com>:
  o [ARM PATCH] 1179/1: ldm/stm alignement fixups: treat 920T the same
    as 922T The check in do_alignment_ldmstm for addr and eaddr being
    the same is #ifdef'd

<gnb@alphalink.com.au>:
  o kconfig choice defaults 2 (3_3)
  o 2.5: kconfig EXPERIMENTAL variant form
  o 2.5: kconfig spurious EXPERIMENTAL 3 (2_2)
  o 2.5: kconfig spurious bool default value (1_3)
  o 2.5: kconfig spurious EXPERIMENTAL 3 (1_2)
  o 2.5: kconfig missing EXPERIMENTAL 4 (1_4)

<hch@lst.de>:
  o implement kmem_cache_size()
  o update dqblk_xfs.h inclusion guards
  o reparent scsi new-EH threads to init
  o explicit signed char cast in i386 spin_is_locked
  o silence APIC errors a bit
  o documentation typos in

<ica2_ts@csv.ica.uni-stuttgart.de>:
  o Fix typo in mm_slab.c
  o Fix typo in net_ipv4_ipconfig.c

<james@cobaltmountain.com>:
  o Typo in linux_net_sched_sch_ingress.c
  o Typos in linux_arch_i386_kernel_io_apic.c

<johann.deneux@it.uu.se>:
  o Small fix to assign continuous values to KEY_*

<maalanen@ra.abo.fi>:
  o using ptr after kfree()

<marcel@holtmann.org>:
  o Bluetooth Subsystem PC Card drivers update

<matthew@wil.cx>:
  o LSM file locking patch is bogus

<mulix@actcom.co.il>:
  o sound/oss/trident.c [1/2] merge driver from 2.4-ac
  o sound/oss/trident.c [2/2] remove cli/sti calls

<oleg@tv-sign.ru>:
  o fix Thread-Local Storage GDT access

<rfjak@eircom.net>:
  o 2.5 Trivial patch - 1400x1050 video mode added twice in 2.5.28

<sam@mars.ravnborg.org>:
  o kbuild: Add new define do_cmd do_cmd is a nice shorthand when
    creating rules that in one line shall adhere to KBUILD_VERBOSE and
    make -s.
  o docbook: parportbook dependencies and do_cmd
  o kbuild: fix warnings in fixdep when compiled with -pedantic

<th122948@scl1.sfbay.sun.com>:
  o Lindent drivers/char/nvram.c in anticipation of more patching
  o clean up 'return (x);' style stuff into 'return x' in nvram.c

<tomlins@cam.org>:
  o fix UP links - current bk tree

<willy@debian.org>:
  o fs/locks.c: eliminate locks_unlock_delete

<wli@holomorphy.com>:
  o PAE compile fix
  o remove declaration of __free_pte()

<zwane@linuxpower.ca>:
  o parport_serial/serial init dependencies

Adam J. Richter <adam@yggdrasil.com>:
  o fix do_open() interaction with rd.c

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 2.5.29 Fix pnpbios
  o 2.5.29 Fix cmd640 config locking
  o cs5530 IDE driver cli/sti fixes and cleanups

Alexander Viro <viro@math.psu.edu>:
  o Get rid of per-partition blk_size[]
  o split "gendisk" to be per-disk, parts 1-2

Anders Gustafsson <andersg@0x63.nu>:
  o Add argument to synchronize_irq in cs46xx

Andrew Morton <akpm@zip.com.au>:
  o misc fixes
  o use a slab cache for pte_chains
  o show_free_areas() cleanup
  o speed up pte_chain locking on uniprocessors
  o optimise struct page layout
  o for_each_pgdat macro
  o for_each_zone macro
  o strict overcommit
  o use c99 initialisers in ext3
  o direct IO updates
  o permit modular build of raw driver
  o put_page() uses audited
  o restore lru_cache_del() in truncate_complete_page
  o Re: BUG at rmap.c:212

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o partition fix

Anton Blanchard <anton@samba.org>:
  o make cpu_relax a barrier on all architectures
  o fix compile warning
  o fix warning

Brad Hards <bhards@bigpond.net.au>:
  o Change the EVIOC?ABS ioctls to use structs rather than arrays of
    ints

Christoph Hellwig <hch@sb.bsdonline.org>:
  o VFS: implement sendfile file operation
  o Remove kHTTPD
  o Implement down_read_trylock() and down_write_trylock() and add a
    generic spinlock implementation for downgrade_write().
  o VM: remove unused /proc/sys/vm/kswapd and swapctl.h

Christopher Hoover <ch@hpl.hp.com>:
  o [ARM PATCH] 1199/1: ISA Macros expected for platforms This makes
    IRDA happy.

Dave Hansen <haveblue@us.ibm.com>:
  o fix e1000 after irq craziness

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Remove d_delete call from jfs_rmdir and jfs_unlink

David Brownell <david-b@pacbell.net>:
  o ohci, control/enumeration fix

David Howells <dhowells@redhat.com>:
  o export rwsem downgrade function

David Woodhouse <dwmw2@infradead.org>:
  o Revert some bogus changes from mainline -- an over-excessive
    search/replace and some BKL additions from someone who evidently
    didn't bother to look at either the code they were modifying or the
    documentation in README.Locking which explicitly states the BKL is
    not needed.
  o Remove licensing noise from individual JFFS2 files to refer to a
    single 'LICENCE' file, which contains the new licence info. JFFS2
    is no longer dual-licensed under RHEPL and  GPL; eCos is now GPL'd
    (with an exception for linking application) and hence so is JFFS2.
  o JFFS2 update
  o JFFS2 compile fixes for latest kernel
  o Switch JFFS2 to C99 named initialisers
  o Prevent crash after mounting JFFS2 images built with incorrect
    erase size
  o Remove cli() from R3964 line discipline

Eric Sandeen <sandeen@sgi.com>:
  o wan/sdla_chdlc.c oops fix

franz.sirl@lauterbach.com <Franz.Sirl@lauterbach.com>:
  o Hi Vojtech, some superflous keyboard stuff came back with the last
    PPC merge to Linus. This patch fixes that. Please apply.

Greg Kroah-Hartman <greg@kroah.com>:
  o Removed devfs_register_chrdev and devfs_unregister_chrdev
  o Removed devfs_register_blkdev and devfs_unregister_blkdev
  o Remove the devfs_should* functions I added, and replace them with
    one devfs_only() call

Hugh Dickins <hugh@veritas.com>:
  o shmem_file_write rounding VM_ACCT
  o SHMEM_MAX_BYTES overflow checking
  o mremap MAP_NORESERVE not in flags
  o mmap MAP_NORESERVE not in vm_flags
  o remove unhelpful vm_unacct_vma
  o fix shared and private accounting
  o update overcommit doc and comment
  o shmem_file_setup when MAP_NORESERVE
  o remove acct arg from do_munmap
  o C99 initializers for mm

Ingo Molnar <mingo@elte.hu>:
  o fix synchronize_irq() bug
  o APM fixes, 2.5.29
  o Re: Limit in set_thread_area
  o sched-2.5.29-B1
  o sanitize TLS API

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o alpha pid-reporting POSIX comformance bug fix

Jens Axboe <axboe@suse.de>:
  o fix REQ_QUEUED clearing in blk_insert_request()
  o misc elevator/block updates

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix compiling/installing as different users
  o kbuild: Fix net/8022 selections
  o kbuild: Make scripts/compile.h when sh != bash
  o kbuild: Fix "export-objs"
  o kbuild: Fix double vmlinux link

Linus Torvalds <torvalds@home.transmeta.com>:
  o Move cmd640_lock outside the CONFIG_BLK_DEV_CMD640_ENHANCED test,
    since it is needed regardless.
  o Since "access_process_vm()" releases pages that can be in the page
    cache, it needs to use page_cache_release() instead of plain
    "put_page()".
  o Make "cpu_relax()" imply a barrier, since that's how it is used.
  o Cset exclude: mingo@elte.hu|ChangeSet|20020728030719|07783
  o Leftover from trident cli/sti removal
  o parport: fix warning - "flags" is unused after cli/sti removal
  o Do x86 "kernel_thread()" explicitly by hand, instead of using a
    system call from kernel space. 
  o We'd better BUG out inside the NFS code rather than return a bogus
    dentry pointer to the VFS layer (which would oops on it inside the
    dcache lock).
  o Rename "sys_pread/pwrite" to "sys_pread64/pwrite64" to match the
    actual implementation and avoid confusion.
  o Update file lock security check to match the API change
  o Chris Wright points out that this was also missed in the file
    locking LSM update
  o Split up "do_fork()" into "copy_process()" and "do_fork()"
  o Undo d_drop removal at Trond's request Cset exclude:
    torvalds@home.transmeta.com|ChangeSet|20020801011106|51286
  o Fix missing semicolon from gendisk work

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o SCSI INQUIRY transfer length fix
  o SCSI MODE_SENSE transfer length fix

Mikael Pettersson <mikpe@csd.uu.se>:
  o typo in fs_ufs_super.c:ufs_fill_super()
  o drm_mga bitops -> long fix
  o ftape bitops -> long fix

Patrick Mochel <mochel@osdl.org>:
  o driverfs: use dentry->d_subdirs list instead of our own list when
    removing directory
  o driverfs: Do hashed lookup of dentry's when deleting a driverfs
    file (instead of searching the list we keep)
  o driverfs: don't do addition/deletion of driver_file_entry's into
    local lists, as we don't use the lists anymore
  o driverfs: Remove struct driver_dir_entry::files, since it's not
    being used anymore
  o driverfs: Remove references to struct driver_file_entry::dentry, as
    we don't use it for anything useful anymore.
  o driverfs: Don't put the driver_file_entry in struct
    inode::u.generic_ip or struct file::private_data (since it's
    already in struct dentry::d_fsdata and we always get to that)
  o driverfs: use the parent directory's struct driver_dir_entry (in
    struct dentry::d_fsdata) to access the struct device, rather than
    via struct driver_file_entry::parent pointer.
  o driverfs: Remove struct driver_file_entry::parent, as we can get to
    it by the dentry
  o driverfs: don't dynamically allocate and duplicate struct
    driver_file_entry's any more Now that all unique information about
    struct driver_file_entry's are gone (the dentry and parent
    pointers),  the data in them is shared among all users of the
    entry. So, we don't have any reason to dynamically allocate and
    duplicate the data anymore.
  o driverfs: consolidate all the hashed lookups into a static helper:
    get_dentry()
  o device symlinks: just pass name, not struct driver_file_entry to
    driverfs_create_symlink symlinks now only use the name field of the
    struct driver_file_entry, so instead of allocating a new one each
    time we want to create one, this changes the API to only accept the
    name (since the driverfs core will never use the other fields
    either)
  o driverfs: Change the name of struct driver_file_entry to struct
    device_attribute
  o Fixup users of driverfs
  o driverfs: add device_remove_symlink wrapper for removing symlinks
    (since driverfs API is just about to change...)
  o driverfs
  o fixup users of device_remove_file to pass a struct
    device_attribute, instead of a char *
  o driverfs: Declare DEVICE_ATTR macro for initializing device
    attributes (hide internal format of the structure)
  o Convert users of struct device_attribute to initialize the structs
    using DEVICE_ATTR macro.
  o driverfs: Add struct attribute driverfs can only handle passing
    struct device to read/write functions. In order to free it of this
    limitation, we need a common data structure for driverfs to pass
    around. 
  o driverfs: define struct driverfs_ops and remove struct device
    dependencies

Paul Mackerras <paulus@samba.org>:
  o PPC32: Update to match the removal of global cli/sti etc
  o PPC32: update hard/soft IRQ stuff along the lines of the i386 code
  o PPC32: Simple mmu_gather implementation for now
  o PPC32: remove unused code in ppc_htab.c
  o PPC32: use VM_FAULT_* names instead of numbers
  o PPC32: implement __downgrade_write for rwsems
  o PPC32: add a comment explaining leap year calculation
  o fix include/linux/timer.h compile
  o page table page->index

Pavel Machek <pavel@suse.cz>:
  o Move sleep_on() above refrigerator so that the kseriod thread in
    serio.c doesn't exit on suspend because of a pending signal.
  o swsusp: Vojtech pointed error in usb/hub.c
  o swsusp: comment updates and warning fixes

Peter Osterlund <petero2@telia.com>:
  o Fix "make xconfig"

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Convert ncpfs to C99 initializers. By Rusty Trivial Russell

Richard Gooch <rgooch@atnf.csiro.au>:
  o do_mounts.c, block_dev.c, hiddev.c, md.c
  o Removed deprecated devfs_find_handle()

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] ARM keyboard code fixups for the input layer
  o [SERIAL] Locking fixup (part 1) After the last few days of
    debugging, we've ended up with the caller
  o [SERIAL] Locking fixup (part 2) After the last few days of
    debugging, we've ended up with the caller
  o [ARM] Cleanup fallout from global IRQ changes
  o [ARM] Remove {prepare,finish}_arch_{schedule,switch} These macros
    are no longer required; the generic versions defined in sched.c are
    sufficient for ARM.
  o [ARM] Update ARM IRQ code for 2.5.28 global IRQ changes
    irq_enter/irq_exit no longer take arguments.  We also use the x86
    methods for hardirq.h and softirq.h; they're sufficient for ARM.
  o [ARM] Add security framework hooks (ptrace and syscall)
  o [ARM] Optimise kernel->userspace exit code a little
  o [ARM] Make ARM work with rmap ARM can use the generic rmap.h.  It
    doesn't need its own version.
  o [ARM] Remove mach-types.h header file from asm/arch/hardware.h
    Someone included mach-types.h into asm/arch/hardware.h, which
    causes the whole kernel to needlessly rebuild when the machine type
    file is updated.  Move mach-types.h include into the files that
    really need it.
  o [ARM] Update SA11x0 cpufreq code to reflect CVS version
  o [ARM] Prevent oops in free_pages() when freeing a pgd free_pages()
    oopses if page->mapping is non-NULL.  Ensure that any rmap
    datastructures for the page are freed before freeing the concerned
    page.
  o [ARM] Two small changes Remove a couple of needless includes from
    system3.c, and update mach-types file.
  o [SERIAL] Remove some old compatibility cruft from 8250_pci.c
    8250_pci.c contains some old compatibility cruft for when __devexit
    wasn't defined by the generic kernel.  It is now, so it's gone.
  o [SERIAL] Add pci_disable_device() to initialisation failure paths
  o [SERIAL] Add HP Diva PCI serial port support
  o [SERIAL] Cleanup includes

Rusty Russell <rusty@rustcorp.com.au>:
  o Fix ksoftirqd and migration threads initcalls
  o Hot-plug CPU notifier warning fix
  o CPU#1 not working with CONFIG_SMP=y, 2.5.28 OK
  o Mark sparc32 unmaintained in 2.5

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Allow Motorola machines with PPCBUG to get their boot args
    from NVRAM
  o PPC32: Update the CPC700 code to be able to use all 32 IRQs
  o PPC32: Change some instances of CONFIG_SERIAL_CONSOLE to
    CONFIG_SERIAL_8250_CONSOLE
  o PPC32: Update the Motorola LoPEC platform to work with CONFIG_VT
  o Export synchronize_irq on CONFIG_SMP=y

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Set PG_uptodate in nfs_writepage_sync()
  o Support for cached lookups via readdirplus [1-6]
  o NFS lookup() BKL imbalance
  o Re: better getattr caching
  o Fix brown paper bag race in RPC receive code

Vojtech Pavlik <vojtech@suse.cz>:
  o This simplifies the software autorepeat code in input/input.c, also
    killing a race which could be the cause of autorepeat not stopping
    after a key was released.
  o Use stdint.h types instead of __u16 et al in input.h, to make life
    easier for userspace people, as Brad Hards has suggested.
  o Revert input.h back to kernel types

William Stinson <wstinson@infonie.fr>:
  o region changes for rocket
  o small region change for baycom_ser_hdx.c
  o small region change for boardergo.c


