Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQL0MpC>; Wed, 27 Dec 2000 07:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbQL0Mom>; Wed, 27 Dec 2000 07:44:42 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:38981 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129383AbQL0Moi>; Wed, 27 Dec 2000 07:44:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jogchem de Groot <c.dgroot@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel panics on sending large ping packets using 'ping'
Date: Wed, 27 Dec 2000 14:13:29 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <00122713500100.00417@kryptology>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I recently found a bug in the kernel. Information is included according 
the suggested reporting format.

The message the kernel gave:

Code: 89 42 04 89 10 b8 01 00 00 00 c7 43 04 00 00 00 00 c7 03 00
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing

It also happened that it "Attempted to kill the init task!" 


1: Kernel panics on sending large ping packets using 'ping'

2: When i try to send large ping packets, (i didnt try to find the underlimit)
    The kernel panics with an 'Aiee' message. This is reproducable.

3: kernel, networking

4: Linux version 2.4.0-test12

5: 

6: #!/bin/sh
    ping -s 60000 127.0.0.1

7.0:

7.1: 
Linux kryptology 2.4.0-test12 #1 Sun Dec 17 16:08:31 CET 2000 i686 unknown
Kernel modules         2.3.23
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i

7.2:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 350.817
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 699.60

7.3: none

7.4: 
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
0300-031f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, Inc. UHCI USB
e800-e8ff : 3Dfx Interactive, Inc. Voodoo 3
ec00-ecff : ESS Technology ES1968 Maestro 2
  ec00-ecff : ESS Maestro 2

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-00254387 : Kernel code
  00254388-0026a1c3 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e6000000-e7ffffff : 3Dfx Interactive, Inc. Voodoo 3
e8000000-e9ffffff : 3Dfx Interactive, Inc. Voodoo 3
ea000000-eaffffff : PCI Bus #01
  ea000000-eaffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffff0000-ffffffff : reserved

7.5:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: ea000000-eaffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 
05)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at e000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at e400 [size=32]
 
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
 
00:0d.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at e800 [size=256]
        Expansion ROM at eb000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.0 Multimedia audio controller: ESS Technology ES1968 Maestro 2
        Subsystem: Unknown device 0104:1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 Display controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 
5c)
        Subsystem: ATI Technologies Inc: Unknown device 00f3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at ea000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at d000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e4000000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

7.6: none

7.7: none

Greets, 
 - Jogchem de Groot

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
