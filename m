Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbUCPFwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCPFwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:52:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:27265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262806AbUCPFwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:52:11 -0500
Date: Mon, 15 Mar 2004 21:58:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.5-rc1
Message-ID: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the current set of patches I've merged from various poeple..

Merging from Andrew, but also i2c updates, ALSA CVS merge, netconsole,
prism54 driver merge, sata updates, carmel driver, pcmcia and nfs client
updates..

And a few architectures updated: ia64, ppc32, sparc32, arm.

		Linus

----

Summary of changes from v2.6.4 to v2.6.5-rc1
============================================

<aurelien:aurel32.net>:
  o I2C: New chip driver: ds1621

<bunk:de.rmk.(none)>:
  o [SERIAL] serialP.h: remove a kernel 2.2 #ifdef

<clemy:clemy.org>:
  o I2C: add w83627hf driver

<colin:gibbsonline.net>:
  o [NET_SCHED]: Use time_after, fixes htb on 64-bit arch

<dave.jiang:intel.com>:
  o I2C: IOP3xx i2c driver update

<edwardsg:sgi.com>:
  o ia64: fix missing include in include/asm-ia64/sn/router.h

<jonas.larsson:net.rmk.(none)>:
  o [ARM PATCH] 1753/1: Devfs support for the 21285 serial driver - try
    2

<komoriya:paken.org>:
  o I2C: it87 reset option

<paul:wagland.net>:
  o Set module owner in megaraid driver

<perrye:linuxmail.org>:
  o I2C:  i2c-voodoo3.c needs I2C_ADAP_CLASS_TV_ANALOG

<sryoungs:au.rmk.(none)>:
  o [SERIAL] Add alias for TTY_MAJOR character device

<tim:cambrant.com>:
  o [VLAN]: Use array for static const char 'fmt'

Adrian Bunk:
  o I2C: update I2C help text

Alex Williamson:
  o ia64: minor 2.6 sba_iommu update

Andi Kleen:
  o netpoll for 3c59x
  o netpoll for tulip
  o netpoll for amd8111e
  o Netpoll for pcnet32
  o fix tg3 netpoll
  o netpoll for eepro100
  o x86-64 merge for 2.6.4
  o Fix a 64bit bug in kobject module request
  o Fix CONFIG_DEBUG build on x86-64 & small cleanup

Andreas Schwab:
  o ia64: Fix staircase effect on Altix serial console

Andrew Morton:
  o fix netpoll printk bug
  o netconsole warning fix
  o eepro100.c warning fix
  o ini9100u build fix
  o gcc-3.5: acpi build fix
  o print kernel version in oops messages
  o ppc64: fix initialisation of NUMA arrays
  o Clean up sys_ioperm stubs
  o readdir() cleanups
  o adaptive lazy readahead
  o read-only support for UFS2
  o fb_console_init fix
  o time interpolator fix
  o teach /proc/kmsg about O_NONBLOCK
  o remove __io_virt_debug
  o genrtc: cleanups
  o i386 very early memory detection cleanup patch
  o Allow X86_MCE_NONFATAL to be a module
  o dm: endio method
  o dm: list_for_each_entry audit
  o dm: default queue limits
  o dm: list targets cmd
  o dm: stripe width fix
  o selinux: clean up binary mount data
  o UDF filesystem update
  o kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile
  o NUMA-aware zonelist builder
  o Redundant unplug_timer deletion
  o compiler.h scoping fixes
  o Fix elf mapping of the zero page
  o kbuild: Cause `make clean' to remove more files
  o LOOP_CHANGE_FD ioctl
  o loop setup race fix
  o kbuild: fix usage with directories containing '.o'
  o Remove unneeded unlock in ipc/sem.c
  o /proc data corruption check
  o Enable i810 fb on x86-64
  o Remove arbitrary #acl entries limits on ext[23] when reading
  o watchdog: moduleparam-patches
  o AMD ELAN Kconfig fix
  o fadvise(POSIX_FADV_DONTNEED) fixups
  o Fix and harden validate_mm
  o current_is_keventd() speedup
  o Fix rootfs on ramdisk
  o Fix reading the last block on a bdev
  o wavfront.c needs syscalls.h
  o EDD: Get Legacy Parameters
  o cciss: init section fix
  o add nowarn to a few pte chain allocators
  o Disable Macintosh device drivers for all but PPC || MAC
  o Applicom warning
  o Fix CONFIG_NVRAM dependencies
  o fix raid0 readahead size
  o Fix NULL pointer dereference in blkmtd.c
  o fbdev: monitor detection fixes
  o m68k: __test_and_set_bit()
  o m68k: Amiga Framemaster II fb sysfsification
  o Apollo fb sysfsification
  o m68k: Macintosh IDE fixes
  o m68k: interrupt management cleanups
  o Add barriers to avoid race in mempool_alloc/free
  o synclinkmp.c update
  o synclink_cs.c update
  o synclink.c update
  o vm: per-zone vmscan instrumentation
  o return remaining jiffies from blk_congestion_wait()
  o Narrow blk_congestion_wait races
  o mm/vmscan.c: remove unused priority argument
  o kswapd throttling fixes
  o vmscan: preserve page referenced info in refill_inactive()
  o shrink_slab: math precision fix
  o vm: shrink slab evenly in try_to_free_pages()
  o vmscan: fix calculation of number of pages scanned
  o vm: scan slab in response to highmem scanning
  o vmscan: zone balancing fix
  o vmscan: drive everything via nr_to_scan
  o Balance inter-zone scan rates
  o vmscan: avoid bogus throttling
  o kswapd: avoid unnecessary reclaiming from higher zones
  o kswapd: fix lumpy page reclaim
  o fix the kswapd zone scanning algorithm
  o vmscan: less throttling of page allocators and kswapd
  o vmscan: batch up inactive list scanning work
  o fix vm-batch-inactive-scanning.patch
  o vm: balance inactive zone refill rates
  o vmscan: add lru_to_page() helper
  o slab: avoid higher-order allocations
  o ppc64: fix NUMA compile with large cpumasks
  o Use 64-bit counters for scheduler stats
  o Manfred's patch to distribute boot allocations across nodes
  o further __KERNEL_SYSCALLS__ removal
  o use wait_task_inactive() in kthread_bind()
  o md: use "shedule_timeout()" instead of yield()
  o md: allow assembling of partitioned arrays at boot time
  o Work around an AMD768MPX erratum
  o DMA: Fill gaping hole in DMA API interfaces
  o module unload deadlock fix
  o gcc-3.5 libata build fix
  o move consistent_dma_mask to the generic device
  o s390: update for altered page_state structure
  o __kill_pg_info() return value fix
  o cdev: warning fix
  o generic 32 bit emulation for System-V IPC

Angelo Dell'Aera:
  o [TCP]: Clean up some westwood comments

Anton Blanchard:
  o fix ppc64 in kernel syscalls

Aristeu Sergio Rozanski Filho:
  o qlogicfas: use a static string as name
  o qlogic_cs: don't release region
  o qlogic_cs: use a static string as name
  o qlogic_cs: use scsi_host_put
  o qlogicfas: force can_queue
  o qlogic_cs: use own detect and release functions
  o qlogic_cs: don't call qlogic_release on fail
  o qlogicfas: kill QL_USE_IRQ
  o qlogicfas: use qlogicfas_name instead qinfo
  o qlogicfas: begin to convert qlogicfas to new driver
  o qlogicfas: disable irqs on exit
  o qlogicfas: support multiple cards
  o qlogicfas: move common definitions to qlogicfas.h
  o qlogicfas: finish to convert to new scsi driver
  o qlogic_cs: use own MODULE_ macros

Arjan van de Ven:
  o xirc2ps ethtool fix

Bartlomiej Zolnierkiewicz:
  o update for pdc202xx_new driver
  o ide-disk.c: cleanup get_command()
  o remove ide_cmd_type_parser() logic
  o remove IDE_*_OFFSET_HOB and IDE_*_REG_HOB defines
  o remove ide_init_drive_taskfile()
  o piix_ide_init() can be __init

Benjamin Herrenschmidt:
  o G5 temperature control update
  o ppc32: Fix G5 config space access lockup

Bjorn Helgaas:
  o [SERIAL] fix PCI interrupt setting for ia64

Brian King:
  o SCSI: Recognize device type 0x0C
  o SCSI Midlayer initiated START_UNIT

Chas Williams:
  o [ATM]: [suni] dev_data should really be phy_data

Chris Wright:
  o Patch to hook up PPP to simple class sysfs support
  o class_simple clean up in lp
  o class_simple cleanup in input
  o class_simple cleanup in misc
  o class_simple cleanup in sg

Christoph Hellwig:
  o ia64: simserial module refcounting update

Dave Jones:
  o sort SCSI blacklist
  o USB 6-in-1 card reader blacklist addition
  o Remove unneeded cast
  o Whitespace fixes
  o Fix sysfs leak

David Mosberger:
  o ia64: Move irq_enter()/irq_exit() from hardirq.h to irq_ia64.c. 
    The work done by these routines is very special and needs to be
    done at exactly the right time.  Removing it from the header-file
    reduces the risk of accidental misuse.  Other arch maintainers
    agree that this is the Right Thing to do.
  o ia64: Rename ia64_invoke_kernel_thread_helper() to
    start_kernel_thread() for symmetry with start_kernel() and to make
    it obvious when the end of the call-chain has been reached.
  o ia64: More SAL cleanups/fixes
  o ia64: Reserve 3 syscall numbers for Andi Kleen's NUMA interface
  o ia64: fix preempt bug in IA32 subsystem

David S. Miller:
  o [IPV6]: Kill unused warnings in addrconf.c
  o [SOUND]: Fix typo in SBUS memalloc changes
  o [NETDEV]: pcnet32, eepro100, and 8139too need asm/irq.h
  o [SPARC]: Include linux/linkage.h in asm/unistd.h

Deepak Saxena:
  o I2C:  Support for IXP42x GPIO-based I2C

Don Fry:
  o pcnet32 correct names for changes
  o netdevice.h add netif_msg_init helper

Greg Kroah-Hartman:
  o I2C: fix oops in i2c-ali1535 driver if no hardware is present
  o I2C: fix compiler warnings in 2 drivers
  o I2C: show adapter name in i2c-dev class directory to make it easier
    for userspace tools
  o I2C: keep i2c-dev numbers in sync with i2c adapter numbers
  o Driver core: make CONFIG_DEBUG_DRIVER implementation a whole lot
    cleaner
  o Kobject: add decl_subsys_name() macro for users who want to set the
    subsystem name
  o PCI Hotplug: use the new decl_subsys_name() macro instead of
    rolling our own
  o remove cdev_set_name completely as it is not needed
  o I2C: fix up CONFIG_I2C_DEBUG_BUS logic to be simpler on the .c
    files
  o I2C: fix up CONFIG_I2C_DEBUG_CORE logic to be simpler on the .c
    files
  o I2C: add CONFIG_I2C_DEBUG_ALGO to be consistant
  o I2C: fix up CONFIG_I2C_DEBUG_CHIP logic to be simpler on the .c
    files
  o I2C: delete the i2c-elv.c driver as it is obsoleted by the
    i2c-parport.c driver
  o I2C: delete the i2c_philips-par.c and i2c-veleman.c drivers
  o kref: add kref structure to kernel tree

James Bottomley:
  o SCSI: mptfusion update to 3.00.04
  o Add SCSI lots of disk support
  o Add SCSI transport attributes
  o Add full complement of SPI transport attributes
  o SCSI: Make SPI transport attributes mutable
  o SCSI: implement transport attributes for 53c700
  o fix Kconfig select problem with SCSI_SPI_ATTRS
  o CONFIG_SCSI_AIC7XXX Kconfig bug
  o Make the SCSI mempool allocations variable
  o MPT Fusion driver 3.01.00 update
  o MPT Fusion driver 3.01.01 update
  o add device quiescing to the SCSI API
  o more SPI transport attribute updates
  o update the 53c700 use of transport attributes
  o Add Domain Validation to the SPI transport class
  o Fix removable USB drive oops
  o Add Domain Validation to 53c700 driver
  o Fix voyager to boot again

James Morris:
  o [CRYPTO]: Fix arc4 test vector

Jamie Lenehan:
  o dc395x [1/5] - formatting cleanups
  o dc395x [2/5] - sg list handling cleanups
  o dc395x [3/5] - remove old debugging stuff
  o dc395x [4/5] - debugging cleanup
  o dc395x [5/5] - version update

Jaroslav Kysela:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,ALSA
    Core,PCI drivers,MIXART driver,IGNORE
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712
    driver,ICE1724 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
    Alain Cretet <cretet@digigram.com>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Digigram VX core
    Alain Cretet <cretet@digigram.com>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA sequencer
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Added spinlock to pointer callback - ichdev->position is not
    changed atomically
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> MIXART driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA<-OSS sequencer
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Added period_frames to fix poll behavior
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Fixed oss.period_frames setup
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel
    Added OSS period frames to proc interface
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    emulation Fixed oops regarding last period_frames update
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    Clemens Ladisch <clemens@ladisch.de>:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Fixed swap_headphone() when headpone controls do not exist
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Trident driver
    Fixed s/pdif control initialization
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> RME HDSP driver
    Fixed wrong assert, added checks for copy_*_user functions
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA sequencer
    Clemens Ladisch <clemens@ladisch.de> Timestamping (if enabled on a
    subscription or a port) is not applied to the quoted event but to
    the quoting event.  This patch adds a function to copy only
    selected fields into the event to be delivered.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> MPU401 UART
    Clemens Ladisch <clemens@ladisch.de> remove unneeded technical
    information from port names
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA sequencer
    Clemens Ladisch <clemens@ladisch.de> This patch reverses the order
    of the 'Rawmidi x' and rawmidi name parts of client names to enable
    selecting clients by a unique prefix (as snd_seq_parse_address
    does).
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver Clemens Ladisch <clemens@ladisch.de>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA sequencer
    Clemens Ladisch <clemens@ladisch.de>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> MIXART driver
    Added missing header file inclusion
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
    Documentation,ALSA Core,PCMCIA Kconfig,PCMCIA Sound Core PDAudioCF
    driver Added Sound Core PDAudioCF driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> EMU10K1/EMU10K2
    driver Fixed page overflow
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Serial BUS
    drivers Moved AK4117 from alsa-driver tree to satisfy dependency
    for PDAudioCF driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AK4117 receiver
    Added missing ak4117.h file
  o Fixed compilation of PDAudioCF driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> USB generic
    driver usb_ch9.h is already included in usb.h
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALS4000 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CMIPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> MIXART driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM
    Midlevel,Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> EMU10K1/EMU10K2
    driver James Courtier-Dutton <James@superbug.demon.co.uk>, some
    additions
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Sound Core
    PDAudioCF driver akpm@osdl.org Fix pdaudiocf_irq.c for gcc-3.5
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Tumbler driver
    fixed the resume of bass/treble volumes on snapper.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core Fixed
    snd_info_set_text_ops() wwhen CONFIG_PROC_FS is not defined
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Sound Core
    PDAudioCF driver Fixed pcm->name settings
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AK4531 codec Aux
    Input Route -> Aux Capture Route renaming
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCI drivers
    Select CONFIG_VIDEO_DEV when CONFIG_SND_FM801_TEA575X is wanted
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> OPL3,OPL4,Synth
    Fixed sequencer dependency for opl3, opl4 and emux objects.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCI drivers
    <akpm@osdl.org> fix Kconfig thinko
  o ALSA - 1.0.3
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> FM801 driver
    tea575x can be module, too
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Big DMA cleanup
    originated by Russell King <rmk+alsa@arm.linux.org.uk>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CMI8330
    driver,ES18xx driver,AD1816A driver,AD1848 driver,CS4231 driver
    ES1688 driver,GUS Library,Opti9xx drivers,SB16/AWE driver,SB8
    driver Fixed old function name (snd_pcm_isa_flags ->
    snd_pcm_dma_flags)
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core Russell
    King <rmk+alsa@arm.linux.org.uk>
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver Fix for Creamware Noah:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module,ALSA
    Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ES1968 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Converted to new DMA allocation API
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ARM,ALSA
    Core,Generic drivers,ISA,PARISC,PCI drivers,PCMCIA Kconfig,PPC
    SPARC,USB This is part of a patch series to clean up
    sound/core/Makefile in Linux 2.6.4-rc1.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core,Generic
    drivers,ISA,PCI drivers,USB Russell King
    <rmk+alsa@arm.linux.org.uk>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core,ISA,PCI
    drivers,PCMCIA Kconfig Russell King <rmk+alsa@arm.linux.org.uk>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core,Generic
    drivers Russell King <rmk+alsa@arm.linux.org.uk>
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Generic
    drivers,MPU401 UART,OPL3,OPL4,ISA,PCI drivers More Kconfig and
    Makefile cleanups following Russell's direction:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Generic
    drivers,Digigram VX core,PCI drivers,PCMCIA Kconfig More Kconfig
    and Makefile cleanups following Russell's direction:
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
    fixed the missing inclusion.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCI drivers,AC97
    Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver fixes for broken SB Audigy 2 NX descriptors
  o ALSA - fixed compilation
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Tumbler driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1724
    driver,ICE1712 driver Dirk Kalis <Dirk.Kalis@t-online.de> Added
    num_total_adcs.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA<-OSS
    sequencer mpkelly - fixed channel settings for input events
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Opti9xx drivers
    fixed the code with obsolete check_region().
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec
    Core,Intel8x0 driver,VIA82xx driver,CS46xx driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
    fixed the interrupt problem with NForce(2).
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel Fix
    in playback_silence routine - don't silence whole buffer at start
    if samples are filled
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Core PCM API
    is 2.0.6
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module,PCM
    Midlevel,ALSA Core,CMI8330 driver,ES18xx driver Sound Scape
    driver,AD1816A driver,AD1848 driver,CS4231 driver ES1688 driver,GUS
    Library,Opti9xx drivers,SB16/AWE driver,SB8 driver ALS4000
    driver,AZT3328 driver,BT87x driver,CMIPCI driver,CS4281 driver
    ENS1370/1+ driver,ES1938 driver,ES1968 driver,FM801 driver Intel8x0
    driver,Maestro3 driver,RME32 driver,RME96 driver SonicVibes
    driver,VIA82xx driver,ALI5451 driver,CS46xx driver EMU10K1/EMU10K2
    driver,ICE1712 driver,ICE1724 driver,KORG1212 driver MIXART
    driver,RME HDSP driver,RME9652 driver,Trident driver YMFPCI
    driver,Sound Core PDAudioCF driver,USB generic driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PARISC Harmony
    driver,SPARC AMD7930 driver,SPARC cs4231 driver fixed for the new
    DMA buffer handler.
  o ALSA - fix compilation (header files)
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA
    sequencer remove superfluous call to snd_seq_event_port_detach
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA
    sequencer,ALSA<-OSS sequencer use wrapper function for DELETE_PORT
    ioctl calls
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver use MIN_PACKS_URB as lower bound for nrpacks parameter
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver show one decimal place of momentary frequency in proc file
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver prevent twenty-seconds wait when unplugging USB MIDI device
    with a port subscription
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
    restrict the PCM sample rates to 32, 44.1 and 48kHz when the SPDIF
    switch is on.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> DT019x driver
    Fixed warnings
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver patch
    was applied wrongly.  fixed the rate restriction of spdif output
    again.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,PCI
    drivers,au88x0 driver added the au88x0 drivers for Aureal
    soundcards by Manuel Jander <mjander@embedded.cl>
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Tumbler driver
    added input source switch to select mic/line-in.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
    changed the description of the buffer allocation routines for the
    new designed functions.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation fixed
    the files to include.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> USB generic driver
    added fix and workaround for the mixer problem on SB Extigy.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Tumbler driver
    fixed the info callback of mixer input source (for enum type).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> au88x0 driver
    removed EXPORT_NO_SYMBOLS.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> EMU10K1/EMU10K2
    driver disabled Dell OEM Emu10k1x from the pci id list.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> MIXART driver fixed
    the compile warning.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,PCI
    drivers,ATIIXP driver added snd-atiixp driver for the ATI
    IXP150/200/250 AC97 controllers.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,PCI
    drivers,Intel8x0-modem driver added Intel-compatible onboard MC97
    modem driver by Sasha Khapyorsky <sashak@smlink.com>
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core added the
    new magic numbers for atiixp and au88x0 drivers.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core fixed the
    wrong release of id proc file.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver
    Added slot definitions for s/pdif pcm - ICH4
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Kevin Mack <kevmack@accesscomm.ca> Here's a quick and dirty patch
    that's given me basic sound from my Gateway M675 notebook (Sigmatel
    9758 AC97 codec).
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
    Documentation,MPU401 UART integrate MPU-401 ACPI PnP from
    alsa-driver
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> au88x0
    driver fix compilation on gcc 2.95.x
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> Intel8x0
    driver add Intel ICH6 and ESB
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> au88x0 driver
    Make mchannels and rampchs static
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> au88x0 driver
    Fixed gameport dependency and solid kernel build

Jean Delvare:
  o I2C: Enable debugging in fscher
  o I2C: Credit James Bolt in w83l785ts
  o I2C: New chip driver ported: lm80
  o I2C: fix space in message
  o I2C: fix mor rmmod oopses
  o I2C: Lowercase chips name
  o I2C: fix Hangs with w83781d
  o I2C: fix it87 sensor type
  o I2C: fix another oops in i2c-core with debug
  o I2C: Remove asb100 support from w83781d
  o I2C: update for sysfs-interface documentation
  o I2C: rename sysfs files, part 1 of 2
  o I2C: rename sysfs files, part 2 of 2
  o I2C: Prevent i2c-dev oops with debug
  o I2C: fix i2c adapters class for now
  o I2c: Kconfig for non-sensors i2c chip drivers
  o I2C: Cleanup fan_div in w83781d
  o I2C: fix forced i2c chip drivers have no name
  o I2C: Don't handle kind errors that cannot happen
  o I2C: Setting w83781d fan_div preserves fan_min

Jeff Garzik:
  o [libata] make set_{pio,udma}mode hooks optional
  o [wireless] Add new Prism54 wireless driver
  o [wireless prism54] remove WIRELESS_EXT ifdefs
  o Add Promise SX8 (carmel) block driver
  o [libata] clean up module_init() hook of sata_{promise,sil,svw}
    drivers
  o [blk carmel] fix bug, minor cleanups
  o [libata sata_sil] remove incorrect limit on drive quirk
  o [libata] disable clustering by default, whitespace cleanups
  o [libata] kill the warning everybody grumbles about

Jens Axboe:
  o user data -> request mapping
  o CDROMREADAUDIO dma support
  o sys_swapon bad arg causing slab corruption

Jeremy Higdon:
  o SCSI: remove some SGI devices from the device list
  o [libata] Split up shared IO register locations into individual
    components
  o [libata] misc fixes, and an export
  o [libata] Add new driver for Vitesse VSC-7174
  o update for sata_vsc

Jesse Barnes:
  o ia64: Don't assume iosapic interrupt controllers
  o ia64: fix misc. sn2 warnings

Jonathan Corbet:
  o cdev 1/2: Eliminate /sys/cdev
  o cdev 2/2: hide cdev->kobj

Kai Mäkisara:
  o SCSI tape sysfs name fixes

Keith M. Wesolowski:
  o [SPARC32]: Rework the CPU enumeration and probing code
  o [SPARC32]: Also remove num_cpus_possible as was done on sparc64
  o [SPARC32]: Fix build; we don't need KERNEL_SYSCALLS but
    asm/unistd.h is necessary
  o [SBUS]: Fix sound build if CONFIG_SBUS is set
  o [SPARC32]: Add per-cpu data header

Kenji Kaneshige:
  o ia64: don't unmask iosapic interrupts by default

Krishna Kumar:
  o [IPV4]: Do not leak cork.opt in ip_push_pending_frames()

Kumar Gala:
  o PPC32: Added big-endian cfg_addr access
  o PPC32: Simplified handling of big/little endian pci indirect access

Kurt Garloff:
  o SCSI sysfs host name support

Leann Ogasawara:
  o Add sysfs simple class support for netlink
  o Fix class_register() always returns 0
  o add sysfs simple class support for DRI char device

Len Brown:
  o asmlinkage acpi_enter_sleep_state_s4bios() - from Pavel Machek
  o [ACPI] comments
  o [ACPI] global lock macro fixes (Paul Menage, Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=1669
  o Delete (void)func() casts considered cruft in Linux style
  o [ACPI] fix printk and build warning from previous csets
  o [ACPI] SMP poweroff (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=1141
  o [ACPI] ACPICA 20040311 from Bob Moore
  o [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize"
    acpi_osi= will disable the _OSI method -- which by default tells
    the BIOS to behave as if Windows is the OS.

Linus Torvalds:
  o Revert attribute_used changes in module.h. They were wrong
  o Linux 2.6.5-rc1

Manfred Spraul:
  o forcedeth update

Marc Singer:
  o [ARM PATCH] 1772/1: ARM README changes

Marcel Holtmann:
  o [Bluetooth] Make use of the MODULE_VERSION macro
  o [Bluetooth] Fix compile errors with enabled debugging
  o [Bluetooth] Declare more functions static

Mark Haverkamp:
  o aacraid driver patch
  o add adapter support to aacraid driver (update)

Mark M. Hoffman:
  o PCI: fix i2c quirk for SiS735 chipset SMBus driver
  o I2C: sysfs interface update for w83627hf
  o I2C: sensor chip driver refactoring

Matt Mackall:
  o [NET] add netpoll API
  o [NET] Add netpoll support for tg3
  o [NET] use the netpoll API to transmit kernel printks over UDP
  o netpoll: fix compilation with CONFIG_NETPOLL_RX
  o netpoll: push zap_completion_queue for lkcd
  o netpoll abort for bad interface
  o [netdrvr] add netpoll support to several 8390-based drivers
  o netconsole init return code
  o netconsole init return code
  o netpoll carrier handling
  o fix for netpoll braindamage for 64-bit

Matthew Wilcox:
  o ia64: add zx1_defconfig
  o ia64: SAL cleanup
  o ia64: Add support for extended PCI config space
  o ia64: Convert to use the generic drivers/Kconfig mechanism
  o sym2 2.1.18i
  o PA-RISC update

Mike Christie:
  o add missing free sgtable in scsi_init_io error path

Naveen Burmi:
  o New SCSI host_byte status code

Pat Gefre:
  o ia64: fix SN2 console driver to use console_initcall()
  o ia64: minor cleanups for SN2 console driver
  o ia64: Altix affinity fix

Paul Wagland:
  o SCSI: megaraid /proc dir fix

Pavel Machek:
  o [netdrvr via-rhine] add netpoll support

Prasanna S. Panchamukhi:
  o [netdrvr smc-ultra] netpoll support
  o [netdrvr tlan] netpoll support

Randy Dunlap:
  o I2C: fix i2c-prosavage.c section usage
  o buslogic init. section fix
  o eepro init section usage
  o smctr: fix init section usage
  o use netdev_priv() in appletalk & fc
  o use netdev_priv() in /hamradio/
  o use netdev_priv() in 3com net drivers
  o use netdev_priv() in net/ lance drivers
  o use netdev_priv() in net/arm drivers
  o use netdev_priv() in net/ intel drivers
  o use netdev_priv() in net/pcmcia/ drivers
  o use netdev_priv() in net/tulip drivers
  o use netdev_priv() in net/tokenring/ drivers
  o use netdev_priv() in net/wireless/ drivers
  o use netdev_priv() in tap/tun/plip/loop/skel
  o use netdev_priv() in fusion/mptlan
  o use netdev_priv() in net/wan drivers
  o use netdev_priv() in drivers/net/ (others)

Rene Herman:
  o 8139too assertions

Russell King:
  o I2C: Fix i2c_use_client()
  o [PCMCIA] Add, fix, update PCMCIA debugging
  o [PCMCIA] Clean up socket state handling around shutdown
  o [PCMCIA] Rename driver services constants
  o [PCMCIA] move_pcmcia_bind_device
  o [PCMCIA] move_pcmcia_bind_mtd
  o [PCMCIA] move pcmcia_report_error and cs_error
  o [PCMCIA] socket user operations should take pcmcia_socket
  o [ARM] Update ARM README
  o [ARM] Update mach-types file
  o [ARM] Provide userspace method for controlling LEDs in ARM machines
  o [ARM] Move consistent_xxx exports to arch/arm/mm/consistent.c
  o [ARM] Remove export of kd_mksound
  o [ARM] Allow run-time selection of user debugging messages
  o [ARM] Add asm/irq.h include - required for NR_IRQS

Rusty Russell:
  o drivers_net_wireless_airo.c '< 0' comparison make sense

Scott Feldman:
  o [netdrvr e100] fix stray skb pointer

Stephen Hemminger:
  o 3c59x netpoll typo
  o [TUN]: Name fix
  o [TUN]: Do not obscure error return from misc_register in tun_init
  o [TUN]: Fix user buffer verification
  o [TCP]: Kill westwood bw_sample, set but never used
  o [NET]: Make netdevice.h more non-kernel friendly

Stephen Rothwell:
  o fix PPC64 iSeries virtual console devices

Tom Rini:
  o PPC32: More cleanups of the IBM Spruce code
  o PPC32: Fix a thinko in the gen550 code
  o PPC32: Make {in,out}[bwl] be consistent on all platforms
  o PPC32: Make sure the read in in_8, in_{le,be}{16,32} happens before
    we return
  o PPC32: print useful flags in oops, like x86 / ppc64
  o PPC32: Kill off arch/ppc/boot/prep and rearrange some files
  o PPC32: Update the TODC code from 2.4
  o PPC32: Add and make use of ppc_md.rtc_{read,write}_val
  o PPC32: Fix 'make znetboot' on CONFIG_PPC_MULTIPLATFORM
  o PPC32: Fix an old thinko in arch/ppc/boot/simple/relocate.S
  o PPC32: Update the Motorola PowerPlus family support
  o PPC32: Fix include/asm-ppc/dma-mapping.h for the !CONFIG_PCI case
  o PPC32: consistent_free only takes one arguement

Trond Myklebust:
  o NFSv2/v3/v4: New attribute revalidation code that no longer relies
    on ctime for correctness in avoiding update races.
  o NFSv2/v3/v4: New file writeout strategy. Defer writes until a flush
    is requested by the application (or memory pressure).
  o Configuration: simplify configuration options. Automatically select
    RPCSEC_GSS if NFSv4 is selected. Remove need for user to select
    SUNRPC_GSS, and the crypto options.
  o NFSv2/v3: Ensure that we only use GETATTR+STATFS (NFSv2) and FSINFO
    (NFSv3) when mounting. This should allow us to use AUTH_SYS
    credentials when mounting, (even when the user requests RPCSEC_GSS
    authentication) due to the hack described in RFC2623.
  o NFSv2/v3/v4: Ensure that fsync() flushes all writebacks to disk
    rather than just the
  o NFSv2/v3/v4: A patch by Greg Banks that fixes the "VFS: Busy inodes
    after unmount." problem.
  o RPC: Make XIDs unique on a per-transport basis rather than globally
    unique. Gets rid
  o RPC: Sync rpc_set_timeo() up to the 2.4.x version. In particular,
    this will ensure that the timeout shift is clamped to a maximum
    value of 8.
  o RPC: Ensure that we have the correct capabilities when binding a
    socket to a reserved port. Fixes a privilege bug when
    CONFIG_SECURITY is set.
  o RPC,NFSv2/v3/v4: Ensure that xprt_create_proto() and
    rpc_create_client() return full error codes. Should allow the
    "mount" program to print more useful error diagnostics.
  o NFSv2/v3/v4: Parenthesize #defines in nfs?xdr.c. Fix an off-by-one
    error on the value
  o NFSv2/v3 locking: Patch by Patrice Dumas to implement
    nlmsvc_proc_granted_res
  o NFSv2/v3 locking: Patch by Patrice Dumas that adds a check to
    ensure we really were requesting a blocking lock when we get a
    reply from the server asking us to block.
  o NFSv2/v3 locking: Patch by Patrice Dumas to ensure that the server
    index blocks uniquely by using the client address in addition to
    the value of the NLM cookie field.
  o NFSv2/v3 locking: A patch to ensure that blocks which are not going
    to time out are placed last on the ordered list nlm_block (problem
    reported by Olaf Kirch).
  o RPC,NFSv3: remove the redundant "memset()" in call_encode(). Fix up
    the only places where this causes a padding error:
    xdr_encode_fhandle() and unx_marshal()
  o RPC: patch by Chuck Lever to make the number of RPC slots a tunable
    parameter
  o NFSv2: Fix up NFSv2 reads so that they report when the server
    returned a short read due to EOF.
  o NFSv4: Fix a list corruption in the NFSv4 state engine
  o NFS: From the suse kenrel RPM: handle ENOMEM from nfs_fhget()
  o From: <martin@meltin.net>
  o akpm@odsl.org: For complex reasons it is not possible to hold i_sem
    in nfs_update_inode()

Tuncer M. Zayamut Ayaz:
  o [IPVS]: Fix typo in Config.in

Wim Van Sebroeck:
  o [WATCHDOG] v2.6.4 pcwd_pci-v1.00_20040313-patch
  o WATCHDOG] v2.6.4 wdt977-v0.03-patch
  o [WATCHDOG] v2.6.4 notifier_block-patches

Yoshinori Sato:
  o H8/300: Interrupt handling cleanup
  o H8/300: fix build error
  o H8/300: fix waring
  o H8/300: makefile cleanup



