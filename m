Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSKZPcn>; Tue, 26 Nov 2002 10:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSKZPcm>; Tue, 26 Nov 2002 10:32:42 -0500
Received: from ofree.wp-sa.pl ([212.77.101.203]:50999 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id <S265570AbSKZPci>;
	Tue, 26 Nov 2002 10:32:38 -0500
Message-ID: <3DE38699.6070805@wp.pl>
Date: Tue, 26 Nov 2002 15:35:05 +0100
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <mkkpiotrowski@wp.pl>
User-Agent: Mozilla/5.0 (Windows; U; Win98; PL; rv:1.1) Gecko/20020826
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.20-rc2 (SCSI emulation)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

------------------------------------------------------------------------------------------------
ksymoops 2.4.5 on i586 2.4.20-rc2.  Options used
      -v /home/michal/linux/linux/vmlinux (specified)
      -k /proc/ksyms (specified)
      -l /proc/modules (specified)
      -o /lib/modules/2.4.20-rc2/ (specified)
      -m /boot/System.map-2.4.20-rc2 (specified)

Unable to handle kernel NULL pointer dereference at virtual addres 00000188
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c20913a1>]  Not tained
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c10e1100   edx: c083c440
esi: c10d7ca0   edi: c083c440   ebp: c04f8000   esp: c0203efc
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 407, stackpage=c07a3000)
Stack:  c083c440 c025c4c4 c083c440 c025c344 c0183038 c025c4c4 c083c440 
c10d7ca0
         00000000 c04f8000 c025c4c4 c10d7ca0 c2091579 00000001 c10f2160 
00000000
         c10f2160 c025c4c4 00000202 c025c344 c01834e6 c025c4c4 c2091510 
c1059820
Call Trace: [<c0183038>] [<c2091579>] [<c01834e6>] [<c2091510>] [<c010822d>]
         [<c01083a8>] [<c0105310>] [<c010a818>] [<c0105310>] [<c0105334>]
         [<c01053a2>] [<c0105000>]
Code:   c7 80 88 01 00 00 02 00 00 00 74 81 8b 45 2c 8b 40 24 50 8b


 >>EIP; c20913a1 <END_OF_CODE+d47e/????>   <=====

 >>ecx; c10e1100 <_end+e81b10/1da2a70>
 >>edx; c083c440 <_end+5dce50/1da2a70>
 >>esi; c10d7ca0 <_end+e786b0/1da2a70>
 >>edi; c083c440 <_end+5dce50/1da2a70>
 >>ebp; c04f8000 <_end+298a10/1da2a70>
 >>esp; c0203efc <init_task_union+1efc/2000>

Trace; c0183038 <ide_do_request+b8/1a0>
Trace; c2091579 <END_OF_CODE+d656/????>
Trace; c01834e6 <ide_intr+96/110>
Trace; c2091510 <END_OF_CODE+d5ed/????>
Trace; c010822d <handle_IRQ_event+3d/70>
Trace; c01083a8 <do_IRQ+68/b0>
Trace; c0105310 <default_idle+0/30>
Trace; c010a818 <call_do_IRQ+5/d>
Trace; c0105310 <default_idle+0/30>
Trace; c0105334 <default_idle+24/30>
Trace; c01053a2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c20913a1 <END_OF_CODE+d47e/????>
00000000 <_EIP>:
Code;  c20913a1 <END_OF_CODE+d47e/????>   <=====
    0:   c7 80 88 01 00 00 02      movl   $0x2,0x188(%eax)   <=====
Code;  c20913a8 <END_OF_CODE+d485/????>
    7:   00 00 00
Code;  c20913ab <END_OF_CODE+d488/????>
    a:   74 81                     je     ffffff8d <_EIP+0xffffff8d>
Code;  c20913ad <END_OF_CODE+d48a/????>
    c:   8b 45 2c                  mov    0x2c(%ebp),%eax
Code;  c20913b0 <END_OF_CODE+d48d/????>
    f:   8b 40 24                  mov    0x24(%eax),%eax
Code;  c20913b3 <END_OF_CODE+d490/????>
   12:   50                        push   %eax
Code;  c20913b4 <END_OF_CODE+d491/????>
   13:   8b 00                     mov    (%eax),%eax

<0> Kernel panic: Aiee killing interupt handler!
------------------------------------------------------------------------------------------------

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

