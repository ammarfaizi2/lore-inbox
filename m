Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFFMA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFFMA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFFMA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:00:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:38880 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261317AbVFFMAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:00:03 -0400
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Mon, 06 Jun 2005 13:59:56 +1
MIME-Version: 1.0
Subject: problem with kernel 2.4.30 on p3-500 with asus cubx-mainboard
Reply-To: Dieter.Ferdinand@gmx.de
Message-ID: <42A456DC.19128.6C478081@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a, DE v4.12a R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have a system to record video with 4 dvb's-cards.

this systems hangs to oft in last two weeks and all is dead, no reaction to ping from 
network or keyboard.

to find out, why the system hangs, i change some parameters from kernel and build 
a new kernel.

last i try to change the irq-order and the order from the pci-cards.

i think, that at the moment, the system hangs, a harddisk access or a network-
access is handled while i access one or both of them, if the system hangs.

only a hardware-reset is possible at this time.

a similarly system with some other components (asus p2b-s adaptec uw-scsi on 
board, p3-450 and only two dvb-cards) works fine.

i have no more ideas, what i can do, to find a cause for this problem.

thank you for your help.

at the moment, the pci-cards are in this order:
aha2940 UW
DVB-card
3c905b
3 dvd-cards

irq:
  0:     868630          XT-PIC  timer
  1:         10          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          8          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:    6881671          XT-PIC  saa7146(3), eth0
 11:    2199193          XT-PIC  saa7146(0), saa7146(2)
 14:     238666          XT-PIC  aic7xxx
 15:    5968690          XT-PIC  saa7146(1)
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

cpu:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 501.144
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips        : 999.42

lspci -v:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
 Subsystem: Asustek Computer, Inc.: Unknown device 8025
 Flags: bus master, medium devsel, latency 64
 Memory at e4000000 (32-bit, prefetchable) [size=64M]
 Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
 Flags: bus master, 66Mhz, medium devsel, latency 64
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: e2000000-e2dfffff
 Prefetchable memory behind bridge: e2f00000-e3ffffff

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
 Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
 Flags: medium devsel
 I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
 Flags: bus master, medium devsel, latency 32, IRQ 11
 I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
 Flags: medium devsel, IRQ 9

00:09.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
 Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
 Flags: bus master, medium devsel, latency 32, IRQ 11
 Memory at e1800000 (32-bit, non-prefetchable) [size=512]

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
 Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
 Flags: bus master, medium devsel, latency 32, IRQ 10
 I/O ports at b000 [size=128]
 Memory at e1000000 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [dc] Power Management version 1

00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
 Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
 Flags: bus master, medium devsel, latency 32, IRQ 15
 Memory at e0800000 (32-bit, non-prefetchable) [size=512]

00:0c.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
 Flags: bus master, medium devsel, latency 32, IRQ 14
 I/O ports at a800 [disabled] [size=256]
 Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
 Expansion ROM at <unassigned> [disabled] [size=64K]

00:0d.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
 Subsystem: Technotrend Systemtechnik GmbH: Unknown device 100f
 Flags: bus master, medium devsel, latency 32, IRQ 11
 Memory at df800000 (32-bit, non-prefetchable) [size=512]

00:0e.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
 Subsystem: Technotrend Systemtechnik GmbH: Unknown device 100f
 Flags: bus master, medium devsel, latency 32, IRQ 10
 Memory at df000000 (32-bit, non-prefetchable) [size=512]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP
(rev 7a) (prog-if 00 [VGA])
 Subsystem: ATI Technologies Inc: Unknown device 0084
 Flags: bus master, stepping, medium devsel, latency 64, IRQ 14
 Memory at e3000000 (32-bit, prefetchable) [size=16M]
 I/O ports at d800 [size=256]
 Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
 Expansion ROM at e2fe0000 [disabled] [size=128K]
 Capabilities: [5c] Power Management version 1



Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

