Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTG2QLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTG2QIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:08:48 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:11748 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271837AbTG2QHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:07:31 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <herbert@13thfloor.at>, <linux-kernel@vger.kernel.org>
Subject: RE: Problems related to DMA or DDR memory on Intel 845 chipset?
Date: Tue, 29 Jul 2003 12:18:53 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGMELOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <m3d6ftxvv1.fsf@defiant.pm.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof ,

>Looks like malfunction of your card or driver. Is it a new design or
>is it already working with, say, Windows or something?

This same board works in an Sun Ultra 5 under Solaris and also works on
slower PCs using Linux Red Hat 8.0 and 9.0.  (i.e., all my stress testing
was done on a MoBo with an Intel 815E Chipset using an ICH2 I/O Controller
Hub.  It worked beautifully there!)

>> 00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge
>> (rev 02)
>> 00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP
Bridge
>> (rev 02)
>> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
>> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
>> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
>> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
>> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
>> 00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
>> 00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
>> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro
Ultra
>> TF
>> 02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
>> Controller (rev 80)
>> 02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
01)
>> 02:09.0 Communication controller: Altera Corporation PCI Fiber Optic
Engrave
>> Interface (rev 02)

>Does the above list include your card? Which one is it? Could you show
>lspci -vv output for that device?

The last item "Communication controller" is our card.  lspci -vv for our
system follows (ours is the last one):

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
(rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f3000000-f3dfffff
	Prefetchable memory behind bridge: f3f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at b400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
(prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at f2800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f1000000-f27fffff
	Prefetchable memory behind bridge: f3e00000-f3efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a
[Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra
TF (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7106
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at f3fe0000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at a800 [size=128]
	Capabilities: <available only to root>

02:09.0 Communication controller: Altera Corporation PCI Fiber Optic Engrave
Interface (rev 02)
	Subsystem: Max Daetwyler Corp PCI Fiber Optic Engrave Interface
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f1800000 (32-bit, non-prefetchable) [size=4K]


>> Jul 22 08:22:29 rti10 aksparlnx: ^I/opt/aksparlnx/drv/2.4.19/aksparlnx.o
was
>> compiled for kernel version 2.4.19
>> Jul 22 08:22:29 rti10 aksparlnx: ^Iwhile this kernel is version 2.4.20-8
>> Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
>> /opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: non-GPL
>> license - Copyright 1999-2002 Aladdin Knowledge Systems.

>Is is your driver?
No, but what follows are messages that are written when the driver loads:

Jul 22 08:24:08 rti10 kernel: Installing pslengrave
Jul 22 08:24:08 rti10 kernel: PCI: Found IRQ 10 for device 02:09.0
Jul 22 08:24:08 rti10 kernel: pslengrave(0):  device enabled.
Jul 22 08:24:08 rti10 kernel:
Jul 22 08:24:08 rti10 kernel:
*-----------------------------------------------------------------------*
Jul 22 08:24:08 rti10 kernel: Installing /dev/pslengrave0
Jul 22 08:24:08 rti10 kernel:   Test Driver 26 Version:  %%W%% %%G%%, MDC,
Inc.
Jul 22 08:24:08 rti10 kernel:   Device Rev ID:  02
Jul 22 08:24:08 rti10 kernel:
*-----------------------------------------------------------------------*
Jul 22 08:24:08 rti10 kernel: pslengrave:  major number:  121

>Have you tried running the box (with your card) without any unnecessary
>devices (plugged/loaded)?

Yes.

Regards,
Kathy

