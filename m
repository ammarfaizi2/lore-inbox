Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTDNBCz (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTDNBCz (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 21:02:55 -0400
Received: from [209.248.79.90] ([209.248.79.90]:10762 "EHLO anax.fhase.net")
	by vger.kernel.org with ESMTP id S262706AbTDNBCt (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 21:02:49 -0400
Message-ID: <3E9A19D7.6040509@nixhelp.org>
Date: Sun, 13 Apr 2003 21:15:51 -0500
From: Russell Nash <russ@nixhelp.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mkdir on ext3 creates regular file instead of directory
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

when using 'mkdir' to create a directory on an ext3 filesystem, a 
regular file is created instead of the directory.

[2.] Full description of the problem/report:

I discovered this whilst writing a perl script, however, the problem 
seems to be the same within a normal shell also.  I was trying to create 
a directory (in this case '.variable' off of my home dir) with the 
command 'mkdir .variable'.  When I then tried to 'cd .variable' I 
received the error '-bash: cd: .variable: Not a directory'.  The file or 
directory '.variable' did not exist prior to this.  To make sure, I then 
  executed the command 'rm -rf .variable' before trying the command 
sequence again, with the same results.

I attempted this approximately 20 times as a test to see if it was a 
permanent error or occasional, I also tried different directory names 
('.variable', 'variable', 'test' & '.test').  In each case I managed to 
experience the problem, I also noted that approximately 1 time out of 10 
the mkdir worked as expected.

The root superuser does not appear to be affected by this problem.

[3.] Keywords (i.e., modules, networking, kernel):

ext3, mkdir, directory

[4.] Kernel version (from /proc/version):

Linux version 2.4.20-gentoo-r1 (root@voyager) (gcc version 3.2.2) #2 Sat 
Apr 5 20:58:27 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
      problem (if possible)

cd
rm -rf .variable
mkdir .variable
cd .variable

[7.] Environment

Gentoo Linux V1.4-rc1

[7.1.] Software (add the output of the ver_linux script here)
Linux voyager 2.4.20-gentoo-r1 #2 Sat Apr 5 20:58:27 EST 2003 i686 
Pentium III (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         usb-uhci eepro100 mii

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 796.601
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1572.86

[7.3.] Module information (from /proc/modules):

usb-uhci               29868   0 (unused)
eepro100               21268   1
mii                     2608   0 [eepro100]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
1800-183f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   1800-183f : eepro100
1840-1847 : Xircom Mini-PCI V.90 56k Modem
1850-185f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
   1850-1857 : ide0
   1858-185f : ide1
1860-187f : Intel Corp. 82371AB/EB/MB PIIX4 USB
   1860-187f : usb-uhci

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
   00100000-002df02b : Kernel code
   002df02c-0037167f : Kernel data
0fff0000-0fffebff : ACPI Tables
0fffec00-0fffffff : ACPI Non-volatile Storage
50000000-50000fff : Texas Instruments PCI1450
50100000-50100fff : Texas Instruments PCI1450 (#2)
e8000000-e80fffff : Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion 
Audio Accelerator]
e8100000-e811ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
e8120000-e8120fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   e8120000-e8120fff : eepro100
e8121000-e8121fff : Xircom Mini-PCI V.90 56k Modem
e8122000-e8122fff : Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion 
Audio Accelerator]
f0000000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : S3 Inc. 86C270-294 Savage/IX-MV
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 09)
	Subsystem: Intel Corp. EtherExpress PRO/100+ MiniPCI
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8120000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.1 Serial controller: Xircom Mini-PCI V.90 56k Modem (prog-if 02 
[16550])
	Subsystem: Intel Corp.: Unknown device 2408
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1840 [size=8]
	Region 1: Memory at e8121000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1850 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1860 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 
11) (prog-if 00 [VGA])
	Subsystem: IBM ThinkPad T20
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: SIIG     Model: CompactFlash Car Rev: 0113
   Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

The PC is an IBM Thinkpad T21.

A friend also experienced the same problem, he is also using the ext3 
filesystem which is the only commonality we can think of.

Currently I have the following filesystems mounted (if its relevant?):

root@voyager scripts # mount
/dev/hda4 on / type ext3 (rw,noatime)
proc on /proc type proc (rw)
none on /dev type devfs (rw)
tmpfs on /mnt/.init.d type tmpfs (rw,mode=0644,size=2048k)
/dev/hda1 on /mnt/win type ntfs (ro,uid=1000,gid=100)
tmpfs on /dev/shm type tmpfs (rw)
//defiant/drive_c on /home/russ/defiant type smbfs (0)

[X.] Other notes, patches, fixes, workarounds:

The aforementioned friend managed to circumvent the problem by cd'ing to 
another directory then back again.  I tried this, which allowed me to 
mkdir one directory fine, but then the problem returned.

I also noted that root does not seem to be affected by this problem, I 
cannot reproduce it at all as root.

