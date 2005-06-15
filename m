Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVFOXei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVFOXei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVFOXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:34:38 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:65127 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261657AbVFOXeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:34:31 -0400
Message-ID: <42B0BAF5.106@poczta.fm>
Date: Thu, 16 Jun 2005 01:34:13 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: mru@inprovide.com, Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net> <42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com> <42B04090.7050703@poczta.fm> <20050615212825.GS23621@csclub.uwaterloo.ca>
In-Reply-To: <20050615212825.GS23621@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B44C42C5EF94A8FBDD1445D"
X-EMID: 14fa0138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B44C42C5EF94A8FBDD1445D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Lennart Sorensen napisa=C5=82(a):

>>And it is good in a way, however, i think kernel level translation
>>should be also possible. Either done by a code in each filsystem or by
>>some layer above it.
>=20
> What do you do if the underlying filesystem can not store some unicode
> characters that are allowed on others?

That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
software that need not to be aware of unicodeness of the text it manages
to handle it without any hickups *and* to store in the text information
about multibyte characters.What characters exactly you do mean? NULL?
There is no NULL byte in any UTF-8 string except the one which
terminates it.

> VFAT uses unicode?  I thought it used the same codepage silyness as FAT=

> did, since after all ti was just supposed to be a long filename
> extension to FAT.  Do they use unicode in the long filenames only?

Yes, it uses unicode. And dos codepages in short ones. To prove this
take a vfat floppy and mount it. touch(1) a file on it that has some
non latin1 characters. Unmount the floppy then do dd if=3D/dev/fd0
of=3D/tmp/floppy bs=3D1024 count=3D512. While it's done take some hex
editor/viewer and seek the latin1-complaint part of the filename
in the floppy file (search for uppercase string). Righ above the short
filename you'll find multibyte long one.

> I think UDF is a better filesystem for many types of media since it is
> able to me more gently to the sectors storing the meta data than VFAT
> ever will be.

I've tried cd packet writing with UDF and it gives insane overhead of
about 20%. What metadata you'd like to store for example on your
flashdrive or a floppy disk?

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig8B44C42C5EF94A8FBDD1445D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCsLr5NdzY8sm9K9wRAv2yAJ9yycLSI/KI+g9hY9VPSpHYaDb9MACfeAsR
YiLD3yO/uuliJF+Dd+/lUSg=
=VdHb
-----END PGP SIGNATURE-----

--------------enig8B44C42C5EF94A8FBDD1445D--
