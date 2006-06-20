Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFTM4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFTM4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFTM4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:56:15 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.8]:18008 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750716AbWFTM4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:56:14 -0400
Message-ID: <4497F067.3090008@poczta.fm>
Date: Tue, 20 Jun 2006 14:56:07 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?B?xYF1a2FzeiBTdGVsbWFjaA==?= <stlman@poczta.fm>
Subject: ipv6 source address selection in addrconf.c (2.6.17)
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8BE4A29832CA4711BE22DE57"
X-EMID: 78da138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8BE4A29832CA4711BE22DE57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings

net/ipv6/addrconf.c:971 is
/* Rule 2: Prefer appropriate scope */
if (hiscore.rule < 2) {
        hiscore.scope =3D __ipv6_addr_src_scope(hiscore.addr_type);
        hiscore.rule++;
}

Do you think it makes any sens when hiscore.addr_type hasn't been assigne=
d any
value (or I can't see it) before? There are some more references to
hiscore.addr_type below but no assignment.

I am trying to figure out why when trying to connect to

2001:200:0:8002:203:47ff:fea5:3085 (www.kame.net)

with two global addresses assigned to the ethernet card

fd24:6f44:46bd:face::254
2002:531f:d667:face::254

rule 8 does not work and the first address is chosen.


Please CC answers.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig8BE4A29832CA4711BE22DE57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEl/BuNdzY8sm9K9wRAtQ1AKCeFS1YAvLqlAngbnBO4Lo+nKgHLQCfcxZV
Gy1CtpRdE1mPOVbtERDhHqQ=
=S7lL
-----END PGP SIGNATURE-----

--------------enig8BE4A29832CA4711BE22DE57--
