Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUHDVJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUHDVJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267428AbUHDVJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:09:11 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:24725 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267427AbUHDVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:07:54 -0400
Message-ID: <4111500E.90304@kolivas.org>
Date: Thu, 05 Aug 2004 07:07:26 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Nathan Lynch <nathanl@austin.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, V Srivatsa <vatsa@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
References: <20040802094907.GA3945@in.ibm.com>  <20040802095741.GA4599@in.ibm.com>  <1091475519.29556.4.camel@pants.austin.ibm.com>  <1091478386.29556.36.camel@pants.austin.ibm.com> <1091567239.28036.36.camel@biclops.private.network> <Pine.LNX.4.58.0408041048350.19619@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0408041048350.19619@montezuma.fsmlabs.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig53CC68D2DA4E72CF383A44CC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53CC68D2DA4E72CF383A44CC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Zwane Mwaikambo wrote:
> On Tue, 3 Aug 2004, Nathan Lynch wrote:
> 
> 
>>                __setscheduler(rq->idle, SCHED_NORMAL, 0);
>>                task_rq_unlock(rq, &flags);
>>                BUG_ON(rq->nr_running != 0);
>>
>>I can reproduce this on both ppc64 and i386.  Does anyone know why this
>>is happening?
>>
>>If I remove the BUG_ON, things seem to go ok, but I doubt that's the
>>right thing to do.
> 
> 
> It could have something to do with the staircase scheduler, Con, got any
> wise words?

Doesn't this bug report say 2.6.8-rc2? It's mm2 that has staircase.

Con

--------------enig53CC68D2DA4E72CF383A44CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBEVATZUg7+tp6mRURAjXwAJ9gTem5CuUSZ6E6kNRk5Nd+H5BaTwCeIGx3
J9lTdYce8XsSNzOt8KEhYCE=
=svYv
-----END PGP SIGNATURE-----

--------------enig53CC68D2DA4E72CF383A44CC--
