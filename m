Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUJVWTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUJVWTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUJVWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:19:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:39118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268236AbUJVWFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:05:24 -0400
Date: Fri, 22 Oct 2004 15:05:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: The naming wars continue...
Message-ID: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 Linux-2.6.10-rc1 is out there for your pleasure.

I thought long and hard about the name of this release (*), since one of
the main complaints about 2.6.9 was the apparently release naming scheme. 

Should it be "-rc1"? Or "-pre1" to show it's not really considered release
quality yet? Or should I make like a rocket scientist, and count _down_
instead of up? Should I make names based on which day of the week the
release happened? Questions, questions..

And the fact is, I can't see the point. I'll just call it all "-rcX",
because I (very obviously) have no clue where the cut-over-point from
"pre" to "rc" is, or (even more painfully obviously) where it will become
the final next release.

So to not overtax my poor brain, I'll just call them all -rc releases, and
hope that developers see them as a sign that there's been stuff merged,
and we should start calming down and seeing to the merged patches being
stable soon enough..

So without any further ado, here's 2.6.10-rc1 in testing. A fair number of
patches that were waiting for 2.6.9 to be out are in here, ranging all
over the map: merges from -mm, network (and net driver) updates, SATA
stuff, bluetooth, SCSI, device models, janitorial, you name it.

Oh, and the _real_ name did actually change. It's not Zonked Quokka any 
more, that's so yesterday. Today we're Woozy Numbat! Get your order in!

		Linus

(*) In other words, I had a beer and watched TV. Mmm... Donuts.

----

Summary of changes from v2.6.9 to v2.6.10-rc1
============================================

Aaron Grothe:
  o [CRYPTO]: Put khazad back into tcrypt table

Adam Radford:
  o 3ware 5/6/7/8000 driver v1.26.02.000
  o 3ware 5/6/7/8000 driver update

Adrian Bunk:
  o qla2xxx gcc-3.5 fixes
  o #include <asm/bitops.h> -> #include <linux/bitops.h>
  o fix block/cciss.c with PROC_FS=n
  o make CONFIG_PM_DEBUG depend on CONFIG_PM
  o Another ISA PnP modem (USR0009)

Al Borchers:
  o USB: corrected digi_acceleport 2.6.9-rc1 fix for hang on disconnect
  o USB: circular buffer for pl2303
  o USB: close waits for drain in pl2303

Alan Stern:
  o USB: Make usbcore use usb_kill_urb()
  o USB: Suspend/resume/wakeup support for UHCI root hub ports
  o USB: Remove inappropriate unusual_devs.h entry
  o USB: Nag message for usb_kill_urb
  o USB: Centralize logical disconnects in the hub driver
  o USB: Internal port numbers start at 0
  o USB: Add OTG support to g_file_storage
  o USB: New submission procedure for unusual_devs.h
  o USB: Unusual_devs entry for Panasonic cameras
  o Add BLIST_INQUIRY_36 to all USB blacklist entries
  o USB: Improve UHCI suspend/resume
  o USB: Fix off-by-one error in the hub driver
  o USB: Updated USB device locking
  o USB: Add locking support for USB device resets
  o USB: Descriptor listing bugfix for g_file_storage
  o USB: Allow device resets for hubs
  o USB: Support system suspend in File-Storage Gadget
  o USB: Suspend update for dummy_hcd
  o USB: Activate new hubs and resumed hubs the same way
  o USB: Use list_for_each_entry etc. in UHCI driver
  o USB: Fix data toggle handling in the UHCI driver
  o Let LLD specify INQUIRY length
  o USB Storage: new unusual_devs entry

Albert Cahalan:
  o distinct tgid/tid CPU usage

Alex Kanavin:
  o USB: export inteface and configuration strings to sysfs
  o USB: USB CDC OBEX driver

Alexander Viro:
  o [netdrvr eth1394] use netdev_priv
  o [netdrvr usb] use netdev_priv
  o [netdrvr] netdev_priv for ewrk3, xircom_tulip_cb, wavelan_cs
  o [netdrvr] netdev_priv for sundance, typhoon, yellowfin
  o [netdrvr] use netdev_priv in dl2k, hamachi
  o [netdrvr starfire] fix unregister_netdev call site
  o [netdrvr starfire] use netdev_priv
  o (1/27) eth1394 ethtool conversion
  o (2/27) cris ethtool conversion
  o (3/27) ixgb ethtool conversion
  o (4/27) 3c509 ethtool conversion
  o (5/27) smc91c92_cs ethtool conversion
  o (6/27) tulip ethtool conversion
  o (7/27) xircom ethtool conversion
  o (8/27) wavelan ethtool conversion
  o (9/27) wl3501_cs ethtool conversion
  o (10/27) yellowfin ethtool conversion
  o (11/27) typhoon ethtool conversion
  o (12/27) sundance ethtool conversion
  o (13/27) starfire ethtool conversion
  o (14/27) ns83820 ethtool conversion
  o (15/27) natsemi ethtool conversion
  o (16/27) veth ethtool conversion
  o (17/27) hamachi ethtool conversion
  o (18/27) forcedeth ethtool conversion
  o (19/27) ewrk3 ethtool conversion
  o (20/27) eepro100 ethtool conversion
  o (21/27) dl2k ethtool conversion
  o (22/27) amd8111e ethtool conversion
  o (23/27) gadget ethtool conversion
  o (24/27) rtl8150 ethtool conversion
  o (25/27) pegasus ethtool conversion
  o (26/27) kaweth ethtool conversion
  o (27/27) catc ethtool conversion
  o amd8111e iomem annotations
  o typhoon.c missing include
  o 64bit fix in cycx_x25.c
  o cyclom iomem annotations
  o hd6457x iomem annotations
  o dscc4 iomem annotations
  o bunch of trivial iomem annotations in drivers/net
  o rrunner iomem annotations
  o via-velocity iomem annotations
  o tulip iomem annotations, switch to io{read,write}
  o winbond840 iomem annotations, switch to io{read,write}
  o forcedeth iomem annotations
  o yellowfin iomem annotations, switch to io{read,write}
  o hp100 iomem annotations
  o lanstreamer fix
  o moxa iomem annotations
  o sparc32 kconfig fixes
  o if_ppp.h __user annotation
  o sx.c iomem annotations and fixes
  o skystar2 iomem annotations
  o kyro iomem annotations
  o teles{0,pci} iomem annotations
  o isurf iomem annotations
  o ipr iomem annotations
  o ips iomem annotations
  o megaraid iomem annotations
  o nsp32 iomem annotations
  o aac7xxx iomem annotations
  o ioremap cleanups in aic7xxx
  o qla1820 iomem annotations
  o missing includes of asm/irq.h
  o depca removal of bogus virt_to_bus() uses
  o aacraid iomem annotations
  o fusion iomem annotations
  o alpha writeq fixes
  o amd64 io.h annotations
  o amd64 uaccess.h annotations
  o alpha io_remap_page_range() compile fix
  o ppc io.h annotations
  o sparc64 missing volatile in io.h prototypes
  o added typechecking ot sparc64 ioremap()
  o qlogicisp iomem annotations
  o aic7xxx_old iomem annotations (for real, this time)
  o aty iomem annotations
  o initio.c NULL noise removal

Andi Kleen:
  o scsi: add proper pci id table to aic7xxx
  o x86-64/i386: add mce tainting
  o [TCP]: Remove bogus CONFIG_SYSCTL ifdef
  o x86_64: drop old APIC workaround
  o x86_64: intialize hpet char driver
  o x86_64: use TSC on SMP EM64T machines
  o x86_64: add notsc option
  o x86_64: add an option to configure oops stack dump
  o x86_64: fix IOAPIC on Nvidia boards
  o x86_64 Kconfig: Split CONFIG_NUMA_EMU and CONFIG_K8_NUMA

Andrea Arcangeli:
  o parport_pc superio chip fixes

Andreas Gruenbacher:
  o Replace hard-coded MODVERDIR in modpost
  o xattr: re-introduce validity check before xattr cache insert

Andreas Henriksson:
  o fbdev: Remove i810fb explicit agp initialization hack

Andreas Herrmann:
  o s390: zfcp host adapter

Andrei Konovalov:
  o ppc32: Xilinx ML300 board support (very basic)

Andrew Morton:
  o tmscsim.c build fix
  o kobject_uevent warning fix
  o ksysfs warning fix
  o pegasus.c fixes
  o PCI: fix up usb quirk __init marks
  o PCI: CONFIG_PCI=n build fix
  o PCI: pci_dev_put() build fix
  o psi240i build fix
  o sched: arch_destroy_sched_domains warning fix
  o sched: print preempt count
  o reiserfs: rename struct key
  o jbd wakeup fix
  o unreachable code in ext3_direct_IO()
  o typhoon build fix
  o module_parm_array fixups
  o select-cpio_list-or-source-directory-for-initramfs-image fix
  o vmalloc_to_page() preempt cleanup
  o typhoon build fix
  o v4l: missing bits
  o i2o: missing bits from merge
  o [NETFILTER]: Avoid warning on CONNTRACK_STAT_INC in
    death_by_timeout()
  o [NET]: neigh_stat preempt fix
  o [CRYPTO]: Deinline large function in blowfish.c
  o Fix build for CONFIG_SECURITY=n

Andrew Vasquez:
  o [1/8]  qla2xxx: PCI posting fixes
  o [2/8]  qla2xxx: Dynamic resize of request-q
  o qla2xxx: DMA pool/api usage
  o [4/8]  qla2xxx: Small fixes
  o [5/8]  qla2xxx: Rework ISR registration
  o qla2xxx: 23xx/63xx firmware updates
  o [8/8]  qla2xxx: Update version
  o Fix qla2xxx mismerge
  o SCSI QLA not working on latest *-mm SN2 (qla_dbg fixes)

Andy Whitcroft:
  o vm_dirty_ratio initialisation fix

Anton Altaparmakov:
  o NTFS: Implement extent mft record deallocation
  o NTFS: Splitt runlist related functions off from attrib.[hc] to
    runlist.[hc]
  o NTFS: Add vol->mft_data_pos and initialize it at mount time
  o NTFS: Rename init_runlist() to ntfs_init_runlist(),
    ntfs_vcn_to_lcn() to ntfs_rl_vcn_to_lcn(),
    decompress_mapping_pairs() to ntfs_mapping_pairs_decompress() and
    adapt all callers.
  o NTFS: Forgot to lock the mft bitmap when clearing the bit in
    ntfs_extent_mft_record_free().
  o NTFS: Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
    ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
    and ntfs_mapping_pairs_build(), adapted from libntfs.
  o NTFS: Rename ntfs_merge_runlists() to ntfs_runlists_merge()
  o NTFS: - Add fs/ntfs/lcnalloc.h::ntfs_cluster_free_from_rl() which
    is a static inline wrapper for ntfs_cluster_free_from_rl_nolock()
    which takes the cluster bitmap lock for the duration of the call.
  o NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_record_resize()
  o NTFS: Implement the equivalent of memset() for an ntfs attribute in
    fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
    fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
  o NTFS: Remove unnecessary casts from LCN_* constants
  o NTFS: Implement fs/ntfs/runlist.c::ntfs_rl_truncate_nolock()
  o NTFS: Add MFT_RECORD_OLD as a copy of MFT_RECORD in
    fs/ntfs/layout.h and change MFT_RECORD to contain the NTFS 3.1+
    specific fields.
  o NTFS: Add some debugging checks to fs/ntfs/inode.c::ntfs_truncate()
    and fix a typo in fs/ntfs/layout.h.
  o NTFS: Add a helper function
    fs/ntfs/aops.c::mark_ntfs_record_dirty() which marks all buffers
    belonging to an ntfs record dirty, followed by marking the page the
    ntfs record is in dirty and also marking the vfs inode containing
    the ntfs record dirty (I_DIRTY_PAGES).
  o NTFS: Switch fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to
    using the new helper fs/ntfs/aops.c::mark_ntfs_record_dirty() and
    remove the no longer needed
    fs/ntfs/index.[hc]::__ntfs_index_entry_mark_dirty().
  o NTFS: - Move ntfs_{un,}map_page() from ntfs.h to aops.h and fix
    resulting include errors.
  o NTFS: Remove unused {__,}format_mft_record() from fs/ntfs/mft.c
  o NTFS: - Modify fs/ntfs/mft.c::__mark_mft_record_dirty() to use the
    helper mark_ntfs_record_dirty() which also changes the behaviour in
    that we now set the buffers belonging to the mft record dirty as
    well as the page itself.
  o NTFS: Update fs/ntfs/inode.c::ntfs_write_inode() to also use the
    helper mark_ntfs_record_dirty() and thus to set the buffers
    belonging to the mft record dirty as well as the page itself.
  o NTFS: Fix warnings on x86-64.  (Randy Dunlap with slight
    modification from me)
  o NTFS: Add fs/ntfs/mft.c::try_map_mft_record() which fails with
    -EALREADY if the mft record is already locked and otherwise behaves
    the same way as fs/ntfs/mft.c::map_mft_record().
  o NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() so that it
    only writes the mft record if the buffers belonging to it are
    dirty.
  o NTFS: Attempting to write outside initialized size is _not_ a bug
    so remove the bug check from
    fs/ntfs/aops.c::ntfs_write_mst_block().  It is in fact required to
    write outside initialized size when preparing to extend the
    initialized size.
  o NTFS: Map the page instead of using page_address() before writing
    to it in fs/ntfs/aops.c::ntfs_mft_writepage().
  o NTFS: Provide exclusion between opening an inode / mapping an mft
    record and accessing the mft record in
    fs/ntfs/mft.c::ntfs_mft_writepage() by setting the page not
    uptodate throughout ntfs_mft_writepage().
  o NTFS: Big cleanup of mft record writing code
  o NTFS: - Fix two race conditions in
    fs/ntfs/inode.c::ntfs_put_inode()
  o NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() to no longer
    take the ntfs inode as a parameter as this is confusing and
    misleading and the ntfs inode is available via
    NTFS_I(page->mapping->host).
  o NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() and
    fs/ntfs/aops.c::ntfs_write_mst_block() to only check the dirty
    state
  o NTFS: Move the static inline ntfs_init_big_inode() from
    fs/ntfs/inode.c to inode.h and make
    fs/ntfs/inode.c::__ntfs_init_inode() non-static and add a
    declaration for it to inode.h.  Fix some compilation issues that
    resulted due to #includes and header file interdependencies.
  o NTFS: Simplify setup of i_mode in
    fs/ntfs/inode.c::ntfs_read_locked_inode()
  o NTFS: Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF()
  o NTFS: Modify fs/ntfs/mft.c::map_extent_mft_record() to only verify
    the mft record sequence number if it is specified (i.e. not zero).
  o NTFS: Add fs/ntfs/mft.[hc]::ntfs_mft_record_alloc() and various
    helper functions used by it.
  o NTFS: 2.1.21 release
  o NTFS: Update Documentation/filesystems/ntfs.txt with instructions
    on how to use the Device-Mapper driver with NTFS ftdisk/LDM raid. 
    This removes the linear raid problem with the Software RAID / MD
    driver when one

Antonino Daplas:
  o fbdev: remove unnecessary banshee_wait_idle from tdfxfb
  o fbdev: fix logo drawing failure for vga16fb
  o fbcon: Fix setup boot options of fbcon
  o fbdev: Pass struct device to class_simple_device_add
  o fbdev: Add Tile Blitting support
  o fbdev: fix scrolling corruption
  o fbdev: Add iomem annotations to fbmem.c
  o fbdev: Add iomem annotations to i810fb
  o fbdev: Add iomem annotations to vga16fb.c
  o fbcon unimap fix
  o fbdev: fix framebuffer memory calculation for vesafb
  o fbdev: split vesafb option vram into vtotal and vremap
  o fbdev: trivial fb_get_options fix for cyber2000fb and bw2fb

Arjan van de Ven:
  o aic79xx hostraid support
  o mark scsi_add_host __must_check

Armin Schindler:
  o Remove obsolete file Documentation/isdn/README.eicon

Arnd Bergmann:
  o add missing linux/syscalls.h includes
  o s390: z/VM watchdog timer

Arun Sharma:
  o [IA64] Add missing prototypes to kill warnings in sys_ia32.c

Badari Pulavarty:
  o sched: fix SCHED_SMT & numa=fake=2 lockup

Bartlomiej Zolnierkiewicz:
  o libata: PCI IDE legacy mode fix
  o [libata] do not memset() SCSI request buf in a get-reference style
    function
  o [libata piix] Fix PATA UDMA masks
  o REQUEST_SENSE support for ATAPI
  o [libata] arbitrary size ATAPI PIO support
  o arbitrary size ATAPI PIO support bugfixes
  o make ATAPI PIO work
  o [ide] add sg_init_one() helper and teach ide about it
  o [ide] add ide_hwif_t->dma_setup()
  o [ide] add ide_hwif_t->dma_exec_cmd()
  o [ide] convert ide_hwif_t->ide_dma_begin() to ->dma_start()
  o [ide] pmac: use more ide_hwif_t fields
  o [ide] always allocate hwif->sg_table
  o [ide] sg PIO for taskfile requests
  o [ide] sg PIO for fs requests
  o [ide] ide-disk: unify PIO write/multiwrite code
  o [ide] unify PIO code
  o [ide] remove broken pdc4030 driver
  o [block] remove bio walking
  o [ide] kill CONFIG_IDE_TASKFILE_IO

Ben Dooks:
  o Add S3C2410 (Samsung ARM9 Mobile SoC) watchdog driver
  o [WATCHDOG] s3c2410_wdt.c-wdog-fix-memrelease.patch
  o [WATCHDOG] s3c2410_wdt.c-wdog-fix3.patch
  o [ARM PATCH] 2131/1: Add _iomem to the IO string functions
  o [ARM PATCH] 2144/1: S3C2410 - s3c2440 fixes and clock updates
  o [ARM PATCH] 2145/1: S3C2410 - GPIO ID register update
  o [ARM PATCH] 2132/1: Fix timer NULL pointer de-reference on suspend
  o I2C: S3C2410 I2C Bus driver

Benjamin Herrenschmidt:
  o ppc32/64: FPU/vector register restore after signal
  o ppc64: Fix iSeries build (ouch !)
  o radeonfb: Fix monitor probe logic
  o rework radeonfb blanking
  o ppc64: Fix boot on some non-LPAR pSeries
  o ppc64: Fix typo in zImage boot wrapper
  o ppc64: Update G5 thermal control driver
  o ppc: Disable IRQ probe on ppc
  o ppc: Fix build of irq.c with CONFIG_TAU_INT

Bjorn Helgaas:
  o HCD PCI probe: print actual, not ioremapped, address
  o QLogic ISP2x00: remove needless busyloop
  o add-pci_fixup_enable-pass.patch

Borislav Petkov:
  o USB: fix up usblp usb_unlink_urb() warning
  o USB: remove calls to usb_unlink_urb in class/audio.c
  o USB: remove calls to usb_unlink_urb in class/bluetty.c
  o USB: remove calls to usb_unlink_urb in class/cdc-acm.c
  o USB: remove calls to usb_unlink_urb in class/usb-midi.c
  o USB: remove calls to usb_unlink_urb() in image/hpusbscsi.c
  o USB: remove call to usb_unlink_urb() in media/usbvideo.c
  o USB: remove calls to usb_unlink_urb in media/stv680.c
  o USB: remove calls to usb_unlink_urb in media/se401.c
  o USB: remove call to usb_unlink_urb in media/ov511.c
  o USB: remove calls to usb_unlink_urb in media/konicawc.c
  o USB: remove calls to usb_unlink_urb in input/xpad.c
  o USB: usb_unlink_urb removal from input/ati_remote.c
  o USB: remove calls to usb_unlink_urb in input/wacom.c
  o USB: remove calls to usb_unlink_urb in input/usbmouse.c
  o USB: remove calls to usb_unlink_urb in core/message.c
  o USB: remove usb_unlink_urb() calls in input/kbtab.c
  o USB: usb_unlink_urb removal from input/hid-core.c
  o USB: remove calls to usb_unlink_urb in input/mtouchusb.c
  o USB: usb_unlink_urb removal from input/aiptek.c
  o USB: remove calls to usb_unlink_urb in input/usbkbd.c
  o USB: remove calls to usb_unlink_urb() in input/pid.c
  o USB: remove calls to usb_unlink_urb in image/mdc800.c (v2)
  o USB: remove calls to usb_unlink_urb in input/powermate.c
  o USB: remove calls to usb_unlink_urb() in input/touchkitusb.c
  o USB: remove calls to usb_unlink_urb in net/catc.c
  o USB: remove calls to usb_unlink_urb in misc/legousbtower.c
  o USB: remove _some_ calls to usb_unlink_urb in misc/auerswald.c
  o USB: remove calls to usb_unlink_urb in net/usbnet.c
  o USB: remove calls to usb_unlink_urb() in net/pegasus.c
  o USB: remove calls to usb_unlink_urb() in net/kaweth.c

Carlos Eduardo Medaglia Dyonisio:
  o Fix types.h

Catalin Boie:
  o USB Serial: Correct a use of out of range variable
  o USB: cdc-acm-usb-use-uninit-mem-bug.patch

Chas Williams:
  o [ATM]: use RCV_SHUTDOWN to exit skb_recv_datagram()
  o [ATM]: point to multipoint signalling (from
    ekinzie@cmf.nrl.navy.mil)
  o [ATM]: [ambassador] eliminate pci_find_device()
  o [ATM]: [firestream] remove dead code (from Francois Romieu
    <romieu@fr.zoreil.com>)
  o [ATM]: [zatm] eliminate pci_find_device (from Francois Romieu
    <romieu@fr.zoreil.com>)

Chris Mason:
  o reiserfs: small filesystem fix

Chris Wedgwood:
  o UML IO sched support

Chris Wright:
  o [PKT_SCHED]: Trivial spelling fix in net/sched/Kconfig
  o [PKT_SCHED]: Make tcp_proto_lookup_ops() static
  o lsm: rename security_scaffolding_startup to security_init
  o lsm: reduce noise during security_register
  o lsm: Lindent security/security.c
  o make __sigqueue_alloc() a general helper

Christoph Hellwig:
  o update NCR5380 comments
  o update dmx3191d to modern pci/scsi probing
  o first steps at BusLogic cleanup
  o refactor tmscsim inititalization code
  o update notcq blacklist
  o don't include "scsi.h" in scsi_module.c
  o avoid obsolete APIs in ide-scsi
  o avoid obsolete APIs in eata
  o allow non-modular mptctl
  o fix aic79xx module_init return value when no hardware
  o start removing queue from tmscsim
  o fix Scsi_Host leak in BusLogic
  o kill useless spinlock wrappers in BusLogic
  o remove abort,reset methods from host templates
  o some ncr53c8xx decrufting
  o move scsi_add_host back to where it belongs in aacraid
  o don't mark aacraid as experimental
  o switch fusion to use <linux/list.h> everywhere
  o don't mark the initio 9100 driver broken
  o remove internal queueing from inia100
  o fix inia100 dma mapping warnings
  o fusion dead code removal
  o tmscsim: back out bogus eeprom reading changes
  o merge a100u2w source files
  o qla1280: ISP1020/1040 support
  o initio: remove obsolete APIs, cleanup
  o a100u2w: cleanups
  o merge initio source files
  o tmscsim: remove superflous global host list
  o get rid of obsolete APIs in u14-34f
  o PCI: mark proc_bus_pci_dir static
  o tmscsim: remove remaining INQUIRY sniffing
  o get rid of obsolete APIs in BusLogic
  o get rid of obsolete APIs in nsp32
  o fdomain: reduce usage of global variables
  o merge scsiiom.c into tmscsim.c
  o sparse __iomem annotations for qla2xxx
  o don't export blkdev_open and def_blk_ops
  o remove dead code from fs/mbcache.c
  o remove posix_acl_masq_nfs_mode
  o don't export shmem_file_setup
  o remove pm_find, unexport pm_send
  o remove dead code and exports from signal.c
  o unexport proc_sys_root
  o unexport is_subdir and shrink_dcache_anon
  o unexport devfs_mk_symlink
  o unexport do_execve/do_select
  o unexport exit_mm
  o unexport files_lock and put_filp
  o unexport f_delown
  o unexport lookup_create
  o remove wake_up_all_sync
  o remove set_fs_root/set_fs_pwd
  o remove MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
  o mark inter_module_* deprecated
  o don't include <linux/sysctl.h> in <linux/security.h>
  o remove dead exports from fs/fat/
  o don't include <linux/irq.h> from drivers

Christoph Lameter:
  o Posix compliant cpu clocks
  o Posix compliant cpu clocks V6: mmtimer provides CLOCK_SGI_CYCLE

Colin Leroy:
  o Warning fix in drivers/macintosh/macio-adb.c

Con Kolivas:
  o netconsole support for b44
  o b44poll - whitespace

Craig Hughes:
  o USB: host side fixes for pxa2xx/ethernet/rndis gadgets, like
    gumstix

Daniele Venzano:
  o [netdrvr sis900] whitespace and codingstyle updates

Dave Hansen:
  o remove weird pmd cast

Dave Jones:
  o [CPUFREQ] speedstep-smi: only allow it to run on mobile Intel
    Pentium III
  o [CPUFREQ] Work around AMD64 2nd identical PST errata
  o Remove redundant freeing code from aic7770
  o plug leaks in aic79xx
  o Remove possible reuse of stale pointer in aic7xxx
  o plug leaks in aic7xxx_osm
  o [CPUFREQ] Fix numerous typos in drivers/cpufreq/Kconfig
  o [CPUFREQ] i386 Kconfig fixes
  o [CPUFREQ] x86_64 Kconfig fixes
  o [CPUFREQ] arm Kconfig fixes
  o [CPUFREQ] core Kconfig fix
  o [CPUFREQ] speedstep-centrino should only decode MSR on certain CPUs
  o [CPUFREQ] remove double calls to module_get/put in userspace
    governor
  o [CPUFREQ][1/4] cpufreq "cpu group" awareness: add policy->cpus
  o [CPUFREQ][2/4] cpufreq "cpu group" awareness: save sysdev for all
    CPUs
  o [CPUFREQ][3/4] cpufreq "cpu group" awareness: do symlinks for other
    CPUs instead of registering kobjects
  o [CPUFREQ][4/4] cpufreq "cpu group" awareness: remove FIXME in
    speedstep-ich
  o [AGPGART] Fix incorrect VIA PT880 entry

Dave Kleikamp:
  o generic acl support for ->permission

David Brownell:
  o USB: OHCI init cleanups
  o USB: EHCI SMP fix
  o export usb_set_device_state(), use in ohci
  o USB: gadget_is_n9604
  o USB: ohci updates
  o USB: khubd looks at ports after probe
  o USB: omap_udc supports 5910/1510 chips
  o USB: ohci init refactor
  o USB: net2280 updates
  o USB Gadget: Ethernet/RNDIS gadget, minor updates
  o USB: OHCI support for PXA27x
  o USB Gadget: debug files now Kconfigured
  o USB: OHCI autodetects "need" for init reset quirk
  o PCI: update Documentation/power/pci.txt

David Dillow:
  o PCI cleanups and convert to ethtool_ops

David Howells:
  o Add some key management specific error codes
  o keys: new error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64
  o implement in-kernel keys & keyring management

David S. Miller:
  o [PKT_SCHED]: Fix sch_atm build
  o [SPARC64]: Re-export force_sig to modules
  o [SPARC]: Add entries for recently added system calls
  o [AF_UNIX]: Remove spurious len test in unix_mkname
  o [NET]: More pktgen.c warnings not caught by Randys patch
  o [NET]: Need to disable preempt in softirq check of netif_rx_ni
  o [CRYPTO]: Fix typo in Kconfig
  o [NET]: TSO requires SG, enforce this at device registry
  o [SPARC64]: Make iomap.o obj-y instead of lib-y for module exports
  o [IEEE1394]: ohci1394.c/pcylynx.c need asm/irq.h
  o [SPARC64]: Update defconfig
  o [NET]: Uninline netif_rx_ni()
  o [TG3]: Update driver version and reldate
  o [TCP]: Add total num retransmits accounting
  o [NET]: In netif_rx_ni, put netif_rx call inside preempt-disable

David T. Hollis:
  o USB: Add Surecom USB Ethernet device ids to usbnet

David Woodhouse:
  o USB: Generic USB ATM/DSL core and completed SpeedTouch driver
  o USB: Reformat usb-atm code and rework SpeedTouch firmware loading
  o USB: Fix assertion logic in USB ATM core
  o USB: SpeedTouch / ATM update
  o USB SpeedTouch / ATM: Make it work on 64-bit hosts
  o JFFS2: work around uninitialised use of usercompr field by old code
  o MTD cmdlinepart: Allow partition definitions to be set from
    elsewhere
  o MTD map driver update: Alchemy DB1xxx boards
  o MTD map driver update: ppc44x 'ebony' board
  o MTD map access: Fix calculation of the number of longs in a bus
    access
  o New MTD map drivers
  o MTD: NOR flash chip driver updates
  o MTD translation layer helper: set PF_NOFREEZE to allow sleep
  o MTD userspace ABI: fix userspace compilation w.r.t. __user
  o JFFS2 updates

Dean Gaudet:
  o transmeta efficeon support and cpuid update

Dely Sy:
  o PCI Hotplug: change bus speed patch
  o PCI Hotplug: Bug fixes for shpchp driver
  o PCI Hotplug: quirk fix missed out in last patch

Dimitry Andric:
  o [WATCHDOG] s3c2410_wdt.c-wdog-fix4.patch

Dinakar Guniguntala:
  o ps shows wrong ppid
  o stat shows wrong ppid

Dipankar Sarma:
  o Fix dcache lookup
  o Remove d_bucket
  o Document RCU based dcache lookup

Dmitry Torokhov:
  o ieee1394: SBP-2 - rename some constants to fix clash with new SCSI
    core defines

Dominik Brodowski:
  o [PCMCIA] 01-unused_bulkmem_code.diff
  o [PCMCIA] 02-move_bulkmem.diff
  o [PCMCIA] 03-remove_ftl_memory.diff
  o [PCMCIA] 04-obsolete_kconfig.diff
  o [PCMCICA] 05-obsolete_parts_of_cs.diff
  o [PCMCIA] 06-Kconfig_PCMCIA.diff
  o [PCMCIA] 01-lookup_bus.diff
  o [PCMCIA] 02-adjust_resource_info.diff
  o [PCMCIA] 03-replace_cis.diff
  o [PCMCIA] 04-get_firstnext_tuple.diff
  o [PCMCIA] 05-get_tuple_data.diff
  o [PCMCIA] 06-parse_tuple.diff
  o [PCMCIA] 07-read_tuple.diff
  o [PCMCIA] 08-validate_cis.diff
  o [PCMCIA] 09-pcmcia_compat.diff
  o [PCMCIA] 10-get_window.diff
  o [PCMCIA] 11-configuration_info.diff
  o [PCMCIA] 12-reset_card.diff
  o [PCMCIA] 13-get_status.diff
  o [PCMCIA] 14-access_configuration.diff
  o [PCMCIA] 15-get_firstnext_region.diff

Douglas Gilbert:
  o scsi_debug version 1.74
  o sg jiffy library calls [was: sg kill local jiffies
  o scsi: normalize fixed and descriptor sense data
  o scsi_mid_low_api.txt update

Duncan Sands:
  o usb speedtch: no side-effects in BUG_ON
  o usb speedtch: convert to using usb_kill_urb
  o usb: extract sensible strings from buggy string descriptors
  o USB SpeedTouch cleanup
  o firmware_class: avoid double free

Ed Schouten:
  o nfsd: Insecure port warning shows decimal IPv4 address

Egbert Eich:
  o VGA console font problems on 2.6 kernel

Eric Rossman:
  o s390: crypto device driver

Eric Valette:
  o USB: rtl8150.c ethernet driver : usb_unlink_urb ->usb_kill_urb

Erik Rigtorp:
  o swsusp: progress in percent

Evgeniy Polyakov:
  o w1: Added slave->ttl - time to live for the registered slave
  o W1: let W1 select NET
  o w1_therm: more precise temperature calculation
  o w1: schedule_timeout() issues
  o scx200: pci_find_device() removal

Florian Schirmer:
  o [netdrvr b44] ignore carrier lost errors
  o [netdrvr b44] clean up SiliconBackplane definitions/functions

Frank Hirtz:
  o Display committed memory limit and available in  meminfo

Frank Pavlic:
  o s390: qeth layer 2 support

François Romieu:
  o sata_nv: enable hotplug event on successfull init only
  o sata_nv: wrong failure path and leak
  o sata_nv: housekeeping for goto labels

Geert Uytterhoeven:
  o FrameMaster II build fix
  o m68k: MM off-by-one
  o Atari ACSI dependencies
  o m68k: minmax-removal arch/m68k/kernel/bios32.c
  o M68k: don't emit empty stack program header in vmlinux
  o Amifb: update pseudocolor bitfield lenghts
  o Amiga frame buffer: kill obsolete DMI Resolver code
  o m68k: NULL vs. 0 cleanups
  o Amifb: use new amifb:off logic to enhance audio experience

Gerald Schaefer:
  o s390: add support to read z/VM monitor records

Gerd Knorr:
  o I2C: i2c bus power management support
  o v4l: tuner update
  o v4l: avoid using struct file ptrs in video-buf
  o v4l: adapt saa7146 to video-buf changes
  o v4l: bttv driver update
  o v4l: cx88 driver update
  o DVB/V4L dependency fix
  o v4l: msp3400 cleanup

Gordon Jin:
  o x86_64: correct copy_user_generic return value when exception
    happens

Greg Kroah-Hartman:
  o kobject: adjust hotplug_seqnum increment to keep userspace and
    kernel agreeing
  o ksysfs: don't build ksysfs if CONFIG_SYSFS is not enabled
  o kobject: fix build error if CONFIG_HOTPLUG is not enabled
  o USB: remove usbdevfs filesystem name, usbfs is the proper one to
    use
  o kobject: hotplug_seqnum is not 64 bits on all platforms, so fix it
  o ksyms: don't implement /sys/kernel/hotplug_seqnum if CONFIG_HOTPLUG
    is not enabled
  o USB: make usb_unlink_urb() message only show up if
    CONFIG_DEBUG_KERNEL is enabled
  o USB: fix usb_unlink_urb() usage in pl2303 driver
  o USB: fix usb_unlink_urb() usage in usb-serial core
  o USB: fix usb_unlink_urb() usage in belkin_sa driver
  o USB: fix usb_unlink_urb() usage in cyberjack driver
  o USB: fix usb_unlink_urb() usage in whiteheat driver
  o USB: fix usb_unlink_urb() usage in io_edgeport driver
  o USB: fix usb_unlink_urb() usage in ir-usb driver
  o USB: fix usb_unlink_urb() usage in ipaq driver
  o USB: fix usb_unlink_urb() usage in digi_acceleport driver
  o USB: fix usb_unlink_urb() usage in empeg driver
  o USB: fix usb_unlink_urb() usage in mct_u232 driver
  o USB: fix usb_unlink_urb() usage in omninet driver
  o USB: fix usb_unlink_urb() usage in visor driver
  o USB: fix usb_unlink_urb() usage in kl5kusb105 driver
  o USB: fix usb_unlink_urb() usage in kobil_sct driver
  o USB: fix usb_unlink_urb() usage in io_ti driver
  o USB: fix usb_unlink_urb() usage in ftdi_sio driver
  o USB: fix usb_unlink_urb() usage in keyspan_pda driver
  o USB: fix usb_unlink_urb() usage in generic usb-serial driver
  o Kobject Userspace Event Notification
  o I2C: fix up __iomem marking for i2c bus drivers
  o PCI: fix __iomem warnings in quirk code
  o kevent: standardize on the event types
  o USB: fix hcd-pci's __iomem warnings
  o USB: fix up __iomem warnings in the ehci driver
  o USB: fix up __iomem warnings in the ohci driver
  o USB: fix up some minor sparse warnings in the uhci driver
  o kevent: add block mount and umount support
  o USB:  oops, revert drivers/usb/core/message.c change
  o USB: fix incorrect usage of usb_kill_urb in rtl8150 driver
  o Put symbolic links between drivers and modules in the sysfs tree
  o USB: add support for symlink from usb and usb-serial driver to its
    module in sysfs
  o PCI: add "struct module *" to struct pci_driver to show symlink in
    sysfs for pci drivers
  o I2C: change i2c-elektor.c driver from using pci_find_device()
  o I2C: convert scx200_acb driver to not use pci_find_device
  o PCI: remove pci_find_subsys() calls from cpufreq code
  o PCI: remove pci_find_subsys() calls from acpi code
  o PCI: make pci_find_subsys() static, as it should not be used
    anymore
  o PCI: update the pci.txt documentation about pci_find_device and
    pci_find_subsys going away
  o PCI: make pci_find_class() warn if in interrupt like all other
    find/get functions do
  o PCI: add pci_get_class() to make a safe pci_find_class() like call
  o PCI: clean up the comments in search.c to be correct
  o PCI: remove pci_find_class() usage from arch specific files
  o PCI: remove pci_find_class() usage from all drivers/ files
  o PCI: delete the pci_find_class() function as it's unsafe in
    hotpluggable systems
  o PCI: fix improper pr_debug() statement
  o PCI: get rid of pci_find_device() from arch/i386/*
  o PCI: remove pci_find_device() usages from drivers/pci/*
  o PCI: fix __iomem * warnings for PCI msi core code
  o PCI Hotplug: fix __iomem warnings in the compaq pci hotplug driver
  o PCI Hotplug: fix __iomem warnings in the ibm pci hotplug driver
  o PCI Hotplug: fix the rest of the drivers for __iomem and other
    sparse issues
  o ibmasm: fix __iomem warnings
  o PCI: Create new function to see if a pci device is present
  o PCI: change cyrix.c driver to use pci_dev_present
  o PCI Hotplug: Oops, didn't mean to apply the msi pci express patch,
    so revert it
  o PCI: remove pci_module_init() usage from drivers/pci/hotplug/*
  o PCI: clean up pci_dev_get() to be sane
  o PCI: remove all usages of pci_dma_sync_sg as it's obsolete
  o PCI: remove all usages of pci_dma_sync_single as it's obsolete
  o PCI: fix up pci_register_driver() to stop lying in its return value
  o PCI: audit all callers of pci_register_driver() to work properly
  o PCI: pci_module_init() is identical to pci_register_driver() so
    just make it a #define
  o PCI: remove pci_module_init() usage from drivers/usb/*
  o kevent: add __bitwise kobject_action to help the compiler check for
    misusages
  o USB: add endian markups to the ub driver
  o USB: add bulk_in_size for usb-serial devices
  o USB: add serial ipw driver
  o PCI: fix up pci_save/restore_state in via-agp due to api change
  o I2C: convert from pci_module_init to pci_register_driver for all
    i2c drivers

Gregory Kurz:
  o fork() bug invalidates file descriptors

Guennadi Liakhovetski:
  o tmscsim: remove redundant code
  o ST34555N misbehaves on tagged INQUIRY commands - add to blacklist
  o tmscsim: use mid-layer's decision for tag support
  o tmscsim: remove internal command queue
  o tmscsim: use block-layer tags

Guido Guenther:
  o Mac swsusp driver fixes

Hanna V. Linder:
  o PCI: Fix one missed pci_find_device
  o PCI: Changed pci_find_device to pci_get_device for acpi.c

Hannes Reinecke:
  o Driver Core: Handle NULL arg for put_device()

Harald Welte:
  o [NETFILTER]: Add iptables CONNMARK match+target
  o [NETFILTER]: Add iptables hashlimit match
  o [NETFILTER]: Add iptables CLUSTERIP target, seq_file version

Haroldo Gamal:
  o smbfs does not honor uid, gid, file_mode and dir_mode supplied by
    user mount

Heinz-Juergen Oertel:
  o USB: usb/serial RM vendor/product id for ftdi_sio

Helmut Tschemernjak:
  o [ATALK]: Add appletalk 32-bit ioctl emulation

Herbert Xu:
  o USB: Fix hiddev devfs oops
  o [TCP]: Create tcpdiag_dump_sock
  o [TCP]: Make tcpdiag_bc_run take tcpdiag_entry
  o [TCP]: Dump SYN_RECV sockets in tcpdiag
  o [NET]: Make sure to copy TSO fields in copy_skb_header()
  o [NETLINK]: Yield in netlink_broadcast when congested
  o [TCP]: Fix new packet len calc in tcp_fragment()
  o [XFRM]: Make {__,}xfrm_policy_check behave identically wrt. empty
    policy lists
  o [XFRM]: Fix policy update bug when increasing priority of last
    policy
  o [TCP]: Fix tcp_trim_head() calculations

Hideo Aoki:
  o vm thrashing control tuning
  o proc.txt cleanup
  o vm thrashing control tuning CONFIG_SWAP=n build fix

Hirofumi Ogawa:
  o FAT: use hlist_head for fat_inode_hashtable
  o FAT: rewrite the cache for file allocation table lookup
  o FAT: cache lock from per sb to per inode
  o FAT: the inode hash from per module to per sb
  o FAT: Fix the race bitween fat_free() and fat_get_cluster()
  o FAT: remove debug_pr()
  o FAT: merge fix
  o FAT: check free_clusters value
  o FAT: removal of C[FT]_LE_[WL] macro
  o FAT: remove validity check of FAT first entry

Hirokazu Takata:
  o m32r: trivial fix of smc91x.h
  o m32r: ds1302 driver
  o m32r: new CF/PCMCIA driver for m32r
  o m32r: update include/asm-m32r/m32102.h
  o m32r: AR camera driver
  o m32r: SIO driver
  o m32r: fix sys_tas system call for m32r
  o m32r: update arch/m32r/mm/fault.c to fix a  compile error
  o m32r: fix a compile error of M32R SIO driver
  o m32r: update SIO driver to use module_param()

Hugh Dickins:
  o __set_page_dirty_nobuffers mappings
  o lighten mmlist_lock

Ian Abbott:
  o USB: Add B&B Electronics VID/PIDs to ftdi_sio

Ian Kent:
  o autofs4: allow map update recognition

Ingo Molnar:
  o module.h build fix
  o i386 entry.S cleanups
  o softirqs: fix latency of softirq processing
  o fix the prof=schedule feature
  o generic irq subsystem: core
  o generic irq subsystem: x86 port
  o generic irq subsystem: x86_64 port
  o generic irq subsystem: ppc port
  o generic irq subsystem: ppc64 port
  o doc: remove references to hardirq.c
  o fix & clean up zombie/dead task handling & preemption
  o disk stats preempt safety

Jack Hammer:
  o ServeRAID driver ( ips ) Version 7.10.18

Jamal Hadi Salim:
  o [NET]: Add Mirred TC action

James Bottomley:
  o Add scsi_target abstraction and place it in sysfs
  o Add host and target transport class abstractions
  o Make the SPI transport parameters operate at the target level
  o Add bus signalling host attribute to spi transport class
  o Fix up scsi_test_unit_ready() to work correctly with CD-ROMs
  o fix undefined function msleep warning in osst
  o fix printk warning in sg.c
  o advansys build fix
  o fix SPI transport attributes not showing up in sysfs
  o add channel to struct scsi_target
  o scsi: Add reset ioctl capability to ULDs
  o remove old ifdefs aic79xx
  o remove old ifdefs aic7xxx
  o add .module to qla1280 template
  o complete the bus_addr_t removal from aic7xxx
  o Remove duplicate IDENTIFY from scsi.h
  o Fix a100u2w compile error
  o Add refcounting to scsi command allocation
  o ncr53c8xx: remove integrity checking
  o ncr53c8xx: move driver local quirks up to scsi blacklist
  o mcr53c8xx: remove INQUIRY snooping and believe the mid-layer flags
  o add device_configure to the transport classes
  o ncr53c8xx: Convert to using transport classes
  o Fix up 3w-xxxx after NULL removal mismerge
  o scsi: fix host transport allocations
  o 53c700: update driver for host spi class
  o SCSI: Fix problems with non-power-of-two sector size discs
  o SCSI: fix Suspend I/O block/unblock path

James Morris:
  o xattr consolidation v3 - generic xattr API
  o xattr consolidation v3 - LSM
  o xattr consolidation v3 - ext3
  o xattr consolidation v3 - ext2
  o xattr consolidation v3 - devpts
  o xattr consolidation v3 - tmpfs
  o SELinux: allow all filesystems to specify fscreate mount  option
  o [CRYPTO]: Add Tnepres cipher support

James Smart:
  o Allow LLDD's to fail slave alloc (non-existent slave)
  o suspending I/Os to a device

Jan-Benedict Glaw:
  o Document DEC VSXXX-AB digitizer as known working

Jean Delvare:
  o I2C: Do not init global variables to 0
  o I2C: Fix macro calls in chip drivers
  o I2C: More verbose debug in w83781d detection
  o I2C: Update Documentation/i2c/writing-clients
  o I2C: Cleanup lm78 init
  o I2C: Store lm83 and lm90 temperatures in signed
  o I2C: Spare 1 byte in lm90 driver
  o I2C: Fourth auto-fan control interface proposal
  o I2C: Update Kconfig for AMD bus drivers
  o I2C: Fix amd756 name
  o I2C: Clean up i2c-amd756 and i2c-prosavage messages
  o I2C: lm87 driver ported to Linux 2.6

Jean Tourrilhes:
  o wireless-extension-v17-for-linus.patch
  o wireless-drivers-update-for-we-17.patch
  o WE-17 typo fix
  o [IRDA]: Fix lmp_lsap_inuse()
  o [IRDA]: Fix nsc-ircc dongle_id input
  o [IRDA]: IrNET char dev alias
  o [IRDA]: IAS safety comments
  o [IRDA]: Adaptive discovery query timer
  o [IRDA]: IrCOMM IAS object fix
  o [IRDA]: via-ircc driver speed fixes
  o [IRDA]: Debug module param
  o [IRDA]: Stir driver usb reset fix
  o [IRDA]: Stir driver suspend fix
  o [IRDA]: Stir netdev and messages cleanups

Jeff Garzik:
  o [netdrvr b44] update MODULE_AUTHORS
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA
  o [libata sata_uli] add dev_select hook
  o [libata] add AHCI driver
  o [libata ahci] fix several bugs
  o [libata ahci] more updates

Jeff Mahoney:
  o ReiserFS: Cleanup internal use of bh macros
  o ReiserFS: Cleanup access of journal (cosmetic)
  o ReiserFS: Add I/O error handling to journal operations
  o ReiserFS: Fix several missing reiserfs_write_unlock calls
  o reiserfs: support for REISERFS_UNSUPPORTED_OPT notation
  o reiserfs: allow user_xattr and acl options to be ignored, with
    warning

Jens Axboe:
  o invalidate page race fix
  o return full SCSI status byte in SG_IO
  o switchable and modular io schedulers
  o cfq-v2 I/O scheduler update
  o convert jiffies <-> msecs for io schedulers
  o move io scheduler kconfig entries

Jeremy Higdon:
  o sg.c to warn about ambiguous data direction
  o scsi: add blacklist attribute indicating no ULD attach
  o add ability to set device queue depth to mptfusion
  o per-port LED control for sata_vsc

Jesper Juhl:
  o __copy_to_user return value checks in i2o_config.c
  o [NET]: Add new sysfs attribute 'carrier' for net devices
  o [ATM]: ambassador printk warning fix

Jesse Barnes:
  o SCSI QLA not working on latest *-mm SN2
  o USB: handle usb host allocation failures gracefully
  o [IA64] mca.c: sparse cleanup
  o [IA64] numa.c, discontig.c: sparse: use NULL, not 0
  o [IA64-SGI] snsc.c: snsc needs asm/sn/io.h
  o [IA64] fix sba_iommu build
  o [IA64-SGI] sparse cleanups & misc fixes for sn2
  o [IA64-SGI] more sparse I/O accessor fixes

John Hawkes:
  o [IA64] top level scheduler domain for ia64

John Rose:
  o PCI Hotplug: add host bridges to RPA hotplug subsystem
  o PCI Hotplug: RPA dynamic addition/removal of PCI Host Bridges
  o PPC64: Add pcibios_remove_root_bus
  o PPC64: RPA dynamic addition/removal of PCI Host Bridges
  o PCI Hotplug: RPA DLPAR - remove error check
  o PCI Hotplug: rpaphp safe list traversal

John Stultz:
  o USB: early usb handoff for 2.6

John W. Linville:
  o [TG3]: Add MODULE_VERSION
  o [B44]: Add MODULE_VERSION

Joshua Kwan:
  o Disambiguate esp.c clones

Kai Mäkisara:
  o avoid obsolete "scsi.h" APIs in st

KaiGai Kohei:
  o atomic_inc_return() for i386
  o atomic_inc_return() for x86_64
  o atomic_inc_return() for arm
  o atomic_inc_return() for arm26
  o atomic_inc_return() for sparc64

Kay Sievers:
  o export of SEQNUM to userspace (creates /sys/kernel)

Keith Owens:
  o [IA64] Avoid a rare deadlock during unwind
  o reference_init fix

Kenji Kaneshige:
  o USB: add missing pci_disable_device for PCI-based USB HCD
  o PCI: warn of missing pci_disable_device()

Kenneth W. Chen:
  o Enable config_schedstats for all arches

Lennert Buytenhek:
  o PCI: minor pci.ids update

Lev Makhlis:
  o show aggregate per-process counters in /proc/PID/stat 2

Li Shaohua:
  o PCI: Reorder some initialization code to allow resources to be
    proper allocated

Linus Torvalds:
  o Add fake '__builtin_warning()' for the gcc case
  o Older gcc's ICE on missing (unused) varags macro name
  o Add copyright notice on ppc64 iomap files
  o Wrap <linux/compiler.h> inside '#ifndef __ASSEMBLY__'
  o Fix old-style fn declaration
  o Don't use obsolete gcc named initializer syntax
  o Fix pci config syscall definitions
  o Fix posix timer direct user space access
  o Update tty layer to not mix kernel and user pointers
  o remap_pfn_range: make the region special
  o Make drivers/char/mem.c use remap_pfn_range()
  o Make core-dumps have all the relevant regions in it
  o Fix up USB serial console for tty layer changes
  o Linux 2.6.10-rc1

Luben Tuikov:
  o Adding PCI ID tables to aic7xxx and aic79xxx
  o aic7xxx and aic79xx: fix sleeping while holding a lock

Luca Risolia:
  o USB: SN9C10x driver update
  o USB: SN9C10x driver updates

Luiz Capitulino:
  o USB: remove ugly code from usb/serial/usb-serial.c
  o USB: missing check in usb/serial/usb-serial.c
  o usb-serial: Moves the search in device list out of
    usb_serial_probe()
  o usb-serial: create_serial() return value trivial fix
  o usb-serial: return_serial() trivial cleanup
  o usb-serial: usb_serial_register() cleanup
  o usb-serial: Add module version information
  o PCI: add missing checks in drivers/pci/probe.c

Maciej Soltysiak:
  o [TCP]: Document tcp_tso_win_divisor in ip-sysctl.txt

Maciej W. Rozycki:
  o "console=" parameter ignored

Manfred Spraul:
  o rx checksum support for gige nForce ethernet
  o slab: reduce fragmentation due to kmem_cache_alloc_node

Marcel Holtmann:
  o [Bluetooth] Improve connection hash handling
  o [Bluetooth] Fix race when unlinking incoming connections
  o [Bluetooth] Let the CAPI free the SKB in the error case
  o [Bluetooth] Add module parameter for disabling ISOC transfers
  o [Bluetooth] Add security manager flags and options
  o [Bluetooth] Stop TX task before notifying the driver

Marcelo Tosatti:
  o Adjust alignment of pagevec structure
  o Remove redundant AND from swp_type()

Margit Schubert-While:
  o prism54 Code cleanup
  o prism54 remove module params
  o prism54 add WE17 support
  o prism54 initial WPA support
  o prism54 fix wpa_supplicant frequency parsing
  o I2C: minor lm85 fix
  o prism54 remove TRACE
  o prism54 Bug in timeout scheduling
  o prism54 print firmware version
  o prism54 bug initialization/mgt_commit

Mark Haverkamp:
  o aacraid: Detect non-committed array
  o 2.6.9 aacraid: aac_count fix
  o aacraid: dynamic dev update
  o aacraid: Add get container name functionality

Mark Lord:
  o Export ata_scsi_simulate() for use by non-libata drivers

Mark M. Hoffman:
  o I2C/SMBus stub for driver testing
  o i2c: Add Intel VRD 10.0 and AMD Opteron VID support
  o i2c: sensors chip driver updates
  o i2c: kill some sensors driver macro abuse

Markus Lidel:
  o i2o: code beautifying and cleanup
  o i2o: added support for Promise controllers
  o i2o: new functions to convert messages to a virtual address
  o i2o: quieten sparse 1-bit-bitfield warnings in i2o.h
  o i2o: correct error code if bus is busy in i2o_scsi
  o i2o: message conversion fix for le32_to_cpu parameters

Martin Schlemmer:
  o Select cpio_list or source directory for initramfs image

Martin Schwidefsky:
  o cleanup: move call to update_process_times
  o cleanup: remove unused definitions from timex.h
  o cleanup: time.h, times.h, timex.h and jiffies.h

Matt Domsch:
  o EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
  o idefloppy: suppress media not present errors
  o modules: put srcversion checksum in each modinfo section

Matt Porter:
  o ppc32: use gen550 for PPC44x progress/ppc-stub
  o ppc32: add gen550.h
  o ppc32: configure PPC440GX L2 cache based on CPU rev
  o ppc32: remove bogus PPC44x prefetch workaround
  o ppc32: fix ibm44x_common.c compile

Matthew Dharm:
  o USB Storage: change how INQUIRY is fixed up
  o USB storage: delayed device scanning
  o USB Storage: ignore bogus residue values
  o USB Storage: revert GetMaxLUN strictness

Matthew Dobson:
  o sched_domains: Make SD_NODE_INIT per-arch #2
  o sched: remove NODE_BALANCE_RATE definitions
  o Create nodemask_t

Matthew Wilcox:
  o sym2 2.1.18k
  o Add SPI-5 constants to scsi.h
  o PA-RISC sound update

Matthieu Castet:
  o use of MODULE_DEVICE_TABLE in i2c busses driver
  o bttv IRQ fix

Maximilian Attems:
  o usb/tiglusb: insert set_current_state() before schedule_timeout()
  o usb/dabusb: insert set_current_state() before schedule_timeout()
  o list_for_each_entry: drivers-usb-core-devices.c
  o list_for_each_entry: drivers-usb-serial-ipaq.c
  o list_for_each_entry: drivers-usb-host-hc_sl811.c
  o list_for_each_entry: drivers-usb-media-dabusb.c
  o list_for_each_entry: drivers-usb-class-usb-midi.c
  o list_for_each_entry: drivers-usb-class-audio.c
  o scsi/mesh: replace schedule_timeout()   with msleep()
  o scsi/osst: replace schedule_timeout()   with msleep()
  o scsi/wd7000: replace schedule_timeout()         with msleep()
  o scsi/sd: replace schedule_timeout() with        msleep()
  o scsi/qla_init: replace  schedule_timeout() with
  o scsi/qla_os: replace schedule_timeout()         with msleep()
  o scsi/sata_sx4: replace schedule_timeout()       with
  o PCI list_for_each: arch-i386-pci-i386.c
  o PCI list_for_each: arch-alpha-kernel-pci.c
  o PCI list_for_each: arch-ia64-pci-pci.c
  o PCI list_for_each: arch-ia64-sn-io-machvec-pci_bus_cvlink.c
  o PCI list_for_each: arch-ppc64-kernel-pci.c
  o PCI list_for_each: arch-ppc64-kernel-pci_dn.c
  o PCI list_for_each: arch-ppc-kernel-pci.c
  o PCI list_for_each: arch-sparc-kernel-pcic.c
  o PCI pci_dev_b to list_for_each_entry: drivers-pci-setup-bus.c
  o janitor: cpqarray remove unused include
  o janitor: remove old ifdefs dmascc
  o janitor: remove old ifdefs fasttimer
  o janitor: list_for_each: drivers-char-drm-radeon_mem.c
  o janitor: char/rio_linux: replace schedule_timeout() with
    msleep()/msleep_interruptible()
  o janitor: char/sis-agp: replace schedule_timeout() with msleep()
  o janitor: char/fdc-io: replace direct assignment with
    set_current_state()
  o janitor: char/ipmi_si_intf: add set_current_state()
  o janitor: char/sx: replace direct assignment with
    set_current_state()
  o drivers/char: replace schedule_timeout() with
    msleep_interruptible()
  o janitor: remove check_region from drivers/char/esp.c
  o janitor: mark __init/__exit static drivers/net/ppp_deflate
  o janitor: mark __init/__exit static drivers/net/bsd_comp
  o janitor: fix-typo-arm-dma arch/arm26/machine/dma.c
  o janitor: kill KERNEL_VERSION duplicate in videocodec.c
  o janitor: video/radeon_base: replace MS_TO_HZ() with
    msecs_to_jiffies()
  o janitor: video/radeonfb: remove MS_TO_HZ()
  o janitor: drivers/media: replace schedule_timeout() with msleep()
  o janitor: drivers/message: replace schedule_timeout() with
    msleep_interruptible()
  o drivers/md: replace schedule_timeout() with msleep_interruptible()
  o ieee1394: replace schedule_timeout() with msleep_interruptible()
  o janitor: replace dprintk with pr_debug in drivers/scsi/tpam/
  o janitor: isdn/icn: change units of ICN_BOOT_TIMEOUT1
  o drivers/isdn: replace milliseconds() with msecs_to_jiffies()
  o janitor: replace dprintk with pr_debug in microcode.c
  o janitor: __FUNCTION__ string concatenation deprecated
  o drivers: remove unused MOD_{DEC,INC}_USE_COUNT

Michael A. Halcrow:
  o BSD Secure Levels LSM: add time hooks
  o BSD Secure Levels LSM: core
  o BSD Secure Levels LSM: documentation

Michael Hunold:
  o DVB: update saa7146
  o DVB: documentation update
  o DVB: skystar2 dvb bt8xx update
  o DVB: core update
  o DVB: frontend conversion
  o DVB: frontend conversion #2
  o DVB: frontend conversion #3
  o DVB: frontend conversion #4
  o DVB: add frontend
  o DVB: add frontend #2
  o DVB: new driver for mobile USB Budget DVB-T devices
  o DVB: misc driver updates
  o DVB: frontend updates
  o V4L: follow changes in saa7146

Mike Miller:
  o cciss: SCSI API updates
  o cciss: fixes for clustering

Natalie Protasevich:
  o Incorrect PCI interrupt assignment on ES7000 for platform GSI

Neil Brown:
  o nfsd4: nfsd oopsed when encountering a conflict with a local lock
  o nfsd: separate a little of logic from fh_verify into new function
  o nfsd4: don't take i_sem around call to ->getxattr
  o nfsd: make sure getxattr inode op is non-NULL before calling it
  o nfsd4: reference count stateowners
  o nfsd4: take a reference to preserve stateowner through xdr replay
    code
  o nfsd4: revert awkward extension of state lock over xdr for replay
    encoding
  o nfsd4: fix race in xdr encoding of lock_denied response
  o nfsd: remove incorrect stateid modification in nfsv4 open upgrade
  o nfsd4: move open owner checks from nfsd4_process_open2 into new
    function
  o nfsd: set OPEN_RESULT_LOCKTYPE_POSIX in open()
  o nfsd4: move seqid decrement on reclaim to separate function
  o nfsd4: reorganize "if" in nfsd4_process_open2 to make test clearer
  o nfsd4: move open_upgrade code into a separate function
  o nfsd4: move some nfsd4_process_open2 code to nfs4_new_open
  o nfsd: clean up nfsd4_process_open2
  o nfsd4: fix putrootfh return
  o nfsd4: move code to truncate on open to separate function
  o md: convert %Lu to %llu in printk
  o lockd: remove hardcoded maximum NLM cookie length

Nick Piggin:
  o sched: trivial sched changes
  o sched: add CPU_DOWN_PREPARE notifier
  o sched: integrate cpu hotplug and sched domains
  o sched: sched add load balance flag
  o sched: remove disjoint NUMA domains setup
  o sched: IA64 add disjoint NUMA domain support
  o sched: fix domain debug for isolcpus
  o sched: enable SD_LOAD_BALANCE
  o sched: hotplug add a CPU_DOWN_FAILED notifier
  o sched: use CPU_DOWN_FAILED notifier
  o sched: fixes for ia64 domain setup
  o taint: fix forced rmmod
  o taint on bad_page

Nicolas Pitre:
  o smc91x: Revert 1.1923.3.58: "m32r: modify drivers/net/smc91x.c for
    m32r"
  o smc91x: Assorted minor cleanups
  o smc91x: set the MAC addr from the smc_enable function
  o smc91x: fold smc_setmulticast() into smc_set_multicast_list()
  o smc91x: simplify register bank usage
  o smc91x: move TX processing out of IRQ context entirely
  o smc91x: use a work queue to reconfigure the phy from  smc_timeout()
  o smc91x: fix possible leak of the skb waiting for mem  allocation
  o smc91x: display pertinent register values from the  timeout
    function
  o smc91x: straighten SMP locking
  o smc91x: cosmetics
  o smc91x: fix SMP lock usage
  o smc91x: more SMP locking fixes
  o smc91x: fix compilation with DMA on PXA2xx
  o smc91x: receives two bytes too many
  o smc91x: release on-chip RX packet memory ASAP
  o fix PXA270 compile errors

Nishanth Aravamudan:
  o i2c-algo-ite: remove iic_sleep()
  o i2c/i2c-mpc: replace schedule_timeout() with msleep_interruptible()
  o usb/file_storage: replace schedule_timeout() with
    msleep_interruptible()
  o usb/ati_remote: add set_current_state()
  o usb/kaweth: reorder set_current_state() and schedule_timeout()
  o usb/hid-core: add set_current_state() before schedule_timeout()
  o usb/mdc800: cleanup set_current_state() around wait queues
  o usb/uss720: replace schedule_timeout() with msleep_interruptible()
  o pci hotplug/shpchp: replace schedule_timeout() with
    msleep_interruptible()
  o pci hotplug/pciehp: replace schedule_timeout() with
    msleep_interruptible()
  o pci hotplug/cpqphp: replace schedule_timeout() with
    msleep_interruptible()
  o pci hotplug/cpqphp_ctrl: replace schedule_timeout() with
    msleep_interruptible()
  o net/mac89x0: replace schedule_timeout() with msleep_interruptible()
  o I2C: replace schedule_timeout() with msleep_interruptible() in
    i2c-ibm_iic.c
  o pmac_cpufreq msleep cleanup/fixes

Olaf Dabrunz:
  o TIOCCONS security

Olaf Hering:
  o mesh is ppc32-only
  o [NET]: Allow CONFIG_NET=n on ppc64
  o remove scsi ioctl from udf/lowlevel.c

Olaf Kirch:
  o [NETFILTER]: Don't export common symbols from ipfwadm.ko

Oleg Nesterov:
  o Fix show_trace() in irq context with CONFIG_4KSTACKS
  o fix nosmp & pcibios_fixup_irqs() interaction
  o detach_pid(): restore optimization
  o detach_pid(): eliminate one find_pid() call
  o copy_thread(): unneeded child_tid initialization

Oliver Neukum:
  o USB: update of help text for hpusbscsi
  o USB: switching microtek to usb_kill_urb
  o USB: correct interrupt interval for kaweth
  o USB: switching microtek to usb_kill_urb
  o USB: maintainership of acm cdc
  o USB: acm work around for misplaced
  o additional documentation for power management

Olof Johansson:
  o ppc64: fix CPU numa init code thinkos

Pablo Neira:
  o [NETFILTER]: Fix removing invalid proc file

Paolo 'Blaisorblade' Giarrusso:
  o uml: readd linux Makefile target
  o use container_of() for rb_entry()

Pat Gefre:
  o [IA64-SGI] Remove Altix I/O code (ready for re-org)
  o [IA64-SGI] Add in Altix I/O code
  o [IA64] qla1280.c Mod for Altix I/O add code
  o [IA64-SGI] Fix issue with gemini TIO systems
  o [IA64-SGI] Redundant BUG check
  o [IA64-SGI] Fix a possible memory leak
  o [IA64-SGI] make pci_root_ops non static
  o [IA64-SGI] BUG_ON test was backwards
  o [IA64-SGI] Fixes calling arg1 for bte_crb_error_handler()
  o [IA64] export sn_dma_mapping_error for libata
  o [IA64-SGI] Mod to allow functions other than zero to use virtual
    channel 1

Patrick McHardy:
  o [IPV6]: Fix netdevice/inet6_dev reference leaks in ip6_route_add
    error paths
  o [XFRM]: Apply policy checks to packets with a secpath when the
    policy list is empty
  o [PKT_SCHED]: Fix netem qlen accounting
  o [IPV4]: Fix inet6_dev reference leak in ndisc_dst_alloc error path

Patrick Mochel:
  o [driver model] Change symbol exports to GPL only in
    drivers/base/bus.c
  o [driver model] Change sybmols exports to GPL only in class.c
  o [driver model] Change symbol exports to GPL only in core.c
  o [driver model] Change symbol exports to GPL only in driver.c
  o [driver model] Change symbol exports to GPL only in firmware.c
  o [driver model] Change symbol exports to GPL only in platform.c
  o [driver model] Change symbol exports to GPL only in sys.c
  o [sysfs] Change symbol exports to GPL only in bin.c
  o [sysfs] Change symbol exports to GPL only in dir.c
  o [sysfs] Change symbol exports to GPL only in file.c
  o [sysfs] Change symbol exports to GPL only in group.c
  o [sysfs] Change symbol exports to GPL only in symlink.c
  o [driver core] Change symbol exports to GPL only in power/main.c
  o [driver core] Change symbol exports to GPL only in power/resume.c
  o [driver core] Change symbol exports to GPL only in power/suspend.c

Paul Fulghum:
  o ppp: terminate connection on hangup
  o ppp: disconnect on hangup (synctty)

Paul Jackson:
  o sched: make domain setup overridable

Paul Mackerras:
  o ppc32: fix cpu voltage change delay
  o ppc64: fix XICS startup function to enable as well
  o PPC64 remove __ioremap_explicit() error message
  o Fix PREEMPT_ACTIVE definition

Paul Mundt:
  o sh: SH73180 subtype support
  o sh: SH7705 subtype cleanup + 32k cache support
  o sh: Use asm-offsets
  o sh: consistent API cleanup
  o sh: defconfig updates
  o sh: DMA API updates
  o sh: SCBRR calculation fixes for early printk()
  o sh: EDOSK7705 board support
  o sh: SH-4 optimized memcpy()
  o sh: SH4-202 MicroDev board support
  o sh: cleanup + merge
  o sh: PCI updates
  o sh: oprofile support for SH7750/SH7750S
  o sh: Broken-out CPU subtype probing
  o sh: SE73180 board support
  o sh: CTP/PCI-SH03 board support
  o sh: sh-sci updates
  o sh: ST40 updates

Paulo Marques:
  o kallsyms data size reduction / lookup speedup

Pavel Machek:
  o USB Storage: Unusual_dev patch for Finepix 1300 and 1400's
  o acpi proc: error handling
  o swsusp: fix process start times after resume
  o swsusp: add comments at critical places
  o swsusp: Documentation update
  o __init poisoning for i386
  o Fix suspend/resume support in via-rhine2

Pekka Pietikäinen:
  o b44: use bounce buffers to workaround chip DMA bug/limitations

Pete Zaitcev:
  o USB: Fixes for ub in 2.4.9-rc1 from Oliver and Pat
  o USB: Patch for 3 ub bugs in 2.6.9-rc1-mm4
  o USB: Fixes for ub in 2.4.9-rc2-mm2
  o USB: fix oops with latest ub driver in -mm tree

Peter Osterlund:
  o DVD+RW support
  o packet-writing: add credits
  o CDRW packet writing support
  o cdrom: buffer sizing fix

Peter Williams:
  o CPU Scheduler: fix potential error in runqueue nr_uninterruptible
    count

Petko Manolov:
  o USB: small rtl8150 patch

Petr Vandrovec:
  o Remove big-endian mode from matroxfb
  o Assorted matroxfb fixes
  o Add VIDIOC_S_CTRL_OLD to matroxfb

Phil Dibowitz:
  o USB Storage: Remove unusual_dev entry for IBM Storage Key
  o USB Storage: Remove unusual_devs entries for Genesys Drives
  o USB Storage: Fix Kyocera order
  o USB Storage: unusual_dev modification

Phil Oester:
  o doc: scsihosts parameter no longer exists

Randy Dunlap:
  o i386/io_apic init section fixups
  o [NET]: Fix sprintf type warnings on 64-bit in pktgen.c
  o x86_64/io_apic init section fixups
  o [TG3]: tg3_nvram_read_using_eeprom cannot be __init
  o MTD: dilnetpc: use %p for ptr printk arg
  o saa7134: discarded reference
  o bt878: discarded reference
  o cx88: discarded reference

Robin Holt:
  o [IA64-SGI] Double spin_unlock in bte.c
  o [IA64-SGI] Correct BTE notification timeouts on SN2
  o [IA64-SGI] Distribute useage of BTE interfaces

Roger Luethi:
  o PCI: remove driver private PCI state, 1 arg for
    pci_{save,restore}_state

Roland Dreier:
  o kobject: add add_hotplug_env_var()
  o USB: use add_hotplug_env_var() in core/usb.c
  o ppc: fix build with O=$(output_dir)

Roland McGrath:
  o make rlimit settings per-process instead of per-thread
  o add WCONTINUED support to wait4 syscall
  o fix PTRACE_ATTACH race with real parent's wait calls
  o exec: fix posix-timers leak and pending signal loss
  o move struct k_itimer out of linux/sched.h

Rudolf Marek:
  o I2C: fix it8712 detection

Russell King:
  o [ARM] Convert system ticker timer to sysdev model
  o [ARM] Move OS timer suspend/resume from pm.c to time.c
  o [ARM] Separate out footbridge DC21285 and ISA timer implementations
  o [ARM] Fix Integrator timer implementation
  o [SERIAL] Add FCR setting to serial8250_config structure
  o [SERIAL] Convert TI16C750 flow control into a port capability
  o [SERIAL] Add comment about frobbing the 950's ACR on TX disable
  o [SERIAL] Clean up handling of LSR in receive function
  o [SERIAL] Add explaination why we don't use RTS flow control
  o [SERIAL] Make port autoprobing set up->capabilities
  o [SERIAL] Add new port registration/unregistration functions
  o [SERIAL] Convert 8250_pci to use new serial8250_register_port()
  o [SERIAL] Keep trying to register our console device
  o [ARM] Add netconsole support to ARM AM79C961A driver
  o [ARM] Convert to constant-optimising udelay() implementation
  o [ARM] Rehash iwmmxt signal handling
  o [ARM] Clean up footbridge configuration
  o [ARM] Move machine specific boot variables to separate makefile
  o [ARM] Fix missed udelay usage - assembly needs to call __udelay now
  o [ARM] Sanitise Footbridge machine class
  o [ARM] Add generic RTC implementation
  o [ARM] Add documentation for ARM kernel timer infrastructure
  o [SERIAL] serial_reg.h update
  o [ARM] Cleanup some quirks
  o [ARM] Export find_{first,next}_bit_{l,b}e
  o [ARM] Add seqlocking to timers

Rusty Russell:
  o module_param_array() should take a pointer

Ryan S. Arnold:
  o hvc_console fix to prevent oops and late hangup and write
    operations

Seth Rohit:
  o add sys_setaltroot()

Sreenivas Bagalkote:
  o megaraid 2.20.4: Fix a data corruption bug
  o remove config_compat from Megaraid

Stefan Weinhuber:
  o s390: z/VM log reader

Steffen Zieger:
  o USB: Codemercs IO-Warrior support

Stelian Pop:
  o A simple FIFO implementation

Stephan Fuhrmann:
  o USB Storage: unusual_devs patch for new tekom entry

Stephan Walter:
  o USB Storage: unusual_devs patch for winward music disk

Stephen C. Tweedie:
  o ext3 directio block leak fix

Stephen Hemminger:
  o b44: replace MODULE_PARM
  o b44: use netdev_priv
  o register_chrdev_region(), alloc_chrdev_region() const char
  o [NET]: dst: use const in accessors
  o [TCP]: use const in tcp.h
  o [NET]: Replace dst_release refcount error with standard WARN_ON

Stephen Rothwell:
  o ppc64: iSeries compile broken in 2.6.9-bk3

Suresh B. Siddha:
  o share i386/x86_64 intel cache descriptors table
  o Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 v2
  o no exec: i386 and x86_64 cleanups
  o [IA64] fallback to swiotlb for consistent DMA mappings

Thayne Harbaugh:
  o gen_init_cpio uses external file list

Thomas Gleixner:
  o Shared Reed-Solomon ECC library
  o Add DocBook documentation for MTD NAND drivers
  o MTD updates for __iomem
  o MTD char device access -- return data when ECC errors happen
  o MTD: M-Systems DiskOnChip translation layer (NFTL): fix unused
    variable
  o MTD: NAND flash driver updates

Thomas Graf:
  o [PKT_SCHED]: Replace tc_stats with new gnet_stats in struct Qdisc
  o [PKT_SCHED]: Use gnet_stats API to copy statistics into netlink
    message
  o [PKT_SCHED]: Introduce gen_replace_estimator
  o [PKT_SCHED]: Use generic rate estimator
  o [PKT_SCHED]: Qdisc are not supposed to dump TCA_STATS themselves
  o [PKT_SCHED]: CBQ; Destroy filters before destroying classes
  o [PKT_SCHED]: Requeues statistics
  o [PKT_SCHED]: Max TLV types cleanup
  o [PKT_SCHED]: Add dump_stats qdisc op
  o [PKT_SCHED]: CBQ: use dump_stats
  o [PKT_SCHED]: RED: use dump_stats
  o [PKT_SCHED]: Add dump_stats class op
  o [PKT_SCHED]: CBQ: Use gnet_stats for class statistics
  o [PKT_SCHED]: CBQ: Use dump_stats for class statistics dumping
  o [PKT_SCHED]: CBQ: Use generic rate estimator
  o [PKT_SCHED]: HTB: Use gnet_stats for class statistics
  o [PKT_SCHED]: HTB: Use dump_stats for class statistics dumping
  o [PKT_SCHED]: HTB: Remove unneeded rate estimator bits
  o [PKT_SCHED]: HTB: Use gnet_stats for class statistics
  o [PKT_SCHED]: HFSC: Use generic rate estimator
  o [PKT_SCHED]: HFSC: Use dump_stats for class statistics dumping
  o [PKT_SCHED]: ATM: Use gnet_stats for class statistics and dump them

Tom Rini:
  o sh: fix EMBEDDED_RAMDISK with O=
  o remove unused arch/sh/tools/machgen.sh

Tony Luck:
  o [IA64] Allow -mtune=merced for gcc 3.4
  o [IA64] uninitialised flags element could cause crashes

Ulrich Drepper:
  o Simplify last lib/idr.c change

Urban Widmark:
  o smbfs protocol fixes

Venkatesh Pallipadi:
  o S3 suspend/resume with noexec v2
  o Fix EDID_INFO in zero-page
  o x86[64]: display phys_proc_id only when it is initialized

Vernon Mauery:
  o PCI Hotplug: acpiphp extension fixes

Vladimir Grouzdev:
  o xtime value may become incorrect

Vojtech Pavlik:
  o USB: Fix oops in usblp driver

Werner Almesberger:
  o x86_64: no TIOCSBRK/TIOCCBRK in ia32 emulation

William A. Adamson:
  o nfs4 lease: add a lock manager copy lock callback
  o nfs4 lease: add a lock manager release private callback
  o nfs4 lease: add a lock manager break callback
  o nfs4 lease: aeparate the lease initialization code
  o nfs4 lease: move the f_delown processing
  o nfs4 lease: separate the lease processsing code
  o nfs4 lease: use the inode i_writecount
  o nfs4 lease: export setlease
  o nfs4 lease: export remove_lease
  o nfs4 lease: add the new lock manager callbacks to the documentation

William Lee Irwin III:
  o move waitqueue functions to kernel/wait.c
  o standardize bit waiting data type
  o consolidate bit waiting code patterns
  o eliminate bh waitqueue hashtable
  o eliminate inode waitqueue hashtable
  o move wait ops' contention case completely out of line
  o reduce number of parameters to __wait_on_bit() and
    __wait_on_bit_lock()
  o document wake_up_bit()'s requirement for preceding memory barriers
  o pidhashing: rewrite alloc_pidmap()
  o pidhashing: retain older vendor copyright
  o pidhashing: lower PID_MAX_LIMIT for 32-bit machines
  o pidhashing: enforce PID_MAX_LIMIT in sysctls
  o procfs: fix task_mmu.c text size reporting
  o make console_conditional_schedule() __sched and use cond_resched()
  o report per-process pagetable usage
  o profile: 512x Altix timer interrupt livelock fix
  o sparc32: early tick_ops
  o sparc32: add atomic_sub_and_test()
  o vm: introduce remap_pfn_range() to replace remap_page_range()
  o vm: convert references to remap_page_range() under arch/ and
    Documentation/ to remap_pfn_range()
  o vm: convert users of remap_page_range() under drivers/ and net/ to
    use remap_pfn_range()
  o vm: convert users of remap_page_range() under include/asm-*/ to use
    remap_pfn_range()
  o vm: convert users of remap_page_range() under sound/ to use
    remap_pfn_range()
  o PA-RISC io_remap_page_range() fix

Wim Van Sebroeck:
  o [WATCHDOG] s3c2410_wdt.c-wdog-fix5.patch
  o [WATCHDOG] v2.6.9-rc3 i8xx_tco.c-stop_reboot-patch

Wouter Van Hemel:
  o USB: usb audio is for oss only

Yasuyuki Kozakai:
  o [NETFILTER]: Fix multiple bugs in ip6rt.c
  o [NETFILTER]: Fix checks in ip6t_multiport.c
  o [NETFILTER]: Fix multiple bugs in ip6t_frag.c

Yoichi Yuasa:
  o mips: added missing definition and fixed typo
  o mips: fixed MIPS Makefile

Zwane Mwaikambo:
  o Allow multiple inputs in alternative_input
  o Update 'noapic' description

