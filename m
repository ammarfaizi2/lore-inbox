Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTFDUQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTFDUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:16:56 -0400
Received: from imap.telefonica.net ([213.4.129.150]:6485 "EHLO
	telesmtp1.mail.isp") by vger.kernel.org with ESMTP id S264037AbTFDUQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:16:49 -0400
Subject: PROBLEM: 2.4.21-rcX hangs when accessing HW clock on Toshiba laptop
From: Alfonso =?ISO-8859-1?Q?Mu=F1oz-Pomer?= Fuentes 
	<etinarcadiaego@terra.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054765786.448.22.camel@roamer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 00:29:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is the first time that I post a bug relating to the Linux
kernel, so if I'm not including enough information, please tell me what
else is needed. I understand that the kernel being a critical system
element makes a lot of information be needed in order to solve bugs.

I'll try to follow the form given for bug reports:

1. Kernel 2.4.21-rcX hangs when trying to access HW clock on a Toshiba
DynaBook V4/493PMHW

2. The program hwclock and thus the /etc/init.d scripts hwclock.sh and
hwclockfirst.sh are run the computer freezes. No response from the
keyboard or mouse. The cursor keeps blinking forever after the Enter key
is pressed if 'hwclock --show' is run, for instance, or the computer
hangs when it comes to adjust the system clock from the hardware clock
while running the /etc/init.d scripts. The HW clock in 2.4.20 works
perfectly.

3. Module: Character devices ---> Enhanced Real Time Clock Support

4. Linux version 2.4.21-rc7-ac1 (root@roamer) (gcc version 2.95.4
20011002 (Debian prerelease)) -- Also happened in rc2 and rc5.

5. No Oops...

6. hwclock --show or /etc/init.d/hwclock.sh

7.1. ver_linux :
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux roamer 2.4.21-rc7-ac1 #1 Wed Jun 4 21:22:19 CEST 2003 i686 unknown
  
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded

7.2. cat /proc/cpuinfo :
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU       933MHz
stepping        : 1
cpu MHz         : 929.534
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1854.66

7.3. No loaded modules

7.4. cat /proc/ioports:
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
0cf8-0cff : PCI conf1
1000-10ff : ALi Corporation M5451 PCI AC-Link Controller Audio Device
  1000-10ff : ALi Audio Accelerator
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #03
4c00-4cff : PCI CardBus #03
ed00-edff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ed00-edff : 8139too
ee00-ee3f : ALi Corporation M7101 PMU
ef00-ef1f : ALi Corporation M7101 PMU
eff0-efff : ALi Corporation M5229 IDE
  eff0-eff7 : ide0
  eff8-efff : ide1

cat /proc/iomem :
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0efeffff : System RAM
  00100000-00291b77 : Kernel code
  00291b78-0032cf3f : Kernel data
0eff0000-0effffff : ACPI Tables
0f000000-0fffffff : reserved
10000000-10000fff : ALi Corporation M5451 PCI AC-Link Controller Audio
Device
10001000-100017ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link)
10001800-100019ff : Toshiba America Info Systems SD TypA Controller
10002000-10002fff : Texas Instruments PCI1410 PC card Cardbus Controller
10003000-10003fff : Toshiba America Info Systems ToPIC95 PCI to Cardbus
Bridge with ZV Support
10004000-10007fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #03
11000000-113fffff : PCI CardBus #03
a0000000-a0000fff : card services
f0000000-f3ffffff : ALi Corporation M1644/M1644T Northbridge+Trident
f7efef00-f7efefff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  f7efef00-f7efefff : 8139too
f7eff000-f7efffff : ALi Corporation USB 1.1 Controller
  f7eff000-f7efffff : usb-ohci
f7f00000-fdffffff : PCI Bus #01
  f7ff8000-f7ffffff : Trident Microsystems CyberBlade XPAi1
  f8000000-f9ffffff : Trident Microsystems CyberBlade XPAi1
  fbc00000-fbffffff : Trident Microsystems CyberBlade XPAi1
  fc000000-fdffffff : Trident Microsystems CyberBlade XPAi1
fff80000-ffffffff : reserved

7.5. lspci -vvv :
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1644
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [b0] AGP version 2.0
                Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f7f00000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if 10 [OHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f7eff000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
(prog-if
f0)
        Subsystem: Toshiba America Info Systems: Unknown device 0004
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at eff0 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451
PCI South Bridge Audio (rev 01)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at 10000000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
        Subsystem: Toshiba America Info Systems: Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at ed00 [size=256]
        Region 1: Memory at f7efef00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0c.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
(prog-if 10 [OHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at 10001000 (32-bit, non-prefetchable)
[disabled] [size=2K]
        Region 1: Memory at 10004000 (32-bit, non-prefetchable)
[disabled] [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Subsystem: Lucent Technologies: Unknown device ab01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at 10002000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
 
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 33)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10003000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
 
00:12.0 System peripheral: Toshiba America Info Systems: Unknown device
0805 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10001800 (32-bit, non-prefetchable)
[disabled] [size=512]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: Trident Microsystems: Unknown device
8820 (rev 82) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at fc000000 (32-bit, non-prefetchable)
[size=32M]
        Region 1: Memory at fbc00000 (32-bit, non-prefetchable)
[size=4M]
        Region 2: Memory at f8000000 (32-bit, non-prefetchable)
[size=32M]
        Region 3: Memory at f7ff8000 (32-bit, non-prefetchable)
[size=32K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [80] AGP version 2.0
                Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6. cat /proc/scsi/scsi :
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: DW-28E           Rev: 7.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02


