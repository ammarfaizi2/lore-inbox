Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130806AbQKLUAi>; Sun, 12 Nov 2000 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130841AbQKLUA2>; Sun, 12 Nov 2000 15:00:28 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:35850 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130806AbQKLUAU>; Sun, 12 Nov 2000 15:00:20 -0500
Message-ID: <3A0EF8A8.813816AD@gmx.de>
Date: Sun, 12 Nov 2000 21:08:08 +0100
From: 320058123427-0001@t-online.de (Werner Hager)
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UHCI broken on K7V since test10pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

test10pre6 works fine here with an IntelliExplorer and ELSA ML56k USB.
Later kernels produce:
Interrupt 5/9?

(test11pre1)
Nov 10 01:13:50 antheus kernel: uhci.c: USB UHCI at I/O 0xd400, IRQ 5
Nov 10 01:13:50 antheus kernel: uhci.c: detected 2 ports
Nov 10 01:13:50 antheus kernel: uhci: host system error, PCI problems?
Nov 10 01:13:50 antheus kernel: uhci: host controller halted. very bad
Nov 10 01:13:50 antheus kernel: uhci.c: USB UHCI at I/O 0xd000, IRQ 5
Nov 10 01:13:50 antheus kernel: uhci.c: detected 2 ports
Nov 10 01:13:50 antheus kernel: uhci: host controller halted. very bad
Nov 10 01:13:50 antheus kernel: uhci: host system error, PCI problems?
Nov 10 01:13:50 antheus kernel: uhci: host controller halted. very bad
[...]

(test10pre6)
root@antheus /root]# cat /proc/interrupts 
           CPU0       
  0:     653708          XT-PIC  timer
  1:      16109          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:     285422          XT-PIC  acpi, usb-uhci, usb-uhci, EMU10K1, eth0
 10:     212848          XT-PIC  sym53c8xx
 13:          0          XT-PIC  fpu
 14:     154915          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0 
ERR:          0

My System is RH 7 on an Asus K7V. 

Thanks,
Werner




PS: (test10pre6)
[root@antheus /root]# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8023
	Flags: bus master, medium devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e0000000-e17fffff
	Prefetchable memory behind bridge: e2f00000-e3ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
21)
	Subsystem: Asustek Computer, Inc.: Unknown device 8023
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, stepping, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 0
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 0
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30
)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev
 30)
	Subsystem: Accton Technology Corporation Cheetah Fast Ethernet
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at a400 [size=128]
	Memory at df800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at e2000000 (32-bit, prefetchable) [size=4K]

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at e1800000 (32-bit, prefetchable) [size=4K]

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c810 (rev 2
3)
	Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at a000 [size=256]
	Memory at df000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 04)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9800 [size=32]
	Capabilities: [dc] Power Management version 1

00:0d.1 Input device controller: Creative Labs SB Live! (rev 01)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9400 [size=8]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128
[NV04] (rev 0
4) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc. V3400 TNT
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e3000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at e2ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 1.0
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
