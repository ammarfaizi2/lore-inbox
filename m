Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268859AbRHFQls>; Mon, 6 Aug 2001 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRHFQli>; Mon, 6 Aug 2001 12:41:38 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:21009 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S268859AbRHFQla>; Mon, 6 Aug 2001 12:41:30 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC54B@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Albert D. Cahalan'" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: RE: tulip driver problem
Date: Mon, 6 Aug 2001 12:35:50 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have similar problem. The tulip driver in 2.4.7 doesn't work.
The driver version is 0.9.15-pre6.
Error msg:
	tulip0: ***Warning*** : No MII transeiver found.

The tulip driver version 0.9.14 in 2.4.2 works, though.


-----Original Message-----
From: Albert D. Cahalan [mailto:acahalan@cs.uml.edu]
Sent: Monday, August 06, 2001 12:19 PM
To: linux-kernel@vger.kernel.org
Subject: tulip driver problem



The tulip driver in 2.4.8-pre3 does not work.
The tulip driver version 0.9.14 from sourceforge does not work.
The tulip driver in 2.2.14 is OK.
The de4x5 driver does not work.
I think I had the driver in 2.4.3 working at one point.

The error I'm getting from the 0.9.14 driver:
NETDEV WATCHDOG: eth0: transmit timed out

This is the Force PowerCore 6750 single-board computer with
a PowerPC processor and the DEC 21143 Ethernet chip.

Booting 2.2.14 shows:

POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
remapping IO (0x10e3:0x0 BAR 0): 0xbff001 -> 0xbff000
remapping MEM(0x10e3:0x0 BAR 1): fcfff000 -> 0xfcfff000
remapping IO (0x1011:0x19 BAR 0): 0xbfef81 -> 0xbfef80
remapping MEM(0x1011:0x19 BAR 1): fcffec00 -> 0xfcffec00
Linux NET4.0 for Linux 2.2
...
RAM disk driver initialized:  16 RAM disks of 4096K size
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21143 Tulip rev 65 at 0xbfef80, 00:80:42:0E:CF:E8, IRQ 9.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth0:  Index #1 - Media AUI (#2) described by a 21142 Serial PHY (2) block.
eth0:  MII transceiver #1 config 1000 status 782d advertising 00a1.
Looking up port of RPC 100003/2 on 172.16.101.112
Looking up port of RPC 100005/1 on 172.16.101.112
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 68k init 32k prep 8k pmac 12k open firmware

The firmware (which likes the Ethernet just fine) reports the
host bridge and Ethernet as:

Probing PCIbus at 0x80000000
Device ID = 0x0002; Vendor ID = 0x1057; 
Status    = 0x0080; Command   = 0x0146; 
Base Class= 0x06;   Sub Class = 0x00;   Prg. Inter= 0x00;   Rev. ID   =
0x40; 
BIST      = 0x00;   Header Typ= 0x00;   Latency Ti= 0x00;   Cache Line=
0x08; 
base addr0= 0x00000000, base addr1= 0x00000000; 
Max Lat   = 0x00;   Min Gnt   = 0x00;   IRQ Pin   = 0x00;   IRQ Line  =
0x00; 
Found PCI device: Motorola MPC106 PowerPC PCI bridge

Probing PCIbus at 0x8000D800
Device ID = 0x0019; Vendor ID = 0x1011; 
Status    = 0x0280; Command   = 0x0005; 
Base Class= 0x02;   Sub Class = 0x00;   Prg. Inter= 0x00;   Rev. ID   =
0x41; 
BIST      = 0x00;   Header Typ= 0x00;   Latency Ti= 0x20;   Cache Line=
0x00; 
base addr0= 0x00850001, base addr1= 0x00000000; 
Max Lat   = 0x28;   Min Gnt   = 0x14;   IRQ Pin   = 0x01;   IRQ Line  =
0xFF; 
Found PCI device: DEC 21143 PCI/Cardbus Ethernet LAN

When using lspci I get:

00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
        Flags: bus master, fast devsel, latency 0

00:1b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at bfef80
        Memory at fcffec00 (32-bit, non-prefetchable)
        Expansion ROM at b7fc0000 [disabled]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
