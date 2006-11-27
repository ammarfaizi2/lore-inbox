Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758013AbWK0WrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbWK0WrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758016AbWK0WrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:47:20 -0500
Received: from smtp10.poczta.interia.pl ([80.48.65.10]:10369 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1758013AbWK0WrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:47:19 -0500
Message-ID: <456B6B02.9060105@poczta.fm>
Date: Mon, 27 Nov 2006 23:47:30 +0100
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: autoconf.h and auto.conf missing
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B8E5A6D00C1286557D90E49"
X-EMID: 639a3138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B8E5A6D00C1286557D90E49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings.

It seems that someone has broken *conf programs in 2.6.18 because
only "make silentoldconfig" recreates autoconf.h and auto.conf
properly after configuration (.config) has changed.

I do everything as I always have done.
1. create an empty dir and put my current .config there
2. make O=3Ddir oldconfig
3. compile, everything seems to be OK here
4. do some changes to .config and make oldconfig once again
BZZZZZT
5. auto.conf and autoconf.h don't change along with .config and when
 I build the kernel once again new settings don't take effect.

I discovered I have to make silentoldconfig to regenerate autoconf
files. However, this *seems* to force rebuilding of all the objects
instead of, what it has always done, only those that depend on
altered configurations.

Has anyone else seen something like this? Is it a bug or a feature?

Best regards,

Please CC, I am not a subscriber.
--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP


--------------enig8B8E5A6D00C1286557D90E49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFa2sHNdzY8sm9K9wRAg8aAJ993BRfKRqV4leFPhFCYy/sQi8DDgCgm0y1
n4/sjOaicEw8mjZKy9zwcDk=
=bduG
-----END PGP SIGNATURE-----

--------------enig8B8E5A6D00C1286557D90E49--
