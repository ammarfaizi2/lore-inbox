Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292351AbSBBSvm>; Sat, 2 Feb 2002 13:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292349AbSBBSvd>; Sat, 2 Feb 2002 13:51:33 -0500
Received: from f307.law10.hotmail.com ([64.4.14.182]:4109 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S292348AbSBBSvV>;
	Sat, 2 Feb 2002 13:51:21 -0500
X-Originating-IP: [151.29.18.21]
From: "Vincenzo Cuciti" <vcuciti@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.5.3-pre6]:MTRR support doesn't work properly with Rage128 pro based card
Date: Sat, 02 Feb 2002 19:51:15 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F307TRqf69aZbLAX3cf000130cd@hotmail.com>
X-OriginalArrivalTime: 02 Feb 2002 18:51:15.0462 (UTC) FILETIME=[978A1260:01C1AC1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
         MTRR support doesn't work properly with Rage128 pro based card.
[2.] Full description of the problem/report:
         Graphic acceleration features  do not work under X since I 
installed kernel
         release 2.5.0.
         The problem arises mainly with games which use 3D rendering 
features
         (such as Tux Racer, Gl Tron ecc.)
         I tried to patch with 2.5.1, 2.5.2, 2.5.3-pre6 : I saw no 
improvement.
[3.] Keywords (i.e., modules, networking, kernel):
         mtrr , r128, dri, kernel, graphic acceleration
[4.] Kernel version (from /proc/version):
         2.5.3-pre6 (since 2.5.0)
         2.4.3 behaves correctly
[5.] Output of Oops.. message (if applicable) [snip]
         (From /var/log/kernel/warnings)
         mtrr: no MTRR for dc000000,2000000 found
[6.] A small shell script or example program which triggers the
     problem (if possible)
         Not available
[7.] Environment
         Kde 2.1.1
         XFree86 ver. 4.0.3
[7.1.] Software (add the output of the ver_linux script here)
         Linux QUENTIN 2.5.3-pre6 #8 mer gen 30 20:13:17 EST 2002 i686 
unknown
         Gnu C                  2.96
         Gnu make               3.79.1
         binutils               2.10.1.0.2
         util-linux             2.10s
         mount                  2.11b
         modutils               2.4.3
         e2fsprogs              1.19
         PPP                    2.4.0
         Linux C Library        2.2.2
         Dynamic linker (ldd)   2.2.2
         Procps                 2.0.7
         Net-tools              1.59
         Console-tools          0.2.3
         Sh-utils               2.0
         Modules Loaded         via82cxxx_audio ac97_codec 8139too crc32 
ov511
                                 usb-uhci usbcore nls_iso8859-1 nls_cp850
[7.2.] Processor information (from /proc/cpuinfo):
         processor       : 0
         vendor_id       : GenuineIntel
         cpu family      : 6
         model           : 8
         model name      : Pentium III (Coppermine)
         stepping        : 3
         cpu MHz         : 598.483
         cache size      : 256 KB
         fdiv_bug        : no
         hlt_bug         : no
         f00f_bug        : no
         coma_bug        : no
         fpu             : yes
         fpu_exception   : yes
         cpuid level     : 2
         wp              : yes
         flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge 
mca cmov
pat pse36 mmx fxsr sse
         bogomips        : 1192.75
[7.3.] Module information (from /proc/modules):
         via82cxxx_audio        17792   2
         ac97_codec              9456   0 [via82cxxx_audio]
         8139too                12464   1 (autoclean)
         crc32                    896   1 (autoclean) [8139too]
         ov511                  72176   0
         usb-uhci               21360   0 (unused)
         usbcore                55568   1 [ov511 usb-uhci]
         nls_iso8859-1           2880   1 (autoclean)
         nls_cp850               3616   1 (autoclean)
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
         (from /proc/iomem)
         00000000-0009fbff : System RAM
         0009fc00-0009ffff : reserved
         000a0000-000bffff : Video RAM area
         000c0000-000c7fff : Video ROM
         000f0000-000fffff : System ROM
         00100000-07febfff : System RAM
                 00100000-002395c9 : Kernel code
                 002395ca-00291fef : Kernel data
         07fec000-07feefff : ACPI Tables
         07fef000-07ffefff : reserved
         07fff000-07ffffff : ACPI Non-volatile Storage
         da000000-da0000ff : Realtek Semiconductor Co., Ltd. RTL-8139
                 da000000-da0000ff : 8139too
         da800000-daffffff : PCI Bus #01
                 da800000-da803fff : ATI Technologies Inc Rage 128 PF
         db000000-db0000ff : Motorola SM56 PCI Modem
         dbf00000-dfffffff : PCI Bus #01
                 dc000000-dfffffff : ATI Technologies Inc Rage 128 PF
         e0000000-e7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x]
         ffff0000-ffffffff : reserved
         (from /proc/ioports)
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
         03c0-03df : vga+
         03f6-03f6 : ide0
         03f8-03ff : serial(auto)
         0cf8-0cff : PCI conf1
         9800-98ff : Realtek Semiconductor Co., Ltd. RTL-8139
                 9800-98ff : 8139too
         a000-a003 : VIA Technologies, Inc. AC97 Audio Controller
                 a000-a003 : via82cxxx_audio
         a400-a403 : VIA Technologies, Inc. AC97 Audio Controller
                 a400-a403 : via82cxxx_audio
         a800-a8ff : VIA Technologies, Inc. AC97 Audio Controller
                 a800-a8ff : via82cxxx_audio
         b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
                 b000-b01f : usb-uhci
         b400-b41f : VIA Technologies, Inc. UHCI USB
                 b400-b41f : usb-uhci
         b800-b80f : VIA Technologies, Inc. Bus Master IDE
                 b800-b807 : ide0
                 b808-b80f : ide1
         d000-dfff : PCI Bus #01
                 d800-d8ff : ATI Technologies Inc Rage 128 PF
         e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c2)
        Subsystem: Asustek Computer, Inc.: Unknown device 8020
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: da800000-daffffff
        Prefetchable memory behind bridge: dbf00000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: Asustek Computer, Inc.: Unknown device 8020
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo
Super AC97/Audio] (rev 20)
        Subsystem: Asustek Computer, Inc.: Unknown device 1013
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at a800 [size=256]
        Region 1: I/O ports at a400 [size=4]
        Region 2: I/O ports at a000 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Communication controller: Motorola SM56 PCI Modem
        Subsystem: CIS Technology Inc SM56 PCI Speakerphone Modem
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at db000000 (32-bit, prefetchable) [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
        Subsystem: Unex Technology Corp. ND010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if
00
[VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0018
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at da800000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at dbfe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
                         Not available (no scsi devices mounted)
[7.7.] Other information that might be relevant to the problem
                 (from /proc/mtrr)
                 reg00: base=0x00000000 (   0MB), size= 128MB: write-back, 
count=1
                 reg01: base=0xe0000000 (3584MB), size= 128MB: 
write-combining, count=2
                 reg02: base=0xdc000000 (3520MB), size=  64MB: 
write-combining, count=4
                         slot     offset       size type flags    address 
mtrr
                 (from /proc/dri/0/vm)
                 0 0xda800000 0x00080000  REG  0x02 0xca883000 none
                 1 0xe0302000 0x004e0000  AGP  0x00 0x00000000    1
                 2 0xe0102000 0x00200000  AGP  0x00 0xcaa08000    1
                 3 0xe0101000 0x00001000  AGP  0x02 0xcaa06000    1
                 4 0xe0000000 0x00101000  AGP  0x02 0xca904000    1
                 5 0xdc000000 0x02000000   FB  0x00 0xc887f000    2
                 6 0xc887d000 0x00001000  SHM  0x20 0xc887d000 none
[X.] Other notes, patches, fixes, workarounds:
                 Nothing in particular.

Thanks in advance for help,
Vincenzo Cuciti





_________________________________________________________________
MSN Photos è il metodo più semplice per condividere e stampare le tue foto: 
http://photos.msn.it/Support/WorldWide.aspx

