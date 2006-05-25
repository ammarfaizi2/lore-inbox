Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWEYCJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEYCJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWEYCJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:09:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964849AbWEYCJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:09:32 -0400
Date: Wed, 24 May 2006 19:09:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.17-rc5
Message-ID: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 there it is in all the normal places (or will be, once mirroring 
finishes).

It's mainly drivers updates (firewire sbp2 driver, infiniband ipath 
driver, some DVB updates, and some mmc, network, spi and usb driver 
stuff).

But there's a few netfilter and sctp updates too, and various random 
one-liners around.. As usual, the shortlog is pretty readable, and gives a 
reasonable view into the details.

This will hopefully be the last -rc before the final 2.6.17, knock wood..

		Linus
---
Adrian Bunk:
      V4L/DVB (3964): Bt8xx/bttv-cards.c: fix off-by-one errors
      fs/open.c: unexport sys_openat
      [ARM] arch/arm/kernel/dma-isa.c: named initializers
      [TR]: Remove an unused export.
      drivers/base/firmware_class.c: cleanups
      V4L/DVB (3927): Fix VIDEO_DEV=m, VIDEO_V4L1_COMPAT=y

Alan Cox:
      Final rio polish
      Clarify maintainers and include linux-security info

Alan Stern:
      USB: usbcore: don't check the device's power source

Albert Lee:
      libata: add pio flush for via atapi (was: Re: TR: ASUS A8V Deluxe, x86_64)

Alessandro Zummo:
      rtc subsystem: use ENOIOCTLCMD and ENOTTY where appropriate

Alexey Dobriyan:
      fs/compat.c: fix 'if (a |= b )' typo
      gigaset: endian fix
      [IPX]: Correct argument type of ipxrtr_delete().
      [IPX]: Correct return type of ipx_map_frame_type().
      [IPV6]: Endian fix in net/ipv6/netfilter/ip6t_eui64.c:match().
      [NETFILTER]: GRE conntrack: fix htons/htonl confusion
      selinux: endian fix
      [NET]: Fix "ntohl(ntohs" bugs
      [IRDA]: fix 16/32 bit confusion
      [IRDA]: fixup type of ->lsap_state

Amy Griffis:
      fix race in inotify_release
      fix NULL dereference in inotify_ignore

Andi Kleen:
      x86_64: Check for bad dma address in b44 1GB DMA workaround
      x86_64: Check for bad dma address in b44 1GB DMA workaround
      x86_64: Don't warn for overflow in nommu case when dma_mask is < 32bit
      i386/x86_64: Force pci=noacpi on HP XW9300
      x86_64: Fix memory hotadd heuristics
      x86_64: Don't schedule on exception stack on preemptive kernels

Andrew de Quincey:
      V4L/DVB (3725): Fix mutex in dvb_register_device to work.
      V4L/DVB (3726): Fix TT budget-ci 1.1 CI slots
      V4L/DVB (3740): Fix oops in budget-av with CI
      V4L/DVB (3742): Set tone/voltage again if the frontend was reinitialised
      V4L/DVB (3743): Fix some more potential oopses

Andrew Morton:
      V4L/DVB (3912): Sparc32 vivi fix
      V4L/DVB (3914): Vivi build fix
      setup_per_zone_pages_min() overflow fix
      revert "vfs: propagate mnt_flags into do_loopback/vfsmount"
      jffs2 warning fixes
      dl2k needs dma-mapping.h
      revert "forcedeth: fix multi irq issues"
      binfmt_flat: don't check for EMFILE
      pd6729 section fix
      i810 section fix
      mpu401 section fix
      es18xx build fix
      nm256_audio section fix
      ad1848 section fix
      [SUNSU]: Fix license.
      sys_sync_file_range(): move exported flags outside __KERNEL__

Andrew Victor:
      [ARM] 3523/1: Serial core pm_state

Andy Whitcroft:
      root mount failure: emit filesystems attempted

Aneesh Kumar:
      Fix typos in Documentation/memory-barriers.txt

Angelo P. Castellani:
      [TCP]: reno sacked_out count fix

Anton Blanchard:
      powerpc: fix kernel version display on pseries boxes

Atsushi Nemoto:
      kbuild: check SHT_REL sections
      kbuild: fix modpost segfault for 64bit mipsel kernel

Ayaz Abdulla:
      forcedeth: fix multi irq issues

Ben Dooks:
      [WATCHDOG] s3c2410_wdt.c stop watchdog after boot
      S3C24XX: GPIO based SPI driver
      S3C24XX: hardware SPI driver

Benjamin Herrenschmidt:
      pcmcia Oopses fixes
      Fix pSeries identification in prom_init.c
      powerpc: Fix ide-pmac sysfs entry

Benjamin LaHaise:
      Add Core Solo and Core Duo support to oprofile

Bob Picco:
      Align the node_mem_map endpoints to a MAX_ORDER boundary

Bryan O'Sullivan:
      IB/ipath: fix spinlock recursion bug
      IB/ipath: don't modify QP if changes fail
      IB/ipath: fix reporting of driver version to userspace
      IB/ipath: replace uses of LIST_POISON
      IB/ipath: fix NULL dereference during cleanup
      IB/ipath: enable GPIO interrupt on HT-460
      IB/ipath: enable PE800 receive interrupts on user ports
      IB/ipath: register as IB device owner
      IB/ipath: fix null deref during rdma ops
      IB/ipath: deref correct pointer when using kernel SMA

Carl-Daniel Hailfinger:
      smbus unhiding kills thermal management

Catalin Marinas:
      [ARM] 3526/1: ioremap should use vunmap instead of vfree on ARM
      [ARM] 3533/1: Implement the __raw_(read|write)_can_lock functions on ARM

Chen, Kenneth W:
      [IA64] fix broken irq affinity
      [IA64] one-line cleanup on set_irq_affinity_info

Chris Wedgwood:
      VIA quirk fixup, additional PCI IDs

Chris Wright:
      [NETFILTER]: SNMP NAT: fix memleak in snmp_object_decode

Chuck Ebbert:
      i386: remove junk from stack dump

Daniel Walker:
      tpm_register_hardware gcc 4.1 warning fix

Dave Jones:
      [WATCHDOG] sc1200wdt.c printk fix

Dave Kleikamp:
      JFS: Fix multiple errors in metapage_releasepage

David Brownell:
      USB: fix bug in ohci-hcd.c ohci_restart()
      USB: pegasus fixes (logstorm, suspend)
      USB: fix OHCI PM regression
      SPI: spi whitespace fixes
      SPI: spi bounce buffer has a minimum length
      SPI: devices can require LSB-first encodings
      SPI: busnum == 0 needs to work
      SPI: spi_bitbang: clocking fixes

David S. Miller:
      [SPARC64]: Update defconfig.
      [SPARC]: Handle UNWIND_INFO properly.
      [SPARC]: Add robust futex syscall entries.
      [SPARC64]: Respect gfp_t argument to dma_alloc_coherent().

David Woodhouse:
      bcm43xx: associate on 'ifconfig up'
      powerpc: fill hole in Cell SPU syscall table
      powerpc: check Cell SPU syscall number range _before_ using it
      powerpc: wire up sys_[gs]et_robust_list

Dimitry Andric:
      [ARM] 3529/1: s3c24xx: fix restoring control register with undefined instruction

dmitry pervushin:
      minor SPI doc fix

Duncan Sands:
      USBATM: change the default speedtouch iso altsetting
      USBATM: fix modinfo output
      V4L/DVB (3704): Fix some errors on bttv_risc_overlay
      V4L/DVB (3766): Correct buffer size calculations in cx88-core.c

Eric Sesterhenn:
      V4L/DVB (3790): Use after free in drivers/media/video/em28xx/em28xx-video.c
      Overrun in isdn_tty.c

Erling A. Jacobsen:
      winbond-840-remove-badness-in-pci_map_single

Florin Malita:
      nfsd: sign conversion obscuring errors in nfsd_set_posix_acl()
      orinoco: possible null pointer dereference in orinoco_rx_monitor()

Greg Kroah-Hartman:
      USB: add ark3116 usb to serial driver
      USB: fix omninet driver bug
      kobject: quiet errors in kobject_add

Greg Smith:
      s390: lcs incorrect test

Hans Verkuil:
      V4L/DVB (3813): Add support for TCL M2523_5N_E tuner.
      V4L/DVB (3825): Remove broken 'fast firmware load' from cx25840.

Harry Fearnhamm:
      [ARM] 3527/1: MPCore Boot Lockup Fix

Heiko Carstens:
      RCU: introduce rcu_needs_cpu() interface
      s390: exploit rcu_needs_cpu() interface

Hua Zhong:
      fix can_share_swap_page() when !CONFIG_SWAP

Ian Abbott:
      USB: ftdi_sio: Add support for HCG HF Dual ISO RFID Reader

Ian Kent:
      autofs4: NFY_NONE wait race fix

Imre Deak:
      SPI: per-transfer overrides for wordsize and clocking

Ingo Molnar:
      V4L/DVB (3965): Fix CONFIG_VIDEO_VIVI=y build bug

Ishai Rabinovitz:
      IB/srp: Complete correct SCSI commands on device reset

Jan Niehusmann:
      smbfs: Fix slab corruption in samba error path

Jean Delvare:
      scx200_acb: Fix return on init error
      scx200_acb: Fix resource name use after free
      V4L/DVB (4040a): Fix the following section warnings:
      V4L/DVB (4045): Fixes recursive dependency for I2C

Jens Axboe:
      blk: fix gendisk->in_flight accounting during barrier sequence

Jes Sorensen:
      [IA64] sn2 defconfig

Jesper Juhl:
      [NETFILTER]: Fix memory leak in ipt_recent

Joel Becker:
      configfs: Fix a reference leak in configfs_mkdir().
      configfs: configfs_mkdir() failed to cleanup linkage.
      configfs: Make sure configfs_init() is called before consumers.

John W. Linville:
      via-rhine: revert "change mdelay to msleep and remove from ISR path"

Jordan Crouse:
      scx200_acb: Fix for the CS5535 errata

Jose Alberto Reguero:
      V4L/DVB (3767): Pvr350 tv out (saa7127)

KAMEZAWA Hiroyuki:
      build fix: CONFIG_MEMORY_HOTPLUG=y on i386

Karsten Keil:
      [TG3]: ethtool always report port is TP.

Ken Brush:
      USB: Add Sieraa Wireless 580 evdo card to airprime.c

Komuro:
      network: axnet_cs: bug fix multicast code (support older ax88190 chipset)

Kristen Accardi:
      pci: correctly allocate return buffers for osc calls

Kumar Gala:
      SPI: Add David as the SPI subsystem maintainer
      SPI: Renamed bitbang_transfer_setup to spi_bitbang_setup_transfer and export it
      spi: add spi master driver for Freescale MPC83xx SPI controller

Kylene Jo Hall:
      tpm: update module dependencies
      tpm: fix constant

Latchesar Ionkov:
      v9fs: Twalk memory leak
      v9fs: signal handling fixes

Lennert Buytenhek:
      The ixp2000 driver for the enp2611 was developed on a board with

Lin Feng Shen:
      NFS: fix error handling on access_ok in compat_sys_nfsservctl

Linus Torvalds:
      Revert "[BLOCK] Fix oops on removal of SD/MMC card"
      Alternative fix for MMC oops on unmount after removal
      Revert "i386: export: memory more than 4G through /proc/iomem"
      Revert "sched: fix interactive task starvation"
      Linux 2.6.17-rc5

Luiz Fernando Capitulino:
      usbserial: Fixes use-after-free in serial_open().
      usbserial: Fixes leak in serial_open() error path.

Manu Abraham:
      V4L/DVB (4037): Make the bridge devices that depend on I2C dependant on I2C

Marcelo Tosatti:
      Marcelo has moved

Mark Fasheh:
      ocfs2: take data locks around extend
      ocfs2: take meta data lock in ocfs2_file_aio_read()
      ocfs2: Don't populate uptodate cache in ocfs2_force_read_journal()

Mark Huang:
      initramfs: fix CPIO hardlink check

Mark Lord:
      sata_mv: prevent unnecessary double-resets
      sata_mv: deal with interrupt coalescing interrupts
      sata_mv: chip initialization fixes
      sata_mv: spurious interrupt workaround
      sata_mv: remove local copy of queue indexes
      sata_mv: endian fix
      sata_mv: version bump

Martin Habets:
      [SPARC]: Remove duplicate symbol exports
      [SPARC]: show device name in /proc/dvma_map
      [SPARC]: Fix warning on prom_getproperty in openprom.c

Martin Schwidefsky:
      s390: add vmsplice system call
      s390: next_timer_interrupt overflow in stop_hz_timer

Mauro Carvalho Chehab:
      V4L/DVB (3745): Fix a bug at pluto2 Makefile
      V4L/DVB (3774): Create V4L1 config options
      V4L/DVB (3775): Add VIVI Kconfig stuff
      V4L/DVB (3782): Removed uneeded stuff from pwc Makefile
      V4L/DVB (3788): Fix compilation with V4L1_COMPAT
      V4L/DVB (3796): Add several debug messages to cx24123 code
      V4L/DVB (4041): Fix compilation on PPC 64

Michael Chan:
      [TG3]: Add some missing rx error counters
      [BNX2]: Fix bug in bnx2_nvram_write()
      [BNX2]: Use kmalloc instead of array

Michael Krufky:
      V4L/DVB (3731): Kbuild: drivers/media/video/bt8xx: remove $(src) from include path
      V4L/DVB (3792): Kbuild: DVB_BT8XX must select DVB_ZL10353
      V4L/DVB (3819): Cxusb-bluebird: bug-fix: power down corrupts frontend
      V4L/DVB (3832): Get_dvb_firmware: download nxt2002 firmware from new driver location

Michael S. Tsirkin:
      IB/mthca: Fix posting lists of 256 receive requests for Tavor

Micon, David:
      HID read busywait fix

Mike Kravetz:
      add slab_is_available() routine for boot code
      SPARSEMEM incorrectly calculates section number

Mikhail Gusarov:
      V4L/DVB (3826): Saa7134: Missing 'break' in Terratec Cinergy 400 TV initialization

Monty:
      USB: Emagic USB firmware loading fixes

NeilBrown:
      md: Fix inverted test for 'repair' directive.
      knfsd: Fix two problems that can cause rmmod nfsd to die
      md: fix possible oops when starting a raid0 array
      md: Make sure bi_max_vecs is set properly in bio_split

Nicolas Pitre:
      [ARM] 3524/1: ARM EABI: more 64-bit aligned stack fixes

Olaf Hering:
      USB: add an IBM USB keyboard to the HID_QUIRK_NOGET blacklist

Olaf Kirch:
      smbfs chroot issue (CVE-2006-1864)

Patrick McHardy:
      [NETFILTER]: nfnetlink_log: fix byteorder confusion
      [NETFILTER]: SNMP NAT: fix memory corruption
      [NETFILTER]: H.323 helper: fix parser error propagation
      [NETFILTER]: H.323 helper: fix sequence extension parsing

Paul A. Clarke:
      matroxfb: fix DVI setup to be more compatible

Paul Jackson:
      Cpuset: might sleep checking zones allowed fix
      cpuset: update cpuset_zones_allowed comment
      cpuset: might_sleep_if check in cpuset_zones_allowed

Pavel Machek:
      fix hotplug kconfig help
      swsusp: fix typo in cr0 handling

Pavel Pisa:
      [ARM] 3531/1: i.MX/MX1 SD/MMC ensure, that clock are stopped before new command and cleanups

Pete Zaitcev:
      USB: ub oops in block_uevent

Peter Osterlund:
      devices.txt: remove pktcdvd entry

Peter Staubach:
      NFS server subtree_check returns dubious value

Philip Craig:
      [NETFILTER]: fix format specifier for netfilter log targets

Pierre Ossman:
      [MMC] Fix premature use of md->disk

Randy Dunlap:
      [WATCHDOG] Documentation/watchdog/watchdog-api.txt - fix watchdog daemon
      libata-core: fix current kernel-doc warnings

Razvan Gavril:
      USB: ftdi_sio: add device id for ACT Solutions HomePro ZWave interface

Rene Herman:
      missing newline in scsi/st.c

Richard Purdie:
      LED: Improve Kconfig information
      Backlight/LCD Class: Fix sysfs _store error handling
      LED: Add maintainer entry for the LED subsystem
      LED: Fix sysfs store function error handling

Roland Dreier:
      IB/ipath: Properly terminate PCI ID table
      slab: Fix kmem_cache_destroy() on NUMA
      IB/mthca: Make fw_cmd_doorbell default to 0
      IB/srp: Don't wait for disconnection if sending DREQ fails
      IB/srp: Get rid of extra scsi_host_put()s if reconnection fails
      IB/uverbs: Don't leak ref to mm on error path

Russell King:
      [ARM] arch/arm/kernel/process.c: Fix warning

Rusty Scott:
      V4L/DVB (3829): Fix frequency values in the ranges structures of the LG TDVS H06xF tuners

Satoshi Oshima:
      kprobes: bad manipulation of 2 byte opcode on x86_64

Sean Hefty:
      IB: refcount race fixes

Serge E. Hallyn:
      selinux: check for failed kmalloc in security_sid_to_context()

Sergey Vlasov:
      V4L/DVB (3738): Saa7134: Fix oops with disable_ir=1

Simon Kelley:
      [NEIGH]: Fix IP-over-ATM and ARP interaction.

Solar Designer:
      [NETFILTER]: Fix do_add_counters race, possible oops or info leak (CVE-2006-0039)

Sridhar Samudrala:
      [SCTP]: Set sk_err so that poll wakes up after a non-blocking connect failure.

Stefan Richter:
      sbp2: consolidate workarounds
      sbp2: add read_capacity workaround for iPod
      sbp2: add ability to override hardwired blacklist
      ohci1394, sbp2: fix "scsi_add_device failed" with PL-3507 based devices

Stefan Schweizer:
      Fix capi reload by unregistering the correct major

Stephen Hemminger:
      sky2: prevent dual port receiver problems
      [PKT_SCHED]: Potential jiffy wrap bug in dev_watchdog().
      sky2: allow dual port usage
      Subjec: sky2, skge: correct PCI id for DGE-560T
      sky2: more fixes for Yukon Ultra
      sky2: force NAPI repoll if busy
      sky2 version 1.4
      skge: bad checksums on big-endian platforms
      skge: don't allow transmit ring to be too small
      [BRIDGE]: need to ref count the LLC sap
      sky2: fix jumbo packet support

Stephen Street:
      SPI: add PXA2xx SSP SPI Driver
      spi: Update to PXA2xx SPI Driver
      pxa2xx-spi update

Sunil Mushran:
      ocfs2: fix gfp mask in some file system paths

Theodore Tso:
      Update ext2/ext3/jbd MAINTAINERS entries

Thomas Gleixner:
      [ARM] 3530/1: PXA Mainstone: prevent double enable_irq() in pcmcia

Thomas Kleffel:
      ide_cs: Add IBM microdrive to known IDs

Tobias Powalowski:
      tty_insert_flip_string_flags() license fix

Trent Piepho:
      V4L/DVB (3763): Bug fix: Wrong tuner was used pcHDTV HD-3000 card
      symbol_put_addr() locks kernel

Uwe Zeisberger:
      [ARM] 3517/1: move definition of PROC_INFO_SZ from procinfo.h to asm-offsets.h

Vadim Catana:
      V4L/DVB (3795): Fix for CX24123 & low symbol rates

Vivek Goyal:
      Kdump maintainer info update
      i386 kdump boot cpu physical apicid fix

Vladislav Yasevich:
      [SCTP]: A better solution to fix the race between sctp_peeloff() and
      [SCTP]: Respect the real chunk length when walking parameters.
      [SCTP]: Validate the parameter length in HB-ACK chunk.
      [SCTP]: Allow linger to abort 1-N style sockets.

Wim Van Sebroeck:
      [WATCHDOG] i8xx_tco.c - remove support for ICH6 + ICH7

Yeasah Pell:
      V4L/DVB (3797): Always wait for diseqc queue to become ready before transmitting a diseqc message
      V4L/DVB (3803): Various correctness fixes to tuning.
      V4L/DVB (3804): Tweak bandselect setup fox cx24123

Zachary Amsden:
      Fix a NO_IDLE_HZ timer bug

