Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRFNMGf>; Thu, 14 Jun 2001 08:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbRFNMGQ>; Thu, 14 Jun 2001 08:06:16 -0400
Received: from front4m.grolier.fr ([195.36.216.54]:7049 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S262116AbRFNMGI>; Thu, 14 Jun 2001 08:06:08 -0400
Date: Thu, 14 Jun 2001 14:07:28 +0200
From: Marco <biancio@club-internet.fr>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: hda timeout (busy)
Message-ID: <20010614140728.A1826@bianciotto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, here is my problem :

[1.] 2.4.x kernels sends hda: status timeout: status=0xd0 { Busy }
errors

[2.] I have tried some 2.4.x kernels (2.4.0, 2.4.4, and now
2.4.5, from debs). They all produce the same error message : 
Jun 14 13:32:19 debian kernel: hda: status timeout: status=0xd0 { Busy }
Jun 14 13:32:19 debian kernel: ide0: reset: success
It happens often but irregularly. It does not occur with 2.2 kernels.

[3.] ide, hard drive

[4.]  cat /proc/version
Linux version 2.4.5 (root@debian) (gcc version 2.95.4 20010522 (Debian
prerelease)) #1 mar jun 12 17:24:48 CEST 2001

[7.] Environment
[7.1.]
Linux debian 2.4.5 #1 mar jun 12 17:24:48 CEST 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11d
mount                  2.11d
modutils               2.4.6
e2fsprogs              1.21-WIP
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate ppp_async ppp_generic slhc vfat fat
NVdriver tuner tvaudio bttv videodev i2c-algo-bit lirc_i2c i2c-core
lirc_dev sb sb_lib uart401 sound ide-scsi apm

[7.2.]
[marco] /usr/src/linux $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 499.792
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 996.14

[7.3.] 
[marco] /usr/src/linux $ cat /proc/modules
ppp_deflate            39136   0 (autoclean)
ppp_async               6224   0 (autoclean)
ppp_generic            13216   0 (autoclean) [ppp_deflate ppp_async]
slhc                    4704   0 (autoclean) [ppp_generic]
vfat                    8752   2 (autoclean)
fat                    30624   0 (autoclean) [vfat]
NVdriver              658720  15
tuner                   4112   1 (autoclean)
tvaudio                 8064   0 (autoclean) (unused)
bttv                   53456   1 (autoclean)
videodev                4736   2 (autoclean) [bttv]
i2c-algo-bit            7200   1 (autoclean) [bttv]
lirc_i2c                2512   0
i2c-core               12880   0 [tuner tvaudio bttv i2c-algo-bit
lirc_i2c]
lirc_dev                7808   1 [lirc_i2c]
sb                      7344   2
sb_lib                 33120   0 [sb]
uart401                 6288   0 [sb_lib]
sound                  55392   2 [sb_lib uart401]
ide-scsi                7664   0
apm                     8544   0

[7.4.]
[marco] /usr/src/linux $ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

[7.5.] 
debian:/home/marco# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8001000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
11) (prog-if 00 [VGA])
        Subsystem: Creative Labs CT6892 RIVA TNT2 Value
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e5000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.7.]
debian:/home/marco#  hdparm -i /dev/hda

/dev/hda:

 Model=ST36421A, FwRev=8.01, SerialNo=6BE08WVK
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=13330/15/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=256kB, MaxMultSect=16, MultSect=off
 CurCHS=13330/15/63, CurSects=12596850, LBA=yes, LBAsects=12596850
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 


[X.]
the use of the ide0=autotune option produces a freeze at xdm login.
The use of the hda=slow option does not suppress the error message.

Thanks for your help

Marco

