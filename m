Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269230AbUICEqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269230AbUICEqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269355AbUICEqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:46:36 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:54045 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269230AbUICEps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:45:48 -0400
Message-ID: <75ff465404090221455f7ce800@mail.gmail.com>
Date: Fri, 3 Sep 2004 00:45:48 -0400
From: Shawn Starr <spstarr@gmail.com>
Reply-To: Shawn Starr <spstarr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9-rc1-bk7][USB HID] Problem with USB <-> PS/2 converter for keyboard - USB port timeouts
Cc: linux-usb-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel dump of error:

uhci_hcd 0000:00:1d.1: wakeup_hc
uhci_hcd 0000:00:1d.1: port 1 portsc 00b2
hub 2-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 3 status
001c03 POWER sig=?  CSC CONNECT
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
hub 4-0:1.0: port 3 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status
003c01 POWER OWNER sig=?  CONNECT
uhci_hcd 0000:00:1d.1: suspend_hc

This continues until i press too many keys and then the device USB port gets
shut down.

I will provide more info If requested. Looking at the PS/2 keyboard to USB
converter there is no company name on it.

/proc/bus/usb/devices:

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.9-rc1-bk7 ehci_hcd
S:  Product=Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.9-rc1-bk7 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #3
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.9-rc1-bk7 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #2
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.9-rc1-bk7 uhci_hcd
S:  Product=Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #1
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms


lspci -v:

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller
 (rev 03)
        Subsystem: IBM: Unknown device 0529
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Flags: bus master, medium devsel, latency 0, IRQ 3
        Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge: e8000000-efffffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
01)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1860 [size=16]
        Memory at 3ff79000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 01)
        Subsystem: IBM: Unknown device 052d
        Flags: medium devsel, IRQ 5
        I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0554
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1c00 [size=256]
        I/O ports at 18c0 [size=64]
        Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at c0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
Modem Controller (rev 01) (prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 055a
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 2400 [size=256]
        I/O ports at 2000 [size=128]
        Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0550
        Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 66,
IRQ 9
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 3000 [size=256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: <available only to root>

0000:02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus
Controller (rev 01)
        Subsystem: IBM: Unknown device 0552
        Flags: bus master, medium devsel, latency 168, IRQ 9
        Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 40000000-403ff000 (prefetchable)
        Memory window 1: 40400000-407ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus
Controller (rev 01)
        Subsystem: IBM: Unknown device 0552
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 40800000-40bff000 (prefetchable)
        Memory window 1: 40c00000-40fff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 9
        Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
        Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at 8000 [size=64]
        Capabilities: <available only to root>

0000:02:02.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
        Subsystem: Intel Corp.: Unknown device 2711
        Flags: medium devsel, IRQ 10
        Memory at c0210000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>


Anyone had this problem? 

Shawn.
(cant send this email via rogers.com dont know why..)
