Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUEEM1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUEEM1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUEEM1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:27:13 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:9166 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264632AbUEEM1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:27:10 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>
In-Reply-To: <200405052214.38855.ross@datscreative.com.au>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
	 <200405040111.01514.bzolnier@elka.pw.edu.pl>
	 <200405052214.38855.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/q+Z1YUQ+fHK8G5P2Tzp"
Message-Id: <1083760029.2797.33.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 14:27:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/q+Z1YUQ+fHK8G5P2Tzp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-05 at 14:14, Ross Dickson wrote:
> To my knowledge the only thing left to sort out for the normal kernel
> distro is what to do about the timer_ack issue in check_timer().
>=20
> We need it off for nforce2 to get nmi_watchdog=3D1 working with ioapic
> 8254 timer pin0  timer override patch routing. I vote to revisit Maciej's
> patch that was dropped by Linus after appearing in 2.6.3-mm3.=20
> For those with problems of clock skew with the timer into pin0 routing,=20
> that patch gave a virtual wire timer routing which worked well for those
> users.

Whats the real difference between nmi_watchdog?1 and =3D2? Since
nmi_watchdog=3D2 works here:

NMI:       9884
LOC:   80297310
ERR:          0
MIS:          0

Also, wouldn't it be better to not depend on bioses and bios versions
atm, ie hardcode pin0 since Allen Martin stated that it's hardwired on
pin0?

ie, just:
if(pin2 && nforce2_chip)
{
	printk("ALERT: Known defect in bios, mail your manufacturer. Using
pin0\n");
	<whateverisneededtousepin0>
}

Since this whole problem is pissing me off... It would be much better if
one had some kind of access to the information from nvidia so you can
just point at it, telling the mb-manuf. that they are morons and go fix
=3D). (Did i mention that i have had this problem for quite some time and
would have gone postal if it wasn't for Ross Dicksons fixes =3D))

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-/q+Z1YUQ+fHK8G5P2Tzp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmN2c7F3Euyc51N8RAjq6AKCiFA+FxxIc9tiuCuaB9qNS/uKDSgCeLI2W
N1iwQRJeVzX6eDHq+TSVcBQ=
=QP8r
-----END PGP SIGNATURE-----

--=-/q+Z1YUQ+fHK8G5P2Tzp--

