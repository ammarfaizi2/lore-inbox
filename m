Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271774AbRHRE4e>; Sat, 18 Aug 2001 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271773AbRHRE4Z>; Sat, 18 Aug 2001 00:56:25 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:475 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S271772AbRHRE4O> convert rfc822-to-8bit; Sat, 18 Aug 2001 00:56:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andy Stewart <andystewart@mediaone.net>
Organization: Worcester Linux Users' Group
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.9 locks up solidly with USB and SMP
Date: Sat, 18 Aug 2001 00:56:27 -0400
X-Mailer: KMail [version 1.2]
Cc: andystewart@mediaone.net
MIME-Version: 1.0
Message-Id: <01081800562800.08460@tux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

Please CC any replies to me directly.

With kernel version 2.4.9, my system locks up solidly when I run with SMP 
enabled and attempt to print anything to my USB printer.   I have seen 
this behavior for the last few kernel revs.

SMP without USB seems to work properly.  USB in uniprocessor mode is also 
working properly.

I have usbcore and usb-uhci loaded as modules.

My motherboard is a Tyan Thunderbolt S1837 with two Intel Pentium 3s at 
450 MHz. and 256 MB of memory.  The output from "lspci -v" is appended to 
this e-mail.  I'm not sure what other information I could provide that 
would help isolate this problem.  I would be happy to provide more - 
please ask.

It is unclear to me if I am doing something wrong, if this is a bug in the 
kernel, or a bug in my hardware.  Any help would be most appreciated.

Thanks in advance,

Andy Stewart
Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org


====== output of lspci -v ======

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 
00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fd600000-fe6fffff
	Prefetchable memory behind bridge: f1400000-f54fffff

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:0b.0 SCSI storage controller: Adaptec 7896
	Subsystem: Adaptec: Unknown device 080f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	BIST result: 00
	I/O ports at e400 [disabled] [size=256]
	Memory at febfe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

00:0b.1 SCSI storage controller: Adaptec 7896
	Subsystem: Adaptec: Unknown device 080f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	BIST result: 00
	I/O ports at e800 [disabled] [size=256]
	Memory at febff000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1

00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 9
	I/O ports at ef00 [size=64]
	Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ee80 [size=64]
	Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe900000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at f2000000 (32-bit, prefetchable) [size=32M]
	Memory at fe6fc000 (32-bit, non-prefetchable) [size=16K]
	Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at fe6e0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

==================

