Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUEVAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUEVAcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbUEUX7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:59:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265151AbUEUXfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:35:04 -0400
Subject: PROBLEM: Linux-2.6.6 with dm-crypt hangs on SMP boxes
From: "Dr. Ernst Molitor" <molitor@cfce.de>
To: linux-kernel@vger.kernel.org
Cc: molitor@uni-bonn.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1085043539.18199.20.camel@felicia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 
Date: Thu, 20 May 2004 10:59:00 +0200
X-scanner: scanned by Inflex 2.0.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux gurus, 

please forgive me for being vague - I'd rather be more specific if I
only could, and I'd readily try and follow any procedure you might
suggest to arrive at further information about the problem...

[1.] Linux-2.6.6 caused full halts on two SMP boxes.
[2.] I've been using Linux-2.4.20 with   cryptoloop/cryptoapi for 156
days uptime; on two boxes, I have installed 2.6.6-rc3-bk5 (one box) and
2.6.6-bk5 (the other one), with dm-crypt on the partitions created with
cryptoloop/cryptoapi. Both boxes ran like a charm, but both of them
repeatedly came to a halt (no screen, no network connectivity, no
reaction to keyboard or mouse activity: Need for hard reset) repeatedly.
[3.] dm-crypt, loop device (maybe other things).
In kern.log on the box with 2.6.6-bk5, I found the line
  Incorrect TSC synchronization on an SMP system (see dmesg).
with the 2.6.6 kernels, with 2.4.20, the message was
 checking TSC synchronization across CPUs: passed.
[4.] 2.6.6, 2.6.6-bk5
[5.] sorry, no Oops available
[6.] -
[7.1] Linux pc61 2.6.6-rc3-bk8 #1 SMP Thu May 6 17:35:01 CEST 2004 i686
GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.11x
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
jfsutils               1.1.4
xfsprogs               2.6.3
pcmcia-cs              3.2.5
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         soundcore loop lp ipv6 rtc
 (_this_ kernel has been up and running for a week now... no idea
whether or not it will continue to do so. At any rate, the TSC line in
kern.log for _this_ kernel was  "checking TSC synchronization across 2
CPUs: passed.").

[7.2] processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.523
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2005.40
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.523
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2005.40

[7.3] no modules used
[7.4] cat /proc/ioports
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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
b400-b4ff : Adaptec AIC-7892A U160/m
b800-b8ff : IBM 16/4 Token ring UTP/STP controller
  b800-b8ff : olympic
d000-d01f : VIA Technologies, Inc. USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000d0000-000d53ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-002f687f : Kernel code
  002f6880-0039df1f : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
f6800000-f6800fff : Adaptec AIC-7892A U160/m
  f6800000-f6800fff : aic7xxx
f7000000-f70007ff : IBM 16/4 Token ring UTP/STP controller
  f7000000-f70007ff : olympic
f7800000-f78000ff : IBM 16/4 Token ring UTP/STP controller
  f7800000-f78000ff : olympic
f8000000-f9dfffff : PCI Bus #01
  f8000000-f8ffffff : nVidia Corporation RIVA TNT2 Model 64
f9f00000-fbffffff : PCI Bus #01
  fa000000-fbffffff : nVidia Corporation RIVA TNT2 Model 64
fc000000-fdffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5] lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: f8000000-f9dfffff
        Prefetchable memory behind bridge: f9f00000-fbffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Token ring network controller: IBM 16/4 Token ring UTP/STP
controller (rev 66)
        Subsystem: IBM: Unknown device 0172
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1500ns min, 30000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at f7800000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at f7000000 (32-bit, non-prefetchable)
[size=2K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 
00:0d.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: I/O ports at b400 [disabled] [size=256]
        Region 1: Memory at f6800000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at fa000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at f9ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
 

[7.6] cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: MAN3367MP        Rev: 0107
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: CD-W516EB        Rev: 1.0B
  Type:   CD-ROM                           ANSI SCSI revision: 02

Thank you very much for all your work on Linux.

Best wishes and regards, 

Ernst





