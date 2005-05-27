Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVE0Tfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVE0Tfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVE0Tfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:35:55 -0400
Received: from main.gmane.org ([80.91.229.2]:12426 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262559AbVE0Tdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:33:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody
   cared!"
Date: Fri, 27 May 2005 21:30:28 +0200
Message-ID: <d77sch$4sf$1@sea.gmane.org>
References: <d6gf8j$jnb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <d6gf8j$jnb$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to add more informations for you if you say me how I can
help. The problem is not solved in kernel 2.6.12rc5.

Here is my lspci output. Perhaps it is helpfull for you.

# lspci -v
0000:00:00.0 Host bridge: Intel Corp. 915G/P/GV Processor to I/O
Controller (rev 04)
        Subsystem: Intel Corp. 915G/P/GV Processor to I/O Controller
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corp. 915G/P/GV PCI Express Root Port
(rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: d0000000-d6ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 813d
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at cfdf4000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: cff00000-cfffffff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 50
        I/O ports at 4400 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at 4800 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 217
        I/O ports at 5000 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at 5400 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 50
        Memory at cfdff800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3) (prog-if
01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-0000bfff
        Memory behind bridge: cfe00000-cfefffff
        Prefetchable memory behind bridge: 00000000d7f00000-00000000d7f00000
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 03)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 217
        I/O ports at 7000 [size=8]
        I/O ports at 6800 [size=4]
        I/O ports at 6400 [size=8]
        I/O ports at 6000 [size=4]
        I/O ports at 5800 [size=16]

0000:00:1f.2 IDE interface: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA
Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 2601
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 225
        I/O ports at 8800 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8000 [size=8]
        I/O ports at 7800 [size=4]
        I/O ports at 7400 [size=16]
        Memory at cfdffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Flags: medium devsel
        I/O ports at 0400 [size=32]

0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 813c
        Flags: bus master, medium devsel, latency 64, IRQ 233
        Memory at cfefb800 (32-bit, non-prefetchable) [size=2K]
        Memory at cfef4000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:01:04.0 Unknown mass storage controller: Integrated Technology
Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version
seems to be IT8212, embedded seems (rev 13)
        Subsystem: Asustek Computer, Inc.: Unknown device 813a
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 5
        I/O ports at b000 [size=8]
        I/O ports at a800 [size=4]
        I/O ports at a400 [size=8]
        I/O ports at a000 [size=4]
        I/O ports at 9800 [size=16]
        Expansion ROM at cfea0000 [disabled] [size=128K]
        Capabilities: [80] Power Management version 2

0000:01:06.0 Ethernet controller: Marvell Technology Group Ltd. Yukon
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
        Subsystem: Asustek Computer, Inc.: Unknown device 811a
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 169
        Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
        I/O ports at b400 [size=256]
        Expansion ROM at cfec0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data

0000:01:09.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 64, IRQ 201
        Memory at d7ffe000 (32-bit, prefetchable) [size=4K]

0000:01:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 64, IRQ 201
        Memory at d7fff000 (32-bit, prefetchable) [size=4K]

0000:01:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 64, IRQ 233
        I/O ports at b800 [size=64]

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown
device 4362 (rev 15)
        Subsystem: Asustek Computer, Inc.: Unknown device 8142
        Flags: bus master, fast devsel, latency 0, IRQ 5
        Memory at cfffc000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at c800 [size=256]
        Expansion ROM at cffc0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [e0] #10 [0011]

0000:04:00.0 VGA compatible controller: nVidia Corporation: Unknown
device 0140 (rev a2) (prog-if 00 [VGA])
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Memory at d8000000 (64-bit, prefetchable) [size=128M]
        Memory at d6000000 (64-bit, non-prefetchable) [size=16M]
        Expansion ROM at d5fe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [78] #10 [0001]


