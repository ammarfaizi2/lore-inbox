Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTLONQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTLONQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:16:55 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:27011 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263600AbTLONQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:16:51 -0500
Subject: Re: PCI Express support for 2.4 kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>,
       zaitcev@redhat.com, hch@infradead.org
In-Reply-To: <3FDDACA9.1050600@intel.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>
	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>
	 <3FDDACA9.1050600@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ii+jNsJoQvrbhiiroyrQ"
Organization: Red Hat, Inc.
Message-Id: <1071494155.5223.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Dec 2003 14:15:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ii+jNsJoQvrbhiiroyrQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I should be missing something here. You have 256M of physical address=20
> space at 0xe0000000 occupied.
> You can do nothing with it, it is simply present. Then, ioremap maps it=20
> somewhere in high memory.
> It should not conflict with kernel RAM, for which trivial mapping (+3G)=20
> used.

the thing is that typically you have a maximum of 168Mb or so of
ioremap/vmalloc space (they share the same pool). That is, ff your
system has >=3D 1Gb of ram, if it has less ran the ioremap/vmalloc space
is bigger....


--=-ii+jNsJoQvrbhiiroyrQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3bQLxULwo51rQBIRAvmkAJ0fQctye0e70gDX9h5JvXAFfszZdQCgmpTG
NN7JQhgkB5MZOxYl6LzlT1A=
=ADg1
-----END PGP SIGNATURE-----

--=-ii+jNsJoQvrbhiiroyrQ--
