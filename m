Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRIPN6b>; Sun, 16 Sep 2001 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRIPN6X>; Sun, 16 Sep 2001 09:58:23 -0400
Received: from pec-137-52.tnt10.m2.uunet.de ([149.225.137.52]:45067 "EHLO
	bilbo.local") by vger.kernel.org with ESMTP id <S272265AbRIPN6K>;
	Sun, 16 Sep 2001 09:58:10 -0400
Date: Sun, 16 Sep 2001 16:00:17 +0200
From: Walter Hofmann <walterh@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: oops with 2.2.19 in get_empty_inode
Message-ID: <20010916160017.A16225@aragorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: 

Kernel exception at get_empty_inode.


[2.] Full description of the problem/report:

I was running the VA Cerberus tester plus "find /usr" on this system for
12hours or so without a problem. I then switchend on DMA for /dev/hda
and within minutes got this oops.
I'm not sure if this was caused by DMA directly or just be the
additional load after switching on DMA.
There were no log entries related to DMA (or any other entries), and DMA
was still switched on after the Oops.

/dev/hda:
 
 Model=WDC WD600AB-22BVA0, FwRev=21.01H21, SerialNo=WD-WMA7E1732138
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117231408
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 
/dev/hdb:
 
 Model=IOMEGA ZIP 100 ATAPI, FwRev=14.A, SerialNo=
 Config={ SpinMotCtl Removeable nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:500,w/IORDY:500}
 PIO modes: pio0
 DMA modes:
 
/dev/hdc:
 
 Model=Pioneer DVD-ROM ATAPIModel DVD-116 0109, FwRev=E1.09, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=13395, BuffSize=64kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3
udma4
 
/dev/hdd:
 
 Model=LITE-ON LTR-12101B, FwRev=LS3B, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=1024kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2



[4.] Kernel version (from /proc/version):

Linux version 2.2.19 (herbert@gondolin) (gcc version 2.7.2.3) #1 Sun Apr
8 13:42:11 EST 2001

(Binary from Debian)


[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /boot/System.map-2.2.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000004
current->tss.cr3 = 0efda000, %cr3 = 0efda000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0134ce0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 00000000   ebx: c337a000   ecx: a2d4cb8a   edx: 00000000
esi: d9b4bc80   edi: ddbbad90   ebp: bfffdafc   esp: c337bf78
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 2041, process nr: 120, stackpage=c337b000)
Stack: c337a000 c012eb32 c337a000 c337bfb8 bfffdaf4 bfffdafc ffffffe9 d99392d0 
       08fc4000 c010e321 c337bfb8 c337a000 bfffdaf4 bfffdbb4 bfffdafc d99cf8c0 
       c010a2f9 c337bfc4 c010a1e0 bfffdaf4 08fc42a6 08fc420c bfffdaf4 bfffdbb4 
Call Trace: [<c012eb32>] [<c010e321>] [<c010a2f9>] [<c010a1e0>] 
Code: 89 50 04 89 02 ff 0d f8 a8 2b c0 8d 59 f8 8d 53 08 a1 dc a8 

>>EIP; c0134ce0 <get_empty_inode+14/90>   <=====
Trace; c012eb32 <do_pipe+32/18c>
Trace; c010e321 <sys_pipe+15/b4>
Trace; c010a2f9 <error_code+35/40>
Trace; c010a1e0 <system_call+34/38>
Code;  c0134ce0 <get_empty_inode+14/90>
00000000 <_EIP>:
Code;  c0134ce0 <get_empty_inode+14/90>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0134ce3 <get_empty_inode+17/90>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0134ce5 <get_empty_inode+19/90>
   5:   ff 0d f8 a8 2b c0         decl   0xc02ba8f8
Code;  c0134ceb <get_empty_inode+1f/90>
   b:   8d 59 f8                  lea    0xfffffff8(%ecx),%ebx
Code;  c0134cee <get_empty_inode+22/90>
   e:   8d 53 08                  lea    0x8(%ebx),%edx
Code;  c0134cf1 <get_empty_inode+25/90>
  11:   a1 dc a8 00 00            mov    0xa8dc,%eax


2 warnings issued.  Results may not be reliable.


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here) 

Linux aragorn 2.2.19 #1 Sun Apr 8 13:42:11 EST 2001 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs ide-tape ide-floppy nfsd autofs lockd sunrpc
pcmcia_core af_packet 8139too via82cxxx_audio soundcore ac97_codec unix


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1196.614
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 2385.51


[7.3.] Module information (from /proc/modules):

nfs                    40560   0 (autoclean)
ide-tape               19184   0
ide-floppy              8544   0
nfsd                  159776   8 (autoclean)
autofs                  9152   1 (autoclean)
lockd                  41760   1 (autoclean) [nfs nfsd]
sunrpc                 57808   1 (autoclean) [nfs nfsd lockd]
pcmcia_core            42400   0
af_packet               6144   0 (autoclean)
8139too                11856   1
via82cxxx_audio         8464   0
soundcore               2448   2 [via82cxxx_audio]
ac97_codec              7376   0 [via82cxxx_audio]
unix                   11344  90 (autoclean)


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
c400-c407 : ide0
c408-c40f : ide1
d000-d0ff : via82cxxx
e000-e0ff : eth0


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Region 1: Memory at e2000000 (32-bit, prefetchable)
	Region 2: I/O ports at c000 [disabled]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c400
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at c800
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at cc00
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at d000
	Region 1: I/O ports at d400
	Region 2: I/O ports at d800
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000
	Region 1: Memory at e2001000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Vital Product Data

01:05.0 VGA compatible controller: nVidia Corporation NV11 (rev a1) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)
	Region 1: Memory at d8000000 (32-bit, prefetchable)
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

