Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVAWW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVAWW6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVAWW6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:58:18 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:3768 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261371AbVAWW6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:58:06 -0500
Message-ID: <41F42BD2.4000709@kolivas.org>
Date: Mon, 24 Jan 2005 09:57:22 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87pszvlvma.fsf@sulphur.joq.us>
In-Reply-To: <87pszvlvma.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig394DAE8639A686236A1BDFB9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig394DAE8639A686236A1BDFB9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Looked at this way, there really is no question.  The new scheduler
> prototypes are falling short significantly.  Could this be due to
> their lack of priority distinctions between realtime threads?  Maybe.
> I can't say for sure.  I'll be interested to see what happens when Con
> is ready for me to try his new priority-based SCHED_ISO prototype.

There are two things that the SCHED_ISO you tried is not that SCHED_FIFO 
is - As you mentioned there is no priority support, and it is RR, not 
FIFO. I am not sure whether it is one and or the other responsible. Both 
can be added to SCHED_ISO. I haven't looked at jackd code but it should 
be trivial to change SCHED_FIFO to SCHED_RR to see if RR with priority 
support is enough or not. Second the patch I sent you is fine for 
testing; I was hoping you would try it. What you can't do with it is 
spawn lots of userspace apps safely SCHED_ISO with it - it will crash, 
but it not take down your hard disk. I've had significantly better 
results with that patch so far. Then we cn take it from there.

Cheers,
Con

--------------enig394DAE8639A686236A1BDFB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9CvUZUg7+tp6mRURAmhuAJ9qWbvi+mb34+i/Lk4UmmxojkbFFgCdGCLd
x1mB3uv9e2UZhzQM/8TY/L4=
=9xfk
-----END PGP SIGNATURE-----

--------------enig394DAE8639A686236A1BDFB9--
