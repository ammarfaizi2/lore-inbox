Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTHXSWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbTHXSWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 14:22:36 -0400
Received: from postman2.arcor-online.net ([151.189.0.188]:22008 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261288AbTHXSW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 14:22:27 -0400
Date: Sun, 24 Aug 2003 19:51:49 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM with DMA, IDE-SCSI and Kernel 2.4.21/22pre3
Message-ID: <20030824175149.GA1756@mail1.bwalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Key-ID: 0xDDAF6454
X-PGP-Fingerprint: F61F 34CC 09CA FB82 C9F6  BA4B 8865 3696 DDAF 6454
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


1) I have a problem mounting a CD-ROM through ide-scsi emulation.

2) Following error occures:
             ~~~~~
   |  [~] $ LANG=en_US mount /cdrom
   |  /dev/cdrom: Input/output error
   |  mount: I could not determine the filesystem type, and none was specified

   If I turn DMA mode off, it works. It even works with Kernel 2.4.20
   and prior versions. According to the Kernel I have a "SAMSUNG
   SC-140B, ATAPI CD/DVD-ROM drive". I currently use 2.4.22pre3 but I
   have also problems with 2.4.21 (the final version from kernel.org) or
   2.4.22pre2. My mainboard is a ECS Elitegroup K7S5A-LAN.


   Here's some information:
               ~~~~~~~~~~~
     [~] $ grep  cdrom /etc/fstab 
     /dev/cdrom      /cdrom          auto    ro,user,noauto,umask=222        0       0
     
     [~] $ ls -l /dev/cdrom
     lrwxrwxrwx    1 root     root            3 25. Jul 17:34 /dev/cdrom -> sr0
   
   More information in X at the end of the mail. If you need further
   information please contact me directly -- I'm not reading the kernel
   list.


3) Keywords: ide-scsi mounting dma

4) Version:
   Linux version 2.4.22-rc3 (root@hugo) (gcc version 2.95.4 20011002 
   (Debian prerelease)) #1 Son Aug 24 17:14:34 CEST 2003

5) --

6) --

7) 7.1) If some fields are empty or look unusual you may have an old version.
        Compare to the current minimal requirements in Documentation/Changes.
 
        Linux hugo 2.4.22-rc3 #1 Son Aug 24 17:14:34 CEST 2003 i686 unknown
 
        Gnu C                  2.95.4
        Gnu make               3.79.1
        util-linux             2.11z
        mount                  2.11z
        modutils               2.4.21
        e2fsprogs              1.33
        isdn4k-utils           3.1pre4
        Linux C Library        2.2.5
        Dynamic linker (ldd)   2.2.5
        Procps                 3.1.6
        Net-tools              1.60
        Kbd                    1.06
        Sh-utils               2.0.11
        Modules Loaded         mousedev hid ipt_TOS ipt_state ipt_REJECT ipt_LOG 
        ipt_limit iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables 
        parport_pc lp parport binfmt_misc snd-seq-oss snd-seq-midi-event snd-seq 
        snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer snd-ac97-codec 
        snd-page-alloc snd-mpu401-uart snd-rawmidi snd-seq-device snd sis900 
        usbmouse apm i2c-isa it87 i2c-proc i2c-core ide-scsi scanner soundcore 
        hisax isdn slhc isa-pnp keybdev usbkbd input usb-ohci usbcore

   7.2) processor       : 0
        vendor_id       : AuthenticAMD
        cpu family      : 6
        model           : 8
        model name      : AMD Athlon(tm) XP 2200+
        stepping        : 0
        cpu MHz         : 1792.397
        cache size      : 256 KB
        fdiv_bug        : no
        hlt_bug         : no
        f00f_bug        : no
        coma_bug        : no
        fpu             : yes
        fpu_exception   : yes
        cpuid level     : 1
        wp              : yes
        flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
                          cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
        bogomips        : 3578.26

   7.3) mousedev                3736   1
        hid                    16836   0 (unused)
        ipt_TOS                 1080   6 (autoclean)
        ipt_state                568  13 (autoclean)
        ipt_REJECT              3192   4 (autoclean)
        ipt_LOG                 3192   3 (autoclean)
        ipt_limit                952   3 (autoclean)
        iptable_mangle          2160   1 (autoclean)
        iptable_nat            15192   0 (autoclean) (unused)
        ip_conntrack           16584   2 (autoclean) [ipt_state iptable_nat]
        iptable_filter          1668   1 (autoclean)
        ip_tables              11096  10 [ipt_TOS ipt_state ipt_REJECT ipt_LOG ipt_limit 
                                          iptable_mangle iptable_nat iptable_filter]
        parport_pc             24680   1 (autoclean)
        lp                      6880   0 (autoclean)
        parport                22720   1 (autoclean) [parport_pc lp]
        binfmt_misc             5576   1
        snd-seq-oss            23072   0 (unused)
        snd-seq-midi-event      2696   0 [snd-seq-oss]
        snd-seq                35600   2 [snd-seq-oss snd-seq-midi-event]
        snd-pcm-oss            36804   0 (unused)
        snd-mixer-oss          10968   1 [snd-pcm-oss]
        snd-intel8x0           15588   1
        snd-pcm                53952   0 [snd-pcm-oss snd-intel8x0]
        snd-timer              13700   0 [snd-seq snd-pcm]
        snd-ac97-codec         32840   0 [snd-intel8x0]
        snd-page-alloc          3984   0 [snd-intel8x0 snd-pcm]
        snd-mpu401-uart         2736   0 [snd-intel8x0]
        snd-rawmidi            11744   0 [snd-mpu401-uart]
        snd-seq-device          3588   0 [snd-seq-oss snd-seq snd-rawmidi]
        snd                    25924   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss 
                                          snd-mixer-oss snd-intel8x0 snd-pcm snd-timer 
                                          snd-ac97-codec snd-mpu401-uart snd-rawmidi 
                                          snd-seq-device]
        sis900                 12108   0 (unused)
        usbmouse                1788   0 (unused)
        apm                     9120   1
        i2c-isa                 1164   0 (unused)
        it87                    7080   0 (unused)
        i2c-proc                6256   0 [it87]
        i2c-core               12580   0 [i2c-isa it87 i2c-proc]
        ide-scsi                8880   0
        scanner                 9884   0 (unused)
        soundcore               3396   5 [snd]
        hisax                 455428   3
        isdn                  118048   4 [hisax]
        slhc                    4528   1 [isdn]
        isa-pnp                27748   0 [hisax]
        keybdev                 1696   0 (unused)
        usbkbd                  2844   0 (unused)
        input                   3264   0 [mousedev usbmouse keybdev usbkbd]
        usb-ohci               17448   0 (unused)
        usbcore                55712   1 [hid usbmouse scanner usbkbd usb-ohci]
  
   7.4) 0000-001f : dma1
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
        0290-0297 : it87
        0376-0376 : ide1
        0378-037a : parport0
        03c0-03df : vesafb
        03f6-03f6 : ide0
        03f8-03ff : serial(set)
        0cf8-0cff : PCI conf1
        a000-afff : PCI Bus #01
          a800-a8ff : ATI Technologies Inc Rage 128 RF/SG AGP
        d000-d01f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
          d000-d01f : avm PCI
        d400-d4ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
          d400-d4ff : sis900
        d800-d83f : Silicon Integrated Systems [SiS] Sound Controller
          d800-d83f : SiS SI7012 - Controller
        dc00-dcff : Silicon Integrated Systems [SiS] Sound Controller
          dc00-dcff : SiS SI7012 - AC'97
        ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
          ff00-ff07 : ide0
          ff08-ff0f : ide1

        00000000-0009fbff : System RAM
        0009fc00-0009ffff : reserved
        000a0000-000bffff : Video RAM area
        000c0000-000c7fff : Video ROM
        000c8000-000cffff : Extension ROM
        000f0000-000fffff : System ROM
        00100000-1ffeffff : System RAM
          00100000-002ed283 : Kernel code
          002ed284-003be6c3 : Kernel data
        1fff0000-1fff7fff : ACPI Tables
        1fff8000-1fffffff : ACPI Non-volatile Storage
        c7c00000-cfcfffff : PCI Bus #01
          c8000000-cbffffff : ATI Technologies Inc Rage 128 RF/SG AGP
            c8000000-c82fffff : vesafb
        cfe00000-cfefffff : PCI Bus #01
          cfefc000-cfefffff : ATI Technologies Inc Rage 128 RF/SG AGP
        cfffcfe0-cfffcfff : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
        cfffd000-cfffdfff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
          cfffd000-cfffdfff : sis900
        cfffe000-cfffefff : Silicon Integrated Systems [SiS] USB 1.0 Controller
          cfffe000-cfffefff : usb-ohci
        cffff000-cfffffff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
          cffff000-cfffffff : usb-ohci
        d0000000-d3ffffff : Silicon Integrated Systems [SiS] 735 Host
        fec00000-fec00fff : reserved
        fee00000-fee00fff : reserved
        ffee0000-ffefffff : reserved
        fffc0000-ffffffff : reserved

   7.5) 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
                Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
                Latency: 32
                Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
                Capabilities: [c0] AGP version 2.0
                        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

        00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64
                Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
                I/O behind bridge: 0000a000-0000afff
                Memory behind bridge: cfe00000-cfefffff
                Prefetchable memory behind bridge: c7c00000-cfcfffff
                BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

        00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
                Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 0

        00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
                Subsystem: Elitegroup Computer Systems: Unknown device 0a14
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64 (20000ns max), cache line size 08
                Interrupt: pin D routed to IRQ 12
                Region 0: Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]

        00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
                Subsystem: Elitegroup Computer Systems: Unknown device 0a14
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64 (20000ns max), cache line size 08
                Interrupt: pin A routed to IRQ 5
                Region 0: Memory at cffff000 (32-bit, non-prefetchable) [size=4K]

        00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
                Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
                Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 128
                Region 4: I/O ports at ff00 [size=16]

        00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
                Subsystem: Elitegroup Computer Systems: Unknown device 0a14
                Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64 (13000ns min, 2750ns max)
                Interrupt: pin C routed to IRQ 11
                Region 0: I/O ports at dc00 [size=256]
                Region 1: I/O ports at d800 [size=64]
                Capabilities: [48] Power Management version 2
                        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
                Subsystem: Elitegroup Computer Systems: Unknown device 0a14
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64 (13000ns min, 2750ns max)
                Interrupt: pin A routed to IRQ 3
                Region 0: I/O ports at d400 [size=256]
                Region 1: Memory at cfffd000 (32-bit, non-prefetchable) [size=4K]
                Expansion ROM at cffc0000 [disabled] [size=128K]
                Capabilities: [40] Power Management version 2
                        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
                Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
                Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
                Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Interrupt: pin A routed to IRQ 12
                Region 0: Memory at cfffcfe0 (32-bit, non-prefetchable) [size=32]
                Region 1: I/O ports at d000 [size=32]

        01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
                Subsystem: ATI Technologies Inc: Unknown device 0008
                Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
                Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 64 (2000ns min), cache line size 08
                Interrupt: pin A routed to IRQ 0
                Region 0: Memory at c8000000 (32-bit, prefetchable) [size=64M]
                Region 1: I/O ports at a800 [size=256]
                Region 2: Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
                Expansion ROM at cfec0000 [disabled] [size=128K]
                Capabilities: [50] AGP version 2.0
                        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                        Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
                Capabilities: [5c] Power Management version 1
                        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

   7.6) Attached devices: 
        Host: scsi0 Channel: 00 Id: 00 Lun: 00
          Vendor: SAMSUNG  Model: CD-ROM SC-140B   Rev: BH10
          Type:   CD-ROM                           ANSI SCSI revision: 02
        Host: scsi0 Channel: 00 Id: 01 Lun: 00
          Vendor: LITE-ON  Model: LTR-32123S       Rev: XS0R
          Type:   CD-ROM                           ANSI SCSI revision: 02


X) X.1) dmesg gives me:

        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 0 0 0 2 0 0 0 ]
        ]
        ide-scsi: expected 4096 got 6144 limit 4096
        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 0 0 0 2 0 0 0 ]
        ]
        ide-scsi: expected 4096 got 6144 limit 4096
        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 2 0 0 8 0 0 0 ]
        ]
        ide-scsi: expected 16384 got 18432 limit 16384
        scsi0: ERROR on channel 0, id 0, lun 0, CDB: Request Sense 00 00 00 40 00 
        Current sd0b:00: sense key Medium Error
        Additional sense indicates No seek complete
         I/O error: dev 0b:00, sector 8
        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 4 0 0 2 0 0 0 ]
        ]
        ide-scsi: expected 4096 got 6144 limit 4096
        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 4 0 0 2 0 0 0 ]
        ]
        ide-scsi: expected 4096 got 6144 limit 4096
        ide-scsi: The scsi wants to send us more data than expected - discarding data
        ide-scsi: [[ 28 0 0 0 0 0 0 0 1 0 0 0 ]
        ]
        ide-scsi: expected 2048 got 4096 limit 2048
        FAT: bogus logical sector size 0
        VFS: Can't find a valid FAT filesystem on dev 0b:00.



Regards,
Bernhard

