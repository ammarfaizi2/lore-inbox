Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131111AbRAQXLB>; Wed, 17 Jan 2001 18:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAQXKk>; Wed, 17 Jan 2001 18:10:40 -0500
Received: from adsl-nrp10-C8B0F87C.sao.terra.com.br ([200.176.248.124]:43760
	"EHLO thor.gds-corp.com") by vger.kernel.org with ESMTP
	id <S130844AbRAQXKg> convert rfc822-to-8bit; Wed, 17 Jan 2001 18:10:36 -0500
Date: Wed, 17 Jan 2001 21:11:36 -0200 (BRST)
From: Joel Franco Guzmán <joel@gds-corp.com>
To: <sailer@ife.ee.ethz.ch>, <hb9jnx@hb9w.che.eu.redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
Message-ID: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No se si entiendes español (por causa del .ch) pero lo escribo en mi
pesimo ingles.

Bug Report
----------
1. 128M memory OK, but with 192M the sound card generate a noise while
use the DSP.
2. i got the problem when I just put more 64M memory to the my machine.
With 128M the problem is not present, but with 192M it is. The only
difference is the memory quantity, or in other words, the additional slot
occupied by the new memory card.

i've got the two dmesg, with 128M and with 192M.
With the kernel 2.2.18 don't problem.

the problem: The sound card generates a toc.. toc.. toc .. toc...while
playing a sound using the DSP of the soundcard. Two "tocs"/sec
aproxiumadetely.

i think that be a irq problem.

3. es1371, sound card, kernel 2.4
4. Linux version 2.4.1-pre8 (root@thor.gds-corp.com) (gcc version 2.95.3
19991030 (prerelease)) #2 Wed Jan 17 19:44:31 BRST 2001
   Tested too with the 2.4.0 official kernel.
5. No Oops.
6.
7.Hardware
   - Pentium III 600Mhz Coppermine 133Mhz FSB, mounted with SLOTA
(or
slot 1) to socket 770 adaptor.
   - ASUS P299 (Chipset i440ZX). Note: the i440ZX don't support officially
the coppermine processor at 133Mhz FSB.
   - 100Mhz memory modules. 2 modules in the 2 slots provided by the
motherboard. One of 128M and the other 64M.
   - Sound card creative. es1391 chipset.
  7.1

Linux thor.gds-corp.com 2.4.1-pre8 #2 Wed Jan 17 19:44:31 BRST 2001
i686 unknownKernel modules         2.3.21
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
cat: /proc/modules: No such file or directory
Modules Loaded

7.2

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 598.483
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1192.75

7.3 static kernel compiled.
7.4 [joel@thor linux]$ cat /proc/ioports
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
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b800-b87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  b800-b87f : eth0
d000-d03f : Ensoniq ES1371 [AudioPCI-97]
  d000-d03f : es1371
d400-d41f : Intel Corporation 82371AB PIIX4 USB
  d400-d41f : usb-uhci
d800-d80f : Intel Corporation 82371AB PIIX4 IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
e800-e81f : Intel Corporation 82371AB PIIX4 ACPI

[joel@thor linux]$ cat /proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffcfff : System RAM
  00100000-00265055 : Kernel code
  00265056-002dd703 : Kernel data
e1000000-e100007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e1800000-e2dfffff : PCI Bus #01
  e1800000-e1ffffff : Matrox Graphics, Inc. MGA G200 AGP
  e2000000-e2003fff : Matrox Graphics, Inc. MGA G200 AGP
    e2000000-e2003fff : matroxfb MMIO
e2f00000-e3ffffff : PCI Bus #01
  e3000000-e3ffffff : Matrox Graphics, Inc. MGA G200 AGP
    e3000000-e3ffffff : matroxfb FB
e4000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge

7.5
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e1800000-e2dfffff
	Prefetchable memory behind bridge: e2f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 5
[root@thor linux]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e1800000-e2dfffff
	Prefetchable memory behind bridge: e2f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e1800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e2ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

7.6

[root@thor linux]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 8200  Rev: 1.0f
  Type:   CD-ROM                           ANSI SCSI revision: 02


-- 
    Joel Franco Guzmán
GDS - Global Dynamic Systems
   joelfranco@bigfoot.com
ICQ 19354050 | (16) 270-6867



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
