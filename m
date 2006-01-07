Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752557AbWAGQGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbWAGQGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbWAGQGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:06:06 -0500
Received: from mail.gmx.net ([213.165.64.21]:10478 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752557AbWAGQGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:06:05 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 17:06:22 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107160622.GA25918@section_eight.mops.rwth-aachen.de>
References: <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20060107142201.GC3389@suse.de>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please, don't drop me from the cc list!!)

Yay, problem solved!

On Sa, Jan 07, 2006 at 03:22:01 +0100, Jens Axboe wrote:
>=20
> You can use SG_IO on any block device that accepts "SCSI" commands in
> the end, like ide-cd. Google for the sg driver documentation and you
> will find there are various ways to submit sg commands. cdparanoia
> likely uses the old variant of opening the char device and read/writing
> commands to it, if you convert it to SG_IO it could use that transport
> always (on 2.6 kernels and newer).
>=20
> --=20
> Jens Axboe
>=20

Thanks guys for all your pointers. I googled for cdparanoia and SG_IO
and found out that someone at Red Hat already patched cdparanoia to use
SG_IO. http://people.redhat.com/pjones/cdparanoia/

If you're interested, the patches can be found in the src rpm:
http://people.redhat.com/pjones/cdparanoia/thomasvs/cdparanoia-alpha9.8-27.=
src.rpm

Well, I'm gonna submit an updated ebuild for Gentoo. Let's see how this
thing evolves.

Thanks again for all your help, especially Jens!

Cheers

Sebastian

P.S.: I already reripped the test disc using ide-cd and the
SG_IO-patched cdparanoia and the results are perfect. OMG, I bought Win
XP Home 2 months ago because of this (so I can use Exact Audio Copy). I
guess I can remove XP from my drive now and sell it to some wretched guy :)
Harhar.

S.
--=20
"When the going gets weird, the weird turn pro." (HST)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDv+b+TWouIrjrWo4RAvANAJwIbXFgeiViQAVgKKC8da5j4lzXzACeP6J9
aQVtEEqAkcE/vDImvYSF+VE=
=NkwM
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

