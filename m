Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUGZMpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUGZMpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGZMpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:45:42 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:59656 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S265255AbUGZMp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:45:29 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Jari Ruusu <jariruusu@users.sourceforge.net>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4104E2CC.D8CBA56@users.sourceforge.net>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
	<1090761870.10988.71.camel@ghanima>
	<4103ED18.FF2BC217@users.sourceforge.net>
	<1090778567.10988.375.camel@ghanima>
	<4104E2CC.D8CBA56@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0roL3SOQhYe0FWY5LWr7"
Message-Id: <1090845926.13338.98.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jul 2004 14:45:26 +0200
From: Fruhwirth Clemens <clemens-dated-1091709927.ed82@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0roL3SOQhYe0FWY5LWr7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-26 at 12:54, Jari Ruusu wrote:
> Fruhwirth Clemens wrote:
> > On Sun, 2004-07-25 at 19:25, Jari Ruusu wrote:
> > > In short: exploit encodes watermark patterns as sequences of identica=
l
> > > ciphertexts.
> >=20
> > Probably I'm missing the point, but at the moment this looks like a
> > chosen plain text attack. As you know for sure, this is trivial. For
> > instance, AES asserts to be secure against this kind of attack. (See th=
e
> > author's definition of K-secure..).
>=20
> > I'm suggesting it doesn't work at all.
>=20
> Fruhwirth, your incompetence has always amazed me. And this time is no
> exception. What is conserning is that some mainline folks seem to listeni=
ng
> to your ill opinions. No wonder that both mainline device crypto
> implementations are such a joke.

Please don't resort to personal defamations.=20

To summarize for an innocent bystander:

- The attacks you brought forward are in the best case a starting point
for known plain text attacks. Even DES is secure against this attack,
since an attacker would need 2^47 chosen plain texts to break the cipher
via differential cryptanalysis. (Table 12.14 Applied Cryptography,
Schneier). First, the watermark attack can only distinguish 32
watermarks. Second, you'd need a ~2.000.000 GB to store 2^47 chosen
plain texts. Third, I'm talking about DES (designed 1977!), no chance
against AES.

- The weaknesses brought forward by me are summarized  at
http://clemens.endorphin.org/OnTheProblemsOfCryptoloop . Thanks goes to
Pascal Brisset, who pointed out that cryptoloop is actually more secure
than I assumed.

If you, Jari, have any arguments left, it's time to state them now.
Otherwise, have a nice day,
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-0roL3SOQhYe0FWY5LWr7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBPzlW7sr9DEJLk4RAnqnAJ9ghY6VldsZUgRTH6a1vqGNYdQnmQCeMEKV
k1jfeeyoSStDsctUH5qyO6E=
=Virw
-----END PGP SIGNATURE-----

--=-0roL3SOQhYe0FWY5LWr7--
