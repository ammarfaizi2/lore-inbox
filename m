Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUGJPMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUGJPMx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUGJPMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:12:53 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:2542 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266284AbUGJPMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:12:51 -0400
Message-ID: <40F0075C.2070607@kolivas.org>
Date: Sun, 11 Jul 2004 01:12:28 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu>
In-Reply-To: <20040710124814.GA27345@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig716F2272FD1B1949B88F87A1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig716F2272FD1B1949B88F87A1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've conducted some of the old fashioned Benno's latency test on this 
patch in various sysctl configurations. This was done on top of a 
different tree but everything else was kept static. I have to preface 
these results by saying I don't really get the 50ms size latencies 
normally but I'm usually unable to get better than 3ms so I wasn't sure 
what to expect.

Only the both preempt off showed any "outlying" results with one spike 
of ~20ms but the rest of the time being ~3ms. Enabling both forms of 
preempt seemed to help a little but nothing drastic, and never below 
1ms. It was not universal that the latencies were better, but there was 
a trend towards better latency. I suspect that those who are getting 
huge latencies may see a bigger change with this patch than I did.

http://ck.kolivas.org/latency/

Con

--------------enig716F2272FD1B1949B88F87A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8AdgZUg7+tp6mRURAoDbAJ4jShS/xYL4Zslpl9plqS2metWl9gCfSpDI
HV5m8tq2mCXcDjacPdAwM+A=
=xAsE
-----END PGP SIGNATURE-----

--------------enig716F2272FD1B1949B88F87A1--
