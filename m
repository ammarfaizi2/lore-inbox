Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbRFVL4Q>; Fri, 22 Jun 2001 07:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265383AbRFVL4G>; Fri, 22 Jun 2001 07:56:06 -0400
Received: from venus.postmark.net ([207.244.122.71]:23559 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S265382AbRFVLzw>; Fri, 22 Jun 2001 07:55:52 -0400
Message-ID: <20010622125923.27671.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, becker@scyld.com
Subject: 2.4.6-pre4 tulip driver still mashed with 21041
Date: Fri, 22 Jun 2001 12:59:23 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been following the development of the tulip driver with some
interest because my hardware requires it! I have described the
hardware setup I use before, but I can post it again if necessary.

I will only be able to test new versions/fixes until Tuesday morning
(UK) because then I lose my ethernet connection and will not get it
back again :-(

The tests below were done with a freshly compiled 2.4.6-pre4 kernel
with no additional patches of any kind. The last kernel that worked
for me straight out of the tarball was 2.4.4-ac6

The symptoms are that with anything above 2.4.4-ac6 nothing gets
through to or from the network to my box.

The results I get from running "tulip-diag -aa -ee" having run
"/etc/rc.d/init.d/network start" (RH 7.1) are:

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0xd800.
 * A potential Tulip chip has been found, but it appears to be
active.
 * Either shutdown the network, or use the '-f' flag to see all
values.
Digital DC21041 Tulip chip registers at 0xd800:
 0x00: ffe08000 ffffffff ffffffff 0129a000 0129a200 fc660000 fffe2202
ffffebef
 Port selection is full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000050c8.


When I set "network stop", the results are:

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DC21041 Tulip adapter at 0xd800.
Digital DC21041 Tulip chip registers at 0xd800:
 0x00: ffe08000 ffffffff ffffffff 0129a000 0129a200 fc000102 fffe0200
fffe0000
 0x40: fffe0000 ffff4bf0 ffffffff fffe0000 000050c8 ffffef01 ffffffff
ffff0008
 Port selection is full-duplex.
 Transmit stopped, Receive stopped, full-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000050c8.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 0000, device 0000.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:C0:F0:14:7B:AE.
EEPROM transceiver/media description table.
Leaf node at offset 30, default media type 0800 (Autosense).
 3 transceiver description blocks:
  21041 media index 00 (10baseT).
  21041 media index 01 (10base2).
  21041 media index 04 (10baseT-Full Duplex).
EEPROM contents (64 words):
0x00:  0000 0000 0000 0000 0000 0000 0000 0000
0x08:  0000 0101 c000 14f0 ae7b 1e00 0000 0800
0x10:  0003 0401 0000 0000 0000 0000 0000 0000
0x18:  0000 0000 0000 0000 0000 0000 0000 0000
0x20:  0000 0000 0000 0000 0000 0000 0000 0000
0x28:  0000 0000 0000 0000 0000 0000 0000 0000
0x30:  0000 0000 0000 0000 0000 0000 0000 0000
0x38:  0000 0000 0000 0000 0000 0000 104b 38f4
 ID block CRC 0xe3 (vs. 00).
  Full contents CRC 0x38f4 (read as 0x38f4).
  Internal autonegotiation state is 'Negotiation complete'.


    John
----------------
jbk@postmark.net

