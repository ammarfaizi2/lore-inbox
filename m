Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTDKHkx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTDKHkw (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:40:52 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47598 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264313AbTDKHkv (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 03:40:51 -0400
Subject: Re: TCP/IP stack related prob.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alisha Nigam <mail_to_alisha@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030411073848.33517.qmail@web20106.mail.yahoo.com>
References: <20030411073848.33517.qmail@web20106.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L1FHeZ70k1Fr0LKQtACe"
Organization: Red Hat, Inc.
Message-Id: <1050047551.1415.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 11 Apr 2003 09:52:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L1FHeZ70k1Fr0LKQtACe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-11 at 09:38, Alisha Nigam wrote:

>  then compile it=20
>   gcc -c -O -W -Wall -Wstrict-prototypes
> -Wmissing-prototypes -DMODULE -D__KERNEL__ -mymodule.o
> mymodule.c=20
>=20
>=20
>    i am getting a bundle of errors ......=20
>=20
>=20
> In file included from /usr/include/linux/fs.h:23,
>                  from
> /usr/include/linux/capability.h:17,
>                  from /usr/include/linux/binfmts.h:5,
>                  from /usr/include/linux/sched.h:9,
>                  from /usr/include/linux/skbuff.h:19,
>                  from p10.c:2:
> /usr/include/linux/string.h:8:2: warning: #warning
> Using kernel header in userland!

you are using glibc headers to compile a kernel.... that's not going to
work. Add -I/lib/modules/`uname -r`/build/include to the gcc commandline
to use the headers of the currently running kernel..


--=-L1FHeZ70k1Fr0LKQtACe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQA+lnQ8xULwo51rQBIRAhwNAJYr86dmrW2sJ7nO/l2bQXLVgKToAJ41i152
L3xuJAsyqghPXiGJnVAS6Q==
=HQKW
-----END PGP SIGNATURE-----

--=-L1FHeZ70k1Fr0LKQtACe--
