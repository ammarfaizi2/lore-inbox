Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbTGTWdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268731AbTGTWdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:33:45 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:1990 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S268685AbTGTWdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:33:43 -0400
Subject: Re: devfsd/2.6.0-test1
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: KML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200307202117.32753.arvidjaar@mail.ru>
References: <200307202117.32753.arvidjaar@mail.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2Mmg6TMB1XOsOh5dexoi"
Message-Id: <1058741336.19817.147.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 00:48:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Mmg6TMB1XOsOh5dexoi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-20 at 19:17, Andrey Borzenkov wrote:

> > Well, it implements probeall in another fashion.  Also, you might
> > try /sbin/generate-modprobe.conf to convert a modules.conf to
> > modprobe.conf syntax.
>=20
> modprobe.conf syntax is easy to implement but unfortunately PITA to use.=20
> Exactly probe and probeall have been very helful in tracking module=20
> dependencies. Now you have arbitrary shell line that is near to impossibl=
e to=20
> parse in general.
>=20

True.

> I added half-hearted support to mkinitrd and initscripts for Mandrake but=
 it=20
> will never be complete given the current situation.
>=20
> Also I fixed devfsd to correctly use modprobe.devfs or modules.devfs depe=
nding=20
> on which kernel it runs on; patch has been sent both to lkml and devfs li=
st=20
> and is included in current Mandrake devfsd.
>=20

As I have it in Gentoo, it is done modprobe side, but only because its
less patches (as Rusty already added the changes to his hack, plus the
modprobe.devfs I sent him).

> actually adding probe and probeall is trivial enough, I did not want to b=
ase=20
> Mandrake packages on that to avoid incompatibility.
>=20

Have you checked with Rusty yet if he will accept probe/probeall patches
for module-init-tools ?  I (IMHO) do not see why it should not be
possible to add if its done cleanly, and do not break anything else.

> > Also, read the threads on the list about udev/hotplug - apparently
> > devfsd is going out ...
>=20
> as long as you have memory-based /dev you need devfsd even if it is calle=
d=20
> differently.
>

I have not looked at it myself, but as far as I have it, you do not
mount /dev, and just need udev/hotplug/libsysfs (not sure on libsysfs).
Currently udev still call mknod, but I think Greg said he will fix that
in the future.


Regards,

--=20

Martin Schlemmer




--=-2Mmg6TMB1XOsOh5dexoi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GxxYqburzKaJYLYRAnFOAJ9AAIFg7KQQPaNtGkZJqi5tecShYgCfblhW
Bl3G/pNFpjMQyzo+miYeiD4=
=YdjW
-----END PGP SIGNATURE-----

--=-2Mmg6TMB1XOsOh5dexoi--

