Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUHZLOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUHZLOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHZLLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:11:35 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:56730 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268727AbUHZLIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:08:22 -0400
Message-ID: <412DC47B.4000704@kolivas.org>
Date: Thu, 26 Aug 2004 21:07:39 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org>
In-Reply-To: <20040826014745.225d7a2c.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92489D505188B8769AD7920D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92489D505188B8769AD7920D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
> 
> 
> - nicksched is still here.  There has been very little feedback, except that
>   it seems to slow some workloads on NUMA.

That's because most people aren't interested in a new cpu scheduler for
2.6. The current one works well enough in most situations and people
aren't trying -mm to fix their interactive problems since they are few
and far between. The only reports about adverse behaviour with 2.6 we 
track down to "It behaves differently to what I expect" or applications 
with no (b)locking between threads suck under load. Personally I think 
the latter is a good thing as it encourages better coding, and the 
former is something we'll have with any alternate design.

The only feedback we got on staircase was that it helped NUMA somewhat 
and Nick and Ingo made some criticisms (not counting any benchmarks I 
had to offer). The only feedback on nickshed was that it hurt NUMA 
somewhat, SMT interactivity was broken (an easy enough oversight), and I 
did not comment to avoid giving biased criticism.

If you're after subjective performance feedback you're less likely to 
get it now than ever since you've made a strong stance against 
subjective reports, due to placebo effect. LKML is scary enough for the 
average user already. We have a situation now that if one brave single 
user reports good or bad behaviour everyone runs off that one user's 
report. Ouch!

There isn't going to be a 2.7 any time soon and there are people that 
are using alternate schedulers already in production; which is obviously 
why you're giving them a test run in -mm. Clearly the lack of a formal 
(2.7) development branch makes this even harder. Your attempt at 
preventing "good stuff' from rotting in alternate trees when mainline 
should be benefitting is admirable. While it's fun to rewrite the 
scheduler and gives us something to play with, the current level of 
feedback is hardly the testbase off which to replace it unless there's 
something strikingly better about a new cpu scheduler.

It will be interesting to see if this spawns any further discussion or 
whether Peter's scheduler's performance will also be lost in a low 
signal to noise ratio when it gets a run in -mm.

Cheers,
Con

--------------enig92489D505188B8769AD7920D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLcR+ZUg7+tp6mRURAjf2AJ9mGHUho2UEQV6FARViD8nHMt+hLgCfb+ap
I8D15zV0LXvFWKUnau58jPc=
=NlB1
-----END PGP SIGNATURE-----

--------------enig92489D505188B8769AD7920D--
