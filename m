Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131930AbQLPOi5>; Sat, 16 Dec 2000 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbQLPOir>; Sat, 16 Dec 2000 09:38:47 -0500
Received: from hs-img-rel-1.compuserve.com ([149.174.177.156]:15768 "EHLO
	sphmraaa.compuserve.com") by vger.kernel.org with ESMTP
	id <S131930AbQLPOii>; Sat, 16 Dec 2000 09:38:38 -0500
Message-ID: <3A3B7779.7050408@csi.com>
Date: Sat, 16 Dec 2000 15:08:57 +0100
From: Thierry DANJEAN <tdanjean@csi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT 370 doesn't works with KERNEL 2.4.0-test11 and test 12
Content-Type: multipart/mixed;
 boundary="------------000305050706030702010609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000305050706030702010609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I don't where to send this dysfunctionment. I hope that's the good target.


I can't boot with my HPT 370 from HIGHPOINT TECHNOLOGIE with the 
2.4.0-test11 and test 12. But It works fine with kernel 2.4.0-test10.

Pb is that the boot process is looked when it try to reach UDMA IBM DTLA 
307030 disk connected on this board.

Y'll find attached with mail the result of lspci command and  iomem.log, 
ioports.log, modules.log  for the working  2.4.0-test10 kernel.

I hope y'll find the way to solve this problems.

Best regards.

T. DANJEAN






--------------000305050706030702010609
Content-Type: text/plain;
 name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.log"

00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
	Subsystem: Asustek Computer, Inc. P3C-2000 system chipset
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e1800000-e2dfffff
	Prefetchable memory behind bridge: e2f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000dfff
	Memory behind bridge: e0800000-e17fffff
	Prefetchable memory behind bridge: e2e00000-e2efffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 9800 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 9400 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at e800 [size=16]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e1800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e2ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

02:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0005
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at b800 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b000 [size=4]
	Region 4: I/O ports at a800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]


--------------000305050706030702010609
Content-Type: text/plain;
 name="iomem.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iomem.log"

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c81ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffbfff : System RAM
  00100000-00248647 : Kernel code
  00248648-00260093 : Kernel data
0bffc000-0bffefff : ACPI Tables
0bfff000-0bffffff : ACPI Non-volatile Storage
e0800000-e17fffff : PCI Bus #02
  e0800000-e0800fff : Symbios Logic Inc. (formerly NCR) 53c875
  e1000000-e10000ff : Symbios Logic Inc. (formerly NCR) 53c875
e1800000-e2dfffff : PCI Bus #01
  e1800000-e1ffffff : Matrox Graphics, Inc. MGA G200 AGP
  e2000000-e2003fff : Matrox Graphics, Inc. MGA G200 AGP
e2e00000-e2efffff : PCI Bus #02
e2f00000-e3ffffff : PCI Bus #01
  e3000000-e3ffffff : Matrox Graphics, Inc. MGA G200 AGP
e4000000-e7ffffff : Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH)
ffff0000-ffffffff : reserved

--------------000305050706030702010609
Content-Type: text/plain;
 name="ioports.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioports.log"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
9400-941f : Intel Corporation 82801AA USB
  9400-941f : usb-uhci
9800-980f : Intel Corporation 82801AA IDE
  9800-9807 : ide0
  9808-980f : ide1
a000-dfff : PCI Bus #02
  a800-a8ff : Triones Technologies, Inc. HPT366
    a800-a807 : ide2
    a808-a80f : ide3
    a810-a8ff : HPT370
  b000-b003 : Triones Technologies, Inc. HPT366
  b400-b407 : Triones Technologies, Inc. HPT366
  b800-b803 : Triones Technologies, Inc. HPT366
    b802-b802 : ide2
  d000-d007 : Triones Technologies, Inc. HPT366
    d000-d007 : ide2
  d400-d43f : Ensoniq 5880 AudioPCI
    d400-d43f : es1371
  d800-d8ff : Symbios Logic Inc. (formerly NCR) 53c875
    d800-d87f : ncr53c8xx
e800-e80f : Intel Corporation 82801AA SMBus

--------------000305050706030702010609
Content-Type: text/plain;
 name="modules.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules.log"

sr_mod                 14484   0 (autoclean)
cdrom                  27676   0 (autoclean) [sr_mod]
vmnet                  18240   3
vmmon                  18884   0 (unused)
parport_pc             23172   1 (autoclean)
lp                      5672   1 (autoclean)
parport                25088   1 (autoclean) [parport_pc lp]
ppp_async               6636   1 (autoclean)
ppp_generic            16928   2 (autoclean) [ppp_async]
slhc                    4972   1 (autoclean) [ppp_generic]
es1371                 25012   1
soundcore               4132   4 [es1371]
ac97_codec              7780   0 [es1371]
uhci                   18800   0 (unused)
usbcore                48640   1 [uhci]
ncr53c8xx              56812   0

--------------000305050706030702010609--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
