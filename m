Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUDOFMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 01:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUDOFMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 01:12:23 -0400
Received: from [210.8.79.18] ([210.8.79.18]:23731 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S263745AbUDOFMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 01:12:20 -0400
Date: Thu, 15 Apr 2004 15:12:15 +1000
To: Dave Jones <davej@redhat.com>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040415051215.GC1472@himi.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com> <20040414202554.GA12020@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20040414202554.GA12020@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2004 at 10:25:54PM +0200, Sam Ravnborg wrote:
> On Wed, Apr 14, 2004 at 06:00:10PM +0100, Dave Jones wrote:
> >=20
> > Make this the third.  I just saw it happen here too.
> > 'make bzImage ; make modules ; make modules_install' fails in the above=
 way.
> > Doing a 'make' seems to work.
>=20
> I think I tracked it down now.
> During 'make bzImage' the directory .tmp_versions was deleted and created.
> This is only supposed to happen when building modules.
>=20
> This does not match your failure report 100%.
> I assume what you did was something like:
>=20
> make bzImage
> make modules
> make install		<=3D This would trigger the above case
> make modules_install
>=20
> Or maybe you inverted the two:
> make modules
> make bzImage
>=20
> Anyway here is the fix.
> Please let me know if you still se problems.
>=20
This patch fixed the problem for me - 'make install modules_install'
now does what it's supposed to do.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfhmvQPlfmRRKmRwRAg9KAKCWftr4XRzQNmQ+4BY8qAj2qsB/uwCg0urs
/3s3eAbvLJX1OT+c/6wYQDQ=
=EYEN
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
