Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTIBEOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTIBEOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:14:41 -0400
Received: from [165.165.196.216] ([165.165.196.216]:50608 "EHLO nosferatu.lan")
	by vger.kernel.org with ESMTP id S263444AbTIBEOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:14:39 -0400
Subject: Re: 2.6.0-test4-mm3
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Valdis.Kletnieks@vt.edu
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, Andrew Morton <akpm@osdl.org>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <200309012352.h81NqXT9006422@turing-police.cc.vt.edu>
References: <3F4F22D3.9080104@freemail.hu>
	 <200308291300.h7TD049n022785@turing-police.cc.vt.edu>
	 <1062168946.19599.114.camel@workshop.saharacpt.lan>
	 <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu>
	 <1062447809.5275.7.camel@nosferatu.lan>
	 <200309012352.h81NqXT9006422@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O4KdLYBGlURi15AXbTwW"
Message-Id: <1062476044.5275.13.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 06:14:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O4KdLYBGlURi15AXbTwW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-02 at 01:52, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 01 Sep 2003 22:23:30 +0200, Martin Schlemmer said:
>=20
> > > +		if ! $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE
> )   ; t=3D
> > hen \
> > > +			echo "*** Depmod failed!!!"; \
> > > +			echo "*** You may need to install a current version of=20
> module-init-to=3D
> > ols"; \
> > > +			echo "*** See http://www.codemonkey.org.uk/post-hallowe
> en-2.5.txt"; \
> > > +			exit 1; \
> > > +	 	fi \
> > > +	fi
> > > =3D20
> > >  else # CONFIG_MODULES
> >=20
> > Hmm, this will only work with RH based systems (not using here).  I
> > think the best way is how Andrew did it to just warn if depmod fails.
> > You may agree to disagree if need be :)
>=20
> Umm.. how will this fail for *any* system that has a sane 'depmod' (sane =
as in
> "calls exit(0) if it worked"?  In this patch we never actually check the
> version - we just add code that "if depmod fails during 'make install_mod=
ules',
> it may be too old and give them a hint".
>=20

The problem I have with the patch you had here, is you changed:

DEPMOD         =3D /sbin/depmod

to:

DEPMOD         =3D /sbin/depmod.old

which is only the one from module-init-tools on a RH system ....


Cheers,

--=20

Martin Schlemmer




--=-O4KdLYBGlURi15AXbTwW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/VBkMqburzKaJYLYRAmgUAJ9Mx6DPE1bphtp14Chih9Abs8zbCwCeLaMV
ijAGMFke/7h8ahqujQ9kTDc=
=2RMX
-----END PGP SIGNATURE-----

--=-O4KdLYBGlURi15AXbTwW--

