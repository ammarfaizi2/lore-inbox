Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTA1Vg6>; Tue, 28 Jan 2003 16:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTA1Vg6>; Tue, 28 Jan 2003 16:36:58 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:50600 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S261364AbTA1Vgq>;
	Tue, 28 Jan 2003 16:36:46 -0500
Message-ID: <3E36FA36.9090906@tin.it>
Date: Tue, 28 Jan 2003 22:46:30 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Probably buggy MP Table and ACPI doesn't works
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Which problems do you have at runtime? Do all ide disk work?
>
> I.e. do you have problems with ide, or is the reporting wrong?
> Legacy ide always uses irq 14 and 15, it could be overeager error 
> detection that notices that unused fields in the pci configuration 
> data contain odd values.
>
> Could you add lspci -vxxx -s 00:11.1?
>
> -- 
>    Manfred
>
>
>
>
hi, here my lspci -vvvxx
You have any ideas?

Thanks Bye


00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
   Subsystem: VIA Technologies, Inc.: Unknown device 0000
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
   Latency: 8
   Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
   Capabilities: <available only to root>
00: 06 11 89 31 06 00 30 22 00 00 00 06 00 08 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 
[Normal decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
   Latency: 0
   Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
   I/O behind bridge: 0000f000-00000fff
   Memory behind bridge: dde00000-dfefffff
   Prefetchable memory behind bridge: d5c00000-ddcfffff
   BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
   Capabilities: <available only to root>
00: 06 11 68 b1 07 01 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: e0 dd e0 df c0 d5 c0 dd 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
   Subsystem: Realtek Semiconductor Co., Ltd. RT8139
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (8000ns min, 16000ns max)
   Interrupt: pin A routed to IRQ 19
   Region 0: I/O ports at ec00 [size=256]
   Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
   Capabilities: <available only to root>
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 80 00 00
10: 01 ec 00 00 00 ff ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)
   Subsystem: Micro-star International Co Ltd: Unknown device 5900
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (500ns min, 6000ns max)
   Interrupt: pin A routed to IRQ 16
   Region 0: I/O ports at e800 [size=256]
   Capabilities: <available only to root>
00: f6 13 11 01 05 00 10 02 10 00 01 04 00 80 00 00
10: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 59
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 02 18

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin A routed to IRQ 21
   Region 4: I/O ports at dc00 [size=32]
   Capabilities: <available only to root>
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 dc 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin B routed to IRQ 21
   Region 4: I/O ports at e000 [size=32]
   Capabilities: <available only to root>
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin C routed to IRQ 21
   Region 4: I/O ports at e400 [size=32]
   Capabilities: <available only to root>
00: 06 11 38 30 17 00 10 02 80 00 03 0c 08 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
   Subsystem: VIA Technologies, Inc. USB 2.0
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128, cache line size 08
   Interrupt: pin D routed to IRQ 21
   Region 0: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
   Capabilities: <available only to root>
00: 06 11 04 31 17 00 10 02 82 20 03 0c 08 80 00 00
10: 00 fe ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
   Subsystem: VIA Technologies, Inc.: Unknown device 0000
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 0
   Capabilities: <available only to root>
00: 06 11 77 31 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
   Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 32
   Interrupt: pin A routed to IRQ 0
   Region 4: I/O ports at fc00 [size=16]
   Capabilities: <available only to root>
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 
Ti200] (rev a3) (prog-if 00 [VGA])
   Subsystem: Micro-star International Co Ltd: Unknown device 5105
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 128 (1250ns min, 250ns max)
   Interrupt: pin A routed to IRQ 16
   Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
   Region 1: Memory at d8000000 (32-bit, prefetchable) [size=64M]
   Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=512K]
   Expansion ROM at dfef0000 [disabled] [size=64K]
   Capabilities: <available only to root>
00: de 10 01 02 07 00 b0 02 a3 00 00 03 00 80 00 00
10: 00 00 00 de 08 00 00 d8 08 00 c8 dd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 05 51
30: 00 00 ef df 60 00 00 00 00 00 00 00 0b 01 05 01






