Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUD3ChM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUD3ChM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUD3ChM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:37:12 -0400
Received: from static-151047.static.umsystem.edu ([207.160.151.47]:39859 "EHLO
	um-exproto7.um.umsystem.edu") by vger.kernel.org with ESMTP
	id S262100AbUD3Cgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:36:55 -0400
Message-ID: <4091BBC4.5030801@mizzou.edu>
Date: Thu, 29 Apr 2004 21:36:52 -0500
From: "Justin R. Wilson" <jrw972@mizzou.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Network and Sound mutually exclusive
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2004 02:36:53.0955 (UTC) FILETIME=[FFAB8930:01C42E5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Network works and sound works but not at the same time.
2. My wireless network card and sound card work but they don't work at the same time.
	I can be surfing the web, then go to play an ogg file and my browser stops dead.
	When I press pause on the ogg, the browser works again.  There is also no
	error messages which really stumps me.
3. Keywords: networking, wireless, alsa, orinoco_pci
4. Kernel version: 2.4.25-jrw-1
5. Output of Oops... nothing
6. A small shell script or example program which triggers the
     problem (none)
7. Environment
7.1. Software (add the output of the ver_linux script here)
Linux hydrogen 2.4.25-jrw-1 #1 Thu Apr 29 18:55:06 CDT 2004 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux
  
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         tdfx agpgart lp parport_pc parport snd-pcm-oss snd-mixer-oss snd-seq-midi snd-ens1371 snd-pcm snd-page-alloc snd-rawmidi gameport snd-ac97-codec snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device snd soundcore msr microcode cpuid via82cxxx orinoco_pci orinoco hermes tulip crc32

7.2. Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 750.050
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1497.49

7.3. Module information (from /proc/modules):
tdfx                   35288   1
agpgart                14544   0 (autoclean) (unused)
lp                      7200   0 (autoclean)
parport_pc             16100   1
parport                26888   1 [lp parport_pc]
snd-pcm-oss            38404   0
snd-mixer-oss          13624   1 [snd-pcm-oss]
snd-seq-midi            4032   0 (autoclean) (unused)
snd-ens1371            13824   2 (autoclean)
snd-pcm                62468   0 (autoclean) [snd-pcm-oss snd-ens1371]
snd-page-alloc          6804   0 (autoclean) [snd-pcm]
snd-rawmidi            14784   0 (autoclean) [snd-seq-midi snd-ens1371]
gameport                1676   0 (autoclean) [snd-ens1371]
snd-ac97-codec         48284   0 (autoclean) [snd-ens1371]
snd-seq-oss            29696   0 (unused)
snd-seq-midi-event      3840   0 [snd-seq-midi snd-seq-oss]
snd-seq                39024   2 [snd-seq-midi snd-seq-oss snd-seq-midi-event]
snd-timer              15844   0 [snd-pcm snd-seq]
snd-seq-device          4336   0 [snd-seq-midi snd-rawmidi snd-seq-oss snd-seq]
snd                    34980   1 [snd-pcm-oss snd-mixer-oss snd-seq-midi snd-ens1371 snd-pcm snd-rawmidi snd-ac97-codec snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
soundcore               4196   8 [snd]
msr                     1544   0 (unused)
microcode               5440   0 (unused)
cpuid                   1032   0 (unused)
via82cxxx              11080   1
orinoco_pci             3364   1
orinoco                37972   0 [orinoco_pci]
hermes                  6020   0 [orinoco_pci orinoco]
tulip                  40800   0 (unused)
crc32                   2912   0 [tulip]

7.4. Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-90ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  9000-90ff : tulip
9400-943f : Ensoniq 5880 AudioPCI
  9400-943f : Ensoniq AudioPCI
b000-b01f : VIA Technologies, Inc. USB (#2)
  b000-b01f : usb-uhci
b400-b41f : VIA Technologies, Inc. USB
  b400-b41f : usb-uhci
b800-b80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo 3
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2ffebfff : System RAM
  00189000-002cc2a1 : Kernel code
2ffec000-2ffeefff : ACPI Tables
2ffef000-2fffefff : reserved
2ffff000-2fffffff : ACPI Non-volatile Storage
dd800000-dd8003ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  dd800000-dd8003ff : tulip
de000000-e0ffffff : PCI Bus #01
  de000000-dfffffff : 3Dfx Interactive, Inc. Voodoo 3
e1000000-e1000fff : Harris Semiconductor Prism 2.5 Wavelan chipset
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

7.5. PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8023
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: de000000-e0ffffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: Asustek Computer, Inc.: Unknown device 8023
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0c.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0570
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0d.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
        Subsystem: Linksys WMP11 Wireless 802.11b PCI Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e1000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d800 [size=256]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit+ FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
7.6. SCSI information (from /proc/scsi/scsi): none
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
root@hydrogen proc # cat /proc/interrupts
           CPU0
  0:     244128          XT-PIC  timer
  1:       6083          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       6176          XT-PIC  usb-uhci, usb-uhci, eth1
 10:        630          XT-PIC  Ensoniq AudioPCI
 12:      91229          XT-PIC  PS/2 Mouse
 14:      12294          XT-PIC  ide0
 15:         33          XT-PIC  ide1
NMI:          0
LOC:     244088
ERR:         51
MIS:          0
root@hydrogen proc #

I've spent a few months looking for a solution and I couldn't find anything so I thought
I'd ask the pros.  Thanks for everything.

Justin R. Wilson
jrw972@mizzou.edu

