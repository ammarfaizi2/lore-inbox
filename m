Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbTIZFgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTIZFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 01:36:08 -0400
Received: from cs6668109-142.austin.rr.com ([66.68.109.142]:55180 "EHLO
	formanonline.com") by vger.kernel.org with ESMTP id S261935AbTIZFfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 01:35:53 -0400
Subject: cdrecord burn looks fine, but upon mounting, i get nothing.
From: Jeffrey Forman <jforman@mail.utexas.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Rgn/hOdE++T4srDlOFmA"
Message-Id: <1064554552.6661.6.camel@tribeca.formanonline.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 26 Sep 2003 00:35:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rgn/hOdE++T4srDlOFmA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

i am having some issues burning cd's using cdrecord in 2.6.0-test5-mm4,
and possibly could get someone to lend a hand, since i'm not sure if
its a kernel issue or a cdrecord issue.

i am running 2.6.0-test5-mm4, on a p4-2.8/512MB machine. i have an atapi
plextor 48/24/48A ide cd burner.i am trying to burn various data, iso's
etc. cdrecord seems to burn correctly (paste of output below), but upon
trying to mount the burned cd, it shows up as 0 files on the cd. i am
using atapi burning with the command line: cdrecord dev=/dev/hdc -v
driveropts=burnfree speed=30 pentium4-1.4-20030911-cd1.iso. this
pentium4.iso is a gentoo release of its install. it is a 501MB file, but
when mounted, i see

Filesystem            Size  Used Avail Use% Mounted on
/dev/cdroms/cdrom0    246M  246M     0 100% /mnt/cdrom

Attached is a pertinent kernel bug report. Hopefully you can alert me as
to what i might be doing wrong, or if this is a kernel issue and totally
out of my hands. As expected, I can burn perfectly fine on my system
when running the 2.4.20 kernel released with gentoo systems now.

Any help you can give me is greatly appreciated. Please feel free to
pass this email on to other parties if they are more knowledgeable on
this issue. all help i have searched for so far has come down to "it works for me, not sure what your issue is."

please CC me personally as i do do not subscribe to the linux-kernel ML. 

Cheers and thanks in advance,
Jeffrey Forman

cdrecord output: 
jforman@tribeca temp $ cdrecord dev=/dev/hdc -v driveropts=burnfree
speed=30 pentium4-1.4-20030911-cd1.iso 
Cdrecord-Clone 2.01a18 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg
Schilling
TOC Type: 1 = CD-ROM
cdrecord: Operation not permitted. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using
setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
SCSI buffer size: 64512
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W4824A'
Revision       : '1.04'
Device seems to be: Generic mmc CD-RW.
Current: 0x0009
Profile: 0x0008 
Profile: 0x0009 (current)
Profile: 0x000A 
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC FORCESPEED SPEEDREAD
SINGLESESSION HIDECDR 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P
RAW/R96R
Drive buf size : 2394336 = 2338 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data   501 MB        
Total size:      576 MB (57:06.16) = 256962 sectors
Lout start:      576 MB (57:08/12) = 256962 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is unrestricted
  Is not erasable
  Disk sub type: Medium Type B, low Beta category (B-) (4)
  ATIP start of lead in:  -11753 (97:25/22)
  ATIP start of lead out: 359849 (79:59/74)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 8
Manufacturer: Hitachi Maxell, Ltd.
Single session is OFF.
Hide CDR is OFF.
Speed-Read is OFF.
Blocks total: 359849 Blocks current: 359849 Blocks remaining: 102887
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using
setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.
Forcespeed is OFF.
Power-Rec is ON.
Power-Rec write speed:     16x (recommended)
Starting to write CD/DVD at speed 24 in real TAO mode for single
session.
Last chance to quit, starting real write    0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Turning BURN-Free on
Performing OPC...
Starting new track at sector: 0
Track 01:  501 of  501 MB written (fifo 100%) [buf  98%]  16.9x.
Track 01: Total bytes read/written: 526254080/526254080 (256960
sectors).
Writing  time:  233.240s
Average write speed  15.5x.
Min drive buffer fill was 52%
Fixating...
Fixating time:   28.434s
Last selected write speed: 24x
Max media write speed:     16x
Last actual write speed:   16x
BURN-Free was 1 times used.
cdrecord: fifo had 8290 puts and 8290 gets.
cdrecord: fifo was 0 times empty and 4177 times full, min fill was 84%.
jforman@tribeca temp $

jforman@tribeca mnt $ ls -al /mnt/cdrom
total 0


--=-Rgn/hOdE++T4srDlOFmA
Content-Disposition: attachment; filename=cdrecord-2.6.0-test5-mm4.bug
Content-Type: text/plain; name=cdrecord-2.6.0-test5-mm4.bug; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

cdrecord in 2.6.0-test5-mm3 bug
jeffrey forman : <jforman@mail.utexas.edu>


[1.] One line summary of the problem: I have been unable to burn cds and cdrws with the 2.6.0-test# line of kernels.
[2.] Full description of the problem/report: I am fully able to blank cdrw's in 2.6.0, but have not been able to burn cd's at all using atapi burning and the scsi emulation.
[3.] Keywords (i.e., modules, networking, kernel): cdrecord, cdrw, burner, cdr, mm kernel.
[4.] Kernel version (from /proc/version): Linux tribeca.formanonline.com 2.6.0-test5-mm4 #3 Thu Sep 25 13:18:32 CDT 2003 i686 Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible): cdrecord dev=/dev/hdc -v <file>
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
jforman@tribeca linux $ sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tribeca.formanonline.com 2.6.0-test5-mm4 #3 Thu Sep 25 13:18:32 CDT 2003 i686 Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         isofs nvidia vfat fat

[7.2.] Processor information (from /proc/cpuinfo):
jforman@tribeca linux $ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 7
cpu MHz         : 2800.547
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5537.79

[7.3.] Module information (from /proc/modules):
jforman@tribeca linux $ cat /proc/modules 
isofs 22404 1 - Live 0xe194d000
nvidia 1699372 10 - Live 0xe1aba000
vfat 12544 1 - Live 0xe18d5000
fat 40992 1 vfat, Live 0xe18dd000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
jforman@tribeca linux $ cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
8800-887f : 0000:00:0d.0
  8800-887f : 0000:00:0d.0
9000-9007 : 0000:00:0a.1
9400-941f : 0000:00:0a.0
  9400-941f : EMU10K1
b400-b40f : 0000:00:02.5
  b400-b407 : ide0
  b408-b40f : ide1
e600-e61f : 0000:00:02.1

jforman@tribeca linux $ cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-003b8abf : Kernel code
  003b8ac0-004d0bff : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
e3800000-e380007f : 0000:00:0d.0
e4800000-e4800fff : 0000:00:03.3
  e4800000-e4800fff : ehci_hcd
e5000000-e5000fff : 0000:00:03.2
  e5000000-e5000fff : ohci-hcd
e5800000-e5800fff : 0000:00:03.1
  e5800000-e5800fff : ohci-hcd
e6000000-e6000fff : 0000:00:03.0
  e6000000-e6000fff : ohci-hcd
e6800000-e6800fff : 0000:00:02.3
e7000000-e7ffffff : PCI Bus #01
  e7000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ee800000-ee800fff : 0000:00:0b.1
ef000000-ef000fff : 0000:00:0b.0
  ef000000-ef000fff : bttv0
eff00000-febfffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f0ffffff : vesafb
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
tribeca root # lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4
                Command: RQ=1 ArqSz=0 Cal=3 SBA- AGP+ GART64- 64bit- FW- Rate=x4
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e7000000-e7ffffff
        Prefetchable memory behind bridge: eff00000-febfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0963 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at e600 [size=32]
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 3000ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at efee0000 [disabled] [size=128K]
        Capabilities: [64] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 11
        Region 4: I/O ports at b400 [size=16]
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=4K]
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 9400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 9000 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee800000 (32-bit, prefetchable) [size=4K]
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 8800 [size=128]
        Region 1: Memory at e3800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 4200 AGP 8x] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

[7.6.] SCSI information (from /proc/scsi/scsi)
jforman@tribeca linux $ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
tribeca root # cdrecord -version
Cdrecord-Clone 2.01a18 (i686-pc-linux-gnu) Copyright (C) 1995-2003 JÃ¶rg Schilling

[X.] Other notes, patches, fixes, workarounds:

--=-Rgn/hOdE++T4srDlOFmA--

