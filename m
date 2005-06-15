Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVFOOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFOOwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFOOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:52:31 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:56382 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261487AbVFOOwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:52:15 -0400
Message-ID: <42B04090.7050703@poczta.fm>
Date: Wed, 15 Jun 2005 16:52:00 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: mru@inprovide.com
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>	<200506150454.11532.pmcfarland@downeast.net>	<42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>
In-Reply-To: <yw1xd5qo2bzd.fsf@ford.inprovide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig440315F6C92317B174B6019E"
X-EMID: ce0d138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig440315F6C92317B174B6019E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

M=C3=A5ns Rullg=C3=A5rd napisa=C5=82(a):

>>IMHO for *every* filesystem there need to be an *option* to:
>>
>>1. store filenames in utf-8 (that is quite possible today) or any other=

>>unicode form.
>=20
> export LC_CTYPE=3Dwhatever.utf-8

Translate and store them in utf-8 at kernel level same as VFAT mounted
with iocharset option.

>>2. convert them to/from a desired iocharset. I prefere using ISO-8859-2=

>>on my system for not every tool support utf-8 today (hopefuly yet).
>=20
> man iconv

There are far more programmes than only iconv. First of all readline
library is kind of broken because it counts (or at least it did a year
ago) bytes instead of characters. I won't use UTF-8 nor force anybody
else to do so until readline will handle it properly.


>>Of course if a user whishes to store filenames in some other encoding
>>she should be *able* to do so (that is why i like linux).
>=20
> That's the current situation.

And it is good in a way, however, i think kernel level translation
should be also possible. Either done by a code in each filsystem or by
some layer above it.

>>Generally. IMHO VFAT is a good example how character encoding needs
>>to be handeled.
>=20
> IMHO, VFAT is only a good example of bad design.

It depend's on what it is used for. It is very good fs for removable
media. None of linux native filesystems is good for this because of
different uids on different machines. Since VFAT uses unicode it is
possible to see the filenames properly on systems using different
codepages for the same language (1:1 is possible).

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig440315F6C92317B174B6019E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCsECVNdzY8sm9K9wRAsseAJ4/CcoD/WZAZVxJ4PlXVO8dIkKU8gCfY4YT
lMQgLYZxiVvKDq5KNYd7IPs=
=/qki
-----END PGP SIGNATURE-----

--------------enig440315F6C92317B174B6019E--
