Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUGYU6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUGYU6S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUGYU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:58:18 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:9990 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S264419AbUGYU6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:58:08 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20040725T212435-197@post.gmane.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
	<1090761870.10988.71.camel@ghanima>
	<4103ED18.FF2BC217@users.sourceforge.net>
	<1090778567.10988.375.camel@ghanima>
	<loom.20040725T212435-197@post.gmane.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-T0fcOpdVl1owM4DZNaqn"
Message-Id: <1090789085.8623.18.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jul 2004 22:58:05 +0200
From: Fruhwirth Clemens <clemens-dated-1091653086.2b8e@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T0fcOpdVl1owM4DZNaqn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-25 at 21:44, Marc Ballarin wrote:
> Fruhwirth Clemens <clemens-dated-1091642568.f246 <at> endorphin.org> writ=
es: =20
>  =20
> >  =20
> > Probably I'm missing the point, but at the moment this looks like a =20
> > chosen plain text attack. As you know for sure, this is trivial. For =20
> > instance, AES asserts to be secure against this kind of attack. (See th=
e =20
> > author's definition of K-secure..). =20
>  =20
> It assures against key revovery through chosen plain text attacks. As wri=
tten=20
> before, the purpose of this attack is not to break encryption, but to pro=
ve=20
> the existence of a file *known to* and *prepared by* the attacker. =20

If an attacker has some means to put a file on the encrypted hard disk,
I'm not considering it a big breakthrough if he can find out the
position of that file. I'm sure this information can be gained by
forensic block access pattern analysis anyway.

> The exploit generates a rather simple bit pattern with a size of 1024 byt=
es. =20
> When this pattern - the watermark - is encrypted, dm-crypt's output has s=
ome =20
> special properties - independent of cipher or key size. =20
> For example, encoding nr. 1, always produces a cyphertext block, where by=
tes =20
> 0-15 are equal to bytes 512-523. =20

I'm starting to wonder why this is called an attack. The results of this
``attack'' can't be used in any way. In the worst case, a cipher
text/plain text pair can be obtained. I'm repeating it one more time:
ciphers are designed to resist further attacks steaming from known-plain
text attacks.

Have a look at=20
http://clemens.endorphin.org/OnTheProblemsOfCryptoloop . That's an
attack!
 =20
> On dm-crypt's mailing list, I have given a description how this can be re=
fined =20
> easily to improve reliability of detection and determine a file's layout =
on=20
> the encrypted volume. =20

I'm sorry, I consider this useless information.=20

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-T0fcOpdVl1owM4DZNaqn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBB7cW7sr9DEJLk4RAj2gAJ0aZPnzEUBaS1zhEKQMxNHnDFWJAwCeJ8kE
rNGa+499j9eHHN9WXoXt9jo=
=NjuU
-----END PGP SIGNATURE-----

--=-T0fcOpdVl1owM4DZNaqn--
