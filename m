Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbRFSWi0>; Tue, 19 Jun 2001 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264817AbRFSWiQ>; Tue, 19 Jun 2001 18:38:16 -0400
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:6163 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S264816AbRFSWiH>;
	Tue, 19 Jun 2001 18:38:07 -0400
Message-ID: <3B2F2B61.5E591C74@mail.utexas.edu>
Date: Tue, 19 Jun 2001 16:37:21 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac14 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: FYI: 2.4.5-ac16 panics on Asus A7A266
Content-Type: multipart/mixed;
 boundary="------------98D1CF63F9E16D0CF4290087"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------98D1CF63F9E16D0CF4290087
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I tried 2.4.5-ac16 on my Asus A7A266 w/ Athlon because the fixnotes
sounded like it might address the simplex vs. DMA problem that I
reported a while back, but I get a kernel panic early in the boot
sequence every time I try to boot.


FYI, 2.4.5-ac14 boots and runs OK, except for the disabled DMA and
frequent SMBus resets when I try to run lm_sensors.  (The only
difference in the .config between -ac14 and -ac16 is that for -ac16 I
enabled the new ALI chipset fix.)

Possibly relevant, notice that 2.4.5-ac14 reports the chipset as
"ALI15X3" during the boot sequence, whereas the board's documentation
says that it's actually an ALi M1535D+.

It also gives this message at boot time, which I will send to the
indicated address in a separate message:

Jun 19 15:49:36 pollux kernel: PCI: Found IRQ 9 for device 00:0d.0
Jun 19 15:49:36 pollux kernel: Redundant entry in serial pci_table.
Please send the output of
Jun 19 15:49:36 pollux kernel: lspci -vv, this message
(4793,4104,4793,215)
Jun 19 15:49:36 pollux kernel: and the manufacturer and name of serial
board or modem board
Jun 19 15:49:36 pollux kernel: to serial-pci-info@lists.sourceforge.net.

Jun 19 15:49:36 pollux kernel: ttyS04 at port 0x9800 (irq = 9) is a
16550A

The lspci info is attached, in case anyone here wants it.

Holler if you want more, and tell this cluebie how to collect it.

Thanks,

Bobby Bryant
Austin, Texas



--------------98D1CF63F9E16D0CF4290087
Content-Type: text/plain; charset=us-ascii;
 name="temp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp.txt"

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: dc800000-dddfffff
	Prefetchable memory behind bridge: ddf00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Asustek Computer, Inc.: Unknown device 8053
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at d400 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=64]
	Region 5: Memory at d9800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com: Unknown device 00d7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 9800 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0641
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at dc800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at ddfe0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


--------------98D1CF63F9E16D0CF4290087--

