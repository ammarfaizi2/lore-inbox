Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUGEI0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUGEI0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUGEI0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:26:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5792 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265960AbUGEI0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:26:31 -0400
Subject: Re: [PATCH] prism54 use set_pci_mwi()
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: margitsw@t-online.de
In-Reply-To: <200407011909.i61J90GF006580@hera.kernel.org>
References: <200407011909.i61J90GF006580@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QUiHh8lLFMe6KTvXXEsq"
Organization: Red Hat UK
Message-Id: <1089015987.2805.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 10:26:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QUiHh8lLFMe6KTvXXEsq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> diff -Nru a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/w=
ireless/prism54/islpci_hotplug.c
> --- a/drivers/net/wireless/prism54/islpci_hotplug.c	2004-07-01 12:09:09 -=
07:00
> +++ b/drivers/net/wireless/prism54/islpci_hotplug.c	2004-07-01 12:09:09 -=
07:00
> @@ -321,6 +321,9 @@
>  	DEBUG(SHOW_TRACING, "%s: pci_set_master(pdev)\n", DRV_NAME);
>  	pci_set_master(pdev);
> =20
> +	/* enable MWI */
> +	pci_set_mwi(pdev);
> +

pci_set_mwi() has a return value that you're supposed to check.....

--=-QUiHh8lLFMe6KTvXXEsq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6RCzxULwo51rQBIRAouIAJ9jnGmK8Ei3GVj3PuvbUrp3CltlaACgqPlp
//2Vs18ryZ9NDaveXyG+ZVs=
=cWj8
-----END PGP SIGNATURE-----

--=-QUiHh8lLFMe6KTvXXEsq--

