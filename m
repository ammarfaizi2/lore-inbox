Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTGaPvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274826AbTGaPui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:50:38 -0400
Received: from law8-f39.law8.hotmail.com ([216.33.241.39]:2310 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S274810AbTGaPre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:47:34 -0400
X-Originating-IP: [81.102.120.243]
X-Originating-Email: [godoal@hotmail.com]
From: "Linux Power" <godoal@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: mount deadlock !! buggy mainboard!! ide-scsi
Date: Thu, 31 Jul 2003 15:47:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law8-F39vfIPlmPi2Ot00007e2e@hotmail.com>
X-OriginalArrivalTime: 31 Jul 2003 15:47:33.0133 (UTC) FILETIME=[0E7023D0:01C3577B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
     System deadlock when trying to mount damaged cd media

[2.] Full description of the problem/report:
     When tried to mount one of my old cds (well it was a little bit 
scrached), the mount process was stack and after a couple of seconds there 
was no responce from the mouse/keyboard. As a mater of fact the keyboard 
leds "Num/Caps/Scroll" start bliping and Ctrl+Alt+Backspace as well as 
Ctrl+Alt+Del did not respond. The only solution was to reboot the system. On 
another instance the same problem appeared, only this time the cd was 
mounted succesfully but there was a problem with a spesific sector of the cd 
disk.

[3.] Keywords (i.e., modules, networking, kernel):
     kernel?, modules?

[4.] Kernel version (from /proc/version):
     Linux version 2.4.21 (root@Chr0n0s) (gcc version 3.2.2) #1 Sun Jun 29 
20:21:55 BST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see  Documentation/oops-tracing.txt): N/A

[6.] A small shell script or example program which triggers the problem (if 
possible): N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here):
Linux Chr0n0s 2.4.21 #1 Sun Jun 29 20:21:55 BST 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         vmnet vmmon CDCEther es1370 ide-scsi

[7.2.] Processor information (from /proc/cpuinfo):
Linux version 2.4.21 (root@Chr0n0s) (gcc version 3.2.2) #1 Sun Jun 29 
20:21:55 BST 2003
Chr0n0s:/usr/src/linux/scripts# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 463.229
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 924.05

[7.3.] Module information (from /proc/modules):
vmnet                  21408   4
vmmon                  20628   6
CDCEther               12540   1
es1370                 26796   1
ide-scsi               10352   0

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
Chr0n0s:/usr/src/linux/scripts# cat /proc/ioports
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
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo 3
e800-e83f : Ensoniq ES1370 [AudioPCI]
  e800-e83f : es1370
f0a0-f0bf : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
f0c0-f0ff : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
f400-f40f : Olicom OC-2326
  f400-f40f : TLAN
f800-f81f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  f800-f81f : usb-uhci
fcf0-fcff : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

Chr0n0s:/usr/src/linux/scripts# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-13ffdfff : System RAM
  00100000-0032145b : Kernel code
  0032145c-003c3223 : Kernel data
13ffe000-13fffbff : ACPI Tables
13fffc00-13ffffff : ACPI Non-volatile Storage
dc000000-ddffffff : PCI Bus #01
  dc000000-ddffffff : 3Dfx Interactive, Inc. Voodoo 3
fc000000-fdffffff : PCI Bus #01
  fc000000-fdffffff : 3Dfx Interactive, Inc. Voodoo 3
fe000000-fe7fffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fedffc00-fedffc0f : Olicom OC-2326
ffff0800-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
Chr0n0s:/usr/src/linux/scripts# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at fe000000 (32-bit, prefetchable) [size=8M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: dc000000-ddffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at f800 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0c.0 Ethernet controller: Olicom OC-2326 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min, 7000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at f400 [size=16]
        Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [size=16]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:10.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort+ <MAbort- >SERR- <PERR-
        Latency: 96 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e800 [size=64]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at dc000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit+ FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi):
Chr0n0s:/usr/src/linux/scripts# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4824A Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: ATAPI-CD Model: ROM-DRIVE-52MAX  Rev: 52CE
  Type:   CD-ROM                           ANSI SCSI revision: 02


                                                      -- GODoal --

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

