Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTISGDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbTISGDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:03:40 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:55512 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S261355AbTISGDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:03:35 -0400
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Date: Thu, 18 Sep 2003 23:02:15 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Xircom nic hang on boot since cs.c race condition patch
Message-ID: <20030919060215.GB5952@UnderGrid.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030917144406.753953dd.seanlkml@rogers.com> <20030917223336.H16045@flint.arm.linux.org.uk> <200309190247.h8J2lmhx005690@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <200309190247.h8J2lmhx005690@turing-police.cc.vt.edu>
X-GPG-Debian: 1024D/29AB4CDD  C745 FA35 27B4 32A6 91B3 3935 D573 D5B1 29AB 4CDD
X-GPG-General: 1024D/62DBDF62  E636 AB22 DC87 CD52 A3A4 D809 544C 4868 62DB DF62
User-Agent: Mutt/1.5.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

	Not sure if it's related but I've had problems with PCMCIA support in
the test kernels myself... The Cisco Aironet 350 has problems and I've
been able to make any use of the Orinoco Gold wireless card...
Fortunately the ethernet card is built in on PCI bus and doesn't have
any problem but I had being corded down...

	Regards,
	Jeremy

On Thu, Sep 18, 2003 at 10:47:48PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 17 Sep 2003 22:33:36 BST, Russell King said:
> > On Wed, Sep 17, 2003 at 02:44:06PM -0400, Sean Estabrooks wrote:
> > > [PCMCIA] Fix race condition causing cards to be incorrectly recognised
> > >=20
> > > This patch that went into test5 causes my Toshiba laptop with Xircom=
=20
> > > pcmcia nic to freeze on boot at "Socket status: 30000020". =20
> >=20
> > Unfortunately this patch does two things:
> >=20
> > (a) it fixes the problem with PCMCIA cards not being recognised on boot.
> > (b) it introduces a deadlock between the PCMCIA layer and the driver
> >     model.
>=20
> OK... so what's different about Sean's Toshiba and my Dell (or alternativ=
ely,
> the fact we both have Xircom cards) that the *old* code worked just fine?
>=20
> Is it the fact that it's a multi-function card?
>=20
> lspci -v says:
> 03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
>         Subsystem: Xircom Cardbus Ethernet 10/100
>         Flags: bus master, medium devsel, latency 64, IRQ 9
>         I/O ports at 1000 [size=3D128]
>         Memory at 10800000 (32-bit, non-prefetchable) [size=3D2K]
>         Memory at 10800800 (32-bit, non-prefetchable) [size=3D2K]
>         Expansion ROM at 10400000 [disabled] [size=3D16K]
>         Capabilities: [dc] Power Management version 1
>=20
> 03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (=
prog-if 02 [16550])
>         Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
>         Flags: medium devsel, IRQ 9
>         I/O ports at 1080 [size=3D8]
>         Memory at 10801000 (32-bit, non-prefetchable) [size=3D2K]
>         Memory at 10801800 (32-bit, non-prefetchable) [size=3D2K]
>         Expansion ROM at 10404000 [disabled] [size=3D16K]
>         Capabilities: [dc] Power Management version 1
>=20
> I could see problems if the serial controller is being added while the et=
hernet
> controller is still getting its act together while holding locks, since i=
t's one
> physical card.
>=20
> I admit not being hot on the programming model  for cardbus, but I'm
> quite willing to test patches.. ;)
>=20
>=20



--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/apvnzbdYcZyFNB8RAqCGAKCgOfQ7ICshVM00nj02wYR8BMD0FwCeIBLT
R1e3JwHi5WLWwZrC2TTT7bk=
=TkeX
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
