Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTLNKqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 05:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTLNKqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 05:46:23 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:52354 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263800AbTLNKqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 05:46:21 -0500
Subject: Re: [CFT][RFC] HT scheduler
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jamie Lokier <jamie@shareable.org>, bill davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FDC3023.9030708@cyberone.com.au>
References: <20031213022038.300B22C2C1@lists.samba.org>
	 <3FDAB517.4000309@cyberone.com.au> <brgeo7$huv$1@gatekeeper.tmr.com>
	 <3FDBC876.3020603@cyberone.com.au>
	 <20031214043245.GC21241@mail.shareable.org>
	 <3FDC3023.9030708@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5XpcfM1dsn4odEYQ1KMw"
Organization: Red Hat, Inc.
Message-Id: <1071398761.5233.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 14 Dec 2003 11:46:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5XpcfM1dsn4odEYQ1KMw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >Regarding the overhead of the shared runqueue lock:
> >
> >Is the "lock" prefix actually required for locking between x86
> >siblings which share the same L1 cache?
> >
>=20
> That lock is still taken by other CPUs as well for eg. wakeups, balancing=
,
> and so forth. I guess it could be a very specific optimisation for
> spinlocks in general if there was only one HT core. Don't know if it
> would be worthwhile though.

also keep in mind that current x86 processors all will internally
optimize out the lock prefix in UP mode or when the cacheline is owned
exclusive.... If HT matters here let the cpu optimize it out.....

--=-5XpcfM1dsn4odEYQ1KMw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3D9pxULwo51rQBIRAtPqAJ996GzmPZ5zkrN+qxVQxsupTRC+XACZAfU0
sUlw6QgoDrXCXGiL+1jB4jE=
=Yjf+
-----END PGP SIGNATURE-----

--=-5XpcfM1dsn4odEYQ1KMw--
