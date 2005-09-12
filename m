Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVILXT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVILXT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVILXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:19:26 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:5351 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932349AbVILXTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:19:25 -0400
Subject: Re: [ANNOUNCE 0/2] Serial Attached SCSI (SAS) support for the
	Linux kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4325F488.5040304@adaptec.com>
References: <4321E2C1.7080507@adaptec.com>
	 <20050911092030.GA5140@infradead.org>  <4325F488.5040304@adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F3c/3N8SDVdWaqfktxF6"
Date: Mon, 12 Sep 2005 17:18:31 -0600
Message-Id: <1126567112.20831.102.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F3c/3N8SDVdWaqfktxF6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-09-12 at 17:35 -0400, Luben Tuikov wrote:
> On 09/11/05 05:20, Christoph Hellwig wrote:
> > Thanks for finally posting your code.
> >=20
> > At the core it's some really nice code dealing with host-based SAS
> > implementations.
>=20
> Thank you Christoph.  Much appreciated.
>=20
> > What's not nice is that it's not intgerating with the
> > SAS transport class I posted,
>=20
> I wish there was something I could do.  HP and LSI
> were aware of my efforts since the beginning of the year.

I know I am going to regret getting pulled into this ;-(.

This effort started on April.  Eric Moore, Mike Miller and I started
work on a SAS transport class and then later pulled Luben it at the
suggestion of Douglas Gilbert (if I remember correctly).  We later
mutually agreed that Luben would take over the transport class work as
he seemed to have much more experience with this sort of thing.  The
original idea was to implement a SAS transport class that would allow
the LSI and Adaptec driver to get into kernel.org (or others at the
time) and to find a way to get SDI/CSMI API's into the kernel without
the use of IOCTL's.  Luben then went off on his own and came up with his
effectively Adaptec only solution.

>=20
> As well, you had a copy of my code July 14 this year,
> long before starting your work on your SAS class for LSI and
> HP (so its acceptance is guaranteed), after OLS.

HP never suggested that Christoph do a SAS transport layer. We were
happy to provide some equipment when we found out that he was working on
it.  Please don't speak for HP. I am sure that LSI would prefer you
don't speak for them either.

>=20
> We did meet at OLS and we did have the SAS BOF.  I'm not sure
> why you didn't want to work together?

If my memory serves correctly, there were 10-12 people at that BOF,
representing the SCSI kernel maintainers and all of the vendors
currently providing SAS hardware.  Virtually everyone disagreed with
your implementation (which you indeed emailed shortly before the
conference) that would only work with one vendor's card. The suggestion
was made that you convert your code to various library layers so that it
would work with all vendors.  A suggestion which it seems that you
continue to reject.

>=20
> > it's duplicating things like LUN disocvery
>=20
> This is a much more involved subject than meets the eye.
>=20
> > from the SCSI core code, and adding it's own sysfs representation that'=
s
> > very different from the way the SCSI core and transport classes do it.
>=20
> Yes, it is time to evolve.
>=20
> I've pointed out many times the shortcomings of expanding the
> JB's "transport _attribute_ class" into a "transport layer" in
> recent threads.
>=20
> I'm sorry but over everything else, we need a common base,
> (what you call "techno-gibberish") in order to see eye to eye.
>=20
> > Are you willing to work with us to intgerate it with the infrastructure
> > we have?
>=20
> I'm sure you've already taken a closer look at the SAS code=20
> I posted.   Study it, read the spec, read the code again.
>=20
> Let me know if I can help with anything.
>=20
> Overall, MPT is very different in design than a disclosed
> transport.  Talk to HP, LSI and Dell and see what they think.

=46rom HP's point of view (or mine at least).  We would prefer something
that works with every vendors card.  Not Adaptec's (or is it Luben's)
vision of the perfect card.

Andrew
--=20
Andrew Patterson               =20
Hewlett-Packard

--=-F3c/3N8SDVdWaqfktxF6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJgzHoKXgdXvblSgRArxbAKC6fbWRh8/CadXThxlGzqqGy1eL8wCfZ68s
zPwJwKbm6dm4g3T/B5HX5bg=
=HYu6
-----END PGP SIGNATURE-----

--=-F3c/3N8SDVdWaqfktxF6--

