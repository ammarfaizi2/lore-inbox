Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUAWHSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUAWHSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:18:31 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:56194 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265376AbUAWHSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:18:11 -0500
Date: Fri, 23 Jan 2004 20:20:59 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: A question about terminology.
In-reply-to: <20040122222720.19e905f9.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074842459.12773.272.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-gcNZX2PhWWKUj0swDp3X";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074799304.12771.93.camel@laptop-linux>
 <20040122222720.19e905f9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gcNZX2PhWWKUj0swDp3X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Thanks for the pointer.

I was aware of swap extents, but didn't look at the supporting
infrastructure because I originally wrote the code for 2.4, before I
looked at porting it to 2.6.

Having said that, I've looked at them now, but think that they probably
wouldn't help me.

This is partly because I've ended up using extents to store all the
meta-data: swap addresses, which blocks on the swap devices are used,
and which pages are used for what. (Sorry, only mentioning blocks in the
previous message did mislead you).

More importantly that that, though, I'm using whole pages for storing
the extents, and store the pages in the header of the image (after
making them relocatable). They replace the 'pagedirs' in Patrick's and
Pavel's implementations.

Regards,

Nigel

On Fri, 2004-01-23 at 19:27, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> >
> > Hi again.
> >=20
> > When I began work on swapfile support, I looked for an efficient method
> > to store all the information on which blocks were used. The process led
> > me to develop something I called ranges, which Pavel later looked at an=
d
> > said something like 'Oh. Extents.'
> >=20
> > Throughout the code, I still call them ranges (I have, for example
> > struct range and struct rangechain). In preparation for merging, should
> > I go through an rename ranges to extents, or will they be okay as it is=
?
>=20
> Are you aware of the current `struct swap_extent' and its supporting
> infrastructure?
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-gcNZX2PhWWKUj0swDp3X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEMtaVfpQGcyBBWkRApRNAJ42LHLWvWRsHTqudXDGSmPXnw9bwgCfS0Bo
ABgwgMxXw80T+Yukgt7DLU4=
=x1El
-----END PGP SIGNATURE-----

--=-gcNZX2PhWWKUj0swDp3X--

