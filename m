Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSAHT4D>; Tue, 8 Jan 2002 14:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSAHTzz>; Tue, 8 Jan 2002 14:55:55 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:19808 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284732AbSAHTzq>; Tue, 8 Jan 2002 14:55:46 -0500
Posted-Date: Tue, 8 Jan 2002 19:55:31 GMT
Date: Tue, 8 Jan 2002 19:55:30 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Stepan Maseizik <st.mase@web.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: "shutdown -r now" (lilo, win98) (fwd)
Message-ID: <Pine.LNX.4.21.0201081952090.7547-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stepan.

Unfortunately, I'm not able to help with this. As a result, I've
forwarded it to the Linux Kernel Developers mailing list for
comment. Hopefully, somebody there can help...

Best wishes from Riley.

---------- Forwarded message ----------
Date: Tue, 8 Jan 2002 15:18:33 +0100
From: Stepan Maseizik <st.mase@web.de>
To: rhw@memalpha.cx
Subject: PROBLEM: "shutdown -r now" (lilo, win98)

1. PROBLEM:     "shutdown -r now" problem (lilo,win98)

2. DESCRIPTION: When I try a "shutdown -r now" to start win98 (using lilo as
                bootloader) the computer hangs a few seconds after the initial
                win98 start-picture.  Horizontal white lines run across the
                screen, the win98 startlogo is still visible.
                A "shutdown -r now" rebooting linux works just fine!
                A "shutdown -h now", restrating the computer and selcting
                win98 from the lilo-menu works fine as well!
                
                I had a similar problem with suse-kernel 2.4.4. The only
                difference: No runnig white lines across the screen. But I got
                an error massage then that read "UNABLE TO CONTROL THE A20
                LINE!" I have reported that problem to SuSE and they have
                generated a bug report (so they said 11. jul 2001).

3. Kywords:     rebooting win98, lilo?, A20 line error? 

4. Kernel:	Linux version 2.4.16-4GB (root@Pentium.suse.de) (gcc version
		2.95.3 20010315 (SuSE)) #1 Tue Dec 18 15:10:30 GMT 2001

5. oops         -- 
6. script       --

7. Environment

7.1 Software:  output from ver_linux: 

-----------------------------------------------------------------------
Linux kurt 2.4.16-4GB #1 Tue Dec 18 15:10:30 GMT 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.12
e2fsprogs              1.19
reiserfsprogs          3.x.0k-pre10
pcmcia-cs              3.1.28
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1341670 Dez 18 16:50 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc 
snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-seq-midi snd-seq-midi-event 
snd-seq snd-card-ymfpci snd-ymfpci snd-pcm snd-ac97-codec snd-mixer snd-opl3 
snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore 
parport_pc lp parport mousedev hid input usb-uhci usbcore ipv6 ds i82365 
pcmcia_core ipchains ide-scsi nls_iso8859-1 nls_cp437 reiserfs
--------------------------------------------------------------------------

7.2 Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 159.355
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 304.74


7.3 Module information (from /proc/modules):

ppp_deflate            39680   0 (autoclean)
bsd_comp                4032   0 (autoclean)
ppp_async               6144   0 (autoclean)
ppp_generic            14760   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4432   0 (autoclean) [ppp_generic]
snd-pcm-oss            18400   0 (autoclean)
snd-pcm-plugin         14480   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           4672   0 (autoclean) [snd-pcm-oss]
snd-seq-midi            3136   0 (unused)
snd-seq-midi-event      2800   0 [snd-seq-midi]
snd-seq                38320   0 [snd-seq-midi snd-seq-midi-event]
snd-card-ymfpci         4288   0
snd-ymfpci             35936   0 [snd-card-ymfpci]
snd-pcm                28960   0 [snd-pcm-oss snd-pcm-plugin snd-ymfpci]
snd-ac97-codec         23488   0 [snd-ymfpci]
snd-mixer              22568   0 [snd-mixer-oss snd-ymfpci snd-ac97-codec]
snd-opl3                4256   0 [snd-card-ymfpci]
snd-hwdep               3072   0 [snd-opl3]
snd-timer               8128   0 [snd-seq snd-pcm snd-opl3]
snd-mpu401-uart         2288   0 [snd-card-ymfpci]
snd-rawmidi             9184   0 [snd-seq-midi snd-mpu401-uart]
snd-seq-device          3740   0 [snd-seq-midi snd-seq snd-rawmidi]
snd                    31072   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss 
snd-seq-midi snd-seq-midi-event sndsoundcore               3268   5 [snd]
parport_pc             25192   1 (autoclean)
lp                      5824   0 (autoclean)
parport                22368   1 (autoclean) [parport_pc lp]
mousedev                3872   0 (unused)
hid                    17760   0 (unused)
input                   3072   0 [mousedev hid]
usb-uhci               20996   0 (unused)
usbcore                47616   1 [hid usb-uhci]
ipv6                  124608  -1 (autoclean)
ds                      6816   2
i82365                 23312   2
pcmcia_core            43040   0 [ds i82365]
ipchains               29640   0
ide-scsi                7584   0
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
reiserfs              152096   2


7.4 Loaded driver and hardware information 

/proc/ioports: 

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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1040-105f : PCI device 8086:7113
8000-803f : PCI device 8086:7113
fc40-fc7f : PCI device 1073:0010
fc40-fc7f : YMF744 legacy
fcc0-fcdf : PCI device 8086:7112
fcc0-fcdf : usb-uhci
fce0-fce7 : PCI device 14f1:2443
fcec-fcef : PCI device 1073:0010
fcf0-fcff : PCI device 8086:7111
fcf0-fcf7 : ide0
fcf8-fcff : ide1


/proc/iomem:

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
00100000-00242cd7 : Kernel code
00242cd8-002a27eb : Kernel data
0fff0000-0ffff7ff : ACPI Tables
0ffff800-0fffffff : ACPI Non-volatile Storage
10000000-10000fff : PCI device 1180:0478
10000000-10000fff : i82365
10001000-10001fff : PCI device 1180:0478
10001000-10001fff : i82365
40000000-40ffffff : PCI device 8086:7190
fd000000-fdffffff : PCI Bus #01
fd000000-fdffffff : PCI device 10c8:0025
fd000000-fd2effff : vesafb
fe800000-fecfffff : PCI Bus #01
fe800000-febfffff : PCI device 10c8:0025
fec00000-fecfffff : PCI device 10c8:0025
fede0000-fedeffff : PCI device 14f1:2443
fedf0000-fedf7fff : PCI device 1073:0010
fedff000-fedff7ff : PCI device 104d:8039
fedffc00-fedffdff : PCI device 104d:8039
fff80000-ffffffff : reserved

7.5 PCI information (lspci -vvv)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 
03)
	Subsystem: Sony Corporation: Unknown device 806f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at 40000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe800000-fecfffff
	Prefetchable memory behind bridge: fd000000-fdffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fcc0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 
02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 8071
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedff000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [disabled] [size=512]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio 
Controller] (rev 02)
	Subsystem: Sony Corporation: Unknown device 8072
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at fc40 [size=64]
	Region 2: I/O ports at fcec [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Communication controller: CONEXANT: Unknown device 2443 (rev 01)
	Subsystem: Sony Corporation: Unknown device 8075
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fede0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 1: I/O ports at fce0 [disabled] [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8073
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 00000000-00000000
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8073
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 00000000-00000000
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Neomagic Corporation: Unknown device 0025 
(rev 30) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80a2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



7.6 SCSI information (from /proc/scsi/ide-scsi)

SCSI host adapter emulation for IDE ATAPI devices


       
        

8. The computer is a Sony PCG-F707 notebook. 
   This is my very first bug report. I hope I got the right maintainer and the
   report contains all that is needed. Thanks for your work on the kernel!!

Regards,
Stephan Maseizik

