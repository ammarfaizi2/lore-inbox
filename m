Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbULTEOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbULTEOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbULTEOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:14:23 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:46225 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261405AbULTEOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:14:18 -0500
Message-ID: <41C65169.4020508@kolivas.org>
Date: Mon, 20 Dec 2004 15:13:29 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Mikhail Ramendik <mr@ramendik.ru>, Andrew Morton <akpm@digeo.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, lista4@comhem.se,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2> <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com> <200412200303.35807.mr@ramendik.ru> <41C640DE.7050002@kolivas.org> <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4DA86FAE9C2F70BF1198AA47"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DA86FAE9C2F70BF1198AA47
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:
> On Mon, 20 Dec 2004, Con Kolivas wrote:
> 
>> I still suspect the thrash token patch even with the swap token 
>> timeout at 0. Is it completely disabled at 0 or does it still do 
>> something?
> 
> 
> It makes it harder to page out pages from the task holding the
> token.  I wonder if kswapd should try to steal the token away
> from the task holding it, so in effect nobody holds the token
> when the system isn't under a heavy swapping load.
> 

What if the token isn't handed out at all until a heavy swapping load 
starts? A slight delay in thrash control would be worth it.

Con

--------------enig4DA86FAE9C2F70BF1198AA47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxlFrZUg7+tp6mRURAilgAJ9shmc1cNi9t13kKKJ08LEgxV851ACeOBkp
pjUvjGPppvUUKVL+AF0wSeQ=
=5Dyb
-----END PGP SIGNATURE-----

--------------enig4DA86FAE9C2F70BF1198AA47--
