Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUE3Gxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUE3Gxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 02:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUE3Gxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 02:53:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:29125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261851AbUE3GxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 02:53:12 -0400
Date: Sat, 29 May 2004 23:52:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.7-rc2
Message-ID: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. An ALSA update, and tons of sparse type-fixes from Al Viro. Some 
even uncovered real bugs in user pointer usage.

USB, firewire, network driver, XFS, CIFS updates.

		Linus

Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
============================================

<felixb:sgi.com>:
  o [XFS] Remove speculative preallocation from linvfs_get_block_core

<fishor:gmx.net>:
  o I2C: add max1619 driver

<fsgqa:sgi.com>:
  o [XFS] Remove the 128K limitation on pagebuf_get_no_daddr() and
    allow the kmem_alloc() to fail.

Achim Leubner:
  o gdth driver update to 3.04

Adam Kropelin:
  o typo in OSS sparse __user annotations

Adam Lackorzynski:
  o asm-i386/timer.h docu cleanup

Adrian Bunk:
  o CREDITS is unmaintained

Alan Cox:
  o Do something about aacraid
  o initial 2.6 fixup for ATP870U scsi

Alan Stern:
  o USB: Initially read 9 bytes of config descriptor
  o USB UHCI: allow URBs to be unlinked when IRQs don't work
  o USB: Change "driverfs" to "sysfs" in usbcore
  o USB: Add usb_release_address() and move usb_set_address()
  o USB: Make usb_choose_configuration() a separate subroutine
  o USB: Gonzo variable renaming in hub.c
  o USB: Use normal return codes for several routines in hub.c

Alexander Viro:
  o ncpfs compat ioctls
  o initramfs uncpio fix
  o sparse: oprofile __user annotation
  o sparse: parport __user annotation (sysctls)
  o sparse: nfs __user annotation (client only, and not touching RPC)
  o sparse: ext2 __user annotation (ioctl)
  o sparse: ipc __user annotation
  o sparse: acpi __user annotation
  o sparse: trivial part of drivers/char __user annotation
  o sparse: trivial part of drivers/block __user annotation
  o sparse: partial drivers/input __user annotation
  o sparse: drivers/pci __user annotation
  o sparse: partial serial_core.c __user annotation
  o sparse: OSS __user annotation
  o sparse: ide-proc.c fixes
  o sparse: trivial part of drivers/ide __user annotation
  o sparse: rtc.c __user annotation
  o sparse: partial mm/* __user annotation
  o sparse: trivial part of kernel/* __user annotation
  o Missed RTC_IRQ patchlet
  o more sparse checking of do_utimes()
  o sparse: cdrom_generic_command split into kernel/user
  o sparse: trivial part of drivers/scsi/* annotation
  o sparse: trivial part of cdrom.c annotation
  o sparse: kernel/sysctl.c annotation and cleanup
  o sparse: make sg_io_hdr->cmdp a __user pointer
  o sparse: scsi_cmd_ioctl __user annotation
  o sparse: scsi_ioctl __user annotation
  o sparse: sg.c annotation
  o sparse: aio annotation
  o sparse: trivial parts of fs/* annotation
  o sparse: bits and pieces
  o sparse: misc ->read()/->write() __user annotation
  o sparse: fault_in_pages_readable() annotation
  o sparse: compat_ioctl - easy part
  o sparse (compat_ioctl): raw_ioctl() fixes
  o sparse (compat_ioctl): blkpg cleanup and annotation
  o sparse (compat_ioctl): font stuff
  o sparse (compat_ioctl): CDROM_SEND_PACKET handling
  o sparse (compat_ioctl): fb colourmap stuff
  o sparse (compat_ioctl): SIOCGIFCONF
  o sparse: final bits of compat_ioctl
  o sparse: ->[gs]etsockopt() annotation
  o sparse: nf_sockopt() annotation

Andi Kleen:
  o ext3: remove duplicated ext3_std_error() call
  o Really enable NUMA API on x86-64
  o Revert bogus x86-64 change
  o Fix nodemask clearing bug in NUMA API
  o Print backtrace for bad vfree()

Andreas Gruenbacher:
  o posix locks oops fix

Andrew Morton:
  o qlogicfas408.c warning fix
  o ppc64: bump IOMMU_MAX_ORDER
  o ppc64: avoid bogus real IRQ numbers
  o use SLAB_PANIC in ll_rw_blk.c
  o ep_send_events() stack reduction
  o matroxfb: Add support for mapping CRTC<->outputs at boot time
  o remap_file_pages: implement MAP_POPULATE for all protections
  o remap_file_pages: fix syscall declaration
  o minor sched.c cleanup
  o ir-kbd-gpio.c build fix
  o Subject: Re: Help understanding slow down
  o sched.h comment typo fix
  o sched_yield() microoptimisation
  o missing compat ioctl mapping for DM_REMOVE_ALL
  o Fix the setting of file->f_ra on block-special files
  o wdt.c warning fix
  o d_bucket initialisation simplification
  o Add `make checkstack' target

Andries E. Brouwer:
  o vt_ioctl() comment fix

Anton Blanchard:
  o ppc64: fix inline spinlocks
  o ppc64: NUMA fixes
  o ppc64: fix to viopath.c
  o ppc64: small enter_rtas fix
  o ppc64 kernel hackers can't spell
  o ppc64: xmon fixes

Arjan van de Ven:
  o PCI: restore pci config space on resume

Arthur Kepner:
  o [TG3]: Fix ethtool -S
  o [TG3]: Make sure RX/TX flow control settings actually get set

Bart Samwel:
  o Don't use "cut" in laptop mode control script -- it is in /usr
  o No interpretation of HD spindown timeout in laptop mode ACPI
    binding script

Bartlomiej Zolnierkiewicz:
  o ide: missing rq checks in ide-disk
  o ide: fix ide_delay_50ms() in ide.c to always sleep
  o ide: use msleep() instead of ide_delay_50ms()

Ben Collins:
  o [IEEE1394]: Fix for deadlock condition
  o [ieee1394]: Kill duplicate atomic.h inclusion
  o [ieee1394]: Fix problem with extended ROM regions
  o [ieee1394]: Delete host timer to avoid crashes in certain
    conditions
  o [ieee1394]: Cleanup failure handling in ieee1394 and nodemgr
  o [ieee1394]: Fix some possible deadlock conditions
  o [ieee1394]: Remove unused variable
  o [sbp2]: Fix use-after-free bug

Ben Fennema:
  o UDF: directory reading fix

Benjamin Herrenschmidt:
  o radeonfb iBook & IGP fixes
  o Fix typo in pmac_zilog
  o fix non-existent /dev/adb
  o use new msleep() in ADT746x driver

Brian Gerst:
  o use SLAB_PANIC for general caches

Brian King:
  o Make st support the scsi_device timeout
  o ipr gcc attributes fixes
  o ipr add error logs to abort and reset paths
  o ipr fix for ioa reset timeout oops
  o ipr remove anonymous unions for gcc 2.95
  o ipr driver version 2.0.7

Christoph Hellwig:
  o kill acient compat cruft from acenic
  o convert acenic to pci_driver API
  o [XFS] Properly account for clustered pages in the writeout path
  o [XFS] fix direct user memory dereference in bulkstat
  o [XFS] Use macros instead of inlines for spinlock wrappers to aid
    debugging.
  o fix assorted wd7000 warnings
  o tmscsim: remove procfs write support from tmscsim
  o remove an unused function from NC53c406a
  o don't export vma_prio_tree_next
  o remove stale comments above struct page
  o fix a bash-ism in toplevel Makefile
  o remove a dead variable from isofs
  o add one more neomagic audio device id
  o missing init.h in drivers/mtd/chips/sharp.c
  o include linux/root_dev.h for ROOT_DEV in drivers/mtd/maps/uclinux.c
  o include linux/selection.h for color_table in drivers/video/tgafb.c
  o make i386 dma-mapping.h includeable standalone
  o sb1000 and wan/sealevel net drivers need to include linux/init.h
  o [XFS] Don't leak locked pages on readahead failure
  o [WATCHDOG] v2.6.6 linux/fs.h-patch

Christophe Saout:
  o [CRYPTO]: Fix two scatterwalk problems

Colin Leroy:
  o ADT746X MAINTAINERS update

Daniele Venzano:
  o [netdrvr sis900] fix ISA bridge detection
  o [netdrvr sis900] cosmetic header cleanups
  o [netdrvr sis900] fix missing netif_device_detach in suspend

David Brownell:
  o USB: PXA 2xx UDC and RNDIS g_ether

David Gibson:
  o ppc64: remove silly debug path from get_vsid()

David Mosberger:
  o ia64: use new ptep_set_access_flags

David S. Miller:
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Implement debugging version of write_trylock()
  o [SPARC64]: Implement _raw_spin_lock_flags()
  o [SPARC64]: Update defconfig
  o [SPARC64]: Move over to HZ==1000
  o [SPARC64]: Kill unused var warnings/errors
  o [SCTP]: Kill 64-bit platform warning
  o [TCP]: Kill distance enforcement between tcp_mem[] elements
  o [TCP]: Add tcp_default_win_scale sysctl
  o [SPARC64]: Export _do_write_trylock to modules
  o Cset exclude: mashirle@us.ibm.com|ChangeSet|20040526204412|10895
  o [TCP]: Add receiver side RTT estimation
  o [TCP]: Grow socket receive buffer based upon estimated sender
    window
  o [AIRO]: Fix build error
  o [TCP]: More sysctl tweakings for rcvbuf stuff
  o [SPARC64]: compat select and futex need %o4 zero-extended
  o [NET]: Do net_todo_list empty check under semaphore

David Sanders:
  o isapnp sb16 virtual pc

Davide Libenzi:
  o epoll events send fix

Dean Roehrich:
  o [XFS] Prep for using dmapi code outside of xfs tree
  o [XFS] Remove some recent dmapi changes
  o [XFS] Dmapi preunmount event references null pointer

Dmitry Torokhov:
  o [NET_SCHED] Do not oops when user tries to attach a filter to a TBF
    qdisc

Don Fry:
  o pcnet32: add static to two routines
  o pcnet32: avoid hard hang with some chip variants
  o pcnet32: correct 79C976 variant string
  o pcnet32: fix boundary comparison bug
  o pcnet32: remove timer and complexity
  o pcnet32: limit frames received during interrupt
  o pcnet32: fix bogus carrier errors with 79c973
  o pcnet32: correct printk for big-endian arch
  o pcnet32: avoid timeout with tcpdump
  o pcnet32: fix for patch 8 le16_to_cpu

Douglas Gilbert:
  o st.c for GET_IDLUN

Eric Sandeen:
  o [XFS] guard against unused var in new mutex_spinunlock #define
  o [XFS] Fix overflow in mapping test at offsets of 2^63-1 bytes

Eugene Surovegin:
  o I2C PPC4xx IIC driver: upgrade to new OCP infrastructre
  o I2C PPC4xx IIC driver: Kconfig cleanup
  o I2C PPC4xx IIC driver: fix debug build with gcc3
  o I2C PPC4xx IIC driver: 0-length transaction temporary fix

Fabian Frederick:
  o ext2: fix build with DEBUG=y

Faik Uygur:
  o I2C: use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c

Ganesh Venkatesan:
  o e1000 1/7: Clear Auto-MDIX when the link is forced to
  o e1000 2/7: Workaround for link LED staying ON even when
  o e1000 3/7: Determine link status correctly while using
  o e1000 4/7: Estimate number of tx descriptors required
  o e1000 6/7: ethtool_ops support
  o e1000 7/7: Support for ethtool msglevel based error

Giridhar Pemmasani:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Intel8x0 driver

Go Taniguchi:
  o Fix dpt_i2o

Greg Banks:
  o [TG3]: Count rx_discards in rx_errors
  o [TG3]: Add more ethtool -S stats
  o fs/dcache.c: avoid race when updating nr_unused count of unused
    dentries

Greg Kroah-Hartman:
  o Reversed pci.ids changes, as Linus already fixed them in his tree
  o Remove the smbios driver as it is not needed
  o Report which device failed to suspend
  o Minor coding style fixups in resume code and added a bit of
    debugging help

Guennadi Liakhovetski:
  o tmscsim: 64-bit cleanup
  o tmscsim: no internal queue
  o tmscsim: remove legacy and void code
  o tmscsim: trivial updates

Guido Guenther:
  o ppc32: Fix typo in USB sleep code on intrepid based laptops

Heiko Carstens:
  o SCSI: fix Stack overflow when lldd returns SCSI_MLQUEUE_DEVICE_BUSY

Herbert Xu:
  o [IPSEC]: Fix OOPS when deleting an ip address
  o [IPSEC]: Use add_timer in find_acq
  o [IPSEC]: Do not leak entries in xfrm_state_find
  o [IPSEC]: Fix outdated comment in __xfrm_state_delete
  o [IPSEC]: Use add_timer() in xfrm_state_find
  o [AF_KEY]: Set family for state selector
  o [IPSEC]: Fix ref counting in __xfrmN_bundle_create()

Hideaki Yoshifuji:
  o [NET]: Prevent future missed updates of FOO_MAX macros

Hirofumi Ogawa:
  o FAT: small fixes

Ian Abbott:
  o USB: ftdi_sio throttling fix

Ian Campbell:
  o [ARM PATCH] 1893/1: define __ARCH_WANT_SYS_PAUSE for ARM

Ingo Molnar:
  o Fix the mangled-oops-output-on-SMP problem

Ivan Kokshaysky:
  o fix system clock on ruffian
  o fix NUMA build
  o compile fix for mm/init.c
  o fix PCI bridge swizzle on takara and eiger

J. Bruce Fields:
  o Prevent scary warnings from knfsd

James Bottomley:
  o Fix SCSI device state model
  o scsi sg: fix smp_call_function() with intrs disabled
  o SCSI: logging optimisation
  o SCSI: deprecate BLIST_FORCELUN
  o SCSI: make SCSI REPORT LUNS the default
  o SCSI: make inquiry timeout tuneable
  o pa-risc: kernel/fork.c broken by the new rmap

James Lamanna:
  o USB: Fix down() in hard IRQ in powermate driver

Jaroslav Kysela:
  o Fixed ALSA aureal driver compilation - wrong and missing PCI IDs
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CS4281 driver
    Added retry_count
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCMCIA Kconfig
    SND_PDAUDIOCF depends on SND_PCM
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Version
    release: 1.0.4
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver added
    dxs_support and ac97_quirk entries for Amira notebook.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ATIIXP driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core fix access to wrong register when clearing powerdown bits
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> Intel8x0
    driver 20-bit sample format support
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver remove superfluous address operator from literal arrays
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver allow specification of rate_table in AUDIO_FIXED_ENDPOINT
    quirks
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Timer
    Midlevel,ALSA Core Added early event flag and code to the timer
    interface.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core show AC'97 2.3 information in proc file
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core fix AC'97 revision bits on AD1985
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,SA11xx
    UDA1341 driver,Memalloc module,PCM Midlevel RawMidi Midlevel,RTC
    timer driver,ALSA Core,Timer Midlevel ALSA<-OSS emulation,ALSA
    sequencer,ALSA<-OSS sequencer,Generic drivers MPU401
    UART,OPL3,OPL4,ALS100 driver,AZT2320 driver,CMI8330 driver DT019x
    driver,ES18xx driver,OPL3SA2 driver,Sound Galaxy driver Sound Scape
    driver,AD1816A driver,AD1848 driver,CS4231 driver CS4236+
    driver,PC98(CS423x) driver,ES1688 driver,GUS Classic driver GUS
    Extreme driver,GUS MAX driver,AMD InterWave driver,Opti9xx drivers
    EMU8000 driver,ES968 driver,SB16/AWE driver,SB8 driver Wavefront
    drivers,PARISC Harmony driver,ALS4000 driver,ATIIXP driver AZT3328
    driver,BT87x driver,CMIPCI driver,CS4281 driver ENS1370/1+
    driver,ES1938 driver,ES1968 driver,FM801 driver Intel8x0
    driver,Intel8x0-modem driver,Maestro3 driver,RME32 driver RME96
    driver,SonicVibes driver,VIA82xx driver,AC97 Codec Core ALI5451
    driver,au88x0 driver,CS46xx driver,EMU10K1/EMU10K2 driver ICE1712
    driver,ICE1724 driver,KORG1212 driver,MIXART driver NM256
    driver,RME HDSP driver,RME9652 driver,Trident driver Digigram VX222
    driver,YMFPCI driver,Sound Core PDAudioCF driver Digigram VX Pocket
    driver,PPC PowerMac driver,SPARC AMD7930 driver SPARC cs4231
    driver,USB generic driver use the new module_param*() functions.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,Control Midlevel,ALSA Core,AD1848 driver,CS4231
    driver CS46xx driver,Trident driver,YMFPCI driver,ES18xx
    driver,OPL3SA2 driver ATIIXP driver,CS4281 driver,ES1968
    driver,Intel8x0 driver Intel8x0-modem driver,Maestro3
    driver,ALI5451 driver,NM256 driver Sound Core PDAudioCF driver
    Clean up of power-management codes.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALI5451 driver Clean
    up of power-management codes.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Trident
    driver,CS4231 driver,PARISC Harmony driver Remove all old
    SNDRV_DMA_TYPE_PCI references
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA
    sequencer load snd-seq-dummy automatically, as documented in
    seq_dummy.c
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver use wrapper function for usb_control_msg() to prevent
    DMA'ing from/to the stack
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x
    driver CMIPCI driver,CS4281 driver,ENS1370/1+ driver,ES1938 driver
    ES1968 driver,FM801 driver,Intel8x0 driver,Intel8x0-modem driver
    Maestro3 driver,RME32 driver,RME96 driver,SonicVibes driver VIA82xx
    driver,ALI5451 driver,au88x0 driver,CS46xx driver EMU10K1/EMU10K2
    driver,ICE1712 driver,ICE1724 driver,KORG1212 driver MIXART
    driver,NM256 driver,RME HDSP driver,RME9652 driver Trident
    driver,Digigram VX222 driver,YMFPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCI drivers,au88x0
    driver bugfixes and VIA/AMD chipset automatic workaround by Manuel
    Jander <manuel.jander@mat.utfsm.cl>
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver added
    Event Electronics EZ8 support by Doug McLain <nostar@comcast.net>
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
    fixed MX440 workaround in suspend/resume.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
    fixed the allocation of coherent DMA pages under 32bit mask.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver Edirol UA-700 advanced modes support
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0
    driver,Intel8x0-modem driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS4281 driver,ES1968
    driver,Maestro3 driver,ALI5451 driver CS46xx driver,NM256
    driver,Trident driver,YMFPCI driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel fixed
    the deadlock of power_lock in suspend (by Terry Loftin)
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC PMAC driver
    fixed the suspend/resume with the new ALSA common callbacks.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Memalloc module
    removed the obsolete hack for dev_alloc_coherent() with dev = 0.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC PMAC driver
    another fix for the new suspend/resume.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver
    <Dirk.Kalis@t-online.de> added a control for default rate in the
    ice1712 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC PMAC driver
    fixed the missing function declarations.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ATIIXP driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Control Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    added the mic/center sharing switch of cm9739 codec again.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,AC97
    Codec Core added the write support to ac97#x-x+regs proc file.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    Fixed AD18xx PCM bit handling
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Opti9xx drivers
    Fixed irq&dma initialization for <93x chips
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    patch_sigmatel_stac9758
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> AC97 Codec Core
    ac97->pci might be null
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC Keywest
    driver,PPC PMAC driver,PPC PowerMac driver PPC Tumbler driver fixed
    the oops on resume and the initialization of chip.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core
    fixed the compilation without CONFIG_SND_DEBUG.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCI drivers,ATIIXP
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> OPL3SA2 driver
    Added YMH0801 ISA PnP ID - OPL3-SA2
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PARISC Harmony
    driver fixed compilation - using struct parisc_device for DMA
    allocation.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA<-OSS
    emulation,ALSA sequencer,ALSA<-OSS sequencer,OPL4 make some module
    parameters sysfs-writable, where appropriate
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> Intel8x0
    driver check that period interrupt really has occured; clear only
    those interrupts that have been handled
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS4231 driver checks
    the PCM substream pointers to fix oops/panic in the interrupt
    handler.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver added
    DXS whitelist for (eMachines) m680x.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
    Documentation,EMU10K1/EMU10K2 driver Initial attempt to add support
    for SB Live 5.1 (c) 2003
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> RME HDSP driver
    HDSP9632 has also firmware version 0x97
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> CS4231
    driver add missing closing brace
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> AC97 Codec Core try
    to mute and power down in the destructor (to shut up noises).
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ES1968 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> SA11xx UDA1341
    driver,UDA1341
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ICE1712
    driver fix Hoontech DSP* box configuration
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> ALSA<-OSS
    emulation don't return negative byte count from GET[IO]PTR ioctl
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver fixed
    again the DXS entry for m680x to 48k-fixed rate.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel fixed
    the bit width of IEC958_SUBFRAME_* formats from 24 to 32.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,NM256
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,CMIPCI
    driver dropped the software encoding of AC3 stream in the driver.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ATIIXP driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation added
    the document about Audigy mixer implementation by Peter Zubaj.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver (Alan Stern) use altsetting number instead of index in
    messages
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> EMU10K1/EMU10K2
    driver Credits for SB Live (c) 2003
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Sound Core
    PDAudioCF driver Updated interrupt function to 2.6 irq API
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,CMIPCI
    driver make soft_ac3 option conditional again.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
    renamed the elements of 'input source select' control to avoid
    confusion.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Sound Core PDAudioCF
    driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de>
    Documentation,ICE1724 driver,ICE1712 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PARISC Harmony
    driver
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core STAC9758: stereo mutes, jack configuration
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver Roland UA-1000 support
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver fix typo
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel fixed
    the buffer id confliction in the case of CONTINUOUS or ISA buffers.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PPC PMAC driver,PPC
    Tumbler driver Giuliano Pochini <pochini@shiny.it>:
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ATIIXP driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> CS4236+ driver Added
    the new pnp id for an Intel mobo.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> RME HDSP
    driver,RME9652 driver fixed invalid spin_lock/unlock_irq() in the
    prepare callback.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver added
    headphone amplifier switch.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver Added
    the support of Aureon 7.1-Universe.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ICE1712 driver fixes
    by Christoph Haderer <chris_web@gmx.at>:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver
    <Dirk.Kalis@t-online.de> ice1712 patch for dsp24 value cards
    Without this patch in envy24control no controls for DAC and ADC
    available because no number of dacs and adcs is given.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel,ALSA
    Core Added SYNC_PTR ioctl for the PCM interface.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel Call
    hwsync at the start of SYNC_PTR ioctl
  o ALSA CVS sync
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCI drivers,ICE1712
    driver,ICE1724 driver
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> ALSA Core added
    reverse selections of components to CONFIG_SND_BIT32_EMUL.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> VIA82xx driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel,ALSA
    Core Added SNDRV_PCM_SYNC_PTR_APPL and SNDRV_PCM_SYNC_PTR_AVAIL_MIN
    extensions to SYNC_PTR ioctl for PCM API.

Javier Achirica:
  o [wireless airo] Add RFMON support for MPI and latest Cisco

Jean Delvare:
  o I2C: Incomplete AT24RF08 corruption prevention in i2c eeprom
  o Update Alfred Arnold contact info
  o Fix incorrect but unused define in net_sk_mca.h
  o I2C: i2c-parport: support the ADM1031 evaluation board

Jeff Garzik:
  o [netdrvr tg3] netdev_priv
  o [netdrvr ixgb] massive update
  o [netdrvr] Add 'gigabit ethernet' config option

Jeff Lightfoot:
  o net/sk98lin: correct buggy VPD in ASUS MB

Jeff Mahoney:
  o Fix for lockup in reiserfs acl/xattrs

Joe Nardelli:
  o USB: visor: Fix Oops on disconnect

Joe Thornber:
  o dm: change maintainer

Jon Krueger:
  o [XFS] xfs_iomap_write_delay() was doing speculative allocations
    without checking if there were any real blocks already in the
    speculative allocation area. This could result in an allocation
    that overlaps pre-allocated space. This would result in an ASSERT
    failure in debug kernels, or invalid output from xfs_bmap.
  o [XFS] Add support for allocating additional file space in stripe
    width sized chunks. A new fstab/mount option, "swalloc" has been
    defined. If specified when mounting a striped file system,
    allocation requests will be rounded up to a stripe width if the
    file size is >= stripe width, and the data is being appended to
    eof. The 'swalloc' option is "off" by default.

Joshua Jackson:
  o [VLAN]: Use KERN_INFO for VLAN_INF

Kevin Corry:
  o dm-ioctl.c: fix off-by-one error
  o dm.c: free cloned bio on error path
  o dm-ioctl: replace dm_[add|remove]_wait_queue() with dm_wait_event()
  o dm: add static and __init qualifiers
  o dm-table.c: proper usage of dm_vcalloc

Kevin Curtis:
  o [netdrvr wan] farsync driver update

Kurt Garloff:
  o Decrease srtuct file size by 8

Linus Torvalds:
  o Pass in a "dirty" argument to ptep_establish in preparation for pte
    update race fix.
  o Introduce architecture-specific "ptep_update_dirty_accessed()"
    helper function to write-back the dirty and accessed bits from
    ptep_establish().
  o Don't return void types from void functions
  o Make constant types explicit, rather than depend on some rather
    subtle C type expansion rules.
  o Remove bogus test preprocessor test
  o Split ptep_establish into "establish" and "update_access_flags"
  o Revert 3c905C initialization changes that cause problems
  o Add __user annotations to ppc64 signal.c
  o Add __user annotations to arch/ppc64/kernel/syscalls.c
  o Add __user annotations to arch/ppc64/kernel/process.c
  o Fix sparse complaint about badly typed constant
  o Add __user pointer annotations to arch/ppc64/kernel/sys_ppc32.c
  o Add __user pointer annotations to fs/compat.c
  o adb.c needs <linux/devfs_fs_kernel.h>
  o Add __user pointer annotations to ppc64 code
  o Fix up my misedit of Al's good patch. Don't blame Al
  o Linux 2.6.7-rc2

Luiz Capitulino:
  o USB: /usb/gadget/serial.c warning fix
  o fix net/tulip/winbond-840.c warning
  o PCI: fix pci/probe.c possible NULL pointer
  o fix unchecked return value in register_disk()

Maneesh Soni:
  o fix-sysfs-symlinks.patch

Mans Rullgard:
  o Fix userspace include of linux/fs.h

Marcel Holtmann:
  o [Bluetooth] Kill duplicate includes
  o [Bluetooth] Use try_module_get() for RFCOMM sessions
  o [Bluetooth] Define .kobj.k_name for the fake device

Martin Habets:
  o USB: usblp printer GET_DEVICE_ID fix

Matt Mackall:
  o i386: put irq stacks in .bss.page_aligned section

Matt Porter:
  o Add new IBM PPC4xx EMAC net driver
  o ppc32: fix PPC4xx for the handle_page_fault() change
  o ppc32: reorg DMA API, add coherent alloc in irq

Meelis Roos:
  o [SPARC64]: Make 32 CPUs the default

Michael Hunold:
  o v4l: use saa7111 i2c module in V4L MXB driver

Mordechai Ovits:
  o USB: add support for MS adapter to usb pegasus net driver

Nathan Scott:
  o Fix an incorrect email address in XFS maintainers section
  o Remove a bk ignored XFS cvs directory, accidentally added
  o [XFS] Remove extraneous vmtruncate call, missed in earlier merge
  o [XFS] Remove xfs_iaccess checks on security namespace, needs to be
    done outside XFS.
  o [XFS] Remove unused transaction pointer from bulkstat
  o [XFS] Bump the kmalloc/vmalloc cutoff up to 128k
  o [XFS] Make uses of extended inode flags consistent, remove
    duplicated code
  o [XFS] Fix some compiler warnings, mark cmn_err as printflike
  o [XFS] Fixup a couple of incorrect xfs_trans_commit calls (bad
    flags/casts).
  o [XFS] Merge final laptop mode patch (xfssyncd) from Bart Samwel
  o [XFS] Export/import tunable time intervals as centisecs not jiffies
  o [XFS] Switch all XFSDEBUG to DEBUG
  o [XFS] Fix a use-after-free during transaction commit when the log
    is in error state.
  o [XFS] Use set_current_state instead of direct current->state
    assignment
  o [XFS] Fix sendfile return code to be ssize_t in all places
  o [XFS] Remove xfs_swappable code, its not useful on Linux
  o [XFS] Remove no-longer-used variable in log write code, and a dated
    comment.
  o [XFS] Remove unused xfs_trans_bhold_until_committed and related
    macros
  o [XFS] Rename a subdirectory to make life easier for people (esp

Neil Brown:
  o Set d_bucket correctly for anonymous dentries
  o nfsd: deleting symlinks over nfs causes oops on unmount
  o nfsd: missing dget()

Nicolas Pitre:
  o [ARM PATCH] 1898/1: fix io_v2p macro on PXA
  o [ARM PATCH] 1872/1: base clock difference between PXA25x and PXA27x
  o [ARM PATCH] 1897/1: prevent selecting more than one PXA target
  o [ARM PATCH] 1869/1: PCMCIA support for Mainstone

Olaf Hering:
  o USB: out of bounds access in hiddev_cleanup

Olaf Kirch:
  o Fix race condition with current->group_info

Oliver Neukum:
  o USB: clean delays for ehci
  o USB: yet another place for msleep
  o USB: waitqueue related problem in kaweth
  o USB: fix fix to kaweth.c

Patrick McHardy:
  o [IPV6]: Fix memory leak in ah6.c
  o [IPV4,6]: Fix off-by-one in max protocol-type check
  o [IPV4]: Fix skb leak in igmpv3_newpack
  o [IRDA]: Fix NULL-ptr dereference in irlmp_get_saddr()

Paul Mackerras:
  o ppc64: better stack traces
  o IRQ stacks for PPC64
  o ppc64: fix nonexistent irq affinity

Paul Mundt:
  o Fix 8139too ring size for dreamcast/embedded

Pavel Machek:
  o swsusp: fix swsusp with intel-agp
  o swsusp documentation updates

Per Olofsson:
  o [netdrvr tulip] new pci id

Randy Dunlap:
  o remove message: POSIX conformance testing by UNIFIX

Rene Herman:
  o missing closing \n in printk

Robert Love:
  o CREDITS file update

Roger Luethi:
  o via-rhine: Fix force media
  o via-rhine: Rename some symbols
  o via-rhine: Whitespace clean-up
  o via-rhine: USE_MEM, USE_IO -> USE_MMIO
  o via-rhine: netdev_priv()

Roland Dreier:
  o PCI: Add InfiniBand HCA IDs to pci_ids.h

Roman Zippel:
  o hfsplus: fix key length for index nodes
  o hfsplus: correct dentry initialization for dir dentries
  o hfsplus: delete inode properly
  o hfsplus: completely remove half inserted catalog entry
  o hfsplus: don't release not existing nodes
  o hfsplus: update dir time after change

Russell King:
  o [PCMCIA] Fix a couple of resource bugs
  o [PCMCIA] Convert IO resource allocation to use struct resource
  o [ARM] Fix oops in dma_unmap_single()
  o [ARM] Provide coherent_dma_mask for PXA MCI device
  o [ARM] Add lubbock_set_misc_wr()
  o [ARM] Add LCD display parameters for Lubbock board
  o [ARM] Update PXA serial driver
  o [ARM] Remove SA1111 PS/2 IRQ_HANDLED handling
  o [ARM] PXAFB bug fixes
  o [ARM] Remove old static GPIO port definitions for SA1111
  o [ARM] Fix sorting of machine class symbols
  o [ARM] Enable IRQs over context switches
  o [ARM] Remove needless include of asm/mach-types.h
  o [ARM] Don't reference __machine_arch_type directly
  o [ARM] Fix lubbock PCMCIA driver
  o [ARM] pxa2xx_udc needs asm/mach-types.h
  o [ARM] Fix sparse complaint
  o [ARM] Move common definitions to asm/memory.h
  o [ARM] Ensure AMBA devices on Versatile have a correct dma_mask
  o [ARM] Remove obsolete asm-arm/arch-*/keyboard.h
  o [SERIAL] Fix sparse warnings in serial_core.c

Rusty Russell:
  o [TRIVIAL 2.6] drivers_scsi_nsp32.c: kill duplicate
  o bk-kernel-howto reversion

Sean Young:
  o [WATCHDOG] v2.6.6 sc520_wdt.c-patch2

Sergey S. Kostyliov:
  o befs: nls fix
  o befs: typo fix

Shirley Ma:
  o [IPV6]: Fix pmtu check conditions in two spots
  o [RTNETLINK]: IFA_MAX is wrong

Srivatsa Vaddagiri:
  o CPU Hotplug: restore Idle task's priority during CPU_DEAD
    notification

Stefan Rompf:
  o [netdrvr b44] always restore PCI config on resume

Stephen Hemminger:
  o [BRIDGE]: Update bridge.txt
  o [NET]: Simplify netdev_sysfs_xxx if SYSFS is not configured

Stephen Rothwell:
  o dynamic addition of virtual disks on PPC64 iSeries

Steve French:
  o POSIX protocol extensions part 1
  o Check for kmalloc failure on building full path
  o fix oops in heavy stress test caused by lack of check for bad
    dentry being passed in on reconnect
  o Fix incorrect file size on handle based setattr (for big endian
    hardware)
  o check for close pending and invalid file struct on writing out page
  o Retry build_path_from_dentry if parent path changes in flight
  o do not log errors on write failures unless debug is on
  o Keep number of active (on the network at one time) requests (to a
    single cifs server) below SMB maxmpx
  o fix big endian conversion of file system attribute and device info
  o missing init for new request_q
  o Take rename sem (where we can do it safely) when building full
    paths. We don't try to take the rename sem in cifs_rename of course
    because the kernel already took it above us, and for the same
    reason we can not take it in lookup/revalidate, but most everywhere
    else we build a full path we can safely take it
  o Add support for cifs per-share statistics, and add corresponding
    make menuconfig option for cifs statistics
  o add additional cifs stats
  o fix rc mapping on out of memory on mid alloc failure and cleanup
    dead code
  o Missing spin lock init

Steven King:
  o [IPSEC]: Fix buglet in AF_KEY spddelete

Thomas Wahrenbruch:
  o USB: Fix kobil_sct with uhci

Timothy Shimmin:
  o [XFS] Change xfs_contig_bits to work on 32/64 and both endian
    styles

Todd Poynor:
  o Device runtime suspend/resume fixes
  o Leave runtime suspended devices off at system resume
  o Fix for leave-runtime-suspended-devices-off-at-system-resume.patch

Todd Rimmer:
  o PCI: Add InfiniCon PCI ID to pci_ids.h

Tom Rini:
  o ppc32: fix 'make O=...'
  o ppc32: ix compiling arch/ppc/8260_io/enet.c

Vadim Lobanov:
  o [NET]: Save some space with sysfs strings

Valdis Kletnieks:
  o CREDITS file update

Venkatesh Pallipadi:
  o x86-bigsmp: use fixed interrupt delivery

William Lee Irwin III:
  o rmap build fix

Wim Van Sebroeck:
  o [WATCHDOG] v2.6.6 w83627hf_wdt.c
  o [WATCHDOG] v2.6.6 sc520_wdt.c-patch1

Yoshinori Sato:
  o H8/300 module fix
  o H8/300 ne driver module fix

Yury Umanets:
  o Fix various memory leaks

Zdenek Pavlas:
  o Make early_cpu_detect() set x86_cache_alignment on pre-cpuid CPU's
    too

