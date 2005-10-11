Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVJKMPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVJKMPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJKMPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:15:48 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:57791 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S932078AbVJKMPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:15:47 -0400
Date: Tue, 11 Oct 2005 14:15:25 +0200
From: Jan Hudec <bulb@ucw.cz>
To: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/16] GFS: core fs
Message-ID: <20051011121525.GC16249@djinn>
References: <20051010171002.GD22483@redhat.com> <20051010213928.GB2475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20051010213928.GB2475@elf.ucw.cz>
User-Agent: Mutt/1.5.11
X-Spam-Score: -4.5 (----)
X-Spam-Report: Spam detection software, running on "shpek.cybernet.src", has inspected this
	incomming email and gave it -4.5 points (spam is above 5.0)
	Content analysis details:
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.9 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2005 at 23:39:28 +0200, Pavel Machek wrote:
> Hi!
>=20
> > Signed-off-by: Ken Preslan <ken@preslan.org>
> > Signed-off-by: David Teigland <teigland@redhat.com>
>=20
> > +	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
>=20
> > +		for (head =3D &ai->ai_ail1_list, tmp =3D head->prev, prev =3D tmp->p=
rev;
> > +		     tmp !=3D head;
> > +		     tmp =3D prev, prev =3D tmp->prev) {
>=20
>=20
> > +	for (head =3D &ai->ai_ail1_list, tmp =3D head->prev, prev =3D tmp->pr=
ev;
> > +	     tmp !=3D head;
> > +	     tmp =3D prev, prev =3D tmp->prev) {
>=20
>=20
> Can you get less creative in the for loops? [There are more examples
> at other patches, for (i=3Dsomething; i--; ) was "nicest" example].

The later two are good examples of where list_for_each_safe is
appropriate.

--
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDS6zdRel1vVwhjGURApTDAJ4hsxRGFVNqQOOcW6Ix3fsL2f+VVwCg1+9K
qjRqoXM/ufayzpSrU9CNP3c=
=9NSE
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
