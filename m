Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbRG3UpR>; Mon, 30 Jul 2001 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbRG3UpJ>; Mon, 30 Jul 2001 16:45:09 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:38257
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S267837AbRG3UpC>; Mon, 30 Jul 2001 16:45:02 -0400
Message-ID: <3B661C70.2010303@fugmann.dhs.org>
Date: Tue, 31 Jul 2001 04:48:16 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010716
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
Cc: "Paul G. Allen" <pgallen@randomlogic.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD-760 AGP Support
In-Reply-To: <3B5CDFC1.4D954891@randomlogic.com> <3B5D9799.70807@valinux.com>
Content-Type: multipart/mixed;
 boundary="------------040804020109050306000903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------040804020109050306000903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I do not know if you still want reports,
but here is one anyway:-)

I've just bought an ASUS A7M266, and
agpgart is working perfectly with my Gforce256, using the
'agp_try_unsupported=1' option

The kernel is 2.4.7-ac3.

Output from lspci -vvv is attached.

Regards
Anders Fugmann


Jeff Hartmann wrote:
> 
> I have a pre production Tyan mb that I tested things on.  It seemed to 
> work just fine with agp_try_unsupported=1.  Please test it with 
> agp_try_unsupported on an actual production system to make sure, but if 
> it works just send me the output of lspci -vvv and I'll put it in the 
> kernel.
> 
> -Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--------------040804020109050306000903
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: Memory at df800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW+ Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: ce000000-cfdfffff
	Prefetchable memory behind bridge: cff00000-df7fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8040
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at cd800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc. AGP-V6600 SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at cfff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=15 SBA- AGP+ 64bit- FW+ Rate=<none>


--------------040804020109050306000903--

