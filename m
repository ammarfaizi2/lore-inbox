Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUITDXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUITDXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 23:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUITDXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 23:23:19 -0400
Received: from gourmet.spamgourmet.com ([216.218.230.146]:16061 "EHLO
	gourmet.spamgourmet.com") by vger.kernel.org with ESMTP
	id S265900AbUITDWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 23:22:37 -0400
Message-ID: <414E0873.2020506@home.se>
Date: Mon, 20 Sep 2004 00:30:11 +0200
From: linuxkernel1.20.sandos@spamgourmet.com
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: de2104x bug in 2.6.9-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-mdh_se-MailScanner-Information: Please contact the ISP for more information
X-mdh_se-MailScanner: Found to be clean
X-MailScanner-From: linuxkernel1.20.sandos@spamgourmet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ive seen mentions of the de2104 driver not working for quite some time 
in 2.6 (since 2.5 even?), and Im seeing this still on 2.6.9-rc2. Anyway, 
a little info if anyone wants it. I can also help debug by trying out 
patches if need be.

2.6.8-rc2:
http://sandos.ath.cx/IMG_0403.JPG
2.6.9-rc2:
http://sandos.ath.cx/IMG_0404.JPG

lspci -vvv:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 
[KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e4dfffff
        Prefetchable memory behind bridge: e4f00000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

0000:00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]
        Capabilities: <available only to root>

0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at b400 [size=32]
        Capabilities: <available only to root>

0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at b000 [size=32]
        Capabilities: <available only to root>

0000:00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: <available only to root>

0000:00:09.0 Unknown mass storage controller: Promise Technology, Inc. 
PDC20268 (Ultra100 TX2) (rev 01) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra100TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9000 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8400 [size=4]
        Region 4: I/O ports at 8000 [size=16]
        Region 5: Memory at e3800000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: <available only to root>

0000:00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 
21041 [Tulip Pass 3] (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 7800 [size=128]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

0000:00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 7400 [size=128]
        Region 1: Memory at e2800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 
AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0088
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Region 0: Memory at e5000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e4fe0000 [disabled] [size=128K]
        Capabilities: <available only to root>


