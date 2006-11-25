Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757648AbWKYDll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648AbWKYDll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 22:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935135AbWKYDll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 22:41:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:51930 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1757642AbWKYDlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 22:41:40 -0500
Message-ID: <4567BB70.6080907@comcast.net>
Date: Fri, 24 Nov 2006 22:41:36 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5-mm2 : usb keeps resetting usb keyboard.
Content-Type: multipart/mixed;
 boundary="------------090303040100060608050607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303040100060608050607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



I just upgraded from a ps2 keyboard to usb and have been getting these 
messages seemingly randomly, which also corresponds to whatever key i'm 
pressing at the time they occur to act like it's stuck down.  

usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3
usb 2-2: reset low speed USB device using ohci_hcd and address 3

(repeated a few hundred times )


The keyboard is detected as
Bus 002 Device 002: ID 1267:0103 Logic3 / SpectraVideo plc


Any further input needed?  




below is my lspci output :   Attached is more verbose output.

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 
6600] (rev a2)
05:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
05:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)


--------------090303040100060608050607
Content-Type: text/plain;
 name="lspci_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_output.txt"

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: 66MHz, fast devsel, IRQ 255
	I/O ports at e400 [size=32]
	I/O ports at 4c00 [size=64]
	I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	Memory at c8104000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
	Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=256]
	Memory at c8103000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device f043:815a
	Flags: bus master, 66MHz, fast devsel, latency 0
	[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	[virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	[virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 815a
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
	I/O ports at 09f0 [size=8]
	I/O ports at 0bf0 [size=4]
	I/O ports at 0970 [size=8]
	I/O ports at 0b70 [size=4]
	I/O ports at d800 [size=16]
	Memory at c8102000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
	I/O ports at 09e0 [size=8]
	I/O ports at 0be0 [size=4]
	I/O ports at 0960 [size=8]
	I/O ports at 0b60 [size=4]
	I/O ports at c400 [size=16]
	Memory at c8101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
	Prefetchable memory behind bridge: c8000000-c80fffff

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
	Memory at c8100000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at b000 [size=8]
	Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: c0000000-c7ffffff
	Prefetchable memory behind bridge: 00000000b0000000-00000000bfffffff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Unknown device 81b0
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at c0000000 (32-bit, non-prefetchable) [size=64M]
	Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Memory at c4000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at c5000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

05:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 32, IRQ 255
	Memory at c8000000 (32-bit, prefetchable) [size=4K]

05:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Flags: bus master, medium devsel, latency 32, IRQ 255
	Memory at c8001000 (32-bit, prefetchable) [size=4K]


--------------090303040100060608050607--
