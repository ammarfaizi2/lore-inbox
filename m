Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTIMJUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTIMJUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:20:33 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:13628 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262098AbTIMJUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:20:18 -0400
Message-ID: <3F62E145.9090100@iku-ag.de>
Date: Sat, 13 Sep 2003 11:20:05 +0200
From: Kurt Huwig <k.huwig@iku-ag.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at ide-iops.c:1262! after DMA timeout with 2.4.21
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4EAE2BFC8B48BC501D15BB6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4EAE2BFC8B48BC501D15BB6
Content-Type: multipart/mixed;
 boundary="------------090804020806070104070207"

This is a multi-part message in MIME format.
--------------090804020806070104070207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

[1.] One line summary of the problem:
My machine freezes while burning CDs after a DMA timeout

[2.] Full description of the problem/report:
On my machine 'setiathome' runs niced in the background. I burn CDs 
using cdrdao on an ATAPI 32x burner with ide-scsi. I get DMA timeouts 
and then SCSI reset. I guess it is due to heat problems of the CD 
writer, as it does happen after about 10 CDs have been burned and then 
can be repeated by resetting the machine and immediately burning another 
cd. Nevertheless, the machine runs stable for all other purposes, like 
kernel compilation and video encoding.

[3.] Keywords (i.e., modules, networking, kernel):
ide-scsi, dma timeout

[4.] Kernel version (from /proc/version):
Linux lobo 2.4.21 #1 Fri Jul 25 21:46:23 CEST 2003 i686 unknown

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
see attached 'ksymoops.txt'

[6.] A small shell script or example program which triggers the
      problem (if possible)
n/a

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux lobo 2.4.21 #1 Fri Jul 25 21:46:23 CEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfsd lp hid nfs lockd sunrpc 8139too uhci 
ehci-hcd serial isa-pnp parport_pc pt_drv parport usbnet cdfs ide-scsi 
scsi_mod cmpci soundcore usbmouse mousedev keybdev usbkbd usbcore input 
rtc reiserfs isofs vfat fat ext2 ide-disk ide-probe-mod ext3 jbd 
via82cxxx ide-mod

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 2100+
stepping        : 2
cpu MHz         : 1735.486
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3460.30

[7.3.] Module information (from /proc/modules):
nfsd                   68544   0 (autoclean)
lp                      7008   0 (autoclean)
hid                    19488   0 (unused)
nfs                    65468   2 (autoclean)
lockd                  48864   1 (autoclean) [nfsd nfs]
sunrpc                 61108   1 (autoclean) [nfsd nfs lockd]
8139too                16320   1 (autoclean)
uhci                   24136   0 (unused)
ehci-hcd               15552   0 (unused)
serial                 45440   0 (autoclean)
isa-pnp                28796   0 (autoclean) [serial]
parport_pc             25128   2 (autoclean)
pt_drv                107616   0 (unused)
parport                23328   2 [lp parport_pc pt_drv]
usbnet                 12360   0 (unused)
cdfs                   20264   0 (unused)
ide-scsi                9120   0
scsi_mod               92456   1 [ide-scsi]
cmpci                  30416   0 (unused)
soundcore               3588   4 [cmpci]
usbmouse                1856   0 (unused)
mousedev                3936   1
keybdev                 1728   0 (unused)
usbkbd                  2944   0 (unused)
usbcore                57184   1 [hid uhci ehci-hcd usbnet usbmouse usbkbd]
input                   3392   0 [hid usbmouse mousedev keybdev usbkbd]
rtc                     6012   0 (autoclean)
reiserfs              165024   1 (autoclean)
isofs                  25056   0 (autoclean)
vfat                    9564   0 (autoclean)
fat                    29944   0 (autoclean) [vfat]
ext2                   31648   0 (autoclean)
ide-disk               13092   2 (autoclean)
ide-probe-mod           9872   0 (autoclean)
ext3                   58080   0 (autoclean)
jbd                    36968   0 (autoclean) [ext3]
via82cxxx              10332   1 (autoclean)
ide-mod                88940   2 (autoclean) [ide-scsi ide-disk 
ide-probe-mod via82cxxx]

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
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0330-0331 : cmpci Midi
0376-0376 : ide1
0378-037a : parport0
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a800-a81f : VIA Technologies, Inc. USB (#4)
   a800-a81f : usb-uhci
b000-b01f : VIA Technologies, Inc. USB (#3)
   b000-b01f : usb-uhci
b400-b40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   b400-b407 : ide0
   b408-b40f : ide1
b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   b800-b8ff : 8139too
d000-d01f : VIA Technologies, Inc. USB (#2)
   d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
   d400-d41f : usb-uhci
d800-d8ff : C-Media Electronics Inc CM8738
   d800-d8ff : cmpci
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
   00100000-001f407d : Kernel code
   001f407e-0025d7df : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
d5000000-d50000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   d5000000-d50000ff : 8139too
d5800000-d58000ff : VIA Technologies, Inc. USB 2.0
   d5800000-d58000ff : ehci-hcd
d6000000-d7efffff : PCI Bus #01
   d6000000-d6ffffff : nVidia Corporation NV11 [GeForce2 MX]
d7f00000-dfffffff : PCI Bus #01
   d8000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX]
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
         Subsystem: Asustek Computer, Inc.: Unknown device 807f
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: d6000000-d7efffff
         Prefetchable memory behind bridge: d7f00000-dfffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
         Subsystem: Asustek Computer, Inc.: Unknown device 80e2
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 6000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at d800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 8080
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 12
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 8080
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin B routed to IRQ 11
         Region 4: I/O ports at d000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 
51) (prog-if 20)
         Subsystem: Asustek Computer, Inc.: Unknown device 8080
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 10
         Interrupt: pin C routed to IRQ 10
         Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at b800 [size=256]
         Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
         Subsystem: Asustek Computer, Inc.: Unknown device 808c
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 808c
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at b400 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 808c
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at b000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 808c
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at a800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) 
(rev b2) (prog-if 00 [VGA])
         Subsystem: Elsa AG: Unknown device 0c64
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at d7ff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: HL-DT-ST Model: CD-RW GCE-8320B  Rev: 1.04
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: MT1316B  Model: BDV212B          Rev: 0p40
   Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
lobo:~# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt8233a
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xb400
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA      UDMA
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          22ns     600ns     120ns      60ns
Transfer Rate:   88.8MB/s   3.3MB/s  16.6MB/s  33.3MB/s

[X.] Other notes, patches, fixes, workarounds:

CD writer is /dev/hdc.

Please respond via private mail too, as I am not subscribed to lkml.


Thanks,

Kurt
-- 
Kurt Huwig             iKu Systemhaus AG        http://www.iku-ag.de/
Vorstand               Am Römerkastell 4        Telefon 0681/96751-0
                        66121 Saarbrücken        Telefax 0681/96751-66
GnuPG 1024D/99DD9468 64B1 0C5B 82BC E16E 8940  EB6D 4C32 F908 99DD 9468

--------------090804020806070104070207
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -k 20030913102954.ksyms (specified)
     -l 20030913102954.modules (specified)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/reiserfs/reiserfs.o for module reiserfs has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/isofs/isofs.o for module isofs has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/vfat/vfat.o for module vfat has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/fat/fat.o for module fat has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/ext2/ext2.o for module ext2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/drivers/ide/pci/via82cxxx.o for module via82cxxx has changed since load
Warning (expand_objects): object /lib/modules/2.4.21/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
kernel BUG at ide-iops.c:1262!
CPU:    0
EIP:    0010:[<e080e5c3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010082
eax:  c15e9280  ebx: 00000000  ecx: dbff5f6c  edx: 00000002
esi:  00000000  edi: e0820344  ebp: e0820294  esp: dbff5ed4
ds: 0018  es:  0018  ss: 0018
Process setiathome (pid: 735, stackpage=dbff5000)
Stack: 00000000 00000000 dfee35c0 d7a0f800 c15e9280 00000086 e080e78c e0820344
       00000000 e09b17a6 e0820344 e099f0bc d7a0f800 00000002 d7a0f800 00000282
       00000000 c027c240 00000000 e099e659 d7a0f800 00000002 e09aaec0 00000000
Call Trace:    [<e080e78c>] [<e0820344>] [<e09b17a6>] [<e0820344>] [<e099f0bc>]
  [<e099e659>] [<e09aaec0>] [<e099e600>] [<c01201fc>] [<c011cbea>] [<c011cb16>]
  [<c011c90a>] [<c0109e0d>] [<c010c078>]
Code: 0f 0b ee 04 7a a3 81 e0 90 8d 74 26 00 80 bf 09 01 00 00 20


>>EIP; e080e5c3 <[ide-mod]__kstrtab___ide_dma_write+5/1a>   <=====

>>eax; c15e9280 <_end+133306c/20556dec>
>>ecx; dbff5f6c <_end+1bd3fd58/20556dec>
>>edi; e0820344 <[ide-mod]ide_hwifs+524/2c88>
>>ebp; e0820294 <[ide-mod]ide_hwifs+474/2c88>
>>esp; dbff5ed4 <_end+1bd3fcc0/20556dec>

Trace; e080e78c <[ide-mod]ide_do_reset+c/10>
Trace; e0820344 <[ide-mod]ide_hwifs+524/2c88>
Trace; e09b17a6 <[ide-scsi]idescsi_reset+16/20>
Trace; e0820344 <[ide-mod]ide_hwifs+524/2c88>
Trace; e099f0bc <[scsi_mod]scsi_reset+dc/340>
Trace; e099e659 <[scsi_mod]scsi_old_times_out+59/110>
Trace; e09aaec0 <[scsi_mod]RCSid+aa0/1080>
Trace; e099e600 <[scsi_mod]scsi_old_times_out+0/110>
Trace; c01201fc <timer_bh+24c/370>
Trace; c011cbea <bh_action+1a/50>
Trace; c011cb16 <tasklet_hi_action+46/70>
Trace; c011c90a <do_softirq+5a/b0>
Trace; c0109e0d <do_IRQ+9d/b0>
Trace; c010c078 <call_do_IRQ+5/d>

Code;  e080e5c3 <[ide-mod]__kstrtab___ide_dma_write+5/1a>
00000000 <_EIP>:
Code;  e080e5c3 <[ide-mod]__kstrtab___ide_dma_write+5/1a>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e080e5c5 <[ide-mod]__kstrtab___ide_dma_write+7/1a>
   2:   ee                        out    %al,(%dx)
Code;  e080e5c6 <[ide-mod]__kstrtab___ide_dma_write+8/1a>
   3:   04 7a                     add    $0x7a,%al
Code;  e080e5c8 <[ide-mod]__kstrtab___ide_dma_write+a/1a>
   5:   a3 81 e0 90 8d            mov    %eax,0x8d90e081
Code;  e080e5cd <[ide-mod]__kstrtab___ide_dma_write+f/1a>
   a:   74 26                     je     32 <_EIP+0x32> e080e5f5 <[ide-mod]__kstrtab___ide_dma_end+3/18>
Code;  e080e5cf <[ide-mod]__kstrtab___ide_dma_write+11/1a>
   c:   00 80 bf 09 01 00         add    %al,0x109bf(%eax)
Code;  e080e5d5 <[ide-mod]__kstrtab___ide_dma_write+17/1a>
  12:   00 20                     add    %ah,(%eax)

Kernel panic: Aiee, killing interrupt handler!

11 warnings issued.  Results may not be reliable.

--------------090804020806070104070207--

--------------enigA4EAE2BFC8B48BC501D15BB6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/YuFJTDL5CJndlGgRAtpsAKCO/V8ksz/EcA3NNwXldbZ2KIJSaACggBBX
Ew/l843V7Rap6B5IO0AJjOk=
=4iyn
-----END PGP SIGNATURE-----

--------------enigA4EAE2BFC8B48BC501D15BB6--

