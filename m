Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268017AbUHKKYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268017AbUHKKYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHKKYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:24:32 -0400
Received: from imap.gmx.net ([213.165.64.20]:48049 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268017AbUHKKY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:24:29 -0400
X-Authenticated: #4512188
Message-ID: <4119F3D9.7040708@gmx.de>
Date: Wed, 11 Aug 2004 12:24:25 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: spaminos-ker@yahoo.com, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
         others)
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org>
In-Reply-To: <cone.1092193795.772385.25569.502@pc.kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| I tried this on the latest staircase patch (7.I) and am not getting any
| output from your script when tested up to 60 threads on my hardware. Can
| you try this version of staircase please?
|
| There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
|
| http://ck.kolivas.org/patches/2.6/2.6.8/

Hi,

I just updated to 2.6.8-rc4-ck2 and tried the two options interactive
and compute. Is the compute stuff functional? I tried setting it to 1
within X and after that X wasn't usable anymore (meaning it looked like
locked up, frozen/gone mouse cursor even). I managed to switch back to
console and set it to 0 and all was OK again.

The interactive to 0 setting helped me with runnign locally multiple
processes using mpi. Nevertheless (only with interactive 1 regression to
vanilla scheduler, else same) can't this be enhanced?

Details: I am working on a load balancing class using mpi. For testing
purpises I am running multiple processes on my machine. So for a given
problem I can say, it needs x time to solve. Using more processes opn a
single machine, this time (except communication and balancing overhead)
shouldn't be much larger. Unfortunately this happens. Eg. a given
probelm using two processes needs about 20 seconds to finish. But using
8 it already needs 47s (55s with interactiv set to 1). No, my balancing
framework is quite good. On a real (small, even larger till 128 nodes
tested) cluster overhead is just as low as 3% to 5%, ie. it scales quite
linearly.

Any idea how to tweak the staircase to get near the 20 seconds with more
processes? Or is this rather a problem of mpich used locally?

If you like I can send you my code to test (beware it is not that small).

Cheers,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGfPZxU2n/+9+t5gRApa1AJ9j82Aujwj/IoGLqvDsX29y/dLu/wCglvse
bRV6zeWc+6z+ETl9Hxqleho=
=Jay6
-----END PGP SIGNATURE-----
