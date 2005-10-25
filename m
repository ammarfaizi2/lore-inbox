Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVJYUY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVJYUY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVJYUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:24:57 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:30725 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S932349AbVJYUY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:24:56 -0400
Date: Tue, 25 Oct 2005 21:22:18 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Message-ID: <4DBF8B37C1%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
User-Agent: Messenger-Pro/3.30b1 (MsgServe/3.10) (RISC-OS/4.02) POPstar/2.06+cvs
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Mail-Followup-To: linux-kernel@vger.kernel.org,torvalds@osdl.org,linux@youmustbejoking.demon.co.uk
Subject: Re: Call for PIIX4 chipset testers
X-Editor: Zap 1.47 (17 Oct 2005) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Tue, 4438 Sep 1993 21:22:18 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1513533056--566338704--508276840"
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--1513533056--566338704--508276840
Content-Type: text/plain; charset=us-ascii

  $ dmesg | grep PIIX4
  PCI quirk: region 5000-503f claimed by PIIX4 ACPI
  PCI quirk: region 4000-401f claimed by PIIX4 SMB
  PIIX4 devres C PIO at 0100-0107
  PIIX4 devres I PIO at 00e0-00e3
  PIIX4 devres J PIO at 00f9-00fc
  PIIX4: IDE controller at PCI slot 0000:00:07.1
  PIIX4: chipset revision 1
  PIIX4: not 100% native mode: will probe irqs later
  uhci_hcd 0000:00:07.2: Intel Corporation 82371AB/EB/MB PIIX4 USB
  $

Machine is a Compaq Armada M700; /proc/ioports & lspci output are attached.

(Mail-Followup-To set, although I should see any replies via list archives.)

-- 
| Darren Salt | nr. Ashington, | d youmustbejoking,demon,co,uk
| Debian,     | Northumberland | s zap,tartarus,org
| RISC OS     | Toon Army      | @                      Say NO to UK ID cards
|                                                       http://www.no2id.net/

This is an empty line.

--1513533056--566338704--508276840
Content-Type: text/plain; charset=iso-8859-1; name="armada-m700_proc-ioports.txt"
Content-Disposition: attachment; filename="armada-m700_proc-ioports.txt"
Content-Transfer-Encoding: quoted-printable

0000-001f : dma1
0020-0021 : pic1
0022-0022 : PM2_CNT_BLK
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0c
0800-087f : pnp 00:0c
0cf8-0cff : PCI conf1
1000-1fff : PCI CardBus #02
2000-203f : 0000:00:09.0
  2000-203f : eepro100
2040-2047 : 0000:00:09.1
2050-205f : 0000:00:07.1
  2050-2057 : ide0
  2058-205f : ide1
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-401f : 0000:00:07.3
  4000-400f : motherboard
    4000-400f : pnp 00:0c
4020-403f : 0000:00:07.2
  4020-403f : uhci_hcd
4400-44ff : 0000:00:08.0
  4400-44ff : ESS Maestro
5000-503f : 0000:00:07.3
  5000-5003 : PM1a_EVT_BLK
  5004-5005 : PM1b_CNT_BLK
  5008-500b : PM_TMR
  500c-500f : GPE0_BLK
  5010-5015 : ACPI CPU throttle
6004-6005 : motherboard
  6004-6005 : PM1a_CNT_BLK
7000-7fff : PCI CardBus #02
8000-8fff : PCI CardBus #06
9000-9fff : PCI CardBus #06
f000-f0cf : motherboard
  f000-f0cf : pnp 00:0c

--1513533056--566338704--508276840
Content-Type: text/plain; charset=iso-8859-1; name="armada-m700_lspci_-xxx.txt"
Content-Disposition: attachment; filename="armada-m700_lspci_-xxx.txt"
Content-Transfer-Encoding: quoted-printable

0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX H=
ost bridge (rev 03)
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 10 b1
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c a2 00 ff 00 00 00 09 03 10 11 11 01 00 00 00
60: 04 04 08 08 0c 10 10 10 00 00 28 0f 00 fa 00 00
70: 20 1f 0a 38 00 00 0f 01 06 35 dc 38 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 80 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 eb 07 00 00 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 00 00 00 00 00 00
d0: 17 c0 ff ff 00 00 00 00 1c 00 00 00 00 00 00 00
e0: 9c b3 ff 7f 8f 3e 00 80 2c d3 f7 cf 9d 3e 00 00
f0: 40 01 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AG=
P bridge (rev 03)
00: 86 80 91 71 07 00 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 30 30 a0 22
20: 10 40 f0 41 00 10 00 10 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

0000:00:04.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00: 4c 10 1b ac 07 00 10 02 03 00 07 06 08 a8 82 00
10: 00 00 00 42 a0 00 00 02 00 02 05 b0 00 00 00 08
20: 00 f0 ff 09 00 00 00 0a 00 f0 ff 0b 00 10 00 00
30: fc 1f 00 00 00 70 00 00 fc 7f 00 00 0b 01 c0 05
40: 11 0e 13 b1 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 f0 44 20 80 00 00 00 81 81 81 09 00 00 00 00
90: 80 02 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00: 4c 10 1b ac 07 00 10 02 03 00 07 06 08 a8 82 00
10: 00 00 08 42 a0 00 00 02 00 06 09 b0 00 00 00 0c
20: 00 f0 ff 0d 00 00 00 0e 00 f0 ff 0f 00 80 00 00
30: fc 8f 00 00 00 90 00 00 fc 9f 00 00 0b 01 c0 05
40: 11 0e 13 b1 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 f0 44 20 80 00 00 00 81 81 81 09 00 00 00 00
90: 80 02 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00: 86 80 10 71 0f 01 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 30 04
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 80 0b 0b 92 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 08 40 08 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 c7 11 f0 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 25 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (re=
v 01)
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 51 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
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
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (r=
ev 01)
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 50 00 00 00 00 00 00 00 08 00 00 00 10 00 02
50: 00 00 18 00 00 00 00 00 23 00 00 02 00 00 00 b0
60: 04 60 21 62 00 01 67 f8 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 e0 00 13 00 f9 00 12 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2=
E (rev 10)
00: 5d 12 78 19 05 00 90 02 10 00 01 04 00 40 00 00
10: 01 44 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 12 b1
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 02 18
40: 60 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: c0 01 d0 0a 00 00 00 00 0c 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 22 76 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet P=
ro 100] (rev 09)
00: 86 80 29 12 07 00 90 02 09 00 00 02 08 42 80 00
10: 00 00 08 40 01 20 00 00 00 00 00 40 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 03 22
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 7e
e0: 00 40 00 3c 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.1 Serial controller: Agere Systems LT WinModem
00: c1 11 45 04 03 00 10 02 00 00 00 07 00 00 80 00
10: 41 20 00 00 00 00 10 42 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 03 22
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 7e
e0: 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobilit=
y P/M AGP 2x (rev 64)
00: 02 10 4d 4c 87 00 90 02 64 00 00 03 08 42 00 00
10: 00 00 00 41 01 30 00 00 00 00 10 40 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 11 b1
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00
40: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 5c 10 00 03 02 00 ff 00 00 00 00 01 00 01 06
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


--1513533056--566338704--508276840
Content-Type: text/plain; charset=iso-8859-1; name="armada-m700_lspci_-vvv.txt"
Content-Disposition: attachment; filename="armada-m700_lspci_-vvv.txt"
Content-Transfer-Encoding: quoted-printable

0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX H=
ost bridge (rev 03)
        Subsystem: Compaq Computer Corporation Armada M700/E500
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at 50000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART6=
4- HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit=
- FW- Rate=3D<none>

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AG=
P bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: 40100000-41ffffff
        Prefetchable memory behind bridge: 10000000-100fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

0000:00:04.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: Compaq Computer Corporation Armada M700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 42000000 (32-bit, non-prefetchable) [size=3D4=
K]
        Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D=
176
        Memory window 0: 08000000-09fff000 (prefetchable)
        Memory window 1: 0a000000-0bfff000
        I/O window 0: 00001000-00001fff
        I/O window 1: 00007000-00007fff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWr=
ite+
        16-bit legacy interface ports at 0001

0000:00:04.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: Compaq Computer Corporation Armada M700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 42080000 (32-bit, non-prefetchable) [size=3D4=
K]
        Bus: primary=3D00, secondary=3D06, subordinate=3D09, sec-latency=3D=
176
        Memory window 0: 0c000000-0dfff000 (prefetchable)
        Memory window 1: 0e000000-0ffff000
        I/O window 0: 00008000-00008fff
        I/O window 1: 00009000-00009fff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWr=
ite+
        16-bit legacy interface ports at 0001

0000:00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (re=
v 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 2050 [size=3D16]

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (r=
ev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 4020 [size=3D32]

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

0000:00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2=
E (rev 10)
        Subsystem: Compaq Computer Corporation Armada M700/E500
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 4400 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,=
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet P=
ro 100] (rev 09)
        Subsystem: Intel Corporation EtherExpress PRO/100+ MiniPCI
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 =
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 40080000 (32-bit, non-prefetchable) [size=3D4=
K]
        Region 1: I/O ports at 2000 [size=3D64]
        Region 2: Memory at 40000000 (32-bit, non-prefetchable) [size=3D1=
28K]
        Expansion ROM at 10100000 [disabled] [size=3D1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,=
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:00:09.1 Serial controller: Agere Systems LT WinModem (prog-if 00 [82=
50])
        Subsystem: Intel Corporation PRO/100+ MiniPCI (probably an Ambit =
U98.003.C.00 combo card)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 2040 [size=3D8]
        Region 1: Memory at 42100000 (32-bit, non-prefetchable) [size=3D4=
K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,=
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobilit=
y P/M AGP 2x (rev 64) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation Armada M700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 41000000 (32-bit, non-prefetchable) [size=3D1=
6M]
        Region 1: I/O ports at 3000 [size=3D256]
        Region 2: Memory at 40100000 (32-bit, non-prefetchable) [size=3D4=
K]
        Expansion ROM at 10000000 [disabled] [size=3D128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART=
64- HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit=
- FW- Rate=3D<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


--1513533056--566338704--508276840--
