Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRGPS3v>; Mon, 16 Jul 2001 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbRGPS3q>; Mon, 16 Jul 2001 14:29:46 -0400
Received: from c009-h017.c009.snv.cp.net ([209.228.34.130]:7065 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S267621AbRGPS3d>;
	Mon, 16 Jul 2001 14:29:33 -0400
X-Sent: 16 Jul 2001 18:29:30 GMT
Date: Mon, 16 Jul 2001 11:28:59 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Marko Rebrina <mrebrina@jagor.srce.hr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:blinking screen in XFree4.x !
In-Reply-To: <20010716193301.A2161@debelian.doma.hr>
Message-ID: <Pine.LNX.4.33.0107161128050.579-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Marko Rebrina wrote:

> Hi,
> I have problem with XFree4.x(current 4.1) when I have large file transfer(~1GB)
> then screen in X start blinking(black screen),console works fine!
> Restarting Xe not resolving problem! No message in log !

I used to have this problem as well.  It is due to massive clock skew on
certain motherboads (ahem).  To "fix" this, simply display DPMS in your X
server: xset -dpms

-jwb

>
> I have K7-700Mhz/AbitKA7(KX133)/256M/G400DH32M
> Kernel:2.4.x,current 2.4.6
>
> %cat /proc/modules
> nls_iso8859-1           2880   0 (autoclean)
> nls_iso8859-2           3392   1 (autoclean)
> nls_cp437               4384   1 (autoclean)
> vmnet                  18752   0 (unused)
> vmmon                  19152   0 (unused)
> 8139too                11936   1
> hisax                 134224   5
> isdn                  119984   6 [hisax]
> slhc                    5024   2 [isdn]
> cmpci                  23664   2
>
> %cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(set)
> 0778-077a : parport0
> 0cf8-0cff : PCI conf1
> 4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> d000-d00f : VIA Technologies, Inc. Bus Master IDE
>   d000-d007 : ide0
>   d008-d00f : ide1
> d400-d41f : VIA Technologies, Inc. UHCI USB
>   d400-d41f : usb-uhci
> d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
>   d800-d81f : usb-uhci
> dc00-dcff : Realtek Semiconductor Co., Ltd. RTL-8139
>   dc00-dcff : 8139too
> e000-e007 : PCI device 1043:0675 (Asustek Computer, Inc.)
> e400-e4ff : C-Media Electronics Inc CM8738
>   e400-e4ff : cmpci
>
> %cat /proc/iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-0ffeffff : System RAM
>   00100000-0023e7d3 : Kernel code
>   0023e7d4-002b055f : Kernel data
> 0fff0000-0fff2fff : ACPI Non-volatile Storage
> 0fff3000-0fffffff : ACPI Tables
> d0000000-d7ffffff : VIA Technologies, Inc. VT8371 [KX133]
> d8000000-dbffffff : PCI Bus #01
>   d8000000-d8003fff : Matrox Graphics, Inc. MGA G400 AGP
>   d9000000-d97fffff : Matrox Graphics, Inc. MGA G400 AGP
> dc000000-ddffffff : PCI Bus #01
>   dc000000-ddffffff : Matrox Graphics, Inc. MGA G400 AGP
> de000000-de0000ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   de000000-de0000ff : 8139too
> de001000-de0010ff : PCI device 1043:0675 (Asustek Computer, Inc.)
> ffff0000-ffffffff : reserved
>
> %lspci -vvv
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 0
> 	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: d8000000-dbffffff
> 	Prefetchable memory behind bridge: dc000000-ddffffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 21)
> 	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
>
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at d000 [size=16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 11
> 	Region 4: I/O ports at d400 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 11
> 	Region 4: I/O ports at d800 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin ? routed to IRQ 3
> 	Capabilities: [68] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
> 	Latency: 32 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at dc00 [size=256]
> 	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
>
> 00:0b.0 Network controller: Asustek Computer, Inc.: Unknown device 0675 (rev 02)
> 	Subsystem: Dynalink: Unknown device 1704
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 16 (4000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at e000 [disabled] [size=8]
> 	Region 1: Memory at de001000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [40] Power Management version 1
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
>
> 00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 6000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at e400 [size=256]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
> 	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (4000ns min, 8000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
> 	Region 1: Memory at d8000000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
>
>
>

