Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRCLR6F>; Mon, 12 Mar 2001 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRCLR54>; Mon, 12 Mar 2001 12:57:56 -0500
Received: from [193.120.151.1] ([193.120.151.1]:42736 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S130516AbRCLR5r>;
	Mon, 12 Mar 2001 12:57:47 -0500
From: "John Brosnan" <jbrosnan@asitatech.ie>
To: <tulip@scyld.com>, <linux-kernel@vger.kernel.org>
Cc: "John Brosnan" <jbrosnan@asitatech.ie>
Subject: Linux 2.2.16/Tulip Smartbits testing. 
Date: Mon, 12 Mar 2001 18:18:04 -0000
Message-ID: <015001c0ab20$c7ae0e70$8d7fa8c0@NTWIGGY.asitatech.ie>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

we've been running some throughput tests (Smartbits
test box) using Donald Becker's tulip.c:v0.92 on Linux 2.2.16,
on a Pentium 3 800Mhz and a 4 port Dlink DFE-570TX see log below.
Basically Smartbits allows one to set the packet size, speed, protocol,
etc. For example if you start at 64 byte size packets and set
an initial rate of 20Mb/s and a max of 80 Mb/s it goes
up and down until it finds the optimum rate. At the moment
w're trying some UDP tests.

The problem is that as the rate increases, the number of
packets received decreases until is goes to zero, then for all
further iterations of that 64 packet size test, no matter
how slow the rate gets, the number of packets received is always
0. It does not recover from being flooded until the Smartbits moves to
the next packet size, performs learning frames and then the same
eventually thing happens again.

Has anybody ever run any tests like this before ?
Is it a driver or a kernel issue ? Any ideas ?

Performance also looks pretty bad for the smaller packet sizes
but does improve as the packet size increases.

We're just trying to figure out why absolutely no packets
are received no matter how slow the rate gets.

thanks in advance for any help,

John.


Mar  9 15:52:41 : tulip.c:v0.92 4/17/2000  Written by Donald Becker
<becker@scyld.com>
Mar  9 15:52:41 :   http://www.scyld.com/network/tulip.html
Mar  9 15:52:41 : eth1: Digital DS21143 Tulip rev 65 at 0xc8812c00,
00:80:C8:CF:BE:D1, IRQ 11.
Mar  9 15:52:41 : eth1:  EEPROM default media type Autosense.
Mar  9 15:52:41 : eth1:  Index #0 - Media MII (#11) described by a 21142 MII
PHY (3) block.
Mar  9 15:52:41 : eth1:  MII transceiver #1 config 3100 status 7869
advertising 01e1.
Mar  9 15:52:41 : eth2: Digital DS21143 Tulip rev 65 at 0xc8814800,
00:80:C8:CF:BE:D2, IRQ 10.
Mar  9 15:52:41 : eth2:  EEPROM default media type Autosense.
Mar  9 15:52:41 : eth2:  Index #0 - Media MII (#11) described by a 21142 MII
PHY (3) block.
Mar  9 15:52:41 : eth2:  MII transceiver #1 config 3100 status 7869
advertising 01e1.
Mar  9 15:52:41 : eth3: Digital DS21143 Tulip rev 65 at 0xc8816400,
00:80:C8:CF:BE:D3, IRQ 9.
Mar  9 15:52:41 : eth3:  EEPROM default media type Autosense.
Mar  9 15:52:41 : eth3:  Index #0 - Media MII (#11) described by a 21142 MII
PHY (3) block.

Mar  9 15:52:41 : eth3:  MII transceiver #1 config 3100 status 7869
advertising 01e1.
Mar  9 15:52:41 : eth4: Digital DS21143 Tulip rev 65 at 0xc8818000,
00:80:C8:CF:BE:D4, IRQ 12.
Mar  9 15:52:41 : eth4:  EEPROM default media type Autosense.
Mar  9 15:52:41 : eth4:  Index #0 - Media MII (#11) described by a 21142 MII
PHY (3) block.
Mar  9 15:52:41 : eth4:  MII transceiver #1 config 3100 status 7849
advertising 01e1.
Mar  9 15:52:41 : eth1: Setting full-duplex based on MII #1 link partner
capability of 41e1.
Mar  9 15:52:41 : eth2: Setting full-duplex based on MII #1 link partner
capability of 41e1.
Mar  9 15:52:41 : eth3: Setting full-duplex based on MII #1 link partner
capability of 41e1.
Mar  9 15:52:42


