Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSGSUdi>; Fri, 19 Jul 2002 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSGSUdi>; Fri, 19 Jul 2002 16:33:38 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:6092 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317024AbSGSUdh>; Fri, 19 Jul 2002 16:33:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19-rc2-ac2
References: <200207161713.g6GHDhw02197@devserv.devel.redhat.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 19 Jul 2002 16:36:38 -0400
In-Reply-To: <200207161713.g6GHDhw02197@devserv.devel.redhat.com>
Message-ID: <9cfadonmp49.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Fujitsu P-2110 which has an ALI15X3 controller.  RedHat's 7.2
kernel (2.4.9-mumble) boots OK when I specify 'ide0=ata66 ide1=ata66';
otherwise, PIO only.

Trying out 2.4.19-rc2-ac2, the machine hangs during boot when bringing
up the ALI15X3 driver, no matter what I give on the kernel command
line.

Any clues?

output of /sbin/lspci -v:

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 02)
	Subsystem: Citicorp TTI: Unknown device 110e
	Flags: bus master, medium devsel, latency 64
	Memory at fc100000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Citicorp TTI: Unknown device 110e
	Flags: fast devsel

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Citicorp TTI: Unknown device 110e
	Flags: fast devsel

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Citicorp TTI: Unknown device 10a2
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at fc004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown device 5451 (rev 01)
	Subsystem: Citicorp TTI: Unknown device 112f
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1000 [size=256]
	Memory at fc005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Citicorp TTI: Unknown device 10a3
	Flags: medium devsel

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: <available only to root>

00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Citicorp TTI: Unknown device 10c6
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 17100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 17400000-177ff000 (prefetchable)
	Memory window 1: 17800000-17bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if fa)
	Subsystem: Citicorp TTI: Unknown device 10a4
	Flags: bus master, medium devsel, latency 32
	I/O ports at 1800 [size=16]
	Capabilities: <available only to root>

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Citicorp TTI: Unknown device 111c
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 8000 [size=256]
	Memory at fc007800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:13.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8026 (prog-if 10 [OHCI])
	Subsystem: Citicorp TTI: Unknown device 1162
	Flags: medium devsel, IRQ 9
	Memory at fc007000 (32-bit, non-prefetchable) [size=2K]
	Memory at fc000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

00:14.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M (rev 64) (prog-if 00 [VGA])
	Subsystem: Citicorp TTI: Unknown device 114f
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 9
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 1400 [size=256]
	Memory at fc006000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>


