Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbSKUNmA>; Thu, 21 Nov 2002 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSKUNmA>; Thu, 21 Nov 2002 08:42:00 -0500
Received: from ofree.wp-sa.pl ([212.77.101.203]:62147 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id <S266631AbSKUNly>;
	Thu, 21 Nov 2002 08:41:54 -0500
Message-ID: <3DDCD891.6030808@wp.pl>
Date: Thu, 21 Nov 2002 13:58:57 +0100
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <mkkpiotrowski@wp.pl>
User-Agent: Mozilla/5.0 (Windows; U; Win98; PL; rv:1.1) Gecko/20020826
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.20-rc2 cdn...
Content-Type: multipart/mixed;
 boundary="------------060001070206080603040105"
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001070206080603040105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[1.] - Kernel panic when I mount cdrom (linux 2.4.20-rc2).
[2.] - I make kernel with opt.
	SCSI Support --->
	  <M> SCSI Support
	  <M> SCSI CD-ROM Support
	  (2) Maximum number of CDROM devices that can be loaded as modules
	  <M> SCSI generic support
	ATA/IDE/MFM/RLL support --->
	  <*> ATA/IDE/MFM/RLL support
	  IDE, ATA and ATAPI Block devices --->
	    <M> Include IDE/ATAPI CDROM support
	    <M> SCSI emulation support
	In lilo.conf I wrote append="hdd=ide-scsi"
	In /etc/fstab
		/dev/scd0  /mnt/cdrom iso9660 noauto, owner, ro  00
	And when I try to mount cdrom system crash.
[3.] - IDE SCSI emulation
[4.] - Linux version 2.4.20-rc2 (michal@one.pl) (gcc version 3.2 20020903
	(Red Hat Linux 8.0 3.2-7)) #9 wto lis 19 20:06:22 CET 2002
[5.] - Output of Oops

Unable to handle kernel NULL pointer dereference at virtual addres 00000188
printing eip: c20913a1
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c20913a1>]  Not tained
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c10e1100   edx: c083c440
esi: c10d7ca0   edi: c083c440   ebp: c04f8000   esp: c0203efc
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 407, stackpage=c07a3000)
Stack:	c083c440 c025c4c4 c083c440 c025c344 c0183038 c025c4c4 c083c440 
c10d7ca0
	00000000 c04f8000 c025c4c4 c10d7ca0 c2091579 00000001 c10f2160 00000000
	c10f2160 c025c4c4 00000202 c025c344 c01834e6 c025c4c4 c2091510 c1059820
Call Trace: [<c0183038>] [<c2091579>] [<c01834e6>] [<c2091510>] [<c010822d>]
	[<c01083a8>] [<c0105310>] [<c010a818>] [<c0105310>] [<c0105334>]
	[<c01053a2>] [<c0105000>]
Code:	c7 80 88 01 00 00 02 00 00 00 74 81 8b 45 2c 8b 40 24 50 8b
<0> Kernel panic: Aiee killing interupt handler!
Interupt handler - not syncing

[7.1.] ver_linux

Linux one.pl 2.4.20-rc2 #9 wto lis 19 20:06:22 CET 2002 i586 i586 i386 
GNU/Linux
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         serial ne2k-pci 8390 af_packet ide-scsi scsi_mod 
ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat sb isa-pnp sb_lib uart401 
sound soundcore
rtc unix

[7.2.] /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 132.632
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 264.60

[7.3.] /proc/modules

serial                 48932   1 (autoclean)
ne2k-pci                6752   1
8390                    7788   0 [ne2k-pci]
af_packet              10728   0 (autoclean)
ide-scsi                9616   0
scsi_mod               65204   1 [ide-scsi]
ide-cd                 31588   0
cdrom                  31328   0 [ide-cd]
nls_iso8859-1           3484   1 (autoclean)
nls_cp437               5116   1 (autoclean)
vfat                   11916   1 (autoclean)
fat                    36920   0 (autoclean) [vfat]
sb                      9012   0
isa-pnp                38308   0 [serial sb]
sb_lib                 41006   0 [sb]
uart401                 8068   0 [sb_lib]
sound                  70292   0 [sb_lib uart401]
soundcore               6244   5 [sb_lib sound]
rtc                     7964   0 (autoclean)
unix                   16936   6 (autoclean)

[7.4.] /proc/ioports

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
0220-022f : soundblaster
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
3000-300f : Intel Corp. 82371FB PIIX IDE [Triton I]
   3000-3007 : ide0
   3008-300f : ide1
6000-601f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
   6000-601f : ne2k-pci

/proc/iomem

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-017fffff : System RAM
   00100000-001d0774 : Kernel code
   001d0775-00201c1f : Kernel data
f0000000-f3ffffff : S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX]
ffff0000-ffffffff : reserved

[7.5.] lspci -vvv

00:00.0 Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corp. 82371FB PIIX IDE [Triton I] (rev 02) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at 3000 [size=16]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 6000 [size=32]

00:0a.0 VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX 
or /GX] (rev 16) (prog-if 00 [VGA])
         Subsystem: S3 Inc. 86C775 Trio64V2/DX, 86C785 Trio64V2/GX
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=64M]
         Expansion ROM at <unassigned> [disabled] [size=64K]

[7.7.] /proc/ide/drivers

ide-scsi version 0.9
ide-cdrom version 4.59
ide-disk version 1.12

-------------------------------------------------------------------------------
/proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: E-IDE    Model: CD-ROM Max 50X   Rev: 6.30
   Type:   CD-ROM

-------------------------------------------------------------------------------
/proc/ide/hdd/capacity

2147483647

-------------------------------------------------------------------------------
/proc/ide/hdd/driver

ide-scsi version 0.9

-------------------------------------------------------------------------------
/proc/ide/hdd/identify

85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5665
7236 2e33 304f 452d 4944 4520 4344 2d52
4f4d 204d 6178 2035 3058 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0b00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0407
0003 0078 0096 00e3 0078 0000 0000 0000
0000 0004 0009 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0007 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

-------------------------------------------------------------------------------
/proc/ide/hdd/settings

name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           34              0               69              rw
ide_scsi                0               0               1               rw
init_speed              34              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

--------------060001070206080603040105
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.5 on i586 2.4.20-rc2.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc2/ (default)
     -m /boot/System.map-2.4.20-rc2 (default)

f9C4=0F=83=11=01=8BSD=85=D2t=11=8BK@=01=CA;=15=F0*$=C0=0F=86=E3f=85=C0u=06=
f=C7C6=14f=FFC4=A1=F0*$=C0=89C,V=E8-=F5=FF=FF=8B=86=E8=8BP`=83=CA=04=89P`=
j=01SV=E8u=12=83=C4=10=F6=86t=01=08uif=8BF=08%=FF=FFP=E8=DA=D5=FD=FF=89=04=
$h =E2=1D=C0=E8=1D=9D=FB=FFY=8B=86=9C=01[=8B=90=AC=85=D2u+f=8B=80=98%=FF=FF=
P=E8=A9=D5=FD=FF=89=04$h=97=B6=1D=C0=E8=EC=9C=FB=FF^_[=89=E8^_]=C3=8Dvh=AF=
=B6=1D=C0=E8=D6=9C=FB=FF[=EB=E9=8Dv=8B=87=B8P=8B=86=D0P=8B=86=CCP=8BG$P=8B=
~=0CWh=C1=B6=1D=C0h=D0=B6=1D=C0h`=E2=1D=C0=E8=9F=9C=FB=FF=83=C4 =E9^=FF=FF=
=FFh=C0=E2=1D=C0=89=F6=E8=8B=9C=FB=FFf=8BC6Y=E9=07=FF=FF=FFh =E3=1D=C0=EB=
=EAh=80=E3=1D=C0=EB=E3=8Dvh=E0=E3=1D=C0=EB=D9h@=E4=1D=C0=BD=01=E8Z=9C=FB=FF=
X=E9=82=FE=FF=FF=8Dt&UW1=FFV1=F6S=83=EC=0C=8Bl$ =81=C5=BC=8BE,=8BX=14=C7D=
$=08=8BE$=89D$=049=C6si=8BT$ =8B=92=DC=89=14$1=D2=89=F0=F74$=85=D2u=12=8B=
T$=08=8BE0=8B=04=90B=8Bx4=89T$=08=8B=079=D8rl=8BT$ =89=D9=03=8A=CC9=C8s\=8B=
G=049=D8rL9=C8sH=8BW=089=DAr$=89=D0=8B]=18=01=D89=C8s=19F=83=C7 =89=CB;t$=
=04r=A4=B8=01=83=C4=0C[^_]=C3RVh=A0=E4=1D=C0h=DB=B6=1D=C0=8BD$0P=E8=D6=F0=
=FF=FF=83=C4=141=C0=EB=DBPVh=E0=E4=1D=C0=EB=E1PVh =E5=1D=C0=EB=D8=90=8D=B6=
=8D=BFU1=EDWVS=83=EC=0C=8Bt$ =8B|$$=8BF(=89D$=08=C7D$=04=8B=97=E8=85=D2t"=
=83=E0=01=0F=85m=01f=8B=86=80=01=83=E0=02f=85=C0t=12=C7=87=E8=83=C4=0C[^_=
]=C3=85=D2=0F=84=90=8D=96=A0=01=89=14$=8B=8F=E8QV=E8=8E=92=FF=FF=89=C3XZ=85=
=DB=0F=84=0E=01=8B=96=A0=01=8D=83p=01=89=93p=01=89B=04=8B=14$=89=86=A0=01=
=89P=04f=83{4=0F=84=C6=8BCHP=8BCDP=8BC(Ph=F2=B6=1D=C0h`=E5=1D=C0=E8=AB=9A=
=FB=FFS=E8=E5=B6=FF=FF=8BD$=1C@=89D$=1C=83=C4=18S=E8=03=A5=FE=FF=8B=8F=E8=
[=85=C9=0F=85y=FF=FF=FF=85=EDt0=B8>Q=1D=C0=83=FD=01t=05=B8OM=1E=C0PUf=8BF=
=08%=FF=FFP=E8=10=D3=FD=FF=89=04$h=A0=E5=1D=C0=E8S=9A=FB=FF=83=C4=10=8BT$=
=04=85=D2t6=B8>Q=1D=C0=83|$=04=01t=05=B8OM=1E=C0P=8BD$=08Pf=8BF=08%=FF=FF=
P=E8=D2=D2=FD=FF=89=04$h=E0=E5=1D=C0=E8=15=9A=FB=FF=83=C4=10=8BD$=08=89F(=
=E9=E2=FE=FF=FF=8D=B6=8BC(EPh=F2=B6=1D=C0h =E6=1D=C0=E8=EC=99=FB=FF=83=C4=
=0C=E9K=FF=FF=FF=C7=87=E8=E9Q=FF=FF=FF=90=8Dt&f=8BF=08%=FF=FFP=E8q=D2=FD=FF=
=89=04$h`=E6=1D=C0=E8=B4=99=FB=FF=8BF(=83=E0=FE=89F([=8B=97=E8X=E9a=FE=FF=
=FF=8D=B4&=8D=BC'W=B8=01V1=D2SVV=8B|$=18=8DO=FE=0F=A5=C2=D3=E0=83=E1 t=04=
=89=C21=C0=89=04$=8D4?=83=04$=0C=89T$=04=8DN=FC=B8=01=83T$=041=D2=0F=A5=C2=
=D3=E0=83=E1 t=04=89=C21=C0=01=04$=8Dt7=FA=89=F1=B8=01=11T$=041=D2=0F=A5=C2=
=D3=E0=83=E1 t=04=89=C21=C0=01=04$=89=F9=11T$=04=8B=1C$=8Bt$=04=0F=A5=DE=D3=
=E3=F7=C1 t=04=89=DE1=DB=B8=01=89t$=04=D3=E0=89=C21=F6=C1=FA=1F=BF=02)=C6=
=89=1C$=19=D79|$=04|=7F=049=F3v=07=894$=89|$=04=8B=04$=8BT$=04Y[[^_=C3=90=
=89=F6UW=BF=04VS=83=ECD=8Bt$X=C7D$<=01=C7D$0=01=C7D$,=C7D$@f=8Bn=08=8D=9E=
=BC=89=EA=0F=B6=C6=C7D$ =02=8B=14=85=A0=8F%=C0=85=D2t=12=89=E8%=FF=8B=04=82=
=85=C0t=04=89D$ ;|$ }=04=8B|$ =C7=83=B8=C7=83=BC=C7=83=C0j=8DD$DPS=8DD$HP=
=8BL$lQ=E8=8D=F3=FF=FF=83=C4=14=85=C0u=16f=C7F=081=C0=83=C4D[^_]=C3=8D=B6=
=89=E9=89~=0C=81=E1=FF=FFW=89L$ Q=E8*=C3=FD=FF=81=FF=04XZt=13=8BD$<1=D2=C1=
=E0
<4>Warning: null TTY for (%s) in %s
Pid: %d, comm: %20s
EIP: %04x:[<%08lx>] CPU: %d EFLAGS: %08lx    %s
 DS: %04x ES: %04x
Call Trace:    [<%08lx>]
Stack:=20
Code: %02x  Bad EIP value.<bad filename>kernel BUG at %s:%d!
ESI: %08lx EDI: %08lx EBP: %08lxCR0: %08lx CR2: %08lx CR3: %08lx CR4: %08=
lx
WARNING: dead process %8s still has LDT? <%p>
EIP:    %04x:[<%08lx>]    %s
EFLAGS: %08lx
eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx
esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx
ds: %04x   es: %04x   ss: %04x
Process %s (pid: %d, stackpage=3D%08lx)Uhhuh. NMI received. Dazed and con=
fused, but trying to continue
NMI: IOCK error (debug interrupt?)
Uhhuh. NMI received for unknown reason %02x.
<6>AMD K6 stepping B detected - <6>K6 BUG %ld %d (Report these if test re=
port is incorrect)
<5>Intel Pentium with F0 0F bug - workaround enabled.
fdiv_bug        : %s
hlt_bug         : %s
f00f_bug        : %s
coma_bug        : %s
<6> *** Building an SMP kernel may evade the bug some of the time.
<6>%s machine detected. Mousepad Resume Bug workaround enabled.
<3>PCI: BIOS BUG #%x[%08x] found
PAE BUG #01!
<1>*pde =3D %08lx
<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle ke=
rnel paging requestremap_area_pte: page already exists
kernel BUG in header file at line %d
<3>inter_module_register: duplicate im_name '%s'<3>Aiee, inter_module_reg=
ister: cannot kmalloc entry for '%s'
Aiee, killing interrupt handler!Attempted to kill the idle task!Attempt t=
o kill tasklet from interrupt
%-13.13s  %08lX %5lu %5d %6d %5d %7d %5d (L-TLB)
Using defaults from ksymoops -t elf32-i386 -a i386
 (NOTLB)
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  %-13.13s

>>EIP; 00000008 Before first symbol   <=3D=3D=3D=3D=3D

Pid:    %d
<4>Warning: dev (%s) tty->count(%d) !=3D #fd's(%d) in %s
<4>Warning: kfree_skb on hard IRQ %p
<4>Warning: kfree_skb passed an skb still on a list (from %p).
<2>Dead loop on virtual device %s, fix it urgently!
 face |bytes    packets errs drop fifo frame compressed multicast|bytes  =
  packets errs drop fifo colls carrier compressed
<2>Bug in ip_route_input_slow(). Please, report

1 warning issued.  Results may not be reliable.

--------------060001070206080603040105--

