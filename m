Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTAJIRR>; Fri, 10 Jan 2003 03:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbTAJIRR>; Fri, 10 Jan 2003 03:17:17 -0500
Received: from cassius.its.unimelb.edu.au ([128.250.6.200]:14 "EHLO
	cassius.its.unimelb.edu.au") by vger.kernel.org with ESMTP
	id <S264610AbTAJIRM>; Fri, 10 Jan 2003 03:17:12 -0500
Message-Id: <200301100825.TAA17664@cassius.its.unimelb.edu.au>
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
X-Mailer: MIME-tools 4.104 (Entity 4.117)
From: t.widjaja1@ugrad.unimelb.edu.au
Date: Fri, 10 Jan 2003 19:25:54 +1100
To: linux-kernel@vger.kernel.org
Subject: Problem:  kernel BUG at page_alloc.c:217!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the message in /var/log/syslog

---------------------- start /var/log/syslog -----------------------------------

Jan 10 18:15:49 Widjaja kernel: kernel BUG at page_alloc.c:217!
Jan 10 18:15:49 Widjaja kernel: invalid operand: 0000
Jan 10 18:15:49 Widjaja kernel: CPU:    0
Jan 10 18:15:49 Widjaja kernel: EIP:    0010:[<c012be40>]    Tainted: P
Jan 10 18:15:49 Widjaja kernel: EFLAGS: 00010092
Jan 10 18:15:49 Widjaja kernel: eax: 0001fffc   ebx: c12903a4   ecx: 00001000   edx: f45e05e6
Jan 10 18:15:49 Widjaja kernel: esi: c12903a4   edi: 00000000   ebp: c0272a14   esp: da1f1eb8
Jan 10 18:15:49 Widjaja kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 18:15:49 Widjaja kernel: Process wvdial (pid: 353, stackpage=da1f1000)
Jan 10 18:15:49 Widjaja kernel: Stack: c0272b80 000001ff da1889c0 00000000 00001000 0000f5e6 00000292 c0272a2c
Jan 10 18:15:49 Widjaja kernel:        00000000 c0272a14 c012c220 000001f0 da1f1f6c da1889c0 da596f00 c0272a14
Jan 10 18:15:49 Widjaja kernel:        c0272b7c 000001f0 00000000 c012c016 00000000 c012c34a c013ebb3 da3ff540
Jan 10 18:15:49 Widjaja kernel: Call Trace:    [<c012c220>] [<c012c016>] [<c012c34a>] [<c013ebb3>] [<c0139bd6>]
Jan 10 18:15:49 Widjaja kernel:   [<c013eda6>] [<c013f1fa>] [<c0106d03>]
Jan 10 18:15:49 Widjaja kernel:
Jan 10 18:15:49 Widjaja kernel: Code: 0f 0b d9 00 13 3a 23 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03
Jan 10 18:15:49 Widjaja kernel:  kernel BUG at page_alloc.c:217!
Jan 10 18:15:49 Widjaja kernel: invalid operand: 0000
Jan 10 18:15:49 Widjaja kernel: CPU:    0
Jan 10 18:15:49 Widjaja kernel: EIP:    0010:[<c012be40>]    Tainted: P
Jan 10 18:15:49 Widjaja kernel: EFLAGS: 00010096
Jan 10 18:15:49 Widjaja kernel: eax: 0001fffc   ebx: c1527d38   ecx: 00001000   edx: f45ef735
Jan 10 18:15:49 Widjaja kernel: esi: c1527d38   edi: 00000000   ebp: c0272a14   esp: dc9d5ea8
Jan 10 18:15:49 Widjaja kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 18:15:49 Widjaja kernel: Process kdeinit (pid: 314, stackpage=dc9d5000)
Jan 10 18:15:49 Widjaja kernel: Stack: c0272b80 000001ff dc819640 00000000 c012302f df6d5840 00000296 c0272a2c
Jan 10 18:15:49 Widjaja kernel:        00000000 c0272a14 c012c220 000001f0 dc9d5f6c dc819640 dca603fc c0272a14
Jan 10 18:15:49 Widjaja kernel:        c0272b7c 000001f0 00000001 c012c016 00000000 c012c34a c013ebb3 dc806e80
Jan 10 18:15:49 Widjaja kernel: Call Trace:    [<c012302f>] [<c012c220>] [<c012c016>] [<c012c34a>] [<c013ebb3>]
Jan 10 18:15:49 Widjaja kernel:   [<c021b783>] [<c01e1ef3>] [<c013eda6>] [<c013f1fa>] [<c0106d03>]
Jan 10 18:15:49 Widjaja kernel:
Jan 10 18:15:49 Widjaja kernel: Code: 0f 0b d9 00 13 3a 23 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03
Jan 10 18:16:05 Widjaja kernel:  kernel BUG at page_alloc.c:217!
Jan 10 18:16:05 Widjaja kernel: invalid operand: 0000
Jan 10 18:16:05 Widjaja kernel: CPU:    0
Jan 10 18:16:05 Widjaja kernel: EIP:    0010:[<c012be40>]    Tainted: P
Jan 10 18:16:05 Widjaja kernel: EFLAGS: 00013096
Jan 10 18:16:05 Widjaja kernel: eax: 0001fffc   ebx: c1527d38   ecx: 00001000   edx: f45ef735
Jan 10 18:16:05 Widjaja kernel: esi: c1527d38   edi: 00000000   ebp: c0272a14   esp: dec8de50
Jan 10 18:16:05 Widjaja kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 18:16:05 Widjaja kernel: Process XFree86 (pid: 254, stackpage=dec8d000)
Jan 10 18:16:05 Widjaja kernel: Stack: c0272ba0 000001ff dfe44740 00000000 e1a716ec 0001ba89 00003286 c0272a2c
Jan 10 18:16:05 Widjaja kernel:        00000000 c0272a14 c012c220 000001d2 dfe44740 dfe44740 da165ec0 c0272a14
Jan 10 18:16:05 Widjaja kdm[242]: Server for display :0 terminated unexpectedly
Jan 10 18:16:05 Widjaja kernel:        c0272b9c 000001d2 c0227ac6 c012c016 00104025 c0122f54 498d3000 dfe44740
Jan 10 18:16:05 Widjaja kernel: Call Trace:    [<c012c220>] [<c0227ac6>] [<c012c016>] [<c0122f54>] [<c012302f>]
Jan 10 18:16:05 Widjaja kernel:   [<c01231c2>] [<c0111d83>] [<c0111c20>] [<e19814a4>] [<e1b633bb>] [<e1b610f5>]
Jan 10 18:16:05 Widjaja kernel:   [<c010b6dd>] [<e1b610e0>] [<e1b610e0>] [<c010816f>] [<c010a6a8>] [<c010830c>]
Jan 10 18:16:05 Widjaja kernel:   [<c0106df4>]
Jan 10 18:16:05 Widjaja kernel:
Jan 10 18:16:05 Widjaja kernel: Code: 0f 0b d9 00 13 3a 23 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03
Jan 10 18:16:05 Widjaja kernel:  kernel BUG at page_alloc.c:217!
Jan 10 18:16:05 Widjaja kernel: invalid operand: 0000
Jan 10 18:16:05 Widjaja kernel: CPU:    0
Jan 10 18:16:05 Widjaja kernel: EIP:    0010:[<c012be40>]    Tainted: P
Jan 10 18:16:05 Widjaja kernel: EFLAGS: 00013082
Jan 10 18:16:05 Widjaja kernel: eax: 0001fffc   ebx: c0232a2c   ecx: 00001000   edx: ee869e0c
Jan 10 18:16:05 Widjaja kernel: esi: c0232a2c   edi: 00000000   ebp: c0272a14   esp: dead5e50
Jan 10 18:16:05 Widjaja kernel: ds: 0018   es: 0018   ss: 0018
Jan 10 18:16:05 Widjaja kernel: Process XFree86 (pid: 1140, stackpage=dead5000)
Jan 10 18:16:05 Widjaja kernel: Stack: c0272ba0 000001ff dfe44c80 00000000 e1a716ec 0001baae 00003286 c0272a2c
Jan 10 18:16:05 Widjaja kernel:        00000000 c0272a14 c012c220 000001d2 dfe44c80 dfe44c80 df219540 c0272a14
Jan 10 18:16:05 Widjaja kernel:        c0272b9c 000001d2 c0227ac6 c012c016 00104025 c0122f54 082ba044 dfe44c80
Jan 10 18:16:05 Widjaja kernel: Call Trace:    [<c012c220>] [<c0227ac6>] [<c012c016>] [<c0122f54>] [<c012302f>]
Jan 10 18:16:05 Widjaja kernel:   [<c01231c2>] [<c0111d83>] [<c0111c20>] [<c0125ce3>] [<c012601f>] [<c0125f10>]
Jan 10 18:16:05 Widjaja kernel:   [<c0131b07>] [<c0106df4>]

Jan 10 18:16:05 Widjaja kernel: Code: 0f 0b d9 00 13 3a 23 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03

------------------------ end /var/log/syslog -----------------------------------

This problem often arose when I was running konqueror and wvdial.
Similar things happened when I was running ssh (on X) and wvdial.
But, I have to say that this happens intermittently.

Here is the output of scripts/ver_linux for my system:

Linux Widjaja 2.4.20 #4 Mon Jan 6 00:22:22 EST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
jfsutils               1.0.14
reiserfsprogs          3.x.1b
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate zlib_inflate zlib_deflate ppp_async hsfbasic2 hsfserial hsfengine hsfosspec NVdriver mousedev usbmouse hid input slip dummy bsd_comp rtc

Now, /proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 2000+
stepping        : 2
cpu MHz         : 1687.552
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3368.55

Now, /proc/iomem:

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-0022c50a : Kernel code
  0022c50b-002a9dd7 : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
d8000000-d800ffff : Rockwell International HCF 56k Data/Fax/Voice/Spkp (w/Handset) Modem
d8800000-d88000ff : VIA Technologies, Inc. USB 2.0
d9000000-d9003fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
d9800000-d98007ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
da000000-db6fffff : PCI Bus #01
  da000000-daffffff : nVidia Corporation NV17 [GeForce4 MX420]
db700000-dfffffff : PCI Bus #01
  db800000-db87ffff : nVidia Corporation NV17 [GeForce4 MX420]
  dc000000-dfffffff : nVidia Corporation NV17 [GeForce4 MX420]
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

Now, the result of 'lspci -vvv':

-------------------- start 'lspci -vvv' ----------------------------------------

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: Asustek Computer, Inc.: Unknown device 807f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: da000000-db6fffff
        Prefetchable memory behind bridge: db700000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023 (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808d
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 35 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d9800000 (32-bit, non-prefetchable) [disabled] [size=2K]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable) [disabled] [size=16K]
Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51) (prog-if 20)
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 5
        Region 0: Memory at d8800000 (32-bit, non-prefetchable) [disabled] [siCapabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Communication controller: Rockwell International HCF 56k Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01)
        Subsystem: Rockwell International HCF 56k Data/Fax/Voice/Spkp (w/Handset) Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d8000000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at d000 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)ze=256]
Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b400 [disabled] [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UH
CI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0172 (rev
a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 805b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at db800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at db7e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>
------------------ end 'lspci -vvv' --------------------------------------------

In addition, I'm running no SCSi device.
One additional information that may be useful:
1. This bug occured in 2.4.18 very often (almost always). It seems that
   this problem arises less often in 2.4.20.
2. It seems that the problem does not show up when X is not running.
3. The problem occurs when I'm connected to the internet (then again,
   this happens sporadically).
4. This may be due to NVidia driver because I often get:
   "no MTRR found in e000... e000..." when X is killed (and NVidia driver
   being loaded then).

Hope this can be fixed soon :-)

Thanks in advance,

Anthony

-- 
t.widjaja1@ugrad.unimelb.edu.au
