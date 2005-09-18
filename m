Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVIRW3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVIRW3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVIRW3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:29:54 -0400
Received: from h80ad24e0.async.vt.edu ([128.173.36.224]:11908 "EHLO
	h80ad24e0.async.vt.edu") by vger.kernel.org with ESMTP
	id S932236AbVIRW3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:29:54 -0400
Message-Id: <200509182229.j8IMTUot004728@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: 7eggert@gmx.de
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Martin =?ISO-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts 
In-Reply-To: Your message of "Sun, 18 Sep 2005 21:23:42 +0200."
             <E1EH4lL-0001Iz-Lx@be1.lrz> 
From: Valdis.Kletnieks@vt.edu
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
            <E1EH4lL-0001Iz-Lx@be1.lrz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127082569_2682P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Sep 2005 18:29:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127082569_2682P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Sep 2005 21:23:42 +0200, Bodo Eggert said:
> Bernd Petrovitsch <bernd=40firmix.at> wrote:
> > Apparently I have to repeat: If you do =60cat a.txt b.txt >c.txt=60 w=
here
> > a.txt and b.txt have this marker, then c.txt have the marker of b.txt=

> > somewhere in the middle. Does this make sense in anyway?
> > How do I get rid of the marker in the middle transparently?
>=20
> The unicode standard defines how to handle them.

For the benefit of those of us who are interested in the problem, but are=
n't
in the mood to wade through a long standard looking for the answer to a
specific question, can you elaborate?

It isn't as obvious as all that, because of all the nasty corner cases...=


> > It is different even if a pure ASCII file is marked as UTF-8.
>=20
> No pure ASCII file will be marked, since a marked file will be no
> ASCII file.

Given a file =22a.txt=22 that's pure ASCII, and a file =22b.txt=22 that h=
as the BOM
marker on it, what happens when you do =22cat a.txt b.txt > c.txt=22?

'cat' doesn't know, and has no way of knowing, that c.txt needs a BOM at =
the
*front* of the file until it's already written past the point in c.txt wh=
ere
the BOM has to go.

What does the Unicode standard say to do in this case?

--==_Exmh_1127082569_2682P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDLepJcC3lWbTT17ARAt1+AKCYZ67+er/I+W11Lv3g1Oq39YtL3wCfTeqd
sQb60ncl4NYtPO8zcL5gcjw=
=2w7n
-----END PGP SIGNATURE-----

--==_Exmh_1127082569_2682P--
