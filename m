Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbWJ3JqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbWJ3JqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWJ3JqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:46:19 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:57532 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030530AbWJ3JqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:46:18 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers/video/*: use kmemdup()
Date: Mon, 30 Oct 2006 10:45:57 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Eric Sesterhenn <snakebyte@gmx.de>
References: <20061029195803.GC4900@martell.zuzino.mipt.ru>
In-Reply-To: <20061029195803.GC4900@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1609580.kSXYEtdSFK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610301046.03714.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1609580.kSXYEtdSFK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alexey Dobriyan wrote:
> From: Eric Sesterhenn <snakebyte@gmx.de>
>
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  drivers/video/aty/radeon_monitor.c  |    3 +--
>  drivers/video/i810/i810-i2c.c       |    4 +---
>  drivers/video/intelfb/intelfbdrv.c  |    3 +--
>  drivers/video/nvidia/nv_i2c.c       |    7 ++-----
>  drivers/video/nvidia/nv_of.c        |    3 +--
>  drivers/video/savage/savagefb-i2c.c |    7 ++-----
>  6 files changed, 8 insertions(+), 19 deletions(-)
>
> --- a/drivers/video/aty/radeon_monitor.c
> +++ b/drivers/video/aty/radeon_monitor.c
> @@ -104,10 +104,9 @@ static int __devinit radeon_parse_montyp
>  	if (pedid == NULL)
>  		return mt;
>
> -	tmp = (u8 *)kmalloc(EDID_LENGTH, GFP_KERNEL);
> +	tmp = (u8 *)kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);

No cast here.

Eike

--nextPart1609580.kSXYEtdSFK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFRcnbXKSJPmm5/E4RAkbDAJ49lja2iH7y599OwSgwNrweKLMXiACgh8U1
rBE1fToZoJlNrZ1p8Znns/o=
=V2cq
-----END PGP SIGNATURE-----

--nextPart1609580.kSXYEtdSFK--
