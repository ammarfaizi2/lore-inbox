Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbTCGQou>; Fri, 7 Mar 2003 11:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261673AbTCGQou>; Fri, 7 Mar 2003 11:44:50 -0500
Received: from web13903.mail.yahoo.com ([216.136.175.29]:48494 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261665AbTCGQol>; Fri, 7 Mar 2003 11:44:41 -0500
Message-ID: <20030307165516.10224.qmail@web13903.mail.yahoo.com>
Date: Fri, 7 Mar 2003 08:55:16 -0800 (PST)
From: Condor <condor_inc@yahoo.com>
Subject: kernel 2.4.x bug in adaptec raid modules
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i use linux slackware 8.1 i386 raise fs and i try some
kernels in my server.
I found problem.
Explain problem:
My raid is Adaptec ATA 2400A IDE. My raid disks is on
UFS file system.
My boot disk (hda1) is on raise fs. I initialize my
raid with:
modprobe dpt_i2o
and i mount them:
mount -t ufs -o ufstype=44bsd /dev/sda5 /mnt/disk
When i copy/move small files (i try with 29 kb file)
from hda1 to sda5
my server is frezzing. Need cold restart. I try with
large files, no problem.

Any body know this problem and have solution for me?
I try latest kernel 2.4.20 but problem exist.

--- begin paste need parts ---
#sh ver_linux

If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.
 
Linux urban 2.4.18 #4 Fri May 31 01:25:31 PDT 2002
i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.16
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    command
Sh-utils               2.0
Modules Loaded         ide-scsi dpt_i2o eepro100
--- end ver_linux ---
--- kernel version ---
Linux version 2.4.18 (root@midas) (gcc version 2.95.3
20010315 (release)) #4 Fri May 31 01:25:31 PDT 2002
--- end version ---
--- proccesor ---
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm)
stepping        : 2
cpu MHz         : 1050.066
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall
mmxext 3dnowext 3dnow
bogomips        : 2097.15
--- end processor ---
--- modules ---
ide-scsi                7456   0
dpt_i2o                25056   0 (unused)
eepro100               17264   1
--- end modules ---
--- drivers information /proc/ioports ---
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
e000-e03f : Intel Corp. 82557 [Ethernet Pro 100]
  e000-e03f : eepro100
e400-e40f : VIA Technologies, Inc. Bus Master IDE
--- end drivers ---
--- begin iomem ---
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0028031c : Kernel code
  0028031d-002eade3 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
20000000-23ffffff : S3 Inc. 86c868 [Vision 868 VRAM]
vers 0
e8000000-e9ffffff : Distributed Processing Technology
SmartRAID V Controller
eb000000-eb3fffff : VIA Technologies, Inc. VT8367
[KT266]
eb400000-eb41ffff : Intel Corp. 82557 [Ethernet Pro
100]
eb420000-eb420fff : Intel Corp. 82557 [Ethernet Pro
100]
  eb420000-eb420fff : eepro100
ffff0000-ffffffff : reserved
--- end iomem ---
--- begin lspci -vvv ---
00:00.0 Host bridge: VIA Technologies, Inc. VT8367
[KT266]
        Subsystem: Elitegroup Computer Systems:
Unknown device 0996
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at eb000000 (32-bit,
prefetchable) [size=4M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367
[KT266 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge:
fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:08.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S
Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache
line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at eb420000 (32-bit,
non-prefetchable) [size=4K]
        Region 1: I/O ports at e000 [size=64]
        Region 2: Memory at eb400000 (32-bit,
non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled]
[size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2
PME-

00:09.0 VGA compatible controller: S3 Inc. 86c868
[Vision 868 VRAM] vers 0 (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20000000 (32-bit,
non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled]
[size=64K]

00:0b.0 PCI bridge: Distributed Processing Technology
PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02,
sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 00100000-000fffff
        Prefetchable memory behind bridge:
00100000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort-
>Reset- FastB2B-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0b.1 I2O: Distributed Processing Technology
SmartRAID V Controller (rev 02) (prog-if 01)
        Subsystem: Distributed Processing Technology
2400A UDMA Four Channel
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 250ns max), cache line
size 08
        Interrupt: pin A routed to IRQ 12
        BIST result: 00
        Region 0: Memory at e8000000 (32-bit,
prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled]
[size=32K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA
Bridge
        Subsystem: Elitegroup Computer Systems:
Unknown device 0996
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master
IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
--- end lspci ---
--- begin scsi information ---
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ADAPTEC  Model: RAID-0           Rev: 370L
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi0 Channel: 02 Id: 00 Lun: 00
  Vendor: ADAPTEC  Model: RAID-0           Rev: 370L
  Type:   Direct-Access                    ANSI SCSI
revision: 02
--- end scsi info ---

Best Regards,
Condor



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
