Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286166AbRLJGJD>; Mon, 10 Dec 2001 01:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286167AbRLJGIz>; Mon, 10 Dec 2001 01:08:55 -0500
Received: from mail303.mail.bellsouth.net ([205.152.58.163]:34236 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S286166AbRLJGIe>; Mon, 10 Dec 2001 01:08:34 -0500
Date: Mon, 10 Dec 2001 01:08:28 -0500 (EST)
From: Burton W <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: tulip-users@lists.sourceforge.net
cc: jgarzik@mandrakesoft.com, <linux-kernel@vger.kernel.org>
Subject: 2.4.17-pre7: Oops with Tulip
Message-ID: <Pine.LNX.4.43.0112100105140.211-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address
0000001b
c02b8b46
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02b8b46>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: d3f5053c   ebx: 00000000   ecx: 00000001   edx: d3f47940
esi: d3f7ff98   edi: 00000001   ebp: 00000008   esp: d3f7fe90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=d3f7f000)
Stack: 00000006 d3f7ff98 d3f47cc0 d3f47940 c02674b8 d3f7fec4 c0236ce2
d3f47800
       d3f47940 c02b99f1 d3f47800 d3f47800 c02674b1 00000001 c02c4ba4
d3f75800
       c02a54c0 00000000 c029891c d3f47874 d3f7ff18 00000000 00000001
00000000
Call Trace: [<c0236ce2>] [<c01e1421>] [<c01e1484>] [<c0105037>]
[<c010546c>]
Code: 80 7b 1b 00 0f 84 a7 03 00 00 8b 44 24 20 83 b8 58 02 00 00

>>EIP; c02b8b46 <tulip_parse_eeprom+176/530>   <=====
Trace; c0236ce2 <sprintf+12/18>
Trace; c01e1420 <pci_announce_device+34/50>
Trace; c01e1484 <pci_register_driver+48/60>
Trace; c0105036 <init+6/110>
Trace; c010546c <kernel_thread+28/38>
Code;  c02b8b46 <tulip_parse_eeprom+176/530>
00000000 <_EIP>:
Code;  c02b8b46 <tulip_parse_eeprom+176/530>   <=====
   0:   80 7b 1b 00               cmpb   $0x0,0x1b(%ebx)   <=====
Code;  c02b8b4a <tulip_parse_eeprom+17a/530>
   4:   0f 84 a7 03 00 00         je     3b1 <_EIP+0x3b1> c02b8ef6
<tulip_parse_eeprom+526/530>
Code;  c02b8b50 <tulip_parse_eeprom+180/530>
   a:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c02b8b54 <tulip_parse_eeprom+184/530>
   e:   83 b8 58 02 00 00 00      cmpl   $0x0,0x258(%eax)

 <0>Kernel panic: Attempted to kill init!

Raw oops:
ne.c: ISAPnP reports Generic PNP at i/o 0x280, irq 10.
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x280: 00 80 ad c9 e0 69
eth0: NE2000 found at 0x280, using IRQ 10.
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 9 for device 00:09.0
PCI: Setting latency timer of device 00:09.0 to 64
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII (0)
block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21140 non-MII (0)
block.
tulip0:  Index #3 - Media 10baseT-FDX (#4) described by a 21140 non-MII
(0) block.
tulip0:  Index #4 - Media 100baseTx-FDX (#5) described by a 21140 non-MII
(0) block.
tulip0:  MII transceiver #1 config 3100 status 7809 advertising 05e1.
eth1: Davicom DM9102/DM9102A rev 32 at 0xb800, 00:E0:3F:04:58:60, IRQ 9.
PCI: Enabling device 00:0b.0 (0080 -> 0083)
PCI: Assigned IRQ 9 for device 00:0b.0
PCI: Setting latency timer of device 00:0b.0 to 64
tulip1:  Controller 1 of multiport board.
Unable to handle kernel NULL pointer dereference at virtual address
0000001b
 printing eip:
c02b8b46
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02b8b46>]    Not tainted
EFLAGS: 00010296
eax: d3f5053c   ebx: 00000000   ecx: 00000001   edx: d3f47940
esi: d3f7ff98   edi: 00000001   ebp: 00000008   esp: d3f7fe90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=d3f7f000)
Stack: 00000006 d3f7ff98 d3f47cc0 d3f47940 c02674b8 d3f7fec4 c0236ce2
d3f47800
       d3f47940 c02b99f1 d3f47800 d3f47800 c02674b1 00000001 c02c4ba4
d3f75800
       c02a54c0 00000000 c029891c d3f47874 d3f7ff18 00000000 00000001
00000000
Call Trace: [<c0236ce2>] [<c01e1421>] [<c01e1484>] [<c0105037>]
[<c010546c>]

Code: 80 7b 1b 00 0f 84 a7 03 00 00 8b 44 24 20 83 b8 58 02 00 00
 <0>Kernel panic: Attempted to kill init!


morpheus:/home/bwindle# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10
MBit (rev 20)
00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:0b.0 Ethernet controller: Macronix, Inc. [MXIC] MX98713
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)

00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10
MBit (rev 20)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME+

00:0b.0 Ethernet controller: Macronix, Inc. [MXIC] MX98713
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at ff00 [disabled] [size=256]
	Region 1: Memory at 14000000 (32-bit, non-prefetchable) [disabled]
[size=256]
	Expansion ROM at e5eb0000 [disabled] [size=64K]


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.0/init/main.c:655



