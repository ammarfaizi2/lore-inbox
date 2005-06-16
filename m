Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVFPEQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVFPEQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVFPEQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:16:15 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:45009 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261732AbVFPEQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:16:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Alexander Gretencord <arutha@gmx.de>
Subject: Re: Swapping in 2.6.10 and 2.6.11.11 on a desktop system
Date: Thu, 16 Jun 2005 14:16:01 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506141653.32093.arutha@gmx.de> <200506150242.02606.kernel@kolivas.org> <200506151544.17191.arutha@gmx.de>
In-Reply-To: <200506151544.17191.arutha@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10282255.ZbLVO7rZ41";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506161416.03569.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10282255.ZbLVO7rZ41
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 15 Jun 2005 23:44, Alexander Gretencord wrote:
> On Tuesday 14 June 2005 18:42, Con Kolivas wrote:
> > Try the mapped watermark patch from -ck on 2.6.11*
>
> Unfortunately this patch does not help either. The patch buys me time but
> then I get swapping at the 300MB mark. 2.6.8.1 with swappiness=3D0 swaps
> later than this...

Try tweaking it with this:
echo 100 > /proc/sys/vm/mapped

If this tries so hard to avoid swap that you get an out-of-memory condition=
=20
you may also have to disable the hard maplimit with this:
echo 0 > /proc/sys/vm/hardmaplimit

Cheers,
Con

--nextPart10282255.ZbLVO7rZ41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCsP0DZUg7+tp6mRURAiQFAJ9p419Dm8+WgBojZM9JWE62DnO7NwCfTPpe
4z1kYYhsC+sQ4MBxlAoNCb0=
=uPOR
-----END PGP SIGNATURE-----

--nextPart10282255.ZbLVO7rZ41--
