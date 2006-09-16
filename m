Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWIPDre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWIPDre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 23:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWIPDre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 23:47:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932398AbWIPDrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 23:47:33 -0400
Subject: Re: Linux 2.6.18-rc6
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1157637874.3462.8.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <20060906110147.GA12101@aepfle.de>
	 <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
	 <20060907091517.GA21728@aepfle.de>
	 <1157637874.3462.8.camel@mulgrave.il.steeleye.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z7ubKhyjYxFWzD1CqxBl"
Organization: Red Hat, Inc.
Date: Fri, 15 Sep 2006 23:47:04 -0400
Message-Id: <1158378424.2661.150.camel@fc6.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-1.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z7ubKhyjYxFWzD1CqxBl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-07 at 09:04 -0500, James Bottomley wrote:
> On Thu, 2006-09-07 at 11:15 +0200, Olaf Hering wrote:
> > This does not work: ahc_linux_get_signalling: f 56f6
> >=20
> > echo $(( 0x56f6 & 0x00002 )) gives 2, and the ahc_inb is called.
>=20
> Erm, there's something else going on then:  An ultra 2 card has to have
> this register.  It's used to signal mode changes in
> ahc_handle_scsiint().  The piece of code in there will trigger and read
> this register for any ultra 2 + controller every time there's an error
> (just to see if the bus mode changed).

Sorry for my belated response, but this usually happens when you access
an aic chipset too soon after a chip reset.  Try putting a delay before
whatever access is causing this to see if it make s difference.  Common
problems include after a chip reset, touching any register will cause
the card to reset, etc.

--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: CFBFF194
              http://people.redhat.com/dledford

Infiniband specific RPMs available at
              http://people.redhat.com/dledford/Infiniband

--=-Z7ubKhyjYxFWzD1CqxBl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFC3O4g6WylM+/8ZQRAkMoAJ9bMRVyQVN8CAIQbMeCe1wMX8MrXACgkUbl
D67khWM951RMKhHG5JOmn7E=
=lKOW
-----END PGP SIGNATURE-----

--=-Z7ubKhyjYxFWzD1CqxBl--

