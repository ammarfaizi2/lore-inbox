Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTKYR0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTKYR0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:26:33 -0500
Received: from mail-gate1.weizmann.ac.il ([132.77.4.148]:61196 "EHLO
	mail-gate1") by vger.kernel.org with ESMTP id S262795AbTKYR0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:26:21 -0500
From: dov@imagic.weizmann.ac.il
Message-Id: <200311251711.hAPHBRfk025794@imagic.weizmann.ac.il>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel freezes when doing adsl communication
Date: Tue, 25 Nov 3 19:11:27 IST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. One line summary of the problem:    

     Kernel freezes when doing ADSL communication

2. Full description of the problem/report:

     While doing communication through my ADSL modem connected to
     ethernet, the kernel suddenly ejects error messages in 
     /var/log/messages. I can usually go on working for another
     minute or so, and after that everything freezes or start to
     behave very strangely. It seems to be related only to some 
     communication programs, e.g. gaim and mplayer seem to trigger
     the problem, whereas other, e.g. ssh, can work for hours without
     a problem.

[3.] Keywords (i.e., modules, networking, kernel):

     networking, kernel

[4.] Kernel version (from /proc/version):

     Linux version 2.4.22-1.2115.nptl (bhcompile@daffy.perf.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 Wed Oct 29 15:42:51 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

     N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

     The problem is triggered by running certain communications programs
     like e.g. gaim or mplayer. Just doing ssh seem to be find...

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

    Linux homebox 2.4.22-1.2115.nptl #1 Wed Oct 29 15:42:51 EST 2003 i686 i686 i386 GNU/Linux
     
    Gnu C                  3.3.2
    Gnu make               3.79.1
    util-linux             2.11y
    mount                  2.11y
    modutils               2.4.25
    e2fsprogs              1.34
    jfsutils               1.1.3
    reiserfsprogs          3.6.8
    pcmcia-cs              3.1.31
    quota-tools            3.06.
    PPP                    2.4.1
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 2.0.17
    Net-tools              1.60
    Kbd                    1.08
    Sh-utils               5.0
    Modules Loaded         ppp_synctty ppp_async ppp_generic slhc dmfe es1371 ac97_codec gameport soundcore autofs ipt_REJECT iptable_filter ip_tables floppy sg sr_mod microcode ide-scsi scsi_mod ide-cd cdrom loop nls_iso8859-1 nls_cp437 vfat fat keybdev mousedev hid input usb-uhci usbcore ext3 jbd
    
[7.2.] Processor information (from /proc/cpuinfo):

    processor       : 0
    vendor_id       : GenuineIntel
    cpu family      : 6
    model           : 8
    model name      : Pentium III (Coppermine)
    stepping        : 6
    cpu MHz         : 797.428
    cache size      : 256 KB
    fdiv_bug        : no
    hlt_bug         : no
    f00f_bug        : no
    coma_bug        : no
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 2
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
    bogomips        : 1592.52
        
[7.3.] Module information (from /proc/modules):

    ppp_synctty             7936   0 (unused)
    ppp_async               9472   1
    ppp_generic            24476   3 [ppp_synctty ppp_async]
    slhc                    6756   0 [ppp_generic]
    dmfe                   15841   1 (autoclean)
    es1371                 29832   1 (autoclean)
    ac97_codec             17192   0 (autoclean) [es1371]
    gameport                3380   0 (autoclean) [es1371]
    soundcore               6468   4 (autoclean) [es1371]
    autofs                 13364   0 (autoclean) (unused)
    ipt_REJECT              4344   6 (autoclean)
    iptable_filter          2444   1 (autoclean)
    ip_tables              15776   2 [ipt_REJECT iptable_filter]
    floppy                 58012   0 (autoclean)
    sg                     36492   0 (autoclean)
    sr_mod                 18168   0 (autoclean)
    microcode               4700   0 (autoclean)
    ide-scsi               12208   0
    scsi_mod              108168   3 [sg sr_mod ide-scsi]
    ide-cd                 35776   0
    cdrom                  33728   0 [sr_mod ide-cd]
    loop                   12472   9 (autoclean)
    nls_iso8859-1           3516   4 (autoclean)
    nls_cp437               5148   1 (autoclean)
    vfat                   13036   1 (autoclean)
    fat                    38872   0 (autoclean) [vfat]
    keybdev                 2976   0 (unused)
    mousedev                5556   0 (unused)
    hid                    24708   0 (unused)
    input                   5888   0 [keybdev mousedev hid]
    usb-uhci               26380   0 (unused)
    usbcore                79168   2 [hid usb-uhci]
    ext3                   71300   2
    jbd                    52084   2 [ext3]
    
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
    03c0-03df : vga+
    03f6-03f6 : ide0
    03f8-03ff : serial(auto)
    0cf8-0cff : PCI conf1
    d800-d8ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
      d800-d8ff : dmfe
    df00-df3f : Ensoniq ES1371 [AudioPCI-97]
      df00-df3f : es1371
    ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
      ef40-ef5f : usb-uhci
    ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
      ef80-ef9f : usb-uhci
    efa0-efaf : Intel Corp. 82801BA/BAM SMBus
    ffa0-ffaf : Intel Corp. 82801BA IDE U100
      ffa0-ffa7 : ide0
      ffa8-ffaf : ide1
    
    00000000-0009fbff : System RAM
    0009fc00-0009ffff : reserved
    000a0000-000bffff : Video RAM area
    000c0000-000c7fff : Video ROM
    000f0000-000fffff : System ROM
    00100000-0bfbffff : System RAM
      00100000-00277f10 : Kernel code
      00277f11-0038d8a7 : Kernel data
    0bfc0000-0bff7fff : ACPI Tables
    0bff8000-0bffffff : ACPI Non-volatile Storage
    e4700000-f47fffff : PCI Bus #02
      e8000000-efffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
    f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
    fc9fec00-fc9fecff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
      fc9fec00-fc9fecff : dmfe
    fca00000-feafffff : PCI Bus #02
      fd000000-fdffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
    ffb80000-ffbfffff : reserved
    fff00000-ffffffff : reserved
    
[7.5.] PCI information ('lspci -vvv' as root)

    00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
            Latency: 0
            Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
            Capabilities: [88] #09 [f104]
            Capabilities: [a0] AGP version 2.0
                    Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                    Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
    
    00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64
            Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
            I/O behind bridge: 0000f000-00000fff
            Memory behind bridge: fca00000-feafffff
            Prefetchable memory behind bridge: e4700000-f47fffff
            BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
    
    00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 02) (prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
            I/O behind bridge: 0000d000-0000dfff
            Memory behind bridge: fc900000-fc9fffff
            Prefetchable memory behind bridge: e4600000-e46fffff
            BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    
    00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
            Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
    
    00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02) (prog-if 80 [Master])
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Region 4: I/O ports at ffa0 [size=16]
    
    00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Interrupt: pin D routed to IRQ 11
            Region 4: I/O ports at ef40 [size=32]
    
    00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Interrupt: pin B routed to IRQ 10
            Region 4: I/O ports at efa0 [size=16]
    
    00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Interrupt: pin C routed to IRQ 9
            Region 4: I/O ports at ef80 [size=32]
    
    01:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (3000ns min, 32000ns max)
            Interrupt: pin A routed to IRQ 10
            Region 0: I/O ports at df00 [size=64]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    01:0b.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
            Subsystem: Unknown device 3030:5032
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
            Latency: 64 (5000ns min, 10000ns max)
            Interrupt: pin A routed to IRQ 9
            Region 0: I/O ports at d800 [size=256]
            Region 1: Memory at fc9fec00 (32-bit, non-prefetchable) [size=256]
            Expansion ROM at fc980000 [disabled] [size=256K]
            Capabilities: [50] Power Management version 1
                    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    
    02:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1) (prog-if 00 [VGA])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (1250ns min, 250ns max)
            Interrupt: pin A routed to IRQ 11
            Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
            Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
            Expansion ROM at feaf0000 [disabled] [size=64K]
            Capabilities: [60] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
            Capabilities: [44] AGP version 2.0
                    Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
                    Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

    Attached devices: 
    Host: scsi0 Channel: 00 Id: 00 Lun: 00
      Vendor: CREATIVE Model: CD-RW RW3260E    Rev: E110
      Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
     
The following is written to /var/log/messages when the memory
corruption occurs:

    Nov 25 19:00:04 homebox kernel: ------------[ cut here ]------------
    Nov 25 19:00:04 homebox kernel: kernel BUG at page_alloc.c:195!
    Nov 25 19:00:04 homebox kernel: invalid operand: 0000
    Nov 25 19:00:04 homebox kernel: ppp_synctty ppp_async ppp_generic slhc dmfe es1371 ac97_codec gameport soundcore autofs ipt_REJECT iptable_filter ip_tables floppy sg sr_mod microcode ide-scs
    Nov 25 19:00:04 homebox kernel: CPU:    0
    Nov 25 19:00:04 homebox kernel: EIP:    0060:[<c013d265>]    Not tainted
    Nov 25 19:00:04 homebox kernel: EFLAGS: 00010082
    Nov 25 19:00:04 homebox kernel: 
    Nov 25 19:00:04 homebox kernel: EIP is at rmqueue [kernel] 0x1b5 (2.4.22-1.2115.nptl)
    Nov 25 19:00:04 homebox kernel: eax: 000000cd   ebx: c10005f0   ecx: 00000000   edx: 0000001f
    Nov 25 19:00:04 homebox kernel: esi: c034a9e0   edi: c034a9f4   ebp: 00001000   esp: c2ffbea4
    Nov 25 19:00:04 homebox kernel: ds: 0068   es: 0068   ss: 0068
    Nov 25 19:00:04 homebox kernel: Process up2date (pid: 1196, stackpage=c2ffb000)
    Nov 25 19:00:04 homebox kernel: Stack: 00000000 c1000320 c2ffbeb8 0000001f 00000292 00000000 c034a9e0 c034ac18 
    Nov 25 19:00:04 homebox kernel:        0000023f c9cc29b4 00000000 c013d55b c1001820 c034aa90 c034ac10 000001d2 
    Nov 25 19:00:04 homebox kernel:        00000000 cbf10540 00000000 c9cc29b4 00000470 c01357ef c2ffbf6c c1001820 
    Nov 25 19:00:04 homebox kernel: Call Trace:   [<c013d55b>] __alloc_pages [kernel] 0x4b (0xc2ffbed0)
    Nov 25 19:00:04 homebox kernel: [<c01357ef>] do_generic_file_read [kernel] 0x35f (0xc2ffbef8)
    Nov 25 19:00:04 homebox kernel: [<c0135c10>] file_read_actor [kernel] 0x0 (0xc2ffbf20)
    Nov 25 19:00:04 homebox kernel: [<c0135dad>] generic_file_read [kernel] 0xbd (0xc2ffbf40)
    Nov 25 19:00:04 homebox kernel: [<c0135c10>] file_read_actor [kernel] 0x0 (0xc2ffbf50)
    Nov 25 19:00:04 homebox kernel: [<c0133a2e>] do_munmap [kernel] 0x2be (0xc2ffbf58)
    Nov 25 19:00:04 homebox kernel: [<c0145936>] sys_pread [kernel] 0xc6 (0xc2ffbf8c)
    Nov 25 19:00:04 homebox kernel: [<c0133aaa>] sys_munmap [kernel] 0x4a (0xc2ffbfa4)
    Nov 25 19:00:04 homebox kernel: [<c0109b9f>] system_call [kernel] 0x33 (0xc2ffbfc0)
    Nov 25 19:00:04 homebox kernel: 
    Nov 25 19:00:04 homebox kernel: 
    Nov 25 19:00:04 homebox kernel: Code: 0f 0b c3 00 dd 9d 28 c0 ff 74 24 10 9d c7 43 14 01 00 00 00 
        

And as I said in the beginning, when this occurs the only thing I can
do is to do a soft reboot. Any help is extremely appreciated!

Thanks in advance!
--
                                                        ___   ___
                                                      /  o  \   o \
Dov Grobgeld                                         ( o  o  ) o   |
The Weizmann Institute of Science, Israel             \  o  /o  o /
"Where the tree of wisdom carries oranges"              | |   | |
                                                       _| |_ _| |_

