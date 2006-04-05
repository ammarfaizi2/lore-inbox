Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDEUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDEUIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDEUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:08:21 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:27334 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751161AbWDEUIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:08:20 -0400
Message-ID: <44342389.5040606@arcor.de>
Date: Wed, 05 Apr 2006 22:07:37 +0200
From: l7or <l7or@arcor.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug-report (kernel-oops)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. After having watched a movie with kaffeine-0.8.1 using xine-lib-1.1.1 I got a kernel-oops when closing kaffeine
2. After the kernel-oops I was able to continue to use the system without problems. I went online with a normal 56K-Modem connected to the pl2303-USB2Serial-Converter. After 		   having been online for a while I got the following message from my internet-connection-program (slylcr): "appear to have received our own echo-reply!" (I don't know whether        
   this has to do with the kernel-oops, but I never got that message before...
   Perhaps the problem is related to my vp7045 (TwinhanDTV-Alpha-DVB-T-Card), I had it connected to the computer but I removed it when it wasn't needed any more. However 
   kaffeine might have been started with the card connected and closed with the card having been removed while kaffeine was running...

4./7.1
Linux Notebook 2.6.16.1 #1 Thu Mar 30 19:54:24 CEST 2006 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.18
reiser4progs           1.0.5
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      6.0.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   068
Modules Loaded         ppp_async crc_ccitt ppp_generic slhc pl2303 ntfs dvb_usb_vp7045 dvb_usb dvb_core dvb_pll isofs udf loop

5.
Apr  5 21:17:09 Notebook kernel: Unable to handle kernel paging request at ffffc20000065060 RIP: 
Apr  5 21:17:09 Notebook kernel: <ffffffff8803ed10>{:dvb_core:dvb_demux_release+15}
Apr  5 21:17:09 Notebook kernel: PGD 1fae067 PUD 1fad067 PMD 1fac067 PTE 0
Apr  5 21:17:09 Notebook kernel: Oops: 0000 [1] 
Apr  5 21:17:09 Notebook kernel: CPU 0 
Apr  5 21:17:09 Notebook kernel: Modules linked in: ntfs dvb_usb_vp7045 dvb_usb dvb_core dvb_pll isofs udf ppp_async crc_ccitt ppp_generic slhc pl2303 loop
Apr  5 21:17:09 Notebook kernel: Pid: 6908, comm: kaffeine Not tainted 2.6.16.1 #1
Apr  5 21:17:09 Notebook kernel: RIP: 0010:[<ffffffff8803ed10>] <ffffffff8803ed10>{:dvb_core:dvb_demux_release+15}
Apr  5 21:17:09 Notebook kernel: RSP: 0018:ffff810005ae9ed8  EFLAGS: 00010282
Apr  5 21:17:09 Notebook kernel: RAX: ffffffff8803ed01 RBX: ffffc20000065000 RCX: 0000000000000000
Apr  5 21:17:09 Notebook kernel: RDX: 0000000000000000 RSI: ffff8100223f04c0 RDI: ffff81000364db00
Apr  5 21:17:09 Notebook kernel: RBP: ffff8100223f04c0 R08: 000000000000000a R09: 0000000000001afc
Apr  5 21:17:09 Notebook kernel: R10: 00007fffffded0b8 R11: 0000000000000206 R12: ffff81000364db00
Apr  5 21:17:09 Notebook kernel: R13: ffff81000364db00 R14: ffff810001fbf280 R15: ffff81003ad160c0
Apr  5 21:17:09 Notebook kernel: FS:  00002b8cc07ec620(0000) GS:ffffffff80420000(0000) knlGS:00000000562e27e0
Apr  5 21:17:09 Notebook kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Apr  5 21:17:09 Notebook kernel: CR2: ffffc20000065060 CR3: 0000000006040000 CR4: 00000000000006e0
Apr  5 21:17:09 Notebook kernel: Process kaffeine (pid: 6908, threadinfo ffff810005ae8000, task ffff81000c6ba890)
Apr  5 21:17:09 Notebook kernel: Stack: 0000000000000206 0000000000000008 ffff8100223f04c0 ffff81000364db00 
Apr  5 21:17:09 Notebook kernel:        ffff81000364db00 ffffffff80157112 ffff81001e44dc40 ffff8100223f04c0 
Apr  5 21:17:09 Notebook kernel:        0000000000000000 ffff81001e44dc40 
Apr  5 21:17:09 Notebook kernel: Call Trace: <ffffffff80157112>{__fput+168} <ffffffff801550b9>{filp_close+89}
Apr  5 21:17:09 Notebook kernel:        <ffffffff801558a1>{sys_close+112} <ffffffff8010a4ea>{system_call+126}
Apr  5 21:17:09 Notebook kernel: 
Apr  5 21:17:09 Notebook kernel: Code: 4c 8b 6b 60 e8 7c d8 2b f8 49 8d 6d 68 48 89 ef 41 ff 4d 68 
Apr  5 21:17:09 Notebook kernel: RIP <ffffffff8803ed10>{:dvb_core:dvb_demux_release+15} RSP <ffff810005ae9ed8>
Apr  5 21:17:09 Notebook kernel: CR2: ffffc20000065060

6. -
7. SuSE Linux 10.0 with many updated packages
  I did compile kaffeine and xine myself, I didn't take the RPMs

7.2
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3400+
stepping        : 10
cpu MHz         : 800.000
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 1597.84
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

7.3 see 4.

7.4

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d9fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffcffff : System RAM
 00100000-002ffbaa : Kernel code
 002ffbab-003e73bf : Kernel data
3ffd0000-3ffdefff : ACPI Tables
3ffdf000-3fffffff : ACPI Non-volatile Storage
50000000-51ffffff : PCI CardBus #02
52000000-53ffffff : PCI CardBus #02
54000000-55ffffff : PCI CardBus #06
56000000-57ffffff : PCI CardBus #06
58000000-58000fff : 0000:00:09.0
58001000-58001fff : 0000:00:09.1
e0000000-e7ffffff : 0000:00:00.0
 e0000000-e7ffffff : aperture
ee900000-fe8fffff : PCI Bus #01
 f0000000-f7ffffff : 0000:01:00.0
   f0000000-f7ffffff : radeonfb framebuffer
fea00000-feafffff : PCI Bus #01
 feac0000-feadffff : 0000:01:00.0
 feaf0000-feafffff : 0000:01:00.0
   feaf0000-feafffff : radeonfb mmio
febc0000-febdffff : 0000:00:04.0
febf4000-febf7fff : 0000:00:06.0
febf8000-febf9fff : 0000:00:0b.0
febfa000-febfafff : 0000:00:09.2
febfb800-febfbfff : 0000:00:06.0
febfc000-febfcfff : 0000:00:04.0
 febfc000-febfcfff : sis900
febfd000-febfdfff : 0000:00:03.0
 febfd000-febfdfff : ohci_hcd
febfe000-febfefff : 0000:00:03.1
 febfe000-febfefff : ohci_hcd
febff000-febfffff : 0000:00:03.3
 febff000-febfffff : ehci_hcd
fff80000-ffffffff : reserved


/proc/ioports:

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0816-0816 : PM2_CNT_BLK
0820-0823 : GPE0_BLK
0830-0833 : GPE1_BLK
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #02
1400-14ff : PCI CardBus #02
1800-18ff : PCI CardBus #06
1c00-1cff : PCI CardBus #06
c000-cfff : PCI Bus #01
 c800-c8ff : 0000:01:00.0
d800-d8ff : 0000:00:04.0
 d800-d8ff : sis900
e000-e07f : 0000:00:02.6
e400-e4ff : 0000:00:02.6
e800-e8ff : 0000:00:02.7
 e800-e8ff : SiS SI7012
ec00-ec7f : 0000:00:02.7
 ec00-ec7f : SiS SI7012
ffa0-ffaf : 0000:00:02.5
 ffa0-ffa7 : ide0
 ffa8-ffaf : ide1


7.5

lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 755 Host (rev 01)
       Subsystem: Silicon Integrated Systems [SiS] 755 Host
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
       Latency: 32
       Region 0: Memory at 00000000e0000000 (32-bit, non-prefetchable) [size=128M]
       Capabilities: [a0] AGP version 3.0
               Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
               Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
       Capabilities: [d0] HyperTransport: Slave or Primary Interface
               !!! Possibly incomplete decoding
               Command: BaseUnitID=0 UnitCnt=9 MastHost- DefDir-
               Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC+ TXO- <CRCErr=0
               Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
               Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
               Link Config 1: MLWI=N/C MLWO=N/C LWI=N/C LWO=N/C
               Revision ID: 1.02
       Capabilities: [f0] HyperTransport: Interrupt Discovery and Configuration

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
       I/O behind bridge: 0000c000-0000cfff
       Memory behind bridge: fea00000-feafffff
       Prefetchable memory behind bridge: ee900000-fe8fffff
       Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
       BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media IO] (rev 25)
       Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 128
       Region 4: I/O ports at ffa0 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0) (prog-if 00 [Generic])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (13000ns min, 2750ns max)
       Interrupt: pin C routed to IRQ 10
       Region 0: I/O ports at e400 [size=256]
       Region 1: I/O ports at e000 [size=128]
       Capabilities: [48] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (13000ns min, 2750ns max)
       Interrupt: pin C routed to IRQ 22
       Region 0: I/O ports at e800 [size=256]
       Region 1: I/O ports at ec00 [size=128]
       Capabilities: [48] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (20000ns max)
       Interrupt: pin A routed to IRQ 20
       Region 0: Memory at 00000000febfd000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (20000ns max)
       Interrupt: pin B routed to IRQ 21
       Region 0: Memory at 00000000febfe000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (20000ns max)
       Interrupt: pin D routed to IRQ 19
       Region 0: Memory at 00000000febff000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [50] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 91)
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (13000ns min, 2750ns max)
       Interrupt: pin A routed to IRQ 18
       Region 0: I/O ports at d800 [size=256]
       Region 1: Memory at 00000000febfc000 (32-bit, non-prefetchable) [size=4K]
       Expansion ROM at 00000000febc0000 [disabled] [size=128K]
       Capabilities: [40] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (500ns min, 1000ns max), Cache Line Size 10
       Interrupt: pin A routed to IRQ 5
       Region 0: Memory at 00000000febfb800 (32-bit, non-prefetchable) [size=2K]
       Region 1: Memory at 00000000febf4000 (32-bit, non-prefetchable) [size=16K]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus Controller (rev 20)
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Interrupt: pin A routed to IRQ 16
       Region 0: Memory at 0000000058000000 (32-bit, non-prefetchable) [size=4K]
       Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
       Memory window 0: 50000000-51fff000 (prefetchable)
       Memory window 1: 52000000-53fff000
       I/O window 0: 00001000-000010ff
       I/O window 1: 00001400-000014ff
       BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite-
       16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus Controller (rev 20)
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64
       Interrupt: pin A routed to IRQ 16
       Region 0: Memory at 0000000058001000 (32-bit, non-prefetchable) [size=4K]
       Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
       Memory window 0: 54000000-55fff000 (prefetchable)
       Memory window 1: 56000000-57fff000
       I/O window 0: 00001800-000018ff
       I/O window 1: 00001c00-00001cff
       BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite-
       16-bit legacy interface ports at 0001

00:09.2 System peripheral: O2 Micro, Inc. OZ711Mx 4-in-1 MemoryCardBus Accelerator
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Interrupt: pin A routed to IRQ 11
       Region 0: Memory at 00000000febfa000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [a0] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus Reference Card (rev 01)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 6833
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64, Cache Line Size 10
       Interrupt: pin A routed to IRQ 5
       Region 0: Memory at 00000000febf8000 (32-bit, non-prefetchable) [size=8K]
       Capabilities: [40] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Capabilities: [80] HyperTransport: Host or Secondary Interface
               !!! Possibly incomplete decoding
               Command: WarmRst+ DblEnd-
               Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
               Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
               Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
       Subsystem: Fujitsu Siemens Computer GmbH: Unknown device 105f
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Latency: 64 (2000ns min), Cache Line Size 10
       Interrupt: pin A routed to IRQ 17
       Region 0: Memory at 00000000f0000000 (32-bit, prefetchable) [size=128M]
       Region 1: I/O ports at c800 [size=256]
       Region 2: Memory at 00000000feaf0000 (32-bit, non-prefetchable) [size=64K]
       Expansion ROM at 00000000feac0000 [disabled] [size=128K]
       Capabilities: [58] AGP version 3.0
               Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
               Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
       Capabilities: [50] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 I don't have scsi

7.7 I'm using the reiser4-patch from namesys and my root-filesystem is using the reiser4-filesystem


I'm sorry, this is my first bug-report and I'm sure I included too much worthless information. If you've still got questions/found out the reason please email me.

Regards,

Lorenz





