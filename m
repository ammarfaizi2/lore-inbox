Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbRFDKmt>; Mon, 4 Jun 2001 06:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264134AbRFDKmj>; Mon, 4 Jun 2001 06:42:39 -0400
Received: from lilly.ping.de ([62.72.90.2]:6408 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S264021AbRFDKm1>;
	Mon, 4 Jun 2001 06:42:27 -0400
Date: Mon, 4 Jun 2001 12:21:21 +0200 (CEST)
From: Juergen Boehm <juergen@abyss.ping.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Can't mount cdrom, connected on Adaptec 1542CF with Kernel
 2.4.(3-5)
Message-ID: <Pine.LNX.4.21.0106041208150.12514-100000@abyss.ping.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.   Can't mount cdrom, connected on Adaptec 1542CF with Kernel 2.4.(3-5)

2.   Description
     On Kernel 2.2.(3-5) with aha1542 as second SCSI-Controller
     mount -t iso9660 -o ro /dev/scd1 /cdrom gives the following Message:

     mount: wrong fs type, bad option, bad superblock on /dev/sdc1
     or too many mounted file systems

     But I can burn CDROM and read Images from CDROM,
     mean copy Iso9660- and Audio-CDs are ok.

     When I switch back to Kernel 2.2.19 there is no Mount-Problem.
     There is no mount Problem with aic7xxx, too.
3.   Keywords
     Adaptec 1542CF, CDROM, mount, iso9660, CD, CD-R, aha1542
4.   Kernel version (at the moment)
     Linux version 2.4.4 (root@abyss)
     (gcc version 2.95.2 19991024 (release)) #3 Fre Mai 25 13:31:31 CEST 2001
5.   Output (no oops, but /var/log/messages)
     Jun  4 11:24:41 abyss kernel: sr: ran out of mem for scatter pad
     Jun  4 11:24:41 abyss kernel:  I/O error: dev 0b:01, sector 64
     Jun  4 11:24:41 abyss kernel: isofs_read_super: bread failed, dev=0b:01,
                                   iso_blknum=16, block=32
6.   mount -t iso9660 -o ro /dev/scd1 /cdrom/
7.   Environment
7.1  Linux abyss 2.4.4 #3 Fre Mai 25 13:31:31 CEST 2001 i586 unknown
     Gnu C                  2.95.2
     Gnu make               3.78.1
     binutils               2.9.5.0.24
     util-linux             2.10m
     mount                  2.10m
     modutils               2.4.5
     e2fsprogs              1.18
     PPP                    2.4.0
     isdn4k-utils           3.1beta6s
     Linux C Library        x 1 root  root  4070406 Jul 30  2000 /lib/libc.so.6
     Dynamic linker (ldd)   2.1.3
     Procps                 2.0.6
     Net-tools              1.54
     Kbd                    0.99
     Sh-utils               2.0
     Modules Loaded         hisax isdn ppp_async ppp_generic sr_mod cdrom
                            aha1542 videodev printer usb-ohci nfsd lockd
                            sunrpc serial ne isa-pnp 8390
7.2  Processor information
     processor       : 0
     vendor_id       : AuthenticAMD
     cpu family      : 5
     model           : 6
     model name      : AMD-K6tm w/ multimedia extensions
     stepping        : 2
     cpu MHz         : 233.293
     cache size      : 64 KB
     fdiv_bug        : no
     hlt_bug         : no
     f00f_bug        : no
     coma_bug        : no
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 1
     wp              : yes
     flags           : fpu vme de pse tsc msr mce cx8 mmx
     bogomips        : 465.30
7.3  Module information
     hisax                 148304   2
     isdn                  102256   3 [hisax]
     ppp_async               6224   0 (autoclean)
     ppp_generic            13120   0 (autoclean) [ppp_async]
     sr_mod                 12848   0 (autoclean)
     cdrom                  26912   0 (autoclean) [sr_mod]
     aha1542                10208   0
     videodev                4640   0 (unused)
     printer                 4912   0 (unused)
     usb-ohci               16640   0 (unused)
     nfsd                   43920   4 (autoclean)
     lockd                  37680   1 (autoclean) [nfsd]
     sunrpc                 58912   1 (autoclean) [nfsd lockd]
     serial                 43152   1 (autoclean)
     ne                      6752   1
     isa-pnp                27696   0 [aha1542 serial ne]
     8390                    6192   0 [ne]
7.4  Loaded driver and hardware information
     /proc/ioports
     0000-001f : dma1
     0020-003f : pic1
     0040-005f : timer
     0060-006f : keyboard
     0080-008f : dma page reg
     00a0-00bf : pic2
     00c0-00df : dma2
     00f0-00ff : fpu
     0220-022f : soundblaster
     02f8-02ff : serial(auto)
     0300-031f : eth0
     0330-0333 : aha1542
     03c0-03df : vga+
     03f8-03ff : serial(auto)
     0cf8-0cff : PCI conf1
     ea00-eaff : Adaptec AIC-7881U
     ee80-ee9f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]
       ee80-ee9f : avm PCI
     /proc/iomem
     00000000-0009fbff : System RAM
     0009fc00-0009ffff : reserved
     000a0000-000bffff : Video RAM area
     000c0000-000c7fff : Video ROM
     000c8000-000cc7ff : Extension ROM
     000dc000-000dffff : Extension ROM
     000f0000-000fffff : System ROM
     00100000-0bffffff : System RAM
       00100000-001e7cdf : Kernel code
       001e7ce0-0024589f : Kernel data
     ed000000-edffffff : Matrox Graphics, Inc. MGA G200
     ef000000-ef7fffff : Matrox Graphics, Inc. MGA G200
     efff9000-efff9fff : Adaptec AIC-7881U
       efff9000-efff9fff : aic7xxx
     efffafe0-efffafff : AVM Audiovisuelles MKTG & Computer System GmbH A1 
                         ISDN [Fritz]
     efffb000-efffbfff : Acer Laboratories Inc. [ALi] M5237 USB
       efffb000-efffbfff : usb-ohci
     efffc000-efffffff : Matrox Graphics, Inc. MGA G200
     fec00000-fec00fff : reserved
     fee00000-fee00fff : reserved
     fffe0000-ffffffff : reserved
7.5  PCI information
     lspci -vvv
     00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
       (rev b2)
     - Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
     - Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
       Stepping- SERR- FastB2B-
     - Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
       <MAbort+ >SERR- <PERR-
     - Latency: 32

     00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
       [Aladdin IV] (rev b4)
     - Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
       Stepping- SERR- FastB2B-
     - Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
       <TAbort+ <MAbort+ >SERR- <PERR-
       Latency: 0

     00:03.0 SCSI storage controller: Adaptec AIC-7881U
     - Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
       Stepping- SERR+ FastB2B-
     - Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
        <TAbort- <MAbort- >SERR- <PERR-
     - Latency: 64 (2000ns min, 2000ns max), cache line size 08
     - Interrupt: pin A routed to IRQ 15
     - Region 0: I/O ports at ea00 [disabled] [size=256]
     - Region 1: Memory at efff9000 (32-bit, non-prefetchable) [size=4K]
     - Expansion ROM at effd0000 [disabled] [size=64K]

     00:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200
       (rev 01) (prog-if 00 [VGA])
     - Subsystem: Matrox Graphics, Inc. Millennium G200 SD
     - Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
       Stepping- SERR- FastB2B-
     - Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
       <TAbort- <MAbort- >SERR- <PERR-
     - Latency: 64 (4000ns min, 8000ns max), cache line size 08
     - Interrupt: pin A routed to IRQ 0
     - Region 0: Memory at ed000000 (32-bit, prefetchable) [size=16M]
     - Region 1: Memory at efffc000 (32-bit, non-prefetchable) [size=16K]
     - Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=8M]
     - Expansion ROM at effe0000 [disabled] [size=64K]
     - Capabilities: [dc] Power Management version 1
     -    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,
          D3cold-)
     -    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

    00:06.0 Network controller: AVM Audiovisuelles MKTG & Computer System
       GmbH A1 ISDN [Fritz] (rev 02)
     - Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card
       ISDN Controller
     - Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
       Stepping- SERR+ FastB2B-
     - Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
       <TAbort- <MAbort- >SERR- <PERR-
     - Interrupt: pin A routed to IRQ 9
     - Region 0: Memory at efffafe0 (32-bit, non-prefetchable) [size=32]
     - Region 1: I/O ports at ee80 [size=32]

     00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
       (prog-if 10 [OHCI])
     - Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
       Stepping- SERR+ FastB2B-
     - Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
       <TAbort- <MAbort- >SERR- <PERR-
     - Latency: 64, cache line size 08
     - Interrupt: pin A routed to IRQ 10
     - Region 0: Memory at efffb000 (32-bit, non-prefetchable) [size=4K]
7.6  SCSI information
     /proc/scsi/scsi
     Attached devices:
     Host: scsi0 Channel: 00 Id: 00 Lun: 00
       Vendor: IBM      Model: DDRS-34560W      Rev: S92A
       Type:   Direct-Access                    ANSI SCSI revision: 02
     Host: scsi0 Channel: 00 Id: 01 Lun: 00
       Vendor: IBM      Model: DORS-31080       Rev: WA6A
       Type:   Direct-Access                    ANSI SCSI revision: 02
     Host: scsi0 Channel: 00 Id: 02 Lun: 00
       Vendor: DEC      Model: RZ26L    (C) DEC Rev: 442D
       Type:   Direct-Access                    ANSI SCSI revision: 02
     Host: scsi0 Channel: 00 Id: 06 Lun: 00
       Vendor: TOSHIBA  Model: CD-ROM XM-3701TA Rev: 0236
       Type:   CD-ROM                           ANSI SCSI revision: 02
     Host: scsi0 Channel: 00 Id: 08 Lun: 00
       Vendor: IBM      Model: DCAS-34330W      Rev: S65A
       Type:   Direct-Access                    ANSI SCSI revision: 02
     Host: scsi0 Channel: 00 Id: 09 Lun: 00
       Vendor:          Model: DFRSS4W          Rev: 4B4B
       Type:   Direct-Access                    ANSI SCSI revision: 02
     Host: scsi1 Channel: 00 Id: 01 Lun: 00
       Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
       Type:   CD-ROM                           ANSI SCSI revision: 02
     Host: scsi1 Channel: 00 Id: 02 Lun: 00
       Vendor: HP       Model: CD-Writer+ 9200  Rev: 1.0c
       Type:   CD-ROM                           ANSI SCSI revision: 04
     Host: scsi1 Channel: 00 Id: 04 Lun: 00
       Vendor: HP       Model: HP35480A         Rev: T503
       Type:   Sequential-Access                ANSI SCSI revision: 02
     Host: scsi1 Channel: 00 Id: 05 Lun: 00
       Vendor: EXABYTE  Model: EXB-8200         Rev: 2644
       Type:   Sequential-Access                ANSI SCSI revision: 01
     Host: scsi1 Channel: 00 Id: 06 Lun: 00
       Vendor: SCANNER  Model:                  Rev: 1.06
       Type:   Scanner                          ANSI SCSI revision: 01 CCS
7.7  Other notes
     There are 2 SCSI-Controller running on the System:

     the first: aic7xxx (Adaptec 2940UW)
     Note: The cdrom on aic7xxx can be mounted, without any problem

     the second: aha1542 (Adaptec 1542CF)
     Note: No cdrom can be mounted, but I can read Cdrom-Images with cdrecord.
           Tapes and Scanner running fine

     Missing in REPORTING-BUGS
     /proc/meminfo
             total:    used:    free:  shared: buffers:  cached:
     Mem:  196005888 193130496  2875392        0 11296768 59224064
     Swap: 139821056  1134592 138686464
     MemTotal:       191412 kB
     MemFree:          2808 kB
     MemShared:           0 kB
     Buffers:         11032 kB
     Cached:          57836 kB
     Active:          14024 kB
     Inact_dirty:     52048 kB
     Inact_clean:      2796 kB
     Inact_target:       16 kB
     HighTotal:           0 kB
     HighFree:            0 kB
     LowTotal:       191412 kB
     LowFree:          2808 kB
     SwapTotal:      136544 kB
     SwapFree:       135436 kB

X.   Sorry for my bad english, I'm working on it. Thank you

Greetings from Germany

