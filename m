Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSIHU0t>; Sun, 8 Sep 2002 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSIHU0t>; Sun, 8 Sep 2002 16:26:49 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:14722 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S314529AbSIHU0o>; Sun, 8 Sep 2002 16:26:44 -0400
Date: Sun, 8 Sep 2002 13:31:26 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: opps 2.4.20-pre5-ac2
Message-ID: <20020908203126.GA11475@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre5-ac2 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
oops lockup

[2.] Full description of the problem/report:
random lockup with oops

[3.] Keywords (i.e., modules, networking, kernel):
page_lau
[4.] Kernel version (from /proc/version):

Linux version 2.4.20-pre5-ac2 (root@the-penguin) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 Thu Sep 5 17:48:25 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 

ksymoops 2.4.6 on i686 2.4.20-pre5-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5-ac2/ (default)
     -m /System.map (specified)

Sep  7 06:28:03 the-penguin kernel: are using the NVidia binary only module please report this bug to 
Sep  7 06:28:03 the-penguin kernel: kernel BUG at page_alloc.c:102!
Sep  7 06:28:03 the-penguin kernel: invalid operand: 0000
Sep  7 06:28:03 the-penguin kernel: CPU:    0
Sep  7 06:28:03 the-penguin kernel: EIP:    0010:[__free_pages_ok+78/656]    Not tainted
Sep  7 06:28:03 the-penguin kernel: EFLAGS: 00010282
Sep  7 06:28:03 the-penguin kernel: eax: 00000033   ebx: c17a3014   ecx: 00000001   edx: ef960000
Sep  7 06:28:03 the-penguin kernel: esi: 00000000   edi: 000003d0   ebp: 00000010   esp: c19ddf38
Sep  7 06:28:03 the-penguin kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 06:28:03 the-penguin kernel: Process kswapd (pid: 4, stackpage=c19dd000)
Sep  7 06:28:03 the-penguin kernel: Stack: c02336e0 c0233680 c0233620 c17a3014 c17a3030 000003d0 00000010 c013ae6e 
Sep  7 06:28:03 the-penguin kernel:        c17a3014 000001d0 000003d0 00000010 c0139329 c17a3014 c17a3030 c012f026 
Sep  7 06:28:03 the-penguin kernel:        c0130f7b c012f05c c0278500 c02785dc 00001493 0000003e c0278608 00001493 
Sep  7 06:28:03 the-penguin kernel: Call Trace:    [try_to_free_buffers+142/224] [try_to_release_page+73/80] [page_launder_zone+1046/1632] [__free_pages+27/32] [page_launder_zone+1100/1632]
Sep  7 06:28:03 the-penguin kernel: Code: 0f 0b 66 00 f4 35 23 c0 83 c4 0c 89 d8 2b 05 b0 b2 2d c0 69 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c17a3014 <_end+14a9b3c/30534b88>
>>edx; ef960000 <_end+2f666b28/30534b88>
>>esp; c19ddf38 <_end+16e4a60/30534b88>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   66                        data16
Code;  00000003 Before first symbol
   3:   00 f4                     add    %dh,%ah
Code;  00000005 Before first symbol
   5:   35 23 c0 83 c4            xor    $0xc483c023,%eax
Code;  0000000a Before first symbol
   a:   0c 89                     or     $0x89,%al
Code;  0000000c Before first symbol
   c:   d8 2b                     fsubrs (%ebx)
Code;  0000000e Before first symbol
   e:   05 b0 b2 2d c0            add    $0xc02db2b0,%eax
Code;  00000013 Before first symbol
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A
[7.] Environment
Debian sid
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.4.20-pre5-ac2 #7 Thu Sep 5 17:48:25 PDT 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.28
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         radeon nfsd lockd sunrpc ipx binfmt_misc hid usbmouse usb-uhci ehci-hcd usbcore vfat fat sr_mod cdrom agpgart cmpci soundcore 3c59x

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1700+
stepping	: 2
cpu MHz		: 1466.291
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2922.90

[7.3.] Module information (from /proc/modules):

radeon                 93728   0
nfsd                   68304   8 (autoclean)
lockd                  48848   1 (autoclean) [nfsd]
sunrpc                 60060   1 (autoclean) [nfsd lockd]
ipx                    15940   2 (autoclean)
binfmt_misc             5628   1
hid                    19460   0 (unused)
usbmouse                1812   0 (unused)
usb-uhci               21484   0 (unused)
ehci-hcd               20328   0 (unused)
usbcore                62816   1 [hid usbmouse usb-uhci ehci-hcd]
vfat                    9532   0 (unused)
fat                    29752   0 [vfat]
sr_mod                 13200   0 (unused)
cdrom                  29312   0 [sr_mod]
agpgart                15060   1
cmpci                  24980   0 (unused)
soundcore               3652   2 [cmpci]
3c59x                  25200   1
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : PnPBIOS PNP0c02
02f8-02ff : serial(auto)
03c0-03df : vga+
03f0-03f1 : PnPBIOS PNP0c02
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7800-781f : VIA Technologies, Inc. USB (#4)
  7800-781f : usb-uhci
8000-801f : VIA Technologies, Inc. USB (#3)
  8000-801f : usb-uhci
8400-840f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
8800-887f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  8800-887f : 00:0f.0
9000-90ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
  9000-907f : sym53c8xx
9400-941f : VIA Technologies, Inc. USB (#2)
  9400-941f : usb-uhci
9800-981f : VIA Technologies, Inc. USB
  9800-981f : usb-uhci
a000-a00f : Promise Technology, Inc. PDC20276 IDE
a400-a403 : Promise Technology, Inc. PDC20276 IDE
a800-a807 : Promise Technology, Inc. PDC20276 IDE
b000-b003 : Promise Technology, Inc. PDC20276 IDE
b400-b407 : Promise Technology, Inc. PDC20276 IDE
b800-b8ff : C-Media Electronics Inc CM8738
  b800-b8ff : cmpci
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Radeon VE QY
e400-e47f : PnPBIOS PNP0c02
ec00-ec3f : PnPBIOS PNP0c02


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d1fff : Extension ROM
000f0000-000fffff : System ROM
00100000-2fffbfff : System RAM
  00100000-00229f71 : Kernel code
  00229f72-002b0d1f : Kernel data
2fffc000-2fffefff : ACPI Tables
2ffff000-2fffffff : ACPI Non-volatile Storage
d3800000-d380007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d4000000-d4000fff : LSI Logic / Symbios Logic (formerly NCR) 53c895
d4800000-d48000ff : LSI Logic / Symbios Logic (formerly NCR) 53c895
d5000000-d50000ff : VIA Technologies, Inc. USB 2.0
  d5000000-d50000ff : ehci-hcd
d5800000-d5803fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
d6000000-d60007ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
d6800000-d6803fff : Promise Technology, Inc. PDC20276 IDE
d7000000-d7dfffff : PCI Bus #01
  d7000000-d700ffff : ATI Technologies Inc Radeon VE QY
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) (prog-if 85)
	Subsystem: Asustek Computer, Inc.: Unknown device 807e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at d6800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 Controller (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 35 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 8800 [size=128]
	Region 1: Memory at d3800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8400 [disabled] [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 14
	Region 4: I/O ports at 8000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 14
	Region 4: I/O ports at 7800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DCAS-34330W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1037
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
none

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


