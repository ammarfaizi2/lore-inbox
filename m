Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVGMUMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVGMUMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVGMUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:10:26 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:33381 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262741AbVGMUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:10:20 -0400
Subject: Re: [PATCH] Allow cscope to index multiple architectures
From: Ian Campbell <ijc@hellion.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
In-Reply-To: <20050713214337.GC16374@mars.ravnborg.org>
References: <1119522355.2995.23.camel@icampbell-debian>
	 <20050713214337.GC16374@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z/KTyHJ/nqPt2dPqFJNc"
Date: Wed, 13 Jul 2005 21:10:16 +0100
Message-Id: <1121285416.5337.3.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z/KTyHJ/nqPt2dPqFJNc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-07-13 at 21:43 +0000, Sam Ravnborg wrote:
> On Thu, Jun 23, 2005 at 11:25:54AM +0100, Ian Campbell wrote:
> > Hi,
> >=20
> > I have a single source tree which I cross compile for a couple of
> > different architectures using ARHC=3Dfoo O=3Dblah etc.
> >=20
> > The existing cscope target is very handy but only indexes the current
> > $(ARCH), which is a pain since inevitably I'm interested in the other
> > one at any given time ;-). This patch allows me to pass a list of
> > architectures for cscope to index. e.g.
> > 	make ALLSOURCE_ARCHS=3D"i386 arm" cscope
> >=20
> > This change also works for etags etc, and I presume it is just as usefu=
l
> > there.
>=20
> I cannot see how it will index i386 if I do not specify ALLSOURCES_ARCHS
> (and I am running on a i386).

The patch has:=20

+ALLSOURCE_ARCHS :=3D $(ARCH)

won't that do it? I thought $(ARCH) would be i386 so ALLSOURCE_ARCHS
will be too unless you override it.

I thought I'd tested non-ALLSOURCE_ARCHS but it was quite a while back
so I can't say for sure... I'll have a look when I get to work tomorrow
though.

Ian.
--=20
Ian Campbell

critic, n.:
	A person who boasts himself hard to please because nobody tries
	to please him.
		-- Ambrose Bierce, "The Devil's Dictionary"

--=-Z/KTyHJ/nqPt2dPqFJNc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1XUoM0+0qS9rzVkRAljQAJ4jWmtXTMcjXC2BwV6CHOv6kulx9QCgiKhZ
md8WS5/iis9IvVaJn90o1VQ=
=z4HU
-----END PGP SIGNATURE-----

--=-Z/KTyHJ/nqPt2dPqFJNc--

