Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUHWRKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUHWRKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUHWRKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:10:10 -0400
Received: from lora.pns.networktel.net ([216.83.236.238]:42759 "EHLO
	lora.pns.networktel.net") by vger.kernel.org with ESMTP
	id S266117AbUHWRIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:08:37 -0400
Message-ID: <412A23A4.2020803@versaccounting.com>
Date: Mon, 23 Aug 2004 12:04:36 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Recording Audio CD's
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.27.0.6; VDF 6.27.0.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Recording Audio CDs with kernel 2.6.8.1

[2.] When recording Audio CD's with cdrecord the output produced
      is of an alien sound. The best way to describe it would be
      like the sound that a modem makes. The tracks are recorded
      at the correct length, and cd play programs show the
      correct artist/album.

      This has been reproduced on 2 separate
      machine types:
          AMD XP with nForce2 chipset
          Intel P4 with the 82845G/GL Brookdale-G/GE/PE chipset.

      Both machines are nearly mechanically identical. Both have a single
      ATA 100 IDE disk on ide0 Primary. Both have 2 CD's on ide1. The
      ide1 primaries are a CD-ROm/16X DVD Player and the secondarys are
      CD-RW 52x52x52.

      I can boot into the Slackware stock 2.4.27 kernel and re-run the
      cdrecord command and it will burn correctly.
      I have applied the 2.6.8.1 patch for audio memory leak (see
      item 8.0 for specifics).

[3.] CD/RW, kernel, ATAPI

[4.] Kernel version (from /proc/version):

      AMD System;
      Linux version 2.6.8.1 (root@desktop) (gcc version 3.3.4)
      #4 Sat Aug 21 09:47:27 CDT 2004

      Intel System:
      Linux version 2.6.8.1 (root@ottnlee) (gcc version 3.3.4)
      #1 Fri Aug 20 14:16:55 CDT 2004


[5.] No oops.

[6.] cdrecord -v speed=8 dev=ATAPI:0,1,0 -audio track*

[7.] Environment:
      AMD machine:
      Slackware 10.0
      Cdrecord 2.00.3 (i686-pc-linux-gnu) i
      Copyright (C) 1995-2002 Jorg Schilling

      Intel machine:
      Slackware 10.0
      Cdrecord 2.00.3 (i686-pc-linux-gnu) i
      Copyright (C) 1995-2002 Jorg Schilling

[7.1.] Software:

AMD Machine:

Linux desktop 2.6.8.1
#4 Sat Aug 21 09:47:27 CDT 2004 i686 unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         uhci_hcd ohci_hcd ehci_hcd usbcore
                        shpchp pciehp pci_hotplug nvidia evdev
                        ide_scsi scsi_mod gen rtc

Intel machine:
Linux ottnlee 2.6.8.1
#1 Fri Aug 20 14:16:55 CDT 2004 i686 unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_pcm_oss snd_mixer_oss ohci_hcd i
                        intel_agp uhci_hcd ehci_hcd usbcore i
                        shpchp pciehp pci_hotplug i8xx_tco i
                        snd_intel8x0 snd_ac97_codec snd_pcm i
                        snd_timer snd_page_alloc gameport i
                        snd_mpu401_uart snd_rawmidi snd_seq_device
                        snd nvidia 8139too ide_scsi genrtc

[7.2.] Processor information
AMD machine:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2079.578
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
                   mtrr pge mca cmov pat pse36 mmx fxsr sse
                   syscall mmxext 3dnowext 3dnow
bogomips        : 4120.57

Intel machine:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2793.242
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
                   mtrr pge mca cmov pat pse36 clflush dts acpi
                   mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5537.79


[7.3.] Module information (from /proc/modules):

AMD Machine:
uhci_hcd 32784 0 - Live 0xf8ad8000
ohci_hcd 21636 0 - Live 0xf8a9f000
ehci_hcd 31364 0 - Live 0xf8a96000
usbcore 119268 5 uhci_hcd,ohci_hcd,ehci_hcd, Live 0xf8ab9000
shpchp 101292 0 - Live 0xf8a5e000
pciehp 97836 0 - Live 0xf8a7d000
pci_hotplug 12164 2 shpchp,pciehp, Live 0xf8a3a000
nvidia 4821268 0 - Live 0xf8f52000
evdev 9536 0 - Live 0xf8a2d000
ide_scsi 17476 0 - Live 0xf8a34000
scsi_mod 84032 1 ide_scsi, Live 0xf8a48000
genrtc 9844 0 - Live 0xf8a29000snd_pcm_oss 53928 0 - Live 0xf8a79000


Intel Machine:

snd_mixer_oss 20352 1 snd_pcm_oss, Live 0xf8a62000
ohci_hcd 21508 0 - Live 0xf899c000
intel_agp 22432 1 - Live 0xf8a22000
uhci_hcd 32272 0 - Live 0xf8a19000
ehci_hcd 31108 0 - Live 0xf8a10000
usbcore 116836 5 ohci_hcd,uhci_hcd,ehci_hcd, Live 0xf8a33000
shpchp 100204 0 - Live 0xf89d8000
pciehp 96876 0 - Live 0xf89f7000
pci_hotplug 34096 2 shpchp,pciehp, Live 0xf89a3000
i8xx_tco 7440 0 - Live 0xf8994000
snd_intel8x0 35884 0 - Live 0xf896f000
snd_ac97_codec 68484 1 snd_intel8x0, Live 0xf89c6000
snd_pcm 96392 2 snd_pcm_oss,snd_intel8x0, Live 0xf89ad000
snd_timer 25860 1 snd_pcm, Live 0xf8988000
snd_page_alloc 11912 2 snd_intel8x0,snd_pcm, Live 0xf8959000
gameport 4864 1 snd_intel8x0, Live 0xf8956000
snd_mpu401_uart 8064 1 snd_intel8x0, Live 0xf894d000
snd_rawmidi 25380 1 snd_mpu401_uart, Live 0xf8967000
snd_seq_device 8712 1 snd_rawmidi, Live 0xf8949000
snd 55140 9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,
        snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xf8979000
nvidia 4821716 0 - Live 0xf8e5b000
8139too 25344 0 - Live 0xf895f000
ide_scsi 17284 0 - Live 0xf8950000
genrtc 9972 0 - Live 0xf8945000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
AMD Machine:
IO-PORTS:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5040-5047 : nForce2 SMBus
c000-dfff : PCI Bus #01
c000-c007 : 0000:01:07.0
c000-c007 : ide2
c400-c403 : 0000:01:07.0
c402-c402 : ide2
c800-c807 : 0000:01:07.0
cc00-cc03 : 0000:01:07.0
d000-d00f : 0000:01:07.0
d000-d007 : ide2
d008-d00f : ide3
e000-e007 : 0000:00:04.0
e000-e007 : forcedeth
e400-e4ff : 0000:00:06.0
e800-e87f : 0000:00:06.0
e800-e83f : NVidia nForce2 - Controller
ec00-ec1f : 0000:00:01.1
f000-f00f : 0000:00:09.0
f000-f007 : ide0
f008-f00f : ide1

IOMEM:
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000d0000-000d17ff : Adapter ROM
000d2000-000d3fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-4ffeffff : System RAM
00100000-0030e92e : Kernel code
0030e92f-003f393f : Kernel data
4fff0000-4fff2fff : ACPI Non-volatile Storage
4fff3000-4fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #02
e4000000-e7ffffff : 0000:02:00.0
e8000000-e9ffffff : PCI Bus #02
e8000000-e8ffffff : 0000:02:00.0
e8000000-e8ffffff : nvidia
ea000000-eaffffff : PCI Bus #01
eb000000-eb000fff : 0000:00:04.0
eb000000-eb000fff : forcedeth
eb001000-eb001fff : 0000:00:06.0
eb001000-eb0011ff : NVidia nForce2 - AC'97
eb002000-eb002fff : 0000:00:02.0
eb002000-eb002fff : ohci_hcd
eb003000-eb003fff : 0000:00:02.1
eb003000-eb003fff : ohci_hcd
eb004000-eb0040ff : 0000:00:02.2
eb004000-eb0040ff : ehci_hcd

Intel machine:
IOPORTS:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:1f.0
4060-406f : i8xx TCO
4080-40bf : 0000:00:1f.0
5000-501f : 0000:00:1f.3
c000-c0ff : 0000:02:04.0
c000-c0ff : 8139too
d000-d01f : 0000:00:1d.1
d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.2
d400-d41f : uhci_hcd
d800-d81f : 0000:00:1d.0
d800-d81f : uhci_hcd
e000-e0ff : 0000:00:1f.5
e400-e43f : 0000:00:1f.5
f000-f00f : 0000:00:1f.1
f000-f007 : ide0
f008-f00f : ide1

IOMEM:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ca7ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
00100000-002b8bef : Kernel code
002b8bf0-003c257f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : 0000:00:1f.1
e0000000-e7ffffff : PCI Bus #01
e0000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ec000000-edffffff : PCI Bus #01
ec000000-ecffffff : 0000:01:00.0
ec000000-ecffffff : nvidia
ee000000-ee0000ff : 0000:02:04.0
ee000000-ee0000ff : 8139too
ee100000-ee1003ff : 0000:00:1d.7
ee100000-ee1003ff : ehci_hcd
ee101000-ee1011ff : 0000:00:1f.5
ee101000-ee1011ff : Intel 82801DB-ICH4 - AC'97
ee102000-ee1020ff : 0000:00:1f.5
ee102000-ee1020ff : Intel 82801DB-ICH4 - Controller
fec00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
AMD Machine:-------------------------------------------------------------------------
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [40] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at ec00 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at eb002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 185
	Region 0: Memory at eb003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 193
	Region 0: Memory at eb004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 570c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at eb000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) 
(rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at e800 [size=128]
	Region 2: Memory at eb001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: ea000000-eaffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5700
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:07.0 SCSI storage controller: Artop Electronic Corp ATP865 (rev 02)
	Subsystem: Artop Electronic Corp ATP865
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 254 (2750ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at c400 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at d000 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2) 
(prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8


Intel machine PCI: -------------------------------------------------------------------------

00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub 
Interface (rev 03)
	Subsystem: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [6105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP Bridge (rev 03) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: AOPEN Inc.: Unknown device 02c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: AOPEN Inc.: Unknown device 02c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 177
	Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: AOPEN Inc.: Unknown device 02c8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 185
	Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 02) (prog-if 20 
[EHCI])
	Subsystem: AOPEN Inc.: Unknown device 040a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 193
	Region 0: Memory at ee100000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 82) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ee000000-ee0fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB (ICH4) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) Ultra ATA 100 Storage Controller (rev 02) 
(prog-if 8a [Master SecP PriP])
	Subsystem: AOPEN Inc.: Unknown device 02c8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 02)
	Subsystem: AOPEN Inc.: Unknown device 02c8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at 5000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 02)
	Subsystem: AOPEN Inc.: Unknown device 0225
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 201
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e400 [size=64]
	Region 2: Memory at ee101000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ee102000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 DDR/200 DDR] 
(rev b2) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 002c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: AOPEN Inc.: Unknown device 0180
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 209
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)
        AMD and Intel both show no attached devices.


[7.7.] Other information that might be relevant to the problem
AMD machine Cd Burner on ide1 secondary settings:

name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                25038           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           66              0               70              rw
failures                0               0               65535           rw
init_speed              66              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

Intel machine Cd Burner on ide1 secondary settings:

name                    value           min             max             mode
----                    -----           ---             ---             ----
current_speed           66              0               70              rw
dsc_overlap             1               0               1               rw
ide-scsi                0               0               1               rw
init_speed              66              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw


[8.] Other notes, patches, fixes, workarounds:

      Very Important:
      I have applied the patch from this link:

      http://kerneltrap.org/node/view/3659

      This was to BOTH the AMD and the Intel Computers.
      It did not make any difference. Creating audio still
      produces the "modem" sounds instead of the correct
      format. Neither machine experienced the "slow" down
      as reported here, either before or after applying
      the patch.


-- 
Ben Duncan   - VersAccounting Software LLC 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

