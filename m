Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274928AbTHLATZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274929AbTHLATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:19:25 -0400
Received: from 24-25-204-203.san.rr.com ([24.25.204.203]:18436 "HELO
	mail.amrx.net") by vger.kernel.org with SMTP id S274928AbTHLATL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:19:11 -0400
Date: Mon, 11 Aug 2003 17:16:47 -0700 (PDT)
From: Andrew Marks <atm@amrx.net>
X-X-Sender: amrx@andrew.amrx.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 slow boot
Message-ID: <Pine.LNX.4.53.0308111658300.3112@andrew.amrx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. 3-5 minute pause during boot, right after "Bios Data Check Successful"

2. This bug, if indeed a bug, appears in 2.6.0-test1, test2, and test3.
The problem is after the kernel is loaded, there is a very long pause,
after "Bios Data Check Successful" and before the kernel boots.  After the
3-5 minute pause, everything works great.  This problem only occures on my
specific hardware.

3. boot, bios data

4. Linux version 2.6.0-test3 (root@andrew) (gcc version 3.2.2) #1 SMP Sun
Aug 10 10:38:20 PDT 2003


5. N/A

6. N/A

7.1 N/A

7.2
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP 1600+
stepping	: 2
cpu MHz		: 1400.249
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2760.70

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1400.249
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2793.47

7.3
ntfs 82068 0 - Live 0xe0c52000
emu10k1 54592 0 - Live 0xe0c6a000
ac97_codec 15104 1 emu10k1, Live 0xe0c4d000
ide_scsi 11776 0 - Live 0xe0c31000
tulip 34784 0 - Live 0xe0c3a000

7.4
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0a.0
  1000-10ff : tulip
1400-141f : 0000:00:0d.0
  1400-141f : EMU10K1
1430-143f : 0000:00:0c.0
  1430-1437 : ide2
  1438-143f : ide3
1440-1443 : 0000:00:00.0
1444-1447 : 0000:00:0c.0
1448-144f : 0000:00:0c.0
1450-1453 : 0000:00:0c.0
  1452-1452 : ide2
1458-145f : 0000:00:0c.0
  1458-145f : ide2
1460-1467 : 0000:00:0d.1
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000dc000-000dcfff : 0000:00:07.4
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00323678 : Kernel code
  00323679-003a5c3f : Kernel data
1fff0000-1ffffbff : ACPI Tables
1ffffc00-1fffffff : ACPI Non-volatile Storage
f4001000-f40010ff : 0000:00:0a.0
  f4001000-f40010ff : tulip
f4100000-f4ffffff : PCI Bus #01
  f4100000-f4103fff : 0000:01:05.0
  f4800000-f4ffffff : 0000:01:05.0
f5200000-f5200fff : 0000:00:00.0
f6000000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : 0000:01:05.0
f8000000-fbffffff : 0000:00:00.0
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

7.5
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f5200000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1440 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=69
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f4100000-f4ffffff
	Prefetchable memory behind bridge: f6000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB (rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0c.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
	Subsystem: CMD Technology Inc PCI0649
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 1458 [size=8]
	Region 1: I/O ports at 1450 [size=4]
	Region 2: I/O ports at 1448 [size=8]
	Region 3: I/O ports at 1444 [size=4]
	Region 4: I/O ports at 1430 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1400 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 1460 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (4000ns min, 8000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

7.6

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DVD-16X  Model: OEM316B          Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Verbatim Model: 522452AL         Rev: 68S1
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: COLORADO 8GB     Rev: 2.03
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: 14.A
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff

7.7 N/A

8. I tried looking through some of the bios loading code in
arch/i386/boot/setup.S, but I don't really know what I am looking for.
Plan on learning more about it when I get a chance ;)

Hope this info helps, and it being my first bug report, hope its actually
a bug.  I have pretty much exhausted kernel configurations, and the
problem seems to be beyond that.

~Andrew Marks
