Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVFOJbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFOJbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVFOJbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:31:48 -0400
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:16381 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S261368AbVFOJam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:30:42 -0400
Subject: PROBLEM: lock
From: Jan <eidtmann@informatik.uni-bremen.de>
Reply-To: eidtmann@informatik.uni-bremen.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 15 Jun 2005 11:30:35 +0200
Message-Id: <1118827835.5992.5.camel@lunar.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System-Info:
Linux lunar 2.6.11.11 #1 SMP Sat Jun 4 15:21:24 CEST 2005 i686 unknown
unknown GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.16.1
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.25
quota-tools            3.12.
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   058
Modules Loaded         eepro100 emu10k1_gp gameport 3c59x intel_mch_agp
fglrx agpgart snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem
snd_hwdep

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2606.612
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5160.96

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2606.612
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5193.72

/proc/modules
eepro100 27280 0 - Live 0xf89eb000
emu10k1_gp 3072 0 - Live 0xf88e8000
gameport 3968 1 emu10k1_gp, Live 0xf88e6000
3c59x 38824 0 - Live 0xf891d000
intel_mch_agp 8592 1 - Live 0xf88e2000
fglrx 241852 7 - Live 0xf8a0b000
agpgart 29488 2 intel_mch_agp,fglrx, Live 0xf89b7000
snd_emu10k1 96260 2 - Live 0xf8929000
snd_rawmidi 20640 1 snd_emu10k1, Live 0xf88ea000
snd_ac97_codec 73728 1 snd_emu10k1, Live 0xf88f9000
snd_util_mem 3712 1 snd_emu10k1, Live 0xf88e0000
snd_hwdep 7712 1 snd_emu10k1, Live 0xf88dd000

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000d0000-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0045504e : Kernel code
  0045504f-0056a87f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : 0000:00:1f.1
e0000000-e7ffffff : 0000:00:00.0
e8000000-f7ffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
  f0000000-f7ffffff : 0000:01:00.1
f8000000-f9ffffff : PCI Bus #01
  f9000000-f900ffff : 0000:01:00.0
  f9010000-f901ffff : 0000:01:00.1
fb005000-fb00507f : 0000:02:01.0
fb006000-fb006fff : 0000:02:08.0
  fb006000-fb006fff : eepro100
fc000000-fc0003ff : 0000:00:1d.7
  fc000000-fc0003ff : ehci_hcd
fec00000-ffffffff : reserved

/proc/ioports
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
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1028-102f : GPE0_BLK
1080-10bf : 0000:00:1f.0
1400-141f : 0000:00:1f.3
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-a07f : 0000:02:01.0
  a000-a07f : 0000:02:01.0
a400-a41f : 0000:02:02.0
  a400-a41f : EMU10K1
a800-a807 : 0000:02:02.1
  a800-a807 : emu10k1-gp
ac00-ac3f : 0000:02:08.0
  ac00-ac3f : eepro100
b000-b01f : 0000:00:1d.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
  bc00-bc1f : uhci_hcd
c000-c007 : 0000:00:1f.2
  c000-c007 : libata
c400-c403 : 0000:00:1f.2
  c400-c403 : libata
c800-c807 : 0000:00:1f.2
  c800-c807 : libata
cc00-cc03 : 0000:00:1f.2
  cc00-cc03 : libata
d000-d00f : 0000:00:1f.2
  d000-d00f : libata
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1

lspci -vvv
00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 2570
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+
Rate=x8

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: e8000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
(prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at fc000000 (32-bit, non-prefetchable)
[size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0
+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
(prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable)
[size=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
(prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Giga-byte Technology: Unknown device 24d1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c000 [size=8]
        Region 1: I/O ports at c400 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at cc00 [size=4]
        Region 4: I/O ports at d000 [size=16]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 24d2
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4e48 (prog-if 00 [VGA])
        Subsystem: Hercules: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at f9000000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW
+ Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc: Unknown device 4e68
        Subsystem: Hercules: Unknown device 0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at f9010000 (32-bit, non-prefetchable)
[size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at a000 [size=128]
        Region 1: Memory at fb005000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at a400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 02)
        Subsystem: Giga-byte Technology: Unknown device 3013
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fb006000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at ac00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

/proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3120026AS      Rev: 3.05
  Type:   Direct-Access

###################################################
/var/log/messages
Jun 15 04:50:01 lunar kernel: ------------[ cut here ]------------
Jun 15 04:50:01 lunar kernel: kernel BUG at mm/vmscan.c:563!
Jun 15 04:50:01 lunar kernel: invalid operand: 0000 [#1]
Jun 15 04:50:01 lunar kernel: PREEMPT SMP
Jun 15 04:50:01 lunar kernel: Modules linked in: fglrx eepro100
emu10k1_gp gameport 3c59x intel_mch_agp agpgart snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_util_mem snd_hwdep
Jun 15 04:50:01 lunar kernel: CPU:    0
Jun 15 04:50:01 lunar kernel: EIP:    0060:[<c01432f0>]    Tainted: P
VLI
Jun 15 04:50:01 lunar kernel: EFLAGS: 00010046   (2.6.11.11)
Jun 15 04:50:01 lunar kernel: EIP is at shrink_cache+0xb0/0x350
Jun 15 04:50:01 lunar kernel: eax: 00000000   ebx: c04cbd00   ecx:
c1711018   edx: c1711018
Jun 15 04:50:01 lunar kernel: esi: 00000020   edi: c04cbf90   ebp:
c1bfbeb4   esp: c1bfbe98
Jun 15 04:50:01 lunar kernel: ds: 007b   es: 007b   ss: 0068
Jun 15 04:50:01 lunar kernel: Process kswapd0 (pid: 209,
threadinfo=c1bfa000 task=c1bb8a80)
Jun 15 04:50:01 lunar kernel: Stack: c0114702 f7c30a80 c1bfbecc c1bfa000
0000001f c04cbf80 00000020 c1711038
Jun 15 04:50:01 lunar kernel:        c172fbb8 00000000 00000001 00000202
00000001 00000296 00000000 00000000
Jun 15 04:50:01 lunar kernel:        00000000 c1bfbef0 c011474d f7c30a80
0000000f 00000000 c19f6b80 c0262854
Jun 15 04:50:01 lunar kernel: Call Trace:
Jun 15 04:50:01 lunar kernel:  [<c0114702>] try_to_wake_up+0x262/0x290
Jun 15 04:50:01 lunar kernel:  [<c011474d>] wake_up_process+0x1d/0x30
Jun 15 04:50:01 lunar kernel:  [<c0262854>] pagebuf_daemon_wakeup
+0x14/0x20
Jun 15 04:50:01 lunar kernel:  [<c0142b08>] shrink_slab+0x88/0x190
Jun 15 04:50:01 lunar kernel:  [<c0143b4a>] shrink_zone+0xba/0xf0
Jun 15 04:50:01 lunar kernel:  [<c0144058>] balance_pgdat+0x2b8/0x3b0
Jun 15 04:50:01 lunar kernel:  [<c014423d>] kswapd+0xed/0x110
Jun 15 04:50:01 lunar kernel:  [<c012f8c0>] autoremove_wake_function
+0x0/0x60
Jun 15 04:50:01 lunar kernel:  [<c0102782>] ret_from_fork+0x6/0x14
Jun 15 04:50:01 lunar kernel:  [<c012f8c0>] autoremove_wake_function
+0x0/0x60
Jun 15 04:50:01 lunar kernel:  [<c0144150>] kswapd+0x0/0x110
Jun 15 04:50:01 lunar kernel:  [<c01009f5>] kernel_thread_helper
+0x5/0x10
Jun 15 04:50:01 lunar kernel: Code: 00 00 89 f6 8d bc 27 00 00 00 00 8b
8b 94 02 00 00 8b 41 04 39 f8 74 07 83 e8 18 8d 74 26 00 f0 0f ba 71 e8
05 19 c0 85 c0 75 08 <0f> 0b 33 02 33 fa 46 c0 8b 51 04 8b 01 89 50 04
89 02 c7 41 04
Jun 15 04:50:01 lunar kernel:  <6>note: kswapd0[209] exited with
preempt_count 1



