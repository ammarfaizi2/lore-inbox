Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUGGNpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUGGNpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUGGNpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:45:33 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:28566 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264934AbUGGNpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:45:30 -0400
Message-ID: <40EBFE72.7050908@kolivas.org>
Date: Wed, 07 Jul 2004 23:45:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>
Subject: Staircase cpu scheduler and -ck updates
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D5D5C079A3433DC9DC3DF1A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D5D5C079A3433DC9DC3DF1A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

A tiny SCHED_FIFO microoptimisation and comments changes make up the 
staircase7.9 patch. I doubt anyone will notice any difference, but this 
shows the relative stability/maturity of the scheduler now. Patches for 
vanilla, 2.6.7-bk20 and 2.6.7-mm6 are available. The sched batch (idle 
scheduling) and sched iso (soft real time scheduling) policies are also 
available, stable and ready for prime time testing.

The sched batch and sched iso policies have been updated slightly. The 
sched batch implementation should be safe for disk intensive loads while 
still minimising it's cpu usage as much as possible.

I've resynced with 2.6.7-bk20 as the bk19 introduced the security fixes 
so if you feel you need the security updates you should move to this 
snapshot.

There was a small cfq bug Jens has just addressed and I've added the 
incremental fix to that in the ck-dev, mm6 and bk20 snapshots. If you 
use cfq (ck does by default) it is probably worth applying this fix.

Kernel homepage here:
http://kernel.kolivas.org

Patches available here:
http://ck.kolivas.org/patches/2.6/2.6.7/

Cheers,
Con

--------------enig2D5D5C079A3433DC9DC3DF1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA6/5yZUg7+tp6mRURAm7JAJ9SquSWLmTvmn8SFtRhG9xFen9RbACeLryV
0LVG32Oxpllpbx3/i/dp1P0=
=wIx1
-----END PGP SIGNATURE-----

--------------enig2D5D5C079A3433DC9DC3DF1A--
