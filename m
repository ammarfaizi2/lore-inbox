Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUAYTbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUAYTbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:31:00 -0500
Received: from diale017.ppp.lrz-muenchen.de ([129.187.28.17]:34749 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S265225AbUAYTa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:30:56 -0500
Subject: rtl8169 problem and 2.4.23
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rOQzZHKZ5sJxy6aYhxlI"
Message-Id: <1075059124.13750.38.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 20:32:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rOQzZHKZ5sJxy6aYhxlI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I just discovered that the interface doesn't account outgoing bytes, so
although I'm shoveling GBs over NFS to another machine, ifconfig and
/proc/net/dev both state that the card hasn't transmitted anything:

eth2      Link encap:Ethernet  HWaddr 00:08:01:a3:64:97,
          inet addr:192.168.11.2  Bcast:192.168.11.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:297638 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1334930 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:45831863 (43.7 MiB)  TX bytes:0 (0.0 b)
          Interrupt:4 Base address:0xff00

Furthermore the performance is really scary slow: I'm not even getting=20
100Base-T speeds from an Athlon XP to my G4 PowerBook under MacOS X over
a PtP connection.

What is interesting though is that the machine produces interrupt errors
which only occur when the card is active:

           CPU0
  0:  110545371          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      35665          XT-PIC  ohci1394
  4:    4314949          XT-PIC  eth2
  8:          4          XT-PIC  rtc
 12:   87125964          XT-PIC  eth0
 14:    6035586          XT-PIC  ide0
 15:    6986897          XT-PIC  ide1
NMI:          0
LOC:  110544807
ERR:      10905
MIS:          0

And this is this output of the driver at initialisation:

r8169 Gigabit Ethernet driver 1.2 loaded
PCI: Found IRQ 4 for device 00:0d.0
r8169: PCI device 00:0d.0: unknown chip version, assuming RTL-8169
r8169: PCI device 00:0d.0: TxConfig =3D 0x800000
eth2: Identified chip type is 'RTL-8169'.
eth2: RealTek RTL8169 Gigabit Ethernet at 0xe093ff00, 00:08:01:a3:64:97, IR=
Q 4
eth2: Auto-negotiation Enabled.
eth2: 1000Mbps Full-duplex operation.

--=20
Servus,
       Daniel

--=-rOQzZHKZ5sJxy6aYhxlI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQBQZtDBkNMiD99JrAQL3VQf/bOTSz8pxGxULvVpodEb6j0oXco11Bxcg
9N3VYagNbGIuDJE5cxPnme7tTCQ5zImO7CJR7KsLNJQuK4Q4Dn/u8TcBZY75OnJb
XDsbqEWqgOtJ1z2LYltuByIYbZaLKUjTfPDqzK5a3dPy8L2deP3R04dIP6jZZ4QO
dTiv329GGVWCYX9dvV+yQqVEwfOzzPyx1PYgbFGP7tcyuUEh/VpnJE+bEwzDdScq
Lr2V4p2ff8g7BQoFLRJoy9UyL6AYjkGXX4UCvrpjjMyQyXesMjKiRWkMbwmaEkKT
8I3TcYI/uLCgo/mf2q5DCaN0T8jBoEOlH2rpaygSO84DHCjuZvT4Ww==
=4AVz
-----END PGP SIGNATURE-----

--=-rOQzZHKZ5sJxy6aYhxlI--

