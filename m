Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTLNPAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 10:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTLNPAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 10:00:16 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:62089 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262063AbTLNPAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 10:00:10 -0500
Subject: Re: Problem with exiting threads under NPTL
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031214052516.GA313@vana.vc.cvut.cz>
References: <20031214052516.GA313@vana.vc.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cBd1K444WoVe0AlqtZ7v"
Message-Id: <1071414122.4987.80.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 17:02:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cBd1K444WoVe0AlqtZ7v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-14 at 07:25, Petr Vandrovec wrote:
> Hi,
>   several times one of our threads ended up as ZOMBIE and
> nobody wants to pick him up - even init ignores it. Inspection
> of kernel structures revealed that task's exit code is 0,
> exit_signal is -1, ptrace is 0 and state is 8 (ZOMBIE).
>=20

>    So if some process ignores SIGCHLD, and spawns child process=20
> which creates additional thread, and main thread in child exits=20
> before child it created, you'll end up with immortal zombie.
>=20

I can confirm this behavior here, although I must admit I do not
know if the sample code is legal.  Latest glibc from cvs + bk kernel.


Cheers,

--=20
Martin Schlemmer

--=-cBd1K444WoVe0AlqtZ7v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/3HtqqburzKaJYLYRArBxAJ9TaceI16W+YNT4MF62sksVoR9tUgCbBoW0
ItEco/jDuEsnYPJVLsQbuDg=
=LSnE
-----END PGP SIGNATURE-----

--=-cBd1K444WoVe0AlqtZ7v--

