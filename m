Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267848AbRGRJrQ>; Wed, 18 Jul 2001 05:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbRGRJrI>; Wed, 18 Jul 2001 05:47:08 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:9225 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267848AbRGRJrA>; Wed, 18 Jul 2001 05:47:00 -0400
Message-ID: <3B555AD2.B41EEC56@namesys.com>
Date: Wed, 18 Jul 2001 13:45:54 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Fabrizio Ammollo <f.ammollo@reitek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: mount/umount blocked
In-Reply-To: <01071809031300.01307@f-ammollo.reitek.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it reiserfs or ext2 that fails to umount/mount?  Do I understand correctly that is09660 also
fails to mount/umount?

Hans

Fabrizio Ammollo wrote:
> 
> Hello,
> 
> I'm writing to report this strange problem.
> 
> [1.] mount/umount blocked
> [2.] mount/umount block forever when invoked, both on a partition of my IDE
> hard drives and on my IDE CDROM.
> 
> The mount and the umount processes (from the output of ps) are in a state of
> uninterruptible sleep and strace shows that they are blocked waiting for the
> mount or umount library call to return.
> 
> [3.] mount umount blocked
> [4.] Linux version 2.4.6 (root@f-ammollo.reitek.com) (gcc version 2.96
> 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)) #4 Mon Jul 16 14:22:22 CEST 2001
> [5.] N/A
> [6.] mount /dev/cdrom or umount /mnt/win_c2 (see fstab below)
> 
> [7.1.]
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux f-ammollo.reitek.com 2.4.6 #4 Mon Jul 16 14:22:22 CEST 2001 i686 unknown
> 
> Gnu C                  2.96
> Gnu make               3.79.1
> binutils               2.10.1.0.2
> util-linux             2.10s
> mount                  2.11e
> modutils               2.4.3
> e2fsprogs              1.19
> reiserfsprogs          3.x.0i
> PPP                    2.4.0
> Linux C Library        2.2.2
> Dynamic linker (ldd)   2.2.2
> Procps                 2.0.7
> Net-tools              1.59
> Console-tools          0.2.3
> Sh-utils               2.0
> Modules Loaded         isofs nfs lockd sunrpc es1371 ac97_codec soundcore
> 3c59x nls_iso8859-1 nls_cp850 vfat fat
> 
> [7.2.]
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 7
> model name      : Pentium III (Katmai)
> stepping        : 3
> cpu MHz         : 501.148
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 3
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr sse
> bogomips        : 999.42
> 
> [7.3.]
> es1371                 26240   0
> ac97_codec              8624   0 [es1371]
> soundcore               3792   4 [es1371]
> 3c59x                  25248   1 (autoclean)
> nls_iso8859-1           2864   1 (autoclean)
> nls_cp850               3616   1 (autoclean)
> vfat                    9232   1 (autoclean)
> fat                    31584   0 (autoclean) [vfat]
> 
> [7.4.]
> /proc/ioports:
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial(auto)
> 0376-0376 : ide1
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0cf8-0cff : PCI conf1
> 4000-403f : Intel Corporation 82371AB PIIX4 ACPI
> 5000-501f : Intel Corporation 82371AB PIIX4 ACPI
> d000-dfff : PCI Bus #01
>   d000-d0ff : ATI Technologies Inc 3D Rage IIC AGP
> e000-e01f : Intel Corporation 82371AB PIIX4 USB
> e400-e47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
>   e400-e47f : 00:0b.0
> e800-e83f : Ensoniq ES1371 [AudioPCI-97]
>   e800-e83f : es1371
> f000-f00f : Intel Corporation 82371AB PIIX4 IDE
>   f000-f007 : ide0
>   f008-f00f : ide1
> 
> /proc/iomem:
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-0fffffff : System RAM
>   00100000-001f3ad1 : Kernel code
>   001f3ad2-00242147 : Kernel data
> e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> e4000000-e5ffffff : PCI Bus #01
>   e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
> e6000000-e6ffffff : PCI Bus #01
>   e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
>     e6000000-e63fffff : vesafb
> e8000000-e800007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
> ffff0000-ffffffff : reserved
> 
> [7.5.]
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
> 03)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR-
>         Latency: 64
>         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 1.0
>                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
> 03) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: e4000000-e5ffffff
>         Prefetchable memory behind bridge: e6000000-e6ffffff
>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
> 
> 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 0
> 
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
> 80 [Master])
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 64
>         Region 4: I/O ports at f000 [size=16]
> 
> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if
> 00 [UHCI])
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin D routed to IRQ 0
>         Region 4: I/O ports at e000 [size=32]
> 
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Interrupt: pin ? routed to IRQ 9
> 
> 00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev
> 30)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 64 (2500ns min, 2500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at e400 [size=128]
>         Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at e7000000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
>         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+
> <MAbort+ >SERR- <PERR-
>         Latency: 64 (3000ns min, 32000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at e800 [size=64]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
>                 Status: D3 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
> 7a) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc: Unknown device 000f
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min), cache line size 08
>         Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
>         Region 1: I/O ports at d000 [size=256]
>         Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [5c] Power Management version 1
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> [7.6.] N/A
> 
> [7.7.]
> 
> /etc/fstab:
> 
> /dev/hda6 / ext2 defaults 1 1
> /dev/hda5 /boot ext2 defaults 1 2
> none /dev/pts devpts mode=0620 0 0
> /dev/hda9 /home reiserfs defaults 1 2
> /dev/cdrom      /mnt/cdrom      iso9660 ro,nosuid,noauto,exec,user,nodev
>  0 0
> /dev/fd0        /mnt/floppy     vfat sync,nosuid,noauto,user,nodev,unhide
>  0 0
> /dev/hdb5 /mnt/win_c2 vfat user,exec,umask=0,codepage=850,iocharset=iso8859-1
> 0
> 0
> none /proc proc defaults 0 0
> /dev/hda8 /tmp reiserfs defaults 1 2
> /dev/hda10 /usr reiserfs defaults 1 2
> /dev/hda7 swap swap defaults 0 0
> /dev/hdb7 /mnt/win_tmp ext2 defaults 1 3
> 
> info from dmesg:
> 
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: FUJITSU MPD3084AT, ATA DISK drive
> hdb: FUJITSU MPG3204AT E, ATA DISK drive
> hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, UDMA(33)
> hdb: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
>  hdb: hdb1 < hdb5 hdb6 hdb7 >
> 
> /proc/ide/drivers:
> 
> ide-disk version 1.10
> 
> /proc/ide/piix:
> 
>                                 Intel PIIX4 Ultra 33 Chipset.
> --------------- Primary Channel ---------------- Secondary Channel
> -------------                 enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1
> ------DMA enabled:    yes              yes             yes               yes
> UDMA enabled:   yes              yes             no                no
> UDMA enabled:   2                2               X                 X
> UDMA
> DMA
> PIO
> 
> /proc/ide/ide0/hda:
> 
> model: FUJITSU MPD3084AT
> settings:
> 
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----
> bios_cyl                1027            0               65535           rw
> bios_head               255             0               255             rw
> bios_sect               63              0               63              rw
> breada_readahead        4               0               127             rw
> bswap                   0               0               1               r
> current_speed           66              0               69              rw
> file_readahead          0               0               2097151         rw
> ide_scsi                0               0               1               rw
> init_speed              66              0               69              rw
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> lun                     0               0               7               rw
> max_kb_per_request      127             1               127             rw
> multcount               8               0               8               rw
> nice1                   1               0               1               rw
> nowerr                  0               0               1               rw
> number                  0               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               1               0               1               rw
> 
> /proc/ide/ide0/hdb:
> 
> model: FUJITSU MPG3204AT E
> settings:
> 
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----
> bios_cyl                2491            0               65535           rw
> bios_head               255             0               255             rw
> bios_sect               63              0               63              rw
> breada_readahead        4               0               127             rw
> bswap                   0               0               1               r
> current_speed           66              0               69              rw
> file_readahead          0               0               2097151         rw
> ide_scsi                0               0               1               rw
> init_speed              66              0               69              rw
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> lun                     0               0               7               rw
> max_kb_per_request      127             1               127             rw
> multcount               8               0               8               rw
> nice1                   1               0               1               rw
> nowerr                  0               0               1               rw
> number                  1               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               1               0               1               rw
> 
> /proc/ide/ide1/hdc:
> 
> media: cdrom
> model: CRD-8322B
> settings:
> 
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----
> current_speed           0               0               69              rw
> ide_scsi                0               0               1               rw
> init_speed              0               0               69              rw
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> nice1                   0               0               1               rw
> number                  2               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               0               0               1               rw
> 
> [8.] Other Notes: the same thing does NOT happen on another machine which has
> kernel 2.4.6 and a similiar setup (two IDE hard drives, one IDE CDROM).
> 
> Thank you very much in advance for any suggestion.
> 
> --
> Fabrizio Ammollo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
