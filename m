Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWCMWzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWCMWzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWCMWzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:55:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:52704 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751209AbWCMWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:55:35 -0500
Message-ID: <4415F863.9040203@simg.de>
Date: Mon, 13 Mar 2006 23:55:31 +0100
From: Stefan <stefan-kernel@simg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323
X-Accept-Language: German, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Crash when bunring CD/DVD
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:19bc3e802cd2a3798db68ea433f6540f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I try to burn CD's/DVD's my computer crashes.

It seems to be independently from the recording software and from the
drive. It occurs with cdrecord (cdrecord-clone version 2.01.01a01 from
debian) and growisofs (version 5.21 from debian), and with the drives
NEC ND-4550A and LG GMA-4020B.

The problem occurs at least with the kernels 2.6.14.7, 2.6.15.4 and
2.6.16-rc6 (The earlier verions I tested are very unstable. Mostly
it was not possible even to boot.)

Unfortunately I cant obtain any error messages, even with several debug
options turned on. Here is a screenshot :-) of crashed cdrecord, but
there is nothing unnormal to see:
http://www.simg.de/tmp10/cd-2.6.16-rc6.png

That is my .config:
http://www.simg.de/tmp10/2.6.16-rc6-config

My hardware is:
Mainboard: Tyan S2466 (AMD 760MPX Dual Athlon board, latest BIOS)
CPU's: 2 x Barton MP 2133 MHz
Memory: 2GB registred ECC
Drives: see below
PCI: see bolow

More Info is attached below. Please mail me, if you need more.


Best regards,
Stefan



----------------------------------------------------------------------------------
/proc/scsi:

Attached devices:
Host: scsi0 Channel: 01 Id: 00 Lun: 00
   Vendor: MAXTOR   Model: ATLAS15K2_73SCA  Rev: JNZM
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 01 Id: 01 Lun: 00
   Vendor: FUJITSU  Model: MAN3367MP        Rev: 0109
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: _NEC     Model: DVD_RW ND-4550A  Rev: 1.07
   Type:   CD-ROM                           ANSI SCSI revision: ffffffff
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: HL-DT-ST Model: DVDRAM GMA-4020B Rev: A109
   Type:   CD-ROM                           ANSI SCSI revision: ffffffff
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: Generic  Model: STORAGE DEVICE   Rev: 9317
   Type:   Direct-Access                    ANSI SCSI revision: 02

----------------------------------------------------------------------------------
ide/scsi boot messages:

Mar 13 20:33:39 ws2 kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Mar 13 20:33:39 ws2 kernel: AMD7441: IDE controller at PCI slot 0000:00:07.1
Mar 13 20:33:39 ws2 kernel: AMD7441: chipset revision 4
Mar 13 20:33:39 ws2 kernel: AMD7441: not 100%% native mode: will probe 
irqs later
Mar 13 20:33:39 ws2 kernel: AMD7441: 0000:00:07.1 (rev 04) UDMA100 
controller
Mar 13 20:33:39 ws2 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Mar 13 20:33:39 ws2 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:DMA
Mar 13 20:33:39 ws2 kernel: hda: HDT722525DLAT80, ATA DISK drive
Mar 13 20:33:39 ws2 kernel: hdb: Pioneer DVD-ROM ATAPIModel DVD-106S 
012, ATAPI CD/DVD-ROM drive
Mar 13 20:33:39 ws2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 13 20:33:39 ws2 kernel: hdc: _NEC DVD_RW ND-4550A, ATAPI CD/DVD-ROM 
drive
Mar 13 20:33:39 ws2 kernel: hdd: HL-DT-ST DVDRAM GMA-4020B, ATAPI 
CD/DVD-ROM drive
Mar 13 20:33:39 ws2 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 13 20:33:39 ws2 kernel: hda: max request size: 1024KiB
Mar 13 20:33:39 ws2 kernel: hda: 488397168 sectors (250059 MB) w/7674KiB 
Cache, CHS=30401/255/63, UDMA(100)
Mar 13 20:33:39 ws2 kernel: hda: cache flushes supported
Mar 13 20:33:39 ws2 kernel:  hda: hda1 hda2 hda3
Mar 13 20:33:39 ws2 kernel: hdb: ATAPI 40X DVD-ROM drive, 256kB Cache, 
UDMA(66)
Mar 13 20:33:39 ws2 kernel: Uniform CD-ROM driver Revision: 3.20
Mar 13 20:33:39 ws2 kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Mar 13 20:33:39 ws2 kernel: ide-cd: passing drive hdd to ide-scsi emulation.
Mar 13 20:33:39 ws2 kernel: qla1280: QLA12160 found on PCI bus 0, dev 9
Mar 13 20:33:39 ws2 kernel: scsi(0): Reading NVRAM
Mar 13 20:33:39 ws2 kernel: scsi(0:0): Resetting SCSI BUS
Mar 13 20:33:39 ws2 kernel: scsi(0:1): Resetting SCSI BUS
Mar 13 20:33:39 ws2 kernel: scsi0 : QLogic QLA12160 PCI to SCSI Host Adapter
Mar 13 20:33:39 ws2 kernel:        Firmware version: 10.04.42, Driver 
version 3.25
Mar 13 20:33:39 ws2 kernel:   Vendor: MAXTOR    Model: ATLAS15K2_73SCA 
  Rev: JNZM
Mar 13 20:33:39 ws2 kernel:   Type:   Direct-Access 
  ANSI SCSI revision: 03
Mar 13 20:33:39 ws2 kernel: scsi(0:1:0:0): Sync: period 9, offset 24, 
Wide, DT
Mar 13 20:33:39 ws2 kernel:   Vendor: FUJITSU   Model: MAN3367MP 
  Rev: 0109
Mar 13 20:33:39 ws2 kernel:   Type:   Direct-Access 
  ANSI SCSI revision: 03
Mar 13 20:33:39 ws2 kernel: scsi(0:1:1:0): Sync: period 9, offset 24, 
Wide, DT
Mar 13 20:33:39 ws2 kernel: ide-scsi is deprecated for cd burning! Use 
ide-cd and give dev=/dev/hdX as device
Mar 13 20:33:39 ws2 kernel: scsi1 : SCSI host adapter emulation for IDE 
ATAPI devices
Mar 13 20:33:39 ws2 kernel:   Vendor: _NEC      Model: DVD_RW ND-4550A 
  Rev: 1.07
Mar 13 20:33:39 ws2 kernel:   Type:   CD-ROM 
  ANSI SCSI revision: 00
Mar 13 20:33:39 ws2 kernel: scsi2 : SCSI host adapter emulation for IDE 
ATAPI devices
Mar 13 20:33:39 ws2 kernel:   Vendor: HL-DT-ST  Model: DVDRAM GMA-4020B 
  Rev: A109
Mar 13 20:33:39 ws2 kernel:   Type:   CD-ROM 
  ANSI SCSI revision: 00
Mar 13 20:33:39 ws2 kernel: SCSI device sda: 143374650 512-byte hdwr 
sectors (73408 MB)
Mar 13 20:33:39 ws2 kernel: SCSI device sda: drive cache: write through
Mar 13 20:33:39 ws2 kernel: SCSI device sda: 143374650 512-byte hdwr 
sectors (73408 MB)
Mar 13 20:33:39 ws2 kernel: SCSI device sda: drive cache: write through
Mar 13 20:33:39 ws2 kernel:  sda: sda1 sda2 sda3 sda4
Mar 13 20:33:39 ws2 kernel: Attached scsi disk sda at scsi0, channel 1, 
id 0, lun 0
Mar 13 20:33:39 ws2 kernel: SCSI device sdb: 71771688 512-byte hdwr 
sectors (36747 MB)
Mar 13 20:33:39 ws2 kernel: SCSI device sdb: drive cache: write back
Mar 13 20:33:39 ws2 kernel: SCSI device sdb: 71771688 512-byte hdwr 
sectors (36747 MB)
Mar 13 20:33:39 ws2 kernel: SCSI device sdb: drive cache: write back
Mar 13 20:33:39 ws2 kernel:  sdb: sdb1 sdb2
Mar 13 20:33:39 ws2 kernel: Attached scsi disk sdb at scsi0, channel 1, 
id 1, lun 0
Mar 13 20:33:39 ws2 kernel: sr0: scsi3-mmc drive: 0x/0x caddy
Mar 13 20:33:39 ws2 kernel: sr1: scsi3-mmc drive: 0x/0x caddy
Mar 13 20:33:39 ws2 kernel: Attached scsi generic sg0 at scsi0, channel 
1, id 0, lun 0,  type 0
Mar 13 20:33:39 ws2 kernel: Attached scsi generic sg1 at scsi0, channel 
1, id 1, lun 0,  type 0
Mar 13 20:33:39 ws2 kernel: Attached scsi generic sg2 at scsi1, channel 
0, id 0, lun 0,  type 5
Mar 13 20:33:39 ws2 kernel: Attached scsi generic sg3 at scsi2, channel 
0, id 0, lun 0,  type 5


----------------------------------------------------------------------------------

/proc/interrupts:
            CPU0       CPU1
   0:     503595     744635    IO-APIC-edge  timer
   1:       5040       7016    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          2          2    IO-APIC-edge  rtc
  12:     159728     195845    IO-APIC-edge  i8042
  14:      28317      29306    IO-APIC-edge  ide0
  15:          0         13    IO-APIC-edge  ide1
  16:      15882      15870   IO-APIC-level  bttv0, ehci_hcd:usb1
  17:      44864      44277   IO-APIC-level  qla1280, ohci1394
  18:          8          8   IO-APIC-level  ohci_hcd:usb2, Ensoniq AudioPCI
  19:      19338      19233   IO-APIC-level  saa7146 (0), ohci_hcd:usb3, 
eth0
NMI:      64670      98880
LOC:    1248159    1248158
ERR:          0
MIS:

----------------------------------------------------------------------------------

/proc/iomem:
00000000-0009e3ff : System RAM
0009e400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000cd000-000cd7ff : Adapter ROM
000cd800-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7fffffff : System RAM
   00100000-0042edeb : Kernel code
   0042edec-0055e44b : Kernel data
88000000-8801ffff : 0000:00:09.0
c0000000-c0000fff : 0000:00:09.0
c0100000-c01fffff : PCI Bus #01
   c0100000-c010ffff : 0000:01:05.0
   c0110000-c011ffff : 0000:01:05.1
   c0120000-c013ffff : 0000:01:05.0
c0200000-c03fffff : PCI Bus #02
   c0201000-c02011ff : 0000:02:07.0
     c0201000-c02011ff : saa7146
   c0201400-c020147f : 0000:02:08.0
   c0300000-c03fffff : PCI Bus #03
     c0300000-c0300fff : 0000:03:09.0
       c0300000-c0300fff : ohci_hcd
     c0301000-c0301fff : 0000:03:09.1
       c0301000-c0301fff : ohci_hcd
     c0302000-c03027ff : 0000:03:08.0
       c0302000-c03027ff : ohci1394
     c0302800-c03028ff : 0000:03:09.2
       c0302800-c03028ff : ehci_hcd
c0600000-c0600fff : 0000:00:00.0
c4000000-c7ffffff : 0000:00:00.0
d0000000-efffffff : PCI Bus #01
   d0000000-dfffffff : 0000:01:05.0
     d0000000-dfffffff : vesafb
   e0000000-efffffff : 0000:01:05.1
f0000000-f00fffff : PCI Bus #02
   f0000000-f0000fff : 0000:02:04.0
     f0000000-f0000fff : bttv0
   f0001000-f0001fff : 0000:02:04.1
   f0020000-f003ffff : 0000:02:08.0
fec00000-fec07fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

----------------------------------------------------------------------------------

/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0c00-0c07 : w83627hf
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:09.0
1410-1413 : 0000:00:00.0
2000-2fff : PCI Bus #01
   2000-20ff : 0000:01:05.0
3000-4fff : PCI Bus #02
   3000-307f : 0000:02:08.0
     3000-307f : 0000:02:08.0
   3080-30bf : 0000:02:06.0
     3080-30bf : Ensoniq AudioPCI
   4000-4fff : PCI Bus #03
     4000-407f : 0000:03:08.0
80e0-80ef : amd756-smbus
f000-f00f : 0000:00:07.1
   f000-f007 : ide0
   f008-f00f : ide1

----------------------------------------------------------------------------------

/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP 2800+
stepping        : 0
cpu MHz         : 2133.684
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4276.53

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 2133.684
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4267.23

----------------------------------------------------------------------------------

lspci -vvv
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at c4000000 (32-bit, prefetchable) [size=64M]
         Region 1: Memory at c0600000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at 1410 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 99
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
         I/O behind bridge: 00002000-00002fff
         Memory behind bridge: c0100000-c01fffff
         Prefetchable memory behind bridge: d0000000-efffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA 
(rev 04)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] 
IDE (rev 04) (prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 4: I/O ports at f000 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI 
(rev 03)
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:09.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel 
Ultra3 SCSI Processor (rev 06)
         Subsystem: QLogic Corp.: Unknown device 0007
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at 1000 [size=256]
         Region 1: Memory at c0000000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 88000000 [disabled] [size=128K]
         Capabilities: [44] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI 
(rev 04) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=02, subordinate=03, sec-latency=69
         I/O behind bridge: 00003000-00004fff
         Memory behind bridge: c0200000-c03fffff
         Prefetchable memory behind bridge: f0000000-f00fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:01:05.0 VGA compatible controller: ATI Technologies Inc RV350 AP 
[Radeon 9600] (prog-if 00 [VGA])
         Subsystem: C.P. Technology Co. Ltd PowerColor R96A-C3N
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
         Region 1: I/O ports at 2000 [size=256]
         Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at c0120000 [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- 
FW- Rate=<none>
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.1 Display controller: ATI Technologies Inc RV350 AP [Radeon 
9600] (Secondary)
         Subsystem: C.P. Technology Co. Ltd: Unknown device 2065
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Region 1: Memory at c0110000 (32-bit, non-prefetchable) [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 02)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=4K]

0000:02:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 02)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at f0001000 (32-bit, prefetchable) [size=4K]

0000:02:05.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge 
(non-transparent mode) (rev 11) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x10 (64 bytes)
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
         I/O behind bridge: 00004000-00004fff
         Memory behind bridge: c0300000-c03fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                 Bridge: PM- B3+
         Capabilities: [90] #06 [0080]

0000:02:06.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 3080 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:07.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
         Subsystem: TERRATEC Electronic GmbH: Unknown device 1156
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (3750ns min, 9500ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at c0201000 (32-bit, non-prefetchable) [size=512]

0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
         Subsystem: Tyan Computer Tiger MPX S2466 (3C920 Integrated Fast 
Ethernet Controller)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 80 (2500ns min, 2500ns max), Cache Line Size: 0x10 (64 
bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at 3000 [size=128]
         Region 1: Memory at c0201400 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at f0020000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:03:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns max), Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at c0302000 (32-bit, non-prefetchable) [size=2K]
         Region 1: I/O ports at 4000 [size=128]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:09.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 
[OHCI])
         Subsystem: Unknown device 2098:2100
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 
bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at c0300000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:09.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 
[OHCI])
         Subsystem: Unknown device 2098:2100
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 
bytes)
         Interrupt: pin B routed to IRQ 19
         Region 0: Memory at c0301000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 
20 [EHCI])
         Subsystem: Unknown device 2098:2000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 132 (4000ns min, 8500ns max), Cache Line Size: 0x10 
(64 bytes)
         Interrupt: pin C routed to IRQ 16
         Region 0: Memory at c0302800 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------------------

ver_linux output (Debian 3.1 system)
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded
