Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVUid>; Wed, 22 Nov 2000 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129392AbQKVUiX>; Wed, 22 Nov 2000 15:38:23 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:4612 "EHLO
        mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
        id <S129150AbQKVUiO>; Wed, 22 Nov 2000 15:38:14 -0500
Date: Wed, 22 Nov 2000 21:07:44 +0100 (CET)
From: chr.roessner@t-online.de (Christian Roessner)
Subject: PROBLEM: (U)DMA, hda: dma_intr status=0x51 ... error=0x84
To: linux-kernel@vger.kernel.org
X-Mailer: Mahogany, 0.60 'Redmond', compiled for Linux 2.2.16 i686
Reply-To: chr.roessner@t-online.de
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811740-846930886-974923665=:1169"
Message-ID: <13ygBO-0DqljkC@fwd07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---1463811740-846930886-974923665=:1169
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; CHARSET=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: INLINE

Hello,

I tested many hours before I sent you this eMail. I never
sent Bug-Reports, so please be friendly if I did something
wrong :-)

I used the formular to produce a bug-report:

1.) See subject
2.) I have trouble using DMA mode with my Siemens Fujitsu
harddisk on a NMC 6vcx Motherboard. I compiled the kernel
with DMA support, multi mode VIA chipset support and booting
DMA by default when available.

I used the command "updatedb" and "find" and "bonnie" to have much
read access. No problem occurs.

I used xmms to convert mp3-files into wav. There I get many
errors of the following:

hda: dma_intr status=3D0x51 {DriveReadySeekComplete Error}
hda: dma_intr  error=3D0x84 {DriveStatusError BadCRC}

I do not want to run the harddisk in PIO mode. I used hdparm
to change some settings (infos from SuSE Support database)

hdparm -d 1 -c 0 -X66 /dev/hda (also without -X66)
and
hdparm -d 1 -c 1 -X66 /dev/hda (also without -X66)
at least
hdparm -d 0 /dev/hda

Nothing changed. (only performance maybe)

3.) Keywords: (U)DMA
4.) Linux version 2.4.0-test11 (root@informatik) (gcc
version 2.95.2 19991024 (release)) #15 Wed Nov 22 18:40:38
CET 2000
5.) No Oops Output available
6.) Xmms is able to produce the error by using the
diskwriter modul
7.) Environment:
-1.) Kernel modules         2.3.20
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070406 Jul
30 21:41 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10q
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin
snd-mixer-oss tuner tvaudio bttv videodev ppp_deflate
bsd_comp ppp_async ppp_generic snd-card-via686a snd-pcm
snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device
snd-ac97-codec snd-mixer snd ipv6 3c59x hisax isdn slhc
AM53C974 ide-scsi usb-uhci usbcore

-2.) processor=09: 0
vendor_id=09: GenuineIntel
cpu family=09: 6
model=09=09: 5
model name=09: Pentium II (Deschutes)
stepping=09: 2
cpu MHz=09=09: 350.000809
cache size=09: 512 KB
fdiv_bug=09: no
hlt_bug=09=09: no
f00f_bug=09: no
coma_bug=09: no
fpu=09=09: yes
fpu_exception=09: yes
cpuid level=09: 2
wp=09=09: yes
features=09: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge
mca cmov pat pse36 mmx fxsr
bogomips=09: 699.60

-3.) snd-pcm-oss            18352   0 (autoclean)
snd-pcm-plugin         14672   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5120   1 (autoclean) [snd-pcm-oss]
tuner                   3232   1 (autoclean)
tvaudio                 7792   0 (autoclean) (unused)
bttv                   54768   1 (autoclean)
videodev                4512   3 (autoclean) [bttv]
ppp_deflate            39200   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6224   1 (autoclean)
ppp_generic            13024   3 (autoclean) [ppp_deflate
bsd_comp ppp_async]
snd-card-via686a        7408   1 (autoclean)
snd-pcm                31776   0 (autoclean) [snd-pcm-oss
snd-pcm-plugin snd-card-via686a]
snd-timer               8512   0 (autoclean) [snd-pcm]
snd-mpu401-uart         2640   0 (autoclean) [snd-card-via686a]
snd-rawmidi            10144   0 (autoclean) [snd-mpu401-uart]
snd-seq-device          3744   0 (autoclean) [snd-rawmidi]
snd-ac97-codec         24288   0 (autoclean) [snd-card-via686a]
snd-mixer              24208   0 (autoclean) [snd-mixer-oss snd-ac97-codec]
snd                    36384   1 [snd-pcm-oss snd-pcm-plugin
snd-mixer-oss snd-card-via686a snd-pcm snd-timer
snd-mpu401-uart snd-rawmidi snd-seq-device sc97-codec snd-mixer]
ipv6                  113296  -1 (autoclean)
3c59x                  22192   1 (autoclean)
hisax                 146608   5
isdn                   98912   6 [hisax]
slhc                    4592   2 [ppp_generic isdn]
AM53C974               12096   0 (unused)
ide-scsi                7840   0
usb-uhci               21424   0 (unused)
usbcore                49344   1 [usb-uhci]

-4.) 0000-001f : dma1
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
0240-025f : avm PnP
02f8-02ff : serial(auto)
0320-0321 : VIA 82C686A - MPU401
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 RF
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : VIA 82C686A - AC'97
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
  e400-e403 : VIA 82C686A - MPU401 config
e800-e87f : Advanced Micro Devices [AMD] 53c974 [PCscsi]
ec00-ec7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  ec00-ec7f : eth0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ce1ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00240747 : Kernel code
  00240748-00259667 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : ATI Technologies Inc Rage 128 RF
    e4000000-e7ffffff : aty128fb FB
e8000000-e9ffffff : PCI Bus #01
  e9000000-e9003fff : ATI Technologies Inc Rage 128 RF
    e9000000-e9003fff : aty128fb MMIO
ec000000-ec00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ec001000-ec001fff : Brooktree Corporation Bt848 TV with DMA push
  ec001000-ec001fff : bttv
ffff0000-ffffffff : reserved

-5.) Look at the bottom please.

-6.) Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: 51.G
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: ATAPI    Model: CD-R/RW 4X4X32   Rev: 3.DS
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-U24X   Rev: 1.01
  Type:   CD-ROM

-7.) hdparm -i /dev/hda

Model=3DFUJITSU MPE3273AT, FwRev=3DED-82-25, SerialNo=3D05006851
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
 BuffType=3D0(?), BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=3D16
 DblWordIO=3Dno, OldPIO=3D2, DMA=3Dyes, OldDMA=3D0
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D53377152
 tDMA=3D{min:120,rec:120}, DMA modes: mword0 mword1 mword2=20
 IORDY=3Dyes, tPIO=3D{min:120,w/IORDY:120}, PIO modes: mode3 mode4=20
 UDMA modes: mode0 mode1 *mode2=20
 Drive Supports : ATA-1 ATA-2 ATA-3 ATA-4

hdparm -I /dev/hda

Model=3DUFIJST UPM3E72A3 T , FwRev=3DDE8--252, SerialNo=3D50008615
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
 BuffType=3D0(?), BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=3D16
 DblWordIO=3Dno, OldPIO=3D2, DMA=3Dyes, OldDMA=3D0
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D53377152
 tDMA=3D{min:120,rec:120}, DMA modes: mword0 mword1 mword2=20
 IORDY=3Dyes, tPIO=3D{min:120,w/IORDY:120}, PIO modes: mode3 mode4=20
 UDMA modes: mode0 mode1 *mode2=20
 Drive Supports : ATA-1 ATA-2 ATA-3 ATA-4


I hope that is all you need on information. The problem does
not occur with Kernel 2.2.16 (SuSE-patch)

Please let me know, if that is/was a bug. If I did something
wrong with configuration, I was thankful for helping me
fixing the problem.

Sincercley
Christian Roessner

-----
Attachments:

---1463811740-846930886-974923665=:1169
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; NAME="lspci.txt"; CHARSET=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: INLINE; FILENAME="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 44)=
=0A=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B-=0A=09Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVS=
EL=3Dmedium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+=0A=09Latency: 16=0A=09=
Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]=0A=09Capab=
ilities: [a0] AGP version 1.0=0A=09=09Status: RQ=3D7 SBA+ 64bit- FW- Rate=
=3Dx1,x2=0A=09=09Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>=0A=0A00=
:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-i=
f 00 [Normal decode])=0A=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A=09Status: Cap+ 66Mhz+ UDF- =
FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-=
=0A=09Latency: 0=0A=09Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0=0A=09I/O behind bridge: 0000c000-0000cfff=0A=09Memory behin=
d bridge: e8000000-e9ffffff=0A=09Prefetchable memory behind bridge: e400000=
0-e7ffffff=0A=09BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2=
B-=0A=09Capabilities: [80] Power Management version 2=0A=09=09Flags: PMEClk=
- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=09=09Sta=
tus: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:07.0 ISA bridge: VIA T=
echnologies, Inc. VT82C686 [Apollo Super] (rev 1b)=0A=09Subsystem: VIA Tech=
nologies, Inc. VT82C686/A PCI to ISA Bridge=0A=09Control: I/O+ Mem+ BusMast=
er+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-=0A=09Sta=
tus: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <M=
Abort- >SERR- <PERR-=0A=09Latency: 0=0A=0A00:07.1 IDE interface: VIA Techno=
logies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])=
=0A=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B-=0A=09Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVS=
EL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 32=0A=09=
Region 4: I/O ports at d000 [size=3D16]=0A=09Capabilities: [c0] Power Manag=
ement version 2=0A=09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0=
-,D1-,D2-,D3hot-,D3cold-)=0A=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D=
0 PME-=0A=0A00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (r=
ev 0e) (prog-if 00 [UHCI])=0A=09Subsystem: Unknown device 0925:1234=0A=09Co=
ntrol: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-=
 SERR- FastB2B-=0A=09Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmed=
ium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 32, cache line s=
ize 08=0A=09Interrupt: pin D routed to IRQ 10=0A=09Region 4: I/O ports at d=
400 [size=3D32]=0A=09Capabilities: [80] Power Management version 2=0A=09=09=
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-=
)=0A=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:07.4 Host=
 bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)=0A=09=
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppin=
g- SERR- FastB2B-=0A=09Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dm=
edium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=0A00:07.5 Multimedia audi=
o controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (re=
v 21)=0A=09Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Au=
dio]=0A=09Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-=0A=09Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- =
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Interrupt: pi=
n C routed to IRQ 10=0A=09Region 0: I/O ports at dc00 [size=3D256]=0A=09Reg=
ion 1: I/O ports at e000 [size=3D4]=0A=09Region 2: I/O ports at e400 [size=
=3D4]=0A=09Capabilities: [c0] Power Management version 2=0A=09=09Flags: PME=
Clk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=09=09=
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A00:08.0 Multimedia vid=
eo controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)=0A=09C=
ontrol: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping=
- SERR- FastB2B-=0A=09Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dme=
dium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 32 (4000ns min,=
 10000ns max)=0A=09Interrupt: pin A routed to IRQ 11=0A=09Region 0: Memory =
at ec001000 (32-bit, prefetchable) [size=3D4K]=0A=0A00:09.0 SCSI storage co=
ntroller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)=0A=09Contro=
l: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping+ SER=
R- FastB2B-=0A=09Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium =
>TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 70 (1000ns min, 1000=
0ns max)=0A=09Interrupt: pin A routed to IRQ 9=0A=09Region 0: I/O ports at =
e800 [size=3D128]=0A=09Expansion ROM at ea000000 [disabled] [size=3D64K]=0A=
=0A00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]=
 (rev 30)=0A=09Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100=
=0A=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B-=0A=09Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVS=
EL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 32 (2500=
ns min, 2500ns max), cache line size 08=0A=09Interrupt: pin A routed to IRQ=
 10=0A=09Region 0: I/O ports at ec00 [size=3D128]=0A=09Region 1: Memory at =
ec000000 (32-bit, non-prefetchable) [size=3D128]=0A=09Expansion ROM at eb00=
0000 [disabled] [size=3D128K]=0A=09Capabilities: [dc] Power Management vers=
ion 1=0A=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,=
D3hot+,D3cold-)=0A=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (pro=
g-if 00 [VGA])=0A=09Subsystem: ATI Technologies Inc: Unknown device 0448=0A=
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping+ SERR- FastB2B-=0A=09Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A=09Latency: 32 (2000ns=
 min), cache line size 08=0A=09Interrupt: pin A routed to IRQ 11=0A=09Regio=
n 0: Memory at e4000000 (32-bit, prefetchable) [size=3D64M]=0A=09Region 1: =
I/O ports at c000 [size=3D256]=0A=09Region 2: Memory at e9000000 (32-bit, n=
on-prefetchable) [size=3D16K]=0A=09Expansion ROM at <unassigned> [disabled]=
 [size=3D128K]=0A=09Capabilities: [50] AGP version 2.0=0A=09=09Status: RQ=
=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2=0A=09=09Command: RQ=3D0 SBA+ AGP- 64bit-=
 FW- Rate=3D<none>=0A=09Capabilities: [5c] Power Management version 1=0A=09=
=09Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)=0A=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A
---1463811740-846930886-974923665=:1169--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
