Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSH1L7Y>; Wed, 28 Aug 2002 07:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSH1L7Y>; Wed, 28 Aug 2002 07:59:24 -0400
Received: from mex.italtel.it ([138.132.117.4]:41132 "EHLO mex.italtel.it")
	by vger.kernel.org with ESMTP id <S318809AbSH1L7T>;
	Wed, 28 Aug 2002 07:59:19 -0400
Message-ID: <3D6CA7CC.685FE47@imads2.milano.italtel.it>
Date: Wed, 28 Aug 2002 12:37:00 +0200
From: Corrado Cappello <Corrado.Cappello@italtel.it>
Organization: Italtel S.p.A.
X-Mailer: Mozilla 4.5 [it] (WinNT; I)
X-Accept-Language: it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Daniele.Garbagnati@italtel.it, Gianmarco.Vocino@italtel.it,
       Corrado.Cappello@italtel.it, cappelc@hotmail.com
Subject: PROBLEM: restore file in tar from a magnetic tape device attached on 
 SCSI
Content-Type: multipart/mixed;
 boundary="------------10637513ACC79E12EE40F3A2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Questo è un messaggio multi-parte scritto in formato MIME.
--------------10637513ACC79E12EE40F3A2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 
+----------------------------------+
 Corrado Cappello Italtel spa
 TPD-SP-PE-U
 E-Mail:corrado.cappello@italtel.it
	Phone	(+39.2)43888991
	Fax  	(+39.2)43888705
	Mobile	(+39.2)43884212
+----------------------------------+
--------------10637513ACC79E12EE40F3A2
Content-Type: text/plain; charset=us-ascii;
 name="oopsFull.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oopsFull.txt"

Problem: restore file in archive file format from a magnetic tape  device attached on SCSI BUS.


When i restore file by tar -xvf /dev/st0 and recorded on tape there is the following list:

-rw-r--r--    1 cappelc  cappelc  184854528 lug 26 16:06 cdimg.iso

the system panics.

/proc/version's output is:

Linux version 2.4.18 (kernelu@ic3sd04) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-87)) #5 ven lug 26 08:22:19 CEST 2002

ksymoops's output is:

ksymoops 2.4.0 on alpha 2.4.18.  Options used
     -v /boot/vmlinux-2.4.18 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

Unable to handle kernel paging request at virtual address 0000000000000230
swapper(0): Oops 1
pc = [<fffffc000043ef74>]  ra = [<fffffc000043ef74>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000000  t1 = ffffffffffe20fe0
t2 = 0000000000000000  t3 = 0000000000000005  t4 = 000000000000002b
t5 = fffffffffffffc18  t6 = 000000000008e44d  t7 = fffffc000056c000
s0 = 0000000000000000  s1 = fffffc0000e6e4c0  s2 = 0000000000000006
s3 = fffffc0000e6e400  s4 = fffffc00005d8dd8  s5 = 0000000000000006
s6 = 0000000000000000
a0 = fffffc0000f6e140  a1 = 0000000000000000  a2 = fffffc000056fed8
a3 = 0000000000000080  a4 = 0000000000000001  a5 = 0000000000000400
t8 = fffffc00005d9a80  t9 = 0000000000001fff  t10= fffffffffffffffe
t11= 0000000000001fff  pv = fffffc00003225d0  at = fffffc0000590080
gp = fffffc000061e1a0  sp = fffffc000056fdf8
Trace: fffffc000043ebac fffffc0000315954 fffffc0000316354 fffffc0000323954 fffffc
0000316988 fffffc0000310b38 fffffc00003122a0 fffffc0000327e70 fffffc0000312280 f
ffffc000035ee40 fffffc00003100a4 fffffc000031001c 
Code: b26901d4  a0300000  443ff001  402075a1  e4200004  d3400049 <b0090230> c3e0

>>PC;  fffffc000043ef74 <isp1020_intr_handler+3a4/4c0>   <=====
Trace; fffffc000043ebac <do_isp1020_intr_handler+2c/50>
Trace; fffffc0000315954 <handle_IRQ_event+b4/130>
Trace; fffffc0000316354 <handle_irq+134/1d0>
Trace; fffffc0000323954 <dp264_srm_device_interrupt+34/50>
Trace; 0000000000fffffc Before first symbol

Code;  fffffc000043ef5c <isp1020_intr_handler+38c/4c0>
0000000000000000 <_PC>:
Code;  fffffc000043ef5c <isp1020_intr_handler+38c/4c0>
   0:   d4 01 69 b2       stl  a3,468(s0)
Code;  fffffc000043ef60 <isp1020_intr_handler+390/4c0>
   4:   00 00 30 a0       ldl  t0,0(a0)
Code;  fffffc000043ef64 <isp1020_intr_handler+394/4c0>
   8:   01 f0 3f 44       and  t0,0xff,t0
Code;  fffffc000043ef68 <isp1020_intr_handler+398/4c0>
   c:   a1 75 20 40       cmpeq        t0,0x3,t0
Code;  fffffc000043ef6c <isp1020_intr_handler+39c/4c0>
  10:   04 00 20 e4       beq  t0,24 <_PC+0x24> fffffc000043ef80 <isp1020_intr_handler+3b0/4c0>
Code;  fffffc000043ef70 <isp1020_intr_handler+3a0/4c0>
  14:   49 00 40 d3       bsr  ra,13c <_PC+0x13c> fffffc000043f098 <isp1020_return_status+8/140>
Code;  fffffc000043ef74 <isp1020_intr_handler+3a4/4c0>   <=====
  18:   30 02 09 b0       stl  v0,560(s0)   <=====
Code;  fffffc000043ef78 <isp1020_intr_handler+3a8/4c0>
  1c:   e0 c3 00 00       call_pal     0xc3e0

Environment:

Software:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ic3sd04 2.4.18 #6 mer ago 28 08:54:02 CEST 2002 alpha unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11e
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         autofs


Processor information:
cpu		: Alpha
cpu model		: EV6
cpu variation	: 7
cpu revision		: 0
cpu serial number	: 
system type		: Tsunami
system variation	: Webbrick
system revision		: 0
system serial number	: AY0
cycle frequency [Hz]	: 462962962 
timer frequency [Hz]	: 1024.00
page size [bytes]	: 8192
phys. address bits	: 44
max. addr. space #	: 255
BogoMIPS		: 921.84
kernel unaligned acc	: 0 (pc=0,va=0)
user unaligned acc	: 0 (pc=0,va=0)
platform string	: COMPAQ AlphaServer DS10 466 MHz
cpus detected	: 1	

Module information:

autofs                 15392   1 (autoclean)

Loaded driver and hardware information:

00000000-01ffffff : PCI IO bus 0
00000000-0000001f : dma1
00000020-0000003f : pic1
00000040-0000005f : timer
00000060-0000006f : keyboard
00000070-00000080 : rtc
00000070-0000007f : rtc
000000a0-000000bf : pic2
000000c0-000000df : dma2
00000170-00000177 : ide1
000002f8-000002ff : serial(auto)
00000376-00000376 : ide1
000003f0-000003f5 : floppy
000003f7-000003f7 : floppy DIR
000003f8-000003ff : serial(auto)
00008000-000080ff : QLogic Corp. ISP1020
00008000-000080fe : qlogicisp
00008400-0000847f : Digital Equipment Corporation DECchip 21142/43
00008400-0000847f : tulip
00008480-000084ff : Digital Equipment Corporation DECchip 21142/43 (#2)
00008480-000084ff : tulip
00008800-0000887f : Digi International AccelePort Xr/J
00008880-0000888f : Acer Laboratories Inc. [ALi] M5229 IDE
00008890-0000889f : Acer Laboratories Inc. [ALi] M5229 IDE
000088a0-000088af : Acer Laboratories Inc. [ALi] M5229 IDE
000088a0-000088a7 : ide0
000088a8-000088af : ide1
000088b0-000088b3 : Acer Laboratories Inc. [ALi] M5229 IDE
000088b4-000088b7 : Acer Laboratories Inc. [ALi] M5229 IDE
00009000-0000907f : tulip
00009080-000090ff : tulip
00009400-0000947f : tulip
00009480-000094ff : tulip

00000000-ffffffff : PCI mem bus 0
 09000000-097fffff : Texas Instruments TVP4020 [Permedia 2]
 09800000-09ffffff : Texas Instruments TVP4020 [Permedia 2]
 0a000000-0a3fffff : Digi International AccelePort Xr/J
 0a400000-0a43ffff : Digital Equipment Corporation DECchip 21142/43
 0a440000-0a47ffff : Digital Equipment Corporation DECchip 21142/43 (#2)
 0a480000-0a49ffff : Texas Instruments TVP4020 [Permedia 2]
 0a4a0000-0a4affff : Texas Instruments TVP4020 [Permedia 2]
 0a4b0000-0a4bffff : QLogic Corp. ISP1020
 0a4c0000-0a4c0fff : QLogic Corp. ISP1020
 0a4c1000-0a4c17ff : Digi International AccelePort Xr/J
 0a4c2000-0a4c23ff : Digital Equipment Corporation DECchip 21142/43
 0a4c2000-0a4c23ff : tulip
 0a4c3000-0a4c33ff : Digital Equipment Corporation DECchip 21142/43 (#2)
 0a4c3000-0a4c33ff : tulip
 0a4c4000-0a4c407f : Digi International AccelePort Xr/J
 0a600000-0a60007f : tulip
 0a601000-0a60107f : tulip
 0a602000-0a60207f : tulip
 0a603000-0a60307f : tulip

 PCI information:

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at 8400 [size=128]
	Region 1: Memory at 000000000a4c2000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 000000000a400000 [disabled] [size=256K]

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 30
	Region 0: I/O ports at 8480 [size=128]
	Region 1: Memory at 000000000a4c3000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 000000000a440000 [disabled] [size=256K]

00:0d.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if f0)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 8880 [size=16]
	Region 1: I/O ports at 88b4 [size=4]
	Region 2: I/O ports at 8890 [size=16]
	Region 3: I/O ports at 88b4 [size=4]
	Region 4: I/O ports at 88a0 [size=16]

00:0e.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] (rev 01) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0a32
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (48000ns min, 48000ns max)
	Interrupt: pin A routed to IRQ 35
	Region 0: Memory at 000000000a480000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 0000000009000000 (32-bit, non-prefetchable) [size=8M]
	Region 2: Memory at 0000000009800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 000000000a4a0000 [disabled] [size=64K]

00:0f.0 Communication controller: Digi International AccelePort Xr/J
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 39
	Region 0: Memory at 000000000a4c4000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at 8800 [size=128]
	Region 2: Memory at 000000000a000000 (32-bit, non-prefetchable) [size=4M]
	Expansion ROM at 000000000a4c1000 [disabled] [size=2K]

00:10.0 SCSI storage controller: Q Logic ISP1020 (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at 000000000a4c0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 000000000a4b0000 [disabled] [size=64K]

00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: 0a500000-0a6fffff
	Prefetchable memory behind bridge: 0000000000100000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

01:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 47
	Region 0: I/O ports at 9000 [size=128]
	Region 1: Memory at 000000000a600000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 000000000a500000 [disabled] [size=256K]

01:01.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 46
	Region 0: I/O ports at 9080 [size=128]
	Region 1: Memory at 000000000a601000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 000000000a540000 [disabled] [size=256K]

01:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 45
	Region 0: I/O ports at 9400 [size=128]
	Region 1: Memory at 000000000a602000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 000000000a580000 [disabled] [size=256K]

01:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
	Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 44
	Region 0: I/O ports at 9480 [size=128]
	Region 1: Memory at 000000000a603000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 000000000a5c0000 [disabled] [size=256K]



Scsi information:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: RZ2DD-KS (C) DEC Rev: 0306
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DEC      Model: RZ2DD-KS (C) DEC Rev: 0306
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: DEC      Model: TLZ10    (C) DEC Rev: 04a8
  Type:   Sequential-Access                ANSI SCSI revision: 02


Thank you for the attention

C.Cappello (cappelc)
--------------10637513ACC79E12EE40F3A2--

