Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbULSAnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbULSAnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbULSAnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 19:43:16 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:63193 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261251AbULSAnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 19:43:11 -0500
Message-ID: <41C4CE77.40601@kolivas.org>
Date: Sun, 19 Dec 2004 11:42:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikhail Ramendik <mr@ramendik.ru>
Cc: ck@vds.kolivas.org, Rik van Riel <riel@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>, linux <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.7 backport request, spinoff idea
References: <200412171504.41234.mr@ramendik.ru> <41C4A670.9090009@kolivas.org> <41C4A899.10102@kolivas.org> <200412190321.16567.mr@ramendik.ru>
In-Reply-To: <200412190321.16567.mr@ramendik.ru>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04A01DEC08F8B9D8621D81D8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04A01DEC08F8B9D8621D81D8
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Mikhail Ramendik wrote:
> Con Kolivas wrote:
> 
> 
>>Actually I wonder if the swap token is responsible in 2.6.10-rc3
>>
>>Try this
>>echo 0 > /proc/sys/vm/swap_token_timeout
> 
> 
> Well, this makes things really better, although not as good as 2.6.8.1. There 
> are kswapd cpu jumps and screen freezes, but they only last several seconds 
> (the longest is in the very beginning, about 15-20 sec).
> 
> Thanks! This makes the system much more useable.

This is worth posting to lkml so I've cc'ed a few relevant people (there 
is already a thread about this there). Rik care to comment? I recall 
pointing out this test case a while back. Got any way to make it harder 
to trigger the swap token? It seems to affect normal workloads adversely 
considering how rare swap thrashing actually occurs.

Con

--------------enig04A01DEC08F8B9D8621D81D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxM55ZUg7+tp6mRURAgm/AJ90qPhr9U57MwCu1WSBDwVtiic9SACfQV0T
nTpC98hLcg6Ymw/ayu10sHw=
=5FE7
-----END PGP SIGNATURE-----

--------------enig04A01DEC08F8B9D8621D81D8--
