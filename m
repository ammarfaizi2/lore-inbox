Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHUMQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHUMQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUHUMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:16:07 -0400
Received: from gathered-geeks.org ([217.160.210.51]:37843 "EHLO
	p15132835.pureserver.info") by vger.kernel.org with ESMTP
	id S264251AbUHUMOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:14:35 -0400
Message-ID: <41273CB1.1090302@cbeppler.de>
Date: Sat, 21 Aug 2004 14:14:41 +0200
From: Christopher Beppler <info@cbeppler.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040816
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: DMA over CPU" memory leak in Kernel 2.6.8.1
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi... this is my first bug report. I hope that it will help you.

Thank You

1.
"DMA over CPU" memory leak if I burn Audio-CDs

2.
I installed Linux 2.6.8.1 and tried to burn an Audio-CD. Then the PC 
swapped a lot until he freezes. I tried to increase the swap-partition 
without a success. Then I stopped burning with xcdroast and burned on 
the bash directly with cdrecord (dev=ATAPI:0,1,0). Then I saw always at 
the same time. DMA over CPU-Error... an many memory dumps rushed over my 
screen and he started "swapping to death" He killed some processes to 
get more memory (I have 256MB RAM and 384 MB swap). I am not able to 
print these Error-Messages, because I have no access to my PC then. Then 
I installed Linux 2.6.7 again and everything works probably.

3.
hdd, memory, swap, dma over cpu

4.
Linux version 2.6.8.1 (root@christopher) (gcc-Version 3.3.3) #1 Wed Aug 
18 19:50:01 CEST 2004

6.
cdrecord -dev=ATAPI:0,1,0 -dummy -speed=8 -audio *.wav

7.1.
cdrecord               2.00.3
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_pcm_oss snd_mixer_oss agpgart nvidia 
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore via_rhine mii crc32

7.2.
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1333.922
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2629.63

7.3.
snd_pcm_oss 49128 0 - Live 0xd0d26000
snd_mixer_oss 17344 3 snd_pcm_oss, Live 0xd0d10000
agpgart 27624 0 - Live 0xd0ca5000
nvidia 4819348 12 - Live 0xd1188000
snd_emu10k1 91848 3 - Live 0xd0bde000
snd_rawmidi 20352 1 snd_emu10k1, Live 0xd0bc6000
snd_pcm 84964 2 snd_pcm_oss,snd_emu10k1, Live 0xd0bf8000
snd_timer 21124 1 snd_pcm, Live 0xd0bbf000
snd_seq_device 6536 2 snd_emu10k1,snd_rawmidi, Live 0xd0b90000
snd_ac97_codec 66436 1 snd_emu10k1, Live 0xd0bcc000
snd_page_alloc 8968 2 snd_emu10k1,snd_pcm, Live 0xd0ba3000
snd_util_mem 3264 1 snd_emu10k1, Live 0xd0b93000
snd_hwdep 7200 1 snd_emu10k1, Live 0xd0b9b000
snd 46052 12 
snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, 
Live 0xd0baa000
soundcore 7392 3 snd, Live 0xd0b87000
via_rhine 18760 0 - Live 0xd0b95000
mii 4032 1 via_rhine, Live 0xd0b8c000
crc32 3840 1 via_rhine, Live 0xd0b8a000

7.4.
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
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
d000-d01f : 0000:00:09.0
   d000-d01f : EMU10K1
d400-d407 : 0000:00:09.1
d800-d8ff : 0000:00:0a.0
   d800-d8ff : via-rhine
dc00-dc0f : 0000:00:11.1
   dc00-dc07 : ide0
   dc08-dc0f : ide1
e000-e01f : 0000:00:11.2
e400-e41f : 0000:00:11.3
e800-e81f : 0000:00:11.4

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cebff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
   00100000-00271434 : Kernel code
   00271435-002de13f : Kernel data
d0000000-dfffffff : PCI Bus #01
   d0000000-d7ffffff : 0000:01:00.0
     d0000000-d02fffff : vesafb
   d8000000-d807ffff : 0000:01:00.0
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
   e4000000-e4ffffff : 0000:01:00.0
     e4000000-e4ffffff : nvidia
e7000000-e70000ff : 0000:00:0a.0
   e7000000-e70000ff : via-rhine

7.5.
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
         Subsystem: Elitegroup Computer Systems: Unknown device 0996
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: e4000000-e5ffffff
         Prefetchable memory behind bridge: d0000000-dfffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
         Subsystem: Creative Labs: Unknown device 8064
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d000 [size=32]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
         Subsystem: Creative Labs Gameport Joystick
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 0: I/O ports at d400 [size=8]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 43)
         Subsystem: D-Link System Inc DFE-530TX rev A
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (750ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d800 [size=256]
         Region 1: Memory at e7000000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
         Subsystem: Elitegroup Computer Systems: Unknown device 0996
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])        Sub 
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at dc00 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at e000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at e400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at e800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 
Ti4400] (rev a2) (prog-if 00 [VGA])
         Subsystem: LeadTek Research Inc.: Unknown device 2892
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Region 2: Memory at d8000000 (32-bit, prefetchable) [size=512K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4
