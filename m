Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUFFIdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUFFIdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFFIdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:33:50 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36316 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263085AbUFFIdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:33:24 -0400
Message-ID: <40C28573.6070704@comcast.net>
Date: Sat, 05 Jun 2004 22:46:11 -0400
From: Miles Lane <miles.lane@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-bk6 -- mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x200000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting an error using the nv open-source driver
for the GeForce FX 5600 board.

vesafb: framebuffer at 0xd0000000, mapped to 0xf8808000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:f530
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x200000

root@Monkey100:~# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1
reg03: base=0xd0000000 (3328MB), size=   2MB: write-combining, count=1

root@Monkey100:~# lspci -vvxxx
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable)
         Capabilities: [40] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=x4
         Capabilities: [60] #08 [2001]
00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 02 60 30 00 1b 42 00 1f 01 00 00 00 ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 01 9f
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 0c 01 00 00 ff ff ff 5f 01 00 00 00 01 80 00 00
90: 0e 80 e0 f2 0e 80 e0 f0 f0 0f ff 00 00 00 00 00
a0: 00 00 00 00 22 e2 3d 00 01 00 00 00 00 00 00 00
b0: cc ff 07 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 33 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 56 01 47 00 16 30 00 10 00 00 00 00 00 00 00 00
f0: 07 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
(rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 eb 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 04 00 00 70 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 16 05 42 81 01 00 00 00 01 00 00 00 01 00 00 00
70: 18 04 00 00 18 04 00 00 2c 07 00 01 40 07 00 01
80: 01 00 00 00 f3 13 0f 03 08 05 08 05 78 c8 a6 3f
90: 0b 8c 33 33 40 22 43 22 00 21 54 02 0d 22 77 07
a0: 6a 00 00 00 00 00 10 00 6a 00 00 00 00 00 10 00
b0: 6a 00 00 00 00 00 10 00 2a 00 00 00 01 00 10 00
c0: 00 31 22 02 00 00 00 00 00 00 00 00 ff ff 02 00
d0: 44 4e 00 00 22 22 00 00 0d 00 00 00 1e 00 00 00
e0: 1a 00 00 00 80 00 00 00 88 44 44 10 b1 04 30 40
f0: 10 18 1e 03 04 10 04 3f 09 44 1c 04 01 03 70 30

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ee 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 01 20 da 12 01 20 da 12 01 20 da 12 01 00 37 1f
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: ff ef ff 07 ff ff fd 07 ff ef ff 07 ff ff df 07
80: ff ff ff 07 ff ef 6d 04 ff df 7f 05 ff ef ff 05
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 f4 03 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 80 ff ff ff bf
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ed 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 30 00 00 00 00 90 00 00 63 00 00 00 71 07 00 00
50: 76 06 00 00 72 95 00 00 68 ea 00 00 50 40 20 00
60: e9 00 00 00 00 06 f7 67 00 ea aa aa 88 ba 00 77
70: 01 80 e0 01 6a 00 00 00 03 10 01 20 55 00 02 01
80: ff ff 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
90: ff 10 ff 10 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: ff 30 00 00 ff 30 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 04 40 00 00 ff ff ff ff
f0: 1c 40 00 00 ff ff ff ff ff ff ff ff ff ff ff ff

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ec 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: aa 33 aa 33 aa 33 aa 33 aa 33 aa 33 aa 33 aa 33
70: ff 99 ff 99 f0 00 00 00 7f 3e e0 0f aa 33 aa 33
80: ff 99 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 3f 3f 3d 3d 3d 3d 3d 3c 0e 0e 0d 0d 0d 0d 0d 0d
a0: 00 00 00 00 a5 56 00 80 00 00 00 00 5f 05 a0 00
b0: 78 56 34 12 ef cd ab 89 9b 4a 66 22 ee bd dc 8b
c0: 66 06 53 07 00 00 00 00 55 55 55 00 00 00 00 00
d0: ff 20 ff 20 ff 20 ff 7f 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ef 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 39 e9 f4 09 39 e9 f4 09
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 ff ff ff 3f 00 00 00 00 ff ff ff 3f
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [48] #08 [01e1]
00: de 10 60 00 0f 00 b0 00 a4 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ad 80
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00
40: 43 10 ad 80 de fd 3c 08 08 00 e1 01 60 00 88 08
50: a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 40 00 00 01 44 00 00 01 42 00 00 00 00 f8 ff
70: 10 00 ff ff 03 00 00 00 0f 00 00 00 18 d2 00 00
80: 09 82 8d 00 d2 d2 28 22 3f 00 00 00 00 00 00 00
90: 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: cc 00 02 00 0a 00 00 00 00 00 00 00 00 00 00 00
e0: 00 11 00 07 1f 50 00 00 00 20 00 08 00 00 00 00
f0: 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 23
         Region 0: I/O ports at e000
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 64 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 43 10 11 0c 01 00 02 c0 00 00 00 00 00 00 10 00
50: 01 50 00 00 01 55 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at ee087000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 70 08 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01
40: 43 10 11 0c 01 00 02 fe 00 00 00 00 02 00 00 00
50: 13 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 21
         Region 0: Memory at ee082000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 20 08 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 03 01
40: 43 10 11 0c 01 00 02 fe 00 00 00 00 03 00 00 00
50: 2c 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 20
         Region 0: Memory at ee083000 (32-bit, non-prefetchable)
         Capabilities: [44] #0a [2080]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 68 00 06 00 b0 00 a4 20 03 0c 00 00 80 00
10: 00 30 08 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 03 03 01
40: 43 10 11 0c 0a 80 80 20 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 01 00 00 60 98 81 c3 13 00 00 00 00 00 00
70: 00 00 00 05 00 10 20 80 89 3d 84 22 e7 25 04 80
80: 01 00 02 fe 00 00 00 00 00 00 00 00 15 16 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 04 e0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
         Subsystem: Asustek Computer, Inc.: Unknown device 80a7
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 22
         Region 0: Memory at ee086000 (32-bit, non-prefetchable)
         Region 1: I/O ports at e400 [size=8]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00
10: 00 60 08 ee 01 e4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a7 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14
40: 43 10 a7 80 01 00 02 fe 00 01 00 00 04 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 3000ns max)
         Interrupt: pin A routed to IRQ 21
         Region 0: Memory at ee000000 (32-bit, non-prefetchable)
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 6b 00 06 00 b0 00 a2 00 01 04 00 00 00 00
10: 00 00 00 ee 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 01 0c
40: 43 10 11 0c 01 00 02 06 00 00 00 00 0a 05 00 00
50: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
60: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
70: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
80: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
90: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
a0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
b0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
c0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
d0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
e0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06
f0: 01 00 02 06 01 00 02 06 01 00 02 06 01 00 02 06

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 
AC97 Audio Controler (MCP) (rev a1)
         Subsystem: Asustek Computer, Inc.: Unknown device 8095
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at d000
         Region 1: I/O ports at d400 [size=128]
         Region 2: Memory at ee080000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 6a 00 07 00 b0 00 a1 00 01 04 00 00 00 00
10: 01 d0 00 00 01 d4 00 00 00 00 08 ee 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 95 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 05
40: 43 10 95 80 01 00 02 06 00 00 00 00 06 01 00 01
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000a000-0000bfff
         Memory behind bridge: ec000000-edffffff
         Expansion ROM at 0000a000 [disabled] [size=8K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: de 10 6c 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 a0 b0 80 22
20: 00 ec f0 ed f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
40: 00 00 00 00 01 00 02 00 01 00 00 00 08 0b 07 00
50: 0c 0d fe 5f 0e 0f 00 00 70 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 43 10 11 0c 01 00 02 00 00 00 00 00 00 09 00 00
50: 03 f0 00 00 00 00 00 00 20 20 a8 20 20 00 20 20
60: c0 c0 00 c6 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 c0 52 1c 00 00 02 38 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: e8000000-e9ffffff
         Expansion ROM at 0000c000 [disabled] [size=4K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: de 10 6d 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 c0 c0 80 22
20: 00 e8 f0 e9 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
40: 00 00 00 00 01 00 02 00 01 00 00 00 12 1b 04 00
50: 1c 1d fe 5f 1e 1f 00 00 7f 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire 
(IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 809a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 21
         Region 0: Memory at ee084000 (32-bit, non-prefetchable)
         Region 1: Memory at ee085000 (32-bit, non-prefetchable) [size=64]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: de 10 6e 00 07 00 b0 00 a3 10 00 0c 00 00 00 00
10: 00 40 08 ee 00 50 08 ee 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 9a 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01
40: 00 00 00 00 01 00 02 fe 00 80 00 00 13 14 00 01
50: 43 10 9a 80 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
         Memory behind bridge: ea000000-ebffffff
         Prefetchable memory behind bridge: d0000000-dfffffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: de 10 e8 01 07 01 20 02 c1 00 04 06 00 10 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 20 f0 00 20 22
20: 00 ea f0 eb 00 d0 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 01 00 00 00 00 00 f0 5f 20 00 00 00 ff ff ff ff
50: 00 00 00 00 00 00 00 10 ff ff ff ff ff ff ff ff
60: ff 40 ff 40 00 00 00 20 00 00 00 00 ff ff ff ff
70: ff ff ff ff 00 00 00 00 00 00 00 00 ff ff ff ff
80: ff ff ff ff 00 80 00 00 8c 01 00 00 ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 1b 42 00 1f ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil 
3112/3112A ] (rev 02)
         Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) 
Asus A7N8X
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at a000
         Region 1: I/O ports at a400 [size=4]
         Region 2: I/O ports at a800 [size=8]
         Region 3: I/O ports at ac00 [size=4]
         Region 4: I/O ports at b000 [size=16]
         Region 5: Memory at ed000000 (32-bit, non-prefetchable) [size=512]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 95 10 12 31 07 00 b0 02 02 00 04 01 08 10 00 00
10: 01 a0 00 00 01 a4 00 00 01 a8 00 00 01 ac 00 00
20: 01 b0 00 00 00 00 00 ed 00 00 00 00 95 10 12 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 10 20 08 b0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 22 00 00 00 22 00 00 00 00 00 c0 00 fb ff 7f 6e
90: 00 fc 01 01 0f ff 00 00 00 00 00 18 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated 
Fast Ethernet Controller [Tornado] (rev 40)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ab
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at c000
         Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=128]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b7 10 01 92 07 00 10 02 40 00 00 02 08 10 00 00
10: 01 c0 00 00 00 00 00 e9 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ab 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 fe
e0: 00 40 00 b7 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:03:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce 
FX 5600] (rev a1) (prog-if 00 [VGA])
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 9123
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at ea000000 (32-bit, non-prefetchable)
         Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>
00: de 10 12 03 07 00 b0 02 a1 00 00 03 00 10 00 00
10: 00 00 00 ea 08 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 23 91
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
40: 62 14 23 91 02 00 30 00 1b 0e 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
