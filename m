Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTJ3MKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTJ3MKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:10:08 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12724 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262397AbTJ3MJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:09:58 -0500
Date: Thu, 30 Oct 2003 10:00:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre9
Message-ID: <Pine.LNX.4.44.0310300954540.1275-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -pre9. Only bugfixes will be accepted till 2.4.24-pre now.

-pre9 backouts out a few ACPI problematic changes. It also includes a USB 
update, JFS update, sis900/starfire/tg3 bugfixes, etc.

Detailed changelog below. 

Please help with testing! 

Summary of changes from v2.4.23-pre8 to v2.4.23-pre9
============================================

<achirica:telefonica.net>:
  o Fix compatibily issue with some APs
  o Fix wireless stats locking

<car.busse:gmx.de>:
  o USB: one more digicam for unusual_devs.h

<chrisw:osdl.org>:
  o sysctl core_setuid_ok fix

<dan:reactivated.net>:
  o USB brlvger: Debug code fixes

<dax:gurulabs.com>:
  o USB: Add Handspring Treo 600 ids

<henry.ne:arcor.de>:
  o USB: Update SL811, HC_SL811 driver

<janitor:sternwelten.at>:
  o [NETFILTER]: Add IPCHAINS to MAINTAINERS entry

<kml:patheticgeek.net>:
  o [TCP]: When SYN is set, the window is not scaled

<laurent.ml:linuxfr.org>:
  o [IRDA]: Fix build fallout from gcc-3.3 changes

<len.brown:intel.com>:
  o [ACPI] fix x86_64 build (Jeff Garzik)
  o [ACPI] fix x86_64 build (Jeff Garzik)
  o [ACPI] REVERT acpi_ec_gpe_query(ec) T40 fix that crashed other boxes http://bugme.osdl.org/show_bug.cgi?id=1171
  o [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused crash http://bugzilla.kernel.org/show_bug.cgi?id=1341
  o [ACPI] fix x86_64 ACPI build in 2.4.22 by backporting from 2.4.23
  o vsprintf needs PAGE_SIZE from page.h in 2.4

<luca:libero.it>:
  o USB: add W996[87]CF driver

<marcelo:logos.cnet>:
  o Fix Makefile -pre8 typo
  o Cset exclude: 9a4gl@9a0tcp.ampr.org|ChangeSet|20031021055256|28265
  o Changed EXTRAVERSION to -pre9

<tsk:ibakou.com>:
  o [netdrvr 8139too] add pci id

<zzz:anda.ru>:
  o Fix aic7xxx compilation without PCI support

Adrian Bunk:
  o USB: add USB gadget Configure help entries

Alan Stern:
  o USB: fix for earlier unusual_devs.h patch

Andrew Morton:
  o make printk more robust with "null" pointers
  o sis900 skb free fix
  o [netdrvr 3c527] add MODULE_LICENSE tag

Arjan van de Ven:
  o r8169 module license tag
  o fix starfire 64-bit b0rkage

Bart De Schuymer:
  o [NETFILTER]: Fix potential OOPS in ipt_REDIRECT

Ben Collins:
  o IEEE1394 fixes

Dave Kleikamp:
  o JFS: Make sure journal records get flushed to disk
  o JFS: Improved error handing
  o JFS: remove racy, redundant call to block_flushpage

David Brownell:
  o USB: usb ethernet gadget
  o USB: ehci-hcd, misc bugfixes
  o USB: usb "gadget zero" tweaks
  o USB: <linux/usb_ch9.h> updates
  o USB: usb gadget Config.in updates

David S. Miller:
  o [TG3]: Disable/enable timer in suspend/resume
  o Cset exclude: kuznet@ms2.inr.ac.ru|ChangeSet|20031021053209|59468

Greg Kroah-Hartman:
  o USB: fix compiler error in sl811.c
  o USB: fix build bug with usbnet and older versions of gcc

Henning Meier-Geinitz:
  o USB: scanner driver: new device ids (1/3)
  o USB: scanner driver: added USB_CLASS_CDC_DATA (2/3)
  o USB: scanner driver: use static declarations (3/3)

Hideaki Yoshifuji:
  o [IPV6]: Fix bogus semicolon typo in mcast.c

Ian Abbott:
  o USB: ftdi_sio - Perle UltraPort new ids - 1 of 2
  o USB: ftdi_sio - Perle UltraPort new ids - 2 of 2
  o USB: ftdi_sio - version bump 1.3.5

Jay Vosburgh:
  o [bonding] Restore compatibilty with old ifenslave

Jun Komuro:
  o [pcmcia fmvj18x_cs] share interrupts properly for TDK multifunction cards

Linus Torvalds:
  o Kamble, Nitin A: Add a quirk for the Intel ICH-[45] to add special ACPI regions

Maksim Krasnyanskiy:
  o [Bluetooth] Add support for FCon and FCoff flow control commands
  o [Bluetooth] Credit based flow control (CFC) must be disabled by default for compatibility with 1.0b devices. Made CFC a session attribute, introduced CFC states and cleaned up CFC logic.

Marcel Holtmann:
  o [Bluetooth] Always use two ISOC URB's
  o [Bluetooth] Remove USB zero packet option
  o [Bluetooth] Add support for the Digianswer USB devices
  o [Bluetooth] Add support for an old ALPS module

Neil Brown:
  o Fix deadlock problem in lockd

Paul Mackerras:
  o Add load_addr arg to ELF_PLAT_INIT

Rik van Riel:
  o saa7110 typo fix
  o silence warning in reiserfs_ioctl
  o [netdrvr starfire] include asm/io.h

Stelian Pop:
  o sonypi driver update
  o compile mii when using usbnet


