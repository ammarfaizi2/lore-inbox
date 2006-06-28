Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423301AbWF1MFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423301AbWF1MFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423302AbWF1MFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:05:43 -0400
Received: from admingilde.org ([213.95.32.146]:2537 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1423301AbWF1MFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:05:43 -0400
Date: Wed, 28 Jun 2006 14:05:36 +0200
From: Martin Waitz <tali@admingilde.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lukas Jelinek <info@kernel-api.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
Message-ID: <20060628120536.GF19868@admingilde.org>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Lukas Jelinek <info@kernel-api.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <44A1858B.9080102@kernel-api.org> <20060627132226.2401598e.rdunlap@xenotime.net> <44A1982C.1010008@kernel-api.org> <Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

when I once experimented with doxygen, I used the following script to
convert some kerneldoc comments to doxygen syntax:

#!/usr/bin/perl -wpi

use strict;

BEGIN { $::state =3D 0; }

if ($::state =3D=3D 0) {
	$::state =3D 1 if /\/\*\*/;
} elsif ($::state =3D=3D 1) {
	s/(\*\s+)(struct\s+|enum\s+)?\S+ - /$1/;
	s/$/\./ unless /\.$/;
	$::state =3D 2;
} elsif ($::state =3D=3D 2) {
	s/(\*\s+)\@(\w+):\s+(.*)/$1\\param $2 $3./;
	s/(\s+)[%&\@](\S+)/$1$2/g;
}
s/\.\.$/./;

$::state =3D 0 if /\*\//;


--=20
Martin Waitz

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEonCQj/Eaxd/oD7IRAqXdAJwOS0lskZ77dvotmvMRhSrP7R1IpgCdF8gP
Cz1UVi5jSQjQTks9501EgEA=
=t/an
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
