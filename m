Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbTCZX0f>; Wed, 26 Mar 2003 18:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbTCZX0f>; Wed, 26 Mar 2003 18:26:35 -0500
Received: from cpt-dial-196-30-180-122.mweb.co.za ([196.30.180.122]:36992 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S262620AbTCZX0d>;
	Wed, 26 Mar 2003 18:26:33 -0500
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <20030326202904.GK24689@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <20030326202904.GK24689@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ptsNdk8Y8+awBkIfn1O0"
Organization: 
Message-Id: <1048721671.7569.46.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 27 Mar 2003 01:34:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ptsNdk8Y8+awBkIfn1O0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-26 at 22:29, Greg KH wrote:

> Some of the nasty casts should be fixed up though.  Stuff like:
>=20
> > +      ERROR7:
> > +	if (!is_isa)
> > +		i2c_detach_client(&
> > +				  (((struct w83781d_data
> > +				     *) (i2c_get_clientdata(new_client)))->
> > +				   lm75[1]));
> > +      ERROR6:
> > +	if (!is_isa)
> > +		i2c_detach_client(&
> > +				  (((struct w83781d_data
> > +				     *) (i2c_get_clientdata(new_client)))->
> > +				   lm75[0]));
> > +      ERROR5:
> > +	if (!is_isa)
> > +		kfree(((struct w83781d_data *) (i2c_get_clientdata(new_client)))->
> > +		      lm75);
>=20
> Is just obnoxious :)
>=20

Quick question .... With sysfs, is it not needed to call
i2c_detach_client ?   I am asking this as it seems from patches
that you remove all these calls ...


Regards,

--=20

Martin Schlemmer




--=-ptsNdk8Y8+awBkIfn1O0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+gjkHqburzKaJYLYRAsjqAKCbZLehBMLJ6laG+R1XYZ1wSTKG8QCfUE9q
ewZ4diZ4WO5k2gZGS1ITV6c=
=YEr3
-----END PGP SIGNATURE-----

--=-ptsNdk8Y8+awBkIfn1O0--

