Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUIAIeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUIAIeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIAIen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:34:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40372 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264265AbUIAIa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:30:28 -0400
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
In-Reply-To: <20040901072245.GF13749@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-82PY/ieQzQxAP/qKF+4A"
Organization: Red Hat UK
Message-Id: <1094027417.2947.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 10:30:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-82PY/ieQzQxAP/qKF+4A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 09:22, Michael S. Tsirkin wrote:
> Hello!
> Currently, on the x86_64 architecture, its quite tricky to make
> a char device ioctl work for an x86 executables.
> In particular,
>    1. there is a requirement that ioctl number is unique -
>       which is hard to guarantee especially for out of kernel modules

well... external modules thus should be really really careful with
ioctls then and not embrace and extend too much but just use existing
ones instead when reasonable

>    2. there's a performance huge overhead for each compat call - there's
>       a hash lookup in a global hash inside a lock_kernel -
>       and I think compat performance *is* important.

such is life

>=20
> Further, adding a command to the ioctl suddenly requires changing
> two places - registration code and ioctl itself.

adding ioctls SHOULD be painful. Really painful. It's similar to adding
syscalls; you'll have to keep compatibility basically forever so adding
should not be an easy thing.


--=-82PY/ieQzQxAP/qKF+4A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNYiZxULwo51rQBIRAkCuAJ9/sLhd3za+1ls6HEIIcFBmvSF3FwCgiVMl
X1ok3gBsQ0jGTTYdHT/VPbs=
=tR34
-----END PGP SIGNATURE-----

--=-82PY/ieQzQxAP/qKF+4A--

