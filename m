Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVDRJeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVDRJeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVDRJe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:34:29 -0400
Received: from mp1-smtp-3.eutelia.it ([62.94.10.163]:38316 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S262004AbVDRJdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:33:52 -0400
Message-ID: <42637EFE.9020808@eutelia.it>
Date: Mon, 18 Apr 2005 11:33:50 +0200
From: Sergio Chiesa <sergio.chiesa@eutelia.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG 2.4.30 "Kernel bug at tg3.c:2456"
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all there,

I'll try to report using the FORM specified by the "REPORTING-BUGS" file.
I didn't find the tg3.c maintainer, then I post here.

TIA



1. My Tyan 2881 ethernet freeze (down up solve it) or the whole kernel
freeze with Kernel bug at tg3.c:2456

2. I've two Tyan 2881 dual opteron 1.6GHz with 2GB ram, when I do a very
massive network transfer (to trigger the bug I use faucet/hose cat
/dev/zero it ran at about 96 mbps!!!) at random :( times
either the sender or the receiver ethernet freeze, usually doing a
"ifconfig eth0 down" followed by /etc/rc.d/rc.inet1 solve it, but other
times I get the whole kernel hung! Only hard reset works. Usually there
are no messages on screen, but the last time I get "Kernel bug at
tg3.c:2456"!! on the sender. The skb pointer in the tx_ring_info was
null.... May it be queue overrun?

3. tg3 networking broadcom

4. Linux version 2.4.29 (root@newaaa02) (gcc version 3.3.4) #1 SMP Wed Mar
30 17:56:15 CEST 2005

5.

6. see point 2

7.1.
Gnu C                  3.3.4
Gnu make               3.80
util-linux             2.12a
mount                  2.12a
modutils               2.4.25
e2fsprogs              1.35
xfsprogs               2.6.13
Linux C Library        3.2.so*
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6*
Procps                 3.2.1
Net-tools              1.60
Kbd                    command
Sh-utils               5.2.1
Modules Loaded         tg3

7.2.
  processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 242
stepping        : 10
cpu MHz         : 1594.324
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow
bogomips        : 3178.49

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 242
stepping        : 10
cpu MHz         : 1594.324
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow
bogomips        : 3185.04

7.3.
tg3                    59500   1

7.4.
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #03
   b800-b8ff : ATI Technologies Inc Rage XL
cc00-cc1f : Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
ffa0-ffaf : Advanced Micro Devices [AMD] AMD-8111 IDE

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca1ff : Extension ROM
000f0000-000fffff : System ROM
00100000-7fffffff : System RAM
   00100000-0025b786 : Kernel code
   0025b787-002b25df : Kernel data
fc800000-fc8fffff : PCI Bus #01
fc900000-fc9fffff : PCI Bus #02
   fc9b0000-fc9bffff : Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet
     fc9b0000-fc9bffff : tg3
   fc9c0000-fc9cffff : Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet
     fc9c0000-fc9cffff : tg3
   fc9e0000-fc9effff : Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet (#2)
     fc9e0000-fc9effff : tg3
   fc9f0000-fc9fffff : Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet (#2)
     fc9f0000-fc9fffff : tg3
fca00000-feafffff : PCI Bus #03
   fd000000-fdffffff : ATI Technologies Inc Rage XL
   feafc000-feafcfff : Advanced Micro Devices [AMD] AMD-8111 USB
   feafd000-feafdfff : Advanced Micro Devices [AMD] AMD-8111 USB (#2)
   feaff000-feafffff : ATI Technologies Inc Rage XL
febfe000-febfefff : Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (#2)
febff000-febfffff : Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
ff400000-ff4fffff : PCI Bus #01
   ff4f0000-ff4fffff : LSI Logic / Symbios Logic PowerEdge Expandable RAID
Controller 4
     ff4f0000-ff4f007f : MegaRAID: LSI Logic Corporation.
ff500000-ff5fffff : PCI Bus #02
ff780000-ffffffff : reserved

7.5.
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: fca00000-feafffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [c0] #08 [0086]
         Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
(prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at ffa0 [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin D routed to IRQ 19
         Region 0: I/O ports at cc00 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fc900000-fc9fffff
         Prefetchable memory behind bridge:
00000000ff500000-00000000ff500000
         BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [a0]      Capabilities: [b8] #08 [8000]
         Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
(prog-if 10 [IO-APIC])
         Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at febff000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fc800000-fc8fffff
         Prefetchable memory behind bridge:
00000000ff400000-00000000ff400000
         BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [a0]      Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
(prog-if 10 [IO-APIC])
         Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [80] #08 [2101]
         Capabilities: [a0] #08 [2101]
         Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [80] #08 [2101]
         Capabilities: [a0] #08 [2101]
         Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

01:03.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
         Subsystem: LSI Logic / Symbios Logic MegaRAID 520 SCSI 320-1
Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin A routed to IRQ 28
         Region 0: Memory at ff4f0000 (32-bit, prefetchable) [size=64K]
         Expansion ROM at fc8f0000 [disabled] [size=64K]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
         Subsystem: Broadcom Corporation: Unknown device 1644
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 24
         Region 0: Memory at fc9c0000 (64-bit, non-prefetchable) [size=64K]
         Region 2: Memory at fc9b0000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at fc9a0000 [disabled] [size=64K]
         Capabilities: [40]      Capabilities: [48] Power Management
version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                 Address: 8601d08000200200  Data: 0090

02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
         Subsystem: Broadcom Corporation: Unknown device 1644
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin B routed to IRQ 25
         Region 0: Memory at fc9f0000 (64-bit, non-prefetchable) [size=64K]
         Region 2: Memory at fc9e0000 (64-bit, non-prefetchable) [size=64K]
         Expansion ROM at fc9d0000 [disabled] [size=64K]
         Capabilities: [40]      Capabilities: [48] Power Management
version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                 Address: 2419691315487100  Data: 0111

03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
(prog-if 10 [OHCI])
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max)
         Interrupt: pin D routed to IRQ 19
         Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
(prog-if 10 [OHCI])
         Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max)
         Interrupt: pin D routed to IRQ 19
         Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]

03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Rage XL
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: I/O ports at b800 [size=256]
         Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at feac0000 [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


7.6.
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: MegaRAID Model: LD0 RAID1 35002R Rev: 1L37
   Type:   Direct-Access                    ANSI SCSI revision: 02


7.7.
Well, it seems that with the original onboard raid controller the bug
didn't trigger... the controller was swapped with the lsi logic by my
supplier because it fails badly with raid-5 arrays (hw/fw related issue)
I also tried the original broadcom driver version 7.3.5 with similar
results...

I think it is something IRQ related because if the eth hungs but the kernel 
is still running I see more than 140000 irq per second with "vmstat".
Hope it helps

Best regards,
Sergioc

