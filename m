Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUKHU35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUKHU35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKHU35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:29:57 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:30340 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261198AbUKHU3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:29:54 -0500
Message-ID: <418FD73A.2040505@kolivas.org>
Date: Tue, 09 Nov 2004 07:29:46 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Warren <SWarren@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR and kernel threads
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F094@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B002A7F094@hqemmail02.nvidia.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig482309B7F27828D8103B326A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig482309B7F27828D8103B326A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Warren wrote:
> Hello.
> 
> We have an application that is running on kernel 2.6.9. This application
> makes use of real-time threads, namely using the SCHED_RR policy.
> 
> It appears that during times of high application CPU usage, some
> *kernel* threads don't get to run. As an example, this means that local
> keyboard presses aren't processed (or are processed very slowly) by the
> kernel, so our application never sees them. This has the effect of
> hanging the system, since the way to get out of the higher CPU usage
> portion of the application is to press the ESC key, and our application
> never sees that keypress.
> 
> This appears to be due to the fact that the kernel threads are all
> SCHED_OTHER, so our SCHED_RR user-space application trumps them!

Don't run your userspace at SCHED_RR? The kernel threads are 
SCHED_NORMAL precisely for the reason that you wont get real time 
performance if the kernel threads rear their ugly heads, albeit rarely.

Cheers,
Con

--------------enig482309B7F27828D8103B326A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj9c9ZUg7+tp6mRURAhiaAJ45pttDMjRiKRTkboIFdRY8mnvgHACcD/Ik
UcR6RSJJ+3WNOJCNhEJ9qbA=
=ymzm
-----END PGP SIGNATURE-----

--------------enig482309B7F27828D8103B326A--
