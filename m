Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSIWAh0>; Sun, 22 Sep 2002 20:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264640AbSIWAh0>; Sun, 22 Sep 2002 20:37:26 -0400
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:41233 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264638AbSIWAhU>; Sun, 22 Sep 2002 20:37:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Martin Knott <martin@knotthome.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at vmalloc.c:236!  version 2.4.19
Date: Mon, 23 Sep 2002 01:44:42 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tHIy-0005Rd-00.2002-09-23-01-42-28@cmailg2.svr.pol.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Cannot use video1394 module to send DV to my camcorder.

I am attempting to do DV-ediiting under Linux. Capture, Edit work OK but 
trying to get it back to my camera persistently fails. I get the following 
message from both Kino 0.51 and MainConcept's madvout programs:

VIDEO1394_TALK_CHANNEL: Bad address

The following appears in dmesg:

kernel BUG at vmalloc.c:236!
invalid operand: 0000
CPU:    0
EIP:    1010:[<c012a997>]    Not tainted
EFLAGS: 00210246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d20ddbfc
esi: 00000200   edi: d20ddc1c   ebp: c6a0fe5c   esp: c6a0fe2c
ds: 1018   es: 1018   ss: 1018
Process madvout (pid: 2750, stackpage=c6a0f000)
Stack: 00000000 00000200 d20ddc1c c02c8d5f 00000000 00000000 00000010 fffffffe
       00000000 00000041 000031b5 d1df7f7c c6a0fe7c e21f8085 00000000 000001f2
       00000163 d20ddb80 00000200 d20ddc1c c6a0fea0 e21f82f8 00000000 bffdb808
Call Trace:    [<e21f8085>] [<e21f82f8>] [<c0117318>] [<e21f949b>] 
[<c013a8d1>]
  [<c013b21c>] [<c013a829>] [<c013bacb>] [<c01316af>] [<c01315bf>] 
[<c013e679>]
  [<c01099fb>]

Code: 0f 0b ec 00 20 1b 24 c0 e9 65 01 00 00 6a 02 53 e8 94 fe ff
 mask: 8000000000000000 usage: 8000000000000000

System Information follows. Sure hope you can give me some pointers  - non 
NULLthat is ;)

Thanks
Martin Knott

/proc/version
------------------
Linux version 2.4.19-win4lin-200209181 (root@clapham) (gcc version 2.95.3 
20010315 (SuSE)) #1 Wed Sep 18 23:22:57 BST 2002

/proc/cpuinfo
------------------
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1400.088
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2791.83

/proc/modules
--------------------
video1394              13040   1
ohci1394               16304   0 [video1394]
lt_serial              19744   2 (autoclean)
lt_modem              314464   0 (autoclean) [lt_serial]
raw1394                 6800   0
ieee1394               29520   0 [video1394 ohci1394 raw1394]
soundcore               3408   0 (autoclean)
Mvnetd                  8676   1 (unused)
Mvnet                  51968   0 [Mvnetd]
Mvnetint                 216   0 (unused)
Mvw                     4172   0 (unused)
Mvmouse                  704   0 (unused)
Mvkbd                    824   0 (unused)
Mvgic                   3160   0 (unused)
Mvdsp                    904   0 (unused)
Mserial                 5724   0 (unused)
Mmpip                   6796   0 (unused)
Mmerge                128636   0 [Mvnetd Mvnet Mvw Mvmouse Mvkbd Mvgic Mvdsp 
Mserial Mmpip]
mki-adapter            20720   0 [Mvnetd Mvnet Mvnetint Mvw Mvmouse Mvkbd 
Mvgic
Mvdsp Mserial Mmpip Mmerge]
mga                   101120   1
agpgart                31744   3 (autoclean)
usb-storage            77584   0 (autoclean) (unused)


/proc/ioports
------------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
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
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
c400-c41f : VIA Technologies, Inc. UHCI USB
  c400-c41f : usb-uhci
c800-c81f : VIA Technologies, Inc. UHCI USB (#2)
  c800-c81f : usb-uhci
cc00-ccff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  cc00-ccff : 8139too
d000-d01f : Creative Labs SB Audigy
d400-d4ff : Lucent Microelectronics LT WinModem
  d400-d4ff : ltserial
d800-d807 : Lucent Microelectronics LT WinModem
dc00-dc07 : Creative Labs SB Audigy MIDI/Game port
ff00-ff0f : VIA Technologies, Inc. Bus Master IDE
  ff00-ff07 : ide0
  ff08-ff0f : ide1

/proc/iomem
------------------
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0023b9c8 : Kernel code
  0023b9c9-002af67f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
dac00000-decfffff : PCI Bus #01
  dc000000-ddffffff : Matrox Graphics, Inc. MGA G400 AGP
dee00000-dfefffff : PCI Bus #01
  df000000-df7fffff : Matrox Graphics, Inc. MGA G400 AGP
  dfefc000-dfefffff : Matrox Graphics, Inc. MGA G400 AGP
dfff8000-dfffbfff : Creative Labs SB Audigy FireWire Port
dffff000-dffff7ff : Creative Labs SB Audigy FireWire Port
  dffff000-dffff7ff : ohci1394
dffffe00-dffffeff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  dffffe00-dffffeff : 8139too
dfffff00-dfffffff : Lucent Microelectronics LT WinModem
e0000000-e0ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

lspci -vvv
-------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: dee00000-dfefffff
        Prefetchable memory behind bridge: dac00000-decfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
        Subsystem: Digitan Systems Inc: Unknown device 9300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at d800 [size=8]
        Region 2: I/O ports at d400 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs: Unknown device 0004 (rev 
03)        Subsystem: Creative Labs: Unknown device 0051
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d000 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs: Unknown device 7003 (rev 03)
        Subsystem: Creative Labs: Unknown device 0040
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.2 FireWire (IEEE 1394): Creative Labs: Unknown device 4001 (prog-if 10 
[OHCI])
        Subsystem: Creative Labs: Unknown device 0010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at dfff8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
        Subsystem: VIA Technologies, Inc.: Unknown device 3074
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 14
        Region 4: I/O ports at ff00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0543
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


/proc/scsi/scsi
--------------------
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: GENERIC  Model: CRD-BP1500P      Rev: 6z34
  Type:   CD-ROM                           ANSI SCSI revision: 02

/proc/interrupts
---------------------
           CPU0
  0:     363653          XT-PIC  timer
  1:       8075          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        159          XT-PIC  eth0
 10:    1693970          XT-PIC  ltserial
 11:        394          XT-PIC  ohci1394
 12:      71160          XT-PIC  usb-uhci, usb-uhci
 14:     673380          XT-PIC  ide0
 15:      20691          XT-PIC  ide1
NMI:          0
ERR:          0

/proc/meminfo
--------------------
        total:    used:    free:  shared: buffers:  cached:
Mem:  528637952 455442432 73195520        0  7544832 327790592
Swap: 139788288        0 139788288
MemTotal:       516248 kB
MemFree:         71480 kB
MemShared:           0 kB
Buffers:          7368 kB
Cached:         320108 kB
SwapCached:          0 kB
Active:          49368 kB
Inactive:       353460 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       516248 kB
LowFree:         71480 kB
SwapTotal:      136512 kB
SwapFree:       136512 kB
