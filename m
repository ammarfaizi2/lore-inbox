Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbTFNSyy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265702AbTFNSyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 14:54:54 -0400
Received: from mailhost1-sfldmi.sfldmi.ameritech.net ([206.141.193.105]:39599
	"EHLO mailhost.det2.ameritech.net") by vger.kernel.org with ESMTP
	id S265701AbTFNSys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 14:54:48 -0400
Subject: Kernel Problem: A7N266-C and USB Hub
From: "Terrance A. Crow" <terrance@interstell.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1055617717.3603.11.camel@ohcmhwks051>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 15:08:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I"m running Red Hat 9.0 2.4.20-18.8. After upgrading via Up2Date to
2.4.20-18.9, the boot process would halt and leave no record of the
attempt in /var/log/dmesg. I added noapic to LILO.CONF, and the boot
process went a little farther. It recorded that /var was clean and the
file system was mounted in read/write mode, but then it would hang.

I found others who used the A7N266-C motherboard and USB hubs, so I
disconnected my Belkin USB 4-Port Hub F5U101. I had only one device
connected to it at the time: a Compaq iPaq cradle 176483-001. Once
detached, the system would boot normally. I removed noapic, and it
continued to boot normally.

My system is from AlienWare. It has 768Mb of RAM and is using an Athlon
2200+ processor. I boot from hdb (an 80Gb Seagate) and hda is an 80Gb
Western Digital. It has WinXP Pro installed, and I use LILO as my boot
manager.

Other than the Belkin USB port, I have no other USB devices in use. I
tried to use my mouse attached to the USB port, but as soon as I would
move it, the system would lock up -- very much like the boot lock up.
Both required me to power down the machine. 

I apologize that I did not copy dmesg in time -- it's been overwritten.

I hope this is enough information for you; additional configuration
information is below. If I can provide anything else, please let me
know.

Thank you.

The full version of the kernel that's now working shows as:

Linux version 2.4.20-18.9 (bhcompile@porky.devel.redhat.com) (gcc
version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Thu May 29 06:54:41 EDT 2003

Output of ver_linux:

Linux ohcmhwks051 2.4.20-18.9 #1 Thu May 29 06:54:41 EDT 2003 i686
athlon i386 GNU/Linux
  
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         vmnet parport_pc parport vmmon audigy ac97_codec
sound soundcore nvidia binfmt_misc e100 sg sr_mod ide-scsi scsi_mod
ide-cd cdrom ohci1394 ieee1394 loop lvm-mod keybdev mousedev hid input
usb-ohci usbcore ext3 jbd


Contents of /proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2200+
stepping        : 0
cpu MHz         : 1804.090
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
bogomips        : 3604.48

Output of lspci:

00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [40] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
        Capabilities: [60] #08 [2001]
 
00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
(rev b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
linux-kernel@vger.kernel.org<TAbort- <MAbort- >SERR- <PERR-
 
00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
(rev b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 
00:00.3 RAM memory: nVidia Corporation nForce 420 Memory Controller
(DDR) (rev b2)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 
00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [50] #08 [01e1]
 
00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=16]
        Region 1: I/O ports at 5500 [size=16]
        Region 2: I/O ports at 5100 [size=32]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev
c3) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ce800000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev
c3) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ce000000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
(prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: cc000000-cdffffff
        Prefetchable memory behind bridge: dff00000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 
00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) (prog-if
8a [Master SecP PriP])
        Subsystem: nVidia Corporation: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at b800 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
(prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000afff
        Memory behind bridge: cb000000-cbffffff
        Prefetchable memory behind bridge: cf700000-dfefffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 
01:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player/OEM
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game port
(rev 03)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at d400 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
(prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at cd800000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at cd000000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+
 
01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cc800000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at d000 [size=64]
        Region 2: Memory at cc000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 
02:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4600] (rev a2) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
8721
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at cb000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at cf800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at cf7e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4
 




-- 
Terrance A. Crow <terrance@interstell.com>

