Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRCaTlU>; Sat, 31 Mar 2001 14:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRCaTlJ>; Sat, 31 Mar 2001 14:41:09 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:52983 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S132483AbRCaTkw> convert rfc822-to-8bit; Sat, 31 Mar 2001 14:40:52 -0500
Date: Sat, 31 Mar 2001 21:40:10 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
To: linux-kernel@vger.kernel.org
Subject: epic100 aka smc etherpower II
Message-ID: <Pine.LNX.4.21.0103312129170.6125-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i can`t get my smc etherpower ii working with the 2.4.3 kernel.
now i have downgraded to 2.4.2 and it works again ...
does anyone have a suggestion, what the problem is ?

daniel

this are the interesting lines from /var/log/messages:
during the bootup:
(debugging enabled in the driver)
Mar 31 18:52:17 hyperion kernel: epic100.c:v1.11 1/7/2001 Written by
Donald Becker <becker@scyld.com>
Mar 31 18:52:17 hyperion
kernel:   http://www.scyld.com/network/epic100.html
Mar 31 18:52:17 hyperion kernel:  (unofficial 2.4.x kernel port, version
1.1.6, January 11, 2001)
Mar 31 18:52:17 hyperion kernel:  e000 0c29 a15a f000 001d 1c08 10b8 a011
0000 0000 0000 0000 0000 0000 0000 0000
Mar 31 18:52:17 hyperion kernel:  0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
Mar 31 18:52:17 hyperion kernel:  0010 0000 1980 2100 0000 0000 0003 0000
0701 0000 0000 0000 4d53 3943 3334 5432
Mar 31 18:52:17 hyperion kernel:  2058 2020 0000 0000 0280 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
Mar 31 18:52:17 hyperion kernel: epic100(00:09.0): MII transceiver #3
control 3000 status 7809.
Mar 31 18:52:17 hyperion kernel: epic100(00:09.0): Autonegotiation
advertising 01e1 link partner 0001.
Mar 31 18:52:17 hyperion kernel: eth0: SMSC EPIC/100 83c170 at 0x6500, IRQ
11, 00:e0:29:0c:5a:a1.

later, short after end of bootup:

Mar 31 19:23:29 hyperion kernel: eth0: Setting half-duplex based on MII
xcvr 3 register read of 0001.
Mar 31 19:23:29 hyperion kernel: Real Time Clock Driver v1.10d
Mar 31 19:23:29 hyperion kernel: eth0: Setting full-duplex based on MII #3
link partner capability of 45e1.
Mar 31 19:24:31 hyperion kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 31 19:24:31 hyperion kernel: eth0: Transmit timeout using MII device,
Tx status 4003.
Mar 31 19:24:33 hyperion kernel: eth0: Setting half-duplex based on MII #3
link partner capability of 0001.
Mar 31 19:24:35 hyperion kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 31 19:24:35 hyperion kernel: eth0: Transmit timeout using MII device,
Tx status 0003.

aditional there was the error message : to much work at interrupt ...

lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97]
(rev 03)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 31)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 01)
00:08.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev
02)
00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF
(rev 06)
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev
08)
00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II]

network hardware:
smc etherpower ii connected to an 10/100 mbit nway autoneg. switch




***************************************************
Daniel Nofftz
Sysadmin CIP Pool der Informatik 
Universität Trier, V 103
Mail: daniel@nofftz.de
***************************************************

"One World, One Web, One Program" - Microsoft Promotional Ad 
"Ein Volk, Ein Reich, Ein Fuhrer" - Third Reich Promotional Ad

