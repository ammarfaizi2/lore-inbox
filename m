Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWIYVjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWIYVjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWIYVjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:39:33 -0400
Received: from mail.isohunt.com ([69.64.61.20]:59082 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751471AbWIYVjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:39:32 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Mon, 25 Sep 2006 14:39:38 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "Robin H. Johnson" <robbat2@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060925213938.GE415@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <450F88F0.307@garzik.org> <450F8D2E.6060700@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <450F8D2E.6060700@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2006 at 03:24:46PM +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> >I don't really like this port_tbl approach.  I think it complicates=20
> >things too much.
> >
> >Direct indexing should be fine.  For the non-linear case, just make sure=
=20
> >the non-existent ports are always dummy ports.  If the driver directly=
=20
> >references a port we know isn't there, that's just an AHCI bug to be=20
> >fixed...
>=20
> I thought about that too, but it will end up with ata1-6 with dummy 3=20
> and 4 while the BIOS shows continuous 4 ports.  I wanted avoid this=20
> discrepancy as it could cause confusion to users.
>=20
> The other option is adding pp->port_idx to record hw port index.  It=20
> does make the code a bit simpler.  What do you think about this?
*bump*

Jeff - any opinions on Tejun's or my last posts on this, or do you want
to see some code for the idea.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFGEyaPpIsIjIzwiwRAsvhAJwNm8s8WK5fmNPGa2u1RESDQsjB2gCg/vqc
gszhcX7WIKA9piCMGFlNSoo=
=mzzi
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
