Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSJPNRU>; Wed, 16 Oct 2002 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPNRU>; Wed, 16 Oct 2002 09:17:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:18130 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262472AbSJPNRS>; Wed, 16 Oct 2002 09:17:18 -0400
Date: Wed, 16 Oct 2002 15:19:17 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Kernels > 2.4.18 *not* booting (epox 4g4a+, 845g)
Message-ID: <20021016131916.GA575@links2linux.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.17 i686
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I experienced a problem with Kernel 2.4 not booting on my EPoX 4G4A+
(Intel 845G chipset, HPT372 IDE-RAID).

- Celeron 1700MHz
- 512MB

The last thing it says is:

Uncompressing Linux... Ok, now booting the kernel.
<here it hangs>

With Kernels < 2.4.19 the kernel option (append=)
mem=504 
does help (RAM - Graphics shared mem)

But with newer ones this does not work anymore :-(
I tested Debian 2.4.19-686, vanilla 2.4.19 / 2.4.20-pre11

How can I track down that problem?

Which information can I provide to you to help?

Best regards,
-Marc

Here is a lspci -v if that helps:
-----------------------------8<----------------------------------
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
	Subsystem: Unknown device 1695:4002
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [0105]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev 01) (prog-if 00 [VGA])
	Subsystem: Unknown device 1695:9002
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Memory at ee000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4002
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4002
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4002
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at b400 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: ec000000-edffffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1695:4002
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at f000 [size=16]
	Memory at 1f800000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
	Subsystem: Unknown device 1695:4002
	Flags: medium devsel, IRQ 17
	I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
	Subsystem: Unknown device 1695:4002
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at c000 [size=256]
	I/O ports at c400 [size=64]
	Memory at ee081000 (32-bit, non-prefetchable) [size=512]
	Memory at ee082000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:00.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at 9000 [disabled] [size=256]
	Memory at ed000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:03.0 RAID bus controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 05)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 21
	I/O ports at 9400 [size=8]
	I/O ports at 9800 [size=4]
	I/O ports at 9c00 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at a400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Unknown device 1695:9001
	Flags: bus master, medium devsel, latency 32, IRQ 22
	I/O ports at a800 [size=256]
	Memory at ed001000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2

01:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Allied Telesyn International AT-2500TX/ACPI
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at ac00 [size=256]
	Memory at ed002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

-----------------------------8<----------------------------------

-- 
-------------------------------------------
Take back the Net! http://www.anti-dmca.org
-------------------------------------------
