Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUBGC3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUBGC3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:29:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:64221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264538AbUBGC2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:28:33 -0500
Date: Fri, 6 Feb 2004 18:28:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.3-rc1
Message-ID: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this is another big merge of a number of pending patches, although to 
some degree the patches have now moved "outwards" from the core, and most 
of them are in driver land.

There's a lot of network driver updates (have been in -mm and Jeff's 
testing trees for a while), and Al Viro has been fixing up not just 
network drivers, but also cursing over parport interfaces ;)

Andrew's patches are all over, from fixing warnings with new versions of
gcc to merging things like the ppc updates he had in his tree, and 
everything in between.

On and a big ALSA update, along with SCSI updates (big qla update, for
example).

So let's calm down and make sure all the updates are ok.

		Linus

-----

Summary of changes from v2.6.2 to v2.6.3-rc1
============================================

Alexander Viro:
  o lots of netdriver fixes: convert to alloc_etherdev, leak fixes
  o parport fixes (1-6)
  o paride cleanup and fixes (1-25)
  o scsi/imm.c cleanup and fixes (1-8)
  o scsi/ppa.c cleanup and fixes (1-9)

Andi Kleen:
  o put "kernel_thread_helper" in right linker segment

Andrew Morton:
  o [APPLETALK]: Do not use lvalue in assignment
  o [ATM]: Do not use lvalue in assignment
  o [X25]: Do not use lvalue in assignment
  o [DECNET]: Do not use lvalue in assignment
  o [ECONET]: Do not use lvalue in assignment
  o [IPV6]: Do not use lvalue in assignment
  o [IPX]: Do not use lvalue in assignment
  o [IRDA]: Do not use lvalue in assignment
  o [LLC]: Do not use lvalue in assignment
  o [AF_KEY]: Do not use lvalue in assignment
  o [NETROM]: Do not use lvalue in assignment
  o [ROSE]: Do not use lvalue in assignment
  o [SCTP]: Fix packed attribute usage
  o [TCP]: Un-inline tcp_put_port()
  o [TG3]: Do not use lvalue in assignment
  o libata warning fixes
  o gcc-35: drivers/net/wan/lmc
  o gcc-3.5: ne2k-pci.c
  o Fix race in sched_exit()
  o Eicon isdn driver flush_scheduled_work() fix
  o sn2: set iommu bounce limit
  o Fixes / Enhancements for PPC_GEN550
  o Make PPC601_SYNC_FIX depend on pmac||prep
  o Remove useless argument from __ste_allocate()
  o Allow PCI BARs that start at 0
  o quiet down SMP boot messages
  o VT locking fixes
  o lock_cpu_hotplug only if CONFIG_CPU_HOTPLUG
  o ia32 MSI vector handling fix
  o kbuild: Unmangle include options for gcc
  o sisfb update
  o Fix more gcc 3.4 warnings
  o string fixes for gcc 3.4
  o gcc-3.5: fix extern inline decls
  o gcc-3.5: #ident fixes
  o gcc-3.5: binfmt_elf warning fix
  o gcc-3.5: pcm_misc.c warnings
  o gcc-3.5: fix pcm_plugin warnings
  o gcc-3.5: reiserfs fixes
  o gcc-3.5: ide.h fixes
  o gcc-3.5: elevator.h fixes
  o gcc-3.5: keyboard.c fixes
  o gcc-3.5: _exit fix
  o Fix inlining failure (all GCCs) in parport
  o More 3.4 compilation fixes
  o gcc-3.5: sound/core/seq/seq_clientmgr.c
  o gcc-3.5: parport warnings
  o gcc-3.5: i810_accel fix
  o gcc-3.5: misc.c warning fix
  o gcc-3.5: fsfilter.h, ntfs.h
  o gcc-3.5: zatm.c fix
  o gcc-3.5: vxfs fixes
  o gcc-3.5: hfs fixes
  o gcc-3.5: drivers/atm/uPD98402.c
  o gcc-3.5: intermezzo
  o gcc-3.5: iphase.c
  o gcc-3.5: suni.c
  o gcc-3.5: drivers/atm/fore200e.c
  o gcc-3.5: ncpfs
  o gcc-3.5: drivers/atm/eni.c
  o gcc-3.5: drivers/atm/idt77105.c
  o gcc-3.5: drivers/atm/he.c
  o gcc-3.5: net/atm/common.c
  o gcc-3.5: drivers/i2c/chips/it87.c
  o gcc-3.5: radeon
  o gcc-3.5: drivers/ide/pci/sc1200.c
  o gcc-3.5: raid6
  o gcc-3.5: mtd
  o gcc-3.5: DVB
  o gcc-3.5: PCMCIA
  o gcc-3.5: video
  o gcc-3.5: pnpbios
  o gcc-3.5: drivers/scsi/53c700
  o gcc-3.5: advansys.c
  o gcc-3.5: atp870u.c
  o gcc-3.5: gdth.c
  o gcc-3.5: fbcon.c
  o gcc-3.5: drivers/video/riva/fbdev.c
  o gcc-3.5: drivers/video/cfbimgblt.c
  o gcc-3.5: drivers/video/vgastate.c
  o gcc-3.5: arch/i386/kernel/traps.c
  o x86-64 fixes for gcc 3.5
  o bitmap parsing/printing routines, version 4
  o i387: handle copy_from_user() error
  o printk_ratelimit() tweaks
  o add readX_relaxed() interface
  o Kconfig: use select statements
  o kconfig/wireless: Replace enable with select
  o use __attribute_const__ everywhere
  o EDD: read disk80 MBR signature, export through edd module
  o swsusp does not stop DMA properly during resume
  o Trivial cleanups for swsusp
  o Allow software_suspend to fail
  o vmalloc address offset fix
  o hugetlbfs directory entry cleanup
  o libfs mtime/ctime updates
  o hugetlbfs cleanup
  o check do_munmap() failure
  o missing `console_driver' with CONFIG_VT && !CONFIG_VT_CONSOLE
  o Make naming of parititions in sysfs match /proc/partitions
  o ppc32: Set HZ to 1000 on ppc32
  o fix blockdev --getro for sr, sd, ide-floppy
  o console: support for > 127 chars
  o remove valid_addr_bitmap
  o osst.c: suppress page allocation failure warnings
  o initialise cpu_vm_mask in init_mm
  o deprecate the raw driver
  o Fix deep stack usage in ncpfs
  o remove_suid() fix
  o md: Move the test in preferred_minor to where it is used
  o md: Fixes to make debuging output nicer
  o md: Collect device IO statistics for MD personalities
  o md: Change the way the name of an md device is printed in error
    messages
  o /proc/paritions: omit removable media
  o remove SIIG combo cards PCI ids from parport_pc
  o Remove memblks from the kernel
  o Clean up raid6 kbuild output
  o Better "Losing Ticks" Error Message
  o posix_timers fixes
  o Zero last byte of mount option page
  o futex: remove redundant test
  o janitor: change a few SYSRQ to MAGIC_SYSRQ
  o janitor: dz: verify_area() removal
  o janitor: sound/oss: use C99 inits
  o console cleanup
  o oprofile per-cpu buffer overrun
  o oprofile, typo in alpha driver
  o copy_namespace ENOMEM fix
  o janitor: vgastate: cleanup iounmap() usage
  o [janitor] vga16fb: add missing iounmap()
  o __d_path needs vfsmount_lock
  o namei.c: take vfsmount_lock
  o try reiserfs before other filesystems
  o UFS: honour `silent' parameter
  o Fine tune the time conversion to eliminate conversion errors
  o /proc/stat:btime fix
  o fix menuconfig choice item help display
  o u_int32_t causes cross-compile problems
  o ac97 OSS driver removal fix
  o is_subdir locking fix
  o proc_check_root() locking fix
  o ide-cd mo write protect
  o rate limit nr_free_pages
  o Use address hint in mmap for search
  o shrink_list(): check PageSwapCache() after add_to_swap()
  o as-iosched.txt update
  o enable fast symbol lookup via an inverted index in cscope
  o Lindent fixed to match reality
  o Move cpu_vm_mask to be closer to mmu_context_t in struct mm
  o PCI Scan all functions
  o CDROMREADAUDIO frames
  o Remove uneeded dentry assignment
  o missing export of cpu_2_node
  o Remove the unused kmalloc_percpu_init()
  o ppp: try harder to allocate the deflate buffer
  o fix compilation warnings in neofb.c
  o istallion compile fix
  o Moxa serial compile fixes
  o Specialix compile fix
  o Hisax compile fix
  o DVB compile fix
  o SElinux compile fix
  o fix memory leak while coredumping
  o Fix x86-64 boot problem
  o Altix update: various, mainly cleanups
  o Altix update: small cleanups
  o Altix update: misc changes
  o Altix update: add MINIMAL_ATE_FLAG
  o Altix update: io changes
  o Altix update: pcibr_invalidate_ate check
  o Altix update: early_probe_for_widget() improvement
  o Altix update: VGA, keyboard, other changes
  o Altix update: remove pcibr_intr_func()
  o Altix update: irq fixes
  o Altix update: pci_bus_cvlink.c fixes
  o Altix update: pci_bus_cvlink.c fixes
  o Fix ptrace in the vsyscall dso area
  o ppc64: move hypervisor console code into its own file
  o ppc64: fix up hvc console dev/devfs name, from Milton Miller
  o ppc64: Fix up iseries updatepp, from Ben Herrenschmidt
  o ppc64: change HSC -> HVSC
  o ppc64: Fix compiler warnings, from Olof Johansson
  o ppc64: Fixes for OF device tree update code, from Nathan Lynch
  o ppc64: integrate vio.c with 2.6 driver model
  o ppc64: Added definition of viomajortype_scsi, from Dave Boutcher
  o ppc64: Fix pcibios_scan_all_fns on iSeries, from Jake Moilanen
  o ppc64: use drivers/Kconfig
  o ppc64: Fix another numa bug
  o ppc64: use smp_processor_id everywhere
  o ppc64: Remove pvr from the paca
  o ppc64: cpus_in_xmon needs to be a cpumask_t, from Milton Miller
  o ppc64: sysrq helpers should have their active character capitalized
  o ppc32: Update PowerMac dmasound driver
  o ppc64: vio fix
  o ppc64: Add readq/writeq and __raw* IO functions
  o gcc-3.5: drivers/atm/atmtcp.c
  o snprintf() commentary
  o With size > XATTR_SIZE_MAX, getxattr(2) always returns E2BIG
  o oss/ad1889: correct printk of dma_addr_t
  o ext2/3: incorrect increment of i_blocks when keeping the same xattr
    block
  o Set CCISS driver VM read-ahead to 1024K
  o janitor: video/fbcmap: kmalloc() audit
  o janitor: ide/pci/triflex: handle !CONFIG_PROC_FS
  o janitor: ps2esdi: fix '&' to '&&'
  o janitor: vga16fb.c ioremap() and fb_alloc_cmap() audit
  o Suppress page allocation failures from sg_page_malloc()
  o Altix: remove alenlist.h
  o Altix: cleanup HWGRAPH_DEBUG
  o Moxa serial devfs fix
  o Improper handling of %c in vsscanf
  o meye: Fix dma_addr_t usage
  o v4l: i2c cleanups
  o v4l: saa7134 cleanups and new cards
  o Fix x86-64 compilation on 2.6.2-bk1
  o unexport do_exit()
  o fb.h header fix
  o epoll struct epitem size reduction
  o fix readX_relaxed machine vectors for ia64
  o memblks compile fixes
  o remove __exit from mptscsih_exit()
  o Add P1/P2 programmable keys to the sonypi driver
  o ext2: update inode ctime on rename()
  o [NETLINK]: Fix illegal lvalue with gcc-3.5
  o [AF_PACKET]: Fix illegal lvalue with gcc-3.5
  o [PPPOE]: Fix illegal lvalue with gcc-3.5
  o [NET]: Simply net_ratelimit()

Andrew Vasquez:
  o Updated qla2xxx driver

Angelo Dell'Aera:
  o [TCP]: Add tcp_westwood doc to ip-sysctl.txt

Bartlomiej Zolnierkiewicz:
  o fix 'cat /proc/ide/<cd|dvd>/identify' hang (CONFIG_IDE_TASKFILE=y)
  o remove dead CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
  o remove CONFIG_IDEDMA_PCI_WIP
  o remove unused ide_devices_t from ide.c and ide.h
  o ide-io.c: remove unused unplugged iops
  o remove unused __ide_dma_retune() and ide_hwif_t->ide_dma_retune
  o remove ide_dma_queued_* ops from ide_hwif_t

Benjamin Herrenschmidt:
  o [SUNGEM]: Add support for G5 PowerMAC plus PM fixes
  o ppc32: Update/cleanup low level POWER4 & G5 CPU support
  o Save and restore HID2 on 750FX CPUs when sleeping/resuming
  o Move pmac-specific PCI quirks to pmac_pci.c, update cardbus one for
    new TI controller, add some for fixing up ATA & SATA controllers
    (switch normal ATA to fully native mode and disable unused function
    on G5 K2 SATA)
  o Fix processing of Open Firmware PCI host bridge "ranges" property
  o On G5 machines, we remap the AGP port to bus number 0xf0. XFree
    contains a hack that is unfixable at the moment for getting the IO
    base which is hard coded to bus number 0 (AGP on earlier machines).
  o ppc32: export clear_user_page, some video-for-linux drivers need it
  o Add Samuel Rydth improved software CPU timebase synchronisation
    used on machines that don't have a HW facility (or we don't drive
    it yet like G5s)
  o ppc32: Cleanup PowerMac SMP support Add a fix fox machines that
    don't have HW timebase sync facility
  o ppc32: Fix smp_message_pass macro, turn into an inline function
  o ppc32: fix a possible race in pte_free() Another processor could be
    walking the page table in the middle of the PTE page to be freeded.
    Synchronize with hash_page using the lock.
  o ppc32: Flush the Hash PTE in ptep_test_and_clear_young() Without
    this, page aging is broken on ppc32
  o ppc32: Fix release_OF_resource() function
  o ppc32: Fix initialisation of the POWER4 / G5 MMU Hash table
    especially related to the use of the btext early debug text engine
  o ppc32: Fix parsing of Open Firmware interrupt tree on G5
  o ppc32: Update register definitions for Apple chipsets
  o ppc32: Fix PCI<->OF linkage for G5s AGP bus
  o ppc32: Rework nvram management
  o ppc32: Update PowerMac motherboard support add support for newer
    laptops and G5 desktops
  o ppc32: Update PowerMac i2c management
  o ppc32: Add support for PowerMac G5 HT/PCI & AGP busses
  o ppc32: Fix PowerMac SMP to work with G5s
  o ppc32: Fix time calibration on some G4 models
  o ppc32: PowerMac G5 interrupt management
  o ppc32: refcounting fix for of_device.c
  o ppc32: Fix a warning with some usages of udelay
  o ppc32: Add some PowerMac specific PCI IDs
  o ppc32: Update macio_asic, add some resource management
  o ppc32: Update the PowerMac 53c94 SCSI driver
  o ppc32: Update PowerMac "mesh" driver
  o ppc32: Update resource management of the PowerMac SCC driver
  o ppc32: Update the PowerMac "macio" IDE driver
  o ADB: Minor fix, autopoll list could be lost on a failed bus reset
  o ppc32: Update the PowerMac adbhid driver (ADB & laptop
    mouse/trackpad/keyboard)
  o ppc32: Update PowerMac mediabay driver
  o ppc32: Update PowerMac via-pmu driver
  o ppc32: Update PowerMac laptop backlight control core
  o ppc32: Use drivers/Kconfig and move some Mac stuffs to
    drivers/macintosh/Kconfig
  o ppc32: Bring back PowerMac swim3 floppy driver into working state
  o ppc32: Update PowerMac cpufreq driver
  o ppc32: Fix the mac mouse button emulation code
  o ppc32: Add thermal management drivers
  o bmac network driver update

Carl-Daniel Hailfinger:
  o [2.6] Update forcedeth to 0.23

Chas Williams:
  o [ATM]: [idt77252] fix dma_addr_t type error with
    CONFIG_HIGHMEM64G=y (by "Randy.Dunlap" <rddunlap@osdl.org>)
  o [ATM]: [clip] check return code from kmem_cache_create (by
    "Randy.Dunlap" <rddunlap@osdl.org>)

Daniele Bellucci:
  o [NETFILTER]: Make use of ipt_register_target() return values

David Dillow:
  o Support the new 3CR990B cards that require authentication of the
    runtime firmware image.

David S. Miller:
  o [TCP]: Put Alexey's -EAGAIN change back in with Linus's fix on top
  o [DECNET]: Fix filling in of header length field
  o [CREDITS]: Update Bjorn Ekwall's address
  o [SUNGEM]: Add K2_GMAC pci id to pci_ids.h
  o [TCP]: Kill bogus reference to CONFIG_TCP_WESTWOOD
  o [SPARC64}: Fix ultra-III and later support of new-style SILO
    booting
  o atmel_pci build fix

David Stevens:
  o [IPV4]: Add per-device sysctl to force IGMP version
  o [IPV4]: Fix IGMP device reference counting

Domen Puncer:
  o [NET]: In dev_seq_printf_stats(), kill extra comparison, make more
    readable

Douglas Gilbert:
  o sg driver update

François Romieu:
  o 2.6.0-test6 - more free_netdev() conversion

Harald Welte:
  o [NETFILTER]: Fix up copyright notices
  o [NETFILTER]: Update Changes file to reflect 2.6.x reality

Hideaki Yoshifuji:
  o [IPV6]: Use the cheaper ipv6_addr_any() for ipv6_addr_type() where
    possible
  o [IPV6]: Use the cheaper ipv6_addr_is_multicast() for
    ipv6_addr_type() where possible
  o [IPV6]: Fix reserved subnet anycast checking in
    __ipv6_regen_rndid()
  o [IPV6]: Fix dst leak in error path of ndisc_send_redirect()
  o [IPV6]: Make note in headers about shared socket option numbers
  o [IPV6]: Clean-up NS (including DAD) vs tentative address
  o [IPV6]: Unify 3 similar code paths in ndisc_recv_ns()
  o [IPV6]: Use cheaper ipv6_addr_any() where appropriate

Hirofumi Ogawa:
  o 8139too NAPI for net-drivers-2.5-exp
  o 8139too warning fix (1/2)
  o 8139too tx queue handling fix

James Bottomley:
  o aha152x request region fix
  o Fusion update to 3.00.02
  o Update qla2xxx to 8.00.00b9
  o qla2xxx - perform proper SNS scans with ISP2200 HBAs. [1/3]
  o qla2xxx - Remove unused GFT_ID code. [2/3]
  o qla2xxx - Use RIO mode 4 for ISP2100/ISP2200 operation. [3/3]
  o Fix mptfusion to compile without CONFIG_PM
  o qla2xxx: Resync with latest released firmware 3.02.21
  o scsi: scatter gather alignment constraints
  o SCSI: BusLogic update
  o SCSI: remove qlogicfc driver
  o SCSI: Remove AM53c974 driver
  o SCSI: remove mac_NCR5380 driver
  o minor mptfusion fix
  o scsi_mid_low_api.txt update to clarify queuecommand return values
  o use cramfs as an initrd

James Morris:
  o [CRYPTO]: Make padding[] array static in sha{256,512}_final()

James Simmons:
  o [FBDEV] Add syfs support

Jaroslav Kysela:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver
    Moved spdif.setup_rate to snd_ice1712_set_pro_rate() function
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver use the standard control names for RCA and optical spdif on
    audigy.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    fixed snd_ac97_set_rate() to accept surround and LFE sample rates,
    too.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver,AC97
    Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    fixes by James Courtier-Dutton <James@superbug.demon.co.uk>:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel
    Simplified snd_pcm_update_hw_ptr*() functions
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Timer Midlevel,ALSA
    sequencer Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core,Timer
    Midlevel,ALSA sequencer,PPC DACA driver PPC Tumbler driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,PCMCIA
    Kconfig
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
    removed a wrong entry for gigabyte mobos.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Sound Scape
    driver Chris Rankin <rankincj@yahoo.com> - use #define rather than
    value for the microcode size
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> OPL3,Raw OPL
    FM,ES1968 driver removed obsolete __SND_OSS_COMPAT__.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver Peter Zubaj <pzad@pobox.sk>:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Added mpu_port initialization from the kernel command line
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Generic
    drivers,MPU401 UART,ALSA Core,ALS100 driver,AZT2320 driver CMI8330
    driver,DT019x driver,ES18xx driver,OPL3SA2 driver Sound Galaxy
    driver,Sound Scape driver,AD1816A driver,AD1848 driver CS4231
    driver,CS4236+ driver,PC98(CS423x) driver,ES1688 driver GUS Classic
    driver,GUS Extreme driver,GUS MAX driver AMD InterWave
    driver,Opti9xx drivers,ES968 driver,SB16/AWE driver SB8
    driver,Wavefront drivers,CMIPCI driver,VIA82xx driver,YMFPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,SB
    drivers,YMFPCI driver,ALS4000 driver,AZT3328 driver CMIPCI
    driver,ENS1370/1+ driver,ES1968 driver,Intel8x0 driver VIA82xx
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS4281 driver,RME32
    driver,RME96 driver,CS46xx driver,NM256 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    added ALC655 entry (compatible with ALC650).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Maestro3 driver
    don't enable MPU401 irq.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS emulation
    added fallback device selection for OSS mixer.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0
    driver,VIA82xx driver,AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    fixed typo in the last AD198x fix.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver added
    the DXS whitelist for twinhead mobo.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Timer Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel don't
    call kfree with NULL pointer (constraint rules is not always
    allocated).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Timer Midlevel fixed
    the unbalanced spinlock at the error path.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation minor
    corrections for the recent updates.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel removed
    the export of snd_pcm_lock().  replaced with the normal mutex.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> HWDEP Midlevel allow
    dsp_load callback without dsp_status callback.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver Zinx
    Verituse <zinx@epicsol.org>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ALS4000 driver,ENS1370/1+ driver,YMFPCI driver added
    auto-detection of joystick port.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    Ted.Wen@ite.com.tw:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS46xx driver fixed
    the 4channel mode of another CS429x codec (0x592b).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> YMFPCI driver fixed
    the auto-detection of joystick port.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ALS4000 driver,AZT3328 driver,CMIPCI driver
    ENS1370/1+ driver,VIA82xx driver,YMFPCI driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AD1848 driver
    Robert Harris <robert.f.harris@blueyonder.co.uk> Fixed spinlocks
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Fixed read for partial OSS period buffer contents
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,ALSA
    Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> OSS device
    core,Documentation,ALSA Core,ALSA<-OSS emulation ALSA<-OSS
    sequencer,ALSA Minor Numbers Rusty Russell <rusty@rustcorp.com.au>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core,ALS100
    driver,AZT2320 driver,DT019x driver,CS4231 driver CS4236+
    driver,PC98(CS423x) driver,Opti9xx drivers,SB16/AWE driver
    Wavefront drivers use the standard port address, 0 = disable, 1 =
    auto-probe, others manual.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> OSS device core,ALSA
    Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Opti9xx drivers
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> OPL4 Clemens
    Ladisch <clemens@ladisch.de> use vmalloc instead of kmalloc for
    temp buffer in proc read()/write()
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Clemens Ladisch <clemens@ladisch.de> new controls for
    AD1981A/B/1980/1985
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver added
    the quirk for ASUS A7V600.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Fixed cut & paste bug
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> OPL4 Clemens
    Ladisch <clemens@ladisch.de>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Fixed semantics in snd_pcm_oss_bytes() function.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver Peter Zubaj <pzad@pobox.sk>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CMIPCI driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Added IC Ensemble/KS Waves ID for stereo enhancement
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS4236+ driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> I2C lib core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> GUS Library Fixed
    duplicate control IDs (PCM Playback Volume) for cards with the
    codec chip
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> GUS Library
    Omited to remove old code
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> YMFPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,Memalloc module,ALS4000 driver,AZT3328 driver ES1938
    driver,ES1968 driver,Maestro3 driver,SonicVibes driver ALI5451
    driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver Trident
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    fix by Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel,ALSA
    Core,USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX Pocket
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AMD InterWave driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS emulation
    fixed the calculation of bytes.  this will fix GETxSPACE, GETxPTR,
    GETODELAY ioctls.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS emulation
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> VIA82xx driver
    Added EPoX EP-8K9A default settings (VIA_DXS_ENABLE)
  o ALSA CVS update - version 1.0.0pre3
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> YMFPCI driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> YMFPCI driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Control
    Midlevel,ALSA Core,EMU8000 driver,SB16/AWE driver EMU10K1/EMU10K2
    driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> HWDEP
    Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel,Timer Midlevel
    Digigram VX core,L3 drivers,AC97 Codec Core,CS46xx driver Trident
    driver,YMFPCI driver,GUS Library,SB16/AWE driver,CMIPCI driver
    CS4281 driver,ENS1370/1+ driver,FM801 driver,Intel8x0 driver
    Maestro3 driver,RME32 driver,RME96 driver,SonicVibes driver VIA82xx
    driver,AK4531 codec,ALI5451 driver,EMU10K1/EMU10K2 driver ICE1712
    driver,ICE1724 driver,KORG1212 driver,NM256 driver RME HDSP
    driver,RME9652 driver,USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ES1968 driver,AC97
    Codec Core fixed the compilation with the recent ac97 and info
    changes.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP driver
    Thomas Charbonnel <thomas@undata.org>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP driver
    Thomas Charbonnel <thomas@undata.org>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP driver
    Thomas Charbonnel <thomas@undata.org>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712
    driver,ICE1724 driver Apostolos Dimitromanolakis
    <apostolos@aei.ca>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver
    removed unnecessary codes, which causes compilation error with
    gcc-2.9.x.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec
    Core,Intel8x0 driver Moved AC97 slot allocation from intel8x0 to
    ac97_pcm.c.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec
    Core,Intel8x0 driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Clemens Ladisch <clemens@ladisch.de> fix compiler warnings
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP driver fix
    by Thomas Charbonnel <thomas@undata.org>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver fixes
    by Apostolos Dimitromanolakis <apostolos@aei.ca>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Fixed AC97 slot allocation for 2nd+ PCM in assign function
  o ALSA 1.0.0rc1
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS emulation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Generic drivers
    Steve deRosier <derosier@pianodisc.com>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec
    Core,Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Commented out debugging printk
  o ALSA version 1.0.0rc2
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> EMU10K1/EMU10K2
    driver <pzad@pobox.sk> Center is initialized to analog to prevent
    noise at startup (SB Live)
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AMD InterWave
    driver Fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Timer Midlevel An
    attempt to fix the system timer behaviour (lost jiffy ticks)
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Clemens Ladisch <clemens@ladisch.de> deactivate_urbs didn't
    return the number of still-active URBs when not unlinking
    asynchronously, which would prevent calling wait_clear_urbs when
    some URBs actually are being unlinked asynchronously, so these URBs
    would be freed while still in use.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> RME9652 driver
    Removed duplicated ADAT3 Sync control
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Control Midlevel
    Added snd_ctl_find_hole() function.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> GUS Library Fixed
    race - scheduling in interrupt
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA sequencer
    Fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core A try
    to fix get_id() function - use alloc_bootmem()
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Documentation
    Added read_size comment for snd_info_set_text_ops()
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core petter
    wahlman <petter.wahlman@chello.no> vsnprintf does not copy more
    than 'size' bytes _including_ '\0'
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver
    DFS bit must be handled also for Delta1010 and Delta2496
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
    Documentation,ALSA<-OSS emulation
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> VIA82xx driver
    Added Easy Note 3171, Packard Bell - VIA_DXS_ENABLE
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Documentation
    More complete PCM device example
  o ALSA 1.0.1
  o ALSA - added missing module_init and module_exit functions to
    cs8427 and ak4xxx modules
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> EMU10K1/EMU10K2
    driver Georgi Georgiev <chutz@gg3.net> Line2 LiveDrive Capture
    Volume control fix
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,CMIPCI
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA sequencer
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CMIPCI driver
    Fixed joystick->joystick_port for __setup()
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    Sasha Khapyorsky <sashak@smlink.com>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SB16/AWE driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Tumbler driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ENS1370/1+ driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver fix
    by Timo Hirvonen <tihirvon@ee.oulu.fi> (modified by tiwai):
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Generic
    drivers,MPU401 UART,OPL3,OPL4,ES18xx driver,OPL3SA2 driver Sound
    Galaxy driver,Sound Scape driver,AD1816A driver,AD1848 driver
    CS4231 driver,ES1688 driver,GUS Library,AMD InterWave driver
    Opti9xx drivers,EMU8000 driver,SB drivers
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SB16/AWE driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver,EMU8000 driver,Common EMU synth,SoundFont
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module,PCM
    Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CMIPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,EMU10K1/EMU10K2 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,Memalloc module,ALS4000 driver,AZT3328 driver ES1938
    driver,ES1968 driver,Maestro3 driver,SonicVibes driver ALI5451
    driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver Trident
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Show proper ID for Creative Sound Blaster MP3+
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel,ALSA
    Core Added SNDRV_PCM_STATE_DISCONNECTED state.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Trident driver
    Fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel
    fixed oops when device was not opened (usual situation ;-))
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Fixed filling of the end silence - playback (in sync
    function)
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Clemens Ladisch <clemens@ladisch.de> add support for Edirol
    UM-1SX
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Clemens Ladisch <clemens@ladisch.de>
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core,ALS100
    driver,AZT2320 driver,CMI8330 driver,DT019x driver ES18xx
    driver,OPL3SA2 driver,Sound Scape driver,AD1816A driver CS4236+
    driver,AMD InterWave driver,Opti9xx drivers,ES968 driver SB16/AWE
    driver,Wavefront drivers,ALS4000 driver,AZT3328 driver CMIPCI
    driver,CS4281 driver,ENS1370/1+ driver,ES1938 driver ES1968
    driver,FM801 driver,Intel8x0 driver,Maestro3 driver,RME32 driver
    RME96 driver,SonicVibes driver,VIA82xx driver,CS46xx driver
    EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212
    driver NM256 driver,RME HDSP driver,RME9652 driver,Trident driver
    Digigram VX222 driver,YMFPCI driver,USB generic driver
  o ALSA - updated date identification
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Added more generic entries for Intel hardware (follows 0.9.1adi
    driver)
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Follow 0.9.1 ADI driver (mic in 3.75V, no High-Z mode, remove
    patch_ad1881() cal for 1985 - we have already 6 DACs
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core,Common EMU
    synth,SoundFont,EMU8000 driver EMU10K1/EMU10K2 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core,IGNORE
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SB16/AWE driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Control
    Midlevel,IOCTL32 emulation,ALSA<-OSS emulation EMU10K1/EMU10K2
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,ALS100
    driver,AZT2320 driver,DT019x driver,ES18xx driver AD1816A
    driver,CS4231 driver,CS4236+ driver,ES1688 driver Opti9xx
    drivers,SB16/AWE driver,ALS4000 driver,ES1938 driver FM801
    driver,SonicVibes driver,Trident driver,YMFPCI driver Clemens
    Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP driver
    Martin Bjoernsen:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel
    Change -EINVAL to -EALREADY in snd_pcm_unlink()
  o ALSA 1.0.2 + added missing file (emux_hwdep.c) ommited due merge
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Fixed typo
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> VIA82xx driver
    Removed duplicated code
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core
    Cosmetic change
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Serial BUS
    drivers,TEA575x tuner,PCI drivers,FM801 driver Added module for
    TEA575x radio tuners used in cheap FM801 based soundcards from
    Media Forte.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Documentation,PCI
    drivers,BT87x driver Moved bt87x driver from alsa-driver to
    alsa-kernel
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> TEA575x tuner
    TEA575x code is now 2.6 videodev compatible
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCI drivers Fixed
    condition for TEA575x && FM801
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> FM801 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core Added
    CONFIG_SND_BT87X dependencies
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AMD InterWave
    driver Ok, InterWave STB without TEA6330T without TEA6330T also
    exists
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> RawMidi Midlevel
    copy_*_user() function cannot be called from spinlock context
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1724 driver Davy
    Wentzler <info@audio-evolution.co>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ES1688 driver
    Fixed mpu401 port validation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS emulation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec
    Core,Intel8x0 driver,VIA82xx driver Add AC97 quick manual override
    module parameter.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,Intel8x0 driver,VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ICE1712 driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CS46xx driver
    added missing variables to debug messages
  o ALSA 1.0.2c
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Fixed alsa_card_intel8x0_setup()
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Andrew Morton <akpm@osdl.org>

Javier Achirica:
  o [wireless airo] Add support for mini-pci based cards

Jean-Luc Cooke:
  o [CRYPTO]: Help gcc optimize sha256/sha512 better

Jeff Garzik:
  o [netdrvr tulip] support NAPI
  o [netdrvr 3c515] fix non-modular build
  o [netdrvr tc35815] many fixes, major and minor
  o [netdrvr tc35815] switch to using alloc_etherdev
  o [netdrvr tulip] clean up tulip NAPI poll disable
  o [netdrvr] remove Documentation/networking/8139too.txt
  o [netdrvr] remove init_etherdev mentions in Doc/SubmittingPatches,
    atari_pamsnet.c
  o [netdrvr sk98lin 1/2] Remove CVS substitution keywords/spam
  o [netdrvr sk98lin 2/2] Remove CVS substitution keywords/spam
  o [hamradio mkiss] correctly use spinlocks

Jeroen Vreeken:
  o hamradio driver fixes

Jürgen E. Fischer:
  o aha152x

Kai Mäkisara:
  o SCSI tape cdev fixes for 2.6.2-rc1

Keith M. Wesolowski:
  o [SPARC32]: Fix sparc32 module support

Krishna Kumar:
  o [netdrvr 8139too] support netif_msg_* interface
  o [XFRM]: Do not schedule() when MSG_DONTWAIT

Linus Torvalds:
  o Linux 2.6.3-rc1

Matthew Wilcox:
  o Handle an old acenic card
  o adjust_resource()
  o PA-RISC arch update for 2.6.2
  o PA-RISC driver update for 2.6.2

Mike Anderson:
  o media change check fails for busy unplugged device

Patrick Caulfield:
  o [DECNET]: Made SDF_WILD sockets actually work
  o [DECNET]: Fix double rcu_read_unlock() in dn_rt_cache_seq_stop()

Patrick Mansfield:
  o fix badness in scsi_single_lun_run
  o change scsi_cmd_ioctl to take a gendisk instead of a queue
  o add scsi_cmd_ioctl (SG_IO) support for st

Patrick McHardy:
  o [NET_SCHED]: Add HFSC packet scheduler

Petri Koistinen:
  o [NET]: Bunch of Kconfig and doc URL updates

Randy Dunlap:
  o [netdrvr] remove unnecessary type casting
  o aha1542: queuecommand: change panic() to return
  o aha1542: add kmalloc type
  o fix sym53c8xx_2 doc. location
  o yellowfin: correct printk of dma_addr_t
  o sundance: correct printk of dma_addr_t

Russell King:
  o [ARM] Fix use of #if - should be #ifdef
  o [ARM] Remove extraneous return statement
  o [ARM] Add fusion, I2C and L3 directories to the ARM Kconfig
  o [ARM] Add .data.nosave section into vmlinux.lds.S file
  o [ARM] Convert Integrator AP and Assabet to new machine init method
  o [ARM] Update AMBA device/driver support
  o [ARM] Add cm_control() for Integrator AP and PP2 platforms
  o [ARM] Add Integrator/CP platform support
  o [ARM] Add platform device and resources for SMC91C96 devices
  o [ARM] Add sys_pciconfig_* syscalls

Rusty Russell:
  o [NETFILTER]: Fix locking in ip_conntrack

Scott Feldman:
  o [e1000] add ethtool ring param support
  o [e1000] use pdev->irq rather than netdev->irq for
  o [e1000] loopback diag test failing on big-endian
  o [e1000] use unsigned long for I/O base addr
  o [e1000] 82547 interrupt assert/de-assert re-ordering
  o [e1000] print message if user overrides default ITR
  o [e1000] improve Tx flush method
  o [e1000] exit polling loop if interface is brought down
  o [e1000] Internal SERDES link detect; delay after SPI
  o [e100] missed a kfree -> free_netdev
  o [netdrvr e1000] h/w workarounds + remove device ID
  o [netdrvr e1000] netpoll support
  o [netdrvr e1000] back out CSA interrupt fix
  o [netdrvr e1000] Serial-over-LAN (SoL) fix
  o [netdrvr e1000] tx_lock
  o [netdrvr e1000] Allow 1000/Full setting for Autoneg param
  o [netdrvr e1000] Misc - copyright, changelog spelling
  o [netdrvr e1000] on-demand stats support
  o [netdrvr e1000] 82547 interrupt assert/de-assert re-ordering

Shmulik Hen:
  o [IPV4]: Split arp_send into arp_create and arp_xmit, export them
  o [VLAN]: Export VLAN tag get/set functionality
  o [VLAN]: Use VLAN tag set functionality in 8021q module

Simon Kelley:
  o [wireless atmel] update

Stephen C. Tweedie:
  o Fix block device inode list corruptions

Stephen Hemminger:
  o wan/lmc -- convert to new network device model
  o remove dev_get from wanrouter
  o (1/12) Probe2 infrastructure for 2.6 experimental
  o (2/12) Probe2 -- de620
  o (03/12) Probe2 -- ni65
  o (04/12) Probe2 -- ni52
  o (05/12) Probe2 -- ni5010
  o (06/12) Probe2 -- sk16
  o (07/12) Probe2 -- 3c505
  o (08/12) Probe2 -- 3c507
  o (09/12) Probe2 -- arlan
  o (10/12) Probe2 -- wavelan
  o (11/12) Probe2 -- 3c501
  o (12/12) Probe2 -- 82596
  o (1/6) tokenring probing change
  o (2/6) smctr -- probe2
  o (3/6) proteon -- probe2
  o (4/6) skisa -- probe2
  o typo in net-drivers-2.5-exp 3c507
  o arlan new probe code needs to register
  o sk_g16 missing declaration
  o (1/42) ewrk3
  o (2/42) eepro
  o (3/42) eexpress
  o (4/42) eth16i
  o (5/42) fmv18
  o (6/42) at1700
  o (7/42) cs89x0
  o (8/42) at1500
  o (9/42) seeq8005
  o (10/42) smc
  o (11/42) lance
  o (12/42) ne
  o (13/42) e2100
  o (14/42) hpplus
  o (15/42) hp
  o (16/42) 3c503
  o (17/42) wd
  o (18/42) ultra
  o (19/42) 3c515-T10
  o (20/42) hp100-T10
  o (21/42) sk_mca
  o (22/42) 3c527
  o (23/42) 3c523
  o (24/42) ne2
  o (25/42) lne390
  o (26/42) es3210
  o (27/42) ac3200
  o (28/42) ultra32
  o (29/42) bagetlance
  o (30/42) jazzsonic
  o (31/42) mac89x0
  o (32/42) mac8390
  o (33/42) macsonic
  o (34/42) mac_mace
  o (35/42) mvme147
  o (36/42) hplance
  o (37/42) pamsnet
  o (38/42) bionet
  o (39/42) apne
  o (40/42) sun3_82586
  o (41/42) sun3_lance
  o (42/42) atari_lance
  o 8139too NAPI for net-drivers-2.5-exp
  o (1/3) 8139too -- put back old assert
  o (2/3) 8139too -- configurable receive ring
  o (3/3) 8139too -- poll_controller
  o [TCP]: Port 2.4.x version of TCP Westwood support to 2.6.x
  o [NET]: Move dev_base and dev_base_lock into net/core/dev.c
  o [NET]: Hash netdevices by name for faster lookup
  o [NET]: Hash netdevices by ifindex for faster lookup
  o [NET]: Support for lots of netdevs -- faster dev_alloc_name

Xose Vazquez Perez:
  o more RTL-8139 clone boards

Yoshinori Sato:
  o H8/300 support update (1/3): obsolete header
  o H8/300 support update (2/3): compiler warnings
  o H8/300 support update (3/3): bitops

