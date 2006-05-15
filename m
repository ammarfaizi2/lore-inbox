Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWEOShb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWEOShb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWEOShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:37:31 -0400
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:6091
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965135AbWEOSh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:37:29 -0400
Message-ID: <4468CA67.4060309@seclark.us>
Date: Mon, 15 May 2006 14:37:27 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: how to set this in the future
References: <4466437C.1070306@seclark.us>	 <1147702848.26686.29.camel@localhost.localdomain>	 <4468B3E5.5090209@seclark.us> <1147713822.26686.83.camel@localhost.localdomain>
In-Reply-To: <1147713822.26686.83.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2006-05-15 at 13:01 -0400, Stephen Clark wrote:
>  
>
>>I have a hp pavilion laptop n5430 with an ali chipset. I have a hitachi 
>>drive that will do udma100 - the docs on my laptop say it will do udma4 
>>but linux by default is setting it to
>>udma2.
>>    
>>
>
>Sounds like the laptop vendor has used short 40 wire cable instead of 80
>wire internally to the laptop. This is valid but requires special
>knowledge in the driver of those devices who do it.
>
>  
>
>>00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if 8a 
>>    
>>
>
>Can you give me an lspci -vvxxx of that device (or from the box), and
>also the output of "dmidecode". That way I can automate the detection in
>the new libata pata_ali driver, and if you cc Bartlomiej he can add it
>to the old driver (B.Zolnierkiewicz@elka.pw.edu.pl)
>
>Alan
>
>  
>
Here it is:
00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 / 
MobileMAGiK 1] (rev 04)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
    Latency: 0
    Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [b0] AGP version 2.0
        Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
    Capabilities: [a4] Power Management version 1
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 47 16 07 00 10 a2 04 00 00 06 00 00 00 00
10: 08 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
40: 11 2f 0f 03 1a 10 04 2f 00 20 04 00 00 20 20 00
50: 01 00 00 00 05 10 04 2f 00 20 00 00 00 20 20 ff
60: c1 54 30 85 00 70 00 00 05 70 72 d9 40 24 19 05
70: 8b 8b 8b 8b 00 00 00 00 40 c0 77 47 04 18 03 03
80: 31 07 53 b7 31 07 10 e1 00 01 00 00 00 00 00 00
90: 15 40 50 81 00 00 00 00 08 00 00 00 f0 ae 00 00
a0: 30 80 01 00 01 00 01 06 00 00 00 00 00 00 00 00
b0: 02 a4 20 00 13 02 00 1b 00 00 00 00 08 00 93 0f
c0: 10 00 13 10 00 00 00 f0 80 68 00 c0 00 00 00 00
d0: 07 f0 45 ff 00 b1 6b 15 00 00 00 80 81 81 80 00
e0: 00 2c 23 b9 40 00 00 00 00 00 18 00 00 07 00 00
f0: 00 00 00 46 00 06 80 03 00 01 01 47 00 00 00 00

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00 
[Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    Memory behind bridge: ea100000-efffffff
    Prefetchable memory behind bridge: 28000000-280fffff
    Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR+
    BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: b9 10 47 52 1f 00 00 04 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 a2
20: 10 ea f0 ef 00 28 00 28 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 9
    Region 0: Memory at fff70000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 13 00 90 02 03 10 03 0c 08 10 00 00
10: 00 00 f7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 50
40: 00 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 CardBus bridge: Texas Instruments PCI1420
    Subsystem: Hewlett-Packard Company Unknown device 0018
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 168, Cache Line Size 20
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at 28120000 (32-bit, non-prefetchable) [size=4K]
    Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
    Memory window 0: 20000000-21fff000 (prefetchable)
    Memory window 1: 22000000-23fff000
    I/O window 0: 00002000-000020ff
    I/O window 1: 00002400-000024ff
    BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
    16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 20 a8 82 00
10: 00 00 12 28 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 20 00 00
30: fc 20 00 00 00 24 00 00 fc 24 00 00 0b 01 c0 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 f0 44 20 00 00 00 00 00 00 00 00 22 1b 9c 00
90: c0 82 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 15 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 CardBus bridge: Texas Instruments PCI1420
    Subsystem: Hewlett-Packard Company Unknown device 0018
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 168, Cache Line Size 20
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at 28121000 (32-bit, non-prefetchable) [size=4K]
    Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
    Memory window 0: 24000000-25fff000 (prefetchable)
    Memory window 1: 26000000-27fff000
    I/O window 0: 00002800-000028ff
    I/O window 1: 00002c00-00002cff
    BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
    16-bit legacy interface ports at 0001
00: 4c 10 51 ac 07 00 10 02 00 00 07 06 20 a8 82 00
10: 00 10 12 28 a0 00 00 02 00 06 09 b0 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 28 00 00
30: fc 28 00 00 00 2c 00 00 fc 2c 00 00 0b 01 00 05
40: 3c 10 18 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 f0 44 20 00 00 00 00 00 00 00 00 22 1b 9c 00
90: c0 83 66 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 80 c0 00 15 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 40 01 00 00 00 22 00 ab 7f 02 31 00 01 00 00
50: 00 02 00 00 3f 00 00 00 00 4f 01 40 00 00 00 00
60: 00 00 00 00 a5 00 00 00 00 00 00 ff 01 22 e0 0f
70: 01 81 00 00 00 2f 45 28 f7 77 00 00 f8 02 00 00
80: f6 63 0a 10 02 07 00 00 17 00 00 20 00 00 00 00
90: 00 00 00 00 00 00 00 b2 47 00 b0 9c b0 04 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00
b0: 00 84 00 00 04 07 03 00 60 14 00 00 00 00 00 00
c0: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 06 04 00 00 00 00 00 00 00 40 00 2f 00 00 00
e0: 00 80 40 80 01 00 01 06 00 00 00 00 00 00 00 00
f0: 03 00 20 1e 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge 
[Aladdin IV/V/V+]
    Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [a0] Power Management version 1
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 13 08 ea 5d 02 00 03 99 05 00 00 00 00 cd 03
50: 00 00 00 00 02 00 02 01 5c 00 00 00 00 00 e0 f0
60: 42 31 00 00 00 00 00 00 00 00 00 00 00 64 25 5d
70: d2 00 2b 00 00 1f 81 48 00 02 80 02 21 00 00 11
80: 07 00 33 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 
(rev 12)
    Subsystem: Hewlett-Packard Company Unknown device 0018
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 6000ns max)
    Interrupt: pin A routed to IRQ 5
    Region 0: I/O ports at 1400 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5d 12 88 19 05 00 90 02 12 00 01 04 00 40 80 00
10: 01 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18
40: 44 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 e0 0a 00 00 00 00 00 01 00 00 20 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
    Subsystem: Hewlett-Packard Company Unknown device 0018
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 255
    Region 0: I/O ports at 1800 [disabled] [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable+ DSel=0 DScale=0 PME+
00: 5d 12 89 19 00 00 90 02 12 00 80 07 00 00 80 00
10: 01 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
40: 44 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 e0 0a 00 00 00 00 00 01 00 00 20 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 a2 f6 00 81 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if 8a 
[Master SecP PriP])
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 1000ns max)
    Interrupt: pin A routed to IRQ 255
    Region 4: I/O ports at 1000 [size=16]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c3 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 ff 01 02 04
40: 06 00 00 7a 00 00 00 00 00 02 23 c9 00 00 ba 3a
50: 00 00 00 89 05 00 08 0a 02 31 51 00 00 31 31 00
60: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 Ethernet controller: Accton Technology Corporation EN-1216 
Ethernet Adapter (rev 11)
    Subsystem: Accton Technology Corporation EN2242 10/100 Ethernet 
Mini-PCI Card
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (63750ns min, 63750ns max), Cache Line Size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at 1c00 [size=256]
    Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=1K]
    [virtual] Expansion ROM at 28100000 [disabled] [size=128K]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 13 11 16 12 17 00 90 02 11 00 00 02 08 40 00 00
10: 01 1c 00 00 00 10 00 ea 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 42 22
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 ff ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 17 13 81 09 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 c2 ff 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/XP 
(rev 63) (prog-if 00 [VGA])
    Subsystem: Hewlett-Packard Company Unknown device 0018
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=32M]
    Region 1: Memory at ea400000 (32-bit, non-prefetchable) [size=4M]
    Region 2: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
    Region 3: Memory at ea100000 (32-bit, non-prefetchable) [size=32K]
    [virtual] Expansion ROM at 28000000 [disabled] [size=64K]
    Capabilities: [80] AGP version 2.0
        Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
    Capabilities: [90] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 10 99 07 00 30 02 63 00 00 03 00 40 00 00
10: 00 00 00 ee 00 00 40 ea 00 00 00 ec 00 00 10 ea
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 18 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 90 20 00 07 02 00 20 00 00 00 00 00 00 00 00
90: 01 00 22 06 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

06:00.0 Ethernet controller: Atheros Communications, Inc. AR5212 
802.11abg NIC (rev 01)
    Subsystem: Unknown device 0308:3405
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 168 (2500ns min, 7000ns max), Cache Line Size 20
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at 26000000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 8c 16 13 00 06 00 90 02 01 00 00 02 20 a8 00 00
10: 00 00 00 26 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 50 00 00 08 03 05 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 0a 1c
40: 00 00 00 00 01 00 c2 01 00 40 00 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# dmidecode 2.7
SMBIOS 2.2 present.
29 structures occupying 935 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 19 bytes.
BIOS Information
    Vendor: Phoenix Technologies LTD
    Version:  GD.M1.08
    Release Date: 09/27/2001
    Address: 0xEB220
    Runtime Size: 85472 bytes
    ROM Size: 512 kB
    Characteristics:
        ISA is supported
        PCI is supported
        PC Card (PCMCIA) is supported
        PNP is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        ESCD support is available
        Boot from CD is supported
        Selectable boot is supported
        EDD is supported
        Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
        Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
        3.5"/720 KB floppy services are supported (int 13h)
        Print screen service is supported (int 5h)
        8042 keyboard services are supported (int 9h)
        Serial services are supported (int 14h)
        Printer services are supported (int 17h)
        ACPI is supported
        AGP is supported
        Smart battery is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
    Manufacturer: Hewlett-Packard
    Product Name: HP Pavilion Notebook PC
    Version: HP Pavilion Notebook Model GD
    Serial Number: TW13217104
    UUID: Not Settable
    Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
    Manufacturer: Hewlett-Packard
    Product Name: N/A
    Version: OmniBook N32N-736
    Serial Number: 000000000000

Handle 0x0003, DMI type 3, 13 bytes.
Chassis Information
    Manufacturer: Hewlett-Packard
    Type: Notebook
    Lock: Not Present
    Version: N/A
    Serial Number: None
    Asset Tag: No Asset Tag
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None

Handle 0x0004, DMI type 4, 32 bytes.
Processor Information
    Socket Designation: *Socket 7*
    Type: Central Processor
    Family: Athlon
    Manufacturer: AuthenticAMD
    ID: 70 06 00 00 FF F9 83 01
    Signature: Family 6, Model 7, Stepping 0
    Flags:
        FPU (Floating-point unit on-chip)
        VME (Virtual mode extension)
        DE (Debugging extension)
        PSE (Page size extension)
        TSC (Time stamp counter)
        MSR (Model specific registers)
        PAE (Physical address extension)
        MCE (Machine check exception)
        CX8 (CMPXCHG8 instruction supported)
        SEP (Fast system call)
        MTRR (Memory type range registers)
        PGE (Page global enable)
        MCA (Machine check architecture)
        CMOV (Conditional move instruction supported)
        PAT (Page attribute table)
        PSE-36 (36-bit page size extension)
        MMX (MMX technology supported)
        FXSR (Fast floating-point save and restore)
    Version: AMD Athlon(tm) 4
    Voltage: 3.3 V
    External Clock: Unknown
    Max Speed: 850 MHz
    Current Speed: 850 MHz
    Status: Populated, Enabled
    Upgrade: None
    L1 Cache Handle: 0x0008
    L2 Cache Handle: 0x0009
    L3 Cache Handle: No L3 Cache

Handle 0x0005, DMI type 5, 20 bytes.
Memory Controller Information
    Error Detecting Method: None
    Error Correcting Capabilities:
        None
    Supported Interleave: One-way Interleave
    Current Interleave: One-way Interleave
    Maximum Memory Module Size: 256 MB
    Maximum Total Memory Size: 512 MB
    Supported Speeds:
        Other
    Supported Memory Types: None
    Memory Module Voltage: 3.3 V
    Associated Memory Slots: 2
        0x0006
        0x0007
    Enabled Error Correcting Capabilities:
        Unknown

Handle 0x0006, DMI type 6, 12 bytes.
Memory Module Information
    Socket Designation: JP28
    Bank Connections: 0 1
    Current Speed: 10 ns
    Type: DIMM SDRAM
    Installed Size: 128 MB (Double-bank Connection)
    Enabled Size: 128 MB (Double-bank Connection)
    Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes.
Memory Module Information
    Socket Designation: JP27
    Bank Connections: 2 3
    Current Speed: 10 ns
    Type: DIMM SDRAM
    Installed Size: 128 MB (Double-bank Connection)
    Enabled Size: 128 MB (Double-bank Connection)
    Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes.
Cache Information
    Socket Designation: L1 Cache
    Configuration: Enabled, Socketed, Level 1
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 16 KB
    Maximum Size: 16 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Asynchronous
    Installed SRAM Type: Asynchronous
    Speed: Unknown
    Error Correction Type: Unknown
    System Type: Unknown
    Associativity: Unknown

Handle 0x0009, DMI type 7, 19 bytes.
Cache Information
    Socket Designation: L2 Cache
    Configuration: Enabled, Not Socketed, Level 2
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 64 KB
    Maximum Size: 512 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Synchronous
    Installed SRAM Type: Synchronous
    Speed: Unknown
    Error Correction Type: Unknown
    System Type: Unknown
    Associativity: Unknown

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Primary IDE
    Internal Connector Type: On Board IDE
    External Reference Designator: Not Specified
    External Connector Type: None
    Port Type: Other

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: FLOPPY
    Internal Connector Type: On Board Floppy
    External Reference Designator: Not Specified
    External Connector Type: None
    Port Type: Other

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: COM1
    External Connector Type: DB-9 male
    Port Type: Serial Port XT/AT Compatible

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: Printer
    External Connector Type: DB-25 female
    Port Type: Parallel Port ECP/EPP

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: Keyboard
    External Connector Type: PS/2
    Port Type: Keyboard Port

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: PS/2 Mouse
    External Connector Type: PS/2
    Port Type: Mouse Port

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: CD_IN
    Internal Connector Type: On Board Sound Input From CD-ROM
    External Reference Designator: Not Specified
    External Connector Type: None
    Port Type: Other

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: MIC_IN
    External Connector Type: RJ-11
    Port Type: MIDI Port

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: LINE_IN
    External Connector Type: RJ-11
    Port Type: MIDI Port

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: Not Specified
    Internal Connector Type: None
    External Reference Designator: LINE_OUT
    External Connector Type: RJ-11
    Port Type: MIDI Port

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: USB1
    Internal Connector Type: Other
    External Reference Designator: Not Specified
    External Connector Type: None
    Port Type: USB

Handle 0x0015, DMI type 8, 9 bytes.
Port Connector Information
    Internal Reference Designator: USB2
    Internal Connector Type: Other
    External Reference Designator: Not Specified
    External Connector Type: None
    Port Type: USB

Handle 0x0016, DMI type 9, 13 bytes.
System Slot Information
    Designation: TI 1420 Slot 1
    Type: 32-bit PC Card (PCMCIA)
    Current Usage: Available
    Length: Long
    ID: Adapter 0, Socket 0
    Characteristics:
        3.3 V is provided
        PME signal is supported

Handle 0x0017, DMI type 9, 13 bytes.
System Slot Information
    Designation: TI 1420 Slot 2
    Type: 32-bit PC Card (PCMCIA)
    Current Usage: Available
    Length: Long
    ID: Adapter 0, Socket 0
    Characteristics:
        3.3 V is provided
        Opening is shared
        PME signal is supported

Handle 0x0018, DMI type 10, 8 bytes.
On Board Device 1 Information
    Type: Video
    Status: Enabled
    Description: TRIDENT VGA
On Board Device 2 Information
    Type: Sound
    Status: Enabled
    Description: ESS 1988

Handle 0x0019, DMI type 11, 5 bytes.
OEM Strings
    String 1: HP Pavilion Notebook PC
    String 2: Service ID: 11232     
    String 3: $MODEL:F2418
    String 4: $OS:M
    String 5: $LOCAL:ABA
    String 6: $OPTION:  
    String 7: $DC:   

Handle 0x001A, DMI type 21, 7 bytes.
Built-in Pointing Device
    Type: Touch Pad
    Interface: PS/2
    Buttons: 4

Handle 0x001B, DMI type 22, 26 bytes.
Portable Battery
    Location: Right Front
    Manufacturer: Not Specified
    Name: Not Specified
    Design Capacity: Unknown
    Design Voltage: Unknown
    SBDS Version: Not Specified
    Maximum Error: 0%
    SBDS Serial Number: 0000
    SBDS Manufacture Date: 1980-00-00
    SBDS Chemistry: Not Specified
    OEM-specific Information: 0x00000000

Handle 0x001C, DMI type 127, 4 bytes.
End Of Table



-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



