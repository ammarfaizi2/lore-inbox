Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUBXQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUBXQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:03:16 -0500
Received: from 11.ylenurme.ee ([193.40.6.11]:29346 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S262208AbUBXQC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:02:58 -0500
Subject: Multiple Centrino-laptop unknown devices, new IDS, USB nonworking
From: Elmer Joandi <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1077638587.3660.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2004 18:03:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have got here a very noname centrino-laptop, with quite every PCI id
somewhat unknown

1. not talking about Intel WiFi suprise(I bought laptop when I heard
that Intels WiFi is inside, because I knew Intel would support Linux) a
lot. ndiswrapper stuff sortof works sometimes.
2. USB - uhci and ehci loaded, root HUBs visible in lsusb, but no device
causes any interrupt and is no way visible. The same when BIOS USBboot
is on, and it tries to boot. No Windows, can not check that. 2.4 with
the same problem.
3. Audio works, I was suprised
4. Modem probably wont, havent started looking for modules
5. Radeon is fine, dualhead fine, does not blur the screen on modeswitch
either with latest versions of fb or X
6. Havent tried firewire
7. Cardbus -orinoco card sometimes (when in at boot) can not get
interrupt 11, resource temporarily unavailable, and then it can not get
it until next reboot. This was with 2.6.1
8. RTL8139 works, otherwise I would have thrown it to where it came
from.
9. Havent tried sensors, sensors-detect(Fedore core+ updates) can not
	find /proc/bus/i2c, i2c-dev is loaded.
10. IDE works and fast by default
11 cdwriter works

lspci (detailed output repeated at the end of message):
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 03)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 03)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
(rev 03)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
[Radeon Mobility 9000] (rev 01)
02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
02:03.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller

[elmer@localhost linux-2.6.2]$ more /proc/interrupts
           CPU0
  0:    1146038          XT-PIC  timer
  1:       3025          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:        926          XT-PIC  acpi
 10:          0          XT-PIC  uhci_hcd
 11:      25453          XT-PIC  uhci_hcd, uhci_hcd, ohci1394, yenta,
orinoco_cs, Intel 8
2801DB-ICH4
 12:      16605          XT-PIC  i8042
 14:       9870          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0

[root@localhost root]# more /proc/bus/usb/devices

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

[root@localhost root]# lspci -v
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, fast devsel, latency 0
        Memory at b0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if
00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: e0000000-efffffff
        Prefetchable memory behind bridge: a0000000-afffffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
(prog-if 00 [UHCI])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1200 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
(prog-if 00 [UHCI])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1600 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
(prog-if 00 [UHCI])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1700 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: d0000000-dfffffff
        Prefetchable memory behind bridge: 90000000-9fffffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 03)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 03)
(prog-if 8a [Master SecP PriP])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1100 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 03)
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: medium devsel, IRQ 11
        I/O ports at 1400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
(rev 03)
        Subsystem: COMPAL Electronics Inc: Unknown device 0017
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]
        Memory at f0000400 (32-bit, non-prefetchable) [size=512]
        Memory at f0000600 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 03) (prog-if 00
[Generic])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
[Radeon Mobility 9000] (rev 01) (prog-                                if
00 [VGA])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 128,
IRQ 10
        Memory at a8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at c100 [size=256]
        Memory at e0010000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, stepping, medium devsel, latency 128, IRQ 11
        Memory at d0001800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at a100 [size=128]
        Capabilities: [50] Power Management version 2

02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 128, IRQ 11
        I/O ports at a000 [size=256]
        Memory at d0001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
        Subsystem: Intel Corp.: Unknown device 2522
        Flags: bus master, medium devsel, latency 128, IRQ 11
        Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

02:03.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001



