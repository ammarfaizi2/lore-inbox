Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRB1V1h>; Wed, 28 Feb 2001 16:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRB1V12>; Wed, 28 Feb 2001 16:27:28 -0500
Received: from mlmmail.maxtor.com ([134.6.76.3]:53680 "EHLO mlmmail.maxtor.com")
	by vger.kernel.org with ESMTP id <S129276AbRB1V1O>;
	Wed, 28 Feb 2001 16:27:14 -0500
Message-ID: <09D1E9BD9C30D311919200A0C9DD5C2C03E084CD@mcaexc01.msj.maxtor.com>
From: "Cappellini, Tony" <Tony_Cappellini@maxtor.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROBLEM- Segmentation fault occurs when dd'ing entire drive (9.x 
	GB) to a vfat partition.
Date: Wed, 28 Feb 2001 14:08:52 -0700
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0A1CA.BD9BFCDA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0A1CA.BD9BFCDA
Content-Type: text/plain;
	charset="iso-8859-1"


Hello


I am submitting this bug report. I've attached a file which I hope contains
all of the approppriate information.

Is it possible for someone to let me know if/when this problem is fixed ?

Thanks




Tony Cappellini

Maxtor Corporation



------_=_NextPart_000_01C0A1CA.BD9BFCDA
Content-Type: text/plain;
	name="bug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bug.txt"


Person to Contact-

Tony Cappellini
Tony_cappellini@maxtor.com
408-432-4316



SUMMARY

Segmentation fault occurs when dd'ing entire drive (9.x GB) to a vfat =
partition.

************************************************************************=
************

FULL DESCRIPTION

When using the following command

dd if=3D/dev/had of=3D/mnt/win/image.out bs=3D1048576=20

A segmentation fault occurs when image.out reaches 4294963200 bytes. =
The partition /mnt/win is a vfat partition which is approximately 13GB. =
This partition was created with Windows 98 FDISK.
This problem is repeatble on my system.


************************************************************************=
************

KEYWORDS- large file, vfat, 4GB 4 GB,

************************************************************************=
************

SHELL SCRIPT TO DUPLICATE THE PROBLEM

mount -t vfat /dev/hdb6 /mnt/win           # was used to mount the 13.x =
GB partition. =20
dd if=3D/dev/had of=3D/mnt/win/image.out bs=3D1048576=20


************************************************************************=
************

ENVIRONMENT

PWD=3D/proc
HOSTNAME=3Ddata.starfleet.org
QTDIR=3D/usr/lib/qt-2.2.0
LESSOPEN=3D|/usr/bin/lesspipe.sh %s
KDEDIR=3D/usr
USER=3Droot
LS_COLORS=3Dno=3D00:fi=3D00:di=3D01;34:ln=3D01;36:pi=3D40;33:so=3D01;35:=
bd=3D40;33;01:cd=3D40;33;01:or=3D01;05;37;41:mi=3D01;05;37;41:ex=3D01;32=
:*.cmd=3D01;32:*.exe=3D01;32:*.com=3D01;32:*.btm=3D01;32:*.bat=3D01;32:*=
.sh=3D01;32:*.csh=3D01;32:*.tar=3D01;31:*.tgz=3D01;31:*.arj=3D01;31:*.t=
az=3D01;31:*.lzh=3D01;31:*.zip=3D01;31:*.z=3D01;31:*.Z=3D01;31:*.gz=3D01=
;31:*.bz2=3D01;31:*.bz=3D01;31:*.tz=3D01;31:*.rpm=3D01;31:*.cpio=3D01;31=
:*.jpg=3D01;35:*.gif=3D01;35:*.bmp=3D01;35:*.xbm=3D01;35:*.xpm=3D01;35:*=
.png=3D01;35:*.tif=3D01;35:
MACHTYPE=3Di386-redhat-linux-gnu
MAIL=3D/var/spool/mail/root
OLDPWD=3D/
INPUTRC=3D/etc/inputrc
BASH_ENV=3D/root/.bashrc
LANG=3Den_US
LOGNAME=3Droot
SHLVL=3D1
SHELL=3D/bin/bash
USERNAME=3Droot
HOSTTYPE=3Di386
OSTYPE=3Dlinux-gnu
HISTSIZE=3D1000
HOME=3D/root
TERM=3Dlinux
PATH=3D/usr/local/sbin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/bin:/s=
bin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
_=3D/usr/bin/env


************************************************************************=
************

OUPUT FROM VER_LINUX

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux data.starfleet.org 2.4.1 #1 Mon Feb 26 18:52:58 PST 2001 i586 =
unknown

Kernel modules         2.3.14
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        2.1.92
Dynamic linker         ldd (GNU libc) 2.1.92
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         vfat fat

************************************************************************=
************


/proc/cpuinfo


processor	: 0
vendor_id	: CyrixInstead
cpu family	: 5
model		: 7
model name	: Cyrix MediaGXtm MMXtm Enhanced
stepping	: 4
cache size	: 16 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu msr cx8 cmov mmx cxmmx
bogomips	: 398.13


************************************************************************=
************

/proc/modules

vfat                   11076   1 (autoclean)
fat                    31672   0 (autoclean) [vfat]


************************************************************************=
************

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03d7ffff : System RAM
  00100000-001cb973 : Kernel code
  001cb974-00213a3b : Kernel data
40011000-4001107f : Cyrix Corporation 5530 Audio [Kahlua]
40012000-400120ff : Cyrix Corporation 5530 SMI [Kahlua]
40800000-40ffffff : Cyrix Corporation 5530 Video [Kahlua]
e0000000-e00000ff : Realtek Semiconductor Co., Ltd. RTL-8139
ffff0000-ffffffff : reserved


************************************************************************=
************


/proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
e000-e0ff : Realtek Semiconductor Co., Ltd. RTL-8139
f000-f00f : Cyrix Corporation 5530 IDE [Kahlua]
f000-f007 : ide0
f008-f00f : ide1


************************************************************************=
************

LSPCI -vvv


00:00.0 Host bridge: Cyrix Corporation PCI Master
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 =
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at e000 [size=3D256]
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA =
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-

00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04

00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 40012000 (32-bit, non-prefetchable) [size=3D256]

00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (prog-if 80 =
[Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=3D16]

00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio =
[Kahlua]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 40011000 (32-bit, non-prefetchable) [disabled] =
[size=3D128]

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video =
[Kahlua] (prog-if 00 [VGA])
	Subsystem: Cyrix Corporation: Unknown device 0001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 40800000 (32-bit, non-prefetchable) [size=3D8M]


************************************************************************=
************

/proc/scsi

N/A

************************************************************************=
************
MISC

/mnt/win/image.out was exactly 4294963200 bytes long, when the =
segmentation fault occurred. I expect the next write to that file would =
exceed the 4.xGB file limitation in vfat filesystems. Still- the kernel =
should handle this gracefully.
=20
************************************************************************=
************


DMESG


FAT bread failed
FAT bread failed
fatfs: bogus cluster size
VFS: Can't find a valid MSDOS filesystem on dev 03:40.
FAT bread failed
FAT bread failed
kernel BUG at file.c:79!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c484c6e9>]
EFLAGS: 00010286
eax: 00000019   ebx: 00000000   ecx: 00000004   edx: 00000000
esi: c2fd70a0   edi: c2fd70a0   ebp: c1aeb740   esp: c0bf7e28
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 689, stackpage=3Dc0bf7000)
Stack: c484fc05 c484fd47 0000004f 00000200 00001000 c1aebec0 00000e00 =
c0130f89=20
       c2fd70a0 007fffff c1aeb740 00000001 c1aeba40 c0c4c000 c0bf7e70 =
00000200=20
       007fffff c1aeb740 c02055c0 0000003c 00001000 00000001 c1aebe00 =
c0130645=20
Call Trace: [<c484fc05>] [<c484fd47>] [<c0130f89>] [<c0130645>] =
[<c484c610>] [<c0131620>] [<c484c610>]=20
       [<c484e016>] [<c484c610>] [<c0124705>] [<c484c761>] [<c484c73b>] =
[<c012ea26>] [<c0108f13>] [<c010002b>]=20

Code: 0f 0b 83 c4 0c 66 8b 47 28 89 5d 04 66 89 45 0c 31 c0 8b 5d=20


************************************************************************=
************

Hardware Platform -

Advantech 5820E- 64MB ram. www.advantech.com
Red Hat 7.0- kernel 2.4.1

************************************************************************=
************

hdparm=20


/dev/hda:
 multcount    =3D 16 (on)
 I/O support  =3D  1 (32-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 nowerr       =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 1244/255/63, sectors =3D 19999728, start =3D 0

/dev/hdb:
 multcount    =3D 16 (on)
 I/O support  =3D  1 (32-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 nowerr       =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 3736/255/63, sectors =3D 60030432, start =3D 0


************************************************************************=
************

------_=_NextPart_000_01C0A1CA.BD9BFCDA--
