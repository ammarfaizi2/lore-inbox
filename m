Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUA2WC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUA2WC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:02:57 -0500
Received: from intra.cyclades.com ([64.186.161.6]:676 "EHLO intra.cyclades.com")
	by vger.kernel.org with ESMTP id S266409AbUA2WCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:02:52 -0500
Date: Thu, 29 Jan 2004 18:41:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-pre8
Message-ID: <Pine.LNX.4.58L.0401291833160.1304@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This release contains a big USB merge, architecture updates
(Alpha, SPARC, x86/64), SCSI driver updates (cpqarray and MPT fusion),
smbfs support for CIFS Unix extensions and large files (backported from 2.6),
"ACPICA" merge and ACPI fixes, merge jgarzik's net driver fixes, amongst
others.

This is probably the last -pre.

Detailed changelog follows,

Summary of changes from v2.4.25-pre7 to v2.4.25-pre8
============================================

<drb:med.co.nz>:
  o USB Storage: patch to unusual_devs.h for Pentax Optio 330GS camera

<emoore:lsil.com>:
  o SCSI fusion driver update - version 2.05.11.01

<felipe_alfaro:linuxmail.org>:
  o USB Storage: unusual_devs.h patch for Trumpion MP3 player

<francis.wiran:hp.com>:
  o cpqarray update

<khali:linux-fr.org>:
  o Fix bus reset in i2c-philips-par

<ladis:linux-mips.org>:
  o fix console_cmdline to match declaration

<len.brown:intel.com>:
  o [ACPI] ACPICA 20040116 from Bob Moore
  o [ACPI] move zero initialized data to .bss from Jes Sorensen
  o [ACPI] handle system with NULL DSDT and valid XDSDT from ia64 via Alex Williamson

<marcelo:logos.cnet>:
  o Dave Jones: Fix XFS misplaced "!" (not)
  o Cset exclude: johnstul@us.ibm.com|ChangeSet|20031206183542|49434
  o Add missing drivers/video/it8181fb.c (IT8181 framebuffer driver)
  o Changed EXTRAVERSION to -pre8
  o PC300: check copy_to_user() return value

<michael.krauth:web.de>:
  o USB: unusual-devs.h Patch for Kyocera Finecam L3

<rth:kanga.twiddle.home>:
  o [ALPHA] Tidy ELF_HWCAP and ELF_PLATFORM

<steve:navaho.co.uk>:
  o ALIM7101 watchdog honour NOWAYOUT flag

<tritol:trilogic.cz>:
  o USB: unusual_devs entry for Netac USB-CF

<urban.widmark:enlight.net>:
  o smbfs: struct with smb_ functions (1/3)
  o smbfs: CIFS Unix Extensions (2/3)
  o smbfs: Large File Support (3/3)

<xose:wanadoo.es>:
  o [netdrvr ns83820] s/PREPARE_TQUEUE/INIT_TQUEUE/

<yuasa:hh.iij4u.or.jp>:
  o Added PCI device ID for it8181fb

Adrian Bunk:
  o fix via-ircc.c .text.exit error
  o small hptraid.c fix
  o pc300_drv.c: mark a function pointer as __devexit_p

Alan Stern:
  o USB storage: unusual_devs.h change
  o USB Storage: another unneeded unusual_devs entry
  o USB Storage: another unusual_devs entry
  o USB Storage: unusual_devs.h update

Andi Kleen:
  o x86-64 merge

Arnaud Quette:
  o USB: disable hiddev support for MGE UPSs

Ben Collins:
  o [SPARC64]: Add CONFIG_DEBUG_BOOTMEM option
  o [SPARC64]: Correctly mask the physical address for remapping the kernel TLB's
  o [SPARC/SBUS/FLASH]: Fix some "unused var" warnings

Chas Williams:
  o [ATM]: [horizon] avoid warning about limited range of data type

David Brownell:
  o USB gadget: <linux/usb_gadget.h> updates [1/7]
  o USB gadget: add file_storage gadget driver [2/7]
  o USB gadget: add goku_udc (Toshiba TC86C001) [3/7]
  o USB gadget: gadget build/config updates [4/7]
  o USB gadget: gadget zero driver updates [5/7]
  o USB gadget: ethernet gadget updates [6/7]
  o USB gadget: net2280 controller driver updates [7/7]
  o USB: EHCI support on MIPS
  o USB: ehci update:  1/3, misc
  o USB: ehci update:  2/3, microframe scanning
  o USB:  ehci update:  3/3, highspeed iso rewrite

David S. Miller:
  o [SPARC64]: Fix double patch in head.S

David Stevens:
  o [MULTICAST]: multicast loop with include filters fix

David T. Hollis:
  o USB: Remove standalone AX8817x driver
  o USB: Remove standalone AX8817x  driver Config.in entry

Greg Kroah-Hartman:
  o USB: add test for B4000000 to ir-usb driver to fix build issue on some archs
  o USB: add support for the Clie PEG-TJ25 device

Herbert Xu:
  o USB Storage: revert freecom dvd-rw fx-50 usb-ide patch

Hirofumi Ogawa:
  o [netdrvr 8139cp] fix NAPI race

Jeff Garzik:
  o [tokenring olympic] use memset_io to fix certain platforms

Krzysztof Halasa:
  o warning fix: remove unused do_gettimeoffset_cyclone() when !CONFIG_X86_SUMMIT
  o Remove dead CONFIG_BLK_DEV_IDE_MODES

Mikael Pettersson:
  o 2.4.25-pre7 load_LDT() bug in setup.c

Oliver Neukum:
  o USB: memory allocations in storage code path for 2.4
  o USB: 2.4 memory deadlock avoidance

Pete Zaitcev:
  o USB: Patch for usb-storage in 2.4
  o USB: fix 2.4 usbdevfs race

Randy Dunlap:
  o repair scsi/pcmcia modules so that they can build by only including scsi_module.c for non-PCMCIA builds

Rusty Russell:
  o Add 2.6 module_param() compatibility macros

Stephen Hemminger:
  o Make xircom cardbus handle shared irq

Wolfgang Muees:
  o USB: auerswald driver: add a new device

