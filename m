Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTA2Dfa>; Tue, 28 Jan 2003 22:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTA2Dfa>; Tue, 28 Jan 2003 22:35:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60355 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262420AbTA2Df0>; Tue, 28 Jan 2003 22:35:26 -0500
Date: Wed, 29 Jan 2003 01:44:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre4
Message-ID: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

So here goes -pre4...


Summary of changes from v2.4.21-pre3 to v2.4.21-pre4
============================================

<blueflux@koffein.net>:
  o [IPV4 ROUTE]: Fix some sysctl documentation

<dwmw2@dwmw2.baythorne.internal>:
  o Miscellaneous MTD block driver fixes
  o MTD partitioning updates
  o MTD updates

<filip.sneppe@cronos.be>:
  o [NETFILTER]: ip_conntrack_ftp.c, fixes a typo in a DEBUG statement

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Fix a locking bug in ip_conntrack_proto_tcp

<ganesh@tuxtop.vxindia.veritas.com>:
  o Added ids for the Dell Axim and Toshiba E740. Thanks to Ian Molton

<georgn@somanetworks.com>:
  o Fix /proc/slabinfo on ARM

<henning@meier-geinitz.de>:
  o scanner.c: remove "magic" number for interface
  o USB scanner driver: updated Configure.help
  o scanner.h, scanner.c: New vendor/product ids for visioneer scanners
  o scanner.c: print user-supplied ids only on start-up
  o scanner.c, scanner.h: Remove PV8630 ioctls
  o scanner.c: endpoint detection cleanup
  o Add maintainer for USB scanner driver
  o scanner.h, scanner.c: maintainer change

<jamie@shareable.org>:
  o [SPARC64]: Fix MAP_GROWSDOWN value, cannot be the same as MAP_LOCKED

<kadlec@blackhole.kfki.hu>:
  o [NETFILTER]: Fix excess logging of reused FTP expectations

<manish@zambeel.com>:
  o [netdrvr tg3] add support for another 5704 board, fix up 5704 phy init

<marcus@ingate.com>:
  o [NETFILTER]: ipt_multiport invert fix

<neilt@slimy.greenend.org.uk>:
  o USB Serial patch

<netfilter@interlinx.bc.ca>:
  o [NETFILTER]: UDP nat helper support

<stelian@popies.net>:
  o sonypi driver update
  o make sonypi use ec_read/ec_write from ACPI patch

<valko@linux.karinthy.hu>:
  o [SPARC64]: Translate IPT_SO_SET_REPLACE socket option for 32-bit apps
  o [SPARC64]: Handle SO_TIMESTAMP properly in compat recvmsg

Adrian Bunk <bunk@fs.tum.de>:
  o remove duplicate entries from Configure.help

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o allow people to build M686 without PGE kernels
  o more vaio apm blacklist entries
  o mp oops fix
  o MP message improvements
  o remove confusing MP report
  o nmi stack usage
  o fix linux crash on boot with some boarss
  o fix up cx86 docs
  o IPMI driver
  o enable ipmi config
  o fix compile of 4.0 DRM
  o more parisc specific merge bits
  o parisc mux driver (parisc specific)
  o disable taskfile I/O
  o further IDE tape fixes
  o Skip disabled IDE generic controllers
  o Add ide software raid driver for Medley IDE raid
  o add support for Nvidia nForce2 IDE
  o Allow DMA setup on radeon IGP now we think its fixed
  o allow selection of SI raid
  o fix packet padding on 3c501
  o fix packet padding on the 3c505
  o more unusual USB storage devices
  o fix packet padding on the 3c507
  o fix packet padding on the 3c523
  o fix packet padding on the 7990
  o fix packet padding on the 8139too
  o fix 8390 packet padding
  o fix packet padding on at1700
  o fix packet padding on atp
  o fix de600/20 packet padding
  o fix ni5010 packet padding
  o fix ni52 packet padding
  o fix packet padding on ni65
  o fix packet padding on axnet_cs
  o fix padding on sgiseeq
  o fix sk_g16 padding
  o fix sun3_82586 padding
  o fix sun3lance packet padding
  o further dscc4 updates
  o document undocumentend field in SCSI headers
  o fix ad1889 warning - void functions dont return values
  o more unusual USB storage devices
  o ; cut the mount hash table down to a sane size, and fix printk
  o fix casting in pci dma
  o parisc header update
  o fix msdos end markers for compatibility with cameras etc

Andi Kleen <ak@muc.de>:
  o x86-64 update
  o hammer support for i386

Andrea Arcangeli <andrea@suse.de>:
  o O_DIRECT alignment fix

Andrew Morton <akpm@digeo.com>:
  o [SPARC64]: Handle unchanging _TIF_32BIT properly in SET_PERSONALITY
  o sync_supers() race fix
  o Fix ext3 scheduling storm and lockup
  o 3c59x: add 3c920 support
  o fix rare BUG in ext3

Christoph Hellwig <hch@sgi.com>:
  o fix scsi module unload bug
  o cciss/cpqarray/md should use generic BLKGETSIZE
  o properly handle too long pathnames in d_path
  o update bdflush documentation

Dave Engebretsen <engebret@us.ibm.com>:
  o PPC64 update

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Remove invalid warning
  o JFS: Remove COMMIT_Holdlock
  o JFS: add jfs_get_volume_size() back
  o JFS: Clean up flushing outstanding transactions to journal
  o JFS: add sync_fs super_operation

David Brownell <david-b@pacbell.net>:
  o zaurus B500 (sl-5600?) & usbnet
  o usb root hub strings

David Gibson <david@gibson.dropbear.id.au>:
  o Squash warnings in init/do_mounts.c

David S. Miller <davem@nuts.ninka.net>:
  o [USB]: rtl8150.c needs linux/init.h
  o [TCP]: Add tcp_low_latency sysctl
  o [TCP]: Fix typo in TCP_LOW_LATENCY changes

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiflop incorrect sti()
  o Atari ACSI exports
  o M68k misc_register audit
  o Mac/m68k config fixes
  o Mac/m68k early startup fixes
  o Mac/m68k Nubus updates
  o Atari NVRAM
  o m68k typo
  o Q40 IRQ typo
  o Replace Mac/m68k NS8390 with daynaport driver
  o init_rootfs() prototype
  o M68k matroxfb
  o register_console() comment typo
  o Mac/m68k NCR5380 SCSI updates

Gerd Knorr <kraxel@bytesex.org>:
  o videodev bugfix
  o add bt832 driver
  o bttv documentation update
  o tuner update
  o i2c tv modules update

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix ehci build problem for older versions of gcc
  o USB bluetooth: fix incorrect url in help text
  o USB: Move the scanner ioctls to usb_scanner_ioctl.h to allow access by archs that need it

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: This patch fixes the ULOG target when logging packets without any ethernet header (mac address).

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha update
  o alpha: titan, marvel, srmcons updates

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] s/spin_lock/spin_lock_irqsave/ in tg3_poll and tg3_timer
  o [netdrvr tg3] Better interrupt masking
  o [netdrvr tg3] flush irq-mask reg write before checking hw status block, in tg3_enable_ints.
  o [netdrvr tg3] manage jumbo flag on MTU change when interface is down
  o [netdrvr e100] remove file e100_proc, missed in previous patch (standard stats)
  o [netdrvr tg3] more verbose failures, during initialization

Jens Axboe <axboe@suse.de>:
  o Fix ide highmem scatterlist setup
  o fix CONFIG_IDE_DMA_ONLYDISK
  o IDE: Do not call bh_phys() on buffers with invalid b_page

John Stultz <johnstul@us.ibm.com>:
  o Compensate lost ticks in x440s

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Remove unfinished driver
  o ISDN: Improve DTMF detection
  o ISDN: Fix HiSax/ISAR fax handling bug
  o ISDN: Add locking for list access
  o ISDN: Add ISDN side support for Auerswald USB ISDN support
  o ISDN: Small HiSax cleanups

Khalid Aziz <khalid_aziz@hp.com>:
  o Avoid ide-scsi from starting DMA too soon

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Make READ_VOICE_SETTING available for normal users
  o [Bluetooth] Replace info message about SCO MTU with BT_DBG
  o [Bluetooth] Remove wrong check for size value in rfcomm_wmalloc()

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre4

Olaf Hering <olh@suse.de>:
  o autofs compat for ppc

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: iput deadlock fix - do not call iput() from inside of transaction

Patrick McHardy <kaber@trash.net>:
  o [NETFILTER]: Fix ipt_REJECT udp checksums
  o [NETFILTER]: Fix incremental TCP checksum in ECN module
  o [PPP]: Handle filtering drops correctly

Paul Gortmaker <p_gortmaker@yahoo.com>:
  o Fix wildcards in RTC alarm settings

Paul Mackerras <paulus@samba.org>:
  o add prctls for FP exception control

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix non-G450/G550 build of matroxfb

Randy Dunlap <randy.dunlap@verizon.net>:
  o usb-skeleton MINOR_BASE change

Richard Henderson <rth@dot.sfbay.redhat.com>:
  o [ALPHA] Add debugging access (core and ptrace) to the PAL unique value.

Robert Olsson <robert.olsson@data.slu.se>:
  o [NAPI]: Discuss some more issues in driver HOWTO

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e100] Sync 2.4.x driver with 2.5.x driver
  o [netdrvr e100] udelay a better way
  o [netdrvr e100] standardize nic-specific stats output
  o [netdrvr e100] fix TxDescriptor bit setting
  o [netdrvr e1000] allocate ethtool eeprom buffer dynamically, rather than a large static allocation on the stack
  o [netdrvr e1000] remove /proc support
  o [netdrvr e1000] Add ethtool GSTATS support

Simon Evans <spse@secret.org.uk>:
  o USB: Backport konicawc driver to 2.4

Tom Callaway <tcallawa@redhat.com>:
  o [SUNLANCE]: Add missing asm/machine.h include for sun4 builds
  o [SPARC64]: Add USB scanner ioctls to 32-bit compat table

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix Oopsable NFS condition in 2.4.21-preX

Vojtech Pavlik <vojtech@suse.cz>:
  o Fix the JSIOCGABSMAP et al ioctls in joydev.c
  o Add new devices support to I-Force driver

