Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUGSFgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUGSFgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 01:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUGSFgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 01:36:46 -0400
Received: from mail.donpac.ru ([80.254.111.2]:56525 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264097AbUGSFgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 01:36:43 -0400
Date: Mon, 19 Jul 2004 09:36:40 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Torsten Scheck <torsten.scheck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PIIX4 ACPI device - hardwired IRQ9
Message-ID: <20040719053640.GE32614@pazke>
Mail-Followup-To: Torsten Scheck <torsten.scheck@gmx.de>,
	linux-kernel@vger.kernel.org
References: <40F41D22.5080603@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <40F41D22.5080603@gmx.de>
User-Agent: Mutt/1.5.6+20040523i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 195, 07 13, 2004 at 07:34:26PM +0200, Torsten Scheck wrote:
> Dear friends:
>=20
> Please excuse my ignorance: Does the indicated line below have any other=
=20
> purpose apart from making me comment it and recompile the kernel to get=
=20
> my soundcard working? ;-)
>=20
> kernel-source-2.4.26/arch/i386/kernel/pci-pc.c
> static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
>         /* PIIX4 ACPI device: hardwired IRQ9 */
>  =3D=3D=3D>   d->irq =3D 9;
>=20
> $ isapnp /etc/isapnp.conf
> /etc/isapnp.conf:167 -- Fatal - resource conflict allocating IRQ9
> (see pci)
> /etc/isapnp.conf:167 -- Fatal - Error occurred executing request
> 'IRQ 9' --- further action aborted
>=20
> My soundcard is a Terratec EWS64 XL. I successfully use the=20
> sam9407-1.0.4 driver after a proper isapnp configuration, i.e. comment=20
> the hardwired IRQ9 line, compile the kernel, run isapnp.
>=20
>=20
> If there should be really no other purpose I recommend to comment the=20
> line, so I can use a precompiled kernel from now on. :-)

The answer is simple: don't use isapnptools with 2.4 kernel,
drivers should use kernel ISA PnP subsystem instead.

Unfortunately the sam9407-1.0.4 is extremely ugly piece of code and
no person sane enough will touch it (for the good summ of money perhaps :)

So the real thing you need is sam9407 driver rewritten from scrath :(

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+13oby9O0+A2ZecRAn9UAJ9mPvrLmTCoBq3ITNfkx3KbKe2n/QCfYMHZ
tQLJ8hP0wIFD0pC3xgd2oLM=
=oep3
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
