Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTKYOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 09:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTKYOA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 09:00:58 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:57219 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262581AbTKYOAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 09:00:55 -0500
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FC358B5.3000501@softhome.net>
References: <3FC358B5.3000501@softhome.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-de8gHsGvkYhYk0z4Uwo9"
Organization: Red Hat, Inc.
Message-Id: <1069768835.5214.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 Nov 2003 15:00:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-de8gHsGvkYhYk0z4Uwo9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-11-25 at 14:27, Ihar 'Philips' Filipau wrote:
> Hello!
>=20
>    I just wondering: do last three stable branches of LK able to return=20
> malloc()=3D=3DNULL and/or ENOMEM?
>=20
>    2.2: I cannot test this stuff right now - but it was hanging hard on=20
> "for (;;) memset(malloc(N), 0, N);" So we do not have NULL from malloc().
>    2.4: same behaviour if OOM disabled. But by default (OOM even has no=20
> configuration entry - so always on) it just kills offending process. No=20
> NULL pointer either.
>    2.6: the same as 2.4 with oom killer (default conf). I have no test=20
> system to check 2.6. w/o oom killer.
>=20
>    Resume: we malloc() never returns NULL. so man-pages are incorrect ;-)

that is due to the overcommit policy that your admin has set.=20
You can set it to disabled and then malloc will return NULL in userspace



--=-de8gHsGvkYhYk0z4Uwo9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/w2CDxULwo51rQBIRApwQAJ0ZdwjPQwlXFWMkBHuOcqOXb8dBqwCfWxQR
F5KL3o9wdI1lR8xsyDYaLP8=
=CUcq
-----END PGP SIGNATURE-----

--=-de8gHsGvkYhYk0z4Uwo9--
