Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265822AbTGDHRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbTGDHRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:17:31 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:39662 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265822AbTGDHRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:17:30 -0400
Subject: Re: [PATCH] Re: VIA PCI IRQ router bug fix
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org, mj@ucw.cz, alan@redhat.com
In-Reply-To: <3F04C1AA.80107@pobox.com>
References: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>
	 <3F04C1AA.80107@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1TiRWJnp0s5QHXncQQCX"
Organization: Red Hat, Inc.
Message-Id: <1057303907.5801.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 04 Jul 2003 09:31:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1TiRWJnp0s5QHXncQQCX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> =20
>  static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int=
 pirq, int irq)
>  {
> -	write_config_nybble(router, 0x55, pirq, irq);
> +	write_config_nybble(router, 0x55, pirq =3D=3D 4 ? 5 : pirq, irq);
>  	return 1;
>  }


you missed the=20
> +        return (x >> 4);
in the original patch... so your code is NOT identical.=20

--=-1TiRWJnp0s5QHXncQQCX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/BS1jxULwo51rQBIRAhg4AJ0bAzQSsdz+TGsPuOGiUzVU8qZ1zwCfRwHN
lrFmlTyOCxnW8tzO2KCopVI=
=7ELe
-----END PGP SIGNATURE-----

--=-1TiRWJnp0s5QHXncQQCX--
