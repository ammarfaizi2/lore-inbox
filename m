Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFDMwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTFDMwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:52:37 -0400
Received: from mail.eris.dera.gov.uk ([128.98.1.1]:14695 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S262633AbTFDMwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:52:32 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc6-ac2 usb-ohci fun
Date: Wed, 4 Jun 2003 14:00:04 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306041400.04969.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Booting 2.4.21-rc6-ac2 on a Dell Poweredge 2650 server:

/etc/modules.conf contains (among other things):

probeall usb-interface usb-ohci

This does not appear to be being honoured, since usb-ohci is not being loaded at boot (so nothing USB works until I modprobe it).

I've tried using an initrd but this makes no difference.

Mandrake patched 2.4.21-rc1 _does_ work on the same box.


Any hints would be useful.

Ta,

Mark.

00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
	Flags: fast devsel

00:00.1 Host bridge: ServerWorks CMIC-LE
	Flags: fast devsel

00:00.2 Host bridge: ServerWorks: Unknown device 0000
	Flags: fast devsel

00:04.0 Class ff00: Dell Computer Corporation Embedded Systems Management Device 4
	Subsystem: Dell Computer Corporation Embedded Systems Management Device 4
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at feb80000 (32-bit, prefetchable) [size=4K]
	I/O ports at ecf8 [size=8]
	I/O ports at ece8 [size=8]
	Expansion ROM at fe000000 [disabled] [size=64K]
	Capabilities: [48] Power Management version 2

00:04.1 Class ff00: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
	Subsystem: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
	Flags: medium devsel, IRQ 23
	Memory at fe102000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ec80 [size=64]
	Memory at feb00000 (32-bit, prefetchable) [size=512K]
	Capabilities: [48] Power Management version 2

00:04.2 Class ff00: Dell Computer Corporation: Unknown device 000d
	Subsystem: Dell Computer Corporation: Unknown device 000d
	Flags: medium devsel, IRQ 27
	I/O ports at ecf4 [size=4]
	Capabilities: [48] Power Management version 2

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 0121
	Flags: bus master, VGA palette snoop, stepping, medium devsel, latency 32
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at e800 [size=256]
	Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
	Subsystem: ServerWorks CSB5 South Bridge
	Flags: bus master, medium devsel, latency 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks CSB5 IDE Controller
	Flags: bus master, medium devsel, latency 64
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks GCLE Host Bridge
	Subsystem: ServerWorks: Unknown device 0230
	Flags: bus master, medium devsel, latency 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	Flags: 66Mhz, medium devsel
	Capabilities: [60] 
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	Flags: 66Mhz, medium devsel
	Capabilities: [60] 
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	Flags: 66Mhz, medium devsel
	Capabilities: [60] 
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
	Flags: 66Mhz, medium devsel
	Capabilities: [60] 
01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 20
	Memory at fcf20000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at dcc0 [size=64]
	Memory at fcf00000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2

03:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
	Subsystem: Dell Computer Corporation Broadcom BCM5701 1000Base-T
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 28
	Memory at fcd10000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

03:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
	Subsystem: Dell Computer Corporation Broadcom BCM5701 1000Base-T
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 29
	Memory at fcd00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

04:08.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, slow devsel, latency 32
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fca00000-fcbfffff
	Capabilities: [68] Power Management version 2

04:08.1 RAID bus controller: Dell Computer Corporation PowerEdge Expandable RAID Controller 3 (rev 01)
	Subsystem: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
	Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 30
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fc900000 [disabled] [size=64K]
	Capabilities: [80] Power Management version 2

05:06.0 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
	Subsystem: Dell Computer Corporation PowerEdge 2550
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 30
	BIST result: 00
	I/O ports at ac00 [size=256]
	Memory at fcaff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fcb00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

05:06.1 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
	Subsystem: Dell Computer Corporation PowerEdge 2550
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 31
	BIST result: 00
	I/O ports at a800 [size=256]
	Memory at fcafe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fcb00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2


- -- 
Mark Watts
Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3e1UBn4EFUVUIO0RAqQ9AKC3JE/ss/skx0X8yxtgcx/En/yxqwCg93p3
liFCrk0qXeoKcjlc90A3Zxs=
=FIfb
-----END PGP SIGNATURE-----

