Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031510AbWLANqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031510AbWLANqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031514AbWLANqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:46:25 -0500
Received: from mra01.ch.as12513.net ([82.153.254.69]:35480 "EHLO
	mra01.ch.as12513.net") by vger.kernel.org with ESMTP
	id S1031510AbWLANqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:46:22 -0500
Message-ID: <45703223.7030000@hi.eclipse.co.uk>
Date: Fri, 01 Dec 2006 13:46:11 +0000
From: =?ISO-8859-1?Q?Per_B=F6rjesson?= <sky@hi.eclipse.co.uk>
Reply-To: sky@hi.eclipse.co.uk
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: "PCI: Bus #03 (-#06) is hidden behind transparent bridge
 #01 (-#03)"
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020505060907060409020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020505060907060409020202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I'm sending this because the kernel message said I should :)


[1.] PCI: Bus #03 (-#06) is hidden behind transparent bridge #01 (-#03)
[2.] I recently compiled 2.6.18.3 for my laptop, and when I inspected the logs I found this:

     Nov 27 14:46:41 m03r21a2905 kernel: PCI: Bus #03 (-#06) is hidden behind transparent bridge #01 (-#03) (try 'pci=assign-busses')
     Nov 27 14:46:41 m03r21a2905 kernel: Please report the result to linux-kernel to fix this permanently

     OK, so I added

       append="pci=assign-busses"

     in lilo.conf and now I see:

     Nov 27 14:59:09 m03r21a2905 kernel: PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0


[3.] Keywords (i.e., modules, networking, kernel): PCI Bus
[4.] linux-2.6.18.3 11% cat /proc/version
     Linux version 2.6.18.3 (perbo@cosmos) (gcc version 3.4.6) #1 SMP Mon Nov 20 01:29:03 GMT 2006

[5.] Most recent kernel version which did not have the bug: N/A
[6.] Output of Oops.. message: N/A
[7.] A small shell script or example program: N/A
[8.] Environment
[8.1.] Output from scripts/ver_linux:
      linux-2.6.18.3 4% sh scripts/ver_linux
      If some fields are empty or look unusual you may have an old version.
      Compare to the current minimal requirements in Documentation/Changes.

      Linux m03r21a2905 2.6.18.3 #1 SMP Mon Nov 20 01:29:03 GMT 2006 i686 i686 i386 GNU/Linux

      Gnu C                  3.4.6
      Gnu make               3.81
      binutils               2.15.92.0.2
      util-linux             2.12r
      mount                  2.12r
      module-init-tools      3.2.2
      e2fsprogs              1.38
      jfsutils               1.1.11
      reiserfsprogs          3.6.19
      xfsprogs               2.8.10
      pcmcia-cs              3.2.8
      quota-tools            3.13.
      PPP                    2.4.4b1
      Linux C Library        2.3.6
      Dynamic linker (ldd)   2.3.6
      Linux C++ Library      6.0.3
      Procps                 3.2.7
      Net-tools              1.60
      Kbd                    1.12
      Sh-utils               5.97
      udev                   097
      Modules Loaded         nfs lockd sunrpc snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss ipv6
cm4000_cs usbhid pcmcia usb_storage snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm yenta_socket intel_agp rsrc_nonstatic snd_timer snd_page_alloc
agpgart pcmcia_core ehci_hcd uhci_hcd

[8.2.] Processor information (from /proc/cpuinfo):
       linux-2.6.18.3 5% cat /proc/cpuinfo
       processor       : 0
       vendor_id       : GenuineIntel
       cpu family      : 6
       model           : 9
       model name      : Intel(R) Pentium(R) M processor 1400MHz
       stepping        : 5
       cpu MHz         : 1400.002
       cache size      : 1024 KB
       fdiv_bug        : no
       hlt_bug         : no
       f00f_bug        : no
       coma_bug        : no
       fpu             : yes
       fpu_exception   : yes
       cpuid level     : 2
       wp              : yes
       flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe up est tm2
       bogomips        : 2801.73

[8.3.] Module information (from /proc/modules):
       linux-2.6.18.3 6% cat /proc/modules
       nfs 118064 1 - Live 0xe0439000
       lockd 64456 2 nfs, Live 0xe03c3000
       sunrpc 157884 3 nfs,lockd, Live 0xe03ee000
       snd_seq_dummy 3972 0 - Live 0xe026a000
       snd_seq_oss 35520 0 - Live 0xe02da000
       snd_seq_midi_event 7488 1 snd_seq_oss, Live 0xe023e000
       snd_seq 53584 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xe02b2000
       snd_seq_device 8588 3 snd_seq_dummy,snd_seq_oss,snd_seq, Live 0xe0266000
       snd_pcm_oss 47584 0 - Live 0xe02c1000
       snd_mixer_oss 17856 1 snd_pcm_oss, Live 0xe029e000
       ipv6 262944 12 - Live 0xe0381000
       cm4000_cs 18136 1 - Live 0xe0298000
       usbhid 42272 0 - Live 0xe02a6000
       pcmcia 37628 1 cm4000_cs, Live 0xe0275000
       usb_storage 28932 0 - Live 0xe026c000
       snd_intel8x0 33500 0 - Live 0xe0241000
       snd_ac97_codec 92064 1 snd_intel8x0, Live 0xe0280000
       snd_ac97_bus 2368 1 snd_ac97_codec, Live 0xe0233000
       snd_pcm 82948 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xe024c000
       yenta_socket 27404 4 - Live 0xe021b000
       intel_agp 22556 1 - Live 0xe022c000
       rsrc_nonstatic 13568 1 yenta_socket, Live 0xe0201000
       snd_timer 25092 2 snd_seq,snd_pcm, Live 0xe0224000
       snd_page_alloc 10376 2 snd_intel8x0,snd_pcm, Live 0xe0206000
       agpgart 34824 2 intel_agp, Live 0xe0072000
       pcmcia_core 42068 4 cm4000_cs,pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe020f000
       ehci_hcd 31624 0 - Live 0xe0060000
       uhci_hcd 24524 0 - Live 0xe0069000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
       linux-2.6.18.3 7% cat /proc/ioports
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
       03c0-03df : vesafb
       03f6-03f6 : ide0
       03f8-03ff : serial
       0cf8-0cff : PCI conf1
       1000-10ff : PCI CardBus #06
       1800-1807 : 0000:00:02.0
       1810-181f : 0000:00:1f.1
         1810-1817 : ide0
         1818-181f : ide1
       1820-183f : 0000:00:1d.0
         1820-183f : uhci_hcd
       1840-185f : 0000:00:1d.1
         1840-185f : uhci_hcd
       1860-187f : 0000:00:1d.2
         1860-187f : uhci_hcd
       1880-189f : 0000:00:1f.3
         1880-189f : i801_smbus
       18c0-18ff : 0000:00:1f.5
         18c0-18ff : Intel 82801DB-ICH4
       1c00-1cff : 0000:00:1f.5
         1c00-1cff : Intel 82801DB-ICH4
       2000-207f : 0000:00:1f.6
       2400-24ff : 0000:00:1f.6
       3000-3fff : PCI Bus #01
         3000-30ff : 0000:01:0c.0
           3000-30ff : 8139too
         32a0-32a8 : pcmcia_socket0
         3400-34ff : PCI CardBus #02
         3800-38ff : PCI CardBus #02
         3c00-3cff : PCI CardBus #06
       f800-f87f : motherboard
       f880-f8ff : motherboard
       fc00-fc7f : 0000:00:1f.0
         fc00-fc7f : motherboard
           fc00-fc03 : ACPI PM1a_EVT_BLK
           fc04-fc05 : ACPI PM1a_CNT_BLK
           fc08-fc0b : ACPI PM_TMR
           fc10-fc15 : ACPI CPU throttle
           fc20-fc20 : ACPI PM2_CNT_BLK
           fc28-fc2f : ACPI GPE0_BLK
       fc80-fcbf : 0000:00:1f.0
         fc80-fcbf : motherboard
       fd00-fd6f : motherboard
       fe00-fe01 : motherboard

       linux-2.6.18.3 8% cat /proc/iomem
       00000000-0009f7ff : System RAM
       0009f800-0009ffff : reserved
       000a0000-000bffff : Video RAM area
       000c0000-000ccbff : Video ROM
       000cd000-000cdfff : Adapter ROM
       000ce000-000cffff : reserved
       000f0000-000fffff : System ROM
       00100000-1f6effff : System RAM
         00100000-0036d7d6 : Kernel code
         0036d7d7-004456a3 : Kernel data
       1f6f0000-1f6f7fff : ACPI Tables
       1f6f8000-1f6fffff : ACPI Non-volatile Storage
       1f700000-1fffffff : reserved
       30000000-33ffffff : PCI Bus #01
         30000000-31ffffff : PCI CardBus #02
         32000000-33ffffff : PCI CardBus #06
       34000000-340003ff : 0000:00:1f.1
       36000000-37ffffff : PCI CardBus #02
       38000000-39ffffff : PCI CardBus #06
       d0000000-d007ffff : 0000:00:02.0
       d0080000-d00fffff : 0000:00:02.1
       d0100000-d01003ff : 0000:00:1d.7
         d0100000-d01003ff : ehci_hcd
       d0100800-d01008ff : 0000:00:1f.5
         d0100800-d01008ff : Intel 82801DB-ICH4
       d0100c00-d0100dff : 0000:00:1f.5
         d0100c00-d0100dff : Intel 82801DB-ICH4
       d0200000-d02fffff : PCI Bus #01
         d0200000-d02000ff : 0000:01:0c.0
           d0200000-d02000ff : 8139too
         d0201000-d0201fff : 0000:01:0a.0
           d0201000-d0201fff : yenta_socket
         d0202000-d0202fff : 0000:01:0a.1
           d0202000-d0202fff : yenta_socket
         d0210000-d0210fff : pcmcia_socket0
       d8000000-dfffffff : 0000:00:02.0
         d8000000-d87cffff : vesafb
       e0000000-e7ffffff : 0000:00:02.1
       fec10000-fec1ffff : reserved
       ffb00000-ffbfffff : reserved
       fff00000-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)
       linux-2.6.18.3 9% lspci -vvv
       00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
               Subsystem: Fujitsu Limited. Unknown device 11d5
               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
               Latency: 0
               Region 0: Memory at <unassigned> (32-bit, prefetchable)
               Capabilities: [40] Vendor Specific Information

       00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
               Subsystem: Fujitsu Limited. Unknown device 11d5
               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0

       00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
               Subsystem: Fujitsu Limited. Unknown device 11d5
               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0

       00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
               Subsystem: Fujitsu Limited. Unknown device 120e
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin A routed to IRQ 11
               Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
               Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
               Region 2: I/O ports at 1800 [size=8]
               Capabilities: [d0] Power Management version 1
                       Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-

       00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
               Subsystem: Fujitsu Limited. Unknown device 120e
               Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
               Region 1: Memory at d0080000 (32-bit, non-prefetchable) [size=512K]
               Capabilities: [d0] Power Management version 1
                       Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-

       00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin A routed to IRQ 11
               Region 4: I/O ports at 1820 [size=32]

       00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin B routed to IRQ 11
               Region 4: I/O ports at 1840 [size=32]

       00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin C routed to IRQ 11
               Region 4: I/O ports at 1860 [size=32]

       00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin D routed to IRQ 11
               Region 0: Memory at d0100000 (32-bit, non-prefetchable) [size=1K]
               Capabilities: [50] Power Management version 2
                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
               Capabilities: [58] Debug port

       00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83) (prog-if 00 [Normal decode])
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
               Latency: 0
               Bus: primary=00, secondary=01, subordinate=09, sec-latency=64
               I/O behind bridge: 00003000-00003fff
               Memory behind bridge: d0200000-d02fffff
               Prefetchable memory behind bridge: 30000000-33ffffff
               Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
               BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

       00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
               Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0

       00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin A routed to IRQ 11
               Region 0: I/O ports at <unassigned>
               Region 1: I/O ports at <unassigned>
               Region 2: I/O ports at <unassigned>
               Region 3: I/O ports at <unassigned>
               Region 4: I/O ports at 1810 [size=16]
               Region 5: Memory at 34000000 (32-bit, non-prefetchable) [size=1K]

       00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
               Subsystem: Fujitsu Limited. Unknown device 11ab
               Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Interrupt: pin B routed to IRQ 11
               Region 4: I/O ports at 1880 [size=32]

       00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
               Subsystem: Fujitsu Limited. Unknown device 11c3
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 0
               Interrupt: pin B routed to IRQ 11
               Region 0: I/O ports at 1c00 [size=256]
               Region 1: I/O ports at 18c0 [size=64]
               Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
               Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
               Capabilities: [50] Power Management version 2
                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-

       00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
               Subsystem: Fujitsu Limited. Unknown device 10d1
               Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Interrupt: pin B routed to IRQ 11
               Region 0: I/O ports at 2400 [disabled] [size=256]
               Region 1: I/O ports at 2000 [disabled] [size=128]
               Capabilities: [50] Power Management version 2
                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-

       01:0a.0 CardBus bridge: O2 Micro, Inc. OZ6933/711E1 CardBus/SmartCardBus Controller (rev 20)
               Subsystem: Fujitsu Limited. Unknown device 10e6
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 168
               Interrupt: pin A routed to IRQ 11
               Region 0: Memory at d0201000 (32-bit, non-prefetchable) [size=4K]
               Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
               Memory window 0: 30000000-31fff000 (prefetchable)
               Memory window 1: 36000000-37fff000
               I/O window 0: 00003400-000034ff
               I/O window 1: 00003800-000038ff
               BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
               16-bit legacy interface ports at 0001

       01:0a.1 CardBus bridge: O2 Micro, Inc. OZ6933/711E1 CardBus/SmartCardBus Controller (rev 20)
               Subsystem: Fujitsu Limited. Unknown device 10e6
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 168
               Interrupt: pin B routed to IRQ 11
               Region 0: Memory at d0202000 (32-bit, non-prefetchable) [size=4K]
               Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
               Memory window 0: 32000000-33fff000 (prefetchable)
               Memory window 1: 38000000-39fff000
               I/O window 0: 00003c00-00003cff
               I/O window 1: 00001000-000010ff
               BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
               16-bit legacy interface ports at 0001

       01:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
               Subsystem: Fujitsu Limited. Unknown device 11bd
               Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
               Latency: 64 (8000ns min, 16000ns max)
               Interrupt: pin A routed to IRQ 11
               Region 0: I/O ports at 3000 [size=256]
               Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=256]
               Capabilities: [50] Power Management version 2
                       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                       Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[8.6.] SCSI information (from /proc/scsi/scsi)
       linux-2.6.18.3 10% cat /proc/scsi/scsi
       Attached devices:
       Host: scsi1 Channel: 00 Id: 00 Lun: 00
         Vendor: NEC      Model: USB UF000x       Rev: 1.50
         Type:   Direct-Access                    ANSI SCSI revision: 02

[8.7.] Other information that might be relevant to the problem

       I have attached .config used to compile the kernel and also a copy of /var/log/syslog
       with boot messages before and after the "append message".


Regards
Per Börjesson


--------------020505060907060409020202
Content-Type: text/plain;
 name="config.m03r21a2905"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.m03r21a2905"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.18.3
# Mon Nov 20 01:20:44 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CPUSETS=y
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_NR_CPUS=2
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
# CONFIG_IP_NF_MATCH_AH is not set
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=m
# CONFIG_IRNET is not set
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_VIA_FIR is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=32
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
# CONFIG_NET_FC is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_I8XX_TCO=m
# CONFIG_SC1200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y

#
# TPM devices
#

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
CONFIG_SPI=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#

#
# SPI Protocol Masters
#

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=128
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_7x14=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y
CONFIG_FONT_10x18=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_LIBUSUAL=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m

#
# LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_IDE_DISK=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
CONFIG_INTEL_IOATDMA=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_DEBUG is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_FS is not set
# CONFIG_UNWIND_INFO is not set
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES is not set
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y


--------------020505060907060409020202
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 0000000000100000 - 000000001f6f0000 (usable)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 000000001f6f0000 - 000000001f6f8000 (ACPI data)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 000000001f6f8000 - 000000001f700000 (ACPI NVS)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Nov 27 14:46:41 m03r21a2905 kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dec10000)
Nov 27 14:46:41 m03r21a2905 kernel: Detected 1400.020 MHz processor.
Nov 27 14:46:41 m03r21a2905 kernel: Built 1 zonelists.  Total pages: 128752
Nov 27 14:46:41 m03r21a2905 kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Nov 27 14:46:41 m03r21a2905 kernel: PID hash table entries: 2048 (order: 11, 8192 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: Console: colour dummy device 80x25
Nov 27 14:46:41 m03r21a2905 kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov 27 14:46:41 m03r21a2905 kernel: Calibrating delay using timer specific routine.. 2801.73 BogoMIPS (lpj=5603477)
Nov 27 14:46:41 m03r21a2905 kernel: Mount-cache hash table entries: 512
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: setting ELCR to 0200 (from 0800)
Nov 27 14:46:41 m03r21a2905 kernel: CPU0: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Nov 27 14:46:41 m03r21a2905 kernel: migration_cost=0
Nov 27 14:46:41 m03r21a2905 kernel: Setting up standard PCI resources
Nov 27 14:46:41 m03r21a2905 kernel: PCI quirk: region fc00-fc7f claimed by ICH4 ACPI/GPIO/TCO
Nov 27 14:46:41 m03r21a2905 kernel: PCI quirk: region fc80-fcbf claimed by ICH4 GPIO
Nov 27 14:46:41 m03r21a2905 kernel: PCI: Bus #03 (-#06) is hidden behind transparent bridge #01 (-#03) (try 'pci=assign-busses')
Nov 27 14:46:41 m03r21a2905 kernel: Please report the result to linux-kernel to fix this permanently
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:46:41 m03r21a2905 kernel: intel_rng: FWH not detected
Nov 27 14:46:41 m03r21a2905 kernel: PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
Nov 27 14:46:41 m03r21a2905 kernel: PCI: Bus 2, cardbus bridge: 0000:01:0a.0
Nov 27 14:46:41 m03r21a2905 kernel:   IO window: 00003400-000034ff
Nov 27 14:46:41 m03r21a2905 kernel:   IO window: 00003800-000038ff
Nov 27 14:46:41 m03r21a2905 kernel:   PREFETCH window: 30000000-31ffffff
Nov 27 14:46:41 m03r21a2905 kernel:   MEM window: 36000000-37ffffff
Nov 27 14:46:41 m03r21a2905 kernel: PCI: Bus 3, cardbus bridge: 0000:01:0a.1
Nov 27 14:46:41 m03r21a2905 kernel:   IO window: 00003c00-00003cff
Nov 27 14:46:41 m03r21a2905 kernel:   IO window: 00001000-000010ff
Nov 27 14:46:41 m03r21a2905 kernel:   PREFETCH window: 32000000-33ffffff
Nov 27 14:46:41 m03r21a2905 kernel:   MEM window: 38000000-39ffffff
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Nov 27 14:46:41 m03r21a2905 kernel: fuse init (API version 7.7)
Nov 27 14:46:41 m03r21a2905 kernel: Console: switching to colour frame buffer device 128x48
Nov 27 14:46:41 m03r21a2905 kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Nov 27 14:46:41 m03r21a2905 kernel: Hangcheck: Using get_cycles().
Nov 27 14:46:41 m03r21a2905 kernel: floppy0: no floppy controllers found
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: hda: ST94019A, ATA DISK drive
Nov 27 14:46:41 m03r21a2905 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 27 14:46:41 m03r21a2905 kernel: hdc: TOSHIBA DVD-ROM SD-R2412, ATAPI CD/DVD-ROM drive
Nov 27 14:46:41 m03r21a2905 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 27 14:46:41 m03r21a2905 kernel: ip_conntrack version 2.4 (4023 buckets, 32184 max) - 224 bytes per conntrack
Nov 27 14:46:41 m03r21a2905 kernel: Using IPI Shortcut mode
Nov 27 14:46:41 m03r21a2905 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Nov 27 14:46:41 m03r21a2905 kernel: sda: assuming drive cache: write through
Nov 27 14:46:42 m03r21a2905 kernel: sda: assuming drive cache: write through
Nov 27 14:46:42 m03r21a2905 sshd[1137]: error: Bind to port 7777 on 0.0.0.0 failed: Address already in use.
Nov 27 14:46:42 m03r21a2905 kernel: 
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 0000000000100000 - 000000001f6f0000 (usable)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 000000001f6f0000 - 000000001f6f8000 (ACPI data)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 000000001f6f8000 - 000000001f700000 (ACPI NVS)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Nov 27 14:59:09 m03r21a2905 kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dec10000)
Nov 27 14:59:09 m03r21a2905 kernel: Detected 1400.002 MHz processor.
Nov 27 14:59:09 m03r21a2905 kernel: Built 1 zonelists.  Total pages: 128752
Nov 27 14:59:09 m03r21a2905 kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Nov 27 14:59:09 m03r21a2905 kernel: PID hash table entries: 2048 (order: 11, 8192 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: Console: colour dummy device 80x25
Nov 27 14:59:09 m03r21a2905 kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Nov 27 14:59:09 m03r21a2905 kernel: Calibrating delay using timer specific routine.. 2801.73 BogoMIPS (lpj=5603478)
Nov 27 14:59:09 m03r21a2905 kernel: Mount-cache hash table entries: 512
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: setting ELCR to 0200 (from 0800)
Nov 27 14:59:09 m03r21a2905 kernel: CPU0: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Nov 27 14:59:09 m03r21a2905 kernel: migration_cost=0
Nov 27 14:59:09 m03r21a2905 kernel: Setting up standard PCI resources
Nov 27 14:59:09 m03r21a2905 kernel: PCI quirk: region fc00-fc7f claimed by ICH4 ACPI/GPIO/TCO
Nov 27 14:59:09 m03r21a2905 kernel: PCI quirk: region fc80-fcbf claimed by ICH4 GPIO
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11)
Nov 27 14:59:09 m03r21a2905 kernel: intel_rng: FWH not detected
Nov 27 14:59:09 m03r21a2905 kernel: PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
Nov 27 14:59:09 m03r21a2905 kernel: PCI: Bus 2, cardbus bridge: 0000:01:0a.0
Nov 27 14:59:09 m03r21a2905 kernel:   IO window: 00003400-000034ff
Nov 27 14:59:09 m03r21a2905 kernel:   IO window: 00003800-000038ff
Nov 27 14:59:09 m03r21a2905 kernel:   PREFETCH window: 30000000-31ffffff
Nov 27 14:59:09 m03r21a2905 kernel:   MEM window: 36000000-37ffffff
Nov 27 14:59:09 m03r21a2905 kernel: PCI: Bus 6, cardbus bridge: 0000:01:0a.1
Nov 27 14:59:09 m03r21a2905 kernel:   IO window: 00003c00-00003cff
Nov 27 14:59:09 m03r21a2905 kernel:   IO window: 00001000-000010ff
Nov 27 14:59:09 m03r21a2905 kernel:   PREFETCH window: 32000000-33ffffff
Nov 27 14:59:09 m03r21a2905 kernel:   MEM window: 38000000-39ffffff
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Nov 27 14:59:09 m03r21a2905 kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
Nov 27 14:59:09 m03r21a2905 kernel: fuse init (API version 7.7)
Nov 27 14:59:09 m03r21a2905 kernel: Console: switching to colour frame buffer device 128x48
Nov 27 14:59:09 m03r21a2905 kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Nov 27 14:59:09 m03r21a2905 kernel: Hangcheck: Using get_cycles().
Nov 27 14:59:09 m03r21a2905 kernel: floppy0: no floppy controllers found
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Nov 27 14:59:09 m03r21a2905 kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 27 14:59:09 m03r21a2905 kernel: hda: ST94019A, ATA DISK drive
Nov 27 14:59:09 m03r21a2905 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 27 14:59:09 m03r21a2905 kernel: hdc: TOSHIBA DVD-ROM SD-R2412, ATAPI CD/DVD-ROM drive
Nov 27 14:59:09 m03r21a2905 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 27 14:59:09 m03r21a2905 kernel: ip_conntrack version 2.4 (4023 buckets, 32184 max) - 224 bytes per conntrack
Nov 27 14:59:09 m03r21a2905 kernel: Using IPI Shortcut mode
Nov 27 14:59:09 m03r21a2905 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Nov 27 14:59:09 m03r21a2905 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
Nov 27 14:59:10 m03r21a2905 sshd[1175]: error: Bind to port 7777 on 0.0.0.0 failed: Address already in use.
Nov 27 14:59:11 m03r21a2905 kernel: sda: assuming drive cache: write through
Nov 27 14:59:11 m03r21a2905 kernel: sda: assuming drive cache: write through


--------------020505060907060409020202--
