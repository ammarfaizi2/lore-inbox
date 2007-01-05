Return-Path: <linux-kernel-owner+w=401wt.eu-S1161014AbXAEIKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbXAEIKQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXAEIKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:10:16 -0500
Received: from www.sf-tec.de ([62.27.20.187]:47318 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161014AbXAEIKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:10:14 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Date: Fri, 5 Jan 2007 09:10:01 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed>
In-Reply-To: <20070105063600.GA13571@Ahmed>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1726932.NnAX9TNoZW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701050910.11828.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1726932.NnAX9TNoZW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ahmed S. Darwish wrote:
> Remove unnecessary kmalloc casts in drivers/char/tty_io.c
>
> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

>  	if (!*ltp_loc) {
> -		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
> -						 GFP_KERNEL);
> +		ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
                      ^^^^^^^
>  		if (!ltp)
>  			goto free_mem_out;
>  		memset(ltp, 0, sizeof(struct ktermios));
                ^^^^^^

kzalloc

>  		if (!*o_ltp_loc) {
> -			o_ltp = (struct ktermios *)
> -				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
> +			o_ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
                                ^^^^^^^
>  			if (!o_ltp)
>  				goto free_mem_out;
>  			memset(o_ltp, 0, sizeof(struct ktermios));
                        ^^^^^^

kzalloc

HTH

Eike

--nextPart1726932.NnAX9TNoZW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFngfjXKSJPmm5/E4RAmlSAKCPGN59k9GjWuqYSfgSEi0nyd7qKwCfTbm4
atYuMT9hfVZFlpByQJy29uU=
=5can
-----END PGP SIGNATURE-----

--nextPart1726932.NnAX9TNoZW--
