Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUGYNYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUGYNYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGYNYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 09:24:38 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:58884 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S263893AbUGYNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 09:24:35 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41039CAC.965AB0AA@users.sourceforge.net>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SkjHW6ZRuZx3FD4glJhG"
Message-Id: <1090761870.10988.71.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jul 2004 15:24:30 +0200
From: Fruhwirth Clemens <clemens-dated-1091625872.c783@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SkjHW6ZRuZx3FD4glJhG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-25 at 13:42, Jari Ruusu wrote:
> Fruhwirth Clemens wrote:
> > Second, modern ciphers like Twofish || AES are designed to resist
> > known-plaintext attacks. This is basically the FUD spread by Jari Rusuu=
.
>=20
> Ciphers are good, but both cryptoloop and dm-crypt use ciphers in insecur=
e
> and exploitable way.
>=20
> This is not FUD. Fruhwirth, did you even try run the exploit code?
>=20
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107719798631935&w=3D2

There is no use in running your code. It does not decipher any block
without the proper key. Where is the exploit?=20

Further the link you provide in the posting above is broken (as you
already noticed). I tried at google cache, citeseer and the rest of
Saarien's homepage. No success.=20

If you have any idea where I can obtain the paper, I'd be interested in
seeing the references for your claims.. But guessing from the apparent
logic of your code, it seems to be identical to the weakness brought
forward in the following paragraph of my original posting, which you've
cut out of the quoting.

> > - There is no suitable user space tool ready to use it. util-linux has
> > been broken ever since. My patch key-trunc-fix patch has to be applied
> > to make any use of losetup.
>=20
> Can you name implementation that your "key-truncated" version is compatib=
le
> with that existed _before_ your version appeared?. To my knowledge, that
> key-truncated version is only compatible with itself, and there is no oth=
er
> version that does the same.

Actually there is a version: util-linux 2.12 official. But
unfortunately, the official version truncates binary keys (at 0x00, 0x0a
values), that's what my patch is for. cryptsetup handles keys the same
way. So migration is easy, something which does not hold true for your
strange util-linux patches. But you already know my critiques..

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-SkjHW6ZRuZx3FD4glJhG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBA7SNW7sr9DEJLk4RAhQSAJ0ZvPPt+Q/o4hYJg7W6LmTZyvawXgCgheQd
ixEKFpxhYFVgvt0A3oRtpG4=
=Uw5v
-----END PGP SIGNATURE-----

--=-SkjHW6ZRuZx3FD4glJhG--
