Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTJUNkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTJUNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:40:45 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:41744 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263068AbTJUNkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:40:32 -0400
Message-ID: <000e01c397d8$b31cb900$69c809c0@sierbla.int>
Reply-To: "laurent.miaille" <administrateur@sierbla.com>
From: "laurent.miaille" <laurent.miaille@sierbla.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM
Date: Tue, 21 Oct 2003 15:39:06 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C397E9.765211D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C397E9.765211D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi, 

Here's a bug report we had yesterday:
The machine was completely stopped, keyboard and mouse 
were not active, we could ping the machine but no access to its files.
Only one solution: reboot the machine. We ' re looking for some 
information about this crash. Thanks a lot if you can help us.
I send you a .txt file with all the kernel information and the last 
lines in the log we had.
Thanks a lot.

Laurent. 

------=_NextPart_000_000B_01C397E9.765211D0
Content-Type: text/plain;
	name="bug_report_21_10_03.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bug_report_21_10_03.txt"

Last lines before crashing we had in the logs:

Oct 18 04:44:07 juliette kernel: kernel BUG at dcache.c:362!
Oct 18 04:44:07 juliette kernel: invalid operand: 0000
Oct 18 04:44:07 juliette kernel: ide-cd cdrom cmpci soundcore radeon =
agpgart nfsd parport_pc lp parport autofs=20
Oct 18 04:44:07 juliette kernel: CPU:    0
Oct 18 04:44:07 juliette kernel: EIP:    0010:[<c01538d1>]    Not =
tainted
Oct 18 04:44:07 juliette kernel: EFLAGS: 00013202
Oct 18 04:44:07 juliette kernel:=20
Oct 18 04:44:07 juliette kernel: EIP is at prune_dcache [kernel] 0x91 =
(2.4.18-14)
Oct 18 04:44:07 juliette kernel: eax: 00000020   ebx: ccae5db8   ecx: =
ccae5000   edx: ccae5e38
Oct 18 04:44:07 juliette kernel: esi: ccae5da0   edi: dc3ff3e0   ebp: =
00007038   esp: dffddfac
Oct 18 04:44:07 juliette kernel: ds: 0018   es: 0018   ss: 0018
Oct 18 04:44:07 juliette kernel: Process kswapd (pid: 5, =
stackpage=3Ddffdd000)
Oct 18 04:44:07 juliette kernel: Stack: df048360 ccae5d20 dffdc000 =
00000054 dffdc000 00000000 dffdc245 0008e000=20
Oct 18 04:44:07 juliette kernel:        c0153d04 00009188 c0136c2e =
00000006 000001f0 c23a0018 00010f00 c23a5fb8=20
Oct 18 04:44:07 juliette kernel:        c0105000 c010744e 00000000 =
c0136b60 00000000=20
Oct 18 04:44:07 juliette kernel: Call Trace: [<c0153d04>] =
shrink_dcache_memory [kernel] 0x24 (0xdffddfcc))
Oct 18 04:44:07 juliette kernel: [<c0136c2e>] kswapd [kernel] 0xce =
(0xdffddfd4))
Oct 18 04:44:07 juliette kernel: [<c0105000>] stext [kernel] 0x0 =
(0xdffddfec))
Oct 18 04:44:07 juliette kernel: [<c010744e>] kernel_thread [kernel] =
0x2e (0xdffddff0))
Oct 18 04:44:07 juliette kernel: [<c0136b60>] kswapd [kernel] 0x0 =
(0xdffddff8))
Oct 18 04:44:07 juliette kernel:=20
Oct 18 04:44:07 juliette kernel:=20
Oct 18 04:44:07 juliette kernel: Code: 0f 0b 6a 01 82 aa 25 c0 8d 43 f8 =
8b 48 04 8b 53 f8 89 11 89=20

Kernel Information:

Kernel Version:=20

Linux version 2.4.18-14 (bhcompile@stripples.devel.redhat.com)=20
(gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Sep 4 =
13:35:50 EDT 2002=0A=



Processor information:

processor	: 0=0A=
vendor_id	: GenuineIntel=0A=

cpu family	: 15=0A=
model		: 2=0A=

model name	: Intel(R) Pentium(R) 4 CPU 1.80GHz=0A=
stepping	: 4=0A=

cpu MHz		: 1816.131=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=

hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=

fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=

flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=0A=
bogomips	: 3609.95=0A=
=0A=


Module information:

ide-cd                 33608   0 (autoclean)=0A=
cdrom                  33696   0 (autoclean) [ide-cd]=0A=

cmpci                  35944   0 (autoclean)=0A=
soundcore               6532   4 (autoclean) [cmpci]=0A=

radeon                 93976   1=0A=
agpgart                43072   3=0A=

nfsd                   79920   8 (autoclean)=0A=
parport_pc             19108   1 (autoclean)=0A=

lp                      8996   0 (autoclean)=0A=
parport                37152   1 (autoclean) [parport_pc lp]=0A=

autofs                 13348   0 (autoclean) (unused)=0A=
nfs                    82564   1 (autoclean)=0A=

lockd                  58064   1 (autoclean) [nfsd nfs]=0A=
sunrpc                 79324   1 (autoclean) [nfsd nfs lockd]=0A=

3c59x                  30640   1=0A=
iptable_filter          2412   0 (autoclean) (unused)=0A=

ip_tables              14936   1 [iptable_filter]=0A=
aic7xxx               137204   2 (autoclean)=0A=

sd_mod                 13584   4 (autoclean)=0A=
scsi_mod              107176   2 (autoclean) [aic7xxx sd_mod]=0A=

mousedev                5524   1=0A=
keybdev                 2976   0 (unused)=0A=

hid                    22244   0 (unused)=0A=
input                   5888   0 [mousedev keybdev hid]=0A=

usb-uhci               26188   0 (unused)=0A=
usbcore                77024   1 [hid usb-uhci]=0A=

ext3                   70368   9=0A=
jbd                    52212   9 [ext3]=0A=


Loaded driver and hardware information:

- ioports:
0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=

0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00f0-00ff : fpu=0A=
0170-0177 : ide1=0A=

01f0-01f7 : ide0=0A=
02f8-02ff : serial(auto)=0A=
0330-0331 : cmpci Midi=0A=
0376-0376 : ide1=0A=

0378-037a : parport0=0A=
0388-038b : cmpci FM=0A=
03c0-03df : vga+=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial(auto)=0A=

0cf8-0cff : PCI conf1=0A=
a000-a01f : Intel Corp. 82801BA/BAM USB (Hub #2)=0A=
  a000-a01f : usb-uhci=0A=

a400-a41f : Intel Corp. 82801BA/BAM USB (Hub #1)=0A=
  a400-a41f : usb-uhci=0A=

a800-a80f : Intel Corp. 82801BA IDE U100=0A=
  a800-a807 : ide0=0A=
  a808-a80f : ide1=0A=
b000-bfff : PCI Bus #02=0A=

b000-b07f : 3Com Corporation 3c905C-TX/TX-M [Tornado]=0A=
    b000-b07f : 02:0c.0=0A=

b400-b4ff : Adaptec AHA-7850=0A=
  b800-b8ff : C-Media Electronics Inc CM8738=0A=

b800-b8ff : cmpci=0A=
d000-dfff : PCI Bus #01=0A=
  d800-d8ff : ATI Technologies Inc Radeon VE QY=0A=


- iomem:
00000000-0009fbff : System RAM=0A=
0009fc00-0009ffff : reserved=0A=
000a0000-000bffff : Video RAM area=0A=

000c0000-000c7fff : Video ROM=0A=
000f0000-000fffff : System ROM=0A=
00100000-1ffebfff : System RAM=0A=
 =20
00100000-0024b8dd : Kernel code=0A=
  0024b8de-003457a3 : Kernel data=0A=
1ffec000-1ffeefff : ACPI Tables=0A=

1ffef000-1fffefff : reserved=0A=
1ffff000-1fffffff : ACPI Non-volatile Storage=0A=
ee000000-eeffffff : PCI Bus #02=0A=
 =20
ee000000-ee00007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]=0A=
  ee800000-ee800fff : Adaptec AHA-7850=0A=
   =20
ee800000-ee800fff : aic7xxx=0A=
ef000000-efdfffff : PCI Bus #01=0A=
  ef000000-ef00ffff : ATI Technologies Inc Radeon VE QY=0A=

efe00000-efefffff : PCI Bus #02=0A=
eff00000-f7ffffff : PCI Bus #01=0A=
  f0000000-f7ffffff : ATI Technologies Inc Radeon VE QY=0A=

f8000000-fbffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge=0A=
fec00000-fec00fff : reserved=0A=

fee00000-fee00fff : reserved=0A=
ffff0000-ffffffff : reserved=0A=



PCI information:

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host =
Bridge (rev 04)=0A=
=09
Subsystem: Asustek Computer, Inc.: Unknown device 8070=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
=09
Latency: 0=0A=
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]=0A=
	Capabilities: [e4] #09 [9104]=0A=
=09
Capabilities: [a0] AGP version 2.0=0A=
 Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4=0A=
	=09
Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx1=0A=
=0A=


00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge =
(rev 04) (prog-if 00 [Normal decode])=0A=
=09
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 64=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0=0A=
	I/O behind bridge: 0000d000-0000dfff=0A=
=09
Memory behind bridge: ef000000-efdfffff=0A=
	Prefetchable memory behind bridge: eff00000-f7ffffff=0A=
=09
BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=
=0A=


00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) =
(prog-if 00 [Normal decode])=0A=
=09
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
=09
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 0=0A=
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32=0A=
	I/O behind bridge: 0000b000-0000bfff=0A=
=09
Memory behind bridge: ee000000-eeffffff=0A=
	Prefetchable memory behind bridge: efe00000-efefffff=0A=
=09
BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
=0A=


00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
=09
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 0=0A=
=0A=


00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 =
[Master])=0A=
=09
Subsystem: Asustek Computer, Inc.: Unknown device 8028=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 0=0A=
	Region 0: [virtual] I/O ports at 01f0=0A=
	Region 1: [virtual] I/O ports at 03f4=0A=
=09
Region 2: [virtual] I/O ports at 0170=0A=
	Region 3: [virtual] I/O ports at 0374=0A=
=09
Region 4: I/O ports at a800 [size=3D16]=0A=
=0A=


00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) =
(prog-if 00 [UHCI])=0A=
=09
Subsystem: Asustek Computer, Inc.: Unknown device 8028=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 0=0A=
	Interrupt: pin D routed to IRQ 10=0A=
	Region 4: I/O ports at a400 [size=3D32]=0A=
=0A=


00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) =
(prog-if 00 [UHCI])=0A=
=09
Subsystem: Asustek Computer, Inc.: Unknown device 8028=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 0=0A=
	Interrupt: pin C routed to IRQ 9=0A=
	Region 4: I/O ports at a000 [size=3D32]=0A=
=0A=


01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY =
(prog-if 00 [VGA])=0A=
=09
Subsystem: Palit Microsystems Inc.: Unknown device 5159=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-=0A=
=09
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 64 (2000ns min), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
=09
Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]=0A=
	Region 1: I/O ports at d800 [size=3D256]=0A=
=09
Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=3D64K]=0A=
	Expansion ROM at effe0000 [disabled] [size=3D128K]=0A=
=09
Capabilities: [58] AGP version 2.0=0A=
		Status: RQ=3D47 SBA+ 64bit- FW- Rate=3Dx1,x2,x4=0A=
	=09
Command: RQ=3D31 SBA+ AGP+ 64bit- FW- Rate=3Dx1=0A=
	Capabilities: [50] Power Management version 2=0A=
	=09
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
	=09
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=


02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev =
10)=0A=
=09
Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-=0A=
=09
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 32 (500ns min, 6000ns max)=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: I/O ports at b800 [size=3D256]=0A=
=09
Capabilities: [c0] Power Management version 2=0A=
	Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
	=09
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=


02:09.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)=0A=
=09
Subsystem: Adaptec AHA-2904/Integrated AIC-7850=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 32 (1000ns min, 1000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 9=0A=
=09
Region 0: I/O ports at b400 [disabled] [size=3D256]=0A=
	Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size=3D4K]=0A=
=09
Capabilities: [dc] Power Management version 1=0A=
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
	=09
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=


02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] =
(rev 78)=0A=
=09
Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management =
NIC=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
=09
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=09
Latency: 32 (2500ns min, 2500ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 5=0A=
=09
Region 0: I/O ports at b000 [size=3D128]=0A=
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=3D128]=0A=
=09
Expansion ROM at <unassigned> [disabled] [size=3D128K]=0A=
	Capabilities: [dc] Power Management version 2=0A=
	=09
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
	=09
Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-=0A=
=0A=

------=_NextPart_000_000B_01C397E9.765211D0--

