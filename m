Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTIEGei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTIEGei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:34:38 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:22226 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262691AbTIEGeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:34:36 -0400
Date: Fri, 5 Sep 2003 09:34:22 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop mprotect() changing MAP_SHARED and other cleanup
Message-ID: <20030905063422.GA1145@actcom.co.il>
References: <20030904193454.GA31590@mail.jlokier.co.uk> <20030904201851.GK13947@actcom.co.il> <20030904220435.GI31590@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20030904220435.GI31590@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2003 at 11:04:35PM +0100, Jamie Lokier wrote:
> Muli Ben-Yehuda wrote:
> > > +/* Optimisation macro. */
> > > +#define _calc_vm_trans(x,bit1,bit2) \
> > > +  ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
> > > +   : ((x) & (bit1)) / ((bit1) / (bit2))
> >=20
> > Why is this necessary? the original version of the macro was much
> > simpler. If this isn't just for shaving a couple of optimization,

I meant "shaving a couple of instructions", of course.=20

> > please document it. If it is, I urge you to reconsider ;-)=20
>=20
> When the bits don't match, mine reduces to a mask-and-shift.  The
> original reduces to a mask-and-conditional, which is usually slower.

Ok. Your version is also incomprehensible (to me, at least) without
working it out using a pen and paper, whereas the original is clear
and concise. Are the saved CPU cycles worth the wasted programmer
cycles in this case? I doubt it.
--=20
Muli Ben-Yehuda
http://www.mulix.org


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/WC5tKRs727/VN8sRAhALAJ4qlxzgvUiNfoEvYscQuqcHaDwdAACaAjxr
QWczTq++TxYiHSWtIbOnm9A=
=o7u+
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
