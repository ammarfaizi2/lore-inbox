Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUJMPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUJMPjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUJMPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:39:40 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:1465 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269190AbUJMPep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:34:45 -0400
Subject: Re: waiting on a condition
From: Christophe Saout <christophe@saout.de>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02bb01c4b138$8a786f10$161b14ac@boromir>
References: <02bb01c4b138$8a786f10$161b14ac@boromir>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kYX7nfUx5Mrj0BHHGAXw"
Date: Wed, 13 Oct 2004 17:34:39 +0200
Message-Id: <1097681679.4724.26.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kYX7nfUx5Mrj0BHHGAXw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 13.10.2004, 16:23 +0100 schrieb Martijn Sipkema:

> I'd like to do something similar as can be done using a POSIX condition
> variable in the kernel, i.e. wait for some condition to become true. The
> pthread_cond_wait() function allows atomically unlocking a mutex and
> waiting on a condition. I think I should do something like:
> (the condition is updated from an interrupt handler)

You can take a look at reiser4, it has such an implementation. It's
called kcond (fs/reiser4/kcond.c). It's using semaphores, waitqueues and
a spinlock to emulate POSIX conditions.


--=-kYX7nfUx5Mrj0BHHGAXw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBbUsPZCYBcts5dM0RAj+AAKCplzFTbuxtMNTZbbSwHxCBLSbeAgCfYYRd
kgfInq5gs+GOi2vHuHTWmYg=
=QoaP
-----END PGP SIGNATURE-----

--=-kYX7nfUx5Mrj0BHHGAXw--

