Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUGJBAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUGJBAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUGJBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:00:48 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:13244 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266013AbUGJBAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:00:46 -0400
Message-ID: <40EF3FAA.5000907@kolivas.org>
Date: Sat, 10 Jul 2004 11:00:26 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu>
In-Reply-To: <20040709182638.GA11310@elte.hu>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig253EC76B800EAF7B7A2A034E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig253EC76B800EAF7B7A2A034E
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> as most of you are probably aware of it, there have been complaints on
> lkml that the 2.6 kernel is not suitable for serious audio work due to
> high scheduling latencies (e.g. the Jackit people complained). I took a
> look at latencies and indeed 2.6.7 is pretty bad - latencies up to 50
> msec (!) can be easily triggered using common workloads, on fast 2GHz+
> x86 system - even when using the fully preemptible kernel!
> 
> to solve this problem, Arjan van de Ven and I went over various kernel
> functions to determine their preemptability and we re-created from
> scratch a patch that is equivalent in performance to the 2.4 lowlatency
> patches but is different in design, impact and approach:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-bk20-H2

Looks nice.

I think you may have mixed up your trees. I think this change is the cfq 
bad allocation fix which I dont think is part of your voluntary 
preemption patch:

--- linux/drivers/block/cfq-iosched.c.orig	
+++ linux/drivers/block/cfq-iosched.c	

Otherwise, cheers! I'll give it a bit of a run and see what numbers come up.

Con

--------------enig253EC76B800EAF7B7A2A034E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7z+qZUg7+tp6mRURAkDOAJ9UOb3tSIRUwQFY8n83gkv/TYQbjwCeIkYv
uNcLaxXWdcbV7ieYc7m5duk=
=ZKOb
-----END PGP SIGNATURE-----

--------------enig253EC76B800EAF7B7A2A034E--
