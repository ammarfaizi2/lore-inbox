Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUBCTkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUBCThp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:37:45 -0500
Received: from web10407.mail.yahoo.com ([216.136.130.99]:63320 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266120AbUBCTfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:35:15 -0500
Message-ID: <20040203193514.13301.qmail@web10407.mail.yahoo.com>
Date: Wed, 4 Feb 2004 06:35:14 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.6.2-rc1-mm1 pppd: page allocation failure (Solved!)
To: Andrew Morton <akpm@osdl.org>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040131004214.05851d6e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

>
> This should fix it up.
>
>
> diff -puN
> drivers/net/ppp_deflate.c~ppp-allocation-fix
> drivers/net/ppp_deflate.c
> --- 25/drivers/net/ppp_deflate.c~ppp-allocation-fix
> 2004-01-31 00:39:08.000000000 -0800
> +++ 25-akpm/drivers/net/ppp_deflate.c	2004-01-31
> 00:40:21.000000000 -0800
> @@ -351,7 +351,7 @@ static void
> *z_decomp_alloc(unsigned cha
>  	state->w_size         = w_size;
>  	state->strm.next_out  = NULL;
>  	state->strm.workspace =
> kmalloc(zlib_inflate_workspacesize(),
> -					GFP_KERNEL);
> +

I applied the patch manually and the problem seems to
go away (2 or three days testing).
Thanks.

Regards,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIK7jv07eUvBr8ysRAmqzAJ45VOdj9YZIGtK+gwIv2rKqKYfg9gCeKIng
J+sf4pHzmmSRH92zXL8ler0=
=g1Uv
-----END PGP SIGNATURE-----


=====
S.KIEU

http://greetings.yahoo.com.au - Yahoo! Greetings
Send your love online with Yahoo! Greetings - FREE!
