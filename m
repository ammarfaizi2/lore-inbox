Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVAVNEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVAVNEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAVNEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:04:22 -0500
Received: from [81.188.70.163] ([81.188.70.163]:3502 "EHLO mordor.ath.cx")
	by vger.kernel.org with ESMTP id S262712AbVAVNDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:03:19 -0500
Subject: PROBLEM: Unable to handle kernel paging request at virtual address
	e080f003 / Oops: 0000 [#1]
From: Julien Cigar <mage@mordor.ath.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 22 Jan 2005 14:02:56 +0100
Message-Id: <1106398976.3116.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

#####################################################################

[1.] Problem when rebooting

#####################################################################

[2.] I'm running Debian/unstable and each time I reboot the system, I
get a "Unable to handle kernel pading request at virtual address ...". I
had the same problem on kernel versions 2.6.9, 2.6.10 (also with Debian
kernel-source-2.6.xx packages) and 2.6.11-rc1

#####################################################################

[3.] kernel, reboot, via-rhine

#####################################################################

[4.] Linux version 2.6.11-rc2-Debian (root@rivendell) (gcc version 3.3.5
(Debian 1:3.3.5-6)) #1 Sat Jan 22 12:54:18 CET 2005

#####################################################################

[5.] Nothing in the log, so I took a picture, see
http://mordor.ath.cx/stuff/kernelpb.jpg

#####################################################################

[6.] Nothing, except reboot -d -f -i

#####################################################################

[7.]

[7.1.] 
[root@rivendell:~]# /usr/src/linux-2.6.11-rc2/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux rivendell 2.6.11-rc2-Debian #1 Sat Jan 22 12:54:18 CET 2005 i686
GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.36-rc3
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   050
Modules Loaded         autofs4 floppy rtc evdev ov511 videodev

#####################################################################

[7.2.] 
[root@rivendell:~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1537.653
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
mca cmov pat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3022.84

#####################################################################

[7.3.] 
[root@rivendell:~]# cat /proc/modules
autofs4 16772 0 - Live 0xe0823000
floppy 54096 0 - Live 0xe0830000
rtc 11064 0 - Live 0xe0812000
evdev 7552 0 - Live 0xe0819000
ov511 81056 0 - Live 0xe0861000
videodev 7680 1 ov511, Live 0xe0816000

#####################################################################

[7.4.] 
[root@rivendell:~]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0823 : GPE0_BLK
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c800-c8ff : 0000:01:00.0
d800-d81f : 0000:00:10.0
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.1
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.2
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:10.3
  e400-e41f : uhci_hcd
e800-e83f : 0000:00:07.0
  e800-e83f : Ensoniq AudioPCI
ec00-ec7f : 0000:00:06.0
  ec00-ec7f : via-rhine
fc00-fc0f : 0000:00:0f.0
  fc00-fc07 : ide0
  fc08-fc0f : ide1

[root@rivendell:~]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00342cec : Kernel code
  00342ced-00428bff : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
bfd00000-dfcfffff : PCI Bus #01
  c8000000-cfffffff : 0000:01:00.1
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d0ffffff : vesafb
dfe00000-dfefffff : PCI Bus #01
  dfee0000-dfeeffff : 0000:01:00.1
  dfef0000-dfefffff : 0000:01:00.0
dffffd00-dffffdff : 0000:00:10.4
  dffffd00-dffffdff : ehci_hcd
dfffff80-dfffffff : 0000:00:06.0
  dfffff80-dfffffff : via-rhine
e0000000-e7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

#####################################################################

[7.5.]
[root@rivendell:~]# lspci -vvv|more

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600
AGP] Host Bridge (rev 80)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz+ UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-        Status: Cap+ 66MHz+ UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: bfd00000-dfcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Ethernet controller: VIA Technologies, Inc. VT86C100A
[Rhine] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX rev A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (29500ns min, 38000ns max), Cache Line Size: 0x08
(32 bytes)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at ec00 [size=128]
        Region 1: Memory at dfffff80 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at dffe0000 [disabled] [size=64K]

0000:00:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97]
(rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V,
AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at e800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0
+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF- FastB2B
+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
(prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
5901
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at dffffd00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-        Status: Cap+ 66MHz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R350
[Radeon 9800 Pro] (prog-if
00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-        Status: Cap+ 66MHz+ UDF- FastB2B
+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c800 [size=256]
        Region 2: Memory at dfef0000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc Radeon R350
[Radeon 9800 Pro] (Secondary)
        Subsystem: ATI Technologies Inc: Unknown device 0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-        Status: Cap+ 66MHz+ UDF- FastB2B
+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at dfee0000 (32-bit, non-prefetchable)
[size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

#####################################################################

[7.6.] I don't have any scsi devices.

#####################################################################

[7.7.] I don't have any kernel knownledges, but I suspect a problem in
the via-rhine driver. I don't have any problems on my others machines
and I don't think it's a Debian specific issue ...

I hope this bug report will be usefull for you (it was my first one).
In advance thanks, and sorry for my bad english.

#####################################################################

-- 
Julien Cigar <mage@mordor.ath.cx>

