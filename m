Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUAUEvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAUEvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:51:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:47281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266056AbUAUEoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:44:12 -0500
Date: Tue, 20 Jan 2004 20:43:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.2-rc1
Message-ID: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this is the next "big merge" with things from Andrew's -mm tree, along
with a number of new drivers and arch updates.

People have been busy little beavers. In particular, there are 432 patches
that came through Andrew.

Of the other updates, the biggest single thing is the new qla2xxx SCSI
driver. But there's a fair number of other drivers too. See the summary 
for more details.

		Linus

----

Summary of changes from v2.6.1 to v2.6.2-rc1
============================================

<normalperson:yhbt.net>:
  o [libata sata_sil] cleaner, better version of errata workarounds

<rohde:duff.dk>:
  o USB: Missing patch for ftdi_sio.c

Adam Kropelin:
  o USB: hiddev HIDIOCGREPORT not blocking in 2.6

Adrian Bunk:
  o qla1280.c doesn't compile

Adrian Knoth:
  o USB: add Driver for Emagic A6-2 (formerly known as EMI 6|2m)

Alan Stern:
  o USB storage: unusual_devs.h change
  o USB Storage: another unneeded unusual_devs entry
  o USB Storage: another unusual_devs entry
  o USB Storage: unusual_devs.h update
  o USB Storage: Old patches (as129 and as141)
  o USB Storage: Remove non s-g pathway from subdriver READ/WRITE
  o USB Storage: Scatter-gather fixes for non READ/WRITE in datafab
  o USB Storage: Fix scatter-gather for non READ/WRITE in jumpshot
  o USB Storage: Fix scatter-gather for non READ/WRITE in sddr55
  o USB UHCI: fix broken data toggles for queued control URBs
  o USB Storage: Notify the SCSI layer about device resets

Alex Pankratov:
  o [NET]: Fix dst_gc_timer initialization

Alex Williamson:
  o ia64: sba_iommu update

Alexander Viro:
  o [NET] fix leak in sch_teql
  o [netdrvr forcedeth] kfree -> free_netdev

Andi Kleen:
  o Mark IBM TR driver as not 64 bit clean
  o variable number of dummy devices
  o [COMPAT]: Mark SIOCSIFNAME as compatible ioctl

Andreas Schwab:
  o ia64: __ia64_memcpy_fromio() may be missing from kernel

Andrew Morton:
  o [WATCHDOG] 2.6.0-rc1 amd7xx_tco.c-nowayout.patch
  o [NET]: Fix uninlinable __sock_put call in net/sock.h
  o fix qla2xxx build for older gcc's
  o SH Merge
  o kyrofb support
  o radeonfb line length fix
  o loop: fix hard sector size
  o loop: fix file refcount leak
  o bdev: open() changes
  o bdev: blkdev_put() cleanup
  o bdev: presto conversion
  o bdev: add file.f_mapping
  o bdev: switch to f_mapping
  o bdev: use correct mapping's i_sem
  o bdev: move i_mapping -> f_mapping conversions
  o bdev: generic_osync_inode() conversion
  o bdev: bd_acquire() cleanup
  o bdev: generic_write_checks() cleanup
  o bdev: add I_BDEV()
  o cramfs: use pagecache better
  o raw.c refcounting fix
  o Input: smooth out mouse jitter
  o mousedev PS/@ emulation fix
  o input: i8042 suspend
  o input: i8042 option parsing
  o input: psmouse option parsing
  o input: atkbd option parsing
  o input: missing module licenses
  o Kconfig Synaptics help
  o input: SiS AUX port
  o Fix compile error in 98busmouse.c module
  o Convert mouse drivers to use module_param
  o Convert tsdev to use module_param
  o ppc64: clean up WARN_ON backtrace
  o ppc64: revert IRQ_INPROGRESS change
  o ppc64: Build the zImage by default
  o ppc64: add automatic check for biarch compilers
  o ppc64: ptrace.h PT_FPSCR fixup, from Will Schmidt
  o ppc64: HvCall_writeLogBuffer called with too large of a buffer
  o ppc64:  support for ibm,phandle OF property, from Dave Engebretsen
  o ppc64: New Open Firmware device tree API, from Nathan Lynch
  o ppc64: Change to new OF device tree API, from Nathan Lynch
  o ppc64: vty updates, from Hollis Blanchard
  o ppc64: hvc_console can only handle vty nodes compatible with
    "hvterm1", from Hollis Blanchard
  o ppc64: use device_is_compatible() instead of manual strcmp, from
    Hollis Blanchard
  o ppc64: Make IPI receivers survive a late arrival after the sender
    has given up waiting, from Olof Johansson
  o ppc64: support for runtime updates of /proc/device-tree, from
    Nathan Lynch
  o ppc64: base support for dynamic update of OF device, tree from
    Nathan Lynch
  o ppc64: various trivial patches
  o ppc64: Open Firmware device tree manipulation support, from Nathan
    Lynch
  o ppc64: Mem-map I/O changes, from Mike Wolf
  o ppc64: extended flash changes, from Mike Wolf
  o ppc64: cputable update, from Dave Engebretsen
  o ppc64: cputable cleanup, from Dave Engebretsen
  o ppc64: iSeries fixups, from Stephen Rothwel
  o ppc64: Add some rtas calls, from John Rose
  o ppc64: rename the rtas event classes to avoid namespace collisions,
    from John Rose
  o ppc64: fix sign extension bug in NUMA code
  o ppc64: Add exports and change some __init to __devinit for dynamic
    OF and pci hotplug, from John Rose and Linda Xie
  o ppc64: Add _syscall6, from Olaf Hering
  o ppc64: fix sched_clock, from Paul Mackerras
  o ppc64: compat layer update, from Paul Mackerras, Olaf Hering and
    myself
  o ppc64: add rtas syscall, from John Rose
  o ppc64: shared processor support, from Dave Engebretsen
  o ppc64: SMT processor support and logical cpu numbering, from Dave
    Engebretsen
  o ppc64: UP compile fixes, from Paul Mackerras
  o ppc64: Add VMX registers to sigcontext, from Steve Munroe
  o ppc64: one instruction fix for synchronization bug found during cpu
    DLPAR development, from Joel Schopp
  o ppc64: NVRAM error logging/buffering patch, from Jake Moilanen
  o ppc64: preliminary iseries support, from Paul Mackerras
  o ppc64: Add additional hypervisor call constants, from Dave Boutcher
  o ppc64: iSeries fixes, from Stephen Rothwell
  o ppc64: fix a couple small OF device tree bugs which were
    overlooked, from Joel Schopp
  o ppc64: Tidy up various bits of the iSeries code. No significant
    code changes, from Stephen Rothwell
  o ppc64: Small cleanups to iSeries virtual ethernet driver, from Dave
    Gibson
  o ppc64: add hcall interface
  o ppc64: VIO support, from Dave Boutcher, Hollis Blanchard and
    Santiago Leon
  o ppc64: Get native PCI going on iSeries, from Paul Mackerras
  o ppc64: add/forward port of lparcfg, from Will Schmidt
  o ppc64: Update the surveillance boot parameter to allow all valid
    settings of the surveillance timeout, from Nathan Fontenot
  o ppc64: fix POWER3 boot
  o ppc64: VMX (Altivec) support & signal32 rework, from Ben
    Herrenschmidt
  o ppc64: Fix {pte,pmd}_free vs. hash_page race by relaying actual
    deallocation with RCU, from Ben Herrenschmidt
  o ppc64: __hash_page rewrite, from Ben Herrenschmidt
  o ppc64: Tidy up the mf_proc code, from Stephen Rothwell
  o ppc64: prom_panic(), from Todd Inglett
  o ppc64: Check range of PCI memory and I/O accesses on iSeries, from
    Stephen Rothwell
  o ppc64: Fix a compile error and a warning in the iSeries code, from
    Stephen Rothwell
  o ppc64: Use an atomic_t instead of a volatile unsigned long, from
    Stephen Rothwell
  o ppc64: Makefile fixes
  o ppc64: vmlinux.lds fixes, from Alan Modra
  o ppc64: setup_cpu must be called on boot cpu
  o ppc64: correct epoll syscall names
  o ppc64: cp_compat_stat should copy nanosecond fields
  o ppc64: xmon breakpoint and single step on LPAR fixes from John Rose
  o ppc64: Fixed rtas_extended_busy_delay_time() to calculate correct
    value, from John Rose
  o ppc64: early BSS clear, from Ben Herrenschmidt
  o ppc64: vio fixup
  o jffs: use daemonize()
  o Fix IO scheduler regression
  o AS: request poisoning
  o AS: request poisining fix
  o AS fixes
  o AS: new process estimation
  o AS: thinktime improvement
  o AS tuning
  o PPC32: Export consistent_sync_page
  o PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in
    ppc_ksyms.c
  o PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU
  o PPC32: Minor cleanups to IBM4xx and MPC82xx headers
  o fix gcc-3.4 warning in percpu code
  o Fix oops when modifying /sys/block/dm-0/queue/nr_requests
  o ATAPI MO drive support
  o mt rainier support
  o ATAPI MO support update
  o Make ppp_async callable from hard interrupt
  o make try_to_free_pages walk zonelist
  o CardServices() removal from pcmcia net drivers
  o CardServices removal for ide-cs
  o remove CardServices() from drivers/net/wireless
  o Remvoe CardServices() from drivers/serial
  o serial_cs CardServices removal fix
  o remvoe CardServices from axnet_cs
  o final CardServices() removal patches
  o fix for tridentfb.c usage on CRTs
  o CONFIG_EPOLL=n space reduction
  o kill_fasync speedup
  o O21 for interactivity 2.6.0
  o Relax synchronization of sched_clock()
  o can_migrate_task cleanup
  o CPU scheduler cleanup
  o sched.c style cleanups
  o Make for_each_cpu() Iterator More Friendly
  o Use for_each_cpu() Where It's Meant To Be
  o Change cryptic description and help for CONFIG_PDC202XX_FORCE
  o Missing end tags in kernel-locking kerneldoc
  o C99 change to rcupdate.h
  o M68k floppy selection
  o M68k head console
  o M68k head unused
  o M68k head comments
  o M68k head pic
  o M68k head white space
  o M68k cache mode
  o M68k RMW accesses
  o Atari Hades PCI C99
  o Amiga sound C99
  o BVME6000 RTC C99
  o M68k symbol exports
  o M68k math emu C99
  o MVME16x RTC C99
  o Q40 interrupts C99
  o Sun-3 ID PROM C99
  o Mac ADB IOP fix
  o Macfb setup
  o Mac ADB
  o Amiga Gayle IDE cleanup
  o Amiga Gayle E-Matrix 530 IDE
  o Zorro sysfs/driver model
  o Amiga debug fix
  o Mac II VIA
  o M68k asm/system.h
  o Amiga core C99
  o M68k has no VGA/MDA
  o M68k thread
  o M68k thread_info
  o M68k extern inline
  o Cirrusfb extern inline
  o Genrtc warning
  o M68k Documentation
  o Amiga Buddha/CatWeasel IDE
  o generalise net_ratelimit (printk_ratelimit)
  o parintk_ratelimit fix
  o MODULE_ALIAS for freevxfs
  o reindent trident OSS sound driver
  o trident OSS sound driver fixes
  o trident: use pr_debug instead of home-brewed TRDBG
  o selinux: Add resource limit control
  o selinux: add netif controls
  o selinux: Add node controls
  o selinux: Add node_bind control
  o selinux: socket_has_perm cleanup
  o selinux: Add SO_PEERSEC socket option and getpeersec LSM hook
  o selinux: Add dname to audit output when a path cannot be generated
  o selinux: Makefile cleanup
  o selinux: improve skb audit logging
  o Add SEND_MSG and RECV_MSG controls
  o NFS: fix bogus setattr calls
  o nfs: Optimize away unnecessary NFSv3 COMMIT calls
  o nfs: Fix an open intent bug
  o nfs: Fix readonly mounts
  o nfs: Fix a possible client deadlock
  o nfs: Fix an Oops in the RPC debug code
  o allow for building module support for m68knommu architecture
  o add module support for m68knommu architecture
  o sched_clock() for m68knommu architectures
  o m68knommu include fix
  o fix cpu stats in m68knommu entry.S
  o use m68k/types.h for m68knommu
  o implement find_extend_vma() for nommu
  o s390: general update
  o s390: common i/o layer
  o s390: console driver
  o s390: dasd driver
  o s390: tape driver
  o s390: network drivers
  o s390: zfcp host adapter
  o zfcp host adapter patch cleanup
  o s390: new 3270 driver
  o s390: 32 bit emulation fixes
  o s390: 32 bit ioctl emulation fixes
  o s390: tlb flush optimization
  o s390: physical dirty/referenced bits
  o s390: tlb flush race
  o s390: rmap optimization
  o rmap page refcounting simplification
  o s390: superflous flush_tlb_range calls
  o s390: endless loop in follow_page
  o const vs. __attribute__((const)) confusion
  o sn: Some hwgraph code clean up
  o sn: copyright update
  o sn: namespace cleanup: ioerror_dump->sn_ioerror_dump
  o sn: kill big endian stuff
  o sn: kill $Id$
  o sn: remove unused enum
  o sn: serial update
  o sn: Kill nag.h
  o sn: Kill the arcs/*.h files
  o sn: Delete invent.h
  o sn: General code clean up of sn/io/io.c
  o sn: machvec/pci.c clean up
  o sn: General clean up of xbow.c
  o sn: Remove the bridge and xbridge code - everything not PIC
  o sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG
    definition
  o sn: Fix the last patch - missed an IS_PIC_SOFT and needed the CG
    definition
  o sn: New code for Opus and CGbrick
  o sn: klgraph.c clean up
  o sn: More klgraph.c clean up
  o sn: General module.c clean up
  o sn: shubio.c cleanup
  o sn: General xtalk.c clean up
  o sn: irq clean up and update
  o sn: code pruning - a couple of adds due to the clean up
  o sn: Fix a couple of compiler warnings
  o sn: hcl.c clean up for init failures and OOM
  o sn: Some small bte code clean ups
  o sn: Moved code out of pciio and into its own file - snia_if.c and
    renamed the functions
  o sn: A few small clean ups
  o sn: Some more minor clean up
  o sn: Remove __ASSEMBLY__ tags from shubio.h
  o sn: Small check for invalid node in shub ioctl function
  o sn: More code clean up - this time ioconfig_bus.c
  o sn: Code changes for interrupt redirect
  o sn: Forget to check in the _reg file
  o sn: Merged 2 files into another (sgi_io_sim and irix_io_init into
    sgi_io_init)
  o sn: Support for the LCD
  o sn: Missed an include file in the last patch
  o sn: One less panic
  o sn: SAL interface clean up
  o sn: Fixes for shuberror.c
  o sn: Need a bigger max compact node value
  o sn: Use numionodes
  o sn: Change the definition and usage of iio_itte - make it an array
  o sn: Debug clean up in pcibr_dvr.c
  o sn: New pci provider interfaces
  o sn: Fix IIO_ITTE_DISABLE() args
  o sn: Added a missed opus mod and oom mod
  o sn: Added cbrick_type_get_nasid() function
  o sn: Clean up the bit twiddle macros in pcibr_config.c
  o sn: Fixed an oom in pci_bus_cvlink.c
  o sn: Remove the pcibr_wrap... functions
  o sn: printk cleanup
  o sn: pci dma cleanup
  o sn: Make pcibr debug variables static
  o sn: Include file clean up in pcibr_hints.c
  o sn: Added call to pcireg_intr_status_get
  o sn: More code clean up = mostly pcibr_slot.c
  o sn: pcibr_rrb.c cleanup
  o sn: Minor code clean up of pcibr_error.c
  o sn: sn_pci_fixup() clean up or is it fix up ???
  o sn: Remove irix_io_init - replace with sgi_master_io_infr_init
  o sn: Don't call init_hcl from the fixup code
  o sn: Error devenable not used - delete defs
  o sn: Delete unused code in pcibr_slot.c
  o sn: Delete unused pciio.c code (???_host???_[sg]et)
  o sn: Minor clean up for ml_iograph.c
  o sn: Simulator check in pci_bus_cvlink.c
  o sn: Mostly printk clean up and remove some dead code
  o sn: A little re-formatting
  o sn: cleanups and error checking
  o Document EFI zero-page usage
  o v4l: videodev update
  o v4l: v4l2 update
  o v4l: video-buf update
  o v4l: bttv driver update
  o v4l: add infrared remote support
  o v4l: misc i2c fixes
  o v4l: tuner update
  o v4l: add bttv IR input support
  o v4l: saa7134 driver update
  o v4l: add conexant 2388x driver
  o Use request_list as indicator that req originated from ll_rw_blk
  o modules: skip debug sections
  o update OProfile maintainer
  o kNFSd: Fix problem with stale filehandles
  o kNFSd: Convert error status for failed lookup("..") properly
  o kNFSd: Fix incorrect call for follow_up
  o kNFSd: Make sure dnotify events happen for NFS read and write
  o kNFSd: Honour SUN NFSv2 hack for "set times to server time
  o kNFSd: Move SVCFH_fmt from being 'inline' to being 'extern'
  o 3c59x: module loading fix
  o load_elf_binary() oops fix
  o cpu_sibling_map fix
  o fix page counting for compound pages
  o MAINTAINERS update
  o s3 sleep: Kill obsolete debugging code
  o swsusp/sleep documentation update
  o ext2_new_inode nanocleanup
  o ext2: s_next_generation locking
  o ext3: s_next_generation fixes
  o Remove x86_64 leftover SIMNOW code
  o Fix softcursor
  o ext2: fix build when EXT2_DEBUG is set
  o Fix weird placement of inline
  o do_timer_gettime() cleanup
  o set_cpus_allowed locking
  o module removal race fix
  o Remove Intel check in i386 HPET code
  o jbd: start_this_handle() return value fix
  o remove old Eicon isdn driver
  o Eicon isdn driver hardware access fix
  o Eicon isdn driver alloc buffer size fix
  o do_no_page leak fix
  o allow SGI IOC4 chipset support
  o OSS dmabuf deadlock fix
  o Remove redundant code in workqueue.c
  o tridentfb documentation fix
  o Optimize proc_pid_lookup
  o clarify meaning of bio fields in the end_io function
  o RTC leaks
  o Simplify node/zone field in page->flags
  o Identify RADEON Yd in radeonfb
  o Relocation overflow with modules on Alpha
  o ppc32: OF bootwrapper support
  o Fix Documentation/SubmittingPatches to use -p
  o Kconfig: use range for NR_CPUS
  o bio documentation update
  o vmscan: initialize zone->{prev,temp}_priority
  o readahead part-backout
  o revert lazy readahead
  o kconfig: fix menuconfig exit code
  o fix up CPU detection in p4-clockmod
  o suspend/resume support for PIT
  o Alpha: make prefetch_spinlock() a no-op on UP
  o Fix statically declare FIXMAPs
  o tmpfs readdir does not update dir atime
  o Add bdev private field
  o ext3: fix determination of inode journalling mode
  o Arrange for EFI-related code to be compiled away
  o make gcc 3.4 compilation work
  o if ... BUG() -> BUG_ON()
  o sysrq_key_table_key2index() fixlets
  o setscheduler fix
  o isapnp modem addition
  o fix error case in binfmt_elf.c:load_elf_interp
  o remove null-ilizers
  o ppc cond_syscall fix
  o cleanup single_open usage in dma.c
  o rq_for_each_bio fix
  o remove spurious strdup
  o sgiioc4.c cleanup weak symbol and error numbers
  o rxrpc update
  o AFS upgrade
  o ALI M1533 audio hang fix
  o kbuild: Maintainers update
  o Remove CLONE_DETACHED
  o uninline bitmap functions
  o work around gcc bug in bitmap.c
  o video-buf.c cleanup
  o reiserfs v3 should throttle writers
  o Restore missing ppc64 hash_low.S file
  o Fix for 32-bit execve() error path
  o get PPC64 iSeries closer to building
  o ppc64: Bug fix for hugepages on ppc64
  o ppc64: iSeries virtual console
  o Asus L5 framebuffer fix
  o loop needs MODULE_ALIAS_BLOCK
  o loop: trivial error number fix
  o One-shot support for epoll
  o RAID-6
  o check for truncated modules
  o md: fix return code in set_disk_faulty()
  o md: Don't allow raid5 rebuild to swamp raid5 stripe cache
  o md: Make sure an interrupted resync doesn't seem to have completed
  o md: Fix typo in comment
  o md: Make sure md recovery happens appropriately
  o md: Don't do_md_stop and array when do_md_run fails
  o md: Small fixes for timely writing of md superblocks
  o md: Remove the 'disks' array from md which holds the gendisk
    structures
  o md: Discard the mddev_map array
  o md: Use bd_disk->private data instead of bd_inode->u.generic_ip
  o Move XATTR_SECURITY_PREFIX macro to common location
  o Default hooks protecting the XATTR_SECURITY_PREFIX namespace
  o Fix x86-64 ptrace
  o sendfile calls lock_verify_area with wrong parameters
  o pc300_tty.c is broken
  o dbv: update documentation
  o dvb: update saa7146 driver
  o dvb: update core
  o dvb: av7110 driver splitup
  o dvb: TTUSB driver update
  o amd74xx: fix for !CONFIG_PROCFS
  o APM: handle kernel_thread failure
  o MCA: handle bus failure
  o md: fixes for !CONFIG_PROCFS
  o vm overcommit documentation corrections
  o spell Unix98 the same everywhere
  o md: remove unneeded ifdef/endif
  o remove unused flags arg from fs/stat64*
  o correct floppy outb() macro arg names
  o ext3: update a_ops when running `chattr +j'
  o exception table search fix
  o reiserfs: cleanup_bitmap_list() check for NULL argument
  o Document problems with USB legacy support
  o drivers/isdn/Kconfig URL update: caltech.edu
  o ratelimit I/O error printk's
  o dquot: fix i_blocks accounting and locking
  o smbfs: remove noisy printk's
  o NFS/RPC modprobe -r sunrpc causes an oops
  o afs: avoid ifdef inside macro expansion
  o do not use shared extable code for ia64
  o new module args for ir-kbd-*.c

Andrew Vasquez:
  o No LUNs detected with qla2xxx / qla2300

Anton Altaparmakov:
  o Fix minor bug in handling of compressed directories that fixes the
    erroneous "du" and "stat" output people reported.

Arjan van de Ven:
  o fix a few missing return value checks in scsi

Aron Rubin:
  o [libata sata_sil] add pci id for Silicon Image 3512

Axel Waggershauser:
  o USB: fix memory bug in usb-skeleton.c

Bartlomiej Zolnierkiewicz:
  o cleanup IDE multicount PIO write code
  o remove IDE packet taskfile placeholders
  o siimage.c: remove a gcc warning when !CONFIG_PROCFS
  o pdc202xx_old.c: fix PIO autotuning
  o pdc202xx_old.c: fix enabling 66MHz clock for modes > UDMA2
  o pdc202xx_old.c: sanitize 66MHz clock use

Ben Collins:
  o [SPARC64]: Add option to define default command line to kernel, ala
    PPC
  o [SPARC]: Wrap some includes with __KERNEL__ check in
    asm-sparc/elf.h
  o [IEEE1394]: Update OUI database as of Dec 31, 2003
  o [IEEE1394]: Spelling fix from Dominik Brodowski
  o [IEEE1394]: Convert to cdev API
  o [IEEE1394]: Use the right length when deregistering raw1394 char
    device
  o [IEEE1394]: Fix compilation when CONFIG_COMPAT is enabled (32/64
    systems)
  o [IEEE1394]: Per-host address space patch from Steve
  o [IEEE1394]: Fix test in ohci_soft_reset(), and handle hot-unplugged
    cardbus cards better
  o [IEEE1394]: Rework highlevel list locking to avoid blocking under
    spinlocks
  o [IEEE1394]: Sync file revisions
  o [IEEE1394]: Fix highlevel reset, which was using the wrong list to
    iterate
  o [IEEE1394]: Re-add init_hpsb_highlevel() call to highlevel_add_host

Benjamin Herrenschmidt:
  o [libata sata_svw] cleanup, better probing

Bjorn Helgaas:
  o [SERIAL] request resources for ACPI & HCDP ports
  o ia64: HP IOTLB startup msg
  o ia64: system type Kconfig cleanup
  o ia64: move HCDP under serial console #ifdef
  o [SERIAL] make HCDP dependent on serial console
  o [SERIAL] make ACPI serial module unload work

Chas Williams:
  o [ATM]: br2684 incorrectly handles frames recvd with FCS (by Alex
    Zeffertt <ajz@cambridgebroadband.com>)
  o [ATM]: [nicstar] convert to new style pci module (by "Jorge
    Boncompte [DTI2]" <jorge@dti2.net>)
  o [ATM]: better behavior for sendmsg/recvmsg during async closes

Chris Wright:
  o [AX25]: Check error return from memcpy_fromiovec()
  o [IRDA]: Check error return from memcpy_fromiovec()
  o [NETROM]: Check error return from memcpy_fromiovec()
  o [ROSE]: Check error return from memcpy_fromiovec()

Christoph Hellwig:
  o fix inia100 driver

Dave Jones:
  o [AGPGART] The RadeonIGP 345M device ID is 0xcbb2, not 0xcbb Spotted
    by Matteo Croce 
  o Prevent false positives in non-fatal MCE check

Dave Kleikamp:
  o JFS: Avoid segfault when dirty inodes are written on readonly mount
  o JFS: Fix broken return code checking in ACL code
  o [JFS] allow resize option with no parameter
  o JFS: Creating large xattr lists may cause BUG

David Brownell:
  o USB: add goku_udc driver (Toshiba TC86C001 USB device)
  o USB: fix kfree in usb-skeleton.c
  o [ARM PATCH] 1712/1: pxa2xx_udc (1/5) add INIT_MACHINE
  o [ARM PATCH] 1710/1: pxa2xx_udc (2/5) mach-pxa/idp.c uses
    INIT_MACHINE
  o USB:  EHCI support on MIPS
  o USB: high speed iso maxpacket is 1024 not 1023
  o USB: ehci update:  1/3, misc
  o USB: ehci update:  2/3, microframe scanning
  o USB: ehci update:  3/3, highspeed iso rewrite
  o [ARM PATCH] 1711/1: pxa2xx_udc (3/5) add udc platform_device,
    platform_data
  o [ARM PATCH] 1713/1: pxa2xx_udc (4/5) mach-pxa/lubbock.c updates
  o [ARM PATCH] 1714/1: pxa2xx_udc (5/5) pxa2xx_udc driver

David Jeffery:
  o ips 2/2: minor fixes
  o ips fix for large mem 64bit machines

David Mosberger:
  o ia64: fix potential deadlocks due to printk()
  o ia64: Skip zero-length resources in PCI root bridge _CRS.  This
    fixes some ugly messages that used to show up on Tiger and other
    Intel boxes:
  o Many files
  o ia64: add generic defconfig file
  o ia64: Minor fix for get_order() so it works even for insanely large
    arguments.
  o ia64: Turn on CONFIG_EFI unconditionaly (even for HP Ski simulator)
  o ia64: Avoid use of cast expressions as lvalues.  They're ugly and
    may be dropped from GCC at some point in the future.
  o ia64: Fix bad patch breakage: move generic-defconfig to where it
    belongs
  o ia64: Patch by Bjorn Helgaas: acpi_register_irq() must be exported
    to enable modular ACPI device drivers.
  o ia64: Replace unwcheck shell-script with a Python script which
    works correctly even on 32-bit hosts. As an added bonus, it's
    faster, too.  Run "unwcheck" by default, but for now, don't let
    unwcheck errors cause the kernel build to fail.
  o ia64: If GAS can handle .align inside code, enable it via
    TEXT_ALIGN()

David S. Miller:
  o [SPARC64]: In early bootup, BUG() if cannot find TLB entry for
    remapping
  o [SPARC64]: Update defconfig
  o [SPARC64]: Disable PCI ROM address OBP sanity check for now
  o [COMPAT]: Support wireless ioctls, with help from Clint Adams
  o Cset exclude: mashirle@us.ibm.com|ChangeSet|20040115231022|51079
  o [QLOGICPTI]: Fix SMP locking, tested by Chris Ricker
  o [SCSI_ACARD]: atp870u.c needs linux/init.h
  o [SPARC64]: Update defconfig

David Stevens:
  o [IPV4/IPV6]: In MLD, add new filter first, then delete old one

David T. Hollis:
  o USB: usbnet on 2.6.0 -- needs ax8817x_ethtool_ops

Dean Roehrich:
  o [XFS] Implement dm_get_bulkall
  o [XFS] Remove duplicate FILP_DELAY_FLAG macro

Dmitry Torokhov:
  o kobject: make kobject hotplug function public

Eric Dean Moore:
  o MPT Fusion x86-64 boot fix

Eric Sandeen:
  o [XFS] Add a stack trace to _xfs_force_shutdown
  o [XFS] Fix test for large sector_t when finding max file offset
  o [XFS] Fix sysctl handlers to expect ints
  o [XFS] Update xfs_showargs to reflect all current mount options

Eugene Surovegin:
  o I2C: IBM IIC compile fix

Eugene Teo:
  o [SUNRPC]: Handle copy_*_user and put_user errors

Evan N. McNabb:
  o [wireless orinoco_pci] add Vaio PCI id

Felipe Alfaro Solana:
  o USB Storage: unusual_devs.h patch for Trumpion MP3 player

Felipe Damasio:
  o [netdrvr 3c527] remove cli/sti

Frank Becker:
  o [ARM PATCH] 1703/1: SA Cerf update (cleanup)

Greg Kroah-Hartman:
  o USB: add legotower driver to main usb makefile
  o USB: add a new pl2303 device id
  o USB: fix bug in bMaxPower sysfs file, it should be * 2
  o USB: add test for B4000000 to ir-usb driver to fix build issue on
    some archs
  o USB: add gadget serial driver from Al Borchers
  o USB: add new usb led driver
  o USB: add support for the Clie PEG-TJ25 device
  o I2C: move the Kconfig "source..." out of the drivers/char/ location
  o I2C: remove CONFIG_ISA dependancy for I2C_ISA as x86_64 does not
    have CONFIG_ISA
  o USB: fix up compiler warnings and other stuff in the emi62 driver
  o I2C: only select I2C_ITE if we are a MIPS system
  o I2C: add I2C_DEBUG_CORE config option and convert the i2c core code
    to use it
  o I2C: add I2C_DEBUG_CHIP config option and convert the i2c chip
    drivers to use it
  o I2C: add I2C_DEBUG_BUS config option and convert the i2c bus
    drivers to use it
  o I2C: remove unneeded CVS Id: lines
  o Driver Core: add class_simple support
  o TTY: clean up sysfs class support for tty devices
  o Input: add sysfs class support for input devices
  o LP: add sysfs class support for lp devices
  o MEM: add sysfs class support for mem devices
  o MISC: add sysfs class support for misc devices
  o OSS: add sysfs class support for OSS sound devices
  o ALSA: add sysfs class support for ALSA sound devices
  o Kobject: prevent oops in kset_find_obj() if kobject_name() is NULL
  o USB: hook up the HID device's struct device to the input system
    properly
  o USB: hook up the other (non-HID) input devices to the input system
    properly

Harald Welte:
  o [NETFILTER]: Add config help texts for IP_NF_ARP{TABLES,FILTER}

Herbert Xu:
  o [NET]: net/flow.h needs asm/atomic.h

Hideaki Yoshifuji:
  o [IPV6]: Allow per-device max addresses configurable via sysctl
  o [IPV6]: Do not change DEVCONF_xxx indexed based upon kernel config
  o [NET]: Include sysctl.h in neighbour.h regardless of config
  o [IPV6]: Fix array size and missing sentinal in sysctl table of
    addrconf.c
  o [NET]: Add proc_dointvec_userhz_jiffies, use it for proper handling
    of neighbour sysctls

Hirofumi Ogawa:
  o [AF_PACKET]: Fix bind()/setsockopt(PACKET_RX_RING) bug and socket
    leak

Hollis Blanchard:
  o Driver Core: add device_find() function

James Bottomley:
  o 64 bit updates for Workbit NinjaSCSI driver
  o SCSI: atp870u update
  o SCSI sg,st block layer TCQ fix
  o aacraid warning fix
  o repair oops in aic7xxx_old proc_info
  o another aic7xxx_old proc fix
  o sym2 speed selection fix
  o Fix sym2 Ultra160 mode
  o Update Mac ESP SCSI
  o Mac SCSI fixes (from Matthias Urlichs)
  o ncr53c7xx: Cleanup prototypes
  o BVME6000 SCSI: Fix typos
  o Amiga NCR53c710: Coalesce all configuration options into one
  o NCR53C9x SCSI: Kill bogus inline
  o g_NCR5380 - 2.6.0 -  problem with reloading module
  o Import qla2xxx driver
  o Fix qla2xxx Kconfig dependency problem
  o aha152x PCMCIA fix

Javier Achirica:
  o [wireless airo] Fix PCI registration

Jean Delvare:
  o I2C: documentation update
  o I2C: saa7146.h doesn't need i2c.h
  o I2C: Typo in i2c/busses/Kconfig
  o I2C: i2c-rpx.c doesn't need ioports.h nor parport.h
  o I2C: New parport bus drivers
  o I2C: New chip driver: lm90
  o I2C: Fix w83781d temp
  o I2C: Fix debug bug in lm83 driver
  o I2C: restore correct vaio handling in eeprom driver
  o I2C: clean up ISA dependancies
  o I2C: i2c-i801 help
  o I2C: speed up eeprom driver by a factor of 4
  o I2C: Fix lm90.c with DEBUG
  o I2C: Fix i2c-core.c with DEBUG
  o I2C: Fix i2c busses warnings with DEBUG
  o I2C: New driver: w83l785ts
  o I2C: Autoselect i2c algos

Jean Tourrilhes:
  o [IRDA]: Proper calculation for F-timer. Improve interoperability
  o [IRDA]: Fix a potential dealock in sir-dev state machine
  o [IRDA]: Fix sir-dev 'raw' mode for sir dongles that need it
  o [IRDA]: Add module alias for IrCOMM pseudo serial device
  o [IRDA]: Fix compiler warning in af_irda.c
  o [IRDA]: Migrate TIOCMGET and TIOCMSET ioctls in IrCOMM to the new
    TTY API

Jeff Garzik:
  o [libata sata_sil] unmask interrupts during initialization
  o [libata sata_svr] fix DRV_NAME to reflect actual driver filename
  o [netdrvr] Remove never-referenced 68360enet.c
  o [netdrvr 3c527] applied missing pieces of Richard Proctor's 3c527
    SMP update
  o Cset exclude: shemminger@osdl.org|ChangeSet|20040110194048|37013
  o [netdrvr starfire] remove dup include
  o [tokenring olympic] use memset_io to fix certain platforms
  o [netdrvr forcedeth] include linux/interrupt.h
  o [NET] remove both incorrect and unneeded spinlock from sch_teql
  o [netdrvr forcedeth] linux/interrupt wasn't enough :) include
    asm/irq.h too

Jes Sorensen:
  o qla1280
  o ia64: header cleanup
  o ia64: quiet down SMP boot messages
  o qla1280 update

Jesse Barnes:
  o ia64: sn2 defconfig update

Jürgen E. Fischer:
  o Kernel oops in 2.6.1 when loading aha152x_cs.ko

Keith M. Wesolowski:
  o [SPARC]: Fix PMD masking in SRMMU code
  o [SPARC]: Use spinlock to protect IRQ action management

Krishna Kumar:
  o [IPCOMP]: Set x->km.state to XFRM_STATE_DEAD in
    ipcomp_tunnel_create()
  o [AF_KEY]: In pfkey_get(), do not dereference xfrm_state after it is
    put
  o [XFRM]: Fix two bugs in xfrm_lookup()
  o [XFRM_USER]: xfrm_state_construct() needs to set x->km.state to
    XFRM_STATE_DEAD
  o [XFRM]: In xfrm_lookup(), schedule() before retrying template
    resolution
  o [IPV6]: Add missing sentinel to ipv6_route_table

Krzysztof Halasa:
  o [wan] add new pc200syn driver

Kurt Garloff:
  o [NETFILTER]: Align nulldevname properly in ip_tables

Linus Torvalds:
  o Dosemu actually wants to do a zero-sized source mremap to generate
    the duplicate area at 0x0000 and 0x100000.
  o This removes the old Eicon ISDN driver
  o Make sure we don't access "cmd" in ide-scsi after having started
    the command - it may not exist any more.

Luca Risolia:
  o USB: W996[87]CF driver update

Luiz Capitulino:
  o [BRIDGE]: Fix br_netfilter.c build with CONFIG_SYSCTL disabled

Manfred Spraul:
  o [netdrvr] add "forcedeth" driver for nVidia nForce NICs
  o [netdrvr forcedeth] alloc fixes

Marcel Holtmann:
  o [Bluetooth] Disable credit based flow control by default
  o [Bluetooth] Always use two ISOC URB's
  o [Bluetooth] Add support for the Digianswer USB devices
  o [Bluetooth] Add support for an old ALPS module
  o [Bluetooth] Update HCI security filter
  o [Bluetooth] Support inquiry results with RSSI
  o [Bluetooth] Remove USB zero packet option
  o [Bluetooth] Support for AVM BlueFRITZ! USB
  o [Bluetooth] Correct the module alias for the network family
  o [Bluetooth] Add module aliases for the Bluetooth protocols
  o [Bluetooth] Update the Kconfig entry for the BlueFRITZ! USB driver
  o [Bluetooth] Add CAPI message transport protocol support
  o [Bluetooth] Add missing maintainer entries for the Bluetooth
    subsystem
  o [Bluetooth] Improve blacklist handling
  o [Bluetooth] Support for Broadcom Blutonium
  o [Bluetooth] Convert interrupt handlers to use irqreturn_t
  o [Bluetooth] Fix CMTP reference counting
  o [Bluetooth] Use R2 for default value of pscan_rep_mode
  o [Bluetooth] Set disconnect timer for incoming ACL links
  o [Bluetooth] Fix reference counting for incoming connections
  o [Bluetooth] Start inquiry if cache is empty
  o [Bluetooth] Change maintainer role of the Bluetooth subsystem

Marcel Sebek:
  o USB: fix whiteheat problems

Mark M. Hoffman:
  o I2C: Add ported sensor chip driver: asb100
  o I2C: link asb100 in the proper order

Martin Hicks:
  o Call slave_destroy in scsi_alloc_sdev error path
  o Fix error path when adding sysfs attributes

Matthew Dharm:
  o USB Storage: Fix scatter-gather for non READ/WRITE in sddr09
  o USB Storage: fix mode-sense handling for 10-byte commands
  o USB Storage: add sysfs info attribute
  o USB Storage: Sysfs attribute file for max_sectors

Matthew Wilcox:
  o Re: Building sym 2.1.18f on linux/alpha
  o I2C: Kconfig cleanups

Matthias Bruestle:
  o USB: update the cyberjack driver

Michal Ludvig:
  o [XFRM]: SHA2-256 should be truncated to 96 bits, not 128
  o [IPV6]: Set flow protocol correctly in SIT driver route lookups

Mickael Marchand:
  o [libata sata_sil] add support for adaptec 1210sa, 4-port sii 3114

Mike Anderson:
  o scsi_eh_flush_done_q return status

Mike Christie:
  o Initio 9100u

Mirko Lindner:
  o sk98lin-2.6: Kernel Update to Driver Version v6.21
  o sk98lin-2.6: Readme Update to Driver Version v6.21
  o sk98lin-2.6: Kconfig Update to Driver Version v6.21

Nathan Scott:
  o [XFS] Remove debug source file from kernel tree; useless without
    kdb and dropping it cuts down on merge noise.  Simplifies the
    Makefile too.
  o [XFS] Rename pagebuf debug option (ie. pagebuf tracing) into a
    generic XFS tracing option for the other XFS trace code to use too
    (once fixed)
  o [XFS] Fix compiler warning after change to xfs_ioctl interface
  o [XFS] Add some IO path tracing, move inval_cached_pages to a better
    home to help
  o [XFS] Fix ktrace code - dont build unilaterally, and do earlier
    init for pagebuf use
  o [XFS] Fix log tracing code so it is independent of DEBUG like other
    traces
  o [XFS] Fix build fallout from reordering xfsidbg headers for tracing
    fixes
  o [XFS] Rename the vnode tracing macro to be consistent with the
    other trace code
  o [XFS] Enable tracing in the quota code if requested
  o [XFS] Fix exports for tracing symbol access in idbg code
  o [XFS] When tracing extended attribute calls, only access the buffer
    when it exists
  o [XFS] Fix build with tracing enabled, couple of portability macros,
    move externs into headers
  o [XFS] Enable the tracing options in XFS Makefiles
  o [XFS] Dont build objects which are not linked into the kernel ever
  o [XFS] Fix compiler warning due to mismatched types
  o [XFS] Fix warnings when tracing enabled on 64 bit platforms
  o [XFS] Fix an infinite writepage loop under a combination of low
    free space, and racing write/unlink calls to the same file
  o [XFS] Fix error code sign on forced shutdown in iomap; sync iomap
    code up between 2.4 and 2.6 versions
  o [XFS] Enable pagebuf lock tracking with debug config option
  o [XFS] Cleanup the page buffers loop in writepage (no goto, like 2.4
    variant)
  o [XFS] Merge page_buf_locking routines in with the rest of page_buf
  o [XFS] Switch to using the BSD qsort implementation
  o [XFS] Change pagebuf to use the same ktrace implementation as XFS,
    instead of reinventing that wheel
  o [XFS] Seperate the NFS reference cache code out from xfs_rw.c to
    simplify management of different kernel versions
  o [XFS] Trivial/whitespace changes to sync up different trees a bit
  o [XFS] Set proper device for realtime files in linvfs_get_block_core
  o [XFS] Remove assertion that we do not hold a lock - no lock
    ownership state available
  o [XFS] Move the stack trace wrapper into a kernel-version-specific
    location
  o [XFS] Use iomap abstraction consistently
  o [XFS] Abstract sendfile operation out, supporting multiple kernels
    more easily
  o [XFS] Use xfs_statfs type to statfs operation, to support multiple
    kernels more easily
  o [XFS] Fix some incorrect debug code after buftarg changes
  o [XFS] Make kmem shaking interface consistent between kernel
    versions.  No code change here, mainly symbol names
  o [XFS] Fix comment in xfs_rename.c
  o [XFS] Prevent log ktrace code from sleeping in an invalid context
  o [XFS] Use vnode timespec modifiers for atime/mtime/ctime, keeps
    last code hunk in sync
  o [XFS] No need to initialise struct xfs_trans field to null after a
    zalloc
  o [XFS] Remove some spurious double semi-colons
  o [XFS] Fix async pagebuf I/O tracing at the bottom of pagebuf_get
  o [XFS] Fix a small pagebuf memory leak and keep track of slab pages
    ourselves
  o [XFS] Fix an XFS release_page case where unwritten extents may
    cause I/O incorrectly
  o [XFS] Cleanup bdevname conditional code in xfs_buf headers
  o [XFS] Rework some extended attributes code to make it more easily
    extended
  o [XFS] Fix some inconsistent types
  o [XFS] Trivial and whitespace changes to sync trees.  Remove
    no-longer-used headers
  o [XFS] Remove a no-longer-used pagebuf source file

Nicolas Pitre:
  o [ARM PATCH] 1735/1: correct memcpy return value on ARM

Patrick Mansfield:
  o Re: 2.6.1-rc1: SCSI: `TIMEOUT' redefined

Paul Mackerras:
  o sort exception tables

Paulo Marques:
  o USB: add another PID to ftdi_sio

Pete Zaitcev:
  o USB: Band-aid for mct_u232 in 2.6.1

Peter Teichmann:
  o [ARM PATCH] 1717/1: Add German umlauts to Acorn console font

Petri Koistinen:
  o [NET]: Fix linux-on-laptops URL in net driver Kconfig
  o [IPV4]: Fix URL mentioned for IP_ROUTE_NAT

Raj:
  o [IPV4]: Check for netdev alloc failure in ipmr.c

Randy Dunlap:
  o [netdrvr natsemi] janitor: insert missing iounmap(), add error
    handling

Richard Procter:
  o [netdrvr 3c527] whitespace changes (sync up with maintainer)
  o [netdrvr 3c527] fix race

Robert Olsson:
  o [PKTGEN]: Fix divide by zero and get integer precision at very
    short time intervals

Roland McGrath:
  o fix pdeath_signal SMP locking

Ross Boswell:
  o USB Storage: patch to unusual_devs.h for Pentax Optio 330GS camera

Russell Cattelan:
  o [XFS] move the iomap data structures out of pagebuf
  o [XFS] Fix one more fsid_t type

Russell King:
  o [ARM] Add PXA MCI resources and device structure

Shirley Ma:
  o [IPV6]: Implement MIB:ipv6InterfaceTable
  o [IPV6]: Add notification for MIB:ipv6Prefix events

Simon Kelley:
  o [wireless atmel] various updates

Sridhar Samudrala:
  o [SCTP] ADDIP: Support for processing ASCONF chunks and respond with
    ASCONF_ACK chunks.
  o [SCTP] Remove the extra semicolon in sctp_cacc_skip_3_1()
  o [SCTP] ADDIP: Add sysctl parameter to enable/disable addip
  o [SCTP] Fix to free associations in the accept queue of a one-to-one
    style listening socket that is closed.
  o [SCTP] Fix the duplicate increment of checksum error counter and
    counting bad packet errors as checksum errors.
  o [SCTP] Fix overflow in the macros JIFFIES_TO_MSECS/MSECS_TO_JIFFIES
    when used with large values.
  o [SCTP] ADDIP: Support for processing incoming ASCONF_ACK chunks
  o [SCTP] ADDIP: Handle T4 RTO timer expiry
  o [SCTP] Fix bugs in byte order conversion while processing address
    related SCTP socket options.

Stephen Hemminger:
  o [NET]: Use size_t for size argument in {send,recv}msg callchain
  o [IPV4/IPV6]: Use size_t for size in {send,recv}msg
  o [BLUETOOTH]: Use size_t for size in {send,recv}msg
  o [PPPOE]: Use size_t for size in {send,recv}msg
  o [APPLETALK DDP]: Use size_t for size in {send,recv}msg
  o [ATM]: Use size_t for size in {send,recv}msg
  o [AX25]: Use size_t for size in {send,recv}msg
  o [IPX]: Use size_t for size in {send,recv}msg
  o [DECNET]: Use size_t for size in {send,recv}msg
  o [NETLINK]: Use size_t for size in {send,recv}msg
  o [ECONET]: Use size_t for size in {send,recv}msg
  o [IRDA]: Use size_t for size in {send,recv}msg
  o [LLC]: Use size_t for size in {send,recv}msg
  o [NETROM]: Use size_t for size in {send,recv}msg
  o [ROSE]: Use size_t for size in {send,recv}msg
  o [UNIX]: Use size_t for size in {send,recv}msg
  o [X25]: Use size_t for size in {send,recv}msg
  o smctr - get rid of MOD_INC/DEC
  o get rid of MOD INC/DEC for farsync
  o pc300 - get rid of MOD_INC/MOD_DEC
  o [BRIDGE]: Use dev_base_lock while traversing netdev list
  o [NET]: Convert /proc/net/dev_mcast to seq_file
  o [NET]: Add SIOCSIGNAME wildcarding and name validation, with help
    from Jean Tourrilhes
  o [NET]: When registering a new notifier, rebroadcast REGISTER and UP
    events
  o [IPV6]: Notifier replay changes
  o [X25]: Remove pre-existing device discovery loop
  o [BPQETHER]: Remove pre-existing device discovery loop
  o [LAPBETHER]: Remove pre-existing device discovery loop
  o [ATM]: CLIP device discovery on init is not needed
  o [DECNET]: Fix initialization race
  o [NET]: dev_alloc_name() returns the number of the slot used, so
    comparison needs to be < 0
  o [ATM]: Kill unused declaration in clip.c

Thomas Stewart:
  o USB: powermate-payload-size-fix.patch

Tom Rini:
  o I2C: module_parm fixes for i2c-piix4.c

Tony Lindgren:
  o [ARM PATCH] 1741/1: Add ARM710T processor functions

Ville Nuorvala:
  o [IPV6]: Stricter checks on link-locals in bind and sendmsg

Wesley Smith:
  o [XFS] Work around gcc 2.96 bug in _lsn_cmp

Wim Van Sebroeck:
  o [WATCHDOG] 2.6.0-rc1 - iminor(inode).patch
  o [WATCHDOG] 2.6.0-rc1 expect_close.patch
  o [WATCHDOG] 2.6.0-rc1 i810-tco.c.nowayout.patch
  o [WATCHDOG] 2.6.0-rc1 _is_open.patch
  o [WATCHDOG] 2.6.0-rc1 cleanup-spaces-tabs.patch
  o [WATCHDOG] 2.6.0-rc1 -ENOIOCTLCMD.patch
  o [WATCHDOG] 2.6.0-rc1 ib700wdt-version-comment.patch
  o [WATCHDOG] 2.6.0-rc1 amd7xx_tco.module_param.patch
  o [WATCHDOG] 2.6.0-rc1 spelling-fixes-whether.patch

Xose Vazquez Perez:
  o more ne2k-pci clone boards

