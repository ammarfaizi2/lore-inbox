Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSEKHku>; Sat, 11 May 2002 03:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314494AbSEKHkt>; Sat, 11 May 2002 03:40:49 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:10244 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S314457AbSEKHkt>; Sat, 11 May 2002 03:40:49 -0400
Date: Sat, 11 May 2002 10:36:50 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: linux-kernel@vger.kernel.org
Subject: 3com 3c905cx-tx-nm "unknown device"
Message-ID: <20020511103650.A790@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have new 3com PCI NIC, which purpots to be a "3c905cx-tx-nm". The
3c59x module (kernel 2.4.19-pre3-ac2, I'll try -pre8 in a bit) fails
to recognize the card. 

lspci -vx (with the latest pci.ids file) shows:

00:09.0 Ethernet controller: 3Com Corporation: Unknown device ffff (rev 78)
     Flags: bus master, medium devsel, latency 64, IRQ 11
     I/O ports at 6500 [size=128]
     Expansion ROM at <unassigned> [disabled] [size=128K]
     Capabilities: [dc] Power Management version 2
00: b7 10 ff ff 07 00 10 02 78 00 00 02 08 40 00 00
10: 01 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 1e 3f

Donald Becker's vortex-diag program shows:

[root@alhambra 3com]# ./vortex-diag -p 0x6500 -t 17 -ee
vortex-diag.c:v2.06 4/18/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Assuming a 3c905C Tornado 100baseTx adapter at 0x6500.
EEPROM format 64x16, configuration table at offset 0:
      ...

 The word-wide EEPROM checksum is 0000.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address FF:FF:FF:FF:FF:FF (used as a unique ID only).
 OEM Station address ff:FF:FF:FF:FF:FF (used as the ethernet address).
  Device ID ffff,  Manufacturer ID ffff.
  Manufacture date (MM/DD/YYYY) 15/31/.
  A BIOS ROM of size 960Kx8 is expected.
 Options: force full duplex, link beat check disabled.
  Vortex format checksum is incorrect (0000 vs. ffff).
  Cyclone format checksum is incorrect (00 vs. 0xff).
  Hurricane format checksum is incorrect (00 vs. 0xff).

How can I debug this further? 
Thanks in advance!
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
