Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272099AbRIELpR>; Wed, 5 Sep 2001 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272102AbRIELpH>; Wed, 5 Sep 2001 07:45:07 -0400
Received: from pd41.jeleniag.cvx.ppp.tpnet.pl ([213.77.236.41]:7684 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S272099AbRIELou>; Wed, 5 Sep 2001 07:44:50 -0400
From: marpet@linuxpl.org
Date: Wed, 5 Sep 2001 13:45:35 +0200
To: linux-kernel@vger.kernel.org
Subject: VIA VT8233
Message-ID: <20010905134535.A1142@marek.almaran.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What is the status of support of the VIA VT8233 Southbridge in the
recent kernel versions? When grepping through the sources I get
the VT8233 in a few places, but my system doesn't seem to recognize
it:

$ lspci -v

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3099
	Subsystem: Elitegroup Computer Systems: Unknown device 0996
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b099 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e6000000-e7ffffff
	Prefetchable memory behind bridge: e4000000-e5ffffff
	Capabilities: [80] Power Management version 2

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d000 [size=256]
	Memory at e8000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3074
	Subsystem: Elitegroup Computer Systems: Unknown device 0996
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Flags: bus master, medium devsel, latency 32
	I/O ports at d400 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

00:11.4 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc.: Unknown device 3059 (rev 10)
	Subsystem: Elitegroup Computer Systems: Unknown device 0996
	Flags: medium devsel, IRQ 11
	I/O ports at e400 [size=256]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
	Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0


it is 2.4.9-ac7 with:

CONFIG_BLK_DEV_VIA82CXXX=y

The other thing is: are there any chances for Linux to support the AC97
codec built into VT8233?

regards and best wishes

-- 
Marek Pêtlicki <marpet@linuxpl.org>
Linux User ID=162988

