Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264006AbUECVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUECVJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUECVJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:09:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264006AbUECVJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:09:45 -0400
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davidm@hpl.hp.com, bunk@fs.tum.de,
       eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040503140251.274e1239.akpm@osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
	 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	 <20040501161035.67205a1f.akpm@osdl.org>
	 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	 <20040501175134.243b389c.akpm@osdl.org>
	 <16534.35355.671554.321611@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
	 <20040503140251.274e1239.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ie0qgokG6BLsKCSu/Zmq"
Organization: Red Hat UK
Message-Id: <1083618364.3843.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 03 May 2004 23:06:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ie0qgokG6BLsKCSu/Zmq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-03 at 23:02, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >=20
> >=20
> > How about this patch?=20
>=20
> Seems sane.  For after 2.6.6 ;)
>=20
> > +static inline long open(const char * name, int mode, int flags)
> > +{
> > +	return sys_open((const char __user *) name, mode, flags);
> > +}
>=20
> We may as well stick the get_fs()/set_fs() stuff in here as well - all
> callers need to do it, after all.  After which it would best be uninlined=
.


if you're going to modify callers, why not make them use open_filp()
instead of sys_open etc.


--=-Ie0qgokG6BLsKCSu/Zmq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAlrQ8xULwo51rQBIRAuvrAJ9WjogM+HshdRht4Kcz0S493Vgx+QCfZ8Ja
aRz1IxbpbZm5l3gOLpj3iio=
=e+79
-----END PGP SIGNATURE-----

--=-Ie0qgokG6BLsKCSu/Zmq--

