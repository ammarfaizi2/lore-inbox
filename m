Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbTJXTeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbTJXTeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:34:31 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:30450 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262550AbTJXTeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:34:17 -0400
Date: Fri, 24 Oct 2003 12:34:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-ID: <20031024193402.GA985@ip68-0-152-218.tc.ph.cox.net>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net> <20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net> <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net> <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net> <20031018122708.GA401@schottelius.org> <20031018041448.6362faee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031018041448.6362faee.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 04:14:48AM -0700, Andrew Morton wrote:

> Nico Schottelius <nico-kernel@schottelius.org> wrote:
> >
> > another lspci -vvv where the card works f***cking slow:
> 
> There is a description of various diagnostic procedures in
> Documentation/networking/vortex.txt.  If you could run through those then
> wemight know more.

Okay.  First an odd part.  When the card does not work, I didn't get
anything in the syslog with debug=7, but I did get plenty when it works.
If you want this part I can send it along or put it up someplace.
Here's everything else however:

---- broken ----
+ lspci -vx -s 00:0e.0
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at e480 [size=128]
	[virtual] Memory at febffd80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 24 00 00 02 00 40 00 00
10: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 0a 0a

+ ./vortex-diag -aaee
vortex-diag.c:v2.14 12/28/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0xe480.
 Station address ff:ff:ff:ff:ff:ff.
  Receive mode is 0xff: Promiscuous.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 1: FIFO FIFO ffff ffff ffff ffff ffff ffff.
  Window 2: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 3: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 4: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 5: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 6: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 7: ffff ffff ffff ffff ffff ffff ffff ffff.
Vortex chip registers at 0xe480
  0xE490: **FIFO** ffffffff ffffffff *STATUS*
  0xE4A0: ffffffff ffffffff ffffffff ffffffff
  0xE4B0: ffffffff ffffffff ffffffff ffffffff
  0xE4C0: ffffffff ffffffff ffffffff ffffffff
  0xE4D0: ffffffff ffffffff ffffffff ffffffff
  0xE4E0: ffffffff ffffffff ffffffff ffffffff
  0xE4F0: ffffffff ffffffff ffffffff ffffffff
  DMA control register is ffffffff.
   DMA control register is ffffffff (during Tx Stall).
   Tx list starts at ffffffff.
   Tx FIFO thresholds: min. burst 8160 bytes, priority with 8160 bytes to empty.
   Rx FIFO thresholds: min. burst 8160 bytes, priority with 8160 bytes to full.
   Poll period Tx 81600 ns.,  Rx 8160 ns.
   Maximum burst recorded Tx 65535,  Rx 65535.
 Indication enable is ffff, interrupt enable is ffff.
 Interrupt sources are pending.
   Interrupt latch indication.
   Adapter Failure indication.
   Tx Complete indication.
   Tx Available indication.
   Rx Complete indication.
   Rx Early Notice indication.
   Driver Intr Request indication.
   Statistics Full indication.
   DMA Done indication.
   Download Complete indication.
   Upload Complete indication.
   DMA in Progress indication.
   Command in Progress indication.
 Transceiver/media interfaces available:  100baseT4 100baseTx 100baseFx 10baseT 10base2 AUI MII .
Transceiver type in use:  undefined-15.
 MAC settings: full-duplex, Large packets permitted, 802.1Q flow control, VLT VLAN enabled.
Maximum packet size is 65535.
 Station address set to ff:ff:ff:ff:ff:ff.
 Configuration options ffff.
EEPROM format 64x16, configuration table at offset 0:
    00: ffff ffff ffff ffff ffff ffff ffff ffff
      ...

 The word-wide EEPROM checksum is 0xfff8.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address FF:FF:FF:FF:FF:FF (used as a unique ID only).
 OEM Station address FF:FF:FF:FF:FF:FF (used as the ethernet address).
  Device ID ffff,  Manufacturer ID ffff.
  Manufacture date (MM/DD/YYYY) 15/31/2027, division ÿ, product ÿÿ.
  A BIOS ROM of size 960Kx8 is expected.
 Transceiver selection: undefined-15.
   Options: force full duplex, link beat check disabled.
 PCI Subsystem IDs: Vendor ffff Device ffff.
 100baseT4 100baseTx 100baseFx 10baseT 10base2 AUI MII .
  Vortex format checksum is incorrect (00 vs. ffff).
  Cyclone format checksum is incorrect (00 vs. 0xff).
  Hurricane format checksum is incorrect (00 vs. 0xff).
+ ./mii-diag -v
Using the default interface 'eth0'.
mii-diag.c:v2.09 9/06/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0xffff).
  No MII transceiver present!.
  Use '--force' to view the information anyway.
 MII PHY #24 transceiver registers:
   ffff ffff ffff ffff ffff ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff

---- fixed ----
+ lspci -vx -s 00:0e.0
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at e480 [size=128]
	Memory at febffd80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
00: b7 10 55 90 17 01 10 02 24 00 00 02 08 40 00 00
10: 81 e4 00 00 80 fd bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 bc fe dc 00 00 00 00 00 00 00 09 01 0a 0a

+ ./vortex-diag -aaee
vortex-diag.c:v2.14 12/28/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0xe480.
 Station address 00:10:4b:cb:96:2a.
  Receive mode is 0x07: Normal unicast and all multicast.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 4, registers values by window:
  Window 0: 0000 0000 0000 0000 f5f5 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 0000 0000 0000 0000 2000.
  Window 2: 1000 cb4b 2a96 0000 0000 0000 000a 4000.
  Window 3: 0000 0180 05ea 0020 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd2 0001 8880 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0000 0000 0000 0000 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0002 e000.
Vortex chip registers at 0xe480
  0xE490: **FIFO** 00000000 00000010 *STATUS*
  0xE4A0: 00000020 00000000 00080000 00000004
  0xE4B0: 00000000 09f2f60e 1f22a190 00080004
  0xE4C0: 0065a9eb 00000000 00000000 00000000
  0xE4D0: 00000000 00000000 00000000 00000000
  0xE4E0: 00000000 00000000 00000000 00000000
  0xE4F0: 00009000 00000000 01600160 00000000
  DMA control register is 00000020.
   Tx list starts at 00000000.
   Tx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to empty.
   Rx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to full.
   Poll period Tx 00 ns.,  Rx 0 ns.
   Maximum burst recorded Tx 352,  Rx 352.
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: full-duplex.
 Station address set to 00:10:4b:cb:96:2a.
 Configuration options 000a.
EEPROM format 64x16, configuration table at offset 0:
    00: 0010 4bcb 962a 9055 c4bd 0036 474e 6d50
  0x08: 2971 0000 0010 4bcb 962a 0010 0000 0022
  0x10: 32a2 0000 0000 0180 0000 0000 0000 10b7
  0x18: 9055 000a 0000 0000 0000 0000 0000 0000
  0x20: 00ad 0000 0000 0000 0000 0000 0000 0000
  0x28: 0000 0000 0000 0000 0000 0000 0000 0000
      ...

 The word-wide EEPROM checksum is 0xcd78.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address 00:10:4B:CB:96:2A (used as a unique ID only).
 OEM Station address 00:10:4B:CB:96:2A (used as the ethernet address).
  Device ID 9055,  Manufacturer ID 6d50.
  Manufacture date (MM/DD/YYYY) 5/29/1998, division 6, product NG.
  No BIOS ROM is present.
 Transceiver selection: Autonegotiate.
   Options: negotiated duplex, link beat required.
 PCI Subsystem IDs: Vendor 10b7 Device 9055.
 100baseTx 10baseT.
  Vortex format checksum is incorrect (c5 vs. 10b7).
  Cyclone format checksum is correct (0xad vs. 0xad).
  Hurricane format checksum is correct (0xad vs. 0xad).
+ ./mii-diag -v
Using the default interface 'eth0'.
mii-diag.c:v2.09 9/06/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0x3000).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

 MII PHY #24 transceiver registers:
   3000 786d 0000 0000 01e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   8000 0008 0090 0000 0000 0005 2001 0000
   0000 202e 0002 1c11 0002 1000 0000 0000

Anything else?

-- 
Tom Rini
http://gate.crashing.org/~trini/
