Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319246AbSHNRCI>; Wed, 14 Aug 2002 13:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319248AbSHNRCI>; Wed, 14 Aug 2002 13:02:08 -0400
Received: from host213-121-104-171.in-addr.btopenworld.com ([213.121.104.171]:32130
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S319246AbSHNRCH>; Wed, 14 Aug 2002 13:02:07 -0400
Subject: Re: sundance.o only two ports working
From: Matthew Hall <matt@ecsc.co.uk>
To: Holger.Woehle@arcor.net
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41256C15.00613A82.00@ffm-hq-gtw01.Arcor.net>
References: <41256C15.00613A82.00@ffm-hq-gtw01.Arcor.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-28rOb2MtWr/o/Mui5sOB"
Organization: ECSC Ltd.
Message-Id: <1029344756.18578.6.camel@smelly.dark.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 14 Aug 2002 18:05:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-28rOb2MtWr/o/Mui5sOB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-08-14 at 18:37, Holger.Woehle@arcor.net wrote:
> Hello,
> i have a strange problem with two of my machines:
> They are identical P4 systems with Intel Chipset with two epro100 adapter=
s
> onboard and a d-link dfe-580TX quad ethernet card.
> I am using Kernel 2.4.18 and sundance.o v1.07a 7/9/2002.

I experienced problems with the sundance on the dfe580tx a while back=20
too, and I made a patch for 2.4.18 a while back (it on my site (in the
sig)), donald becker then released v1.08 on his site a while back
(www.scyld.com) which fixed the problem (my patch now includes this).=20
Please apply this patch and try again, (or try db's original version).
Fyi, the dfe580tx doesn't support mii-diag afaik. The best error check
was to check the output of ifconfig and see whether the RX bytes
equalled the TX bytes (unless running lo, these shouldn't be the same,
and they were the first time I had a problem).
Hope this helps,
Matt

> The problem is, that i only can use the two first ports of the d-link car=
d.
> I can set up all four with no problems according to mii-diag and alta-dia=
g.
> Each port recognises link up/down and negotiates to the right speed and
> flowcontrol.
> But when i send traffic over the ports 4&5, at first nothing happens and =
of
> course i can't see any interrupts in /proc/interrupts eth4 eth5 and after=
 a
> while i get
> the console message:
> eth4: Transmit timed out, status c0, resetting...
>=20
> Having a look at alta-diag i noticed, that the column
> " Interrupt status is..." differs between Index#1 / #2 and Index#3 / #4
> Index#1 and #2 tells: Interrupt status is 0000: No interrupts pending.
> Index#3 and #4 tells: Interrupt status is 0101: Interrupt summary Link st=
atus
> changed
>=20
> and after genrating some traffic that line changes at Index#3 & #4 to:
>=20
> Interrupt status is 0301: Interrupt summary Link status changed Tx DMA do=
ne.
>=20
> The beehavier is identical on both machines.
>=20
> For better analysing i can send a file including cat /proc/pic, pci-confi=
g,
> alta-diag -e and alta-diag -m bevor and after sending some pings.
> This file is a some more pages long so i don't know if it is ok to send i=
t to
> the mailing list.
>=20
> with regards
> Holger
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Matthew Hall -- matt@ecsc.co.uk -- http://people.ecsc.co.uk/~matt/
Sig: Printed on 100% recycled electrons.

--=-28rOb2MtWr/o/Mui5sOB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9Wo30w5xT5S6r89URAth+AJ4llhm5QM5c24x8ic+cA/d6Dz+HyACfZ4lW
5Us5z/QVK097AMxwXX66u9c=
=hAVt
-----END PGP SIGNATURE-----

--=-28rOb2MtWr/o/Mui5sOB--

