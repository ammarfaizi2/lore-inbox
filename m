Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRLZOTS>; Wed, 26 Dec 2001 09:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRLZOTJ>; Wed, 26 Dec 2001 09:19:09 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:6016 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S279798AbRLZOTA>; Wed, 26 Dec 2001 09:19:00 -0500
Date: Wed, 26 Dec 2001 12:18:59 -0200
From: Henrique de Moraes Holschuh <hmh@rcm.org.br>
To: linux-kernel@vger.kernel.org
Subject: Re: PDC20265 ide_dma_timeout and RAID5 issues (2.4.17)
Message-ID: <20011226121859.B1700@khazad-dum>
In-Reply-To: <20011226120617.A1316@khazad-dum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011226120617.A1316@khazad-dum>; from hmh@rcm.org.br on Wed, Dec 26, 2001 at 12:06:17PM -0200
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duh, forgot to attach lspci -v output. Here it is...

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Flags: bus master, medium devsel, latency 8
	Memory at e7000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-e6ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at a400 [size=128]
	Memory at d5800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

00:0a.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: KYE Systems Corporation: Unknown device 7003
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
	Memory at d4800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at a000 [size=8]
	I/O ports at 9800 [size=4]
	I/O ports at 9400 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8800 [size=64]
	Memory at d4000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev b2) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 4031
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
