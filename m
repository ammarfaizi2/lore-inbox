Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbVI0Xdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVI0Xdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVI0Xdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:33:38 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:14569 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S965194AbVI0Xdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:33:36 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4339CFC7.6080507@adaptec.com>
References: <4339440C.6090107@adaptec.com>
	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com>
	 <1127836380.4814.36.camel@mulgrave> <43399F17.4090004@adaptec.com>
	 <4339ACDA.3090801@pobox.com> <4339BD58.7060300@adaptec.com>
	 <4339C12C.5020004@pobox.com>  <4339CFC7.6080507@adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kWGDUuf04nkv3/RiOBsV"
Date: Tue, 27 Sep 2005 17:32:22 -0600
Message-Id: <1127863942.10079.25.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kWGDUuf04nkv3/RiOBsV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-09-27 at 19:03 -0400, Luben Tuikov wrote:
> On 09/27/05 18:01, Jeff Garzik wrote:
> > Luben Tuikov wrote:
> >=20
> >>The driver and the infrastructure needs to go in.
> >>
> >>Give it exposure to the people, let people play with it.
> >=20
> >=20
> > Merging into the upstream kernel is not necessary for exposure.
> >=20
> > Historically, saying "no" to a single vendor pushing really hard -- as=20
> > you are doing -- has resulted in a superior solution.
>=20
> This of course implies that everything in Linux is a
> superiour solution _or_ if it is not, then everything in
> linux is a vendor solution.

Or perhaps that it tends to result in better solutions than what would
exist if every vendor wrote their drivers with no consideration for
other vendors.

>=20
> >>If we start "fixing" SCSI Core now (this in itself is JB red
> >>herring), how long before it is "fixed" and we can "rest"?
> >>And how long then before the driver and infrastructure
> >>makes it in?
> >=20
> > Just follow the recipe Christoph outlined.  It's not difficult, just=20
> > requires some work.
>=20
> Anyone have a clear technical plan and/or infrastructure
> on how to do this?  Any specs, plans, consolidations, etc?
>=20
> I know its a wishful thinking, but when the architectures
> differ, not sure how to do this.
> "You can do everything with a big long if ()".

This sounds equivalent to "write your own block driver". =20

>=20
> > So far, this is an Adaptec-only solution.
>=20
> Yes, since Adaptec is the first company to come out with
> open transport SAS chip.  Broadcom seems to be doing the same thing.
> =20
> > It does an end run around 90% of the SCSI core.  You might as well make=
=20
> > it a block driver, if you're going to do that.
>=20
> The "90%" part isn't quite true.
>=20
> But going with a block device isn't that bad:
> Now since the architecture _is_ SCSI after all, what would be
> needed is a minimal, fast, straightforward, SAM/SPC fully complient
> new SCSI Core.  That SCSI Core would register block devices
> with the block layer.  Maybe Jens can point out cool things
> to do and make the whole infrastructure fast and very fast.
> (since we don't need to be bound by this legacy stuff)

Except that you would have to re-implement the SCSI upper-layer drivers
(at a minimum). Seems like it would be easier to take the existing code
in your driver/layers and modify to work with the existing SCSI
infrastructure.

>=20
> Essentially other new technology LLDD and Transport layers
> can probably make use of this: Infiniband, USB2 Storage, etc.
>=20

Seems silly to have all this code duplication.  Why not write to the
existing spec (even if it is an informal one), and then work to get the
spec changed, hopefully without pissing off all the maintainers.

> So if all you have is an AIC-94xx or BCM8603 storage chip
> you can exclule all of the legacy SCSI Core and compile this
> new mean, lean, fast SAM Core.
>=20
> Jeff, this isn't bad at all!

I am not sure if Jeff meant this as a tongue-in-cheek suggestion or is
just trying to get you off peoples backs. Perhaps he is indeed
serious. =20

Andrew

>=20
> Are you willing to contribute to such an effort?
>=20
> Thanks,
> 	Luben
>=20


--=-kWGDUuf04nkv3/RiOBsV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDOdaGoKXgdXvblSgRAu0fAJwI5F+y7TtWcPFNxHlAK5PM9P5s7wCg0Czj
uO7c3KjXhQ1fgsJuvHXX5ao=
=PIGQ
-----END PGP SIGNATURE-----

--=-kWGDUuf04nkv3/RiOBsV--

