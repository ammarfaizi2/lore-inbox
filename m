Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUGAJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUGAJnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUGAJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 05:43:20 -0400
Received: from mail.donpac.ru ([80.254.111.2]:16031 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264386AbUGAJnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 05:43:17 -0400
Date: Thu, 1 Jul 2004 13:43:12 +0400
From: Andrey Panin <pazke@donpac.ru>
To: "Leonardo G. Di Lella" <leonardo@dilella.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio dmi_scan.c patch!
Message-ID: <20040701094312.GA8118@pazke>
Mail-Followup-To: "Leonardo G. Di Lella" <leonardo@dilella.org>,
	linux-kernel@vger.kernel.org
References: <40E3F014.1090601@dilella.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <40E3F014.1090601@dilella.org>
User-Agent: Mutt/1.5.6+20040523i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 183, 07 01, 2004 at 11:05:56AM +0000, Leonardo G. Di Lella wrote:
> Hello,
>=20
> there is a false entry in the dmi_scan.c while identifing the Sony Vaio.
>=20
>    { sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
>            MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>            MATCH(DMI_PRODUCT_NAME, "PCG-"),
>            NO_MATCH, NO_MATCH,
>            } },
>=20
> This is the origin part of the kernel (2.6.7). The main problem is that
> this works only with older Vaio (PCG-) models. So the best solution is
> to replace the MATCH(DMI_PRODUCT_NAME, "PCG-") with NO_MATCH,
> because PCG- is referring to a special model and not to all sony vaios.

With this change, it will match all computers made by Sony. Are you=20
really sure that they all have Vaio compatible hardware ?

> I have the VGN- model, so the kernel doesnt recognize it as a sony vaio.
> I have replaced the line and now it works. Better change this, for other=
=20
> sony vaio users.
=20
New DMI entry will do the same, without risk of false positives.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA49yvby9O0+A2ZecRAiMGAJwJR3j0xmB3ZRx7i8zgPZnpufoUhgCg1J+9
MdYiBpN9ZesZZza+2Zfu6Sg=
=CPzd
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
