Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTJPPZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTJPPZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 11:25:23 -0400
Received: from sea2-dav14.sea2.hotmail.com ([207.68.164.118]:11017 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263004AbTJPPZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 11:25:07 -0400
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3C905 + options=0x8
Date: Thu, 16 Oct 2003 17:25:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV142dkFpnzQd00004019@hotmail.com>
X-OriginalArrivalTime: 16 Oct 2003 15:25:02.0212 (UTC) FILETIME=[AB08B440:01C393F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I have found a strange 3C905 behaviour on linux 2.4.22 (same behaviuor
with 2.4.19)
When the linux box boot with /etc/modules.conf containing:
options 3c59x options=0x8,0x8,0x8

the 3C905 NICs don't receive/send packet.
3C905B NIC is working good.

This is the relevant section from dmesg:

PCI: Found IRQ 10 for device 00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0f.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xe400. Vers LK1.1.18-ac
 00:60:97:d8:e5:01, IRQ 10
  product code 4848 rev 00.0 date 04-28-97
  Internal config register is 102001b, transceivers 0xe040.
  64K word-wide RAM 1:1 Rx:Tx split, autoselect/10baseT interface.
00:0f.0:  Media override to transceiver type 8 (Autonegotiate).
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
00:0f.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
PCI: Found IRQ 11 for device 00:12.0
See Documentation/networking/vortex.txt
00:12.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xec00. Vers LK1.1.18-ac
 00:60:97:d8:e5:f1, IRQ 11
  product code 4848 rev 00.0 date 04-28-97
  Internal config register is 102001b, transceivers 0xe040.
  64K word-wide RAM 1:1 Rx:Tx split, autoselect/10baseT interface.
00:12.0:  Media override to transceiver type 8 (Autonegotiate).
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
00:12.0: scatter/gather enabled. h/w checksums disabled
eth1: Dropping NETIF_F_SG since no checksum feature.
PCI: Found IRQ 12 for device 00:10.0
PCI: Sharing IRQ 12 with 00:04.0
See Documentation/networking/vortex.txt
00:10.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe800. Vers LK1.1.18-ac
 00:50:04:63:dd:55, IRQ 12
  product code 5447 rev 00.9 date 02-07-99
  Internal config register is 1000000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/10baseT interface.
00:10.0:  Media override to transceiver type 8 (Autonegotiate).
  MII transceiver found at address 24, status 780d.
  Enabling bus-master transmits and whole-frame receives.
00:10.0: scatter/gather enabled. h/w checksums enabled

This is the lspci -vx output:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
 Flags: bus master, medium devsel, latency 64
 Memory at e0000000 (32-bit, prefetchable) [size=64M]
 Capabilities: [a0] AGP version 1.0
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
 Flags: bus master, 66Mhz, medium devsel, latency 64
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: e4000000-e5ffffff
 Prefetchable memory behind bridge: e6000000-e6ffffff
00: 86 80 91 71 07 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 d0 d0 a0 22
20: 00 e4 f0 e5 00 e6 f0 e6 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:04.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
 Subsystem: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio
Accelerator]
 Flags: bus master, medium devsel, latency 64, IRQ 12
 Memory at ea100000 (32-bit, non-prefetchable) [size=4K]
 Memory at ea000000 (32-bit, non-prefetchable) [size=1M]
 Capabilities: [40] Power Management version 2
00: 13 10 03 60 06 00 10 02 01 00 01 04 00 40 00 00
10: 00 00 10 ea 00 00 00 ea 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 10 03 60
30: 00 00 00 00 40 00 00 00 00 00 00 00 0c 01 04 18

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
 Flags: bus master, medium devsel, latency 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
 Flags: bus master, medium devsel, latency 64
 I/O ports at f000 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
 Flags: bus master, medium devsel, latency 64, IRQ 3
 I/O ports at e000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 04 00 00

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
 Flags: medium devsel, IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
 Flags: bus master, medium devsel, latency 64, IRQ 10
 I/O ports at e400 [size=64]
 Expansion ROM at e7000000 [disabled] [size=64K]
00: b7 10 50 90 07 00 00 02 00 00 00 02 00 40 00 00
10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 e7 00 00 00 00 00 00 00 00 0a 01 03 08

00:10.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)
 Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
 Flags: bus master, medium devsel, latency 64, IRQ 12
 I/O ports at e800 [size=128]
 Memory at ea101000 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at e8000000 [disabled] [size=128K]
 Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 64 00 00 02 08 40 00 00
10: 01 e8 00 00 00 10 10 ea 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 e8 dc 00 00 00 00 00 00 00 0c 01 0a 0a

00:12.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
 Flags: bus master, medium devsel, latency 64, IRQ 11
 I/O ports at ec00 [size=64]
 Expansion ROM at e9000000 [disabled] [size=64K]
00: b7 10 50 90 07 00 00 02 00 00 00 02 00 40 00 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 e9 00 00 00 00 00 00 00 00 0b 01 03 08

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 03) (prog-if 00 [VGA])
 Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
 Flags: bus master, medium devsel, latency 64, IRQ 11
 Memory at e6000000 (32-bit, prefetchable) [size=16M]
 Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
 Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
 Capabilities: [dc] Power Management version 1
 Capabilities: [f0] AGP version 1.0
00: 2b 10 21 05 07 00 90 02 03 00 00 03 08 40 00 00
10: 08 00 00 e6 00 00 00 e4 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 00 ff
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20

My env: Slackware 9.1 (gcc 3.2.3, glibc 2.3.2)
