Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTABVco>; Thu, 2 Jan 2003 16:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTABVbb>; Thu, 2 Jan 2003 16:31:31 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:11973 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267119AbTABVad>; Thu, 2 Jan 2003 16:30:33 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:38:59 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config 20/22] net.2-m68k
Message-ID: <3E14B173.mailLZI1T5CKH@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2003-01-02 22:03:12.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-02 22:03:17.000000000 +0100
@@ -245,6 +245,19 @@
 	  want). The module is called ariadne.o. If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
+config ARIADNE2
+	tristate "Ariadne II support"
+	depends on NETDEVICES && ZORRO
+	help
+	  This driver is for the Village Tronic Ariadne II and the Individual
+	  Computers X-Surf Ethernet cards. If you have such a card, say Y.
+	  Otherwise, say N.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called ariadne2.o. If you want to compile it as
+	  a module, say M here and read <file:Documentation/modules.txt>.
+
 config NE2K_ZORRO
 	tristate "Ariadne II and X-Surf support"
 	depends on NET_ETHERNET && ZORRO
@@ -272,6 +285,156 @@
 	  want). The module is called hydra.o. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config APNE
+	tristate "PCMCIA NE2000 support"
+	depends on NETDEVICES && AMIGA_PCMCIA
+	help
+	  If you have a PCMCIA NE2000 compatible adapter, say Y.  Otherwise,
+	  say N.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you
+	  want). The module is called apne.o. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+config APOLLO_ELPLUS
+	tristate "Apollo 3c505 support"
+	depends on NETDEVICES && APOLLO
+	help
+	  Say Y or M here if your Apollo has a 3Com 3c505 ISA Ethernet card.
+	  If you don't have one made for Apollos, you can use one from a PC,
+	  except that your Apollo won't be able to boot from it (because the
+	  code in the ROM will be for a PC).
+
+config MAC8390
+	bool "Macintosh NS 8390 based ethernet cards"
+	depends on NETDEVICES && MAC
+	help
+	  If you want to include a driver to support Nubus or LC-PDS
+	  Ethernet cards using an NS8390 chipset or its equivalent, say Y
+	  and read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
+config MAC89x0
+	tristate "Macintosh CS89x0 based ethernet cards"
+	depends on NETDEVICES && MAC
+	---help---
+	  Support for CS89x0 chipset based Ethernet cards.  If you have a
+	  Nubus or LC-PDS network (Ethernet) card of this type, say Y and
+	  read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt> as well as
+	  <file:Documentation/networking/net-modules.txt>.  This module will
+	  be called mac89x0.o.
+
+config MACSONIC
+	tristate "Macintosh SONIC based ethernet (onboard, NuBus, LC, CS)"
+	depends on NETDEVICES && MAC
+	---help---
+	  Support for NatSemi SONIC based Ethernet devices.  This includes
+	  the onboard Ethernet in many Quadras as well as some LC-PDS,
+	  a few Nubus and all known Comm Slot Ethernet cards.  If you have
+	  one of these say Y and read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
+	  If you want to compile this as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt> as well as
+	  <file:Documentation/networking/net-modules.txt>.  This module will
+	  be called macsonic.o.
+
+config MACMACE
+	bool "Macintosh (AV) onboard MACE ethernet (EXPERIMENTAL)"
+	depends on NETDEVICES && MAC && EXPERIMENTAL
+	help
+	  Support for the onboard AMD 79C940 MACE Ethernet controller used in
+	  the 660AV and 840AV Macintosh.  If you have one of these Macintoshes
+	  say Y and read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
+config MVME147_NET
+	tristate "MVME147 (Lance) Ethernet support"
+	depends on NETDEVICES && MVME147
+	help
+	  Support for the on-board Ethernet interface on the Motorola MVME147
+	  single-board computer.  Say Y here to include the
+	  driver for this chip in your kernel.   If you want to compile it as
+	  a module, say M here and read <file:Documentation/modules.txt>.
+
+config MVME16x_NET
+	tristate "MVME16x Ethernet support"
+	depends on NETDEVICES && MVME16x
+	help
+	  This is the driver for the Ethernet interface on the Motorola
+	  MVME162, 166, 167, 172 and 177 boards.  Say Y here to include the
+	  driver for this chip in your kernel.   If you want to compile it as
+	  a module, say M here and read <file:Documentation/modules.txt>.
+
+config BVME6000_NET
+	tristate "BVME6000 Ethernet support"
+	depends on NETDEVICES && BVME6000
+	help
+	  This is the driver for the Ethernet interface on BVME4000 and
+	  BVME6000 VME boards.  Say Y here to include the driver for this chip
+	  in your kernel.   If you want to compile it as a module, say M here
+	  and read <file:Documentation/modules.txt>.
+
+config ATARILANCE
+	tristate "Atari Lance support"
+	depends on NETDEVICES && ATARI
+	help
+	  Say Y to include support for several Atari Ethernet adapters based
+	  on the AMD Lance chipset: RieblCard (with or without battery), or
+	  PAMCard VME (also the version by Rhotron, with different addresses).
+
+config ATARI_BIONET
+	tristate "BioNet-100 support"
+	depends on NETDEVICES && ATARI && ATARI_ACSI!=n
+	help
+	  Say Y to include support for BioData's BioNet-100 Ethernet adapter
+	  for the ACSI port. The driver works (has to work...) with a polled
+	  I/O scheme, so it's rather slow :-(
+
+config ATARI_PAMSNET
+	tristate "PAMsNet support"
+	depends on NETDEVICES && ATARI && ATARI_ACSI!=n
+	help
+	  Say Y to include support for the PAMsNet Ethernet adapter for the
+	  ACSI port ("ACSI node"). The driver works (has to work...) with a
+	  polled I/O scheme, so it's rather slow :-(
+
+config SUN3LANCE
+	tristate "Sun3/Sun3x on-board LANCE support"
+	depends on NETDEVICES && (SUN3 || SUN3X)
+	help
+	  Most Sun3 and Sun3x motherboards (including the 3/50, 3/60 and 3/80)
+	  featured an AMD Lance 10Mbit Ethernet controller on board; say Y
+	  here to compile in the Linux driver for this and enable Ethernet.
+	  General Linux information on the Sun 3 and 3x series (now
+	  discontinued) is at
+	  <http://www.angelfire.com/ca2/tech68k/sun3.html>.
+
+	  If you're not building a kernel for a Sun 3, say N.
+
+config SUN3_82586
+	tristate "Sun3 on-board Intel 82586 support"
+	depends on NETDEVICES && SUN3
+	help
+	  This driver enables support for the on-board Intel 82586 based
+	  Ethernet adapter found on Sun 3/1xx and 3/2xx motherboards.  Note
+	  that this driver does not support 82586-based adapters on additional
+	  VME boards.
+
+config HPLANCE
+	bool "HP on-board LANCE support"
+	depends on NETDEVICES && HP300
+	help
+	  If you want to use the builtin "LANCE" Ethernet controller on an
+	  HP300 machine, say Y here.
+
 config LASI_82596
 	tristate "Lasi ethernet"
 	depends on NET_ETHERNET && PARISC && GSC_LASI
@@ -555,7 +718,7 @@
 
 config NET_VENDOR_SMC
 	bool "Western Digital/SMC cards"
-	depends on NET_ETHERNET && (ISA || MCA || EISA)
+	depends on NET_ETHERNET && (ISA || MCA || EISA || MAC)
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -631,7 +794,7 @@
 
 config SMC9194
 	tristate "SMC 9194 support"
-	depends on NET_VENDOR_SMC && ISA
+	depends on NET_VENDOR_SMC && (ISA || MAC)
 	---help---
 	  This is support for the SMC9xxx based Ethernet cards. Choose this
 	  option if you have a DELL laptop with the docking station, or
@@ -898,7 +1061,7 @@
 
 config NE2000
 	tristate "NE2000/NE1000 support"
-	depends on NET_ISA
+	depends on NET_ISA || (Q40 && m)
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
