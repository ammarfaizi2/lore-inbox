Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVDEXzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVDEXzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDEXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:53:35 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:23744 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262013AbVDEXw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:52:26 -0400
Date: Wed, 6 Apr 2005 09:52:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] Fix compat stat handling on sparc64
Message-Id: <20050406095217.5a728d04.sfr@canb.auug.org.au>
In-Reply-To: <20050405135737.0a413358.davem@davemloft.net>
References: <20050405135737.0a413358.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 5 Apr 2005 13:57:37 -0700 "David S. Miller" <davem@davemloft.net> w=
rote:
>
> --- 1.19/include/asm-sparc64/compat.h	2005-02-17 21:53:03 -08:00
> +++ edited/include/asm-sparc64/compat.h	2005-04-05 12:37:58 -07:00
> @@ -51,11 +51,11 @@
>  	compat_dev_t	st_rdev;
>  	compat_off_t	st_size;
>  	compat_time_t	st_atime;
> -	u32		__unused1;
> +	u32		st_atime_nsec;

Surely you meant to put compat_ulong_t instead of u32 ... :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUyS14CJfqux9a+8RAseYAJ9qg9J1uQpXS88cgkmzrUJ+R9cNzgCfRqRq
p2gWqx2o27LDxzX32Pf9SnE=
=FEhu
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R--
