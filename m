Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSIZBUX>; Wed, 25 Sep 2002 21:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSIZBUX>; Wed, 25 Sep 2002 21:20:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61065 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261497AbSIZBUU>; Wed, 25 Sep 2002 21:20:20 -0400
Date: Wed, 25 Sep 2002 20:33:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre8
Message-ID: <Pine.LNX.4.44.0209252031350.15076-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre8.


Summary of changes from v2.4.20-pre7 to v2.4.20-pre8
============================================

<adam@nmt.edu>:
  o 3ware driver update for 2.4.20-pre7 (resend)

<defouwj@purdue.edu>:
  o net/ipv4/ip_options.c: IPOPT_END padding needs to increment optptr

<info@usblcd.de>:
  o USBLCD updates

<kafai0928@yahoo.com>:
  o Use SET_MODULE_OWNER in eepro100 net driver instead of MOD_{INC,DEC}_USE_COUNT, eliminating a small race

<marcelo@freak.distro.conectiva>:
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20020924233624|33060
  o Changed EXTRAVERSION to -pre8

<ralf@dea.linux-mips.net>:
  o Remove the FBIO_SED1356_BITBLT ioctl which had a dangerous security hole.  That result in an empty s1356fb_ioctl, so nuke the entire ioctl-related code.

<rgs@linalco.com>:
  o Track link state via netif_carrier_xxx, in gmac net driver

<scottm@somanetworks.com>:
  o Small pcihpfs dnotify fix

<silicon@falcon.sch.bme.hu>:
  o comx-hw-munich WAN driver "performance fix": remove hideous udelay

<taka@valinux.co.jp>:
  o arch/i386/lib/checksum.S:csum_partial Handle oddly addressed buffers correctly

<wes@infosink.com>:
  o mwave fixes

<zubarev@us.ibm.com>:
  o IBM PCI Hotplug driver update
  o IBM PCI Hotplug driver update for ISA based devices
  o IBM PCI Hotplug driver update for PCI based controllers

Adrian Bunk <bunk@fs.tum.de>:
  o Fix xconfig screwup caused by MIPS merge

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ; unlimited kmalloc in i2c fix (Silvio Cesare)
  o Add missing watchdog checks
  o wrong sizes in amdtp (Silvio Cesare)
  o fix oops in hisax
  o fix mga hang
  o security - missing checks in video4linux (Silvio Cesare)
  o gmac fixups (Roberto Gordo Saez)
  o S390 misc fixes
  o remove escaped user space diagnostic code
  o tighten modem probe/naming for ac97 (me)
  o forte audio updates
  o Kaweth - align packets for non x86 (Oliver Neukum)
  o replace end user confusing "on fire" joke with real info
  o fix include in freecom.c (Andre Hedrick)
  o Security - vicam (Silvio Cesare)
  o big endian support for voodoo2 frame buffer
  o Warn if mounting an ext3fs as ext2
  o Add additional MSRs to definitions (Dominik Brodowski,
  o fix vmalloc corner case (Dave Miller)
  o quoting fix in unbz64wrap (me)
  o Changes updates (Niels Jensen)
  o doc pointer for khttpd
  o update maestro3 docs to match maestro3 code
  o Fix PCI gameport handling (me)
  o sign fix for i2c (Silvio Cesare)
  o Make trident use new pcigame interfaces (me)
  o add modem bits define for x86

Andi Kleen <ak@muc.de>:
  o ACPI fixes for x86-64
  o AGP for 8151/x86-64
  o x86-64 core changes to sync with x86-64.org
  o Minor change for x86-64 NUMA
  o x86-64 panic blink
  o Fix x86-64 fbcon
  o Fix some x86-64 bugs

Andrew Morton <akpm@zip.com.au>:
  o Fix "multiple definition of 'smc_init'" error in smc-ircc irda driver, by declaring smc_init static.

Ben Collins <bcollins@debian.org>:
  o IEEE-1394 updates

Benjamin LaHaise <bcrl@redhat.com>:
  o ns83820.c v0.20 -- a brown paper bag edition
  o ns83820 v0.20 fixup

charles.white@hp.com <Charles.White@hp.com>:
  o Add cpqarray/cciss entries to root_dev_names

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: cleanup -- Remove excessive typedefs
  o JFS: Avoid parallel allocations within the same allocation group
  o JFS: Slightly relax allocation group reservation
  o JFS: Put legacy OS/2 extended attributes in "os2." namespace
  o JFS: Fix compiler errors in xattr.c
  o JFS: Fix off-by-one error in dbNextAG

David Brownell <david-b@pacbell.net>:
  o usbnet sync w/2.5: new devs, ethtool, etc

David S. Miller <davem@nuts.ninka.net>:
  o [TIGON3]: Do not reference vlgrp unless TG3_VLAN_TAG_USED is set
  o [TIGON3]: Fix slight perf regression from TSO changes
  o [VLAN] Use unregister_netdevice to prevent rtnl double-lock
  o [TIGON3]: New way to flush posted writes of GRC_MISC_CFG
  o [NAPI]: Do not check netif_running() in netif_rx_schedule_prep
  o [NAPI]: Set SCHED before dev->open, clear if fails.  Restore netif_running check to netif_rx_schedule_prep
  o [TIGON3]: Comment out tg3_enable_ints PCI write flush for now
  o [TIGON3]: Use spin_lock_irqsave in tg3_interrupt, fixes SMP hang
  o arch/sparc64/defconfig: Update
  o [TIGON3]: Add 5704 support
  o [TIGON3]: GRC_MISC_CFG_BOARD_ID_5704CIOBE is wrong
  o [TIGON3]: Fiber WOL support, chip clock bug fix
  o [TIGON3]: Static initializer changes from 2.5.x driver
  o [TIGON3]: Fix some comment tabbing
  o [TIGON3]: Fix some extraneous trailing whitespace
  o include/linux/spinlock.h: Fix compiler version check
  o [TIGON3]: Fix link polarity setting on all non-5700 chips
  o [TIGON3]: Optimize NAPI irq masking a bit
  o [TIGON3]: Define NIC_SRAM_MBUF_POOL_SIZE64 properly
  o drivers/char/drm/drmP.h: Disable DRM_DEBUG
  o arch/sparc64/defconfig: Update
  o [SPARC64]: Trap kernel bogus program counter at fault time
  o [DRM]: Set DRM_DEBUG_CODE back to 2, comment out page_to_bus reference
  o [DRM]: Comment out another page_to_bus reference

David S. Miller <davem@redhat.com>:
  o Fix a couple compiler warnings in e100 net driver

Greg Kroah-Hartman <greg@kroah.com>:
  o export pci_scan_bus, as the IBM pci hotplug driver needs it
  o IBM PCI Hotplug driver: sync up with the 2.5 version (__init and formatting fixes)
  o USB: fix timeout value for ezusb firmware download function
  o USB: document struct usb_driver and add module owner field
  o PCI Hotplug: added max bus speed and current bus speed files to the pci hotplug core
  o PCI Hotplug: added speed status to the IBM driver
  o PCI Hotplug: added speed status to the Compaq driver
  o add export for __inode_dir_notify so dnotify can be used from filesystems in a modules
  o PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare
  o PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on
  o USB: fix oopses in hub.c.  Thanks to Alan Stern for pointing them out

Hugh Dickins <hugh@veritas.com>:
  o tmpfs 1/5 shmem_rename fixes
  o tmpfs 2/5 shmem_symlink like 2.5/ac
  o tmpfs 3/5 pretend dirent size
  o tmpfs 4/5 three trivia
  o tmpfs 5/5 closer to 2.5/ac

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha, arm, parisc: PCI setup update

Jan-Benedict Glaw <jbglaw@lug-owl.de>:
  o Sync up with 2.5: Doku/formatting updates for my srm_env.c

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add support for netif_carrier_xxx reporting to 3c59x net driver (based on a patch by Nelson Tan Gin Hwa, via Andrew Morton)
  o Merge up to version 1.04 of sundance net driver
  o Add support for Cirrus Logic GD7548 to clgenfb fbdev driver (contributed by gabucino@mplayerhq.hu)
  o Fix merge error in 3c59x netif_carrier_xxx change
  o merge most of the hppa support into tulip net driver
  o Fixes for little-used paths and obscure races, in 8139cp net driver (contributed by matthias@waechter.wiz.at)
  o Update list of airo wireless commands, and two RIDs, from linux-wlan-ng sources and online sources
  o sundance net driver fixes, and a few cleanups too
  o clean up previous sundance net driver fixes
  o sundance net driver modernization
  o Update eepro100 net driver hardware resume to Becker eepro100.c version
  o further sundance net driver fixes
  o Improve RX buffer size calculation, in sundance net driver (suggested by Donald Becker)
  o Kill more e100 net driver compile warnings

Jens Axboe <axboe@suse.de>:
  o Avoid innapropriate oversized scsi_malloc() calls
  o back out merge_only logic
  o ide-cd sense clearing

Jes Sorensen <jes@wildopensource.com>:
  o acenic net driver update

Marc Boucher <marc@mbsi.ca>:
  o Fix VAIO WXP01Z3 blacklist entry

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Fix error handling of pci_request_regions

matt_domsch@dell.com <Matt_Domsch@dell.com>:
  o Move include/asm-ia64/efi.h to include/linux/efi.h
  o Merge IA64 port copy of include/linux/efi.h

Oliver Neukum <oliver@neukum.name>:
  o hpusbscsi disconnect fix

Roger Luethi <rl@hellgate.ch>:
  o Remove ancient ETHER_STATS statistics code from several net drivers, code that has not been compile-enabled nor compileable in ages.

Russell King <rmk@arm.linux.org.uk>:
  o This patch fixes a bug in handling the timeout in pcnet_cs.c, where it uses the following test to determine whether the timeout has expired:

Tom Rini <trini@kernel.crashing.org>:
  o PPC-specific 3c509 net driver update
  o Add a PCI ID for the Motorola MPC107
  o PPC32: Fix booting on MPC8xx and MPC8260 machines

Urban Widmark <urban@teststation.com>:
  o smbfs gcc warning fix


