Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDFDhi>; Thu, 5 Apr 2001 23:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRDFDh3>; Thu, 5 Apr 2001 23:37:29 -0400
Received: from ferret.phonewave.net ([208.138.51.183]:48654 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131157AbRDFDhU>; Thu, 5 Apr 2001 23:37:20 -0400
Date: Thu, 5 Apr 2001 20:35:41 -0700
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OOPS report for L2 cacheable size setting at 512MB on TD5TH dual P200
Message-ID: <20010405203541.A29396@ferret.phonewave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

OOPS report for L2 cacheable size setting at 512MB on TD5TH dual P200

[2.] Full description of the problem/report:

My system board BIOS has two settings for L2 cacheable size: 64MB and
512MB. Previous kernels would lock when initialising the
framebuffer. This one initialises framebuffer but crashes later.

[3.] Keywords (i.e., modules, networking, kernel):

kernel initialisation

[4.] Kernel version (from /proc/version):

Linux version 2.4.3cc (root@heathen) (gcc version 2.95.3 20010315
(Debian release)) #1 SMP Fri Mar 30 14:22:48 PST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)


ksymoops 2.3.7 on i586 2.4.3cc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3cc/ (default)
     -m /boot/System.map-2.4.3cc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(cuecat_process_scancode) not found in System.map.
Ignoring ksyms_base entry
Warning (compare_maps): snd symbol pm_register not found in
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o.  Ignoring
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o.  Ignoring
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o.  Ignoring
/usr/lib/alsa-modules/2.4.3cc/0.5/snd.o entry
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 418146e0
c02f5407
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c02f5407>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02f5468   ebx: c02f53fc   ecx: c02f53f4   edx: c02f53f4
esi: c02f5404   edi: 00000000   ebp: c02ecc60   esp: c1229ef8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c1229000)
Stack: c011db55 c02f53fc c03056a0 00000020 00000000 c02ecc60 c018021e
00000286
       c122bda0 c011a4be c03056a0 00000020 c011a3a7 00000000 00000001
       c02ed060
       00000020 0000000e c011a24d c02ed060 c0305a00 c02ea9c0 0000000e
       c1229f74
Call Trace: [<c011db55>] [<c018021e>] [<c011a4be>] [<c011a3a7>]
[<c011a24d>] [<c01089aa>] [<c010517
       [<c0107050>] [<c0105170>] [<c010519c>] [<c0105202>] [<c011a24d>]
       [<c01089aa>]
Code: c0 04 54 2f c0 0c 54 2f c0 0c 54 2f c0 f4 53 2f c0 68 60 2a

>>EIP; c02f5407 <tv1+207/804>   <=====
Trace; c011db55 <timer_bh+281/2dc>
Trace; c018021e <ide_intr+12a/194>
Trace; c011a4be <bh_action+46/a4>
Trace; c011a3a7 <tasklet_hi_action+4f/7c>
Trace; c011a24d <do_softirq+5d/8c>
Trace; c01089aa <do_IRQ+ea/fc>
Trace; c0107050 <ret_from_intr+0/20>
Trace; c0105170 <default_idle+0/34>
Trace; c010519c <default_idle+2c/34>
Trace; c0105202 <cpu_idle+3e/54>
Trace; c011a24d <do_softirq+5d/8c>
Trace; c01089aa <do_IRQ+ea/fc>
Code;  c02f5407 <tv1+207/804>
0000000000000000 <_EIP>:
Code;  c02f5407 <tv1+207/804>   <=====
   0:   c0 04 54 2f               rolb   $0x2f,(%esp,%edx,2)   <=====
Code;  c02f540b <tv1+20b/804>
   4:   c0 0c 54 2f               rorb   $0x2f,(%esp,%edx,2)
Code;  c02f540f <tv1+20f/804>
   8:   c0 0c 54 2f               rorb   $0x2f,(%esp,%edx,2)
Code;  c02f5413 <tv1+213/804>
   c:   c0                        (bad)
Code;  c02f5414 <tv1+214/804>
   d:   f4                        hlt
Code;  c02f5415 <tv1+215/804>
   e:   53                        push   %ebx
Code;  c02f5416 <tv1+216/804>
   f:   2f                        das
Code;  c02f5417 <tv1+217/804>
  10:   c0 68 60 2a               shrb   $0x2a,0x60(%eax)

Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

TMC TD5TH v1.1 motherboard. L2 cacheable size set to 512MB in the
BIOS. SMP configuration.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 4
cpu MHz         : 199.434
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 398.13

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 4
cpu MHz         : 199.434
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 398.13

[7.3.] Module information (from /proc/modules):

No modules loading at the time it crashes.

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
0213-0213 : isapnp read
0220-022f : Sound Blaster 16
0240-024f : Sound Blaster AWE32/64
02e8-02ef : serial(set)
02f8-02ff : serial(set)
0300-0301 : Sound Blaster AWE32/64 - MPU-401
0330-0331 : Sound Blaster 16 - MPU-401
0376-0376 : ide1
0388-038b : Sound Blaster 16 - FM
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0620-0623 : Sound Blaster AWE32/64 - WaveTable
0a20-0a23 : Sound Blaster AWE32/64 - WaveTable
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : Sound Blaster AWE32/64 - WaveTable
6000-601f : Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II]
  6000-601f : usb-uhci
6100-61ff : Adaptec AHA-7850
6200-627f : Digital Equipment Corporation DECchip 21140 [FasterNet]
  6200-627f : eth0
6300-63ff : ATI Technologies Inc 3D Rage Pro 215GP
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00235c3f : Kernel code
  00235c40-002acfff : Kernel data
e0000000-e0ffffff : ATI Technologies Inc 3D Rage Pro 215GP
  e0000000-e0ffffff : atyfb
e1000000-e1ffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e2000000-e27fffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e2800000-e2803fff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
e2804000-e280407f : Digital Equipment Corporation DECchip 21140
[FasterNet]
  e2804000-e280407f : eth0
e2805000-e2805fff : Adaptec AHA-7850
  e2805000-e2805fff : aic7xxx
e2806000-e2806fff : ATI Technologies Inc 3D Rage Pro 215GP
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR-
	<PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB
[Natoma/Triton II] (rev 01) (prog-if 00
[UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 6000 [size=32]

00:08.0 SCSI storage controller: Adaptec AHA-7850 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
        FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
        <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 6100 [disabled] [size=256]
        Region 1: Memory at e2805000 (32-bit, non-prefetchable)
        [size=4K]

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 22)
        Subsystem: Netgear FA310TX Fast Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Latency: 32 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 6200 [size=128]
        Region 1: Memory at e2804000 (32-bit, non-prefetchable)
	[size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:0a.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
215GP (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping+ SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 6300 [size=256]
        Region 2: Memory at e2806000 (32-bit, non-prefetchable)
	[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II] (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 1300
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
	ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
	FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
	<PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e1000000 (32-bit, prefetchable) [disabled]
	[size=16M]
        Region 1: Memory at e2800000 (32-bit, non-prefetchable)
	[disabled] [size=16K]
        Region 2: Memory at e2000000 (32-bit, non-prefetchable)
	[disabled] [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-309170      Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-8005  Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-8005  Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

The last few lines of console log:

Mounted devfs on /dev
Freeing unused kernel memory: 224k freed
Unable to handle kernel paging request at virtual address 418146e0
 printing eip:
c02f5407
*pde = 00000000
