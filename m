Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVDETsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVDETsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDETqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:46:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261909AbVDETkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:40:37 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Josselin Mouette <joss@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <4252E6C1.5010701@pobox.com>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>
	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com>
	 <1112723637.4878.14.camel@mirchusko.localnet>  <4252E6C1.5010701@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QDQcNYxJWE035V9fHTXJ"
Organization: Red Hat, Inc.
Date: Tue, 05 Apr 2005 21:40:24 +0200
Message-Id: <1112730024.6275.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QDQcNYxJWE035V9fHTXJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> * The firmware distribution infrastructure is basically non-existent.=20
> There is no standard way to make sure that a firmware separated from the=20
> driver gets to all users.
>=20
> * The firmware bundling infrastructure is basically non-existent.=20
> (Arjan talked about this)  There needs to be a a way to ensure that the=20
> needed firmwares are automatically added to initramfs/initrd.
>=20
> * There is no chicken-and-egg problem as Arjan mentions.=20

actually there is; you just perfectly described it. Until we have
drivers that can use such firmware (and need it in initrds and the like)
infrastructure for that is unlikely to come into existence, and until
there is such infrastructure, driver authors like you are unlikely to
want to transition to loading firmware.  Now there is also your other
point about the request_firmware() interface being too primitive, and
that sure sounds valid. So to move forward two things need to happen

1) the infrastructure needs expanding to be useful for more drivers

2) the chicken and egg stalemate needs breaking. One way to do that is
to have dual-mode drivers for a while (eg drivers that request_firmware
() and if that fails, use the built-in firmware) so that the other
outside-the-kernel infrastructure can be developed and deployed.



--=-QDQcNYxJWE035V9fHTXJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCUumopv2rCoFn+CIRAlrzAJ9jyeE6cITCbL4Dkuva6EUekyryUgCeMdD9
f5X+2qercs7heUp4gxHDneo=
=Z/7l
-----END PGP SIGNATURE-----

--=-QDQcNYxJWE035V9fHTXJ--

