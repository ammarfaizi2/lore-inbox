Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbULTDER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbULTDER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbULTDER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:04:17 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:27025 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261403AbULTDEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:04:00 -0500
Message-ID: <41C640DE.7050002@kolivas.org>
Date: Mon, 20 Dec 2004 14:02:54 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikhail Ramendik <mr@ramendik.ru>
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2> <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com> <200412200303.35807.mr@ramendik.ru>
In-Reply-To: <200412200303.35807.mr@ramendik.ru>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57CEDD287129D82D8B9E9514"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57CEDD287129D82D8B9E9514
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mikhail Ramendik wrote:
> Andrew Morton wrote:
> 
> 
>>- Ask Voluspa to do
>>
>>	echo 0 > /proc/sys/vm/swap_token_timeout
>>
>>  on 2.6.10-rc3 and retest.
> 
> 
> He did, and I did (but I have not sent my report to lkml). In both cases, 
> screen freezes remained but were now less in duration (up to 10-20 sec). In 
> mu case I also monitored CPU loading and the big load peaks were there (the 
> biggest one was in the beginning).
> 
> 
>>(We still don't know why it chews tons of CPU, do we?)
> 
> 
> It does! Any way to dig into this?
> 

I still suspect the thrash token patch even with the swap token timeout 
at 0. Is it completely disabled at 0 or does it still do something?

Con

--------------enig57CEDD287129D82D8B9E9514
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxkDgZUg7+tp6mRURAmloAJ9YJdJMNtdKPC/ZB6fUKFthC11dYgCfQZ7u
nAEC/4xY/27ZImKK7dP7F84=
=0Qj6
-----END PGP SIGNATURE-----

--------------enig57CEDD287129D82D8B9E9514--
