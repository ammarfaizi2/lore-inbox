Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWAEGDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWAEGDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWAEGDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:03:19 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:40310 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752008AbWAEGDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:03:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=L20KHsNvEh0RaPm4qlMGDzUkxexLXplYl2DVwqSz8JWYpmVzYfnS7gjWK9VQwCsvvXcHIw9f29RpC5aHbDNxbPhgvG2w67Fd5b1pHbhnPhlzFarpHHcnvYCrFld49pMyFeJ5xUH+8ZsaBIZZXWb8XdTKxy4u/QNtViG/yvAHJZM=
From: Dane Mutters <dmutters@gmail.com>
Organization: DA Enterprises
To: linux-kernel@vger.kernel.org
Subject: (1) ACPI messes up Parallel support in kernels >2.6.9
Date: Wed, 4 Jan 2006 22:03:12 -0800
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601042203.12377.dmutters@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2)	Hello.  

	I've been attempting to figure out this problem for a long time, and have 
come to the conclusion that it must be a kernel bug (that or perhaps I'm a 
bit dense).  Whenever I have the option, "Device Drivers > Plug and Play > 
ACPI Support" enabled, I become unable to print using my parallel port.

	I'm using an ASUS A8N-SLI motherboard with an AMD64 3200 chip and 1GB of RAM.  
I have two printers, and this happens with both.  Here are some forums in 
which I have tried to solve this problem:

http://forums.gentoo.org/viewtopic-t-416986-highlight-.html
http://www.linuxquestions.org/questions/showthread.php?t=380023

(3)  parallel, acpi, printing, kernel

(4) Linux version 2.6.14-gentoo-r5 (root@Orchestrator) (gcc version 3.4.4 
(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Wed Jan 4 14:43:44 PST 2006

(7.1)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux Orchestrator 2.6.14-gentoo-r5 #1 Wed Jan 4 14:43:44 PST 2006 x86_64 AMD 
Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.0
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.25
quota-tools            3.12.
PPP                    2.4.2
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   070
Modules Loaded         parport_pc lp parport nvidia forcedeth snd_intel8x0 
snd_ac97_codec snd_ac97_bus i2c_nforce2 nls_utf8 nls_iso8859_1 nls_cp437 
ata_piix sata_vsc sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil 
sata_promise libata sbp2 ohci1394 ieee1394 ohci_hcd uhci_hcd usb_storage 
usbhid ehci_hcd

(7.2) processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 0
cpu MHz         : 2100.502
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 
3dnowext 3dnow pni lahf_lm
bogomips        : 4205.42
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

(7.3) parport_pc 37864 1 - Live 0xffffffff88588000
lp 13512 0 - Live 0xffffffff88581000
parport 40588 2 parport_pc,lp, Live 0xffffffff88576000
nvidia 4856528 12 - Live 0xffffffff880d3000
forcedeth 23488 0 - Live 0xffffffff880cc000
snd_intel8x0 36896 1 - Live 0xffffffff880c1000
snd_ac97_codec 107096 1 snd_intel8x0, Live 0xffffffff880a5000
snd_ac97_bus 2880 1 snd_ac97_codec, Live 0xffffffff880a3000
i2c_nforce2 8064 0 - Live 0xffffffff880a0000
nls_utf8 2496 1 - Live 0xffffffff8809e000
nls_iso8859_1 5504 1 - Live 0xffffffff8809b000
nls_cp437 7232 1 - Live 0xffffffff88098000
ata_piix 11204 0 - Live 0xffffffff88094000
sata_vsc 9284 0 - Live 0xffffffff88090000
sata_sis 9088 0 - Live 0xffffffff8808c000
sata_sx4 14788 0 - Live 0xffffffff88087000
sata_nv 10820 0 - Live 0xffffffff88083000
sata_via 9796 0 - Live 0xffffffff8807f000
sata_svw 8964 0 - Live 0xffffffff8807b000
sata_sil 11012 0 - Live 0xffffffff88077000
sata_promise 12996 0 - Live 0xffffffff88072000
libata 51536 9 
ata_piix,sata_vsc,sata_sis,sata_sx4,sata_nv,sata_via,sata_svw,sata_sil,sata_promise, 
Live 0xffffffff88064000
sbp2 25988 0 - Live 0xffffffff8805c000
ohci1394 34252 0 - Live 0xffffffff88052000
ieee1394 105976 2 sbp2,ohci1394, Live 0xffffffff88037000
ohci_hcd 21252 0 - Live 0xffffffff88030000
uhci_hcd 32736 0 - Live 0xffffffff88027000
usb_storage 69504 0 - Live 0xffffffff88015000
usbhid 39264 0 - Live 0xffffffff8800a000
ehci_hcd 34248 0 - Live 0xffffffff88000000

(7.4) 0000-001f : dma1
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
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0960-0967 : 0000:00:08.0
  0960-0967 : sata_nv
0970-0977 : 0000:00:07.0
  0970-0977 : sata_nv
09e0-09e7 : 0000:00:08.0
  09e0-09e7 : sata_nv
09f0-09f7 : 0000:00:07.0
  09f0-09f7 : sata_nv
0b60-0b63 : 0000:00:08.0
  0b60-0b63 : sata_nv
0b70-0b73 : 0000:00:07.0
  0b70-0b73 : sata_nv
0be0-0be3 : 0000:00:08.0
  0be0-0be3 : sata_nv
0bf0-0bf3 : 0000:00:07.0
  0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
4000-407f : motherboard
  4000-4003 : PM1a_EVT_BLK
  4004-4005 : PM1a_CNT_BLK
  4008-400b : PM_TMR
  401c-401c : PM2_CNT_BLK
  4020-4027 : GPE0_BLK
4080-40ff : motherboard
4400-447f : motherboard
4480-44ff : motherboard
  44a0-44af : GPE1_BLK
4800-487f : motherboard
4880-48ff : motherboard
4c00-4c3f : 0000:00:01.1
  4c00-4c07 : nForce2 SMBus
4c40-4c7f : 0000:00:01.1
  4c40-4c47 : nForce2 SMBus
9000-afff : PCI Bus #05
  9000-9007 : 0000:05:06.0
    9000-9007 : ide2
  9400-9403 : 0000:05:06.0
    9402-9402 : ide2
  9800-9807 : 0000:05:06.0
  9c00-9c03 : 0000:05:06.0
  a000-a00f : 0000:05:06.0
    a000-a007 : ide2
    a008-a00f : ide3
  a400-a407 : 0000:05:07.0
    a400-a407 : serial
b000-b007 : 0000:00:0a.0
  b000-b007 : forcedeth
c400-c40f : 0000:00:08.0
  c400-c40f : sata_nv
d800-d80f : 0000:00:07.0
  d800-d80f : sata_nv
dc00-dcff : 0000:00:04.0
  dc00-dcff : NVidia CK804
e000-e0ff : 0000:00:04.0
  e000-e0ff : NVidia CK804
e400-e41f : 0000:00:01.1
f000-f00f : 0000:00:06.0
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d67ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0046e96b : Kernel code
  0046e96c-0059922f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-500fffff : PCI Bus #05
  50000000-50003fff : 0000:05:06.0
c0000000-c7ffffff : PCI Bus #01
  c0000000-c7ffffff : 0000:01:00.0
    c0000000-c7ffffff : vesafb
c8000000-cfffffff : PCI Bus #01
  c8000000-cbffffff : 0000:01:00.0
    c8000000-cbffffff : nvidia
  cc000000-ccffffff : 0000:01:00.0
  cd000000-cd01ffff : 0000:01:00.0
d0000000-d1ffffff : PCI Bus #05
  d1000000-d1003fff : 0000:05:06.0
  d1004000-d1007fff : 0000:05:0b.0
  d1008000-d10087ff : 0000:05:0b.0
    d1008000-d10087ff : ohci1394
d2000000-d2000fff : 0000:00:0a.0
  d2000000-d2000fff : forcedeth
d2001000-d2001fff : 0000:00:08.0
  d2001000-d2001fff : sata_nv
d2002000-d2002fff : 0000:00:07.0
  d2002000-d2002fff : sata_nv
d2003000-d2003fff : 0000:00:04.0
  d2003000-d2003fff : NVidia CK804
d2004000-d2004fff : 0000:00:02.0
  d2004000-d2004fff : ohci_hcd
e0000000-efffffff : reserved
feb00000-feb000ff : 0000:00:02.1
  feb00000-feb000ff : ehci_hcd
fec00000-ffffffff : reserved

(7.5) 0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory 
Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 815a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] #08 [01e0]
        Capabilities: [e0] #08 [a801]

0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 255
        Region 0: I/O ports at e400
        Region 4: I/O ports at 4c00 [size=64]
        Region 5: I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) 
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d2004000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) 
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 18
        Region 0: Memory at feb00000 (32-bit, non-prefetchable)
        Capabilities: [44] #0a [2098]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio 
Controller (rev a2)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at dc00
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d2003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a 
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 09f0
        Region 1: I/O ports at 0bf0 [size=4]
        Region 2: I/O ports at 0970 [size=8]
        Region 3: I/O ports at 0b70 [size=4]
        Region 4: I/O ports at d800 [size=16]
        Region 5: Memory at d2002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 09e0
        Region 1: I/O ports at 0be0 [size=4]
        Region 2: I/O ports at 0960 [size=8]
        Region 3: I/O ports at 0b60 [size=4]
        Region 4: I/O ports at c400 [size=16]
        Region 5: Memory at d2001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: d0000000-d1ffffff
        Prefetchable memory behind bridge: 50000000-500fffff
        Expansion ROM at 00009000 [disabled] [size=8K]
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d2000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at b000 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: c8000000-cfffffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000c7f00000
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 
GT] (rev a2) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 3125
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at c8000000 (32-bit, non-prefetchable) 
[size=cd000000]
        Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
        Region 3: Memory at cc000000 (64-bit, non-prefetchable) [size=16M]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] #10 [0001]

0000:05:06.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02) 
(prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9000 [size=1280M]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at d1000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 00004000 [disabled]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:05:07.0 Serial controller: 3Com Corp, Modem Division 56K FaxModem Model 
5610 (rev 01) (prog-if 02 [16550])
        Subsystem: 3Com Corp, Modem Division: Unknown device 00d3
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a400
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d1008000 (32-bit, non-prefetchable)
        Region 1: Memory at d1004000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

(7.6) (no scsi)

	I hope this helps!

	--Dane

	P.S.  Please let me know if this turns out to be something fixable short of a 
kernel modification!
