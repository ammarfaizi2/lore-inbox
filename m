Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUKCJVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUKCJVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUKCJTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:19:11 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:43167 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261540AbUKCJQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:16:56 -0500
Message-ID: <4188A1F2.6000409@kolivas.org>
Date: Wed, 03 Nov 2004 20:16:34 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu> <4187854C.6000803@kolivas.org> <20041102131105.GA17535@elte.hu> <41878E47.5090805@kolivas.org> <20041102135220.GA20237@elte.hu>
In-Reply-To: <20041102135220.GA20237@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8C921E72542C99D98FD0E91"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8C921E72542C99D98FD0E91
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> SCHED_ISO would be interesting, 

Cool! I've been toying with this too :)

> but all SCHED_BATCH patches that i've
> seen so far were fundamentally broken. [ none protects against the
> possibility of a simple CPU hog starving a SCHED_BATCH task in kernel
> mode holding say /home's i_sem forever. None except the one i wrote a
> couple of years ago that is ;-) ]

I guess the one I wrote for staircase is inadequate too. Although in the 
field the implementation has been safe as far as I can tell.

I'm thinking of holding off for a bit to allow those current changes to 
be tried in -mm for a bit.

I have two more questions - there are already userspace tools and older 
out-of-tree kernels (inluding my current one) that use SCHED_BATCH and 
SCHED_ISO.

Should we respect the values for these policies and use numbering 
consistent with them (meaning SCHED_BATCH at 3 would be reserved but not 
used) or should we dish out values according to when they're implemented 
and demand userspace be updated.

Should we move to a policy bitmask numbering system and/or make 
SCHED_CPUBOUND, SCHED_ISO etc subpolicies of SCHED_NORMAL?

Regards,
Con

--------------enigB8C921E72542C99D98FD0E91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiKHyZUg7+tp6mRURAm2fAJ0ZiaHl8JsPIl3UX52LwZzfp454JwCfSjh/
L+AGAkhprUV3SH5JS5+iHtQ=
=ZVDG
-----END PGP SIGNATURE-----

--------------enigB8C921E72542C99D98FD0E91--
