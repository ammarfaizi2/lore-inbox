Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVIUP5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVIUP5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIUP5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:57:04 -0400
Received: from email.student.malone.edu ([192.42.153.210]:54481 "HELO
	webmail.malone.edu") by vger.kernel.org with SMTP id S1751104AbVIUP5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:57:02 -0400
Message-ID: <433182C8.2060006@malone.edu>
Date: Wed, 21 Sep 2005 11:56:56 -0400
From: "Shawn M. Campbell" <scampbell@malone.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI Express or TG3 issue
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM ThinkCentre A51 (8122-34U).  It has a  Broadcom BCM5751
Gigabit PCI Express ethernet adapter.  I have not been able to get the
adapter to work and I am trying to determine if the problem is related
to PCI code or NIC driver code.  I thought that it might be PCI code
since both the tg3 and Broadcom supplied drivers failed with similar
error messages.  I am not sure how to diagnose the problem further.  If
you could direct me to someone that might be able to help or can offer
any insight into what to try next in order to diagnose the problem, it
would be greatly appreciated.  I have provided as many important details
below as possible.  Please contact me if anything is needed.

Thank you.

Shawn

I have tried the following list of kernels.

>From Debian packages:

2.4.26-1-386
2.4.27-1-386
2.6.11-1-686
2.6.12-1-686

>From kernel.org sources:

2.4.31
2.6.13.1
2.6.14-rc2

I have also tried the latest bcm5700 driver from Broadcom without
success.  Since neither the broadcom supplied
I am running Debian Linux with Sarge, Woody, and Testing branch apt sources.

Entries from /var/log/dmesg (Linux Kernel 2.6.14-rc2):

For tg3:

tg3.c:v3.40 (September 15, 2005)
PCI: Device 0000:02:00.0 not available because of resource collisions
tg3: Cannot enable PCI device, aborting.
tg3: probe of 0000:02:00.0 failed with error -22

For bcm5700 from Broadcom:

Broadcom Gigabit Ethernet Driver bcm5700 with
Broadcom NIC Extension (NICE) ver. 8.2.18 (08/01/05)
PCI: Device 0000:02:00.0 not available because
 of resource collisions
bcm5700: probe of 0000:02:00.0 failed with err
or -22

Output from lspci -vv:

0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL
Processor to I/O Controller (rev 04)
        Subsystem: IBM: Unknown device 02f7
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

0000:00:02.0 VGA compatible controller: Intel Corporation
82915G/GV/910GL Express Chipset Family Graphics Controller (rev 04)
(prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at 34e0 [size=8]
        Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at d0280000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: <available only to root>

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: d0000000-d00fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 201
        Region 4: I/O ports at 3440 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 193
        Region 4: I/O ports at 3460 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 209
        Region 4: I/O ports at 3480 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at d04c0000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=56
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: 0000000030000000-0000000030000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

0000:00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at 3000 [size=256]
        Region 1: I/O ports at 3400 [size=64]
        Region 2: Memory at d04c0800 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at d04c0400 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 03)
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W)
SATA Controller (rev 03) (prog-if 80 [Master])
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 193
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 34d0 [size=16]
        Capabilities: <available only to root>

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) SMBus Controller (rev 03)
        Subsystem: IBM: Unknown device 02f7
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 34a0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 11)
        Subsystem: IBM: Unknown device 02f7
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at <ignored> (64-bit, non-prefetchable)
        Capabilities: <available only to root>

0000:0a:00.0 Communication controller: Conexant: Unknown device 2702
(rev 01)
        Subsystem: Conexant: Unknown device 2002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at 4400 [size=8]
        Capabilities: <available only to root>

0000:0a:01.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
Ethernet 10/100 (rev 11)
        Subsystem: Linksys: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 55 (63750ns min, 63750ns max), Cache Line Size: 0x08
(32 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at 4000 [size=256]
        Region 1: Memory at d0110000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: <available only to root>

Output from lspci -n:

0000:00:00.0 0600: 8086:2580 (rev 04)
0000:00:02.0 0300: 8086:2582 (rev 04)
0000:00:1c.0 0604: 8086:2660 (rev 03)
0000:00:1d.0 0c03: 8086:2658 (rev 03)
0000:00:1d.1 0c03: 8086:2659 (rev 03)
0000:00:1d.2 0c03: 8086:265a (rev 03)
0000:00:1d.7 0c03: 8086:265c (rev 03)
0000:00:1e.0 0604: 8086:244e (rev d3)
0000:00:1e.2 0401: 8086:266e (rev 03)
0000:00:1f.0 0601: 8086:2640 (rev 03)
0000:00:1f.2 0101: 8086:2651 (rev 03)
0000:00:1f.3 0c05: 8086:266a (rev 03)
0000:02:00.0 0200: 14e4:1677 (rev 11)
0000:0a:00.0 0780: 14f1:2702 (rev 01)
0000:0a:01.0 0200: 1317:0985 (rev 11)

