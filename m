Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVKEAHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVKEAHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVKEAHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:07:30 -0500
Received: from 72-34-70-242.skyriver.net ([72.34.70.242]:30183 "HELO
	mail.discoverycenters.org") by vger.kernel.org with SMTP
	id S1751177AbVKEAH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:07:29 -0500
Message-ID: <436BF7BB.9070900@discoverycenters.org>
Date: Fri, 04 Nov 2005 16:07:23 -0800
From: Frank Overton <frank@discoverycenters.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20050113 Red Hat/1.4.3-3.0.7.centos.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 series kernels panic on boot at PCI probe with 450nx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] 2.6 series kernels panic on boot at PCI probe with 450nx (2.4.x kernels boot without hitch)  
[2.] System: HP Netserver LH4s
[3.] Keywords: kernel, i450nx, PCI probe, boot, panic
[4.] Kernel version: 2.6.9-22, 2.6.9-11 by me and (2.6.6, 2.6.7 by Andrew Feldhacker)

[7.7.] For an additional example see: Andrew Feldhacker's June 2004 report at http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0407.0/0915.html

[X.] Other notes:
	-Someone reported that Mandrake 10.2 beta did not have this problem.
	-I know the legacy megaraid now requires a custom built kernel. I just can't get past the PCI-Probe to install it.

[7.] Environment
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.045
cache size      : 512 KB
physical id     : 0
siblings        : 1
runqueue        : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.045
cache size      : 512 KB
physical id     : 0
siblings        : 1
runqueue        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72
 
processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.045
cache size      : 512 KB
physical id     : 0
siblings        : 1
runqueue        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72
 
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.045
cache size      : 512 KB
physical id     : 0
siblings        : 1
runqueue        : 3
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

[7.3.] Module information (from /proc/modules):
ide-cd                 34016   0 (autoclean)
cdrom                  32896   0 (autoclean) [ide-cd]
qla2100               287804   5
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              16544   1 [iptable_filter]
softdog                 3004   1
usbserial              23964   0 (autoclean) (unused)
parport_pc             18884   1 (autoclean)
lp                      9156   0 (autoclean)
parport                38848   1 (autoclean) [parport_pc lp]
autofs4                16984   0 (autoclean) (unused)
lock_gulm              65712   1
crc32                   3764   0 [lock_gulm]
gfs                   291308   1 (autoclean)
lock_harness            3576   0 (autoclean) [lock_gulm gfs]
pool                   84928   4
natsemi                20000   1
e100                   60048   1
floppy                 57552   0 (autoclean)
sg                     37388   0 (autoclean)
microcode               6912   0 (autoclean)
keybdev                 2976   0 (unused)
mousedev                5688   1
hid                    22308   0 (unused)
input                   6176   0 [keybdev mousedev hid]
usbcore                81152   1 [usbserial hid]
ext3                   89992   2
jbd                    55092   2 [ext3]
megaraid               30636   3
sd_mod                 13936  16
scsi_mod              115240   3 [qla2100 sg megaraid sd_mod]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
1400-14ff : LSI Logic / Symbios Logic 53c895
8000-803f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
9000-901f : Intel Corp. 82371AB/EB/MB PIIX4 USB
9020-902f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  9020-9027 : ide0
a000-afff : PCI Bus #01
  a000-a0ff : LSI Logic / Symbios Logic 53c895 (#2)
b000-bfff : PCI Bus #02
  b000-b0ff : National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
    b000-b0ff : eth1
  b400-b4ff : QLogic Corp. QLA2100 64-bit Fibre Channel Adapter
    b400-b4ff : qla2100
  b800-b81f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    b800-b81f : e100

iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c8800-000c97ff : Extension ROM
000c9800-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-e7feffff : System RAM
  00100000-002aba6e : Kernel code
  002aba6f-003efb27 : Kernel data
e7ff0000-e7fffbff : ACPI Tables
e7fffc00-e7ffffff : ACPI Non-volatile Storage
e8000000-e8007fff : Hewlett-Packard Company NetServer Smart IRQ Router
e8008000-e8008fff : Cirrus Logic GD 5446
e8009000-e80090ff : LSI Logic / Symbios Logic 53c895
e800a000-e800afff : LSI Logic / Symbios Logic 53c895
e8100000-e81fffff : PCI Bus #01
  e8100000-e8100fff : LSI Logic / Symbios Logic 53c895 (#2)
  e8101000-e81010ff : LSI Logic / Symbios Logic 53c895 (#2)
e8200000-e83fffff : PCI Bus #02
  e8200000-e82fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    e8200000-e82fffff : e100
  e8300000-e8300fff : National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
    e8300000-e8300fff : eth1
  e8301000-e8301fff : QLogic Corp. QLA2100 64-bit Fibre Channel Adapter
    e8301000-e8301fff : qla2100
ea000000-ebffffff : Cirrus Logic GD 5446
f0000000-f7ffffff : Intel Corp. 80960RP [i960RP Microprocessor]
  f0000000-f000007f : MegaRAID: LSI Logic Corporation
f8000000-f80fffff : PCI Bus #02
  f8000000-f8000fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    f8000000-f8000fff : e100
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fffe8800-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

> 00:02.0 PCI bridge: Intel Corp. 80960RP [i960 RP 
> Microprocessor/Bridge] (rev 03) (prog-if 00 [Normal decode]) Control: 
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- 
> SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64, cache line size 
> 08 Bus: primary=00, secondary=01, subordinate=01, sec-latency=248 I/O 
> behind bridge: 0000a000-0000afff Memory behind bridge: 
> e8100000-e81fffff Prefetchable memory behind bridge: fff00000-000fffff 
> BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B- 00:02.1 
> I2O: Intel Corp. 80960RP [i960RP Microprocessor] (rev 03) (prog-if 01) 
> Subsystem: Hewlett-Packard Company MegaRAID T5, Integrated HP NetRAID 
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
> Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64, 
> cache line size 08 Interrupt: pin A routed to IRQ 10 BIST result: 00 
> Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M] 
> Expansion ROM at <unassigned> [disabled] [size=32K] 00:03.0 PCI 
> bridge: Digital Equipment Corporation DECchip 21152 (rev 02) (prog-if 
> 00 [Normal decode]) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
> VGASnoop- ParErr+ Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF- 
> FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
> <PERR- Latency: 64, cache line size 08 Bus: primary=00, secondary=02, 
> subordinate=02, sec-latency=234 I/O behind bridge: 0000b000-0000bfff 
> Memory behind bridge: e8200000-e83fffff Prefetchable memory behind 
> bridge: 00000000f8000000-00000000f8000000 BridgeCtl: Parity+ SERR+ 
> NoISA+ VGA- MAbort- >Reset- FastB2B- 00:06.0 System peripheral: 
> Hewlett-Packard Company NetServer Smart IRQ Router (rev a0) Subsystem: 
> Hewlett-Packard Company: Unknown device 0001 Control: I/O- Mem+ 
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ 
> FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Region 0: Memory at e8000000 
> (32-bit, non-prefetchable) [size=32K] 00:08.0 VGA compatible 
> controller: Cirrus Logic GD 5446 (rev 45) (prog-if 00 [VGA]) 
> Subsystem: Hewlett-Packard Company: Unknown device 0001 Control: I/O+ 
> Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- 
> FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Region 0: Memory at ea000000 
> (32-bit, prefetchable) [size=32M] Region 1: Memory at e8008000 
> (32-bit, non-prefetchable) [size=4K] Expansion ROM at <unassigned> 
> [disabled] [size=32K] 00:0f.0 ISA bridge: Intel Corp. 82371AB/EB/MB 
> PIIX4 ISA (rev 02) Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- 
> VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap- 66Mhz- UDF- 
> FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
> <PERR- Latency: 0 00:0f.1 IDE interface: Intel Corp. 82371AB/EB/MB 
> PIIX4 IDE (rev 01) (prog-if 80 [Master]) Control: I/O+ Mem- BusMaster+ 
> SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: 
> Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- Latency: 64 Region 4: I/O ports at 9020 
> [size=16] 00:0f.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB 
> (rev 01) (prog-if 00 [UHCI]) Control: I/O+ Mem- BusMaster- SpecCycle- 
> MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap- 
> 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- 
> >SERR- <PERR- Interrupt: pin D routed to IRQ 0 Region 4: I/O ports at 
> 9000 [size=32] 00:0f.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI 
> (rev 02) Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- Status: Cap- 66Mhz- UDF- FastB2B+ 
> ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
> Interrupt: pin ? routed to IRQ 9 00:10.0 Host bridge: Intel Corp. 
> 450NX - 82451NX Memory & I/O Controller (rev 03) Control: I/O- Mem- 
> BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- 
> FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- 00:12.0 Host bridge: Intel 
> Corp. 450NX - 82454NX/84460GX PCI Expander Bridge (rev 02) Control: 
> I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- 
> SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort+ >SERR- <PERR- Latency: 72, cache line size 
> 08 01:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 
> (rev 01) Subsystem: Hewlett-Packard Company: Unknown device 1000 
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
> Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 247 
> (7500ns min, 16000ns max), cache line size 08 Interrupt: pin A routed 
> to IRQ 11 Region 0: I/O ports at 1400 [size=256] Region 1: Memory at 
> e8009000 (32-bit, non-prefetchable) [size=256] Region 2: Memory at 
> e800a000 (32-bit, non-prefetchable) [size=4K] 01:07.0 SCSI storage 
> controller: LSI Logic / Symbios Logic 53c895 (rev 01) Subsystem: 
> Hewlett-Packard Company: Unknown device 1000 Control: I/O+ Mem+ 
> BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ 
> FastB2B- Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 247 (7500ns min, 
> 16000ns max), cache line size 08 Interrupt: pin A routed to IRQ 11 
> Region 0: I/O ports at a000 [size=256] Region 1: Memory at e8101000 
> (32-bit, non-prefetchable) [size=256] Region 2: Memory at e8100000 
> (32-bit, non-prefetchable) [size=4K] 02:02.0 Ethernet controller: 
> Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05) Subsystem: 
> Hewlett-Packard Company NetServer 10/100TX Control: I/O+ Mem+ 
> BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ 
> FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 66 (2000ns min, 
> 14000ns max), cache line size 08 Interrupt: pin A routed to IRQ 15 
> Region 0: Memory at f8000000 (32-bit, prefetchable) [size=4K] Region 
> 1: I/O ports at b800 [size=32] Region 2: Memory at e8200000 (32-bit, 
> non-prefetchable) [size=1M] Expansion ROM at <unassigned> [disabled] 
> [size=1M] Capabilities: [dc] Power Management version 1 Flags: PMEClk- 
> DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-) Status: D0 
> PME-Enable- DSel=0 DScale=0 PME- 02:03.0 Ethernet controller: National 
> Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller 
> Subsystem: Netgear FA311 / FA312 (FA311 with WoL HW) Control: I/O+ 
> Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ 
> FastB2B+ Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 90 (2750ns min, 
> 13000ns max) Interrupt: pin A routed to IRQ 5 Region 0: I/O ports at 
> b000 [size=256] Region 1: Memory at e8300000 (32-bit, 
> non-prefetchable) [size=4K] Expansion ROM at <unassigned> [disabled] 
> [size=64K] Capabilities: [40] Power Management version 2 Flags: 
> PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-) 
> Status: D0 PME-Enable- DSel=0 DScale=0 PME+ 02:04.0 SCSI storage 
> controller: QLogic Corp. QLA2100 64-bit Fibre Channel Adapter (rev 03) 
> Subsystem: QLogic Corp. QLA2100 64-bit Fibre Channel Adapter Control: 
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- 
> SERR+ FastB2B- Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64, cache line size 
> 08 Interrupt: pin A routed to IRQ 11 Region 0: I/O ports at b400 
> [size=256] Region 1: Memory at e8301000 (32-bit, non-prefetchable) 
> [size=4K] Expansion ROM at <unassigned> [disabled] [size=64K] 



[7.6.] SCSI information (from /proc/scsi/scsi)
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID1  8677R Rev:   D
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: FCArray 5_104196 Rev: 5549
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 01
  Vendor: HP       Model: FCArray 5_69464  Rev: 5549
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 02
  Vendor: HP       Model: FCArray 5_104196 Rev: 5549
  Type:   Direct-Access                    ANSI SCSI revision: 02




