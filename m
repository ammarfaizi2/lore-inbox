Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSKZSQN>; Tue, 26 Nov 2002 13:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSKZSQM>; Tue, 26 Nov 2002 13:16:12 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:60305 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S266456AbSKZSQG>; Tue, 26 Nov 2002 13:16:06 -0500
Date: Tue, 26 Nov 2002 10:23:07 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200211261823.gAQIN7J17474@athlon.cichlid.com>
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: PROBLEM: PDC20267 fails (in different ways) with 2.4.20-rc3 and 2.4.20-rc2-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PDC20267 that works with 2.4.19-ac4.
With 2.4.20-rc3 the machine hangs at checking filesystems.
With 2.4.20-rc2-ac3 the machine boots but the PDC20267 is not detected at all.

For the WORKING 2.4.19-ac4:

[1.] PDC20267 fails (in different ways) with 2.4.20-rc3 and 2.4.20-rc2-ac3

[2.] With 2.4.20-rc3 the machine hangs at checking filesystems.
     With 2.4.20-rc2-ac3 the machine boots but the PDC20267 is not detected at all.

[3.] IDE, Promise, PDC20267

[4.] Linux version 2.4.19-ac4-i686 (root@athlon) (gcc version 2.96 20000731 (Red Hat Linux 7.2 2.96-112.7.1)) #2 SMP Mon Nov 25 15:30:13 PST 2002

[5.] Doesn't oops

[6.] Boot problem

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
  Linux athlon 2.4.19-ac4-i686 #2 SMP Mon Nov 25 15:30:13 PST 2002 i686 unknown
   
  Gnu C                  2.96
  Gnu make               3.79.1
  util-linux             2.11f
  mount                  2.11g
  modutils               2.4.18
  e2fsprogs              1.26
  reiserfsprogs          3.x.0f
  pcmcia-cs              3.1.22
  PPP                    2.4.0
  isdn4k-utils           3.1pre1
  Linux C Library        2.2.90
  Dynamic linker (ldd)   2.2.90
  Procps                 2.0.7
  Net-tools              1.57
  Console-tools          0.3.3
  Sh-utils               2.0
  Modules Loaded         appletalk vmnet vmmon st wcusb wcfxo zaptel snd-pcm-oss snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-util-mem snd-ac97-codec snd-rawmidi snd-pcm snd-timer snd-hwdep snd-seq-device snd NVdriver ecc ppp_generic slhc ipt_TOS ipt_state ipt_REJECT ipt_MASQUERADE ipt_LOG ipt_multiport ip_nat_ftp ip_conntrack_ftp iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables ospm_processor ospm_system ospm_busmgr i2c-dev i2c-core parport_pc lp parport 8139too mii sd_mod md audio dsbr100 videodev soundcore usb-ohci usbcore

[7.2.] Processor information (from /proc/cpuinfo):
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 6
  model name      : AMD Athlon(tm) MP
  stepping        : 1
  cpu MHz         : 1194.696
  cache size      : 256 KB
  physical id     : 0
  siblings        : 1
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 2385.51

  processor       : 1
  vendor_id       : AuthenticAMD
  cpu family      : 6
  model           : 6
  model name      : AMD Athlon(tm) Processor
  stepping        : 1
  cpu MHz         : 1194.696
  cache size      : 256 KB
  physical id     : 0
  siblings        : 1
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 1
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
  bogomips        : 2385.51

[7.3.] Module information (from /proc/modules):
  appletalk              32140   0 (autoclean)
  vmnet                  23584   6
  vmmon                  23892   3
  st                     30036   0 (autoclean) (unused)
  wcusb                  18400   0 (unused)
  wcfxo                   7200   1
  zaptel                185152   4 [wcusb wcfxo]
  snd-pcm-oss            42368   2 (autoclean)
  snd-mixer-oss          11712   1 (autoclean) [snd-pcm-oss]
  snd-card-emu10k1        3008   3
  snd-emu10k1            67872   0 [snd-card-emu10k1]
  snd-util-mem            3460   0 [snd-emu10k1]
  snd-ac97-codec         29248   0 [snd-emu10k1]
  snd-rawmidi            18880   0 [snd-emu10k1]
  snd-pcm                76384   0 [snd-pcm-oss snd-emu10k1]
  snd-timer              16160   0 [snd-pcm]
  snd-hwdep               4960   0 [snd-emu10k1]
  snd-seq-device          5688   0 [snd-card-emu10k1 snd-rawmidi]
  snd                    40616   0 [snd-pcm-oss snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-util-mem snd-ac97-codec snd-rawmidi snd-pcm snd-timer snd-hwdep snd-seq-device]
  NVdriver              902432   0 (unused)
  ecc                    15232   0 (unused)
  ppp_generic            25868   0 [zaptel]
  slhc                    6204   0 [ppp_generic]
  ipt_TOS                 1664   5 (autoclean)
  ipt_state               1248   6 (autoclean)
  ipt_REJECT              3520   2 (autoclean)
  ipt_MASQUERADE          2848   2 (autoclean)
  ipt_LOG                 4288 134 (autoclean)
  ipt_multiport           1344   5
  ip_nat_ftp              5056   0 (unused)
  ip_conntrack_ftp        5184   0 [ip_nat_ftp]
  iptable_mangle          2784   1 (autoclean)
  iptable_nat            26996   2 (autoclean) [ipt_MASQUERADE ip_nat_ftp]
  ip_conntrack           30604   3 (autoclean) [ipt_state ipt_MASQUERADE ip_nat_ftp ip_conntrack_ftp iptable_nat]
  iptable_filter          2432   1 (autoclean)
  ip_tables              17152  11 [ipt_TOS ipt_state ipt_REJECT ipt_MASQUERADE ipt_LOG ipt_multiport iptable_mangle iptable_nat iptable_filter]
  ospm_processor         10880   0 (unused)
  ospm_system             8908   0 (unused)
  ospm_busmgr            29952   0 [ospm_processor ospm_system]
  i2c-dev                 4736   0 (unused)
  i2c-core               19456   0 [i2c-dev]
  parport_pc             17348   2 (autoclean)
  lp                      8160   0 (autoclean)
  parport                37376   2 (autoclean) [parport_pc lp]
  8139too                20736   1 (autoclean)
  mii                     2248   0 (autoclean) [8139too]
  sd_mod                 12832  16 (autoclean)
  md                     64448   0
  audio                  44960   0
  dsbr100                 5056   1
  videodev                6080   2 [dsbr100]
  soundcore               7204   7 [snd audio]
  usb-ohci               24320   0 (unused)
  usbcore                78240   1 [wcusb audio dsbr100 usb-ohci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
  02f8-02ff : serial(auto)
  0376-0376 : ide1
  0378-037a : parport0
  037b-037f : parport0
  03c0-03df : vga+
  03f6-03f6 : ide0
  03f8-03ff : serial(auto)
  0cf8-0cff : PCI conf1
  1000-10ff : PCI device 1057:5608 (Motorola)
    1000-10fe : wcfxo
  1400-14ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    1400-14ff : 8139too
  1800-183f : Promise Technology, Inc. 20267
    1800-1807 : ide2
    1808-180f : ide3
    1810-183f : PDC20267
  1840-185f : Creative Labs SB Live! EMU10k1
    1840-185f : EMU10K1
  1860-187f : Oxford Semiconductor Ltd Quad 16950 UART
  1880-189f : Oxford Semiconductor Ltd Quad 16950 UART
    1880-1887 : serial(auto)
    1888-188f : serial(auto)
    1890-1897 : serial(auto)
    1898-189f : serial(auto)
  18a0-18bf : PCI device 1415:9513 (Oxford Semiconductor Ltd)
  18d0-18df : 3ware Inc 3ware 7000-series ATA-RAID
    18d0-18dc : 3ware Storage Controller
  18e0-18e3 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
  18e4-18e7 : Promise Technology, Inc. 20267
    18e6-18e6 : ide3
  18e8-18ef : Promise Technology, Inc. 20267
    18e8-18ef : ide3
  18f0-18f3 : Promise Technology, Inc. 20267
    18f2-18f2 : ide2
  18f8-18ff : Promise Technology, Inc. 20267
    18f8-18ff : ide2
  1c00-1c07 : Creative Labs SB Live! MIDI/Game Port
  1c08-1c0f : PCI device 1415:9513 (Oxford Semiconductor Ltd)
  1c10-1c17 : PCI device 1415:9513 (Oxford Semiconductor Ltd)
    1c10-1c12 : parport1
  f000-f00f : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
    f000-f007 : ide0
    f008-f00f : ide1


  00000000-0009dfff : System RAM
  0009e000-0009ffff : reserved
  000a0000-000bffff : Video RAM area
  000c0000-000c7fff : Video ROM
  000ca800-000cc7ff : Extension ROM
  000cc800-000cdfff : Extension ROM
  000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
    000dc000-000dcfff : usb-ohci
  000e0000-000effff : Extension ROM
  000f0000-000fffff : System ROM
  00100000-2ffeffff : System RAM
    00100000-002868f1 : Kernel code
    002868f2-003256ff : Kernel data
  2fff0000-2ffffbff : ACPI Tables
  2ffffc00-2fffffff : ACPI Non-volatile Storage
  f4000000-f47fffff : 3ware Inc 3ware 7000-series ATA-RAID
  f4800000-f481ffff : Promise Technology, Inc. 20267
  f4821000-f4821fff : PCI device 1057:5608 (Motorola)
  f4822000-f4822fff : Oxford Semiconductor Ltd Quad 16950 UART
  f4823000-f4823fff : Oxford Semiconductor Ltd Quad 16950 UART
  f4824000-f4824fff : PCI device 1415:9513 (Oxford Semiconductor Ltd)
  f4825000-f482500f : 3ware Inc 3ware 7000-series ATA-RAID
  f4825400-f48254ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    f4825400-f48254ff : 8139too
  f4826000-f4826fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
  f5000000-f5ffffff : PCI Bus #01
    f5000000-f5ffffff : nVidia Corporation Vanta [NV6]
  f8000000-fbffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
  fc000000-fdffffff : PCI Bus #01
    fc000000-fdffffff : nVidia Corporation Vanta [NV6]
  fec00000-fec0ffff : reserved
  fee00000-fee00fff : reserved
  fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

  00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	  Latency: 64
	  Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	  Region 1: Memory at f4826000 (32-bit, prefetchable) [size=4K]
	  Region 2: I/O ports at 18e0 [disabled] [size=4]
	  Capabilities: [a0] AGP version 2.0
		  Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		  Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

  00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 99
	  Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	  I/O behind bridge: 0000f000-00000fff
	  Memory behind bridge: f5000000-f5ffffff
	  Prefetchable memory behind bridge: fc000000-fdffffff
	  BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

  00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 02)
	  Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 0

  00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 01) (prog-if 8a [Master SecP PriP])
	  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64
	  Region 0: [virtual] I/O ports at 01f0
	  Region 1: [virtual] I/O ports at 03f4
	  Region 2: [virtual] I/O ports at 0170
	  Region 3: [virtual] I/O ports at 0374
	  Region 4: I/O ports at f000 [size=16]

  00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 01)
	  Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

  00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB (rev 07) (prog-if 10 [OHCI])
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 16 (20000ns max)
	  Interrupt: pin D routed to IRQ 19
	  Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

  00:08.0 Communication controller: Motorola: Unknown device 5608
	  Subsystem: Motorola: Unknown device 0000
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64 (250ns min, 32000ns max)
	  Interrupt: pin A routed to IRQ 16
	  Region 0: I/O ports at 1000 [size=256]
	  Region 1: Memory at f4821000 (32-bit, non-prefetchable) [size=4K]
	  Capabilities: [40] Power Management version 2
		  Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	  Subsystem: Promise Technology, Inc. Ultra100
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64
	  Interrupt: pin A routed to IRQ 17
	  Region 0: I/O ports at 18f8 [size=8]
	  Region 1: I/O ports at 18f0 [size=4]
	  Region 2: I/O ports at 18e8 [size=8]
	  Region 3: I/O ports at 18e4 [size=4]
	  Region 4: I/O ports at 1800 [size=64]
	  Region 5: Memory at f4800000 (32-bit, non-prefetchable) [size=128K]
	  Expansion ROM at <unassigned> [disabled] [size=64K]
	  Capabilities: [58] Power Management version 1
		  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	  Subsystem: Creative Labs CT4832 SBLive! Value
	  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64 (500ns min, 5000ns max)
	  Interrupt: pin A routed to IRQ 18
	  Region 0: I/O ports at 1840 [size=32]
	  Capabilities: [dc] Power Management version 1
		  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	  Subsystem: Creative Labs Gameport Joystick
	  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64
	  Region 0: I/O ports at 1c00 [size=8]
	  Capabilities: [dc] Power Management version 1
		  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0b.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
	  Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
	  Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 72 (2250ns min), cache line size 10
	  Interrupt: pin A routed to IRQ 19
	  Region 0: I/O ports at 18d0 [size=16]
	  Region 1: Memory at f4825000 (32-bit, non-prefetchable) [size=16]
	  Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=8M]
	  Expansion ROM at <unassigned> [disabled] [size=64K]
	  Capabilities: [40] Power Management version 1
		  Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0c.0 Serial controller: Oxford Semiconductor Ltd Quad 16950 UART (prog-if 06 [16950])
	  Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Interrupt: pin A routed to IRQ 16
	  Region 0: I/O ports at 1880 [size=32]
	  Region 1: Memory at f4823000 (32-bit, non-prefetchable) [size=4K]
	  Region 2: I/O ports at 1860 [size=32]
	  Region 3: Memory at f4822000 (32-bit, non-prefetchable) [size=4K]
	  Capabilities: [40] Power Management version 1
		  Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0c.1 Parallel controller: Oxford Semiconductor Ltd: Unknown device 9513 (prog-if 01 [BiDir])
	  Subsystem: Oxford Semiconductor Ltd: Unknown device 0000
	  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Interrupt: pin B routed to IRQ 17
	  Region 0: I/O ports at 1c10 [size=8]
	  Region 1: I/O ports at 1c08 [size=8]
	  Region 2: I/O ports at 18a0 [size=32]
	  Region 3: Memory at f4824000 (32-bit, non-prefetchable) [size=4K]
	  Capabilities: [40] Power Management version 1
		  Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	  Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64 (8000ns min, 16000ns max)
	  Interrupt: pin A routed to IRQ 17
	  Region 0: I/O ports at 1400 [size=256]
	  Region 1: Memory at f4825400 (32-bit, non-prefetchable) [size=256]
	  Capabilities: [50] Power Management version 2
		  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

  01:05.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15) (prog-if 00 [VGA])
	  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	  Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	  Latency: 64 (1250ns min, 250ns max)
	  Interrupt: pin A routed to IRQ 18
	  Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	  Region 1: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	  Expansion ROM at <unassigned> [disabled] [size=64K]
	  Capabilities: [60] Power Management version 1
		  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	  Capabilities: [44] AGP version 2.0
		  Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

  Attached devices: 
  Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 01 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 02 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 03 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 04 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 05 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 06 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
  Host: scsi0 Channel: 00 Id: 07 Lun: 00
    Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
    Type:   Direct-Access                    ANSI SCSI revision: ffffffff

[7.7.] Other information that might be relevant to the problem

  The Promise firmware was upgraded a few months ago.

  For 2.4.20-rc3 I had CONFIG_BLK_DEV_IDEDMA_TIMEOUT and CONFIG_IDEDMA_NEW_DRIVE_LISTINGS set

  The controller has two ATA133 drives attached and two others:
    Maxtor 4G120J6
    IBM IC35L060AVER07-0
    Maxtor 4G120J6
    IBM IC35L040AVER07-0
  They are all running in udma5 (hmmm) even though the Maxtors show udma6 capable in hdparm.

[X.] Other notes, patches, fixes, workarounds:

Let me know if I can provide any help
Andrew

