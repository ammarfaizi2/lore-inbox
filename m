Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLAKax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 05:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTLAKax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 05:30:53 -0500
Received: from pop.gmx.de ([213.165.64.20]:9133 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262110AbTLAKan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 05:30:43 -0500
X-Authenticated: #2203603
Message-ID: <00c801c3b7f5$eafb8ad0$7727048b@de.uu.net>
From: "Daniel Flinkmann" <dflinkmann@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Corrupt files with kernel 2.6.0_test11 and smb mounts
Date: Mon, 1 Dec 2003 11:28:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just resending the file, because the subject wasn't correct. 


[1.] One line summary of the problem:

2.6.0test11 overwriting file on mounted smb volume causes corrupted files! 

[2.] Full description of the problem/report:

When I log into a smb mounted directory and I overwrite a file with 
a file which has smaller amount of bytes its corrupting the data. 

Easy way to show this is following:

cd onto a smbfs mounted dir. 

># echo test1234567890 >test.txt
># cat test.txt
test1234567890
># echo hi! >test.txt
># cat test.txt
hi!
1234567890
># 

As you can see the file is not overwritten as it should be. 

[3.] Keywords (i.e., modules, networking, kernel):

2.6test11, smb filesystem

[4.] Kernel version (from /proc/version):

Linux version 2.6.0-test11 (root@tower) (gcc version 3.3.1 (Mandrake Linux
9.2 3.3.1-2mdk)) #1 Sat Nov 29 00:18:20 CET 2003


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

n.a.

[6.] A small shell script or example program which triggers the
      problem (if possible)

mounting a smb volume e.g. /mnt/smb type smbfs

># echo test1234567890 >test.txt
># cat test.txt
test1234567890
># echo hi! >test.txt
># cat test.txt
hi!
1234567890
># 


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)



[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 701.335
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1384.44

[7.3.] Module information (from /proc/modules):
ipv6 243232 - - Live 0xf09d3000
sg 32664 - - Live 0xf0924000
joydev 9472 - - Live 0xf0914000
agpgart 31816 - - Live 0xf091b000
nls_cp437 5440 - - Live 0xf0906000
nls_iso8859_1 3776 - - Live 0xf08a2000
smbfs 66264 - - Live 0xf0975000
af_packet 20168 - - Live 0xf08f0000
sr_mod 16868 - - Live 0xf0900000
floppy 59252 - - Live 0xf0965000
8139too 20800 - - Live 0xf0909000
mii 4896 - - Live 0xf08ed000
crc32 4128 - - Live 0xf08ea000
ohci1394 33672 - - Live 0xf08f6000
ieee1394 220780 - - Live 0xf092e000
nls_iso8859_15 4352 - - Live 0xf0824000
ntfs 89420 - - Live 0xf088b000
ide_scsi 14948 - - Live 0xf082a000
scsi_mod 75788 - - Live 0xf08a4000
ide_cd 40996 - - Live 0xf087f000
cdrom 35616 - - Live 0xf0811000
uhci_hcd 30640 - - Live 0xf081b000
usbcore 107036 - - Live 0xf0831000
rtc 11640 - - Live 0xf080d000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
ioports:
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
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
c000-c00f : 0000:00:07.1
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : 0000:00:07.2
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:07.3
  c800-c81f : uhci_hcd
cc00-ccff : 0000:00:07.5
  cc00-ccff : via82cxxx_audio
d000-d003 : 0000:00:07.5
  d000-d003 : via82cxxx_audio
d400-d403 : 0000:00:07.5
  d400-d403 : via82cxxx_audio
dc00-dc7f : 0000:00:09.0
e000-e0ff : 0000:00:0c.0
  e000-e0ff : 8139too

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
  00100000-002bd6fd : Kernel code
  002bd6fe-0034adff : Kernel data
d0000000-d1ffffff : 0000:00:00.0
d2000000-d4ffffff : PCI Bus #01
  d2000000-d2003fff : 0000:01:00.0
  d3000000-d37fffff : 0000:01:00.0
d5000000-d5ffffff : PCI Bus #01
  d5000000-d5ffffff : 0000:01:00.0
d7000000-d70000ff : 0000:00:0c.0
  d7000000-d70000ff : 8139too
d7001000-d70017ff : 0000:00:09.0
  d7001000-d70017ff : ohci1394
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
03)
        Subsystem: Elitegroup Computer Systems: Unknown device 0987
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d2000000-d4ffffff
        Prefetchable memory behind bridge: d5000000-d5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (
rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0987
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
Audio Controller (rev 50)
        Subsystem: Elitegroup Computer Systems: Unknown device 0987
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at cc00 [size=256]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at d400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d7001000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at d7000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d5000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at d3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x2


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-R/RW SW-252B  Rev: R701
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

Please let me know what kind if information you guys need.

cheers,

Daniel

-- 
http://www.uuhome.de/df/


