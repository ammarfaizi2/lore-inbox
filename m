Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSHMM2L>; Tue, 13 Aug 2002 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHMM2L>; Tue, 13 Aug 2002 08:28:11 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:11272 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S315266AbSHMM2K>; Tue, 13 Aug 2002 08:28:10 -0400
Date: Tue, 13 Aug 2002 13:31:59 +0100
To: Meelis Roos <mroos@cs.ut.ee>
Cc: kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
Message-ID: <20020813133159.A21210@computer-surgery.co.uk>
References: <200208121732.VAA18612@sex.inr.ac.ru> <Pine.GSO.4.43.0208131137110.14316-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.43.0208131137110.14316-100000@romulus.cs.ut.ee>; from mroos@cs.ut.ee on Tue, Aug 13, 2002 at 11:40:08AM +0300
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2002 at 11:40:08AM +0300, Meelis Roos wrote:
> > The problem is that checksum in tcpdump is OK.
> > This smells really bad.
> >
> > I feel you have to hunt where exactly the segment is dropped
> > and TCPInErrs is incremented.
>=20
> Things got stranger. The symptoms started to appear on other connections
> [....]
> I did a reboot with the same kernel (2.4.19+bk of some
> state, 4. Aug probably) and it just started to work with the same kernel
> image.

I've seen these sort of symptoms before and it turned out
to be faulty memory.=20

Back in 2.2 I had a box which picked the behavior up if
you did a ifconfig down/ifconfig up after it had been running
for some time.

tcpdump on the localbox it that case showed Ok (outgoing) packets, but=20
another box on the same network segment showed the same packets as
corrupted.

Changing the RAM cured it completely.

TTFN
--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9WPw+qQ3nO4jeCz4RArHgAJ0R7cvnNv1+BGjVDlP5cZYVBgZEfQCgmgRV
Z2aVHeA2LODtN4Nds/0cPJE=
=iARk
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
