Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUBLQvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUBLQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:51:00 -0500
Received: from smtp1.clb.oleane.net ([213.56.31.17]:16022 "EHLO
	smtp1.clb.oleane.net") by vger.kernel.org with ESMTP
	id S266514AbUBLQu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:50:58 -0500
Subject: Re: JFS default behavior (was: UTF-8 in file systems?
	xfs/extfs/etc.)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yR/D1NOUeZ5dWdqC2CIm"
Organization: Adresse personnelle
Message-Id: <1076604650.31270.20.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Thu, 12 Feb 2004 17:50:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yR/D1NOUeZ5dWdqC2CIm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Not specifying the file name encoding (either per fs type, per partition
or per filename) is plain dangerous. It is not a userspace problem -
flash/hotplug disks move, users on the same system can have different
locales and try to share files, a user can change his locale to another
one (hear the screams of RH users forcibly converted to utf8 which had
to fix years of storage which filenames were suddenly borked)=20

See also the sun zip encoding bug - everyone uses zip files in Java, zip
authors thought a filename is "just a bunch of bytes" and didn't put
filename encoding info in the zip format, and now java zip handling goes
boom since numerous encodings are unicode-incompatible. It's slowly
getting its way to the top-25 most reported java bugs.

(of course as usual US users/coders  are not hit and do not feel
concerned)

The only reason we got by with it so far is linux localisation was poor,
and systems didn't scale high enough to permit high number of users per
system (reducing locale collision risks)

The only reason we might get by in the future is everyone will be using
utf8.

But that's not a reason not to fix the core problem - I don't want to
spent hours fixing filenames next time someone comes up with a new
encoding. Please put valid encoding info somewhere or declare filenames
are utf-8 od utf-16 only - changing user locale should not corrupt old
data.

Cheers,

--=20
Nicolas Mailhot

--=-yR/D1NOUeZ5dWdqC2CIm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAK67oI2bVKDsp8g0RAk77AKDyxfaKuF01I/AueX4pyD4bDwuaxwCcCkoB
7Btw4qS3MyPMRvxjmFrwMzs=
=xkKo
-----END PGP SIGNATURE-----

--=-yR/D1NOUeZ5dWdqC2CIm--

