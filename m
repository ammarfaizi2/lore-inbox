Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbSKUMSs>; Thu, 21 Nov 2002 07:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266601AbSKUMSs>; Thu, 21 Nov 2002 07:18:48 -0500
Received: from Core-129.SAO.ru ([194.85.27.129]:640 "EHLO jack.sao.ru")
	by vger.kernel.org with ESMTP id <S266586AbSKUMSn>;
	Thu, 21 Nov 2002 07:18:43 -0500
Date: Thu, 21 Nov 2002 15:25:44 +0300 (MSK)
From: Dmitry Kudryavtsev <dkudr@sao.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Sound VIA VT8233 on K7VTA3 motherboard
Message-ID: <Pine.LNX.4.44.0211211445190.1664-100000@jack.sao.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
-------------------------------------
  Problems with sound VIA VT8233A on K7VTA3 motherboard



[2.] Full description of the problem/report:
--------------------------------------------

 Sound works perfectly with Windows on the same host.

 dmesg:
  PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
   using pci=biosirq
  ...
  VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1

sndconfig:
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
 via82cxxx_audio.o: init_module: No such device         
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
 via82cxxx_audio.o: insmod                             
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
 via82cxxx_audio.o failed                               
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
 via82cxxx_audio.o: insmod sound-slot-0 failed

modprobe via82cxxx_audio:
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 init_module: No such device
 Hint: insmod errors can be caused by incorrect module parameters, 
 including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
  insmod 
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o 
  failed
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
  insmod via82cxxx_audio failed

insmod via82cxxx_audio:
 Using 
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol unregister_sound_mixer_R7afc9d8a
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol unload_uart401_Recfdd9c9
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol ac97_probe_codec_R84601c2b
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol register_sound_dsp_R9f707dfd
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol register_sound_mixer_R4f0bdcbb
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol uart401intr_R6391d066
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol unregister_sound_dsp_Rcd083b10
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol midi_devs_Rb3ae63d0
 /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o: 
 unresolved symbol probe_uart401_R63d781ea



[3.] Keywords (i.e., modules, networking, kernel):
--------------------------------------------------

 sound, modules, kernel



[4.] Kernel version (from /proc/version):
-----------------------------------------

 2.4.18-18.7.x (Red Hat Linux 7.3)



[7.1.] Software (add the output of the ver_linux script here)
-------------------------------------------------------------

 Linux jack.sao.ru 2.4.18-18.7.x #2 Втр Ноя 19 14:38:44 MSK 2002 
  i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         radeon agpgart binfmt_misc parport_pc lp parport 
 autofs ne2k-pci 8390 ipchains ide-cd cdrom nls_iso8859-1 ntfs usb-uhci 
 usbcore ext3 jbd



[7.2.] Processor information (from /proc/cpuinfo):
--------------------------------------------------

 processor       : 0
 vendor_id       : AuthenticAMD
 cpu family      : 6
 model           : 6
 model name      : AMD Athlon(tm) XP 1600+
 stepping        : 2
 cpu MHz         : 1399.938
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
 cmov 
 pat p
 se36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
 bogomips        : 2778.83



[7.3.] Module information (from /proc/modules):
-----------------------------------------------

 radeon                 96312   1
 agpgart                40032   3
 binfmt_misc             7236   1
 parport_pc             17476   1 (autoclean)
 lp                      8576   0 (autoclean)
 parport                33536   1 (autoclean) [parport_pc lp]
 autofs                 11108   0 (autoclean) (unused)
 ne2k-pci                6368   1
 8390                    7940   0 [ne2k-pci]
 ipchains               39240   9
 ide-cd                 30112   1 (autoclean)
 cdrom                  31968   0 (autoclean) [ide-cd]
 nls_iso8859-1           3488   3 (autoclean)
 ntfs                   54720   3 (autoclean)
 usb-uhci               24292   0 (unused)
 usbcore                71104   1 [usb-uhci]
 ext3                   65312   3
 jbd                    47796   3 [ext3]



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
--------------------------------------------------------------------------

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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Radeon VE QY
a000-a01f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  a000-a01f : ne2k-pci
a400-a407 : Promise Technology, Inc. 20265
a800-a803 : Promise Technology, Inc. 20265
ac00-ac07 : Promise Technology, Inc. 20265
b000-b003 : Promise Technology, Inc. 20265
b400-b43f : Promise Technology, Inc. 20265
  b400-b407 : ide2
  b408-b40f : ide3
  b410-b43f : PDC20265
b800-b80f : VIA Technologies, Inc. Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
bc00-bc1f : VIA Technologies, Inc. UHCI USB
  bc00-bc1f : usb-uhci
c000-c01f : VIA Technologies, Inc. UHCI USB (#2)
  c000-c01f : usb-uhci
c400-c4ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0021a348 : Kernel code
  0021a349-00302dbf : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8367 [KT266]
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e1ffffff : PCI Bus #01
  e1000000-e100ffff : ATI Technologies Inc Radeon VE QY
e3000000-e301ffff : Promise Technology, Inc. 20265
ffff0000-ffffffff : reserved




[7.5.] PCI information ('lspci -vvv' as root)
---------------------------------------------

 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a000 [size=32]

00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a800 [size=4]
        Region 2: I/O ports at ac00 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=64]
        Region 5: Memory at e3000000 (32-bit, non-prefetchable) 
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at bc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0996
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at c400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY 
(prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 4002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

