Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTI3Hly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTI3Hly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:41:54 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:716 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261151AbTI3Hlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:41:50 -0400
Date: Tue, 30 Sep 2003 10:41:38 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Miles Bader <miles@gnu.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030930074138.GG729@actcom.co.il>
References: <20030929090629.GF29313@actcom.co.il> <20030929153437.GB21798@mail.jlokier.co.uk> <20030930071005.GY729@actcom.co.il> <buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1YtYzP3stTOlsn9I"
Content-Disposition: inline
In-Reply-To: <buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1YtYzP3stTOlsn9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2003 at 04:34:31PM +0900, Miles Bader wrote:
> Muli Ben-Yehuda <mulix@mulix.org> writes:
> > Ah, much nicer, thank you. I'll submit it, but first, what do you
> > think about this version? it keeps the optimization and enforces the
> > "bit1 and bit2 must be single bits only" rule.
>=20
> On my arch it results in huge bloated code, including mul and div
> insns!

Eeek!=20

> [I've no idea what's up with that, I don't even think the generated code
> makes sense, but it seems like the presence of inline function is
> confusing something.]

Ok, that's a pretty convincing argument for scraping that
version. I'll rewrite it to evaluate the arguments at compile time if
they're constants, which they are, in our case. Unless someone else
beats me to it, of course ;-)=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--1YtYzP3stTOlsn9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eTOyKRs727/VN8sRAmyPAKCbtF4sa12rk+XhfS0LuB5MSMMUAQCghsqd
GtnIF7xx57ZBkCrL2kxe5IU=
=m9Pp
-----END PGP SIGNATURE-----

--1YtYzP3stTOlsn9I--
