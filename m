Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJIL0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJIL0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:26:36 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:24044 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262069AbTJIL0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:26:32 -0400
Date: Thu, 9 Oct 2003 13:24:58 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009112458.GE4699@actcom.co.il>
References: <20031009104218.GA1935@averell> <20031009104918.GB4699@actcom.co.il> <20031009112245.GA59762@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20031009112245.GA59762@colin2.muc.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2003 at 01:22:45PM +0200, Andi Kleen wrote:
> On Thu, Oct 09, 2003 at 12:49:18PM +0200, Muli Ben-Yehuda wrote:
> > On Thu, Oct 09, 2003 at 12:42:18PM +0200, Andi Kleen wrote:
> >=20
> > > I added a new argument force=3D=3D2 to get_user_pages that means to i=
gnore
> > > SIGBUS or unaccessible pages errors. MAY_* is still checked for like
> > > with the old force =3D=3D1, it just doesn't error out now for SIGBUS
> > > errors on handle_mm_fault.=20
> >=20
> > How about making it an enum or define for code readability? I'd much
> > rather see an IGNORE_BAD_PAGES or some such than a cryptic '2' in the
> > code. I can send a patch to that effect if you'd like?=20
>=20
> Doesn't look essential. You could submit it as a follow-up patch as soon
> as Linus merged this version, but I'm not sure it satisfies the current
> "no more cleanups" rule because it isn't a bugfix.

That's exactly the reason I wrote to you in the first place - if your
patch gets merged *with* the readability cleanups, it is irrelevant
whether the a follow up patch is acceptible or not. =20

I agree that improved readability is not "essential". Do you agree
that it's preferable? =20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hUWKKRs727/VN8sRAh8bAJ979gIP49zufEJHp7wSEFUjqGQ8wQCfc5Mt
Hk8Lrw/v4n8IfbQ5WoVfxng=
=eXW4
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
