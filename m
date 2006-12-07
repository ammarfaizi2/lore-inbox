Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163178AbWLGS12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163178AbWLGS12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163169AbWLGS12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:27:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48217 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163178AbWLGS11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:27:27 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 7 Dec 2006 13:23:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: Remove superfluous "!=n" symbol comparisons.
Message-ID: <Pine.LNX.4.64.0612071317400.21303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.799, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_50 0.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove all apparently unnecessary "!=n" symbol comparisons from
Kconfig files.

---

  According to the parser itself (scripts/kconfig/expr.c), that
comparison is superfluous:

/*
 * bool FOO!=n => FOO
 */

 drivers/block/Kconfig               |    2 +-
 drivers/block/paride/Kconfig        |    2 +-
 drivers/char/pcmcia/Kconfig         |    2 +-
 drivers/fc4/Kconfig                 |   10 +++++-----
 drivers/isdn/gigaset/Kconfig        |    2 +-
 drivers/isdn/hardware/avm/Kconfig   |    2 +-
 drivers/isdn/hardware/eicon/Kconfig |    2 +-
 drivers/isdn/hisax/Kconfig          |    2 +-
 drivers/isdn/i4l/Kconfig            |    2 +-
 drivers/media/radio/Kconfig         |    2 +-
 drivers/mtd/chips/Kconfig           |    2 +-
 drivers/mtd/devices/Kconfig         |    2 +-
 drivers/mtd/maps/Kconfig            |    2 +-
 drivers/mtd/nand/Kconfig            |    2 +-
 drivers/net/irda/Kconfig            |    2 +-
 drivers/net/pcmcia/Kconfig          |    2 +-
 drivers/scsi/Kconfig                |    2 +-
 drivers/scsi/pcmcia/Kconfig         |    2 +-
 drivers/usb/input/Kconfig           |    2 +-
 drivers/usb/mon/Kconfig             |    2 +-
 drivers/usb/serial/Kconfig          |    2 +-
 fs/Kconfig                          |    2 +-
 net/atm/Kconfig                     |    2 +-
 net/ax25/Kconfig                    |    2 +-
 net/ipv4/netfilter/Kconfig          |   12 ++++++------
 sound/Kconfig                       |    4 ++--
 sound/aoa/Kconfig                   |    2 +-
 sound/arm/Kconfig                   |    2 +-
 sound/drivers/Kconfig               |    2 +-
 sound/isa/Kconfig                   |    2 +-
 sound/mips/Kconfig                  |    2 +-
 sound/parisc/Kconfig                |    2 +-
 sound/pci/Kconfig                   |    2 +-
 sound/pcmcia/Kconfig                |    2 +-
 sound/ppc/Kconfig                   |    2 +-
 sound/sparc/Kconfig                 |    2 +-
 sound/usb/Kconfig                   |    2 +-
 37 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 17dc222..f90e66b 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -96,7 +96,7 @@ config ACSI_MULTI_LUN

 config ATARI_SLM
 	tristate "Atari SLM laser printer support"
-	depends on ATARI && ATARI_ACSI!=n
+	depends on ATARI && ATARI_ACSI
 	help
 	  If you have an Atari SLM laser printer, say Y to include support for
 	  it in the kernel. Otherwise, say N. This driver is also available as
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
index c0d2854..f6723e7 100644
--- a/drivers/block/paride/Kconfig
+++ b/drivers/block/paride/Kconfig
@@ -7,7 +7,7 @@ # controls the choices given to the user
 # PARIDE only supports PC style parports. Tough for USB or other parports...
 config PARIDE_PARPORT
 	tristate
-	depends on PARIDE!=n
+	depends on PARIDE
 	default m if PARPORT_PC=m
 	default y if PARPORT_PC!=m

diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
index 27c1179..168f758 100644
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -3,7 +3,7 @@ # PCMCIA character device configuration
 #

 menu "PCMCIA character devices"
-	depends on HOTPLUG && PCMCIA!=n
+	depends on HOTPLUG && PCMCIA

 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
diff --git a/drivers/fc4/Kconfig b/drivers/fc4/Kconfig
index 345dbe6..fc1267c 100644
--- a/drivers/fc4/Kconfig
+++ b/drivers/fc4/Kconfig
@@ -26,7 +26,7 @@ comment "FC4 drivers"

 config FC4_SOC
 	tristate "Sun SOC/Sbus"
-	depends on FC4!=n && SPARC
+	depends on FC4 && SPARC
 	help
 	  Serial Optical Channel is an interface card with one or two Fibre
 	  Optic ports, each of which can be connected to a disk array. Note
@@ -38,7 +38,7 @@ config FC4_SOC

 config FC4_SOCAL
 	tristate "Sun SOC+ (aka SOCAL)"
-	depends on FC4!=n && SPARC
+	depends on FC4 && SPARC
 	---help---
 	  Serial Optical Channel Plus is an interface card with up to two
 	  Fibre Optic ports. This card supports FC Arbitrated Loop (usually
@@ -54,7 +54,7 @@ comment "FC4 targets"

 config SCSI_PLUTO
 	tristate "SparcSTORAGE Array 100 and 200 series"
-	depends on FC4!=n && SCSI
+	depends on FC4 && SCSI
 	help
 	  If you never bought a disk array made by Sun, go with N.

@@ -63,7 +63,7 @@ config SCSI_PLUTO

 config SCSI_FCAL
 	tristate "Sun Enterprise Network Array (A5000 and EX500)" if SPARC
-	depends on FC4!=n && SCSI
+	depends on FC4 && SCSI
 	help
 	  This driver drives FC-AL disks connected through a Fibre Channel
 	  card using the drivers/fc4 layer (currently only SOCAL). The most
@@ -75,7 +75,7 @@ config SCSI_FCAL

 config SCSI_FCAL
 	prompt "Generic FC-AL disk driver"
-	depends on FC4!=n && SCSI && !SPARC
+	depends on FC4 && SCSI && !SPARC

 endmenu

diff --git a/drivers/isdn/gigaset/Kconfig b/drivers/isdn/gigaset/Kconfig
index 5b203fe..f788d4d 100644
--- a/drivers/isdn/gigaset/Kconfig
+++ b/drivers/isdn/gigaset/Kconfig
@@ -8,7 +8,7 @@ config ISDN_DRV_GIGASET
 	help
 	  Say m here if you have a Gigaset or Sinus isdn device.

-if ISDN_DRV_GIGASET!=n
+if ISDN_DRV_GIGASET

 config GIGASET_BASE
 	tristate "Gigaset base station support"
diff --git a/drivers/isdn/hardware/avm/Kconfig b/drivers/isdn/hardware/avm/Kconfig
index 29a32a8..1897177 100644
--- a/drivers/isdn/hardware/avm/Kconfig
+++ b/drivers/isdn/hardware/avm/Kconfig
@@ -3,7 +3,7 @@ # ISDN AVM drivers
 #

 menu "Active AVM cards"
-	depends on NET && ISDN && ISDN_CAPI!=n
+	depends on NET && ISDN && ISDN_CAPI

 config CAPI_AVM
 	bool "Support AVM cards"
diff --git a/drivers/isdn/hardware/eicon/Kconfig b/drivers/isdn/hardware/eicon/Kconfig
index 01d4afd..96e773c 100644
--- a/drivers/isdn/hardware/eicon/Kconfig
+++ b/drivers/isdn/hardware/eicon/Kconfig
@@ -3,7 +3,7 @@ # ISDN DIVAS Eicon driver
 #

 menu "Active Eicon DIVA Server cards"
-	depends on NET && ISDN && ISDN_CAPI!=n
+	depends on NET && ISDN && ISDN_CAPI

 config CAPI_EICON
 	bool "Support Eicon cards"
diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index cfd2718..2937c31 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -17,7 +17,7 @@ config ISDN_DRV_HISAX
 	  also to the configuration option of the driver for your particular
 	  card, below.

-if ISDN_DRV_HISAX!=n
+if ISDN_DRV_HISAX

 comment "D-channel protocol features"

diff --git a/drivers/isdn/i4l/Kconfig b/drivers/isdn/i4l/Kconfig
index 3ef567b..10b2e72 100644
--- a/drivers/isdn/i4l/Kconfig
+++ b/drivers/isdn/i4l/Kconfig
@@ -126,7 +126,7 @@ source "drivers/isdn/hisax/Kconfig"


 menu "Active cards"
-	depends on NET && ISDN && ISDN_I4L!=n
+	depends on NET && ISDN && ISDN_I4L

 source "drivers/isdn/icn/Kconfig"

diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 6d96b17..4ab38a8 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -3,7 +3,7 @@ # Multimedia Video device configuration
 #

 menu "Radio Adapters"
-	depends on VIDEO_DEV!=n
+	depends on VIDEO_DEV

 config RADIO_CADET
 	tristate "ADS Cadet AM/FM Tuner"
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 72e6d73..bc0cd5c 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -2,7 +2,7 @@ # drivers/mtd/chips/Kconfig
 # $Id: Kconfig,v 1.18 2005/11/07 11:14:22 gleixner Exp $

 menu "RAM/ROM/Flash chip drivers"
-	depends on MTD!=n
+	depends on MTD

 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 440f685..78e682c 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -2,7 +2,7 @@ # drivers/mtd/maps/Kconfig
 # $Id: Kconfig,v 1.18 2005/11/07 11:14:24 gleixner Exp $

 menu "Self-contained MTD device drivers"
-	depends on MTD!=n
+	depends on MTD

 config MTD_PMC551
 	tristate "Ramix PMC551 PCI Mezzanine RAM card support"
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index d132ed5..06f1a64 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -2,7 +2,7 @@ # drivers/mtd/maps/Kconfig
 # $Id: Kconfig,v 1.61 2005/11/07 11:14:26 gleixner Exp $

 menu "Mapping drivers for chip access"
-	depends on MTD!=n
+	depends on MTD

 config MTD_COMPLEX_MAPPINGS
 	bool "Support non-linear mappings of flash chips"
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 1831340..c472c8b 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -2,7 +2,7 @@ # drivers/mtd/nand/Kconfig
 # $Id: Kconfig,v 1.35 2005/11/07 11:14:30 gleixner Exp $

 menu "NAND Flash Device Drivers"
-	depends on MTD!=n
+	depends on MTD

 config MTD_NAND
 	tristate "NAND Device Support"
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 7c8ccc0..c095f8e 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -1,5 +1,5 @@
 menu "Infrared-port device drivers"
-	depends on IRDA!=n
+	depends on IRDA

 comment "SIR device drivers"

diff --git a/drivers/net/pcmcia/Kconfig b/drivers/net/pcmcia/Kconfig
index 74f8620..b8f9891 100644
--- a/drivers/net/pcmcia/Kconfig
+++ b/drivers/net/pcmcia/Kconfig
@@ -3,7 +3,7 @@ # PCMCIA Network device configuration
 #

 menu "PCMCIA network device support"
-	depends on NETDEVICES && PCMCIA!=n
+	depends on NETDEVICES && PCMCIA

 config NET_PCMCIA
 	bool "PCMCIA network device support"
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 6956909..f79bb7f 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -279,7 +279,7 @@ source "drivers/scsi/libsas/Kconfig"
 endmenu

 menu "SCSI low-level drivers"
-	depends on SCSI!=n
+	depends on SCSI

 config ISCSI_TCP
 	tristate "iSCSI Initiator over TCP/IP"
diff --git a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
index eac8e17..b2aaf68 100644
--- a/drivers/scsi/pcmcia/Kconfig
+++ b/drivers/scsi/pcmcia/Kconfig
@@ -3,7 +3,7 @@ # PCMCIA SCSI adapter configuration
 #

 menu "PCMCIA SCSI adapter support"
-	depends on SCSI!=n && PCMCIA!=n && MODULES
+	depends on SCSI && PCMCIA && MODULES

 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 661af7a..21386cc 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -111,7 +111,7 @@ config USB_HIDDEV
 	  If unsure, say Y.

 menu "USB HID Boot Protocol drivers"
-	depends on USB!=n && USB_HID!=y
+	depends on USB && USB_HID!=y

 config USB_KBD
 	tristate "USB HIDBP Keyboard (simple Boot) support"
diff --git a/drivers/usb/mon/Kconfig b/drivers/usb/mon/Kconfig
index deb9ddf..61cfd50 100644
--- a/drivers/usb/mon/Kconfig
+++ b/drivers/usb/mon/Kconfig
@@ -4,7 +4,7 @@ #

 config USB_MON
 	bool "USB Monitor"
-	depends on USB!=n
+	depends on USB
 	default y
 	help
 	  If you say Y here, a component which captures the USB traffic
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 2f4d303..3c0ec9a 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -3,7 +3,7 @@ # USB Serial device configuration
 #

 menu "USB Serial Converter support"
-	depends on USB!=n
+	depends on USB

 config USB_SERIAL
 	tristate "USB Serial Converter support"
diff --git a/fs/Kconfig b/fs/Kconfig
index b3b5aa0..03362cc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -2002,7 +2002,7 @@ config CIFS_UPCALL

 config NCP_FS
 	tristate "NCP file system support (to mount NetWare volumes)"
-	depends on IPX!=n || INET
+	depends on IPX || INET
 	help
 	  NCP (NetWare Core Protocol) is a protocol that runs over IPX and is
 	  used by Novell NetWare clients to talk to file servers.  It is to
diff --git a/net/atm/Kconfig b/net/atm/Kconfig
index 21ff276..ce49f4d 100644
--- a/net/atm/Kconfig
+++ b/net/atm/Kconfig
@@ -49,7 +49,7 @@ config ATM_LANE

 config ATM_MPOA
 	tristate "Multi-Protocol Over ATM (MPOA) support (EXPERIMENTAL)"
-	depends on ATM && INET && ATM_LANE!=n
+	depends on ATM && INET && ATM_LANE
 	help
 	  Multi-Protocol Over ATM allows ATM edge devices such as routers,
 	  bridges and ATM attached hosts establish direct ATM VCs across
diff --git a/net/ax25/Kconfig b/net/ax25/Kconfig
index a8993a0..4fde920 100644
--- a/net/ax25/Kconfig
+++ b/net/ax25/Kconfig
@@ -102,7 +102,7 @@ config ROSE


 menu "AX.25 network device drivers"
-	depends on HAMRADIO && NET && AX25!=n
+	depends on HAMRADIO && NET && AX25

 source "drivers/net/hamradio/Kconfig"

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 363df99..f6f6f7a 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -515,7 +515,7 @@ config NF_NAT_FTP

 config IP_NF_NAT_IRC
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
 	default IP_NF_NAT if IP_NF_IRC=y
 	default m if IP_NF_IRC=m

@@ -526,7 +526,7 @@ config NF_NAT_IRC

 config IP_NF_NAT_TFTP
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
 	default IP_NF_NAT if IP_NF_TFTP=y
 	default m if IP_NF_TFTP=m

@@ -537,7 +537,7 @@ config NF_NAT_TFTP

 config IP_NF_NAT_AMANDA
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
 	default IP_NF_NAT if IP_NF_AMANDA=y
 	default m if IP_NF_AMANDA=m

@@ -548,7 +548,7 @@ config NF_NAT_AMANDA

 config IP_NF_NAT_PPTP
 	tristate
-	depends on IP_NF_NAT!=n && IP_NF_PPTP!=n
+	depends on IP_NF_NAT && IP_NF_PPTP
 	default IP_NF_NAT if IP_NF_PPTP=y
 	default m if IP_NF_PPTP=m

@@ -560,7 +560,7 @@ config NF_NAT_PPTP

 config IP_NF_NAT_H323
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
 	default IP_NF_NAT if IP_NF_H323=y
 	default m if IP_NF_H323=m

@@ -571,7 +571,7 @@ config NF_NAT_H323

 config IP_NF_NAT_SIP
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
 	default IP_NF_NAT if IP_NF_SIP=y
 	default m if IP_NF_SIP=m

diff --git a/sound/Kconfig b/sound/Kconfig
index 95949b6..9554037 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -37,7 +37,7 @@ source "sound/oss/dmasound/Kconfig"
 if !M68K

 menu "Advanced Linux Sound Architecture"
-	depends on SOUND!=n
+	depends on SOUND

 config SND
 	tristate "Advanced Linux Sound Architecture"
@@ -79,7 +79,7 @@ source "sound/parisc/Kconfig"
 endmenu

 menu "Open Sound System"
-	depends on SOUND!=n
+	depends on SOUND

 config SOUND_PRIME
 	tristate "Open Sound System (DEPRECATED)"
diff --git a/sound/aoa/Kconfig b/sound/aoa/Kconfig
index 5d5813c..a7f770e 100644
--- a/sound/aoa/Kconfig
+++ b/sound/aoa/Kconfig
@@ -1,5 +1,5 @@
 menu "Apple Onboard Audio driver"
-	depends on SND!=n && PPC_PMAC
+	depends on SND && PPC_PMAC

 config SND_AOA
 	tristate "Apple Onboard Audio driver"
diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 2e4a5e0..0a93e12 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -1,7 +1,7 @@
 # ALSA ARM drivers

 menu "ALSA ARM devices"
-	depends on SND!=n && ARM
+	depends on SND && ARM

 config SND_SA11XX_UDA1341
 	tristate "SA11xx UDA1341TS driver (iPaq H3600)"
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 7971285..c9cdd00 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -1,7 +1,7 @@
 # ALSA generic drivers

 menu "Generic devices"
-	depends on SND!=n
+	depends on SND


 config SND_MPU401_UART
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 57371f1..a8d1335 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -1,7 +1,7 @@
 # ALSA ISA drivers

 menu "ISA devices"
-	depends on SND!=n && ISA && ISA_DMA_API
+	depends on SND && ISA && ISA_DMA_API

 config SND_AD1848_LIB
         tristate
diff --git a/sound/mips/Kconfig b/sound/mips/Kconfig
index 531f8ba..cd0d18b 100644
--- a/sound/mips/Kconfig
+++ b/sound/mips/Kconfig
@@ -1,7 +1,7 @@
 # ALSA MIPS drivers

 menu "ALSA MIPS devices"
-	depends on SND!=n && MIPS
+	depends on SND && MIPS

 config SND_AU1X00
 	tristate "Au1x00 AC97 Port Driver"
diff --git a/sound/parisc/Kconfig b/sound/parisc/Kconfig
index a5a7f9d..5680044 100644
--- a/sound/parisc/Kconfig
+++ b/sound/parisc/Kconfig
@@ -1,7 +1,7 @@
 # ALSA PA-RISC drivers

 menu "GSC devices"
-	depends on SND!=n && GSC
+	depends on SND && GSC

 config SND_HARMONY
 	tristate "Harmony/Vivace sound chip"
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 8a6b180..7401348 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -1,7 +1,7 @@
 # ALSA PCI drivers

 menu "PCI devices"
-	depends on SND!=n && PCI
+	depends on SND && PCI

 config SND_AD1889
 	tristate "Analog Devices AD1889"
diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index c9fa1a2..e86a63f 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -1,7 +1,7 @@
 # ALSA PCMCIA drivers

 menu "PCMCIA devices"
-	depends on SND!=n && PCMCIA
+	depends on SND && PCMCIA

 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
diff --git a/sound/ppc/Kconfig b/sound/ppc/Kconfig
index a3fb149..27fdfc7 100644
--- a/sound/ppc/Kconfig
+++ b/sound/ppc/Kconfig
@@ -1,7 +1,7 @@
 # ALSA PowerMac drivers

 menu "ALSA PowerMac devices"
-	depends on SND!=n && PPC
+	depends on SND && PPC

 comment "ALSA PowerMac requires I2C"
 	depends on SND && I2C=n
diff --git a/sound/sparc/Kconfig b/sound/sparc/Kconfig
index 079e22a..e587b4e 100644
--- a/sound/sparc/Kconfig
+++ b/sound/sparc/Kconfig
@@ -1,7 +1,7 @@
 # ALSA Sparc drivers

 menu "ALSA Sparc devices"
-	depends on SND!=n && SPARC
+	depends on SND && SPARC

 config SND_SUN_AMD7930
 	tristate "Sun AMD7930"
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index f05d02f..096b0ee 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -1,7 +1,7 @@
 # ALSA USB drivers

 menu "USB devices"
-	depends on SND!=n && USB!=n
+	depends on SND && USB

 config SND_USB_AUDIO
 	tristate "USB Audio/MIDI driver"
