Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTIUU3D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTIUU3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:29:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:53133 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262563AbTIUU2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:28:43 -0400
X-Authenticated: #8108751
Message-ID: <3F6E09F7.7000506@gmx.de>
Date: Sun, 21 Sep 2003 22:28:39 +0200
From: JSTHEMASTER <cheaterjs@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030702
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.22 ACPI hangs up NFORCE2 system when using kudzu
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
When using Kernel 2.4.22 (<= 2.4.21 works perfectly) ACPI on a system 
with NFORCE2 chipset the system hangs when starting
kudzu without any output or log-entry!

[2.]
If you enable kernel 2.4.22 ACPI on a system running NFORCE2 chipset (I 
got a MSI K7N2 Delta-L mainboard) the system hangs
when using kudzu (Redhat Hardware detection tool, any version) without 
any output or log entry. I'm sorry, I was unable to monitor any crash 
dump information because the whole system hung up and didn't write any 
data. Kernels 2.4.21 or lower work fine.


[3.]
acpi, kudzu, nforce2, k72n delta-l, hwacpi, kernel 2.4.22

[4.] Linux version 2.4.22 (root@mrsuicide) (gcc version 3.2.2 20030222 
(Red Hat Linux 3.2.2-5)) #1 Fre Aug 8 02:24:50 CEST 2003

[5.] No message or log entry.

[6.] Get a NFORCE2 board and try kernel 2.4.22 with acpi.

[7.]
[7.1.] Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         nvaudio nvidia i2c-nforce2 w83781d i2c-isa 
i2c-dev i2c-proc i2c-core ipt_state ipt_MASQUERADE iptable_nat 
ip_conntrack parport_pc lp parport iptable_filter ip_tables ppp_synctty 
ppp_async ppp_generic slhc nvnet nls_iso8859-1 nls_cp437 keybdev 
mousedev hid input rtc

[7.2.] processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2079.544
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4141.87

[7.3.]
nvaudio                39668   0 (autoclean)
nvidia               1764672  11 (autoclean)
i2c-nforce2             4040   0 (unused)
w83781d                24592   0 (unused)
i2c-isa                 1292   0 (unused)
i2c-dev                 4960   0 (unused)
i2c-proc                8052   0 [w83781d]
i2c-core               19556   0 [i2c-nforce2 w83781d i2c-isa i2c-dev 
i2c-proc]
ipt_state               1048  12 (autoclean)
ipt_MASQUERADE          2200   1 (autoclean)
iptable_nat            20824   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           26824   2 (autoclean) [ipt_state ipt_MASQUERADE 
iptable_nat]
parport_pc             18756   1 (autoclean)
lp                      8772   0 (autoclean)
parport                35968   1 (autoclean) [parport_pc lp]
iptable_filter          2412   1 (autoclean)
ip_tables              14648   6 [ipt_state ipt_MASQUERADE iptable_nat 
iptable_filter]
ppp_synctty             7840   0 (unused)
ppp_async               9376   1
ppp_generic            24316   3 [ppp_synctty ppp_async]
slhc                    6932   0 [ppp_generic]
nvnet                  30720   1
nls_iso8859-1           3548   1 (autoclean)
nls_cp437               5148   1 (autoclean)
keybdev                 2880   0 (unused)
mousedev                5428   1
hid                    22020   0 (unused)
input                   5664   0 [keybdev mousedev hid]
rtc                     8444   0 (autoclean)

[7.4.] 0000-001f : dma1
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
0290-0297 : w83627hf
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5040-5047 : nForce2 SMBus
c000-cfff : PCI Bus #01
 c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   c000-c0ff : 8139too
d000-d007 : PCI device 10de:0066 (nVidia Corporation)
d400-d4ff : PCI device 10de:006a (nVidia Corporation)
 d400-d4ff : NVIDIA nForce2 Audio
d800-d87f : PCI device 10de:006a (nVidia Corporation)
 d800-d83f : NVIDIA nForce2 Audio
e400-e41f : PCI device 10de:0064 (nVidia Corporation)
f000-f00f : PCI device 10de:0065 (nVidia Corporation)
 f000-f007 : ide0
 f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
 00100000-00305268 : Kernel code
 00305269-0038a943 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : PCI device 10de:01e0 (nVidia Corporation)
d8000000-dfffffff : PCI Bus #02
 d8000000-dfffffff : nVidia Corporation NV10 [GeForce 256 SDR]
   d8000000-d9ffffff : rivafb
e0000000-e1ffffff : PCI Bus #02
 e0000000-e0ffffff : nVidia Corporation NV10 [GeForce 256 SDR]
e2000000-e2ffffff : PCI Bus #01
 e2000000-e20000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   e2000000-e20000ff : 8139too
e3000000-e3000fff : PCI device 10de:0066 (nVidia Corporation)
 e3000000-e3000fff : nvnet
e3001000-e3001fff : PCI device 10de:006a (nVidia Corporation)
e3003000-e3003fff : PCI device 10de:0067 (nVidia Corporation)
 e3003000-e3003fff : usb-ohci
e3004000-e3004fff : PCI device 10de:0067 (nVidia Corporation)
 e3004000-e3004fff : usb-ohci
e3005000-e30050ff : PCI device 10de:0068 (nVidia Corporation)
 e3005000-e30050ff : ehci-hcd


[7.5.] 00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev 
c1)
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0
       Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
       Capabilities: [40] AGP version 2.0
               Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
               Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
       Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0
       Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Interrupt: pin A routed to IRQ 12
       Region 0: I/O ports at e400 [size=32]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (750ns min, 250ns max)
       Interrupt: pin A routed to IRQ 10
       Region 0: Memory at e3003000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (750ns min, 250ns max)
       Interrupt: pin B routed to IRQ 11
       Region 0: Memory at e3004000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 20 [EHCI])
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (750ns min, 250ns max)
       Interrupt: pin C routed to IRQ 4
       Region 0: Memory at e3005000 (32-bit, non-prefetchable) [size=256]
       Capabilities: [44] #0a [2080]
       Capabilities: [80] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 570c
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (250ns min, 5000ns max)
       Interrupt: pin A routed to IRQ 11
       Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
       Region 1: I/O ports at d000 [size=8]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (500ns min, 1250ns max)
       Interrupt: pin A routed to IRQ 5
       Region 0: I/O ports at d400 [size=256]
       Region 1: I/O ports at d800 [size=128]
       Region 2: Memory at e3001000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) 
(prog-if 00 [Normal decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0
       Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
       I/O behind bridge: 0000c000-0000cfff
       Memory behind bridge: e2000000-e2ffffff
       Prefetchable memory behind bridge: fff00000-000fffff
       BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 
8a [Master SecP PriP])
       Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
       Latency: 0 (750ns min, 250ns max)
       Region 4: I/O ports at f000 [size=16]
       Capabilities: [44] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 
[Normal
decode])
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32
       Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
       I/O behind bridge: 0000f000-00000fff
       Memory behind bridge: e0000000-e1ffffff
       Prefetchable memory behind bridge: d8000000-dfffffff
       BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
       Subsystem: Allied Telesyn International AT-2500TX/ACPI
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (8000ns min, 16000ns max)
       Interrupt: pin A routed to IRQ 10
       Region 0: I/O ports at c000 [size=256]
       Region 1: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
       Capabilities: [50] Power Management version 2
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256 
SDR] (rev 10) (prog-if 00 [VGA])
       Subsystem: Elsa AG: Unknown device 0c41
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 248 (1250ns min, 250ns max)
       Interrupt: pin A routed to IRQ 12
       Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
       Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
       Expansion ROM at <unassigned> [disabled] [size=64K]
       Capabilities: [60] Power Management version 1
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [44] AGP version 2.0
               Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
               Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4

[7.6.] Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
 Vendor: HL-DT-ST Model: CD-RW GCE-8320B  Rev: 1.04
 Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] -

[X.] If nothing works, a simple downgrade of ACPI modules would fix the 
problem...

Greeings,
Jan Schiefer!


