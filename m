Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317626AbSFMO5k>; Thu, 13 Jun 2002 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317629AbSFMO5j>; Thu, 13 Jun 2002 10:57:39 -0400
Received: from host213-121-105-182.in-addr.btopenworld.com ([213.121.105.182]:1019
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S317626AbSFMO5f>; Thu, 13 Jun 2002 10:57:35 -0400
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
From: Matthew Hall <matt@ecsc.co.uk>
To: Donald Becker <becker@scyld.com>
Cc: Kernel <linux-kernel@vger.kernel.org>, jgarzik@mandrakesoft.com
In-Reply-To: <Pine.LNX.4.33.0206112336340.2253-100000@presario>
Content-Type: multipart/mixed; boundary="=-TfJP82B709eo+qfkn/Ua"
Organization: ECSC Ltd.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 13 Jun 2002 15:57:26 +0100
Message-Id: <1023980246.1090.25.camel@smelly.dark.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TfJP82B709eo+qfkn/Ua
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for your reply Donald,
	I have tried and tested the sundance.c file as you indicated, and the
netdrivers packages with a recompiled kernel, yet we still cannot get
this (damn) card working :)

We're still getting these transmit timeouts:
NETDEV WATCHDOG: eth5: transmit timed out
eth5: Transmit timed out, status 00, resetting...
  Rx ring c71d4000:  00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
  Tx ring c71d5000:  80008001 80008005 80008009 8000800d 80008011
80008015 80008019 8000801d 80008021 0000 0000 0000 0000 0000 0000 0000

(it is still in the back of my head whether the card works at all...)

Just in case you can provide any more insight into this I compiled the
alta-diag tool, for debugging purposes, the results of -aa, -ee and -mm
are attached, aswell as the full detection message from dmesg after
modprob'ing the module.

Thanks in advance,
Matthew Hall

On Wed, 2002-06-12 at 04:39, Donald Becker wrote:
> On 11 Jun 2002, Matthew Hall wrote:
>=20
> > To: Kernel <linux-kernel@vger.kernel.org>
> > Cc: becker@scyld.com, jgarzik@mandrakesoft.com
> ...
> > I have been testing the D-Link DFE-580TX Quad channel server card (4
> > port nic), on kernel 2.4.18 with little success.
> >
> > Attached are the appropriate results of dmesg, ifconfig, lspci and
> > modules.conf; aswell as the results of the pci-testing tool found on
> > scyld.com, however the card does not support mii testing, claiming to
> > have no MII transceiver.
>=20
> Please provide the full detection message.
>=20
> It appears that you are using a driver that doesn't correctly read the
> EEPROM, and has additional problems.  Try a current driver from
>    http://www.scyld.com/network/ethercard.html
>       ftp://www.scyld.com/pub/network/sundance.c
>    http://www.scyld.com/network/updates.html
>=20
> and run diagnostic program from
>   http://www.scyld.com/diag/index.html
>=20
>=20
> --=20
> Donald Becker				becker@scyld.com
> Scyld Computing Corporation		http://www.scyld.com
> 410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
> Annapolis MD 21403			410-990-9993
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Matthew Hall -- matt@ecsc.co.uk -- http://people.ecsc.co.uk/~matt/
Sig: When I was a boy I was told that anybody could become President. Now I=
'm
beginning to believe it. - Clarence Darrow=20

--=-TfJP82B709eo+qfkn/Ua
Content-Disposition: attachment; filename=alta-diag_aa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=alta-diag_aa; charset=ISO-8859-1

[root@installed root]# alta-diag -aa
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xec80.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:21.
Sundance Technology Alta chip registers at 0xec80
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 5c37 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 19f5 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 fbfb 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 e65d 2109 05ea 0800 0001
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #2: Found a Sundance Technology Alta adapter at 0xec00.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:22.
Sundance Technology Alta chip registers at 0xec00
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 49a0 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 f67c 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 fbfb 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 e65d 2209 05ea 0800 0000
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #3: Found a Sundance Technology Alta adapter at 0xe880.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:23.
Sundance Technology Alta chip registers at 0xe880
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 376b 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 acfb 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 fbfb 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 e65d 2309 05ea 0800 0000
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000
Index #4: Found a Sundance Technology Alta adapter at 0xe800.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:24.
Sundance Technology Alta chip registers at 0xe800
 0x00: 0000 0000 0000 0000 0408 0000 0000 0000
 0x10: 0000 0000 0408 0000 2526 0000 0000 0000
 0x20: 0000 0000 0000 0000 0000 0000 0000 0000
 0x30: 4063 0000 f21f 02ff 0000 0000 1ffc 1ffc
 0x40: 0000 0000 fbfb 0000 0000 ---- 0000 0100
 0x50: 0000 0000 0500 e65d 2409 05ea 0800 0000
 0x60: 0000 0000 0000 0000 0000 0000 0000 0000
 0x70: 0000 0000 0000 0000 0000 0000 0000 0000


--=-TfJP82B709eo+qfkn/Ua
Content-Disposition: attachment; filename=alta-diag_ee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=alta-diag_ee; charset=ISO-8859-1

[root@installed root]# alta-diag -ee
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xec80.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:21.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 e65d 2109 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 cc20 4e0d cc9a 19f5
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 e65d 2109 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 cc20 4e0d cc9a 19f5
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:e6:09:21.
  Configuration 2afc, ASIC Control c063.
Index #2: Found a Sundance Technology Alta adapter at 0xec00.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:22.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 e65d 2209 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 e1e3 fd99 a941 f67c
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 e65d 2209 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 e1e3 fd99 a941 f67c
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:e6:09:22.
  Configuration 2afc, ASIC Control c063.
Index #3: Found a Sundance Technology Alta adapter at 0xe880.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:23.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 e65d 2309 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 faa2 9315 8a08 acfb
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 e65d 2309 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 faa2 9315 8a08 acfb
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:e6:09:23.
  Configuration 2afc, ASIC Control c063.
Index #4: Found a Sundance Technology Alta adapter at 0xe800.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:24.
EEPROM contents:
0x000:  2afc c063 1186 1012 0000 0000 0000 0000
0x008:  0000 0000 0000 0000 0000 0000 0000 0000
0x010:  0500 e65d 2409 0064 0000 0000 0000 0000
0x018:  3400 0100 3702 0300 083a 3f04 0303 0103
0x020:  0000 0000 0000 0000 0000 0000 0000 0000
0x028:  0000 0000 0000 0000 0000 0000 0000 0000
0x030:  0000 0000 0000 0000 0000 0000 0000 0000
0x038:  0000 0000 0000 0000 0000 0000 0000 0000
0x040:  0000 0000 0000 0000 0000 0000 0000 0000
0x048:  0000 0000 0000 0000 0000 0000 0000 0000
0x050:  0000 0000 0000 0000 0000 0000 0000 0000
0x058:  0000 0000 0000 0000 0000 0000 0000 0000
0x060:  0000 0000 0000 0000 0000 0000 0000 0000
0x068:  0000 0000 0000 0000 0000 0000 0000 0000
0x070:  0000 0000 0000 0000 0000 0000 0000 0000
0x078:  0000 0000 0000 0000 bc24 41c0 64b6 f21f
0x080:  2afc c063 1186 1012 0000 0000 0000 0000
0x088:  0000 0000 0000 0000 0000 0000 0000 0000
0x090:  0500 e65d 2409 0064 0000 0000 0000 0000
0x098:  3400 0100 3702 0300 083a 3f04 0303 0103
0x0a0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0a8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0b8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0c8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0d8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0e8:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f0:  0000 0000 0000 0000 0000 0000 0000 0000
0x0f8:  0000 0000 0000 0000 bc24 41c0 64b6 f21f
EEPROM Subsystem IDs, Vendor 1186 Device 1012.
  EEPROM Station address is 00:05:5d:e6:09:24.
  Configuration 2afc, ASIC Control c063.

--=-TfJP82B709eo+qfkn/Ua
Content-Disposition: attachment; filename=alta-diag_mm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=alta-diag_mm; charset=ISO-8859-1

root@installed root]# alta-diag -mm
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xec80.
  Receive mode is 0x00: Unknown/invalid.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0100: Link status changed
  Station address 00:05:5d:e6:09:21.
 MII PHY found at address 0, status 0x7809.
 MII PHY found at address 1, status 0x7809.
 MII PHY #0 transceiver registers:
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 MII PHY #1 transceiver registers:
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 MII PHY #0 transceiver registers:
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   1100 7809 0022 1630 01e1 0040 0004 2001
   0000 0000 0000 0000 0000 0000 0000 0000.
 Basic mode control register 0x1100: Auto-negotiation enabled.
 Basic mode status register 0x7809 ... 7809.
   Link status: not established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation not complete.
 Vendor ID is 00:08:85:--:--:--, model 35 rev. 0.
   No specific information is known about this transceiver type.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 0040: 10baseT-FD.
   Negotiation did not complete.
15:51:21.000  Baseline value of MII BMSR (basic mode status register) is 78=
09.

--=-TfJP82B709eo+qfkn/Ua
Content-Disposition: attachment; filename=detectionmessage
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=detectionmessage; charset=ISO-8859-1

root@installed root]# lsmod
Module                  Size  Used by    Not tainted
iptable_mangle          2080   0  (autoclean) (unused)
iptable_nat            15028   0  (autoclean) (unused)
iptable_filter          1696   0  (autoclean) (unused)
ip_conntrack           15532   1  (autoclean) [iptable_nat]
ip_tables              11616   5  [iptable_mangle iptable_nat iptable_filte=
r]
eepro100               17584   1=20
[root@installed root]# modprobe sundance
[root@installed root]# dmesg |tail -n 18
NETDEV WATCHDOG: eth5: transmit timed out
eth5: Transmit timed out, status 00, resetting...
  Rx ring c71d4000:  00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
  Tx ring c71d5000:  80008001 80008005 80008009 8000800d 80008011 80008015 =
80008019 8000801d 80008021 0000 0000 0000 0000 0000 0000 0000
sundance.c:v1.01b 17-Jan-2002  Written by Donald Becker
  http://www.scyld.com/network/sundance.html
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xc8cb3000, fe:ab:fe:ab:fe:=
ab, IRQ 28.
eth2: No MII transceiver found!, ASIC status 7fabfe
Override speed=3D100, Full duplex
eth3: D-Link DFE-580TX 4 port Server Adapter at 0xc8cdd000, fe:ab:fe:ab:fe:=
ab, IRQ 29.
eth3: No MII transceiver found!, ASIC status 7fabfe
Override speed=3D100, Full duplex
eth4: D-Link DFE-580TX 4 port Server Adapter at 0xc8cdf000, fe:ab:fe:ab:fe:=
ab, IRQ 28.
eth4: No MII transceiver found!, ASIC status 7fabfe
Override speed=3D100, Full duplex
eth5: D-Link DFE-580TX 4 port Server Adapter at 0xc8ce1000, fe:ab:fe:ab:fe:=
ab, IRQ 29.
eth5: No MII transceiver found!, ASIC status 7fabfe
Override speed=3D100, Full duplex
[root@installed root]# ifconfig eth5 up 192.168.0.100
[root@installed root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:C0:9F:05:B5:75 =20
          inet addr:192.168.0.153  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1520 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1100 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:132864 (129.7 Kb)  TX bytes:246982 (241.1 Kb)
          Interrupt:20 Base address:0xd000=20

eth5      Link encap:Ethernet  HWaddr FE:AB:FE:AB:FE:AB =20
          inet addr:192.168.0.100  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:245760 errors:0 dropped:956 overruns:0 frame:0
          TX packets:261452 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1920 txqueuelen:100=20
          RX bytes:3221486008 (3072.2 Mb)  TX bytes:3221486924 (3072.2 Mb)
          Interrupt:29 Base address:0x10
[root@installed root]# lsmod
Module                  Size  Used by    Not tainted
sundance               11264   1=20
iptable_mangle          2080   0  (autoclean) (unused)
iptable_nat            15028   0  (autoclean) (unused)
iptable_filter          1696   0  (autoclean) (unused)
ip_conntrack           15532   1  (autoclean) [iptable_nat]
ip_tables              11616   5  [iptable_mangle iptable_nat iptable_filte=
r]
eepro100               17584   1=20
[root@installed root]# tail -n 20 /var/log/messages=20
Jun 13 15:39:40 installed sshd(pam_unix)[2275]: session opened for user roo=
t by (uid=3D0)
Jun 13 15:49:23 installed login(pam_unix)[1947]: session closed for user ro=
ot
Jun 13 15:53:29 installed sshd(pam_unix)[2275]: session closed for user roo=
t
Jun 13 15:55:55 installed sshd(pam_unix)[2373]: authentication failure; log=
name=3D uid=3D0 euid=3D0 tty=3DNODEVssh ruser=3D rhost=3Dmatt.dark.lan  use=
r=3Droot
Jun 13 15:56:40 installed sshd(pam_unix)[2373]: session opened for user roo=
t by (uid=3D0)
Jun 13 15:57:08 installed firewall: Shutting down Packet filtering:  succee=
ded
Jun 13 15:57:53 installed kernel: sundance.c:v1.01b 17-Jan-2002  Written by=
 Donald Becker
Jun 13 15:57:53 installed kernel:   http://www.scyld.com/network/sundance.h=
tml
Jun 13 15:57:53 installed kernel: eth2: D-Link DFE-580TX 4 port Server Adap=
ter at 0xc8cb3000, fe:ab:fe:ab:fe:ab, IRQ 28.
Jun 13 15:57:53 installed kernel: eth2: No MII transceiver found!, ASIC sta=
tus 7fabfe
Jun 13 15:57:53 installed kernel: Override speed=3D100, Full duplex
Jun 13 15:57:53 installed kernel: eth3: D-Link DFE-580TX 4 port Server Adap=
ter at 0xc8cdd000, fe:ab:fe:ab:fe:ab, IRQ 29.
Jun 13 15:57:53 installed kernel: eth3: No MII transceiver found!, ASIC sta=
tus 7fabfe
Jun 13 15:57:53 installed kernel: Override speed=3D100, Full duplex
Jun 13 15:57:53 installed kernel: eth4: D-Link DFE-580TX 4 port Server Adap=
ter at 0xc8cdf000, fe:ab:fe:ab:fe:ab, IRQ 28.
Jun 13 15:57:53 installed kernel: eth4: No MII transceiver found!, ASIC sta=
tus 7fabfe
Jun 13 15:57:53 installed kernel: Override speed=3D100, Full duplex
Jun 13 15:57:53 installed kernel: eth5: D-Link DFE-580TX 4 port Server Adap=
ter at 0xc8ce1000, fe:ab:fe:ab:fe:ab, IRQ 29.
Jun 13 15:57:53 installed kernel: eth5: No MII transceiver found!, ASIC sta=
tus 7fabfe
Jun 13 15:57:53 installed kernel: Override speed=3D100, Full duplex

--=-TfJP82B709eo+qfkn/Ua--

