Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUBNS3J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBNS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 13:29:09 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:8854 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262794AbUBNS3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 13:29:04 -0500
Subject: Re: [BK PATCHES] 2.6.x libata update
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <402D3B97.70005@pobox.com>
References: <20040213184316.GA28871@gtf.org>
	 <1076700491.22542.38.camel@nosferatu.lan>  <402D3B97.70005@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6VK8gaaRXmUvhm3X9n/7"
Message-Id: <1076783378.27648.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 20:29:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6VK8gaaRXmUvhm3X9n/7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-13 at 23:03, Jeff Garzik wrote:
> Martin Schlemmer wrote:
> > On Fri, 2004-02-13 at 20:43, Jeff Garzik wrote:
> >=20
> > Hi
> >=20
> >=20
> >><jgarzik@redhat.com> (04/02/13 1.1634)
> >>   [libata] catch, and ack, spurious DMA interrupts
> >>  =20
> >>   Hardware issue on Intel ICH5 requires an additional ack sequence
> >>   over and above the normal IDE DMA interrupt ack requirements.  Issue
> >>   described in post to freebsd list:
> >>   http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
> >>  =20
> >>   Since the bug workaround only requires a single additional PIO or
> >>   MMIO read in the interrupt handler, it is applied to all chipsets
> >>   using the standard libata interrupt handler.
> >>  =20
> >>   Credit for research the issue, creating the patch, and testing the
> >>   patch all go to Jon Burgess.
> >>
> >=20
> >=20
> > Did you miss the mail I sent about this locking my box in under
> > 20-30 mins?  It still looks the same as the previous one ....
>=20
>=20
> Yes, I did.  Can you test 2.6.3-rc2 + this patch?
>=20

Yep, it still breaks it.  I get a dma timeout on heavy disk access,
and then things start to freeze (or do not start at all).  Seems
Jon is hitting the same issue with -bk4.

If you need debugging/whatever, just let me know what to do


Thanks,

--=20
Martin Schlemmer

--=-6VK8gaaRXmUvhm3X9n/7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBALmkSqburzKaJYLYRAnSqAJ4sNrHqIxSveXdvF6oQIcy6cQgXxwCdHjM7
j/meoG3Y12ettsu/Wk5bTSw=
=MfoI
-----END PGP SIGNATURE-----

--=-6VK8gaaRXmUvhm3X9n/7--

