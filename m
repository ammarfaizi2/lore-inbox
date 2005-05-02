Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVEBLDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEBLDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 07:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVEBLDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 07:03:55 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:34530 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261196AbVEBLDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 07:03:52 -0400
Date: Mon, 2 May 2005 21:04:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, andros@citi.umich.edu, matthew@wil.cx,
       schwidefsky@de.ibm.com
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
Message-Id: <20050502210411.06226103.sfr@canb.auug.org.au>
In-Reply-To: <20050502091524.GA6457@osiris.boeblingen.de.ibm.com>
References: <20050502091524.GA6457@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__2_May_2005_21_04_11_+1000_heKGL50O_WCOIPom"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__2_May_2005_21_04_11_+1000_heKGL50O_WCOIPom
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Mon, 2 May 2005 11:15:24 +0200 Heiko Carstens <heiko.carstens@de.ibm.com=
> wrote:
>
> the semantics of fnctl used together with F_SETLEASE and
> argument F_RDLCK have been changed with bk changeset
> 1.1938.185.141 (sometime between 2.6.9 and 2.6.10).
> Since then it's only possible to get a read lease when the
> file in question does not have _any_ writers.
> This is at least inconsistent with the man page of fcntl
> and looks pretty much like this is a bug in the kernel.
>=20
> Any comments?

The previous behaviour was a bug that occurred because at the time the
original lease code was written, it was not possible to tell if there were
writers when the read lease was being taken. Further improvements in the
kernel have since made this possible.

The intention of a read lease is to let the holder know is anyone tries to
modify the file.

The current behaviour does not conflict with the man pages on Debian
(although the previous behaviour did not either :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__2_May_2005_21_04_11_+1000_heKGL50O_WCOIPom
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCdgkx4CJfqux9a+8RAmqNAJ9XBtLNOCbPtJPhAf6lTi0fEtOMuwCcC85J
G7hIuFGKSwVpiHsFud9MWpo=
=AjS8
-----END PGP SIGNATURE-----

--Signature=_Mon__2_May_2005_21_04_11_+1000_heKGL50O_WCOIPom--
