Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSFMK4h>; Thu, 13 Jun 2002 06:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317583AbSFMK4g>; Thu, 13 Jun 2002 06:56:36 -0400
Received: from sunray.wldelft.nl ([145.9.132.100]:61661 "EHLO
	pophost.wldelft.nl") by vger.kernel.org with ESMTP
	id <S317578AbSFMK42>; Thu, 13 Jun 2002 06:56:28 -0400
Message-ID: <012d01c212ca$39512c30$25de0991@logchl>
Reply-To: "Leroy van Logchem" <Leroy.vanLogchem@wldelft.nl>
From: "Leroy van Logchem" <Leroy.vanLogchem@wldelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel 2.4.18 PCI PIIX4 resource collisions with E7500 chipset
Date: Thu, 13 Jun 2002 13:05:27 +0200
Organization: WL | delft hydraulics
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please reply also to leroy.vanlogchem@wldelft.nl ,thanks.

[1.] The problem: PCI PIIX4 resource collisions with E7500 chipset
[2.] Full problem description:

During booting my PIIX4 IDE controller doesnt get enabled.
On Supermicro 6022P mainboard which uses the Intel E7500 chipset.
Before posting I thought it was a conflict with the internal NIC's
but after disabling them I still have the:

PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: (ide_setup_pci_device:) Could not enable device.

messages during boot. So I can't use DMA on the disks, which leaves
me with unuseable performance.

[3.] Keywords:
     IDE PIIX E7500
[4.] Kernel version:
     Linux version 2.4.18-3custom (root@lds001)
     (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110))
[7.1] Output of ver_linux:
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         binfmt_misc autofs e1000 ide-cd cdrom
[7.2] Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.20GHz
stepping        : 4
cpu MHz         : 2196.268
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
                  pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse
                  sse2 ss ht tm
bogomips        : 4377.80
[7.3] Module information:
binfmt_misc     7044  1
autofs         11076  2 (autoclean)
e1000          55492  0 (unused)
ide-cd         30016  0 (autoclean)
cdrom          31904  0 (autoclean) [ide-cd]
[7.4] Loaded driver and hardware information:
/proc/ioports

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1100-111f : PCI device 8086:2483 (Intel Corp.)
1400-141f : PCI device 8086:2482 (Intel Corp.)
1420-143f : PCI device 8086:2484 (Intel Corp.)
1440-145f : PCI device 8086:2487 (Intel Corp.)
1460-146f : PCI device 8086:248b (Intel Corp.)
2000-2fff : PCI Bus #01
  2000-2fff : PCI Bus #03
    2000-201f : Intel Corp. 82544EI Gigabit Ethernet Controller
3000-3fff : PCI Bus #07
  3000-30ff : ATI Technologies Inc Rage XL
  3400-343f : Intel Corp. 82557 [Ethernet Pro 100]
    3400-343f : eepro100

/proc/iomem

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-1fefcfff : System RAM
  00100000-002114c2 : Kernel code
  002114c3-0025a3df : Kernel data
1fefd000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
20000000-200003ff : PCI device 8086:248b (Intel Corp.)
fc100000-fc2fffff : PCI Bus #01
  fc100000-fc100fff : PCI device 8086:1461 (Intel Corp.)
  fc101000-fc101fff : PCI device 8086:1461 (Intel Corp.)
  fc200000-fc2fffff : PCI Bus #03
    fc200000-fc21ffff : Intel Corp. 82544EI Gigabit Ethernet Controller
    fc220000-fc23ffff : Intel Corp. 82544EI Gigabit Ethernet Controller
      fc220000-fc23ffff : e1000
fc300000-fc3fffff : PCI Bus #04
  fc300000-fc300fff : PCI device 8086:1461 (Intel Corp.)
  fc301000-fc301fff : PCI device 8086:1461 (Intel Corp.)
fc400000-fdffffff : PCI Bus #07
  fc400000-fc400fff : ATI Technologies Inc Rage XL
  fc401000-fc401fff : Intel Corp. 82557 [Ethernet Pro 100]
    fc401000-fc401fff : eepro100
  fc420000-fc43ffff : Intel Corp. 82557 [Ethernet Pro 100]
  fd000000-fdffffff : ATI Technologies Inc Rage XL
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5] PCI Information  lspci -vvv

00:00.0 Host bridge: Intel Corp. e7500 DRAM Controller (rev 02)
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0

00:00.1 Class ff00: Intel Corp. e7500 DRAM Controller Error Reporting (rev 02)
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. e7500 HI_B Virtual PCI-to-PCI Bridge (F0) (rev 02) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64
 Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
 I/O behind bridge: 00002000-00002fff
 Memory behind bridge: fc100000-fc2fffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp. e7500 HI_C Virtual PCI-to-PCI Bridge (F0) (rev 02) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64
 Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: fc300000-fc3fffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if 00 [UHCI])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin A routed to IRQ 11
 Region 4: I/O ports at 1400 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if 00 [UHCI])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin B routed to IRQ 10
 Region 4: I/O ports at 1420 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02) (prog-if 00 [UHCI])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin C routed to IRQ 7
 Region 4: I/O ports at 1440 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 42) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
 I/O behind bridge: 00003000-00003fff
 Memory behind bridge: fc400000-fdffffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Interrupt: pin A routed to IRQ 7
 Region 0: I/O ports at <unassigned> [size=8]
 Region 1: I/O ports at <unassigned> [size=4]
 Region 2: I/O ports at <unassigned> [size=8]
 Region 3: I/O ports at <unassigned> [size=4]
 Region 4: I/O ports at 1460 [size=16]
 Region 5: Memory at 20000000 (32-bit, non-prefetchable) [disabled] [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Interrupt: pin B routed to IRQ 3
 Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 [IO(X)-APIC])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE- ERO- RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64, cache line size 10
 Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: fff00000-000fffff
 Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE+ ERO+ RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 [IO(X)-APIC])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE- ERO- RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64, cache line size 10
 Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
 I/O behind bridge: 00002000-00002fff
 Memory behind bridge: fc200000-fc2fffff
 Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE+ ERO+ RBC=0 OST=4
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

03:01.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet Controller (rev 02)
 Subsystem: Intel Corp. PRO/1000 XT Server Adapter
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (63750ns min), cache line size 08
 Interrupt: pin A routed to IRQ 5
 Region 0: Memory at fc220000 (64-bit, non-prefetchable) [size=128K]
 Region 2: Memory at fc200000 (64-bit, non-prefetchable) [size=128K]
 Region 4: I/O ports at 2000 [size=32]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
  Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
 Capabilities: [e4] PCI-X non-bridge device.
  Command: DPERE- ERO+ RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
 Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
  Address: 0000000000000000  Data: 0000

04:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 [IO(X)-APIC])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Region 0: Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE- ERO- RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

04:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64, cache line size 10
 Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: fff00000-000fffff
 Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE+ ERO+ RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

04:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 [IO(X)-APIC])
 Subsystem: Super Micro Computer Inc: Unknown device 3480
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Region 0: Memory at fc301000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE- ERO- RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

04:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64, cache line size 10
 Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: fff00000-000fffff
 Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
 BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 Capabilities: [50] PCI-X non-bridge device.
  Command: DPERE+ ERO+ RBC=0 OST=0
  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
 Subsystem: ATI Technologies Inc Rage XL
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min), cache line size 08
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
 Region 1: I/O ports at 3000 [size=256]
 Region 2: Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [5c] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
 Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min, 14000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 3
 Region 0: Memory at fc401000 (32-bit, non-prefetchable) [size=4K]
 Region 1: I/O ports at 3400 [size=64]
 Region 2: Memory at fc420000 (32-bit, non-prefetchable) [size=128K]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.7] Other relevant info kernel messages

output of dmesg:

Linux version 2.4.18-3custom (root@lds001) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #2 Thu Jun 13 10:53:25 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fefd000 (usable)
 BIOS-e820: 000000001fefd000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 130944
zone(0): 4096 pages.
zone(1): 126848 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda2
Initializing CPU#0
Detected 2196.268 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4377.80 BogoMIPS
Memory: 514188k/523776k available (1093k kernel code, 9188k reserved, 291k data, 264k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd885, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI: Found IRQ 7 for device 00:1f.1
PCI: Found IRQ 3 for device 00:1f.3
PCI: Sharing IRQ 3 with 07:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: (ide_setup_pci_device:) Could not enable device.
hda: WDC WD1000JB-00CRA0, ATA DISK drive
hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=193821/16/63
ide-floppy driver 0.99.newide
Partition check:
 hda: [PTBL] [12161/255/63] hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 3 for device 07:02.0
PCI: Sharing IRQ 3 with 00:1f.3
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:12:19:B3, IRQ 3.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
ide-floppy driver 0.99.newide
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 264k freed
Adding Swap: 1044216k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide-floppy driver 0.99.newide
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Intel(R) PRO/1000 Network Driver - version 4.1.7
Copyright (c) 1999-2002 Intel Corporation.
PCI: Found IRQ 5 for device 03:01.0
Intel(R) PRO/1000 Network Connection
eth1:  Mem:0xfc220000  IRQ:5  Speed:N/A  Duplex:N/A

Please help me to get the ide controller running, thanks.

