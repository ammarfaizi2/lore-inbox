Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUFIUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUFIUVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFIUVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:21:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265932AbUFIUVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:21:40 -0400
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <1086812001.13026.63.camel@cherry>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
	 <20040609113455.U22989@build.pdx.osdl.net>
	 <1086812001.13026.63.camel@cherry>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DJRcqNW3GL/wL/7s9Mfv"
Organization: Red Hat UK
Message-Id: <1086812486.2810.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Jun 2004 22:21:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DJRcqNW3GL/wL/7s9Mfv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> + */
> +void *kcalloc(size_t n, size_t size, int flags)
> +{
> +	void *ret =3D kmalloc(n * size, flags);

how about making sure n*size doesn't overflow an int in this function?
We had a few security holes due to that happening a while ago; might as
well prevent it from happening entirely

--=-DJRcqNW3GL/wL/7s9Mfv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAx3FFxULwo51rQBIRAokVAJ9M0CI2R4qMtkPN7yjETCF2Ojy1JQCfSsdQ
QjIX5eglnibBZlhkucSuo0c=
=Sop5
-----END PGP SIGNATURE-----

--=-DJRcqNW3GL/wL/7s9Mfv--

