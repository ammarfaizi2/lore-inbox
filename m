Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSG2IKQ>; Mon, 29 Jul 2002 04:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSG2IKQ>; Mon, 29 Jul 2002 04:10:16 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:50829 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313181AbSG2IKO>; Mon, 29 Jul 2002 04:10:14 -0400
Date: Mon, 29 Jul 2002 11:08:37 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29 sound/oss/trident.c [2/2] remove cli/sti calls
Message-ID: <20020729080836.GO10499@alhambra.actcom.co.il>
References: <20020728202207.GB10499@alhambra.actcom.co.il> <Pine.LNX.4.44.0207290948110.20701-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lsrIB+s628ok5gC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207290948110.20701-100000@linux-box.realnet.co.sz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lsrIB+s628ok5gC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2002 at 10:08:52AM +0200, Zwane Mwaikambo wrote:
> On Sun, 28 Jul 2002, Muli Ben-Yehuda wrote:
>=20
> > +
> > +	spin_unlock_irqrestore(&card->lock, flags);=20
> >  =09
> >  	restore_flags(flags);
> >  }
>=20
> hmm...

grrr, harmless I think, but thanks for spotting it.=20

=3D=3D=3D=3D=3D sound/oss/trident.c 1.25 vs 1.26 =3D=3D=3D=3D=3D
--- 1.25/sound/oss/trident.c	Mon Jul 29 07:08:09 2002
+++ 1.26/sound/oss/trident.c	Mon Jul 29 10:59:59 2002
@@ -3563,8 +3563,6 @@
 	outl(ali_registers.global_regs[0x2c], TRID_REG(card,T4D_MISCINT));
=20
 	spin_unlock_irqrestore(&card->lock, flags);=20
-=09
-	restore_flags(flags);
 }
=20
 static int trident_suspend(struct pci_dev *dev, u32 unused)

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--0lsrIB+s628ok5gC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9RPgEKRs727/VN8sRAmfcAKCsO57zJok0ME7Ci0lNTv8TAKWklgCguhHm
+RyyUkw71Z1UL1H13miKG7I=
=GHZf
-----END PGP SIGNATURE-----

--0lsrIB+s628ok5gC--
