Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTI3W3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTI3W26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:28:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38304 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261771AbTI3W2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:28:38 -0400
Date: Tue, 30 Sep 2003 12:58:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: a.j.dejong-1@student.utwente.nl
Subject: [Bug 1300] New: /dev/sound/dsp claims to be busy, but lsof gives nothing
Message-ID: <17860000.1064951882@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1300

           Summary: /dev/sound/dsp claims to be busy, but lsof gives nothing
    Kernel Version: Linux version 2.6.0-test6 (root@hennep.adsl.utwente.nl)
                    (gcc ver
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: a.j.dejong-1@student.utwente.nl


Distribution: Gentoo Linux 1.4 3.2.3-r1, propolice

Modules:
lp 8192 0 - Live 0xd8905000
radeon 117848 0 - Live 0xd893c000
sd_mod 11648 0 - Live 0xd88f9000
scsi_mod 60096 1 sd_mod, Live 0xd8908000

Hardware Environment:

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 3
cpu MHz         : 631.565
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1245.18

/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:1f.5
  1000-10ff : Intel 82801AA-ICH - AC'97
1400-141f : 0000:00:1f.2
  1400-141f : uhci-hcd
1800-180f : 0000:00:1f.3
1c00-1c0f : 0000:00:1f.1
  1c00-1c07 : ide0
  1c08-1c0f : ide1
2000-203f : 0000:00:1f.5
  2000-203f : Intel 82801AA-ICH - Controller
3000-30ff : 0000:01:09.0
3400-343f : 0000:01:08.0
  3400-343f : e100

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-003b48f8 : Kernel code
  003b48f9-004a8ebf : Kernel data
17ff0000-17fffbff : ACPI Tables
17fffc00-17ffffff : ACPI Non-volatile Storage
e8100000-e810ffff : 0000:01:09.0
e8110000-e8110fff : 0000:01:08.0
  e8110000-e8110fff : e100
e8120000-e813ffff : 0000:01:08.0
  e8120000-e813ffff : e100
f0000000-f7ffffff : 0000:01:09.0
fff00000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller
Hub] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp. 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 1c00 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
        Subsystem: Intel Corp. 82801AA SMBus
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1800 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
        Subsystem: Siemens Nixdorf AG: Unknown device 0049
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 2000 [size=64]

01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
        Subsystem: Siemens Nixdorf AG: Unknown device 004b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8110000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 3400 [size=64]
        Region 2: Memory at e8120000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,
D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:09.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 
7500] (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd RV200 QW [Radeon 7500 PCI Dual 
Display]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,
D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

/proc/asound/oss/devices
  1:       : sequencer
  8:       : sequencer
  3: [0- 3]: digital audio
  0: [0- 0]: mixer

/proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 
UTC).
Compiled on Sep 28 2003 for kernel 2.6.0-test6.


Software Environment:
Linux hennep.adsl.utwente.nl 2.6.0-test6 #1 Sun Sep 28 20:28:00 CEST 2003 i686 
Celeron (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
reiserfsprogs          3.6.8
xfsprogs               2.3.9
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         lp radeon sd_mod scsi_mod


Problem Description:
When playing audio with cplay, it suddenly stops after about a day (both times 
it happened while I was sleeping, so I don't know exactly, it could be exactly 
24hrs). It won't start playing again, mplayer gives me 'Device /dev/sound/dsp is 
busy' while 'lsof /dev/sound/dsp' gives me nothing. I tried restarting X, that 
didn't help. Restarting the whole system did. I never had this problem with any 
kernel before 2.6.0_test6. (I used all the 2.6.0 testkernels except test3)

Steps to reproduce:

let cplay play for a day on 2.6.0_test6


