Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUK0Plv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUK0Plv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 10:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUK0Plu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 10:41:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261229AbUK0Pjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 10:39:42 -0500
Date: Sat, 27 Nov 2004 12:43:22 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-pre1 (resend)
Message-ID: <20041127144322.GA2564@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resending this announcement due to lkml failure in the past couple of days.

Hi,

This is the start of the 29th -pre cycle of the v2.4 kernel series.

Its mainly backport of driver fixes from v2.6: SATA subsystem update, network
drivers (e1000, forcedeth, 3c59x), collection of I2C corrections, isofs large
file fix, sym53c8xx_2 fixes, InterMezzo backports, JFS update, an IA32 microcode
fix, MIPS update, couple of USB changes, amongst others.

The ACPI bug which caused I2C problems has been solved.

It also contains a VM change from Andrea which improves performance 
on high-end boxes making certain loads useable on those systems.

The number of changes is small and it should keep decreasing as time passes.

Please refer to the full changelog for details.

Summary of changes from v2.4.28 to v2.4.29-pre1
============================================

<a.pugachev:pcs-net.net>:
  o via82cxxx audio procfs code selection fix

<edward_peng:alphanetworks.com>:
  o dl2k: correct author's email

<lnville:tuxdriver.com>:
  o [VLAN]: change_mtu should return 0 on success

<manfred99:gmx.ch>:
  o [DECNET]: dn_neigh.c needs linux/module.h
  o [ATM]: Force -n option in gzip invocation
  o Tigran Aivazian: backport sigmatch() issue in microcode.c

<mjagdis:eris-associates.co.uk>:
  o Mike Jagdis CREDITS email address change

<vince:arm.linux.org.uk>:
  o vga16fb: Fix frame buffer bad memory mapping

Adrian Bunk:
  o remove outdated Stallion contact information

Andrea Arcangeli:
  o Lazily add anonymous pages to LRU

Andries E. Brouwer:
  o backport v2.6 largefile isofs fix

Barry K. Nathan:
  o Fix ELF exec with huge bss
  o binfmt_elf.c fix for 32-bit apps with large bss

Bartlomiej Zolnierkiewicz:
  o REQUEST_SENSE support for ATAPI
  o [libata] arbitrary size ATAPI PIO support
  o arbitrary size ATAPI PIO support bugfixes
  o make ATAPI PIO work
  o libata PIO bugfix

Chris Wright:
  o /proc/tty/driver/serial reveals the exact number of characters used in serial links (CAN-2003-0461)

Christoph Hellwig:
  o fix sata_svw compile

Dave Kleikamp:
  o JFS: Fix extent overflow bugs
  o JFS: avoid assert in lbmfree
  o JFS: Fix endian errors
  o JFS: fix race in jfs_commit_inode

David S. Miller:
  o [TCP]: Receive buffer moderation fixes
  o [NETLINK]: sed 's/->sk_/->//' in af_netlink.c

Ganesh Venkatesan:
  o e1000: Update Documentation/networking/e1000.txt
  o e1000: fix set_pauseparam for fiber serdes link
  o e1000: remove unused function e1000_enable_mng_pass_thru
  o e1000: fix set ringparam for ethtool returning error
  o e1000: driver version update
  o e1000: white space corrections
  o e100: Update to Configure.help
  o e1000: Update to Configure.help

Herbert Xu:
  o [NETLINK]: Backport pid hashing changes from 2.6
  o [NETLINK]: Invoke netlink_proto_init() correctly in non-modular case

Jan Kara:
  o Configurable quota messages

Jean Delvare:
  o I2C updates for 2.4.28 (1/5)
  o I2C updates: i2c proc parser fix
  o I2C updates: hardcoded buffer size should depend on define
  o I2C updates: lack trailing newline in logs
  o I2C updates: get rid of unused code

Jeff Garzik:
  o [netdrvr dl2k] new TX scheme, fix minor bug
  o [netdrvr dl2k] remove unused constant 'CFI'
  o [libata] add AHCI driver
  o [libata] fix minor 2.6 backport problems
  o [libata] return ENOTTY rather than EOPNOTSUPP for unknown-ioctl
  o [libata] use kunmap_atomic() correctly
  o [libata] cosmetic: make syncing with 2.6 easier
  o [libata] add ssleep() function
  o [libata ahci] bump version to 1.00
  o Add nth_page() helper
  o Resync linux/ata.h with 2.6.x
  o Remove silly comment from linux/ata.h
  o [libata] remove dependence on PCI (2.4 stub version)
  o [libata] bump versions, add MODULE_VERSION() tags
  o [libata] fix DocBook bugs
  o [libata ahci] minor fixes

Jeremy Higdon:
  o per-port LED control for sata_vsc

John W. Linville:
  o 3c59x: resync with 2.6

Len Brown:
  o [ACPI] BIOS workaround allowing devices to use reserved IO ports Author: David Shaohua Li http://bugzilla.kernel.org/show_bug.cgi?id=3049

Manfred Spraul:
  o Backport of the 0.30 forcedeth driver to 2.4. It's a new backport, starting from the 2.6 tree.

Marcelo Tosatti:
  o O.Sezer: cpqphp_pci.c size warning fix
  o Cset exclude: m.c.p@kernel.linux-systeme.com|ChangeSet|20041122173550|59288
  o Marc-Christian Petersen: VM documentation update
  o Ignore vma's with PageReserved pages at get_user_pages()
  o Andrea: get_user_pages handle ZERO_PAGE PG_reserved page, BUG otherwise
  o Changed EXTRAVERSION to -pre1
  o fix get_user_pages() change typo

Mark Lord:
  o Export ata_scsi_simulate() for use by non-libata drivers

Matthijs Melchior:
  o [libata ahci] fix rather serious (and/or embarassing) bugs

Meelis Roos:
  o ata.h undefined types in USB

Mikael Pettersson:
  o gcc34 fastcall mismatch fixes for rwsem-spinlock

Mike Kravetz:
  o Task name handling static copy v2.6 backport

Nishanth Aravamudan:
  o scsi/ahci: replace schedule_timeout() with msleep()/ssleep()

Pete Zaitcev:
  o USB: fix ohci_complete_add
  o USB: ohci fix by Jes&Pete for Jessie

Ralf Bächle:
  o MIPS update
  o MIPS: sound drivers for AMD Alchemy platforms
  o MIPS: Configure.help updates
  o MIPS: MAINTAINERS update
  o MIPS documentation

Randy Dunlap:
  o oops on boot when initializing CDROM

Solar Designer:
  o Fix SCSI tape driver return code
  o Fix 32-bit syscall emulation waste of CPU resources

Tobias Lorenz:
  o [libata sata_promise] s/sata/ata/

Tony Battersby:
  o sym53c8xx_2 error handler fix
  o sym53c8xx_2 sniff inquiry fix
  o sym53c8xx_2 Ultra 160 requires LVD
  o make SCSI error handler preserve data transfer residual
  o fix for scsi_unjam_host: Miscount of number of failed commands
  o fix race condition in sg.c

Özkan Sezer:
  o ricoh.h, mem0 wrong definition v2.6 backport
  o Wilfried Weissmann: hptraid v0.03 from -ac/redhat - minor fixes
  o DAC960 firmware/alpha backport from 2.6
  o Cure ISDN eicon size warning
  o OPTI Viper-M/N+ chipset support (by Michael Mueller)
  o hamradio scc warning type fix
  o intermezzo, backport some fixes from 2.6
  o intermezzo, backport some more fixes from 2.6
  o intermezzo, fixes from cvs
  o Mark InterMezzo as orphan
  o ide-scsi update from ac/rh: Added transform for reading ATAPI tape drive block limits


----- End forwarded message -----
