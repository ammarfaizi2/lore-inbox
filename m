Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271756AbTHDO5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTHDO5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:57:49 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:46494 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S271756AbTHDO5m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:57:42 -0400
Date: Mon, 4 Aug 2003 11:57:29 -0300
From: Ricardo Jurczyk Pinheiro <rjp@email.com.br>
To: linux-kernel@vger.kernel.org
Cc: schilling@fokus.fhg.de
Subject: CDrecord -> Kernel panic
Message-ID: <20030804115729.A1018@aragorn.rjp.org.br>
Reply-To: autobot@bol.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
X-Arbitrary-Number-Of-The-Day: 69
Organization: Brazilian MSX Crew
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've been getting several kernel panics due to CD burning.

        When tried to burn old CD-RWs (4x), sometimes I've got a kernel
panic. The system told me a bug in the IDE stack (it had been told that
the problem is in the ide-iops.c file). Fortunately I was using only
CD-RWs... =)
	
	Let me send 2 U my info:
	
cat /proc/version
Linux version 2.4.21 (root@aragorn.rjp.org.br) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #4 Seg Ago 4 10:49:02 BRT 2003

cdrecord -version
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1300.084
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2588.67

cat /proc/modules
sg                     31340   0 (autoclean)
sd_mod                 12300   0 (autoclean) (unused)
r128                   83768   1
snd-pcm-oss            53988   0 (autoclean)
snd-mixer-oss          18296   2 (autoclean) [snd-pcm-oss]
sr_mod                 15928   0 (autoclean)
ip_conntrack_irc        4080   0 (unused)
ip_conntrack_ftp        5232   0 (unused)
ipt_MASQUERADE          2200   1
iptable_nat            20824   1 [ipt_MASQUERADE]
ipt_REJECT              4024   0 (unused)
ipt_LOG                 4184   0 (unused)
ipt_state               1048   2 (autoclean)
ip_conntrack           26824   4 (autoclean) [ip_conntrack_irc ip_conntrack_ftp ipt_MASQUERADE iptable_nat ipt_state]
iptable_filter          2412   1 (autoclean)
ip_tables              14648   8 [ipt_MASQUERADE iptable_nat ipt_REJECT ipt_LOG ipt_state iptable_filter]
via686a                 9792   0
eeprom                  4308   0
adm1021                 7032   0
i2c-proc                9136   0 [via686a eeprom adm1021]
i2c-isa                 1800   0 (unused)
i2c-viapro              4528   0 (unused)
i2c-core               19012   0 [via686a eeprom adm1021 i2c-proc i2c-isa i2c-viapro]
aic7xxx_old           121760   0 (unused)
8139too                18632   1 (autoclean)
mii                     3976   0 (autoclean) [8139too]
snd-seq-midi            6432   0 (unused)
snd-seq-midi-event      5704   0 [snd-seq-midi]
snd-seq                53200   0 [snd-seq-midi snd-seq-midi-event]
snd-ens1371            15276   2
snd-pcm                93152   0 [snd-pcm-oss snd-ens1371]
snd-page-alloc          9032   0 [snd-pcm]
snd-timer              21352   0 [snd-seq snd-pcm]
snd-ac97-codec         44992   0 [snd-ens1371]
snd-rawmidi            20128   0 [snd-seq-midi snd-ens1371]
snd-seq-device          6460   0 [snd-seq-midi snd-seq snd-rawmidi]
snd                    49060   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi snd-seq-midi-event snd-seq snd-ens1371 snd-pcm snd-timer snd-ac97-codec snd-rawmidi snd-seq-device]
soundcore               6468   6 [snd]
ide-scsi               12080   0
scsi_mod               99060   5 [sg sd_mod sr_mod aic7xxx_old ide-scsi]
ide-cd                 35360   0
cdrom                  33216   0 [sr_mod ide-cd]
nls_iso8859-1           3548   2 (autoclean)
nls_cp437               5148   2 (autoclean)
rtc                     8444   0 (autoclean)

cat /proc/ioports
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  5000-5007 : via2-smbus
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  6000-607f : via686a-sensors
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 RF/SG AGP
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
d800-d81f : VIA Technologies, Inc. USB (#2)
dc00-dcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dc00-dcff : 8139too
e000-e0ff : Adaptec AHA-7850
  e000-e0fe : aic7xxx
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
  e400-e43f : Ensoniq AudioPCI

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002610b7 : Kernel code
  002610b8-002b80e7 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : PCI Bus #01
  e0000000-e3ffffff : ATI Technologies Inc Rage 128 RF/SG AGP
    e0000000-e11fffff : vesafb
e4000000-e5ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
e6000000-e7ffffff : PCI Bus #01
  e7000000-e7003fff : ATI Technologies Inc Rage 128 RF/SG AGP
e8000000-e80000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e8000000-e80000ff : 8139too
e8001000-e8001fff : Adaptec AHA-7850
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: ABIT Computer Corp. KT7/KT7-RAID/KT7A/KT7A-RAID Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e6000000-e7ffffff
	Prefetchable memory behind bridge: e0000000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at e8001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Magnum/Xpert128/X99/Xpert2000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LG       Model: DVD-ROM DRD8160B Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HL-DT-ST Model: CD-RW GCE-8523B  Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02

	Sorry I can't help (I'm surely not a kernel hacker), but maybe 
it's a easy bug 2 fix.

	Thanks,

--
Ricardo Jurczyk Pinheiro - M. Sc. Numerical Modelling  - rjp@email.com.br
Anime, ABUB, MSX, Linux, Gospel, ST, Rock, Math... Fudeba! - ICQ: 3635907
Sola Scriptura - Sola Gratia - Sola Fide - Solo Christi - Soli Deo Gloria 

Nao perturbe, tenho muitos sonhos pela frente.
