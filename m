Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265864AbUEUPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbUEUPUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUEUPUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:20:53 -0400
Received: from mibi02.meb.uni-bonn.de ([131.220.21.3]:58379 "EHLO
	mibi02.meb.uni-bonn.de") by vger.kernel.org with ESMTP
	id S265864AbUEUPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:20:00 -0400
Subject: PROBLEM: Linux-2.Linux-2.6.6 and -2.6.6-bk7 freeze on SMP boxes6.6
	and -2.6.6-bk7 freeze on SMP boxes
From: "Dr. Ernst Molitor" <molitor@uni-bonn.de>
To: linux-kernel@vger.kernel.org
Cc: "Dr. Ernst Molitor" <molitor@uni-bonn.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 May 2004 17:19:57 +0200
Message-Id: <1085152797.5560.28.camel@mibi02>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux gurus, 

[1.] Linux-2.6.6 and -2.6.6-bk7 freeze on SMP boxes
[2.] Linux-2.6.6. as well as 2.6.6-bk7 suddenly freeze on two SMP boxes
I'm using (dual Pentium-III Coppermine machines with 1 GByte of RAM).
All of the sudden, the box fails to respond, printing ceases abruptly,
the screen shows a "no signal" display, the box does not answer pings
anymore, nothing short of pressing the reset button will cause the box
to show any reaction whatsoever.
[3.] Since I've been using 2.6.x (including .6) on several single
processor boxes without any problem, I'd tend to assume there is a
problem with SMP. Yesterday, I assumed dm-crypt might be involved, but
today, several freezes occurred without use of the loop device or
dm-crypt. 
[4.]  cat /proc/version
Linux version 2.6.6-bk7 (root@pc61) (gcc-Version 3.3.3 20040125
(prerelease) (Debian)) #2 SMP Fri May 21 12:01:32 CEST 2004
[5.] Sorry, no Oops available.
[6.] Sorry, I have no idea what might trigger the freeze. It tended to
occurr under (light) load, e.g., compiling something and printing a
couple of pages via CUPS
[7.1]./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux pc61 2.6.6-bk7 #2 SMP Fri May 21 12:01:32 CEST 2004 i686 GNU/Linux
  
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
Modules Loaded         lp ipv6 rtc

[7.2] 
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.544
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
bogomips        : 1978.36
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1004.544
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
bogomips        : 2007.04
 
[7.3]  cat /proc/modules
lp 10536 0 - Live 0xfbd38000
ipv6 238016 14 - Live 0xfbd7d000
rtc 11496 0 - Live 0xfbd34000
 
[7.4]  cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
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
0cf8-0cff : PCI conf1
b400-b4ff : 0000:00:0b.0
  b400-b4ff : olympic
b800-b8ff : 0000:00:0a.0
d000-d01f : 0000:00:04.3
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e800-e80f : 0000:00:04.4

 cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ca7ff : Video ROM
000cc000-000d13ff : Adapter ROM
000d4000-000d47ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-003bc84d : Kernel code
  003bc84e-004ee55f : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
da800000-da8007ff : 0000:00:0b.0
  da800000-da8007ff : olympic
db000000-db0000ff : 0000:00:0b.0
  db000000-db0000ff : olympic
db800000-db800fff : 0000:00:0a.0
  db800000-db800fff : aic7xxx
dc000000-dddfffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
    dc000000-dcffffff : rivafb
ddf00000-dfffffff : PCI Bus #01
  de000000-dfffffff : 0000:01:00.0
    de000000-dfffffff : rivafb
e0000000-efffffff : 0000:00:00.0
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
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
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
        Memory behind bridge: dc000000-dddfffff
        Prefetchable memory behind bridge: ddf00000-dfffffff
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
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 5
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
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 5
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
 
00:0a.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160 Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: I/O ports at b800 [disabled] [size=256]
        Region 1: Memory at db800000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 Token ring network controller: IBM 16/4 Token ring UTP/STP
controller (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1500ns min, 30000ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at db000000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at da800000 (32-bit, non-prefetchable)
[size=2K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
 
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at de000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at ddff0000 [disabled] [size=64K]
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
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02


I'd happily perform any kind of check I might be able to; currently, one
of the boxes is a backup (the other one is back to 2.4.x ...).

Best wishes and regards, 

Ernst


