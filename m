Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbULMVXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbULMVXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbULMVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:23:47 -0500
Received: from lug-owl.de ([195.71.106.12]:63624 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261171AbULMVXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:23:01 -0500
Date: Mon, 13 Dec 2004 22:23:01 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Message-ID: <20041213212301.GI16958@lug-owl.de>
Mail-Followup-To: Ed L Cashin <ecashin@coraid.com>,
	linux-kernel@vger.kernel.org
References: <87k6rmuqu4.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ltihE5wS63FR6l1A"
Content-Disposition: inline
In-Reply-To: <87k6rmuqu4.fsf@coraid.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ltihE5wS63FR6l1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 11:04:51 -0500, Ed L Cashin <ecashin@coraid.com>
wrote in message <87k6rmuqu4.fsf@coraid.com>:
[...]

Impressive list of changes. I'm thinking about implementing a userland
server for AoE. Is there a formal protocol specification available?
Though, I'd use the block driver's sources to reverse engineer it, but
for interoperability purposes, it would probably be better to start off
a specification than an implementation.

=2E o O (...and I'd love to get my hands on a real hardware device)

> diff -urNp linux-2.6.9/drivers/block/aoe/aoecmd.c linux-2.6.9-aoe/drivers=
/block/aoe/aoecmd.c
> --- linux-2.6.9/drivers/block/aoe/aoecmd.c	1969-12-31 19:00:00.000000000 =
-0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoecmd.c	2004-12-13 10:53:19.000000=
000 -0500
> +static void
> +aoecmd_ata_rw(struct Aoedev *d, struct Frame *f)
> +{
[...]
> +	if (d->flags & DEVFL_EXT) {
> +		ah->aflags |=3D AOEAFL_EXT;
> +		ah->lba4 =3D sector >>=3D 8;
> +		ah->lba5 =3D sector >>=3D 8;
> +	} else {
> +		extbit =3D 0;
> +		ah->lba3 &=3D 0x0f;
> +		ah->lba3 |=3D 0xe0;	/* LBA bit + obsolete 0xa0 */

This comment doesn't match it's code.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--ltihE5wS63FR6l1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBvgg0Hb1edYOZ4bsRAvQKAJ9IYX5LmrXrbvfEL6TqFF+XBBlNUwCdGCNm
HRnvrU9ufNLEvfpvlpj+geQ=
=ajhz
-----END PGP SIGNATURE-----

--ltihE5wS63FR6l1A--
