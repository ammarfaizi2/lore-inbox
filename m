Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUAEPpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAEPpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:45:40 -0500
Received: from smtp0.libero.it ([193.70.192.33]:56284 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265158AbUAEPnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:43:19 -0500
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.6.1-rc1-mm1 and Sisfb
Date: Mon, 5 Jan 2004 16:16:09 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401051615.51468.jorge78@inwind.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5+X+/jIOuguVOBz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5+X+/jIOuguVOBz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi to all.

Today I've compiled and install 2.6.1-rc1-mm1 and I've got multiple oopses in 
the messages console.
Regards.
			Jorge

My .config framebuffer section: 

CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

Lspci output:

D998:/home/io# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: ec100000-ec1fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at 9480 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev 
a0) (prog-if 00 [Generic])
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 173 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: I/O ports at 9000 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound 
Controller (rev a0)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 173 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 8800 [size=256]
        Region 1: I/O ports at 9080 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ec002000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at 9400 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 8c00 [size=256]
        Region 1: Memory at ec002800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 1e400000-1e7ff000 (prefetchable)
        Memory window 1: 1e800000-1ebff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
        Memory window 0: 1ec00000-1efff000 (prefetchable)
        Memory window 1: 1f000000-1f3ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001a
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec100000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at a000 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

03:00.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: DTK Computer: Unknown device 0105
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 1f000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2
+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: DTK Computer: Unknown device 0105
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at 1f001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2
+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: DTK Computer: Unknown device 0205
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 0x20 (128 
bytes)
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at 1f002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2
+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------- Oopses -------------------------------

ksymoops 2.4.9 on i686 2.6.1-rc1-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.1-rc1-mm1/ (default)
     -m /boot/System.map-2.6.1-rc1-mm1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  4 20:48:16 D998 kernel: Machine check exception polling timer started.
Jan  4 20:48:16 D998 kernel: 8139too Fast Ethernet driver 0.9.27
Jan  4 20:48:17 D998 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jan  4 20:48:17 D998 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jan  4 20:48:17 D998 kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x200-0x20f 0x3c0-0x3df 0x480-0x48f 0x4d0-0x4d7
Jan  4 20:48:17 D998 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jan  4 20:48:26 D998 kernel: 022d569c
Jan  4 20:48:26 D998 kernel: Oops: 0002 [#1]
Jan  4 20:48:26 D998 kernel: CPU:    0
Jan  4 20:48:26 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:48:26 D998 kernel: EFLAGS: 00013246
Jan  4 20:48:26 D998 kernel: eax: 80046ef8   ebx: fefffb10   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:48:26 D998 kernel: esi: 022d559c   edi: fefffb10   ebp: 1da13e44   
esp: 1da13e38
Jan  4 20:48:26 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:48:26 D998 kernel: Stack: 1d3b1194 1d3b1194 02541aa0 1da13f84 
022cee17 1d3b1194 1fceb180 80046ef8 
Jan  4 20:48:26 D998 kernel:        fefffb10 02541aa0 1fcf2a00 1da13e84 
02194d1d 1d3b1194 1d8d3a80 1fcd9fb8 
Jan  4 20:48:26 D998 kernel:        fffffff4 1fce5984 1fce5914 1da13ea8 
02164c0e 1fce5914 1d8d3a80 1da13f68 
Jan  4 20:48:26 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ebp; 1da13e44 <_end+1b4c4130/fda9b2ec>
>>esp; 1da13e38 <_end+1b4c4124/fda9b2ec>

Jan  4 20:48:26 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:48:27 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefffb10
Jan  4 20:48:27 D998 kernel: 022d569c
Jan  4 20:48:27 D998 kernel: Oops: 0002 [#2]
Jan  4 20:48:27 D998 kernel: CPU:    0
Jan  4 20:48:27 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:48:27 D998 kernel: EFLAGS: 00013246
Jan  4 20:48:27 D998 kernel: eax: 80046ef8   ebx: fefffb10   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:48:27 D998 kernel: esi: 022d559c   edi: fefffb10   ebp: 1d967e44   
esp: 1d967e38
Jan  4 20:48:27 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:48:27 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1d967f84 
022cee17 1d3b1194 1dba4380 80046ef8 
Jan  4 20:48:27 D998 kernel:        fefffb10 02541aa0 00004c56 00000000 
1dab9a80 1d967e90 1dab9aa0 1d967f6c 
Jan  4 20:48:27 D998 kernel:        1d8d3af0 1febc264 1d966000 0000002e 
00000000 1d8d3a80 1fa34005 00244d69 
Jan  4 20:48:27 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ebp; 1d967e44 <_end+1b418130/fda9b2ec>
>>esp; 1d967e38 <_end+1b418124/fda9b2ec>

Jan  4 20:48:27 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:48:30 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefffb10
Jan  4 20:48:30 D998 kernel: 022d569c
Jan  4 20:48:30 D998 kernel: Oops: 0002 [#3]
Jan  4 20:48:30 D998 kernel: CPU:    0
Jan  4 20:48:30 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:48:30 D998 kernel: EFLAGS: 00013246
Jan  4 20:48:30 D998 kernel: eax: 80046ef8   ebx: fefffb10   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:48:30 D998 kernel: esi: 022d559c   edi: fefffb10   ebp: 1d911e44   
esp: 1d911e38
Jan  4 20:48:30 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:48:30 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1d911f84 
022cee17 1d3b1194 1d97dd80 80046ef8 
Jan  4 20:48:30 D998 kernel:        fefffb10 02541aa0 00004c56 00000000 
1da10e80 1d911e90 1da10ea0 1d911f6c 
Jan  4 20:48:30 D998 kernel:        1d8d3af0 1febc264 1d910000 0000002e 
00000000 1d8d3a80 1fa34005 00244d69 
Jan  4 20:48:30 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ebp; 1d911e44 <_end+1b3c2130/fda9b2ec>
>>esp; 1d911e38 <_end+1b3c2124/fda9b2ec>

Jan  4 20:48:30 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:48:34 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefffb10
Jan  4 20:48:34 D998 kernel: 022d569c
Jan  4 20:48:34 D998 kernel: Oops: 0002 [#4]
Jan  4 20:48:34 D998 kernel: CPU:    0
Jan  4 20:48:34 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:48:34 D998 kernel: EFLAGS: 00013246
Jan  4 20:48:34 D998 kernel: eax: 80046ef8   ebx: fefffb10   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:48:34 D998 kernel: esi: 022d559c   edi: fefffb10   ebp: 1db27e44   
esp: 1db27e38
Jan  4 20:48:34 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:48:34 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1db27f84 
022cee17 1d3b1194 1f6b0680 80046ef8 
Jan  4 20:48:34 D998 kernel:        fefffb10 02541aa0 00004c56 00000000 
1dba4c80 1db27e90 1dba4ca0 1db27f6c 
Jan  4 20:48:34 D998 kernel:        1d8d3af0 1febc264 1db26000 0000002e 
00000000 1d8d3a80 1fa34005 00244d69 
Jan  4 20:48:34 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefffb10 <_end+fcaafdfc/fda9b2ec>
>>ebp; 1db27e44 <_end+1b5d8130/fda9b2ec>
>>esp; 1db27e38 <_end+1b5d8124/fda9b2ec>

Jan  4 20:48:34 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:52:45 D998 kernel: 022d569c
Jan  4 20:52:45 D998 kernel: Oops: 0002 [#5]
Jan  4 20:52:45 D998 kernel: CPU:    0
Jan  4 20:52:45 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:52:45 D998 kernel: EFLAGS: 00013246
Jan  4 20:52:45 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:52:45 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1e4abe44   
esp: 1e4abe38
Jan  4 20:52:45 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:52:45 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1e4abf84 
022cee17 1d3b1194 1f77a380 80046ef8 
Jan  4 20:52:45 D998 kernel:        fefff870 02541aa0 00004c56 00000000 
1f77a280 1e4abe90 1f77a2a0 1e4abf6c 
Jan  4 20:52:45 D998 kernel:        1d8d3af0 1febc264 1e4aa000 0000002e 
00000000 1d8d3a80 1bac1005 00244d69 
Jan  4 20:52:45 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1e4abe44 <_end+1bf5c130/fda9b2ec>
>>esp; 1e4abe38 <_end+1bf5c124/fda9b2ec>

Jan  4 20:52:45 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:52:46 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:52:46 D998 kernel: 022d569c
Jan  4 20:52:46 D998 kernel: Oops: 0002 [#6]
Jan  4 20:52:46 D998 kernel: CPU:    0
Jan  4 20:52:46 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:52:46 D998 kernel: EFLAGS: 00013246
Jan  4 20:52:46 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:52:46 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1bae1e44   
esp: 1bae1e38
Jan  4 20:52:46 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:52:46 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1bae1f84 
022cee17 1d3b1194 1f70ed80 80046ef8 
Jan  4 20:52:46 D998 kernel:        fefff870 02541aa0 00004c56 00000000 
1f6c3480 1bae1e90 1f6c34a0 1bae1f6c 
Jan  4 20:52:46 D998 kernel:        1d8d3af0 1febc264 1bae0000 0000002e 
00000000 1d8d3a80 1bac1005 00244d69 
Jan  4 20:52:46 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1bae1e44 <_end+19592130/fda9b2ec>
>>esp; 1bae1e38 <_end+19592124/fda9b2ec>

Jan  4 20:52:46 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:52:49 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:52:49 D998 kernel: 022d569c
Jan  4 20:52:49 D998 kernel: Oops: 0002 [#7]
Jan  4 20:52:49 D998 kernel: CPU:    0
Jan  4 20:52:49 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:52:49 D998 kernel: EFLAGS: 00013246
Jan  4 20:52:49 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:52:49 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1c823e44   
esp: 1c823e38
Jan  4 20:52:49 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:52:49 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1c823f84 
022cee17 1d3b1194 1dba4280 80046ef8 
Jan  4 20:52:49 D998 kernel:        fefff870 02541aa0 00004c56 00000000 
1e439580 1c823e90 1e4395a0 1c823f6c 
Jan  4 20:52:49 D998 kernel:        1d8d3af0 1febc264 1c822000 0000002e 
00000000 1d8d3a80 1bac1005 00244d69 
Jan  4 20:52:49 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1c823e44 <_end+1a2d4130/fda9b2ec>
>>esp; 1c823e38 <_end+1a2d4124/fda9b2ec>

Jan  4 20:52:49 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:52:53 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:52:53 D998 kernel: 022d569c
Jan  4 20:52:53 D998 kernel: Oops: 0002 [#8]
Jan  4 20:52:53 D998 kernel: CPU:    0
Jan  4 20:52:53 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:52:53 D998 kernel: EFLAGS: 00013246
Jan  4 20:52:53 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:52:53 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1ce11e44   
esp: 1ce11e38
Jan  4 20:52:53 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:52:53 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1ce11f84 
022cee17 1d3b1194 1e439580 80046ef8 
Jan  4 20:52:53 D998 kernel:        fefff870 02541aa0 00004c56 00000000 
1f6c3880 1ce11e90 1f6c38a0 1ce11f6c 
Jan  4 20:52:53 D998 kernel:        1d8d3af0 1febc264 1ce10000 0000002e 
00000000 1d8d3a80 1bac1005 00244d69 
Jan  4 20:52:53 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1ce11e44 <_end+1a8c2130/fda9b2ec>
>>esp; 1ce11e38 <_end+1a8c2124/fda9b2ec>

Jan  4 20:52:53 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:54:45 D998 kernel: 022d569c
Jan  4 20:54:45 D998 kernel: Oops: 0002 [#9]
Jan  4 20:54:45 D998 kernel: CPU:    0
Jan  4 20:54:45 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:54:46 D998 kernel: EFLAGS: 00013246
Jan  4 20:54:46 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:54:46 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1ca81e44   
esp: 1ca81e38
Jan  4 20:54:46 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:54:46 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1ca81f84 
022cee17 1d3b1194 1dab9780 80046ef8 
Jan  4 20:54:46 D998 kernel:        fefff870 02541aa0 00004bff 00000000 
1f77a480 1ca81e90 1f77a4a0 1ca81f6c 
Jan  4 20:54:46 D998 kernel:        1d8d3af0 1febc264 1ca80000 0000002e 
00000000 1d8d3a80 1d5c3005 00244d69 
Jan  4 20:54:46 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1ca81e44 <_end+1a532130/fda9b2ec>
>>esp; 1ca81e38 <_end+1a532124/fda9b2ec>

Jan  4 20:54:46 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:54:46 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:54:46 D998 kernel: 022d569c
Jan  4 20:54:46 D998 kernel: Oops: 0002 [#10]
Jan  4 20:54:46 D998 kernel: CPU:    0
Jan  4 20:54:46 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:54:46 D998 kernel: EFLAGS: 00013246
Jan  4 20:54:46 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:54:46 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1b61fe44   
esp: 1b61fe38
Jan  4 20:54:46 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:54:46 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1b61ff84 
022cee17 1d3b1194 1d97d380 80046ef8 
Jan  4 20:54:46 D998 kernel:        fefff870 02541aa0 00004bff 00000000 
1da6a180 1b61fe90 1da6a1a0 1b61ff6c 
Jan  4 20:54:46 D998 kernel:        1d8d3af0 1febc264 1b61e000 0000002e 
00000000 1d8d3a80 1d5c3005 00244d69 
Jan  4 20:54:46 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1b61fe44 <_end+190d0130/fda9b2ec>
>>esp; 1b61fe38 <_end+190d0124/fda9b2ec>

Jan  4 20:54:46 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:54:50 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:54:50 D998 kernel: 022d569c
Jan  4 20:54:50 D998 kernel: Oops: 0002 [#11]
Jan  4 20:54:50 D998 kernel: CPU:    0
Jan  4 20:54:50 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:54:50 D998 kernel: EFLAGS: 00013246
Jan  4 20:54:50 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:54:50 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1b587e44   
esp: 1b587e38
Jan  4 20:54:50 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:54:50 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1b587f84 
022cee17 1d3b1194 1ca8fd80 80046ef8 
Jan  4 20:54:50 D998 kernel:        fefff870 02541aa0 00004bff 00000000 
1d97d980 1b587e90 1d97d9a0 1b587f6c 
Jan  4 20:54:50 D998 kernel:        1d8d3af0 1febc264 1b586000 0000002e 
00000000 1d8d3a80 1d5c3005 00244d69 
Jan  4 20:54:50 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1b587e44 <_end+19038130/fda9b2ec>
>>esp; 1b587e38 <_end+19038124/fda9b2ec>

Jan  4 20:54:50 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)

Jan  4 20:54:53 D998 kernel:  <1>Unable to handle kernel paging request at 
virtual address fefff870
Jan  4 20:54:53 D998 kernel: 022d569c
Jan  4 20:54:53 D998 kernel: Oops: 0002 [#12]
Jan  4 20:54:53 D998 kernel: CPU:    0
Jan  4 20:54:53 D998 kernel: EIP:    0060:[sisfb_ioctl+256/618]    Not tainted 
VLI
Jan  4 20:54:53 D998 kernel: EFLAGS: 00013246
Jan  4 20:54:53 D998 kernel: eax: 80046ef8   ebx: fefff870   ecx: 0249dba0   
edx: 80046ef8
Jan  4 20:54:53 D998 kernel: esi: 022d559c   edi: fefff870   ebp: 1b583e44   
esp: 1b583e38
Jan  4 20:54:53 D998 kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:54:53 D998 kernel: Stack: 081f0f20 0000002e 02541aa0 1b583f84 
022cee17 1d3b1194 1f70e780 80046ef8 
Jan  4 20:54:53 D998 kernel:        fefff870 02541aa0 00004bff 00000000 
1f77a580 1b583e90 1f77a5a0 1b583f6c 
Jan  4 20:54:53 D998 kernel:        1d8d3af0 1febc264 1b582000 0000002e 
00000000 1d8d3a80 1d5c3005 00244d69 
Jan  4 20:54:53 D998 kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>ebx; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ecx; 0249dba0 <sisfb_ops+0/48>
>>edx; 80046ef8 <_end+7daf71e4/fda9b2ec>
>>esi; 022d559c <sisfb_ioctl+0/26a>
>>edi; fefff870 <_end+fcaafb5c/fda9b2ec>
>>ebp; 1b583e44 <_end+19034130/fda9b2ec>
>>esp; 1b583e38 <_end+19034124/fda9b2ec>

Jan  4 20:54:53 D998 kernel: Code: ff ff 89 1c 24 e8 29 f8 ff ff eb 8d 3d f9 
6e 04 80 0f 85 4e ff ff ff e8 46 f1 ff ff 84 c0 0f 95 c0 0f b6 c0 89 03 e9 3a 
ff ff ff <c7> 03 46 53 49 53 c6 43 11 01 c6 43 12 06 c6 43 13 01 a1 20 19 


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   ff                        (bad)  
Code;  ffffffd6 <__kernel_rt_sigreturn+2b96/????>
   1:   ff 89 1c 24 e8 29         decl   0x29e8241c(%ecx)
Code;  ffffffdc <__kernel_rt_sigreturn+2b9c/????>
   7:   f8                        clc    
Code;  ffffffdd <__kernel_rt_sigreturn+2b9d/????>
   8:   ff                        (bad)  
Code;  ffffffde <__kernel_rt_sigreturn+2b9e/????>
   9:   ff eb                     ljmp   *%ebx
Code;  ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
   b:   8d 3d f9 6e 04 80         lea    0x80046ef9,%edi
Code;  ffffffe6 <__kernel_rt_sigreturn+2ba6/????>
  11:   0f 85 4e ff ff ff         jne    ffffff65 <_EIP+0xffffff65>
Code;  ffffffec <__kernel_rt_sigreturn+2bac/????>
  17:   e8 46 f1 ff ff            call   fffff162 <_EIP+0xfffff162>
Code;  fffffff1 <__kernel_rt_sigreturn+2bb1/????>
  1c:   84 c0                     test   %al,%al
Code;  fffffff3 <__kernel_rt_sigreturn+2bb3/????>
  1e:   0f 95 c0                  setne  %al
Code;  fffffff6 <__kernel_rt_sigreturn+2bb6/????>
  21:   0f b6 c0                  movzbl %al,%eax
Code;  fffffff9 <__kernel_rt_sigreturn+2bb9/????>
  24:   89 03                     mov    %eax,(%ebx)
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   e9 3a ff ff ff            jmp    ffffff65 <_EIP+0xffffff65>
Code;  00000000 Before first symbol
  2b:   c7 03 46 53 49 53         movl   $0x53495346,(%ebx)
Code;  00000006 Before first symbol
  31:   c6 43 11 01               movb   $0x1,0x11(%ebx)
Code;  0000000a Before first symbol
  35:   c6 43 12 06               movb   $0x6,0x12(%ebx)
Code;  0000000e Before first symbol
  39:   c6 43 13 01               movb   $0x1,0x13(%ebx)
Code;  00000012 Before first symbol
  3d:   a1                        .byte 0xa1
Code;  00000013 Before first symbol
  3e:   20 19                     and    %bl,(%ecx)


13 warnings and 1 error issued.  Results may not be reliable.

--Boundary-00=_5+X+/jIOuguVOBz
Content-Type: application/pgp-keys;
  name="La mia chiave OpenPGP"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=public_key.asc

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.2.3 (GNU/Linux)

mQGiBD6GTM4RBAD5lUzMr6yj2WxOy3Kthq/lL/LzxDv7eg5VzgIzgpQsTKRqopir
bunOnjRn/oyLAjUARoYMzWHWYSybm41TRfJJdYWXdPJoJiaEGtDvHssYzROti8po
8+GLKV6mUfF9ghhWZofbcxj4u/mXXwY4Yknst8abNpbdrM82O83ss96//wCgyim8
sx9T4EtZ7MlGDoW37D5DyuMEALMcE+5rekRKhB1P2qJXC24PsyFAYjvzznrHe8N8
T2Kqasl6G4G52ic/Xel9W7gre//oTl+mFROFd95MNekKbS3CsLhIq1ZBVJJ6Ql/G
yqO6XZaxGTVThUW0eMy5r6X8De62LHhXSbWNbCtq2qs6G/g3Ee3eajJpAdh6LT7v
HLNPA/wLadN2KvQ386epm/yPcrU0I8poPxfQ5V/m7VsTkbaMYBkx3S8/NSLA0ci9
bOCq8NeFX0DPaf9fhYe/G/HLQ6ht6gUVfrCbX/kvCyqG8vZgVMax0yl32G0n3nt4
rzWfffj+EKKBegclGMso95y1ULdH/bqdFTHtFs0dSuT08r5jpLQiRGkgTml0dG8g
TWFyaW8gPGpvcmdlNzhAaW53aW5kLml0PohXBBMRAgAXBQI+hkzOBQsHCgMEAxUD
AgMWAgECF4AACgkQKYbqIGqlm1mveACgxny2O2hq8NuRC98rUMAWmGP9CyYAoJZr
QVysaVEEpucxjKJ3Dm5dYSd5uQGNBD6GTNQQBgDCG3Y9rW0+to5kqinRSlEdTtMQ
u3RQQSeqkFbgsXyd1wKc2kxnlFqI+qdFOcggKnv+if+TwMDpgPKFthjrDSVVL118
+xU3t4oUSf6Iey/qk0WQZEpkK5NF6Hr23KEAh2+ClTfXmQWazU98UJEZ3hzOrDa4
nlXIEX8sY3ZdIXCbTsAP/Jovl3Z3bXEYubDPFNVmHGSXnV1hmQIw1r1bpnXEFGVW
7Ok83QYZccUwcMW7bR6TIgWH5gLq9mW9JdDTqMsAAwUGAIFeEapQHY7guNrlnOTL
2tcw9kETMD4PQkuYJNrv14jZvdNoLk0CoSyOrzrGCN5wjP+q+/xcCOMXCYULMIuo
wTTW3CD//ogzd8i/oy9ZQTkd2l2pBlKo+h9CG7SFkpkB8Nb8O8bvB2/riE+owlM7
2Yz7ByB+z9T7u55n92aIJYJDM9utUeCE7iNqjHzys5pJhvrOyQJ2oa7sNBz8z+XF
eou7Bu/6y5k06b/eOsVxYMEVxx0oms29V7oRy58ZGjo+nIhGBBgRAgAGBQI+hkzU
AAoJECmG6iBqpZtZ3i0An3iq/bBF4xROIBDX8QI7TX5HqOnMAJ9nAWifTCx0rx8r
47v5/yT7iQACUQ==
=WHoh
-----END PGP PUBLIC KEY BLOCK-----

--Boundary-00=_5+X+/jIOuguVOBz--

