Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUKODBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUKODBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUKODA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:00:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:40912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261508AbUKOCtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:49:07 -0500
Date: Sun, 14 Nov 2004 18:49:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10-rc2
Message-ID: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
is released. Otherwise we'll never get there.

A lot of driver updates, many of them of the small and trivial kind,
others less so. USB, ALSA, fbdev, IDE, i2c, v4l, you name it. With a
sprinking of core device model and PCI updates thrown in for good measure.

Also, a number of architecture updates: ppc64, m68k, uml, parisc, arm.

And md, NTFS, and Documentation updates too.

The diffstat shows more of the story - not so much single really big
changes, more of a fairly wideranging thing. Shortlog appended.

		Linus

-----

Summary of changes from v2.6.10-rc1 to v2.6.10-rc2
============================================

<anoy@mail.ru>:
  o [ALSA]  Fix DXS entry for GA-7VAX

<alexn:dsv.su.se>:
  o x86_64: assign_irq_vector should not be marked __init

<jdittmer:ppp0.net>:
  o fakephp: introduce pci_bus_add_device
  o fakephp: add pci bus rescan ability

<thockin:google.com>:
  o PCI: small PCI probe patch for odd 64 bit BARs

Aaron Grothe:
  o [CRYPTO]: Add Anubis support

Adam Belay:
  o [PNPBIOS] disable if ACPI is active
  o [PNPBIOS] acpi compile fix

Adam J. Richter:
  o dmx3191d.c lacked MODULE_DEVICE_TABLE()

Adrian Bunk:
  o net/tokenring/olympic.c: remove unused variable
  o USB: fix usb/serial/console.c compile error
  o small SOFTWARE_SUSPEND help text fixes
  o CREDITS update
  o ISDN hisax_fcpcipnp.c: kill unused variable
  o kbuild: Documentation/kbuild/makefiles.txt: check_gcc -> cc-option
  o [APPLETALK]: Remove an unused function
  o [IRDA]: Remove an unused function in net/irda/qos.c
  o [AX25]: Remove an unused function in ax25_route.c
  o [NETFILTER]: Remove an unused function in ipt_tcpmss.c
  o USB stv680.c: remove an unused function
  o USB ohci-dbg.c: remove an unused function
  o [SCTP]: Remove an unused function in outqueue.c
  o small sysfs cleanups
  o i2c it87.c: remove an unused function
  o PCI: kill old PCI changelog
  o i2c/busses/ : make some code static
  o USB: misc USB gadget cleanups
  o [NET]: No reason for pktgen.c to include pci.h

Akinobu Mita:
  o schedstat: fix schedule() statistics

Al Borchers:
  o USB: io_edgeport locking, flow control, and misc fixes
  o USB: revised usbserial open/close unbalanced get/put
  o USB: io_ti new devices, circular buffer, flow control, misc fixes

Alan Cox:
  o [ide] remove debugging delay from CS5520 driver
  o [ide] apply undecoded slave fixup only for ide-cs
  o [ide] siimage: fix the various SI3112 hangs
  o moxa - dead code removal

Alan Stern:
  o usbcore: drop reference to bus on allocation error
  o UHCI: No bandwidth reclamation during enumeration
  o USB Gadget: Use proper BCD values
  o USB file-storage gadget: clean up endian issues
  o USB device init: implement the Windows scheme
  o SCSI core: Fix refcounting error
  o UHCI: Workaround for broken remote wakeup
  o USB: Dequeuing of root-hub URBs
  o UHCI: Use a sane timeout for device initialization
  o dummy_hcd: minor fixups
  o dummy-hcd: Refactor startup and shutdown
  o usbcore: Make the core release hcd structures
  o USB PCI drivers: hcd release changes
  o Non-PCI OHCI drivers: remove hcd release
  o dummy-hcd: removal hcd release
  o usbcore: add comment to updated hcd.h

Alasdair G. Kergon:
  o device-mapper: dm-crypt tidy-ups
  o device-mapper: dm-crypt generator extension
  o device-mapper: dm-crypt: new IV mode ESSIV
  o device-mapper trivial: duplicate kfree in error path

Alex Kiernan:
  o UFS: solaris compatibility fix

Alex Williamson:
  o [IA64] efi.c: fix mem= & max_addr=

Alexander Viro:
  o FB_INTEL Kconfig breakage
  o tcx compile fix (typo)
  o missing braces in macros (asm-alpha/mmzone.h)

Alexey Dobriyan:
  o kernel-doc: support for comma-separated members in structs and
    unions
  o kernel-doc: print arrays in declarations correctly
  o kernel-doc: don't print ... twice in variadic functions
  o kernel-doc: Print preprocessor directives correctly

Andi Kleen:
  o Fix x86-64 genapic build
  o x86_64: Fix safe_smp_processor_id after genapic
  o x86_64: Fix warning in genapic
  o x86_64: Update cpuid feature tables
  o x86_64: Report SSE3 on AMD CPUs
  o x86_64: Fix compat_timer_t
  o x86_64: Defconfig update
  o x86_64: Fix e820 overflow
  o x86_64: Add early exception handler
  o x86_64: Fix some readl/writel warnings
  o x86_64: Fix CONFIG_X86_MCE
  o x86_64: add nmi button support
  o x86_64: Don't wait on panic
  o x86_64: Poison initdata
  o x86_64: Add 32bit quota support
  o x86_64: Fix setup asm constraints
  o x86_64: Auto enable HPET on Summit
  o x86_64: Fallback to swiotlb for dma_alloc_coherent
  o x86_64: Remove bogus __initdata in wakeup path
  o x86_64: set -fno-strict-aliasing for early boot code
  o Print real error when initramfs gunzip failed
  o Add panic blinking to 2.6
  o x86_64: Add p4 clockmod
  o x86-64: Fix broken NMI change

Andrea Arcangeli:
  o [NET]: Accept should return ENFILE not EMFILE

Andreas Gruenbacher:
  o kbuild: Allow install of external modules to custom path

Andreas Herrmann:
  o s390: make zfcp compile again

Andrew Hendry:
  o [X25]: Stop x25_destroy_socket timer looping
  o [ETHERTAP]: Add missing newline to debug printk
  o [X25]: Stop /proc/net/x25/route infinitely reading
  o [X25]: Dont log unknown frame type when receiving clear confirm

Andrew Morton:
  o de4x5 warning fix
  o igxb speedup
  o e1000 sparc64 dma_mapping build fix
  o kobject_hotplug: permit no hotplug_ops
  o kobject_uevent warning fix
  o revert "ppc: fix build with o=output_dir"
  o msnd.c build fix
  o ne2k-pci pci build fix
  o e1000 module_param build fix
  o ide_pio_sector() kmap fix
  o [CRYPTO]: small sha256 cleanup
  o [CRYPTO]: small sha512 cleanup
  o [CRYPTO]: reduce sha512_transform() stack usage, speedup
  o revert- sys_setaltroot
  o [IA64] Need <asm/uaccess.h> for KERNEL_DS & set_fs() definitions
  o key_init ordering fix
  o swapper_space warning suppression
  o ext3 reservation: default to on
  o convert pipefs to fs_initcall()
  o ext3_bread() cleanup
  o PG_writeback: fix waitqueue_active memory barrier
  o bk-kbuild utsname fix
  o unexport lock_page()
  o Fix ext3_dx_readdir
  o netpoll: fix null ifa_list pointer dereference
  o E1000 stop working after resume
  o ixgb: fix ixgb_intr looping checks
  o Fix for 802.3ad shutdown issue
  o x86_64: ia32_aout-build-fix
  o limit CONFIG_LEGACY_PTY_COUNT

Andrew Vasquez:
  o SCSI: fix `risc_code_addr01' multiple definition

Andries E. Brouwer:
  o avoid semi-infinite loop when mounting bad ext2
  o don't divide by zero on bad ext2 fs
  o minix_clear_inode fix
  o ext2 docs update
  o ufs docs update
  o wierd typos
  o propogate typos
  o recieve typos
  o don't divide by 0 when trying to mount ext3
  o new Solaris partition ID
  o remove explicit k_name use in atmel_cs.c, bt3c_cs.c
  o remove if !PARTITION_ADVANCED condition in defaults
  o add __initdata in floppy.c
  o __devinit in sound/oss/es1371.c
  o __init for inflate.c
  o __init in i386/kernel/cpu/nexgen.c
  o __devinit in pci/generic.c
  o __devinit in ide/pci/rz1000.c
  o __init and i386 timers
  o __init in scsi/scsi_devinfo.c
  o __devinit in parport_pc.c
  o __init in mm/slab.c
  o __init in reboot.c
  o __initdata in dm.c
  o no __init in serial/8250.c
  o no __initdata in netfilter

Andy Whitcroft:
  o bootmem use NODE_DATA
  o fix pnpbios fault message

Anil Keshavamurthy:
  o remove cpu_run_sbin_hotplug()
  o Add KOBJ_ONLINE

Anton Altaparmakov:
  o NTFS: Fix two typos in Documentation/filesystems/ntfs.txt
  o NTFS: Improve error handling in fs/ntfs/inode.c::ntfs_truncate()
  o NTFS: Add fs/ntfs/aops.c to list of providers for ->b_end_io method
    in Documentation/filesystems/Locking.
  o NTFS: - Change fs/ntfs/inode.c::ntfs_truncate() to return an error
    code instead of void and provide a helper ntfs_truncate_vfs() for
    the vfs ->truncate method.
  o NTFS: Fix min_size and max_size definitions in ATTR_DEF structure
    in fs/ntfs/layout.h to be signed.
  o NTFS: Add attribute definition handling helpers to
    fs/ntfs/attrib.[hc]
  o NTFS: In fs/ntfs/aops.c::mark_ntfs_record_dirty(), take the
    mapping->private_lock around the dirtying of the buffer heads
    analagous to the way it is done in __set_page_dirty_buffers().
  o NTFS: Ensure the mft record size does not exceed the
    PAGE_CACHE_SIZE at mount time as this cannot work with the current
    implementation.
  o NTFS: Check for location of attribute name and improve error
    handling in general in fs/ntfs/inode.c::ntfs_read_locked_inode()
    and friends.
  o NTFS: In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully
    outside i_size, i.e. race with truncate, invalidate the buffers on
    the page so that they become freeable and hence the page does not
    leak.
  o NTFS: Implement extension of resident files in the regular file
    write code paths (fs/ntfs/aops.c::ntfs_{prepare,commit}_write()). 
    At present this only works until the data attribute becomes too big
    for the mft record after which we abort the write returning
    -EOPNOTSUPP from ntfs_prepare_write().
  o NTFS: Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge(). 
    (Adrian Bunk)
  o NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_find() that
    resulted in a NULL pointer dereference in the error code path when
    a corrupt attribute was found.
  o NTFS: Add MODULE_VERSION() to fs/ntfs/super.c
  o NTFS: Make several functions and variables static.  (Adrian Bunk)
  o fs/buffer.c exports for NTFS
  o NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() so it
    allocates buffers for the page if they are not present and then
    marks the buffers belonging to the ntfs record dirty.  This causes
    the buffers to become busy and hence they are safe from removal
    until the page has been written out.
  o NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find()
    in the error handling code path that resulted in a BUG() due to
    trying to unmap an extent mft record when the mapping of it had
    failed and it thus was not mapped.  (Thanks to Ken MacFerrin for
    the bug report.)
  o NTFS: Drop the runlist lock after the vcn has been read in
    fs/ntfs/lcnalloc.c::__ntfs_cluster_free().
  o NTFS: Rewrite handling of multi sector transfer errors.  We now do
    not set PageError() when such errors are detected in the async i/o
    handler           fs/ntfs/aops.c::ntfs_end_buffer_async_read(). 
    All users of mst           protected attributes now check the magic
    of each ntfs record as they           use it and act appropriately.
     This has the effect of making errors granular per ntfs record
    rather than per page which solves the case where we cannot access
    any of the ntfs records in a page when a single one of them had an
    mst error.  (Thanks to Ken MacFerrin for the bug report.)
  o NTFS: Fix error handling in
    fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date() where we failed to
    release i_sem on the $Quota/$Q attribute inode.
  o NTFS: Fix bug in handling of bad inodes in
    fs/ntfs/namei.c::ntfs_lookup()
  o NTFS: Minor cleanup of fs/ntfs/debug.c
  o NTFS: - Add mapping of unmapped buffers to all remaining code
    paths, i.e
  o NTFS: - Fix creation of buffers in
    fs/ntfs/mft.c::ntfs_sync_mft_mirror()
  o NTFS: Disable the file size changing code from
    fs/ntfs/aops.c::ntfs_prepare_write() for now as it is not safe.
  o NTFS: 2.1.22 - Many bug and race fixes and error handling
    improvements

Anton Blanchard:
  o fix acenic hotplug
  o ppc64: Add option for oprofile to backtrace through spinlocks
  o ppc64: Bump MAX_HWIFS in IDE code
  o ppc64: Fix for cpu hotplug + NUMA
  o ppc64: Small OF fixes

Antonino Daplas:
  o fbdev: Fix software blanking code
  o fbdev: Reduce pixmap memory allocation size
  o fbdev: Remove inter_module_get/put from i810fb
  o fbdev: Various mach64 changes
  o fbdev: Clean up of fbcon/fbdev cursor interface
  o fbdev: Clean up softcursor implementation
  o fbdev: Clean up i810fb cursor implementation
  o fbdev: Cleanup rivafb cursor implementation
  o fbdev: Intel 830M/845G/852GM/855GM/865G framebuffer driver port
  o fbdev: S3 Savage Framebuffer Driver
  o savagefb export fixes
  o fbdev: Fix rivafb crashes on PPC
  o fbdev: Add __iomem annotations for savagefb
  o fbdev: Add __iomem annotations to intelfb
  o fbcon: Fix endian bug in fbcon_putc (console mouse problem)
  o fbdev: Convert MODULE_PARM to module_param in i810fb
  o fbdev: Remove module parameter 'disabled' from savagefb
  o fbdev: Convert MODULE_PARM to module_param in intelfb
  o fbdev: Convert MODULE_PARM to module_param in neofb
  o fbdev: Fix io access in neofb
  o fbdev: Add __iomem annotations to sstfb
  o fbdev: Add __iomem annotations to tdfxfb
  o fbdev: Do not memset the framebuffer memory in asiliantfb
  o fbdev: Add __iomem annotations to cyber2000fb
  o fbdev: Add __iomem annotations to pm2fb
  o fbdev: Add __iomem annotations to hgafb
  o fbdev: Add __iomem annotations to cirrusfb
  o fbdev: Add __iomem annotations to vfb
  o fbdev: Check if cursor image has changed in intelfb
  o fbdev: Maintainership
  o fbcon: Do not touch hardware if vc_mode != KD_TEXT
  o fbdev: Fix access to ROM in aty128fb
  o fbdev: Fix IO access in rivafb
  o fbdev: Fix source copy bug in neofb
  o fbcon/fbdev: Remove fbcon-specific fields from struct fb_info
  o fbdev: atyfb_base.c requires atyfb_cursor()
  o fbdev: Set correct mclk/xclk values for aty in ibook
  o fbdev: Check for intialized flag before registration in matroxfb
  o fbcon: "Do not touch hardware if vc_mode != KD_TEXT: fix
  o fbcon: Another fix for fbcon generic blanking code
  o rivafb: big-endian IO access fixes
  o fbdev: Fix IO access in rivafb (part 2)
  o fbdev: Fix mode handling in rivafb if with no EDID
  o fbdev: Use soft_cursor in i810fb
  o fbdev: Set color depth to 8 if in pseudocolor in vesafb
  o fbcon: Split set_con2fb_map()
  o fbdev: Introduce FB_BLANK_* constants
  o fbdev: Convert drivers to use the new FB_BLANK_* constants
  o fbdev: Fix broken fb_blank() implementation

Arjan van de Ven:
  o [SERIAL] Remove dead code
  o remove NET_HW_FLOWCONTROL
  o [ide] remove unused internal exports from ide core
  o unexport raise_softirq
  o vmalloc_to_page helper
  o remove unused code: dump_extended_fpu
  o make filemap_fdatawrite_range() static
  o unexport add_timer_on()
  o USB: remove dead code in usb video
  o [NET]: Unexport call_netdevice_notifiers()
  o [TCP]: Unexport sysctl_tcp_tw_recycle
  o I2C: remove dead code from i2c
  o remove journal callback code from jbd
  o remove unused lookup_mnt export
  o [NET]: Mark __{lock,release}_sock() static
  o make cdev_get static, unexport
  o unexport task_nice

Arnaldo Carvalho de Melo:
  o [SKBUFF] move common code to hdlc_type_trans
  o [SKBUFF] remove skb->mac.raw setting after hdlc_type_trans
  o [SKBUFF] introduce x25_type_trans
  o [NET] add missing includes and forward decls to filter.h
  o [NET] add missing include to divert.h
  o USB: add id for Siemens x65 series of mobiles to pl2303 driver
  o [NET] add missing include to inet.h
  o [NET] add missing include to inetdevice.h
  o [NET] add missing include to icmp.h
  o [NET] add missing include to iw_handler.h
  o [IPV6]: Fix mca_sfcount[] refcounting in error path
  o fix  platform_rename_gsi related ia32 build breakage

Arnout Engelen:
  o [TCP]: Add /proc/net/tcp{,6} layout documentation

Arthur Kepner:
  o [TG3]: Use mmiowb in tg3_poll

Bart De Schuymer:
  o [EBTABLES]: Add wildcard support for interface matching

Bartlomiej Zolnierkiewicz:
  o [ide] pmac: kill pmac_ide_[raw_]build_sglist()
  o [ide] use ide_map_sg()
  o [ide] kill ide_raw_build_sglist()
  o [ide] ide-scsi: simplify+speedup DMA support
  o [ide] kill ide_hwif_t->ide_dma_verbose
  o [ide] kill /proc/ide/ide?/config
  o [ide] aec62xx: kill /proc/ide/aec62xx
  o [ide] atiixp: kill /proc/ide/atiixp
  o [ide] cs5520: kill /proc/ide/cs5520
  o [ide] cs5530: kill /proc/ide/cs5530
  o [ide] hpt366: kill /proc/ide/hpt366
  o [ide] pdc202xx_new: kill /proc/ide/pdcnew
  o [ide] pdc202xx_old: kill /proc/ide/pdc202xx
  o [ide] piix: kill /proc/ide/piix
  o [ide] sc1200: kill /proc/ide/sc1200
  o [ide] serverworks: kill /proc/ide/svwks
  o [ide] slc90e66: kill /proc/ide/slc90e66
  o [ide] ide-disk: fix /proc/ide/hd?/smart_thresholds
  o [ide] ide-probe: undecoded slave fixup
  o [ide] add pci_get_legacy_ide_irq()
  o [ide] add ide_use_dma()
  o [ide] remove needless exports from ide-taskfile.c
  o [ide] PIO bugfix
  o [ide] remove hwif from /proc/ide/ as part of ide_unregister_hwif()
  o [ide] hpt34x: kill hpt34x.h
  o [ide] pmac: kill CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
  o [ide] setup-pci: small ide_get_or_set_dma_base() cleanup
  o [ide] setup-pci: simplify autodma logic
  o [ide] kill IDEPCI_FLAG_FORCE_MASTER
  o [ide] make destroy_proc_ide_interfaces static
  o [ide] obsolete /proc/ide/hd?/settings
  o [ide] obsolete some command line parameters
  o [ide] obsolete "enable DMA by default" config options
  o libata PIO bugfix
  o [ide] shrink hw_regs_t
  o [ide] ns87415: small cleanup
  o [ide] (partially) unify hdreg.h & ata.h

Ben Dooks:
  o I2C: Fix compile of drivers/i2c/busses/i2c-s3c2410.c
  o [ARM PATCH] 2134/3: S3C2410 - Power Management core (1/4)
  o [ARM PATCH] 2135/3: S3C2410 - Power Management timer resume (2/4)
  o [ARM PATCH] 2136/1: S3C2410 - Power Management IRQ wakeup (3/4)
  o [ARM PATCH] 2138/1: S3C2410 - Power Management documentation (4/4)
  o [ARM PATCH] 2146/1: S3C2410 - serial fixes and s3c2440 updates
  o [ARM PATCH] 2147/1: S3C2410 - reorganise board support
  o [ARM PATCH] 2148/1: S3C2410 - I2C platfrom data
  o [ARM PATCH] 2149/1: S3C2410 - usb-simtec.c fixes and cleanup
  o [ARM PATCH] 2151/1: S3C2410 - fix guard on
    include/asm-arm/arch-s3c2410/regs-iic.h
  o [ARM PATCH] 2152/1: S3C2410 - lcd controller register fixes
  o [ARM PATCH] 2155/1: S3C2410 - fix definition of
    S3C2410_UDC_MAXP_REG
  o [ARM PATCH] 2156/1: S3C2410 - Documentation updates
  o [ARM PATCH] 2157/2: S3C2410 - default configuration update
  o [ARM PATCH] 2158/1: S3C2410 - clean warnings from
    arch/arm/mach-s3c2410/pm.c
  o [ARM PATCH] 2159/1: BAST - include/asm-arm/arch-s3c2410/bast-pmu.h
  o [ARM PATCH] 2161/1: S3C2410 - uncompressor low level uart
    configuration
  o [ARM PATCH] 2139/1: BAST - Power management initialisation
  o [ARM PATCH] 2172/1: S3C2410 - clock updates
  o [ARM PATCH] 2176/1: S3C2410 - fixes for reset and idle
  o [ARM PATCH] 2189/1: S3C2410 - select pclk as source for timer if
    none specified for machine
  o [ARM PATCH] 2190/1: S3C2410 - fix compile for S3C2440 CPUs
  o [ARM PATCH] 2193/1: S3C2410 - fix wake mask for IRQEINT[0..3], and
    IRQ_RTC
  o [ARM PATCH] 2199/1: S3C2410 - fix warning in
    include/asm-arm/arch-s3c2410/dma.h
  o [ARM PATCH] 2208/1: S3C2410 - pm updates and fixes
  o [ARM PATCH] 2210/1: S3C2410 - export symbols from
    arch/arm/mach-s3c2410/gpio.c
  o [ARM PATCH] 2211/1: S3C2410 - fix idcode of S3C2410A
  o [ARM PATCH] 2209/1: OMAP - only offer OMAP systems if
    CONFIG_ARCH_OMAP
  o [ARM PATCH] 2214/1: S3C2410 - add missing RTCCON defs
  o S3C2410 i2c updates
  o [ARM PATCH] 2215/1: S3C2410 - i2c registers for s3c2440a
  o [ARM PATCH] 2220/1: S3C2410 - regs-dsc.h fixes
  o [ARM PATCH] 2217/2: S3C2410 - pm updates
  o [ARM PATCH] 2224/1: S3C2410 - s3c2440 power management device
  o [ARM PATCH] 2225/1: S3C2410 - export symbol from s3c2440-dsc.c
  o [ARM PATCH] 2226/1: S3C2410 - dma system device
  o [ARM PATCH] 2227/1: S3C2410 - export dma symbols to modules
  o [ARM PATCH] 2228/1: S3C2410 - dma register updates
  o [ARM PATCH] 2232/2: S3C2410 - RTC driver
  o [ARM PATCH] 2238/1: S3C2410 - pm.h remove init code if not used
  o [ARM PATCH] 2239/1: S3C2410 - add iPAQ rx3715 machine
  o [ARM PATCH] 2237/1: S3C2410 - new serial driver - update
    serial_core.h (4/4)
  o [ARM PATCH] 2240/1: S3C2410 - clock device id update
  o [ARM PATCH] 2235/1: S3C2410 - new serial driver - core updates
    (2/4)
  o [ARM PATCH] 2236/1: S3C2410 - new serial driver - machine updates
    (3/4)

Ben Greear:
  o [VLAN]: Sync code and feature set with 2.4.x

Benjamin Herrenschmidt:
  o Fix msleep to sleep _at_least_ the requested amount
  o ppc64: Move PCI IO mapping from pSeries_pci.c to pci.c
  o ppc64: Fix pSeries secondary CPU setup
  o ppc64: Rewrite the openpic driver
  o 8250: Let arch provide the list of leagacy ports
  o ppc64: properly build list of legacy serial ports from OF
  o ppc64: clean up existence-check of legacy ISAdevices
  o ppc64: cleanups of ppc64 pci.c
  o ppc64: Some small pci fixes
  o ppc64: Rework PCI <-> OF node matching
  o ppc64: cleanup/split SMP code
  o ppc64: Some cleanups of prom_init.c
  o ppc64: remove unused cruft from prom.h
  o ppc64: annotate remaining IO accessors
  o ppc64: Improve PCI config accessors
  o ppc64: Cleanup console detection
  o Remove bogus definition of local chrp_int_ack_special in
    pSeries_setup.c
  o ppc64: don't include <stddef.h>
  o ppc64: PCI ignores empty phb regions
  o ppc64: Fix new mpic driver on some POWER3
  o ppc64: Fix g5-only build
  o ppc64: Add new "Maple" platform support
  o 8250: Fix empty port registration
  o ppc64: Some sparse fixes
  o ppc32: Fix boot on PowerMac
  o ppc64: Enable maple IDE fixup
  o amd8111e: Fix identation of amd8111e_rx_poll()
  o amd8111e: Add support for ppc64 eval board
  o fbdev: workaround for broken X servers
  o atyfb: Fix power management
  o Fix pmac_zilog as console
  o ppc64: Fix G5 low level i2c code
  o ppc64: Add HW CPU timebase sync

Bjoern Paetzel:
  o USB Storage: unusual_devs entry for yakumo

Bjorn Helgaas:
  o PCDP: call acpi_register_gsi() with arguments in correct order
  o ia64 iomap implementation
  o radeonfb: If no video memory, exit with error
  o acpi: better encapsulate eisa_set_level_irq()
  o PCI: propagate pci_enable_device() errors
  o PCI: remove unconditional PCI ACPI IRQ routing
  o HPET init/add fixes
  o fix HPET time_interpolator registration

Bob Breuer:
  o sparc32: fix for HyperSPARC DMA errors

Brian Gerst:
  o mem leak in tty_io.c

Brian Haley:
  o [IPV6] Lookup appropriate destination when sending TCPv6 with
    routing header

Carsten Otte:
  o s390: dcss segments cleanup

Catalin Marinas:
  o [ARM] Versatile: patch-2.6.9-icst307
  o [ARM] Versatile: patch-2.6.9-common
  o [ARM] Versatile: patch-2.6.9-ab / patch-2.6.9-pb

Chas Williams:
  o [ATM]: [horizon] eliminate pci_find_device()
  o [ATM]: don't leak skb on as_indicate failure; don't wakeup twice on
    as_close
  o [ATM]: [ambassador] fix <irq> type and printk warning (from Randy
    Dunlap <rddunlap@osdl.org>)
  o [ATM]: [drivers] add missing pci_tbl exports (pointed out by Adam
  o [ATM]: [atmtcp] fix refcounting and vcc search

Chris Wedgwood:
  o uml: use generic IRQ code
  o uml: Build fix for TT w/o SKAS
  o uml: Kconfig.debug update
  o uml: minor warning removal
  o uml: mconsole_proc rewrite
  o uml: resolve symbols in back-traces
  o Remove build warning from drivers/char/random.c on 32-bit platforms
  o [ide] remove some cruft from ide.h

Chris Wright:
  o lsm: remove net related includes from security.h
  o error out on execve with no binfmts
  o uninline __sigqueue_alloc
  o binfmt_elf: handle partial reads gracefully

Christian Bornträger:
  o s390: debug feature system control

Christian Ehrhardt:
  o [IPV4]: Do not try to unhash null-netdev nexthops

Christoph Hellwig:
  o [NETFILTER]: Make *_find_target_lock routines static
  o use generic_file_open in udf
  o [ATM]: Mark vcc_remove_socket static
  o [XFRM]: Remove dead exports
  o [IPV6]: Remove dead exports
  o [TCP]: Remove dead exports
  o [NET]: Remove dead socket layer exports
  o remove dead exports in sounds/oss
  o unexport getnstimeofday
  o unexport kick_process
  o remove page_follow_link
  o unexport sys_lseek
  o remove ext2 xatts exports
  o parport: kill dead code and exports
  o unexport vc_cons_allocated
  o mark pi_unclaim static
  o unexport set_selection and paste_selection
  o unexport firmware_class
  o fix show_refcnt return value type
  o remove invoke_softirq
  o remove mousedrivers.sgml
  o [ide] remove more dead ide exports
  o more hardirq.h consolidation
  o remove two leftover <asm/linux_logo.h> files
  o remove dead kernel_map_pages export
  o remove dead exports from random.c
  o unexport do_settimeofday
  o [NET]: Remove dead exports from net/core/dev.c
  o [NET]: Remove net_init.c ifdef clutter
  o fix sata_svw compile

Christoph Lameter:
  o Posix layer <-> clock driver API fix
  o fix IBM cyclone clock and some cleanup
  o mmtimer driver update: add SHub interrupt support

Clemens Buchacher:
  o sparc32: revert sys_setaltroot

Colin Leroy:
  o clean up therm_adt746x
  o fix via-pmu.c compilation without CONFIG_PMAC_PBOOK
  o therm_adt746x: gradually change fan speed and start both fans on
    Albooks

Dale Farnsworth:
  o USB: USB fixes for non-cache-coherent processors

Dan Malek:
  o ppc32: Update MPC8xx code to quasi functional

Daniel Jacobowitz:
  o Unwind information fix for the vsyscall DSO

Darren Hart:
  o sched: active_load_balance fixes

Dave Jiang:
  o [ARM PATCH] 2216/1: Update iop3xx timers to new update process
    times scheme
  o [ARM PATCH] 2222/1: iop3xx timer routine cleanup
  o [ARM PATCH] 2223/1: convert serial UART to platform device on
    iop3xx
  o [ARM PATCH] 2231/1: remove unused file in iop321 port

Dave Jones:
  o [CPUFREQ] Reevaluate users requests after denial
  o [CPUFREQ] Don't break on FFFFFFFF'd frequencies
  o [CPUFREQ] struct acpi_processor_performance *acpi_processor_perf
    should be static
  o [CPUFREQ] dbs_tuners_ins should be static
  o [CPUFREQ] Attribute definitions in cpufreq core should be static
  o [CPUFREQ] cpufreq_sysctl_table should be static even though it'll
    be gone soon
  o [CPUFREQ] Dothan is stepping 13  == 0x0D instead of 0x13 == 19
  o [CPUFREQ] Rename cpufreq acpi module
  o [CPUFREQ] Unify the CPU_FREQ config option
  o [CPUFREQ] 2.4 API clarification
  o [CPUFREQ] Add a unified cpufreq debug infrastructure
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    speedstep library
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    speedstep-smi driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    speedstep-ich driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    speedstep-centrino driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    p4-clockmod driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    longrun driver, and add some dprintks which might be / have been of
    interest.
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    powernow-k8 driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    powernow-k7 driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    longhaul driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    gx-suspmod driver
  o [CPUFREQ] Use the unified cpufreq debug infrastructure in the
    acpi-cpufreq driver
  o [CPUFREQ] Add (one each) dprintk for the performance and powersave
    cpufreq governors
  o [CPUFREQ] Add a few dprintks for the userspace cpufreq governor
  o [CPUFREQ] Add a few useful dprintks in the frequency table helpers
  o [CPUFREQ] Add a few useful dprintks to the cpufreq core
  o [CPUFREQ] Show the CPUs which can only change frequencies at the
    same time in a sysfs file named "affected_cpus"
  o [CPUFREQ] module_vid_table is only used if DEBUG isn't set, so put
    #ifdefs around it
  o [CPUFREQ] print_speed and speedbuffer are only used if DEBUG isn't
    set so put #ifdefs around them.
  o [CPUFREQ] Use __ATTR in cpufreq.c attribute definitions
  o [CPUFREQ] Set .owner in cpufreq_userspace.c sysfs attribute
    definition
  o [CPUFREQ] Use __ATTR in cpufreq_ondemand.c attribute definitions
  o [CPUFREQ] Set .owner in freq_table's sysfs definition
  o [CPUFREQ] ondemand return EINVAL on errors
  o [CPUFREQ] Fix x86-64 compile
  o [CPUFREQ] Remove config.h includes from ondemand driver

Dave Kleikamp:
  o JFS: Fix extent overflow bugs
  o JFS: avoid assert in lbmfree
  o JFS: endian annotations
  o JFS: use alloc_metapage for consistency
  o JFS: make some symbols static

David Brownell:
  o USB: usb hub descriptor fetch needs retries
  o USB: usb suspend support for hid-core
  o USB: goku_udc sparse updates
  o USB: usb/hcd kconfig updates
  o USB: usb error code docs
  o USB: ohci module param for broken bios
  o USB: omap_udc updates
  o USB: net2280 compile fixes
  o USB input Kconfig updates
  o USB ehci: minor pci tweaks
  o USB ehci: handle earlier endpoint_disable()
  o USB ehci: minor debug cleanups
  o Missed usb devices on boot
  o usbcore and system sleep states
  o PCI: make pci_save_state() only happen when no suspend()
  o EHCI suspend/resume updates
  o OHCI suspend/resume updates (minor)
  o usbcore, diagnostic tweaks
  o USB: fix ohci_restart warning
  o USB: fix bug
  o USB: clean up error messages
  o USB: ohci, remove pre-byteswapped constants
  o USB: ohci, hooks for big-endian registers
  o USB: usb gadget drivers, minor tweaks
  o USB: usb gadget serial driver v2.0
  o USB: ohci-omap, updates for omap1510/5910 and innovator
  o USB: usb network Kconfig updates
  o USB: usb PM updates, PCI glue (1/4)
  o USB: usb PM updates, root hub stuff (2/4)
  o USB: usb PM updates, OHCI (3/4)
  o USB: usb PM updates, EHCI (4/4)
  o driver core: shrink struct device a bit

David Gibson:
  o ppc64: don't build virtual IO drivers for PowerMac
  o ppc64: trivial sparse cleanups
  o ppc64: xmon sparse cleanups
  o ppc64: rework hugepage code

David Howells:
  o Shift key-related error codes up and insert ECANCELED
  o ppc/ppc64: hook up key management syscalls
  o move key_init to security_initcall
  o Unexport some RxRPC symbols
  o key management: fix locking problem and move __key_check() out of
    line
  o fix page size assumption in fork()
  o EXT3 compiler warning fix
  o Make /proc/kcore conditional on CONFIG_MMU

David Lazar:
  o fbcon: Add box drawing glyphs to 6x11 font

David S. Miller:
  o [NETFILTER]: Fix ipt_hashlimit build with NETFILTER_DEBUG enabled
  o [ATY]: Fix build on sparc after viro sparse changes
  o [NETFILTER]: ip_ct_attach decl got removed by accident
  o [PKT_SCHED]: Make net/tc_act/tc_pedit.h include net/act_api.h
  o [VLAN]: Revert vlan_dev_hard_start_xmit part of Ben Greear's
    changes
  o [TG3]: Bump driver version and reldate
  o [SPARC64]: Do free_initmem() poisioning
  o [SPARC64]: Update defconfig
  o [SPARC64]: Add __must_check to user copy routines
  o [SPARC64]: Fix IRQ setting in sunsu serial driver
  o [SPARC64]: Add dummy pci_get_legacy_ide_irq() routine
  o [TG3]: Use ioremap_nocache()
  o [TG3]: Bump driver version and reldate
  o [GNET_STATS]: Export gnet_stats_start_copy_compat to modules
  o [TCP]: Fix tcp_diag build with ipv6 completely disabled
  o [SUNGEM]: Use CONFIG_PPC_PMAC throughout
  o Cset exclude:
    herbert@gondor.apana.org.au|ChangeSet|20041110052404|08839
  o [APPLETALK]: Missing file add in recent commit

Dely Sy:
  o PCI: Updated patch to add ExpressCard support
  o PCI: Updated patch to fix adapter speed mismatch for 2.6 kernel
  o PCI: ASPM patch for

Denis Vlasenko:
  o kconfig.debug: mention that DEBUG_SLAB can slow down machine quite
    a bit
  o kbuild: make gcc -align options .config-settable
  o [CRYPTO]: aes-586-asm: formatting changes
  o [CRYPTO]: aes-586-asm: small optimizations

Dinakar Guniguntala:
  o Fix do_wait race

Dmitry Torokhov:
  o ik8.c: export power_status parameter through sysfs
  o Driver core: export device_attach
  o Driver core: add driver_probe_device
  o Driver core: add driver symlink to device
  o panic_blink and i8042 unloading

Domen Puncer:
  o lib/parser: fix %% parsing

Dominik Brodowski:
  o Fix PCMCIA duplicate pc_debug names

Doug Maxey:
  o ppc64: install outside of source tree

Eugene Surovegin:
  o PPC32: remove bogus eXecute permissions
  o I2C: fix recently introduced race in IBM PPC4xx I2C driver

Evgeniy Polyakov:
  o w1/w1_family: replace schedule_timeout() with
    msleep_interruptible()
  o w1/w1: replace schedule_timeout() with msleep_interruptible()
  o w1/dscore: replace schedule_timeout() with msleep_interruptible()
  o w1/w1_int: replace schedule_timeout() with msleep_interruptible()

Frank Pavlic:
  o s390: network driver

François Romieu:
  o via-velocity: wrong module name in Kconfig documentation

Gabriel Paubert:
  o I2C: Recent I2C "dead code removal" breaks pmac sound

Ganesh Venkatesan:
  o e100 - Use pci_device_name for syslog messages till registering
    netdevice
  o e100 - use NET_IP_ALIGN to set rx data buffer alignment
  o e100 driver version number update
  o e1000 - use pci_device_name for syslog messages till registering
    netdevice.
  o e1000 - Removed support for advanced TCO features
  o e1000 Check value returned by from pci_enable_device
  o e1000 - Fix VLAN filter setup errors (while running on PPC)
  o e1000 - Polarity reversal workaround for 10F/10H links
  o e1000 - Ethtool -- 82545 do not support WoL
  o e1000 update -- fix MODULE_PARM, module_param, module_param_array
  o e1000:  modified ethtool_set_pauseparam to use e1000_setup_link for
    flow control settings for fiber serdes link
  o e1000: remove unused function e1000_enable_mng_pass_thru
  o e1000: fix set ringparam for ethtool returning error code on bad
    input
  o e1000: driver version update
  o e1000: white space corrections
  o e100: Fix loss of connectivity to BMC when interface is brought
    down.
  o e100: Fix set ringparam for ethtool returning error code on bad
    input
  o e100: Driver version number update
  o e1000: Configuration and user guide update
  o e100: Configuration and user guide update
  o ixgb: Configuration and user guide update

Geert Uytterhoeven:
  o NTFS: missing #include <linux/vmalloc.h>
  o Cyclades assignment warning
  o SCx200_ACB depends on PCI
  o Atyfb: kill assignment warnings on Atari due to __iomem
  o m68k: HP300 core updates
  o m68k: HP300 DIO
  o m68k: HP300 LANCE
  o m68k: HP300 fb
  o m68k: M68k I/O for generic 8250 on HP300
  o m68k: HP300 8250 serial for DCA and APCI ports
  o m68k: HP300 config
  o m68k: HP300 SCSI chip is 98265A
  o m68k: hades-pci.c: replace pci_find_device() with pci_get_device()
  o m68k: HP300: Convert DIO bus and its drivers to the new driver
    model
  o m68k: fix incorrect config comment in check_bugs()
  o m68k: missing/superfluous config.h
  o m68k: Sun-3 Makefile: join short multi-line
  o m68k: MVME167 serial: Replace bottom half handler with task queue
    handler
  o m68k: Add 43 missing syscalls
  o m68k: Update defconfig for 2.6.9
  o m68k: Add defconfig for Amiga
  o m68k: Add defconfig for Apollo
  o m68k: Add defconfig for Atari
  o m68k: Add defconfig for BVME4000 and BVME6000
  o m68k: Add defconfig for HP9000/300 and HP9000/400
  o m68k: Add defconfig for Macintosh
  o m68k: Add defconfig for MVME147
  o m68k: Add defconfig for MVME162, MVME166, and MVME167
  o m68k: Add defconfig for Q40 and Q60
  o m68k: Add defconfig for Sun 3
  o m68k: Add defconfig for Sun 3x
  o m68k: Disable SERIO_I8042
  o m68k: Reiserfs: Add missing #include <linux/sched.h>
  o m68k: Sun 3: Fix modular XFS by exporting vmalloc_end
  o m68k: Remove duplicate includes

George G. Davis:
  o [ARM PATCH] 2179/1: gcc-4.0 static declaration of 'meminfo' follows
    non- static declaration build error
  o [ARM PATCH] 2181/1: Fix gcc-4.0 static declaration of '__clz_tab'
    follows non-static declaration build error
  o [ARM PATCH] 2188/1: Add missing MODULE_LICENSE declaration in PXA
    Lubbock PCMCIA driver
  o [ARM PATCH] 2182/1: apcs-32 and alignment-traps command line
    options are deprecated in gcc-4.0

Gerd Knorr:
  o v4l: bttv IR input update
  o v4l: bttv whitespace cleanup
  o v4l: i2c whitespace cleanup
  o v4l: IR whitespace cleanup
  o v4l: msp3400 update
  o v4l: tuner update
  o v4l: videobuf whitespace cleanup
  o v4l: videodev whitespace cleanup
  o v4l: config cleanups
  o bttv subdev fix
  o v4l: yet another video-buf interface update
  o v4l: add video-buf-dvb.c
  o v4l: bttv update
  o v4l: saa7134 update
  o v4l: cx88 update
  o v4l: saa7146 update
  o v4l: tuner modparam
  o v4l: ir-common modparam
  o v4l: v4l1-compat modparam
  o v4l: msp3400 fix
  o media/video/bw-qcam.c: remove an unused function

Grant Grundler:
  o [ide] ns87415: PA-RISC update

Greg Edwards:
  o increase max LOG_BUF_SHIFT value

Greg Kroah-Hartman:
  o USB: update devices.txt with the proper USB minor number
    information
  o USB: add phidgetkit driver
  o USB: remove unneeded checks in the usb-serial core
  o USB: fix build error in the USB core if CONFIG_PROCFS is disabled
  o USB: fix DoS in the visor driver by rate limiting sends
  o PCI: use pci_dev_present() in irq.c check
  o kobject: add CONFIG_DEBUG_KOBJECT
  o hotplug: prevent skips in sequence number from happening
  o USB: fix up serial object reference count bug on error path
  o USB: fix up pl2303 device ids that ended up getting duplicated
  o USB: fix sparse warnings in cypress_m8 driver
  o kevent: fix build error if CONFIG_KOBJECT_UEVENT is not selected
  o I2C: fix MODULE_PARAM warning in pc87360.c driver
  o W1: fix build warnings due to msleep changes
  o PCI: remove kernel log message about drivers not calling
    pci_disable_device()
  o I2C: remove probe_range from I2C sensor drivers, as it's not used
  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not
    used
  o I2C: fix i2c_detect to allow NULL fields in adapter address
    structure
  o I2C: moved from all sensor drivers from normal_i2c_range to
    normal_i2c
  o I2C: delete normal_i2c_range logic from sensors as there are no
    more users
  o kobject: fix double kobject_put() in error path of kobject_add()
  o timer: fix up problem where two sysdev_class devices had the same
    name
  o PCI Hotplug: fix up remaining MODULE_PARAM usage in pci hotplug
    drivers
  o USB: fix up sparse lock warning in whiteheat driver
  o USB: fix up locking bugs in kl5kusb105.c that sparse found
  o Cset exclude: david-b@pacbell.net|ChangeSet|20041112030233|28853
  o USB: fix locking bug found by sparse in ehci-sched.c
  o USB: fix 2 locking bugs in usbtest.c as found by sparse
  o USB: fix endian warnings as found by sparse in the rio500.c driver
  o USB: fix sparse warnings in tiglusb.c driver
  o USB: fix endian bug found by sparse in freecom usb-storage driver
  o USB: fix up endian issues found by sparse in io_edgeport.c driver
  o USB: fix endian issues found by sparse in mct_u232 driver
  o I2C: fix up some out of date Documentation
  o I2C: fix up rtc8564 which should not have been changed in my
    previous cleanups
  o driver core: fix up some missed power_state changes from David's
    patch
  o sysfs: fix odd patch error
  o USB: fix sparse warnings in io_ti.c
  o USB: fix up a bunch of sparse bitwise warnings in the ohci driver

Greg Ungerer:
  o remove unused include in m68knommu mm/init.c
  o remove unused include in m68knommu mm/memory.c
  o remove uneeded includes (5206e/config.c)
  o remove uneeded includes (5249/config.c)
  o remove uneeded includes (5307/config.c)
  o remove unused shglcore support
  o clean up HZ definition
  o remove unused shglcore.h include
  o remove other unused shglcores.h include
  o support all relocation types for m68knommu modules
  o update total_vm on non-MMU configurations
  o m68knommu: add hardware defines for the ColdFire 527x CPU family
  o m68knommu: new CPU support strings in setup
  o m68knommu: update syscall table to be inline with other
    architectures
  o m68knommu: build real lib udelay() function
  o m68knommu: new board support nad missing sections for linker script
  o m68knommu: create real lib udelay() function
  o m68knommu: new CPU and board options for configuration
  o m68knommu: update syscall definitions to match new syscall table
  o m68knommu: fix calculation overflow in udelay() on fast CPU's
  o m68knommu: clock definitions for 527x ColdFire CPU's
  o m68knommu: fix do_signal() to properly use get_signal_to_deliver()
  o m68knommu: makefile support for new CPU and board types
  o m68knommu: checksum.h needs linux/in6.h
  o m68knommu: move ColdFire PIT timer to common code directory
  o m68knommu: new device support for ColdFire FEC ethernet driver
  o m68knommu: kernel startup code for Freescale M5271EVB board
  o m68knommu: update defconfig
  o m68knommu: 527x platform support Makefile
  o m68knommu: build PIT timer for 527x and 528x CPUs
  o m68knommu: use linux/delay.h instead of asm/delay.h
  o m68knommu: get flash based boot args for SCALES and CAMcam boards
  o m68knommu: dynamic RAM sizing for Motorola 5206e platform
  o m68knommu: hardware configuration for Freescale 527x family of CPUs
  o m68knommu: add kernel startup code for the Freescale M5275EVB board
  o m68knommu: move ColdFire 5282 config code to common 528x config
    code
  o m68knommu: move ColdFire 5282 Makefile to common 528x Makefile
  o m68knommu: move ColdFire M5282EVB kernel startup code to common
    528x platform directory
  o m68knommu: remove unused include of delay.h in ColdFire 5407
    configuration code
  o m68knommu: use correct register offsets for ColdFire 527x FEC
    ethernet
  o m68knommu: move ColdFire 5282 definitions to common 528x include
  o m68knommu: add kernel startup code for the ColdFire 5272 Feith
    CANcam board
  o m68knommu: add 527x and 528x support to ColdFire UART definitions
  o m68knommu: add 527x and 528x support to ColdFire DMA definitions
  o m68knommu: move definition of kernel stack size
  o m68knommu: update comments in ColdFire PIT timer include
  o m68knommu: kernel startup code for the ColdFire 5272 Feith SCALES
    board
  o m68knommu: add ColdFire 528x CPU reset code
  o m68knommu: include 527x and 528x SIM hardware defines in common
    ColdFire SIM header
  o m68knommu: move senTec board supoprt to common 528x ColdFire
    directory

Guido Barzini:
  o [ARM PATCH] 2177/1: Trivial: contents of mach-h720x/Kconfig should
    be conditional on ARCH_H720X

Guido Guenther:
  o rivafb: stricter memory ordering
  o rivafb: clean up ordering constraints

Hanna V. Linder:
  o hw_random.c: replace pci_find_device
  o add 'for_each_pci_dev()' helper macro
  o PCI: Changed pci_find_device to pci_get_device
  o cyclades.c: replace pci_find_device
  o zr36120.c: Convert pci_find_device to pci_dev_present
  o ide.c: replace pci_find_device with pci_dev_present
  o scx200_wdt.c: replace pci_find_device with pci_dev_present
  o ibmphp_core.c: replace pci_get_device with pci_dev_present
  o chrp_pci.c: replace pci_find_device with for_each_pci_dev
  o gemini_pci.c: replace pci_find_device with for_each_pci_dev
  o matroxfb_base.c: convert pci_find_device to pci_get_device
  o lopec.c: replace pci_find_device with pci_get_device
  o k2.c: replace pci_find_device with pci_get_device
  o cmipci.c: convert pci_find_device to pci_get_device
  o drm_drv.h: replace pci_find_device
  o sis-agp.c: replace pci_find_device with pci_get_device
  o pci-gart.c: replace pci_find_device with pci_get_device
  o ret_mb_a_pci.c: replace pci_find_device with pci_get_device
  o pci_iommu.c: replace pci_find_device with pci_get_device
  o isa.c: replace pci_find_device with pci_get_device
  o ebus.c: replace pci_find_device with pci_get_device
  o fixups-dreamcast.c: replace pci_find_device with pci_get_device
  o sandpoint.c: replace pci_find_device with pci_get_device
  o prpmc750.c: replace pci_find_device with pci_get_device
  o mcpn765.c: replace pci_find_device with pci_get_device
  o pcore.c: replace pci_find_device with pci_get_device
  o pmac_pci.c: replace pci_find_device with pci_get_device
  o pplus.c: replace pci_find_device with pci_get_device
  o prep_pci.c: replace pci_find_device with pci_get_device

Harald Welte:
  o [NETFILTER]: fix ipt_ULOG bogus error messages
  o [NET]: Fix NLM_F_MULTI in tcp_diag and xfrm_user

Herbert Xu:
  o [TCP]: Only re-set TSO size for packet which was TSO to begin with
  o [NET]: Give skb_checksum_help() an skb_buff * again
  o [TCP]: Handle real partial-ACKs of TSO frames correctly
  o [TCP]: Move tcp_get_info() into tcp.c
  o [NETLINK]: Remove netlink_sock_nr
  o [NETLINK]: Check netlink_insert in kernel_create
  o [XFRM]: Don't panic in xfrm_user_init
  o [ETHTOOL]: Enforce SG requires TX csum rule
  o [XFRM]: Move xfrm4_rcv export to its site
  o [IPSEC]: Make  ah4/esp4/ipcomp depend on INET
  o [TCP]: Modularize tcpdiag
  o [XFRM]: Fix build failures without CONFIG_INET
  o [TCP]: Modular ipv6 support in tcpdiag
  o [NETLINK]: Hash sockets by pid if not multicast
  o [NET]: Neighbour table entries counter needs to be atomic_t
  o [NET]: Get rid of unused global counter in neighbour
  o [NETLINK]: Fix pid rover code
  o [IPV6]: Close small race in ip6_del_rt

Hideaki Yoshifuji:
  o [IPV6] Remove codes related to RTF_ALLONLINK
  o [IPV6] simplify functions related to RTF_ALLONLINK
  o [IPV6] NDISC: update neighbor cache entry by RS
  o [IPV6] kill a warning when building without CONFIG_SYSCTL
  o [IPV6]: Do not purge default routes by RA
  o [IPV6] Fix unresolved symbol timer_bug_msg
  o [IPV6] introduce lightweight IPv6 address comparison function
  o [IPV6] Use ipv6_addr_equal() where appropriate

Hidetoshi Seto:
  o futex_wait hang fix

Hirofumi Ogawa:
  o FAT: remove incorrect BUG_ON()
  o FAT: fix VFAT_IOCTL_READDIR_BOTH ioctl

Hirokazu Takata:
  o m32r: fix a typo of delay.c
  o m32r: Fix ELF_CORE_COPY_REGS macro to generate  a correct "core"
    file
  o m32r: remove rep_nop()
  o m32r: remove old ELF relocation types
  o m32r: fix arch/m32r/lib/memset.S
  o m32r: fix for use of Mappi PCC

Hollis Blanchard:
  o HVSI hangup oops
  o HVSI early boot console
  o HVSI reset support

Hugh Dickins:
  o shmem NUMA policy spinlock
  o statm: __vm_stat_accounting
  o statm: shared = rss - anon_rss
  o statm: fix negative data
  o omit CommitAvail
  o tmpfs truncate latency
  o anon cris align address_space
  o tmpfs: CONFIG_TMPFS=n mount fix

Ian Campbell:
  o [ARM PATCH] 2219/2:  Ignore IRQ_NONE for edge triggered interrupts

Ingo Molnar:
  o Avoid small irq preemption recursion window
  o [NET]: Fix unbalanced local_bh_enable() in dev_queue_xmit()

Ivan Kokshaysky:
  o alpha: fix sparse warnings
  o alpha: fix CIA IO
  o alpha: bootp fixes
  o PCI: add pci_fixup_early

Jack Steiner:
  o [IA64] Delete obsolete code from SGI console driver
  o [IA64-SGI] Update asm-ia64/sn/sn_cpuid.h macros
  o [IA64-SGI] Delete simulator support from SN idle loop
  o [IA64-SGI] Update asm-ia64/sn/sn_cpuid.h macros
  o [IA64-SGI] Delete unused variable (master_node_bedrock_address)

Jamal Hadi Salim:
  o [PKT_SCHED]: Add generic packet editor
  o [NETFILTER]: ipt mutex locks access
  o [PKT_SCHED]: Add iptables action

James Bottomley:
  o make osst compile again after st structure changes

James Cleverdon:
  o x86-64 clustered APIC support

James Morris:
  o Add d_alloc_name() to libfs
  o SELinux: fix netif bugs and simplify
  o SELinux: fix sidtab locking bug

James Nelson:
  o ramdisk.txt update
  o ftape has no maintainer
  o ftape documentation fixes
  o Documentation/cpqarray.txt update
  o Documentation/mkdev.ida removal
  o Patch to arch/sparc/Kconfig [1 of 5]
  o More patches to arch/sparc/Kconfig [3 of 5]
  o More patches to arch/sparc/Kconfig [5 of 5]
  o More patches to arch/sparc/Kconfig [4 of 5]
  o Re: More patches to arch/sparc/Kconfig [2 of 5]
  o Documentation/digiboard.txt update
  o Documentation/00-INDEX.txt update
  o MAINTAINERS update
  o Documentation/digiecpa.txt update
  o digiecpa MAINTAINERS update
  o computone: Documentation/computone.txt update
  o computone: MAINTAINERS update
  o floppy: Updates to Documentation/floppy.txt
  o hw_random: Remove changelog from hw_random.txt
  o documentation: Remove drivers/char/README.computone
  o documentation: Remove drivers/char/README.cyclomY
  o documentation: Remove drivers/char/README.ecpa
  o documentation: Remove drivers/char/README.scc
  o tipar: Documentation/tipar.txt cleanup
  o ramdisk: Correction to Documentation/kernel-parameters.txt
  o md: Documentation/md.txt update

Jan Dittmer:
  o aic7xxx remove warnings

Jan Kara:
  o Quota warnings somewhat broken

Jan Kasprzak:
  o Minor fix of RCU documentation

Jaroslav Kysela:
  o ALSA CVS update ENS1370/1+ driver Fixed AC3-passthru on
    ens1371/1373 boards.
  o ALSA CVS update ICE1712 driver Allow the private EEPROM image for
    evaluation boards
  o ALSA CVS update ES18xx driver Fixed a bug in setting the filter
    register.
  o [ALSA]  Added __GFP_NORETRY to avoid OOM-killer
  o [ALSA]  Enable __GFP_NOWARN as default for buffer allocation
  o [ALSA]  Korg1212 misc fixes
  o [ALSA]  AC97 96 kHz sample rate support
  o [ALSA]  add missing ifdef for disabling MIDI
  o [ALSA]  suppress auto-loading of modules in module_init()
  o [ALSA]  Fix latency in ens1371 driver
  o [ALSA]  add AC97 quirk for Fujitsu-Siemens E4010
  o [ALSA]  remove gameport/MIDI support
  o [ALSA]  add mixer quirk for LineX FM Transmitter
  o [ALSA]  [ac97] Added VIA shared type
  o [ALSA]  [ac97] Check ac97 codec id in quirk table
  o [ALSA]  ac97 quirk entry for Soltek SL-75DRV5
  o [ALSA]  inverted EAPD support
  o [ALSA]  detect errors reported by the hardware
  o [ALSA]  Added Compaq Evo W4000 quirk
  o [ALSA]  [emu10k1] Audigy DSP support
  o [ALSA]  Fix the OSS PCM emulation - O_NONBLOCK write
  o [ALSA]  Added support for AudioTrak Prodigy 192 cards
  o [ALSA]  add UA-1000 sample rate detection
  o [ALSA]  mark snd_card_dummy_new_mixer() as static
  o [ALSA]  [ac97 core] added AC97_SCAP_DETECT_BY_VENDOR flag
  o [ALSA]  copy_to_user() return value checking in snd_seq_read()
  o [ALSA]  Added missing header file for AudioTrak Prodigy 192 cards
  o [ALSA]  Fix driver name for nforce and clean-up
  o [ALSA]  show codec name in card description
  o [ALSA]  adjust intel8x0 joystick documentation
  o [ALSA]  enhance Kconfig help texts
  o [ALSA]  remove 'ALSA' from Kconfig USB menu name
  o [ALSA]  fix ALI M5451 description
  o [ALSA]  Fixes for PCM/control 32bit emulation
  o [ALSA]  Support for capture of 16,32,64 channels on emu10k1 device
    2
  o [ALSA]  Remove delay() to improve latency
  o [ALSA]  Improved clock measurement
  o [ALSA]  Fixed the obsolete description in comments
  o [ALSA]  Fix auto-loading of sequencer modules
  o [ALSA]  Fix iomem variable type
  o [ALSA]  Added support of Mediastation
  o [ALSA]  rme32 segfault fix
  o [ALSA]  [hdsp] Fix for 64bit architectures
  o [ALSA]  Fix SPDIF rate setting for old ICHs
  o [ALSA]  use card-specific driver name
  o [ALSA]  remove 'Rawmidi' part from sequencer port names
  o [ALSA]  don't stop capture on errors
  o [ALSA]  Fix the variable types in struct
  o [ALSA]  more au88x0 eq cleanups
  o [ALSA]  Fix HDSP meter ioctl
  o [ALSA]  Aureon S/PDIF input fixes
  o [ALSA]  Aureon S/PDIF input fixes
  o [ALSA]  Fix drain/drop of linked PCM streams
  o [ALSA]  snd-usb-usx2y 0.7.3
  o [ALSA]  Replace with usb_kill_urb()
  o [ALSA]  Fix peakmeter ioctl on big-endian
  o [ALSA]  Clean up ice1712 chip struct
  o [ALSA]  Adds AC'97 support to Aureon cards
  o [ALSA]  Add reset_workaround module option
  o [ALSA]  add overclocking option for the analog input
  o [ALSA]  Add (experimental) CM9761 support
  o [ALSA]  Fix SPDIF support on ICH4/5/6
  o [ALSA]  Fix AC97 master mute
  o [ALSA]  Fix AC3 playback on SB Live
  o ALSA CVS update USB generic driver add Edirol UA-25 support
  o [ALSA]  Fix / clean up OPL3 for CS4281
  o [ALSA]  fix DAC slot assignment
  o [ALSA]  fix description of SPSA=3 in the proc file
  o [ALSA]  fix snd_opl3_init documentation
  o [ALSA]  Clean up bitmap
  o [ALSA]  Fix dead blocking during module_init()
  o [ALSA]  Fix pci_restore_state()
  o [ALSA]  Add KERN_ERR to error messages
  o [ALSA]  Fix typo
  o [ALSA]  Added dxs quirk for QDI Kudoz 7X/600-6AL
  o [ALSA]  Fix ac97 codec reset and clean up
  o [ALSA]  Fix compilation (sync with parisc tree)
  o [ALSA]  Fix Aureon CCS init sequence
  o [ALSA]  Fix the detection of secondary codec
  o [ALSA]  fixing a two-rme32-in-one-machine bug
  o [ALSA]  Add routing/volume of ADAT I/O on EWS88D
  o [ALSA]  Misc. volume fixes
  o [ALSA]  RME9632 precise_ptr fix
  o [ALSA]  fix build in !KMOD case (sequencer)
  o [ALSA]  Fixed SPDIF on CS4298
  o [ALSA]  Fix AC97_EXTENDED_STATUS initialial value
  o [ALSA]  Add VIA8237 driver type
  o [ALSA]  PCM boundary fix in 32bit compat layer
  o [ALSA]  Fix non-blocking write in ALSA OSS emulation
  o [ALSA]  boot_devs removal - module_param_array() accepts NULL now

Jason Baron:
  o fix alt-sysrq deadlock

Jason Uhlenkott:
  o [IA64] fix pgtable.h comments

Jean Delvare:
  o I2C: New LM63 chip driver
  o I2C: New PC8736x chip driver
  o I2C: Check for unregistered adapter in i2c_del_adapter
  o I2C: add Tyan S4882 driver
  o I2C: Missing newlines in debug messages

Jean Tourrilhes:
  o Wireless Extension dropped patchlet

Jeff Dike:
  o uml: use PTRACE_SYSEMU also for TT mode
  o uml: Lots of little fixes by Jeff Dike
  o uml: update atomic.h so UML builds cleanly
  o uml: handle signal api
  o uml: sysenter is syscall
  o uml: generic singlestep syscall
  o uml: generic singlestepping
  o uml: clear singlestep
  o uml: dont check NR_syscalls
  o uml: set DTRACE correctly

Jeff Garzik:
  o [netdev] Remove no-op in-driver implementations of ->set_config()
  o Cset exclude: elf@buici.com|ChangeSet|20040920183610|08290
  o [libata] return ENOTTY rather than EOPNOTSUPP for unknown-ioctl
  o [libata] use kunmap_atomic() correctly
  o [libata] cosmetic libata.h changes to make merging with 2.4 easier
  o add nth_page()
  o [libata ahci] bump version to 1.00
  o Remove silly comment from linux/ata.h
  o [libata] remove dependence on PCI
  o [libata] bump versions, add MODULE_VERSION() tags
  o Parenthize nth_page() macro arg, in linux/mm.h

Jens Axboe:
  o fix bad segment coalescing in blk_recalc_rq_segments()
  o kill excessive cdrom prints
  o cfq v2 switch bug
  o issues with online scheduler switching
  o [ide] ide-disk: enable stroke by default
  o fix SCSI bounce limit
  o add READ_BUFFER_CAPACITY as read-ok command
  o queue congestion threshold hysteresis
  o direct-IO: handle EOF
  o warn once for unknown SCSI command
  o minor io scheduler documentation fixes
  o allow arch override of BIOVEC_PHYS_MERGEABLE
  o Mark as_init and as_exit as init and exit functions
  o Mark cfq_exit as an exit function
  o Mark deadline_init and deadline_exit as init and exit functions

Jesper Juhl:
  o ds_ioctl.c usercopy check
  o [NET]: Fix spelling error for IPComp help in Kconfig
  o kconfig: Small spelling fix for MODULE_SRCVERSION_ALL Kconfig
  o add a bunch of missing files to Documentation/00-INDEX

Jesse Barnes:
  o sched: small load balance fix
  o mmtimer sparse fixes
  o I/O space write barrier
  o [IA64] fix machine vectors for mmiowb
  o [TG3]: Use mmiowb in tg3.c
  o [IA64-SGI] remove duplicate INVALID_* defines from arch.h
  o [IA64-SGI] remove redundant macros
  o [IA64-SGI] move nic_t to asm/sn/types.h
  o [IA64-SGI] update sn2_defconfig
  o document mmiowb and readX_relaxed a bit more in deviceiobook.tmpl
  o fix find_next_best_node()
  o remove contention on profile_lock

Jesse Brandeburg:
  o ixgb: fix endianness issue for tx cleanup
  o e100: fix NAPI race with watchdog
  o e100: whitespace and DPRINTKS

Jim Hague:
  o pm2fb: Blanking fixes
  o pm2fb: Colour palette fixes

Jim Houston:
  o idr_remove safety checking

John Hawkes:
  o sched: improved load_balance() tolerance for pinned tasks

John Johansen:
  o delay rq_lock acquisition in setscheduler

John Lenz:
  o [ARM PATCH] 2206/1: convert locomo to use
    platform_get_resource\platform_get_irq

John W. Linville:
  o 3c59x: style change in vortex_ethtool_ops declaration
  o [BONDING]: Add MODULE_VERSION
  o [VLAN]: Add MODULE_VERSION

Jon Smirl:
  o PCI: add PCI ROMs to sysfs

Jonathan McDowell:
  o USB: add KC2190 support for usbnet

Justin Thiessen:
  o I2C: lm85.c driver update
  o I2C: fix lm85.c build warnings

Kai Mäkisara:
  o SCSI tape: remove remaining typedefs

Karsten Wiese:
  o UHCI: Convert remainder to bitwise-and

Kay Sievers:
  o kobject: fix hotplug bug with seqnum
  o take me home, hotplug_path[]
  o add the physical device and the bus to the hotplug environment
  o add the driver name to the hotplug environment
  o add the bus name to the hotplug environment
  o print hotplug SEQNUM as unsigned

Keith Owens:
  o [IA64] Correct bit test for salinfo oem decode
  o [IA64] Correct references from text/data to init.text/data
  o kbuild: Include useful absolute symbols in kallsyms

Kenji Kaneshige:
  o add missing pci_disable_device for e1000
  o PCI: add hook for PCI resource deallocation

Krzysztof Chmielewski:
  o [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265

Kumar Gala:
  o ppc32: dded MPC8555/8541 security block infrastructure
  o ppc32: fix rheap warning
  o ppc32: updated reporting of CPU rev & freq for e500 CPUs
  o ppc32: add performance counters to cpu_spec
  o ppc32: remove __setup_cpu_8xx
  o ppc32: remove zero initializations in cpu_specs

Lars Marowsky-Bree:
  o device-mapper trivial: stray semi-colon

Len Brown:
  o [ACPI] Notify SMM of cpufreq
    http://marc.theaimsgroup.com/?l=acpi4linux&m=109428989121089&w=2
  o EXPORT_SYMBOL(acpi_os_write_port); EXPORT_SYMBOL(acpi_fadt_is_v1);
  o [ACPI] firmware wakeup address is physical, not virtual (David
    Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=3390
  o [ACPI] add module parameters: processor.c2=[0,1] processor.c3=[0,1]
    to disable/enable C2 or C3 blacklist entries for R40e and Medion
    41700 http://bugme.osdl.org/show_bug.cgi?id=3549
  o [ACPI] create IBM ThinkPad ACPI driver -- ibm-acpi-0.6.patch
  o [ACPI] simplify ES7000 IRQ re-naming scheme so that it works for
    all PCI interrupts.
  o [ACPI] clarify #define ACPI_THERMAL_MODE_CRITICAL (Pavel Machek)
  o [ACPI] disable printk on AML breakpoint
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=135856
  o [ACPI] ACPICA 20040827 update from Bob Moore
  o [ACPI] ACPICA 20040922 from Bob Moore
  o [ACPI] acpi_os_sleep() now takes a single 64-bit value in [ms]
  o [ACPI] ACPICA 20040924 from Bob Moore
  o [ACPI] place-holder for ACPI 3.0 acpi_os_get_timer()
  o [ACPI] ACPICA 20041006 from Bob Moore
  o [ACPI] fix build warning in tables/tbget.c
  o [ACPI] ACPICA 20041015 from Bob Moore
  o [ACPI] fix build warning
  o Cset exclude:
    jason.davis@unisys.com[torvalds]|ChangeSet|20040914144015|50315
  o [ACPI] ibm-acpi 0.7 from Borislav Deianov
  o [ACPI] ACPI_CUSTOM_DSDT for IA64 too
  o [ACPI] Extensions for Display Adapters (Bruno Ducrot)
    http://bugme.osdl.org/show_bug.cgi?id=1944
  o [ACPI] ACPI_VIDEO is EXPERIMENTAL
  o [ACPI] Move the "only do this once" stuff from acpi_register_gsi()
    into eisa_set_level().
  o [ACPI] C1 fixes when processor driver is loaded honor "halt="
    cmdline parameter use monitor/mwait when available
    http://bugzilla.kernel.org/show_bug.cgi?id=2280
  o apply recent ES7000 ACPI interrupt fix to MPS mode
  o 8250_pnp serial_req.port_high fix for Tiger
  o [ACPI] introduces acpi_penalize_isa_irq() to to avoid PCI devices
    use IRQ of legacy PNP devices.
  o [ACPI] export acpi_match_ids()
  o [ACPI] create ACPI-based PNP driver
  o [ACPI] fix video module unload oops
  o [PNP] handler more than 16 IRQs
  o [ACPI] ACPIPNP handle IRQ resource value of 0 (David Shaohua Li)
  o [ACPI] fix x86_64 build warnings in video.c (Luming Yu)
  o [ACPI] correct compiled-in acpi_dbg_level default
  o [ACPI] fix return values for ACPI_FUNCTION_TRACE
    http://bugzilla.kernel.org/show_bug.cgi?id=3336
  o [ACPI] Remove default PNPACPI driver binding to legacy ACPI devices
  o [ACPI] remove obsolete blacklist entries (Andi Kleen)
    http://bugzilla.kernel.org/show_bug.cgi?id=3164
  o [ACPI] enable VIA quirk to fix audio interrupt on VIA_8233_5
    http://bugzilla.kernel.org/show_bug.cgi?id=3175
  o [ACPI] keep processor driver loaded even if acpi_disabled
  o [ACPI] disable PNPBIOS if ACPI, even without PNPACPI
  o [ACPI] delete duplicated code resulting from auto-merge
  o [ACPI] Allow limiting idle C-States
  o [ACPI] ACPICA 20041105 from Bob Moore
  o [ACPI] ibm ACPI 0.8 by Chris Wright and Borislav Deianov

Lennert Buytenhek:
  o [ARM PATCH] 2178/1: mnfd (move negated) emulation is busted on big-
    endian

Liam Girdwood:
  o [ARM PATCH] 2085/1: PXA SSP driver
  o [ARM PATCH] 2084/1: PXA SSP, I2S and other misc register defs

Linus Torvalds:
  o Start supporting lock context annotations
  o Annotate the trivial unconditional lock/unlock functions on SMP
  o Un-inline the big kernel lock
  o Fix broken intel8x0.c ALSA "merge"
  o ppc64: make G5 setup compile again
  o Allow BKL re-acquire to fail, causing us to re-schedule
  o Fix UP non-preempt build for kernel lock changes
  o Don't ask the user for esoteric compiler tweaks by default
  o Fix up "compat_sys_keyctl()" system call
  o Fix atyfb modular build on ppc
  o Fix kbuild problem with O=
  o Make x86 semaphore routines use register calling convention
  o amd8111e network driver: fix silly typo
  o Make "atomic_dec_and_lock()" a macro
  o Add sparse checker rules for conditional lock functions: trylock
    and atomic_dec_and_lock.
  o Annotate scheduler locking behaviour
  o Lock-annotate some kernel functions as an example of how it works
  o Annotate UP spinlock stubs with lock annotations
  o Make sparse pick up the gcc internal include directory
    automatically
  o Undo totally broken m68k patch
  o x86: regparm calling convention for exceptions and interrupts
  o Make "unlock_buffer()" use the optimized
    "smp_mb__after_clear_bit()"
  o usb: don't "unsuspend" ports that aren't suspended
  o Fix USB debugging build
  o usb: remove totally bogus OHCI iomem casts
  o Revert x86-64 flexmap code for now
  o Remove stale 0-byte files
  o Do EFI partitions only on ia64
  o aio: remove incorrect initialization of "nr_pages"
  o pc110 touchpad driver: be more polite
  o fbdev: fix compile of rivafb on __BIG_ENDIAN
  o wait_task_stopped() must not just return 0 when it has released the
    tasklist_lock.
  o Fix the fix
  o Revert recent EDD changes to use EXTENDED READ comand and
    CONFIG_EDD_SKIP_MBR
  o ppc: fix up pmac IDE driver for driver core changes
  o usb: edgeport serial driver uses CMSPAR, which not all
    architectures support
  o x86: only single-step into signal handlers if the tracer asked for
    it.
  o Linux 2.6.10-rc2

Lonnie Mendez:
  o hid-core: add two devices to device blacklist
  o usb-serial: add interrupt out support and improved debug messages
  o cypress_m8: add usb-serial driver 'cypress_m8' to kernel tree
  o usb-serial: free interrupt_out_buffer in cleanup routines

Luca Risolia:
  o USB: W996[87]CF driver updates
  o USB: SN9C10x driver updates

Luiz Capitulino:
  o USB: Module version info for CyberJack
  o USB: Module version info for PL2303
  o USB: Module version info for Belkin_sa

Maciej W. Rozycki:
  o defxx trivial updates
  o defxx device name fixes
  o UP local APIC bootstrap cleanup
  o x86, x86_64: Only handle system NMIs on the BSP

Maneesh Soni:
  o sysfs backing store - prepare sysfs_file_operations helpers
  o fix oops with firmware loading
  o sysfs backing store - add sysfs_direct structure
  o sysfs backing store: use sysfs_dirent based tree in file removal
  o sysfs backing store: use sysfs_dirent based tree in dir file
    operations
  o sysfs backing store: stop pinning dentries/inodes for leaf entries
  o sysfs: fix sysfs backing store error path confusion
  o fix kernel BUG at fs/sysfs/dir.c:20!
  o sysfs: fix duplicate driver registration error

Manfred Spraul:
  o handle posix message queues with /proc/sys disabled

Marc Singer:
  o [ARM PATCH] 2213/1: lh7a40x serial.h cleanup

Marcel Holtmann:
  o [Bluetooth] Ignore the BPA 100/105 devices
  o [Bluetooth] Fix another disconnect race
  o [Bluetooth] Allow vendor specific packet types
  o Fix deprecated MODULE_PARM for CAPI subsystem
  o [Bluetooth] Fix deprecated MODULE_PARM for PCCARD drivers
  o [Bluetooth] Send HCI_Reset for new Microsoft dongle
  o [Bluetooth] Add security callback to the core
  o [Bluetooth] Fix connection hash bug
  o [Bluetooth] Use usb_kill_urb() for synchronous unlink
  o [Bluetooth] Add function for triggering a link key change
  o [Bluetooth] Support responses with zero SCID
  o [Bluetooth] Make some functions static
  o Use add_hotplug_env_var() in firmware loader
  o [Bluetooth] Some trivial s/int/unsigned int/

Marcelo Tosatti:
  o Change pagevec counters back to unsigned long and cacheline align

Margit Schubert-While:
  o Add prism54 to MAINTAINERS

Mark A. Greer:
  o ppc32: add setup_indirect_pci_nomap() routine
  o ppc32: remove CONFIG_SERIAL_CONSOLE_BAUD

Mark Goodwin:
  o [IA64] sn_hwperf correctly handle bricks with multiple slabs

Markus Lidel:
  o fix bug in i2o_iop_systab_set where address is used instead  of
    length

Martin Schlemmer:
  o kbuild: check timestamps on files for initramfs

Martin Schwidefsky:
  o s390: sacf local root exploit (CAN-2004-0887)
  o s390: core changes
  o s390: tty_write fix

Martin Waitz:
  o fix wrong kfifo_init buffer size argument

Martin Wilck:
  o skip sync_arb_IDs on P4/Xeon

Matt Domsch:
  o [NET]: Zero out SIOCGIFHWADDR buffer if dev->addr_len is zero
  o EFI GPT: reduce alternate header probing
  o EDD: fix too short array

Matt Porter:
  o ppc32: disable broken L2 cache on all 440GX revs
  o ppc32: fix ppc4xx_progress warnings
  o ppc32: 40x and Book E debug: core support
  o ppc32: 40x and Book E debug: 4xx platform support
  o ppc32: add PPC440GX L2C error handler

Matthew Dharm:
  o USB Storage: Fix queuecommand() for disconnected devices

Matthew Wilcox:
  o sym2 2.1.18m
  o stifb bugfixes
  o kernel-parameters update for PA-RISC
  o parisc: arch/parisc/kernel/perf_asm.S
  o parisc: unwind fixes
  o parisc: spinlock fixes
  o parisc: debuglock fixes
  o parisc: fix 64-bit gcc 3.3 compiles
  o parisc: register usage documentation update
  o parisc: remove unused header file
  o parisc: make atomic_t 32-bit
  o parisc: make __kernel_clock_t long
  o parisc: fix HPUX compile problem
  o parisc: assembly fixes and comments
  o Use optimised byteswap again
  o parisc: Merge head64.S and head.S
  o parisc: small debug cleanup in power.c
  o parisc: add HP copyright to perf counters
  o parisc: Fix 64-bit linking
  o parisc: Kconfig debugging options
  o parisc: make install
  o parisc: Fix N-class SMP
  o parisc: update a500_defconfig
  o parisc: Initialise restart_block
  o parisc: Add user_space macro
  o parisc: Light-weight syscall support
  o parisc: add copyright to sba_iommu
  o parisc: better stack traces
  o parisc: fix ptrace
  o parisc: signal race fixes
  o parisc: support get/put_unaligned
  o parisc: _raw_write_trylock
  o parisc: remove K_STW_PIC and K_LDW_PIC
  o parisc: Remove isr verification
  o parisc: use fixups for exception support
  o parisc: export global fixup routines
  o parisc: Add memory clobber to userspace syscall wrapper
  o parisc: Fix LBA/SBA bugs
  o parisc: fix CONFIG_DISCONTIGMEM support
  o parisc: new memcpy routines
  o parisc: register cpus with sysfs
  o parisc: dump the stack on a BUG()
  o parisc: Stop exporting the old memcpy symbols
  o parisc: remove lcopy_*_user
  o parisc: fix PTRACE_GETEVENTMSG
  o parisc: new syscalls
  o parisc: fix security hole
  o parisc: superio cleanup
  o parisc: checksum improvements
  o compat syscalls naming standardisation

Matthias Burghardt:
  o [ARM PATCH] 2183/1: GPIO84:81 for PXA26x defines
  o [ARM PATCH] 2185/1: Bit definitions for PXA PWER
  o [ARM PATCH] 2191/1: bugfix for PXA SSP

Matthijs Melchior:
  o [libata ahci] fix rather serious (and/or embarassing) bugs

Maximilian Attems:
  o USB: tiglusb: replace schedule_timeout() with
    msleep_interruptible()
  o USB: dabusb: replace schedule_timeout() with msleep_interruptible()
  o scsi/53c700: replace    schedule_timeout() with
  o scsi/scsi_lib: replace  schedule_timeout() with
  o [SERIAL] replace schedule_timeout() with
    msleep/msleep_interruptible()
  o VFS maintainer email address updates

Meelis Roos:
  o ata.h undefined types in USB

Michael Hunold:
  o DVB: rework debugging in av7110
  o DVB: misc. updates to the dvb-core
  o DVB: add new driver
  o DVB: revamp dibusb driver
  o DVB: misc. updates to frontend drivers
  o v4l: mxb driver and i2c helper cleanup
  o v4l: keep tvaudio driver away from saa7146

Michal Rokos:
  o [ALSA]  Exclude uneeded code when ! CONFIG_PROC_FS

Mika Kukkonen:
  o sparse: fix warnings in net/irda/*

Mikael Starvik:
  o CRIS: configuration and Build
  o CRIS: update simple drivers
  o CRIS: ethernet driver
  o CRIS: IDE driver
  o CRIS: Add USB host driver
  o CRIS: Core kernel updates
  o CRIS: Console setup handling
  o CRIS: Move drivers
  o CRIS: Update Makefiles
  o CRIS: Update MAINTAINERS

Mike Waychison:
  o [TG3]: Fix fiber hw autoneg bounces

Miles Bader:
  o v850: Work around include-definition-loop problem in
    <asm-v850/posix_types.h>
  o v850: Add definitions for memcpy_fromio and memcpy_toio
  o v850: Add __param linker section
  o v850: Fix misnamed variable in ptrace.c
  o v850: signal handling race fix

Milton D. Miller II:
  o net/Kconfig: undo duplicate patch application
  o hamradio/hdlcdrv: undo duplicat patch application
  o fix sysfs backing store error path confusion

Mingming Cao:
  o ext2: discard preallocation in last iput
  o ext3 block reservation patch set -- ext3 preallocation cleanup
  o ext3 block reservations

Måns Rullgård:
  o SysRq-n changes RT tasks to normal

Naoki Shibata:
  o USB: usbnet patch (new ax8817x device)

Neil Brown:
  o md: remove md_flush_all
  o md: make retry_list non-global in raid1 and multipath
  o md: rationalise issue_flush function in md personalities
  o md: rationalise unplug functions in md
  o md: make sure md always uses rdev_dec_pending properly
  o md: fix two little bugs in raid10
  o md: modify locking when accessing subdevices in md
  o md: make read retry use a new bio in raid1 and raid10
  o md: discard calc_sb_csum_common in favour of csum_fold
  o md: don't hold lock on md devices while waiting for them to finish
    resync
  o md: fix typos in md and raid10
  o md: fixes to make version-1 superblocks work in md driver
  o md: fix problem with md/linear for devices larger than 2 terabytes
  o md: fix raid6 problem
  o md: delete unplug timer before shutting down md array
  o md: "Faulty" personality

Neil Horman:
  o ns83820: add vlan tag hardware acceleration support

Nick Piggin:
  o mm: help zone padding
  o vm: unreclaimable pages debugginf
  o vmscan: pages_scanned fix

Nickolai Zeldovich:
  o ext3 umount hang

Nicolas Pitre:
  o [ARM PATCH] 2080/1: clean up io-{read|write}sl
  o fix smc91x compilation error
  o [ARM PATCH] 2175/1: add reference for problem worked around by
    patch #1824/1
  o [ARM PATCH] 2187/1: fix lacking capability in pxa_gpio_mode()
  o [ARM PATCH] 2203/1: trivial asm optimization for csum code
  o [ARM PATCH] 2192/1: small optimization to {read|write}sl routines
  o [ARM PATCH] 2154/2: XIP kernel for ARM
  o [ARM PATCH] 2160/1: allow modules to work with XIP kernel
  o [ARM PATCH] 2230/1: fix generic_fls declaration mismatch

Nigel Croxon:
  o [IA64-HP] Fix for bits_wanted in sba_iommu.c

Nigel Cunningham:
  o Fix dm_io.c oops in low memory conditions

Nishanth Aravamudan:
  o net/de2104x: replace schedule_timeout() with msleep()
  o [PNPBIOS] use msleep_interruptible()
  o scsi/ahci: replace schedule_timeout() with msleep()/ssleep()
  o pci/quirks: replace schedule_timeout() with msleep()

Olaf Hering:
  o remove old version check from mac8390
  o remove double newline from sysrq action_msg
  o rmmod ohci1394 hangs
  o x86_64: Fix make all
  o fix initcall_debug on ppc64/ia64

Olaf Kirch:
  o statfs compat functions can return EOVERFLOW on NFS

Oleg Drokin:
  o "Bad" naming of structures and functions in ext3 reservation code

Oliver Neukum:
  o kaweth: full conversion to usb_unlink_urb
  o kaweth: no need for packed

Olof Johansson:
  o ppc64: setup cpu_sibling_map on iSeries
  o ppc64: VIO iommu table property parsing wrong

Ondrej Zary:
  o make cdu31a work on at least one system

Pablo Neira:
  o [NETFILTER]: Clean up ip_conntrack stats
  o [NETFILTER]: fix stats in __ip_conntrack_confirm

Paolo 'Blaisorblade' Giarrusso:
  o uml: Kconfig and defconfig updates
  o uml: resync LDS script for SMP changes
  o uml: unused label
  o uml: add conf INITRAMFS_SOURCE
  o uml: fix mainline lazyness about TTY layer patch
  o Kbuild: avoid backup localversion files
  o ptrace POKEUSR: add comment about the DR7 check
  o uml: fix ptrace() hang on 2.6.9 host due to host changes
  o uml - some comments about forcing /bin/bash
  o uml: add startup check for mmap(...PROT_EXEC...) from /tmp
  o uml: fix syscall auditing
  o uml: fix symbol conflict in linking
  o uml: cleanup header names
  o uml: remove useless inclusion
  o uml: no duplicate current_thread definition
  o uml: mconsole_proc simplify and partial fix
  o uml: catch EINTR in generic_console_write
  o uml: remove SIGPROF from change_signals
  o uml: use kallsyms when dumping stack
  o uml: revert compile-only changes for other ones
  o uml: fix sysemu test at startup
  o uml: more careful test startup
  o uml: clear errno in CATCH_EINTR
  o uml: re-add linux Makefile target - fixes to the old version
  o uml: add missing newline in help string
  o uml: use sys_getpid bypassing glibc (fixes UML on Gentoo)

Pat Gefre:
  o [IA64-SGI] only allocate irq if the device can interrupt

Patrick Caulfield:
  o [DECNET]: Connect hang bugfix
  o [DECNET]: Route RCU fix
  o [DECNET]: Fix return codes

Patrick McHardy:
  o [NETFILTER]: Introduce tabs to ip6t_ah.c
  o [NETFILTER]: ip6t_esp.c whitespace cleanup
  o [NETFILTER]: Convert ip6t_physdev match function to new argument
    order
  o [NETFILTER]: Select source address for gateway in MASQUERADE
  o [PKT_SCHED]: Fix rcu_assign_pointer fallout, use it in the right
    place
  o [PKT_SCHED]: pedit: Convert jiffies values to USER_HZ when dumping
  o [PKT_SCHED]: mirred: Convert jiffies values to USER_HZ when dumping
  o [PKT_SCHED]: gact: Convert jiffies values to USER_HZ when dumping
  o [PKT_SCHED]: ipt: Convert jiffies values to USER_HZ when dumping
  o [NETFILTER]: Don't use skb_header_pointer in amanda conntrack
    helper
  o [PKT_SCHED]: Fix device leaks in mirred action
  o [PKT_SCHED]: Mark some functions static in tc actions/act_api
  o [PKT_SCHED]: Fix scheduler/classifier module unload race
  o [PKT_SCHED]: Unline inner qdiscs immediately in qdisc_destroy()
  o [PKT_SCHED]: Fix overflow on 64bit in times reported to userspace

Paul E. McKenney:
  o scheduler: remove redundant #ifdef
  o RCU: rcu_assign_pointer() removal of memory barriers
  o RCU: use rcu_assign_pointer()
  o RCU: eliminating explicit memory barriers from SysV IPC

Paul Fulghum:
  o serial send_break duration fix

Paul Mackerras:
  o ppc64: provide notifier list for EEH slot isolations
  o ppc64: crash during firmware flash update
  o ppc64: create iommu_free_table()
  o ppc64: __ioremap_explicit() criterion change
  o ppc64: cpu hotplug notifier for numa
  o PPC/PPC64: Fix FP state corruption on UP
  o Fix deadlocks on dpm_sem
  o PPC64 mmu_context_init needs to run earlier
  o ppc64: iommu fixes, round 3
  o ppc64: iSeries_pci.c use for_each_pci_dev()
  o ppc64: pmac_pci.c replace pci_find_device with pci_get_device
  o ppc64: pSeries_pci.c use for_each_pci_dev()
  o ppc64: pSeries_iommu.c use for_each_pci_dev
  o ppc64: u3_iommu.c use for_each_pci_dev()
  o Check character flags in ppp_async ldisc
  o Update ppc list addresses in MAINTAINERS

Paul Mundt:
  o sh: do_signal() update for generic changes
  o sh: compile fixes
  o sh: syscall updates

Pavel Fedin:
  o VIA8231 support for parallel port driver

Pavel Machek:
  o swsuspend for ne2k-pci cards
  o power/disk.c: small fixups
  o Kill useless pm_access from vt.c
  o Add typechecking to suspend types and powerdown types

Pawel Sikora:
  o signal.c: gcc-3.4 fix
  o /proc/kcore - enable/disable
  o x86: optimize stack pointer access (reduce register usage)

Pekka Enberg:
  o radeonfb: screeninfo initialization cleanup
  o fbcon: Remove spurious casts
  o fbcon: Replace logo_shown magic numbers with constants
  o radeonfb: more initializer fixes

Pete Zaitcev:
  o USB: usblp BKL removal
  o USB: Patch for ub

Peter Chubb:
  o standalone sys_ni.c for not-implemented syscalls
  o [ARM PATCH] 2205/1: Fix compilation for IXDP425: typo in
    mach-ixp4xx/common.c

Peter Osterlund:
  o Fix incorrect kunmap_atomic in pktcdvd
  o Fix incorrect Mt Rainier detection
  o fix bttv oops in btcx_riscmem_free

Peter Pregler:
  o cpia.c rmmod deadlock fix

Petr Konecny:
  o netpoll with xircom_cb

Petr Vandrovec:
  o Weak symbols in modules and versioned symbols
  o Add argument-less ppdev ioctls to compat_ioctl.h

Phil Dibowitz:
  o USB Storage: Add unusual_devs entry for iPod

Philippe Bertin:
  o USB: Superfluous statement in usb.c

Prasanna S. Panchamukhi:
  o kprobes: Minor i386 changes required for porting kprobes to x86_64
  o kprobes: kprobes ported to x86_64
  o kprobes: Minor changes for sparc64

Pu Long:
  o x86_64: Use compat readdir and aio functions

Rajesh Venkatasubramanian:
  o prio_tree: fix prio_tree_expand corner case
  o prio_tree: add Documentation/prio_tree.txt

Ralf Bächle:
  o Stop queue on close in hdlcdrv
  o [AX25]: Fix cb lookup

Randolph Chung:
  o Fix cc-option call for xcompiles

Randy Dunlap:
  o pcnet32: use unsigned 1-bit fields
  o skfp: remove assignment expression in conditional (sparse)(v2)
  o kconfig: OVERRIDE: save kernel version in .config file
  o qla1280: driver_setup not __initdata
  o checkstack: add x86_64 arch. support
  o __init dependencies: ignore __param
  o via-rhine: references __init code during resume
  o convert MODULE_PARM() to module_param() family
  o more MODULE_PARM conversions
  o scsi/mesh: module_param corrections

Richard Henderson:
  o Add __ioremap

Robert III:
  o USB: PL2303 - PharosGPS patch

Robert Love:
  o make dnotify a configure-time option
  o kobject_uevent: fix init ordering
  o kobject_uevent: add MAINTAINER entry

Roland McGrath:
  o Invalid BUG_ONs in signal.c
  o Fix ptrace problem
  o fix core-dump return code
  o acct: report single record for multithreaded process
  o session leader tty disassociation fix
  o Wake up signalled tasks when exiting ptrace

Romain Liévin:
  o USB: tiglusb.c: add direct USB support on some new TI handhelds

Roman Zippel:
  o hfs: update key after rename
  o hfs: relax dirty check
  o hfs: manage correct block count
  o hfs: read correct dir time
  o hfs: write back resource info directly
  o hfs: export type/creator via xattr

Russell King:
  o [PCMCIA] Fix PCMCIA behaviour on resume with different card
  o [ARM] Fix missing parens for __FD_* operations
  o arm: Fix ARM kernel build with permitted binutils versions
  o [ARM] Group linux/* includes together in mcbsp.c
  o [MMC] Fix incorrectly balanced spin_lock_irq()
  o [MMC] Add support for passing scatterlists to MMC host drivers
  o [MMC] Remove block knowledge from MMCI driver
  o [MMC] Switch PXAMCI to use supplied scatterlist
  o [MMC] Deprecate "req" member of mmc_data structure
  o [ARM] Use cpu_vm_mask to indicate whether the MM is mapped
  o [ARM] Use cpu_vm_mask to determine whether to flush TLB/caches
  o [ARM] Add disable_irq_nosync() and CPU number headings
  o [ARM] Remove extraneous spaces
  o [ARM] include/asm-arm/arch-integrator/time.h is unused, remove it
  o [ARM] Fix wrong variable name in icside.c
  o [ARM] etherh: add ethtool support
  o [ARM] etherh: report errors when trying to parse MAC address
  o 8390.c: Use mdelay(10) rather than udelay(10*1000)
  o [ARM] etherh: add __iomem annotations
  o [ARM] Add initial __iomem annotations to ARM io.h headers
  o [ARM] s3c2410: DMA uses __iomem pointers
  o [ARM] Add __iomem annotations to ARM amba drivers
  o [SERIAL] Clean up serial_core.c write functions
  o [SERIAL] 8250: Fix resource handling
  o [SERIAL] 8250: move basic initialisation of 8250 ports
  o [SERIAL] Re-order 8250 serial driver initialisation/finalisation
  o [SERIAL] 8250: Add platform device for ISA 8250-compatible devices
  o [SERIAL] 8250: add probe and remove device driver methods
  o [SERIAL] 8250: prevent ports with zero clocks being registered
  o [SERIAL] Undo "get_legacy_serial_ports" patch for PPC
  o [SERIAL] 8250_acorn: Convert to use serial8250_{un,}register_port
  o [ARM] No need for rpc_map_io to be public
  o [ARM] riscpc: add iomd, keyboard and acornfb platform devices
  o [SERIAL] 8250: Warn when ports with zero base_baud are registered
  o [SERIAL] serial_cs: Convert to use serial8250_{un,}register_port
  o [SERIAL] 8250_pnp: Convert to use serial8250_{un,}register_port
  o [SERIAL] Don't use UPF_AUTOPROBE, fix two build problems
  o [SERIAL] 8250_acpi: Convert to use serial8250_{un,}register_port
  o [SERIAL] Don't detect console availability using port->ops
  o [SERIAL] Fix deadlock on removal of 8250 module
  o [ARM] Remove duplicate includes from ARM files
  o [SERIAL] 8250: Return interrupt handler status
  o [SERIAL] 8250_gsc: Convert to use serial8250_{un,}register_port
  o [ARM] mtd: update mapping drivers
  o [SERIAL] Add support for Dell PCI Remote Access Card III
  o [SERIAL] Add ALPHA_KLUDGE_MCR from include/linux/serialP.h
  o [SERIAL] 8250: Remove two warnings
  o [SERIAL] Fix PPC64 for recent serial changes
  o saa7111.c: fix VIDEO_MODE_SECAM
  o [ARM] sa11x0: use ID of -1 for single devices
  o [ARM] Optimise cache_is_xxx() macros
  o [ARM] Fix double compare with zero instructions
  o [ARM] Versatile: Remove CONFIG_MMC ifdef blocks
  o [ARM] Eliminate include/asm-arm/arch-*/serial.h
  o [ARM] Update mach-types
  o [ARM] rtctime tweaks
  o [ARM] Add static partitioning information to flash_platform_data
  o [ARM] Add SA1100 generic flash infrastructure
  o [ARM] Add Assabet flash device partitioning and location data
  o [ARM] Fix IMX build error post sys_timer merge
  o [ARM] Remove unused 'mclk' element from MMC platform structure
  o [ARM] Add platform_device-based partition and map information
  o [ARM] Remove broken SA1100 machine support
  o [MTD] sa1100: add driver model support and remove static flash
    probing
  o [MTD] sa1100: split out sub-device init/destruction
  o [MTD] sa1100: consolidate mtd and partition destructors
  o [MTD] sa1100: add container structure for one logical flash device
  o [MTD] sa1100: more driver model integration and consolidation
  o [MTD] sa1100: remove static partitioning information
  o [MTD] sa1100: Use set_vpp functions provided by machine support
    code
  o [MTD] sa1100: Obtain flash device location from platform device
  o [SERIAL] Add sparse __iomem annotations
  o [SERIAL] serial driver fixes
  o [ARM] Fix Acorn SCSI drivers to use
    ecard_{request,release}_resources
  o [ARM] ecard: dumpirq state on unrecognised interrupts as well
  o [ARM] icside: use MMIO for board specific registers
  o [ARM] icside: use MMIO for IDE registers
  o [ARM] rapide: use MMIO for IDE registers

Rusty Russell:
  o [NETFILTER]: Change MASQUERADE to Use Device Address Directly
  o MODULE_PARM must die: make it warn first
  o Remove MODULE_PARM from i386 defconfig
  o Remove MODULE_PARM from arch/i386
  o Fix for MODULE_PARM obsolete
  o Builtin Module Parameters in sysfs too
  o boot parameters: quoting of environment variables revisited
  o Eliminate init_module and cleanup_module from Documentation
  o [NETFILTER]: Avoid warning on CONNTRACK_STAT_INC in
    destroy_conntrack()
  o Don't ignore try_stop_module return
  o [NETFILTER]: Fix find_appropriate_src() to actually work

Sam Ravnborg:
  o kbuild: Create Makefile in output dir for *config targets
  o kbuild: Add cc-option-align
  o kbuild/usr: initramfs list fixed and simplified
  o m32r: misc kbuild cleanups
  o kbuild: allow architectures to specify defconfig file with
    KBUILD_DEFCONFIG
  o Do not recompile if localversion changes
  o kbuild: Prefer Kbuild as name of the kbuild files
  o kconfig: drop usage of shared libraries
  o ppc: fix building arch/ppc/boot/lib/ with make O=
  o kconfig: fix xconfig and gconfig

Sascha Hauer:
  o [ARM] Update h720x for timer changes
  o [ARM PATCH] 1956/2: Re: Motorola i.MX serial driver

Scott Feldman:
  o janitor: net/sis900: pci_find_device to pci_get_device
  o janitor: net/tulip: pci_find_device to pci_dev_present
  o e100: update maintainer

Sebastian Witt:
  o [CPUFREQ] NVidia nForce2 FSB cpufreq driver

Sergey S. Kostyliov:
  o Add megaraid PCI IDs

Simon Derr:
  o Fix race in sysfs_read_file() and sysfs_write_file()
  o Possible race in sysfs_read_file() and sysfs_write_file()

Sridhar Samudrala:
  o [SCTP] Change sctp_assoc_t to a sized type(s32)
  o [SCTP] Adaption layer indication support
  o [SCTP] Update cwnd/ssthresh as per the sctpimpguide modifications
  o [SCTP] When an address is deleted, update any transports that are
    caching it as a source adddress
  o [SCTP] Fix HEARTBEAT_ACKs being sent to wrong dest. ip address in a
    multi-homing scenario after a failback.

Stelian Pop:
  o sonypi: module related fixes
  o sonypi: replace homebrew queue with kfifo
  o sonypi: power management related fixes
  o sonypi: rework input support
  o sonypi: make CONFIG_SONYPI depend on CONFIG_INPUT
  o sonypi: don't suppose the bluetooth subsystem is initialy off
  o sonypi: whitespace and coding style fixes
  o sonypi: bump up the version number
  o meye: module related fixes
  o meye: replace homebrew queue with kfifo
  o meye: picture depth is in bits not in bytes
  o meye: do lock properly when waiting for buffers
  o meye: implement non blocking access using poll()
  o meye: cleanup init/exit paths
  o meye: the driver is no longer experimental and depends on PCI
  o meye: module parameters documentation fixes
  o meye: add v4l2 support
  o meye: whitespace and coding style cleanups
  o meye: bump up the version number
  o meye: cache the camera settings in the driver
  o sonypi: documentation fixes
  o videodev2.h patchlet

Stephen C. Tweedie:
  o ext3: online resizing

Stephen D. Smalley:
  o lsm: fix send_sigurg mediation
  o Add DAC check for setxattr(security.selinux)

Stephen Hemminger:
  o (1/4) acenic - use netdev_priv
  o (2/4) acenic - eliminate MAX_SKB_FRAGS #if
  o (3/4) acenic - __iomem warnings cleanup
  o (4/4) acenic - don't spin forever in hard_start_xmit
  o ns83820: use module_param
  o eql: use netdev_priv
  o dummy: use netdev_priv
  o tg3: use module_param
  o tg3: use netdev_priv
  o tg3: make driver only data static
  o slip: use module_param
  o slip: use netdev_priv
  o kaweth: use alloc_etherdev to allocate device private
  o usbnet: use alloc_etherdev to allocate private data
  o USB kaweth: use alloc_etherdev to allocate device private data -
    fix
  o cdev: protect against buggy drivers
  o avoid problems with kobject_set_name and name with %
  o [PKT_SCHED]: netem: use timer to handle packets not rescheduling
  o [NETFILTER]: Fix build without INET
  o loop: convert to module_param
  o rd: convert to module_param and add module alias

Stephen Rothwell:
  o ppc64: iSeries console: cleanup after tty_write user copies 
    removal
  o ppc64 iSeries pci cleanups
  o ppc64 iSeries: fix for generic irq changes
  o ppc64: iSeries iommu cleanups
  o ppc64: iSeries combine some MF code
  o ppc64: iSeries remove trailing white space
  o ppc64: iSeries remove some Studly Caps
  o ppc64: iSeries more MF cleanup
  o ppc64: iSeries remove more Studly Caps from MF code
  o ppc64: iSeries last of the cleanups fo the MF code

Stéphane Eranian:
  o [IA64] misc small patches for perfmon

Suparna Bhattacharya:
  o Fix O_SYNC speedup for generic_file_write_nolock

Suresh B. Siddha:
  o intel irqbalance quirk cleanup
  o x86-64: fix sibling map again

Suresh Krishnan:
  o [NET]: Address family not supported for sendmsg()

Sylvain Meyer:
  o fbdev: intelfb code cleanup

Takayoshi Kochi:
  o [IA64] cleanup CPU drift print

Tejun Heo:
  o kbuild: use two double-quotes for localversion
  o kbuild: explicit enable framepointer
  o driver-model: comment fix in bus.c
  o driver-model: bus_recan_devices() locking fix
  o driver-model: sysfs_release() dangling pointer reference fix
  o driver-model: kobject_add() error path reference counting fix
  o driver-model: device_add() error path reference counting fix

Tero Roponen:
  o Don't initialize /dev/pg0 to be always busy

Theodore Y. Ts'o:
  o Licencing of drivers/char/rocket.c

Thomas Gleixner:
  o Lock initializer unifying (Core)
  o Lock initializer unifying (Network drivers)
  o Lock initializer unifying Batch 2 (USB)
  o Lock initializer unifying Batch 2 (PCI)
  o [BLUETOOTH]: Lock initializer unifying
  o [NET]: Lock initializer unifying

Thomas Graf:
  o [PKT_SCHED]: u32: Remove unused hgenerator field in tc_u_hnode
  o [NETFILTER]: Fix warning in CONNMARK
  o [PKT_SCHED]: Rename TCQ_F_INGRES to TCQ_F_INGRESS
  o [PKT_SCHED]: pkt_cls.h needs pkt_sched.h
  o [PKT_SCHED]: Add net/sch_generic.h with generic sched definitions
  o [PKT_SCHED]: Remove obsolete definitions in pkt_cls.h
  o [PKT_SCHED]: Add net/act_api.h with public action/policer bits
  o [PKT_SCHED]: Remove obsolete definitions in pkt_sched.h
  o [PKT_SCHED]: Transform pkt_sched.h prototypes to be extern
  o [PKT_SCHED]: Move tc_classify from pkt_cls.h to sch_api.c
  o [PKT_SCHED]: psched_*_per_* can be static
  o [PKT_SCHED]: Cleanup cls_set_class
  o [PKT_SCHED]: Inline psched_tod_diff
  o [PKT_SCHED]: Use new header architecture
  o [PKT_SCHED]: Remove bogus lock and make cls_set_class return
    unsigned long
  o [PKT_SCHED]: Add generic classifier routines
  o [PKT_SCHED]: cls_fw: Cleanup fw_classify
  o [PKT_SCHED]: cls_fw: Use generic routines to configure
    action/policer
  o [PKT_SCHED]: cls_fw: Use generic routines to dump action/policer
  o [PKT_SCHED]: cls_fw: Whitespace/ifdef fixes
  o [PKT_SCHED]: cls_fw: Break is not enough to stop walking
  o [PKT_SCHED]: cls_fw: CONFIG_NET_CLS_IND is not dependant on
    CONFIG_NET_CLS_ACT
  o [PKT_SCHED]: cls_route: Use generic routines for class binding and
    police config/dump
  o [PKT_SCHED]: cls_rsvp*: Use generic routines for class binding and
    police config/dump
  o [PKT_SCHED]: cls_tcindex: Use generic routines for class binding
    and police config/dump
  o [PKT_SCHED]: cls_u32: Use generic routines for class binding and
    police config/dump
  o [PKT_SCHED]: tcf_action: copy generic stats via TCA_ACT_STATS
  o [PKT_SCHED]: gact: use gnet_stats for action stats
  o [PKT_SCHED]: ipt: use gnet_stats for action stats
  o [PKT_SCHED]: mirred: use gnet_stats for action stats
  o [PKT_SCHED]: pedit: use gnet_stats for action stats
  o [PKT_SCHED]: police: use gnet_stats for action policer stats
  o [PKT_SCHED]: police: use gnet_stats for old policer stats
  o [PKT_SCHED]: cls_*: use tcf_police_dump_stats to dump via new
    gnet_stats API
  o [PKT_SCHED]: Initialize lists of builtin qdiscs
  o [PKT_SCHED]: Builtin qdiscs should avoid all qdisc_destroy()
    processing
  o [PKT_SCHED]: Remove old estimator code, no longer used

Tobias Lorenz:
  o [libata sata_promise] s/sata/ata/

Tom Fredrik Blenning Klaussen:
  o firmware spelling errors

Tom L. Nguyen:
  o PCI: pci-mmconfig fix

Tom Rini:
  o kbuild: fix 'htmldocs' and friends with O=
  o ppc32: Fix building for Motorola Sandpoint with O=
  o kbuild: warning fixes on Solaris 9
  o ppc32: Move request_irq() calls to arch_initcall() functions
  o ppc32: Fix warning in gen550 code
  o ppc32: Remove sandpoint_early_serial_map()
  o Fix ppc32 compile
  o kconfig: Fix menuconfig on Solaris
  o kbuild: additional warning fixes on Solaris 9
  o ppc32: fix early request_irq
  o ppc32: CPM2 bug
  o ppc32: Add support for Sandpoint X2
  o ppc32: Fixup <asm/time.h> includes
  o Fix building of samba userland
  o Add __KERNEL__ to <linux/crc-ccitt.h>
  o Fix CPM2 uart driver device number brain damage

Tommy Christensen:
  o [NET]: Move local_bh_enable back in dev_queue_xmit

Tony Lindgren:
  o [ARM PATCH] 2162/1: OMAP update 1/8: Improved cpu detection and
    serial init
  o [ARM PATCH] 2164/1: OMAP update 3/8: Include files
  o [ARM PATCH] 2165/1: OMAP update 4/X: Replace 1610 and 5912 header
    files with 16xx
  o [ARM PATCH] 2166/1: OMAP update 5/8: Change OMAP to use generic
    clock framework
  o [ARM PATCH] 2167/1: OMAP update 6/8: Add graphics acceleration
    support to DMA
  o [ARM PATCH] 2169/1: OMAP update 8/8: McBSP update
  o [ARM PATCH] 2170/1: OMAP update 2/8, take 2: Arch files
  o [ARM PATCH] 2173/1: OMAP update 7/8, take 3: Add PM support
  o [ARM PATCH] 2194/1: Change OMAP serial port init to use
    autodetection
  o [ARM PATCH] 2195/1: Updates to OMAP clock framework

Tony Luck:
  o [IA64] Need <asm/meminit.h> for GRANULEROUNDDOWN
  o [IA64] fix(?) unwind data for ia64_monarch_init_handler
  o [IA64] tiger_defconfig update for 2.6.10-rc1
  o [IA64] promote configs/generic_defconfig to defconfig
  o [IA64] implement pcibios_resource_to_bus and
    pcibios_bus_to_resource
  o [IA64-SGI] Do not disable interrupts in
    ia64_sn_plat_specific_err_print

Toshihiro Iwamoto:
  o direct IO write memory leak fix

Utz Bacher:
  o s390: qdio changes

Venkatesh Pallipadi:
  o HPET reenabling after suspend-resume

Ville Syrjala:
  o fbdev: Fix atyfb cursor problems

Wen Xiong:
  o icom makefile fix
  o "PORT_ICOM" defination for icom adapter

Wensong Zhang:
  o [IPVS]: Update version to 1.2.1

Werner Almesberger:
  o update CREDITS entry of Werner Almesberger
  o make buffer head argument of buffer_##name "const"

William Lee Irwin III:
  o remove itimer_ticks and itimer_next

Yanmin Zhang:
  o hugetlb_get_unmapped_area fix
  o x86_64: Fix 32bit aio setup

Yasuyuki Kozakai:
  o [NETFILTER]: prearation of removing skb_linearize()
  o [NETFILTER]: Enable ip6t_LOG.c to work without skb_linearize()
  o [NETFILTER]: Enable ip6t_ah.c to work without skb_linearize()
  o [NETFILTER]: Enable ip6t_esp.c to work without skb_linearize()
  o [NETFILTER]: Enable ip6t_rt.c to work without skb_linearize()
  o [NETFILTER]: Enable ip6t_multiport.c to work without
    skb_linearize()
  o [NETFILTER]: Enable ip6t_frag.c to work without skb_linearize()
  o [NETFILTER]: Fix multiple bugs in dst match
  o [NETFILTER]: Fix multiple bugs in hbh match
  o [NETFILTER]: Introduce skb_header_pointer() to dst match
  o [NETFILTER]: Introduce skb_header_pointer() to hbh match

Yi Zhu:
  o swsusp: print error message when swapping is disabled

Yoshinori Sato:
  o H8/300 inline cleanup
  o H8/300 build error fix
  o H8/300 vmlinux.lds update
  o fix "extern inline"

Zachary Amsden:
  o faster signal handling on x86

