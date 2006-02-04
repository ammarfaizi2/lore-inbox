Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWBDJb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBDJb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBDJb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:31:26 -0500
Received: from sipsolutions.net ([66.160.135.76]:16650 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932166AbWBDJb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:31:26 -0500
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       bcollins@debian.org, scjody@modernduck.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.ne,
       sam@ravnborg.org
In-Reply-To: <43E46F1F.9070503@s5r6.in-berlin.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
	 <20060203212507.GR4408@stusta.de>  <43E46F1F.9070503@s5r6.in-berlin.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y5RnL7ahE45LC1Nf7jhK"
Date: Sat, 04 Feb 2006 10:31:03 +0100
Message-Id: <1139045463.3602.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y5RnL7ahE45LC1Nf7jhK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-02-04 at 10:08 +0100, Stefan Richter wrote:
> Adrian Bunk wrote:
> > ...
> >   OUI2C   drivers/ieee1394/oui.c
> > /bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
> > make[3]: *** [drivers/ieee1394/oui.c] Error 127
> >=20
> > <--  snip  -->
> >=20
> >=20
> > The change that broke it is:
> >=20
> >=20
> >  quiet_cmd_oui2c =3D OUI2C   $@
> > -      cmd_oui2c =3D $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > =
$@
> > +      cmd_oui2c =3D $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
>=20
> How can this be reproduced? IOW which way of building the kernel is broke=
n?

Looks like my mistake. I was pretty sure I tested the normal in-kernel
build way, sorry.

I did the change in order to build out of tree (with an absolute path as
a SUBDIRS value).

johannes

--=-y5RnL7ahE45LC1Nf7jhK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ+R0VKVg1VMiehFYAQLg1hAAq57V6y8H260SiV4/2qQ5Af1Xi8QV2TN4
b705/ivST8fvMpf+uoH5epPHObEjpIeFEyWspbY0UVZx9a0Dm9YmIK8JU37Ip2TM
Puxu+OAnu7zwY43YZGs5r4w0Be7riJiu1p356akJENeRXriJWus7aPGmdZXe2W1f
31kdNo7RKmoNZIMEoX4SWd0LWhMxordRd+rB0p7FKTDyYWh+P9VKjbmRulsabBZ6
W3tuzLrcKd8w2hu0b1PWukloFKszb9WD9yHIx0UMrjnoLGzEFu7rXfpSmFwnP09D
STpJHwiAtHKY9YIJeGTu7/VtOqnfyWdp5LdYpMW76T+lyZ7ACSNgNVfJgcoT6fp4
9wFy6OpVZpnfc4oXAn7YcciauqCg18FwkGzicbAJ7r14uLuZKzSSd4nWvUI9LzyS
eWBALkvIley45TrQYpxZU+qsmrKm18w84cn3fGwThtKlnQbYJ2YVtis+Q3qk9pas
Ukxcp6yNH7LNWAUim75l1xBbZv1Ku7X8QreXjrueYVAt4DrsrTp2ygdSdgbKxLR8
Q6IvVACUAnVwQzI6gSKhyJfWBK62vTRlc3unKMd+9rNmnR4WrfNF1OXzlYqovgJM
X615iynNWibF1pIc+XJOrrGc1joukFhzarQ0mDK7YLFoTT/DClfgiyz+kQ1lK0A5
S0eEY9j4UJk=
=goho
-----END PGP SIGNATURE-----

--=-y5RnL7ahE45LC1Nf7jhK--

