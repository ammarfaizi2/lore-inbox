Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKDV4S>; Sat, 4 Nov 2000 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKDV4I>; Sat, 4 Nov 2000 16:56:08 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:13331 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S129043AbQKDVzw>;
	Sat, 4 Nov 2000 16:55:52 -0500
Date: Sat, 04 Nov 2000 16:55:46 -0500
From: Brad Corsello <bcorsello@usa.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  kernel oops on boot in 2.4.0 test10
Reply-To: bcorsello@usa.net
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <0d19638042204b0NYCSMTP1@nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: 
	kernel oops on boot in 2.4.0 test 10 (i386)

[2.] Full description of the problem/report:
	On every boot of test 10, I get a kernel oops very early on.
	Is reproducible (happens every boot).
	I've successfully booted 2.3 kernels on this machine, but get this
	kernel oops on boot every time with the later 2.4.0tests (from about
	test5 on -- that's from memory, may not be accurate).
	I am successfully running a late 2.2 kernel:  Linux version 2.2.15-4mdk
(chmou@kenobi.mandrakesoft.com) (gcc version 2.95.3 19991030 (prerelease)) #1
Wed May 10 15:31:30 CEST 2000

[3.] Keywords (i.e., modules, networking, kernel):
	kernel oops on boot

[4.] Kernel version (from /proc/version):
	2.4.0-test10 (final) (not from /proc/version)

[5.] Output of Oops.. message (if applicable) with symbolic information =
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.3.4 on i586 2.2.15-4mdk.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel paging request at virtual address ffffff7f
c0144c30
*pde =3D 00001063
Oops: 0002
CPU: 0
EFLAGS: 00010246
eax: 00000000 ebx: ffffff7f ecx: 00000013 edx: f7fbf020 =

esi: 00000000 edi: ffffff7f ebp: 00000002 esp: c1ef7f68 =

ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=3Dc1ef7000)
Stack: c1ef7fb0 00000000 c1efdda0 c1ef8400 00000001 00000010 0000004f
c1ef7fb0
       c0194d36 c1ef7fb0 c1efdea0 c1ef7fb0 c01f9ef2 00000001 c1ef8400
c021fd20
       c0105000 00000001 00003130 c01f9f17 c02336de c01f9f17 c0233706
c1ef8400
Call Trace: [<c0194d36>] [c01f9cf2>] [<c0105000>] [<c01f9f17>] [<c01f9f17=
>]
[<c0105000>] [<c0107007>] [<c0107437>]
Code: f3 ab 8d 55 01 8d 43 4c 89 54 24 10 8b 74 24 1c c1 6c 24 10
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c0194d36 <isapnp_proc_attach_device+36/94>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0107007 <init+7/150>
Trace; c0107437 <kernel_thread+23/30>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  00000002 Before first symbol
   2:   8d 55 01                  lea    0x1(%ebp),%edx
Code;  00000005 Before first symbol
   5:   8d 43 4c                  lea    0x4c(%ebx),%eax
Code;  00000008 Before first symbol
   8:   89 54 24 10               mov    %edx,0x10(%esp,1)
Code;  0000000c Before first symbol
   c:   8b 74 24 1c               mov    0x1c(%esp,1),%esi
Code;  00000010 Before first symbol
  10:   c1 6c 24 10 00            shrl   $0x0,0x10(%esp,1)

Kernel panic: Attempted to kill the idle task!

[6.] A small shell script or example program which triggers the
     problem (if possible)
	Not applicable

[7.] Environment
	Not applicable

[7.1.] Software (add the output of the ver_linux script here)
[But note: I compiled the kernel and modules with egcs 2.1.1]
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux nimrod 2.2.15-4mdk #1 Wed May 10 15:31:30 CEST 2000 i586 unknown
Kernel modules         found
Gnu C                  2.95.3
Binutils               2.9.5.0.31
Linux C Library        ..
ldd: missing file arguments
Try `ldd --help' for more information.
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.6
Mount                  2.10h
Net-tools              (1999-04-20)
Kbd                    [option...]
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               =

Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 198.955487
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mmx
bogomips        : 397.31


[7.3.] Module information (from /proc/modules):
Not applicable

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem=
)
cat /proc/ioports
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
7000-707f : eth0
7800-7807 : ide0
7808-780f : ide1

[no /proc/iomem]


[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1521 [Aladdin III] (rev 1d)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1521 Aladdin III CPU Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 32 set

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1523 (rev b3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+
<MAbort+ >SERR- <PERR-
	Latency: 0 set

00:04.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT
[Mach64 GT] (rev 9a) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 1: I/O ports at <unassigned> [disabled]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5219 (rev 20) (prog-if
fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 2 min, 4 max, 32 set
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 7800

00:0c.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 02)
(prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 set
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 08100000 (32-bit, non-prefetchable)

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 03101000 (32-bit, prefetchable)

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 03102000 (32-bit, prefetchable)

00:0e.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)
(prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 04000000 (32-bit, non-prefetchable)
	Region 1: Memory at 06000000 (32-bit, prefetchable)
	Region 2: I/O ports at 7400
	Expansion ROM at 03120000 [disabled]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
	Subsystem: Kingston Technologies: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 20 min, 40 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 7000
	Region 1: Memory at 03100000 (32-bit, non-prefetchable)
	Expansion ROM at 03140000 [disabled]


[7.6.] SCSI information (from /proc/scsi/scsi)
Not applicable

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Not applicable


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
