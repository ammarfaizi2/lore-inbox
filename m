Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUHKL0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUHKL0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKL0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:26:48 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:5769 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268028AbUHKL01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:26:27 -0400
Message-ID: <411A024B.6060100@kolivas.org>
Date: Wed, 11 Aug 2004 21:26:03 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org> <4119F3D9.7040708@gmx.de>
In-Reply-To: <4119F3D9.7040708@gmx.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95D1C2153158E808A3730D33"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95D1C2153158E808A3730D33
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam wrote:
> Con Kolivas wrote:
> | I tried this on the latest staircase patch (7.I) and am not getting any
> | output from your script when tested up to 60 threads on my hardware. Can
> | you try this version of staircase please?
> |
> | There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
> |
> | http://ck.kolivas.org/patches/2.6/2.6.8/
> 
> Hi,
> 
> I just updated to 2.6.8-rc4-ck2 and tried the two options interactive
> and compute. Is the compute stuff functional? I tried setting it to 1
> within X and after that X wasn't usable anymore (meaning it looked like
> locked up, frozen/gone mouse cursor even). I managed to switch back to
> console and set it to 0 and all was OK again.

Compute is very functional. However it isn't remotely meant to be run on 
a desktop because of very large scheduling latencies (on purpose).

> The interactive to 0 setting helped me with runnign locally multiple
> processes using mpi. Nevertheless (only with interactive 1 regression to
> vanilla scheduler, else same) can't this be enhanced?

I don't understand your question. Can what be enhanced?

> Details: I am working on a load balancing class using mpi. For testing
> purpises I am running multiple processes on my machine. So for a given
> problem I can say, it needs x time to solve. Using more processes opn a
> single machine, this time (except communication and balancing overhead)
> shouldn't be much larger. Unfortunately this happens. Eg. a given
> probelm using two processes needs about 20 seconds to finish. But using
> 8 it already needs 47s (55s with interactiv set to 1). No, my balancing
> framework is quite good. On a real (small, even larger till 128 nodes
> tested) cluster overhead is just as low as 3% to 5%, ie. it scales quite
> linearly.

Once again I dont quite understand you. Are you saying that there is 
more than 50% cpu overhead when running 8 processes? Or that the cpu is 
distributed unfairly such that the longest will run for 47s?

> Any idea how to tweak the staircase to get near the 20 seconds with more
> processes? Or is this rather a problem of mpich used locally?

Compute mode is by far the most scalable mode in staircase for purely 
computational tasks. The cost is that of interactivity; it is bad on 
purpose since it is a no-compromise maximum cpu cache utilisation policy.

> If you like I can send you my code to test (beware it is not that small).
> 
> Cheers,
> 
> Prakash

Cheers,
Con

--------------enig95D1C2153158E808A3730D33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGgJOZUg7+tp6mRURAo6/AKCHHpsTye8ASdFafRQuXhgxsDx/mQCfcexP
21SXFLTjrVJn/lCQJmc/aUU=
=UsyH
-----END PGP SIGNATURE-----

--------------enig95D1C2153158E808A3730D33--
