Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUE1H4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUE1H4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 03:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbUE1H4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 03:56:00 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:24749 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265865AbUE1Hzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 03:55:42 -0400
Message-ID: <40B6F080.7010507@local.se>
Date: Fri, 28 May 2004 09:55:44 +0200
From: Jonas Lundgren <jonas@local.se>
Reply-To: jonas@local.se
User-Agent: Mozilla Thunderbird 0.6 (X11/20040506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jsimmons@infradead.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: Framebuffer + geforce FX5200
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Framebuffer console mode won't work when S-Video cable is connected 
to graphic card. (geforce FX5200, 128MB, look below)

2. Ever since I bought my new gfx card(geforce FX5200, look below) I've 
had this problem, it took me like a day to figure it out.. While I was 
trying
to get fb to work (which it had with my other card, a Geforce 2 pro gts 
64mb) i noticed that when the S-Video cable was connected to the gfx card i
got a "unsupported mode, please enter another video mode or press space 
for default"(or something like that) when (re)booting, but if i removed the
s-video cable this problem would dissapear. (I guess this has something 
to do with the card having s-video output enabled automaticlu when booting
(i.e. i can see the POST and bootup on my tv)
So, i tought "sure, i can remove the cable everytime i reboot and then 
plug it in after the framebuffer is detected" since i reboot my wks like 
every
20-40 days or something. But, when i do this (shut down comp, remove 
s-video cable, boot, detect fb, start fb, insert s-video cable, log in, 
start
xfree) everything works fine in x, s-video works ad everything, BUT, if 
i shut down xfree i get a fucked up console (my screen says out of sync and
displays some crazy resolution), after that i can still write commands, 
it's just the screen thats fucked up, and i can also restart x and 
everything
is fine.

3. nvidia-kernel-1.0.5336(-r3, gentoo), nvidia-glx-1.0.5336(-r2, gentoo)

4. Linux version 2.6.5-gentoo-r1 (root@alpha) (gcc version 3.3.3 
20040412 (Gentoo Linux 3.3.3-r3, ssp-3.3-7, pie-8.5.3)) #4 Thu May 20 
15:30:21 CEST
2004

5. -

6. How to repeat:

example 1:
reboot box with s-video cable attached
framebuffer won't work.

example 2:
remove s-video cable (before (re)booting)
bootup, after framebuffer is started re-attach the cable
log in
start X
shut down X

7. Env.

7.1.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

  Linux alpha 2.6.5-gentoo-r1 #4 Thu May 20 15:30:21 CEST 2004 i686 AMD 
Athlon(tm) XP 2800+ AuthenticAMD GNU/Linux

   Gnu C                  3.3.3
   Gnu make               3.80
   binutils               2.14.90.0.8
   util-linux             2.12
   mount                  2.12
   module-init-tools      3.0
   e2fsprogs              1.35
   nfs-utils              1.0.6
   Linux C Library        2.3.3
   Dynamic linker (ldd)   2.3.3
   Procps                 3.2.1
   Net-tools              1.60
   Kbd                    1.12
   Sh-utils               5.2.1
   Modules Loaded         lirc_atiusb lirc_dev nvidia

7.2.
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2800+
stepping        : 0
cpu MHz         : 2088.007
cache size      : 512 KB
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
bogomips        : 4128.76

7.3.
lirc_atiusb 8708 0 - Live 0xf89c3000
lirc_dev 11112 2 lirc_atiusb, Live 0xf89bf000
nvidia 2069416 20 - Live 0xf8bff000

7.4.
/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial
03c0-03df : vga+
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5500-5507 : nForce2 SMBus
a000-bfff : PCI Bus #01
   a000-a01f : 0000:01:0a.0
     a000-a01f : EMU10K1
   a400-a407 : 0000:01:0a.1
   a800-a807 : 0000:01:0b.0
   ac00-ac03 : 0000:01:0b.0
   b000-b007 : 0000:01:0b.0
   b400-b403 : 0000:01:0b.0
   b800-b80f : 0000:01:0b.0
c000-cfff : PCI Bus #02
   c000-c07f : 0000:02:01.0
     c000-c07f : 0000:02:01.0
d000-d0ff : 0000:00:06.0
d400-d47f : 0000:00:06.0
e000-e01f : 0000:00:01.1
e400-e407 : 0000:00:04.0
f000-f00f : 0000:00:09.0
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d17ff : Extension ROM
000d2000-000d67ff : Extension ROM
000d7000-000d77ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-002ea0b8 : Kernel code
   002ea0b9-0037c0ff : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #03
   d0000000-d7ffffff : 0000:03:00.0
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #02
   dd000000-dd00007f : 0000:02:01.0
de000000-dfffffff : PCI Bus #03
   de000000-deffffff : 0000:03:00.0
e0000000-e1ffffff : PCI Bus #01
   e1000000-e10001ff : 0000:01:0b.0
     e1000000-e10001ff : SiI3112 Serial ATA
e2000000-e207ffff : 0000:00:05.0
e2080000-e2080fff : 0000:00:06.0
e2082000-e2082fff : 0000:00:02.1
   e2082000-e2082fff : ohci_hcd
e2083000-e20830ff : 0000:00:02.2
   e2083000-e20830ff : ehci_hcd
e2084000-e2084fff : 0000:00:04.0
e2085000-e2085fff : 0000:00:02.0
   e2085000-e2085fff : ohci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5.

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d8000000 (32-bit, prefetchable)
         Capabilities: [40] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8
         Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 0
         Region 0: I/O ports at e000
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e2085000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 5
         Region 0: Memory at e2082000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 5
         Region 0: Memory at e2083000 (32-bit, non-prefetchable)
         Capabilities: [44] #0a [2080]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a7
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e2084000 (32-bit, non-prefetchable)
         Region 1: I/O ports at e400 [size=8]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 3000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e2000000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
         Subsystem: Asustek Computer, Inc.: Unknown device 8095
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at d000
         Region 1: I/O ports at d400 [size=128]
         Region 2: Memory at e2080000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000a000-0000bfff
         Memory behind bridge: e0000000-e1ffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Expansion ROM at 0000a000 [disabled] [size=8K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: dc000000-ddffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         Expansion ROM at 0000c000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: de000000-dfffffff
         Prefetchable memory behind bridge: d0000000-d7ffffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:01:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 08)
         Subsystem: Creative Labs CT4832 SBLive! Value
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at a000
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 08)
         Subsystem: Creative Labs Gameport Joystick
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 0: I/O ports at a400
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 
3112 SATARaid Controller (rev 02)
         Subsystem: CMD Technology Inc: Unknown device 6112
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 01
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at a800
         Region 1: I/O ports at ac00 [size=4]
         Region 2: I/O ports at b000 [size=8]
         Region 3: I/O ports at b400 [size=4]
         Region 4: I/O ports at b800 [size=16]
         Region 5: Memory at e1000000 (32-bit, non-prefetchable) [size=512]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated 
Fast Ethernet Controller (rev 40)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ab
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at c000
         Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=128]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:03:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce 
FX 5200] (rev a1) (prog-if 00 [VGA])
         Subsystem: ABIT Computer Corp.: Unknown device 8f15
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at de000000 (32-bit, non-prefetchable)
         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8

7.6.
Scsi not enabled.

7.7.
cat /proc/driver/nvidia/version
NVRM version: NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 
14 18:29:26 PST 2004
GCC version:  gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r3, 
ssp-3.3-7, pie-8.5.3)

cat /proc/driver/nvidia/cards/0
Model:           GeForce FX 5200
IRQ:             5
Video BIOS:      04.34.20.27.00
Card Type:       AGP

cat /proc/interrupts
            CPU0
   0:  648932809          XT-PIC  timer
   1:     635926          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:  196351682          XT-PIC  ide2, ide3, ehci_hcd, ohci_hcd, 
ohci_hcd, EMU10K1, nvidia, eth0
   8:          2          XT-PIC  rtc
NMI:          0
ERR:       1631


I can't think of anything else right now, but if you should need more 
(speciffic) info, please email me at jonas@local.se

Also please excuse my less-than-perfect-english, I'm swedish ;)

-- 
Best regards, Jonas Lundgren

ICQ:    #52064961
IRC:    neonman @ EFnet, Undernet, Quakenet
Mail:   jonas.lundgren@local.se
