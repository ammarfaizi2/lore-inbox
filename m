Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266998AbUBMNar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267000AbUBMNar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:30:47 -0500
Received: from netra27.desy.de ([131.169.40.141]:17320 "EHLO netra27.desy.de")
	by vger.kernel.org with ESMTP id S266998AbUBMNaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:30:20 -0500
Date: Fri, 13 Feb 2004 14:30:17 +0100 (MET)
From: James Ferrando <ferrando@mail.desy.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.2 external ps/2 mouses cannot be unplugged and then
    plugged back in
Message-ID: <Pine.LNX.4.55.0402131406030.27562@zuklin05.desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm trying out 2.6 kernels, and have noticed a problem not present in
the 2.4.24 kernel:

[1.] One line summary of the problem:
i use a DELL Latidude C610, when I unplug a logitech ps/2 mouse in X, then
control shifts back to the built in touchpad controls, but plugging in the
PS/2 mouse in X causes mouse control to be lost, and never recovered.

[2.] Full description of the problem/report:
Performance of the mouse in X is different under 2.6.x kernels to 2.4.x
Mouse response is generally much faster, however resilience of the system
to plugging and unplugging of the mouse (A 3-button logitech ps/2 mouse
S/N LZA20467731) is deteriorated.



Whilst running both debian stable and testing configurations , the system
is not able to deal with the plugging in of the mouse. The touchpad works
fine, and unplugging the mouse, if the system is powered up with the mouse
plugged in causes no problem. However, plugging in the mouse whilst
running X cause the pointer to freeze in position, and it cannot be moved,
nor do any other responses to mouse or touchpad input cause any effect.
This behaviour has been obsevered whilst running KDE 3.1.4 and 3.1.5 on
the version of Xfree86-4 current to this distribution.
This behaviour has not been replicated running under 2.4.x series kernels.

Possibly related is a problem when using the touchpad, where saving in
xemacs causes momentary loss of control of the mouse pointer. This has
been observed using both enlightenment 0.16 and KDE 3.1.x, again this
problem is not observed running with 2.4.x kernels.



[4.] Kernel version (from /proc/version):
Linux version 2.6.2 (root@localhost) (gcc version 3.3.2 (Debian)) #7 Fri
Feb 13 1 3:39:22 CET 2004

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux localhost 2.6.2 #7 Fri Feb 13 13:39:22 CET 2004 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.1
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         pcmcia_core i810_audio ac97_codec 3c59x


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
stepping        : 1
cpu MHz         : 731.070
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat p
se36 mmx fxsr sse
bogomips        : 1445.88


[7.3.] Module information (from /proc/modules):
pcmcia_core 55680 0 - Live 0xd08c6000
i810_audio 28948 1 - Live 0xd08ac000
ac97_codec 17388 1 i810_audio, Live 0xd08a6000
3c59x 34824 0 - Live 0xd089c000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
bf80-bf9f : 0000:00:1d.0
  bf80-bf9f : uhci_hcd
bfa0-bfaf : 0000:00:1f.1
  bfa0-bfa7 : ide0
  bfa8-bfaf : ide1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d400-d4ff : 0000:00:1f.6
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH3
dc00-dc7f : 0000:00:1f.6
dc80-dcbf : 0000:00:1f.5
  dc80-dcbf : Intel ICH3
ec80-ecff : 0000:02:00.0
  ec80-ecff : 0000:02:00.0


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffe27ff : System RAM
  00100000-0033882e : Kernel code
  0033882f-00405ebf : Kernel data
0ffe2800-0fffffff : reserved
10000000-100003ff : 0000:00:1f.1
10001000-10001fff : 0000:02:01.0
10002000-10002fff : 0000:02:01.1
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
f8fffc00-f8fffc7f : 0000:02:00.0
fc000000-fdffffff : PCI Bus #01
  fcff0000-fcffffff : 0000:01:00.0
feda0000-fedfffff : reserved
ffb80000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [40] #09 [1105]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=x1

00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at bf80 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
        I/O behind bridge: 0000e000-0000ffff
        Memory behind bridge: f4000000-fbffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 4541
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at bfa0 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
Controller (rev 02)
        Subsystem: Cirrus Logic: Unknown device 5959
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc80 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
(prog-if 00 [Generic])
        Subsystem: PCTel Inc Dell Inspiron 2100 internal modem
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at dc00 [size=128]
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6
LY (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00e3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at fcff0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 00e3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec80 [size=128]
        Region 1: Memory at f8fffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:01.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Dell Computer Corporation: Unknown device 00e3
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled]
[size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001
02:01.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: Dell Computer Corporation: Unknown device 00e3
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10002000 (32-bit, non-prefetchable) [disabled]
[size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
Problem not observed in 2.4.x series kernels. In all other respects 2.6.x
kernels produce speed and performance improvements over 2.4.x

			Yours,
				James



---------------------------------------------------------
				James Ferrando
				Glasgow ZEUS Group
---------------------------------------------------------


