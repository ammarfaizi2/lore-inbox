Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTEJKCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTEJKCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:02:39 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21743 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263759AbTEJKCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:02:38 -0400
Subject: Re: qla1280 mem-mapped I/O fix
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
References: <200305100951.h4A9pSAD012127@napali.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rHj16vAYV0y/5Fz9IFZA"
Organization: Red Hat, Inc.
Message-Id: <1052561708.1367.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 10 May 2003 12:15:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rHj16vAYV0y/5Fz9IFZA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> @@ -2634,7 +2634,7 @@
>  	/*
>  	 * Get memory mapped I/O address.
>  	 */
> -	pci_read_config_word (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
> +	pci_read_config_dword (ha->pdev, PCI_BASE_ADDRESS_1, &mmapbase);
>  	mmapbase &=3D PCI_BASE_ADDRESS_MEM_MASK;
> =20
>  =09
shouldn't this be pci_resource_start() ?

--=-rHj16vAYV0y/5Fz9IFZA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+vNErxULwo51rQBIRAj/JAKCaWArfEeGmWj1kH5mMx6yxJZQG1wCdGjN1
tPIhFmLipgtuZo6Zly6oxfI=
=tWzC
-----END PGP SIGNATURE-----

--=-rHj16vAYV0y/5Fz9IFZA--
