Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278792AbRKAMTc>; Thu, 1 Nov 2001 07:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278541AbRKAMTN>; Thu, 1 Nov 2001 07:19:13 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:48781 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S278792AbRKAMTG>;
	Thu, 1 Nov 2001 07:19:06 -0500
Date: Thu, 1 Nov 2001 13:17:51 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
cc: <linux-usb@vger.kernel.org>, <derick@jdimedia.nl>
Subject: USB oops
Message-ID: <Pine.LNX.4.33.0111011310080.27910-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

insmodding USB stuff oopsed 2.4.13
OOPS and lspci -vv output below.



	Igmar




Nov  1 12:58:34 mars kernel: usb-uhci.c: USB UHCI at I/O 0xfce0, IRQ 9
Nov  1 12:58:34 mars kernel: usb-uhci.c: Detected 2 ports
Nov  1 12:58:34 mars kernel: usb.c: new USB bus registered, assigned bus number 1
Nov  1 12:58:34 mars kernel: hub.c: USB hub found
Nov  1 12:58:34 mars kernel: hub.c: 2 ports detected
Nov  1 12:58:34 mars kernel: usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
Nov  1 12:58:34 mars kernel: usb.c: USB disconnect on device 1
Nov  1 12:58:35 mars kernel: usb.c: USB bus 1 deregistered
Nov  1 12:58:35 mars kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000005
Nov  1 12:58:35 mars kernel:  printing eip:
Nov  1 12:58:35 mars kernel: c021aa2b
Nov  1 12:58:35 mars kernel: *pde = 00000000
Nov  1 12:58:35 mars kernel: Oops: 0000
Nov  1 12:58:35 mars kernel: CPU:    0
Nov  1 12:58:35 mars kernel: EIP:    0010:[usb_alloc_dev+155/176]    Not tainted
Nov  1 12:58:35 mars kernel: EIP:    0010:[<c021aa2b>]    Not tainted
Nov  1 12:58:35 mars kernel: EFLAGS: 00010206
Nov  1 12:58:35 mars kernel: eax: 00000005   ebx: c59f5600   ecx: 00000000   edx: c59f561c
Nov  1 12:58:36 mars kernel: esi: c5fe0cc0   edi: c59f5740   ebp: c5995800   esp: c5fe7f54
Nov  1 12:58:36 mars kernel: ds: 0018   es: 0018   ss: 0018
Nov  1 12:58:36 mars kernel: Process khubd (pid: 8, stackpage=c5fe7000)
Nov  1 12:58:36 mars kernel: Stack: c59f5600 00000200 000000c8 00000000 c021ddcc c59f5600 c5fe0cc0 c5995c00
Nov  1 12:58:36 mars kernel:        00000000 c59f5600 80000180 00000000 000000a3 00000000 00000001 00000301
Nov  1 12:58:36 mars kernel:        c59f5600 00000001 c021df64 c59f5600 00000000 c5fe7fbc c5fe7fbc 00000000
Nov  1 12:58:36 mars kernel: Call Trace: [usb_hub_port_connect_change+636/784] [usb_hub_events+260/656] [usb_hub_thread+53/96] [stext+0/48] [kernel_thread+38/48]
Nov  1 12:58:36 mars kernel: Call Trace: [<c021ddcc>] [<c021df64>] [<c021e125>] [<c0105000>] [<c0105516>]
Nov  1 12:58:36 mars kernel:    [usb_hub_thread+0/96]
Nov  1 12:58:36 mars kernel:    [<c021e0f0>]
Nov  1 12:58:36 mars kernel:
Nov  1 12:58:36 mars kernel: Code: ff 10 89 d8 5b 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00 00 00

lspci -vv :

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:02.0 VGA compatible controller: Trident Microsystems Cyber 9397 (rev f3) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
	Region 1: Memory at fede0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:03.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:03.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcd0 [size=16]

00:03.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fce0 [size=32]

00:03.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 13
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 15
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001




-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

