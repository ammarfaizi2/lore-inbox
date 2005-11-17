Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVKQKd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVKQKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 05:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVKQKd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 05:33:59 -0500
Received: from mail.gondor.com ([212.117.64.182]:14601 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750733AbVKQKd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 05:33:59 -0500
Date: Thu, 17 Nov 2005 11:33:53 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051117103352.GA4832@knautsch.gondor.com>
References: <20051116181612.GA9231@knautsch.gondor.com> <437B912B.7090505@samwel.tk> <20051116214222.GB4935@knautsch.gondor.com> <437C4C8B.4030502@samwel.tk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <437C4C8B.4030502@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2005 at 10:25:31AM +0100, Bart Samwel wrote:
> Youch. I assumed this was all the same fs! It is the same HD though?

Yes, same HD, same notebook, no hardware changes.

> >But this should definitely have been detected by an fsck, right?
>=20
> Yes. And you've had this problem before, even. Googling for "e2fsck=20
> block bitmap differences" shows me this as the third entry. :)
>=20
> http://lkml.org/lkml/2003/8/3/166
>=20
> If you didn't get those messages, then this is not the problem, apparentl=
y.

Ok - this was on a different computer, so it's not really related, but
the important point is that fsck didn't report any errors so the
write into the middle of another file was not caused by a bad
filesystem.

> There is a known problem with laptop mode where, often during=20
> spindown/spinup, the kernel emits DMA timeout errors.
>=20
> http://lkml.org/lkml/2005/8/21/48
>=20
> According to Andrea Gelmini (the original reporter of this problem) this=
=20
> can lead to system freezes on some kernels, and corruption on others.=20
> Are you seeing these errors somewhere in your logs?

No ide errors at all in the kernel logs, which cover more than one
month.

> What's your hardware? A Thinkpad perhaps?

ASUS M2400N with a SAMSUNG MP0804H 80GB hard drive (this is not
the original hard drive - the notbook was delivered with a 60GB
drive). Centrino chipset, 1.6GHz Pentium M. Hard drive running in udma5
mode. 512MB RAM, Intel Pro Wireless 2100 replaced with an Intel Pro
Wireless 2200 wireless lan card, and a CardMan 4000 card reader in the
pccard slot - not that I think these have any influence on the hard drive,
but this is the complete hardware description.

Jan


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ3xcioFL8fYptN/eAQJy0wP/fm1t/j3ss5fatlPcvXASPihRjkPSSpNh
9mJl54ZhB5INGuCNhwePMxOG8uwCaZsq9/2/oBu3kDo1sWfYOqFTo1Yc0VX31SBg
K3bpdfZxs4RgJX+P6cWNwWF4c34SolzoBDFcRLeWEVrji8bTjCH1r//kOI0Lwi25
kGDmUfIGUMI=
=FFkM
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
