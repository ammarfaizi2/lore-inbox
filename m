Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbULTIU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbULTIU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULTIT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:19:58 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:57790 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261255AbULTIEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:04:39 -0500
Message-ID: <41C6876D.7070702@kolivas.org>
Date: Mon, 20 Dec 2004 19:03:57 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lista4@comhem.se,
       linux-kernel@vger.kernel.org, mr@ramendik.ru, riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au>
In-Reply-To: <41C682F1.20200@yahoo.com.au>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4CCC2E989C6B9A72BA1321B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4CCC2E989C6B9A72BA1321B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> Voluspa <lista4@comhem.se> wrote:
>>
>>> Would be nice though if someone else could verify...
>>
>>
>>
>> Well I'd love to, but afaik the only workloads which we currently know of
>> involve complex userspace apps which I have no experience running.
>>
>> Did anyone come up with a simple step-by-step procedure for 
>> reproducing the
>> problem?  It would be good if someone could do this, because I don't 
>> think
>> we understand the root cause yet?
>>
> 
> I admit to generally being in the same boat as you with respect to
> running complex userspace apps.
> 
> However, based on this and other scattered reports, I'd say it seems
> quite likely that token based thrashing control is the culprit. Based
> on the cost/benefit, I wonder if we should disable TBTC by default for
> 2.6.10, rather than trying to fix it, and try again for 2.6.11?
> 
> Rik? Andrew?
> 
> Also, it would be nice to have a sysctl to *completely* disable TBTC,
> that would make testing easier.

Logistically what makes sense is if a timeout of 0 is used as a test 
that completely disables it (avoids another sysctl too). In time for 
2.6.10 we should disable it by default until the regressions are better 
understood. Tuning it into a useful "on" position can happen later and I 
suspect requires more code.

Con

--------------enigA4CCC2E989C6B9A72BA1321B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxoduZUg7+tp6mRURAmP4AJ9Pk6TDrMxvME80ovsSsnQZzgzu1gCfTaRE
AfJS1OG61InPZi5WyMPZp+g=
=6Twx
-----END PGP SIGNATURE-----

--------------enigA4CCC2E989C6B9A72BA1321B--
