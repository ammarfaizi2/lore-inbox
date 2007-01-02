Return-Path: <linux-kernel-owner+w=401wt.eu-S1754835AbXABNMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbXABNMt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 08:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbXABNMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 08:12:49 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:59957 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbXABNMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 08:12:49 -0500
Subject: Re: [PATCH] sound: aoa of_node_put and kfree cleanup
From: Johannes Berg <johannes@sipsolutions.net>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <200701021350.57816.m.kozlowski@tuxland.pl>
References: <200701021350.57816.m.kozlowski@tuxland.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rW6pTLpUqAYC6X5A8gHq"
Date: Tue, 02 Jan 2007 14:12:08 +0100
Message-Id: <1167743529.13592.44.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rW6pTLpUqAYC6X5A8gHq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-01-02 at 13:50 +0100, Mariusz Kozlowski wrote:

> 	This patch removes redundant argument checks for of_node_put() and kfree=
().

Looks good to me, thanks.

> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Acked-by: Johannes Berg <johannes@sipsolutions.net>

>  sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -upr linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.=
c linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> --- linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006=
-12-28 12:57:54.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007=
-01-02 01:50:26.000000000 +0100
> @@ -1034,9 +1034,9 @@ static int aoa_fabric_layout_probe(struc
>  	list_del(&ldev->list);
>  	layouts_list_items--;
>   outnodev:
> - 	if (sound) of_node_put(sound);
> + 	of_node_put(sound);
>   	layout_device =3D NULL;
> - 	if (ldev) kfree(ldev);
> + 	kfree(ldev);
>  	return -ENODEV;
>  }
> =20
>=20
>=20

--=-rW6pTLpUqAYC6X5A8gHq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFmloo/ETPhpq3jKURAu0HAKCpstMghKAcQRj0bnPd/nhQsg1EIwCgpjHb
xYW5pMEBpvHsE4u1cYfaITA=
=GDsk
-----END PGP SIGNATURE-----

--=-rW6pTLpUqAYC6X5A8gHq--

