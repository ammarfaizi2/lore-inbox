Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUGGK0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUGGK0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 06:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUGGK0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 06:26:55 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:16346 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265043AbUGGK0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:26:53 -0400
Message-ID: <40EBCFC8.7030407@kolivas.org>
Date: Wed, 07 Jul 2004 20:26:16 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Elladan <elladan@eskimo.com>
Cc: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       "'Mike Galbraith'" <efault@gmx.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum) que
 stio n
References: <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com> <20040707085923.GA29731@eskimo.com>
In-Reply-To: <20040707085923.GA29731@eskimo.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig58A5655F7EF6DC06EAAFB9D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58A5655F7EF6DC06EAAFB9D3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Elladan wrote:
> On Wed, Jul 07, 2004 at 03:59:01AM -0400, Povolotsky, Alexander wrote:
> 
>>Thanks to both of you for answering !
>>
>>
>>>The catch here is, without the preemptable kernel option, the kernel
>>>can't preempt itself, so if the first process was doing something in the
>>>kernel, there'd be a delay.  Even with the option, it can't preempt
>>>itself inside of a critical section, so there will still be a (shorter)
>>>delay.
>>
>>Yes, I am aware, - thanks to the previous answer (not included here), about
>>this Linux 2.6
>>configurable "preemptable kernel" option and was assuming it is configured
>>and in effect.
> 
> 
> Note that the preemptable kernel gives you no guarantee of latency,
> though it does reduce the average latency.  A different patch was
> constructed in the 2.4 era which attempted to provide guaranteed latency
> through a different approach (effectively, having all long-running
> operations yield).

2.6 is not that different from the lowlat patches. Note that many of 
these lock breaking points and conditional rescheduling were actually 
put into 2.5 development so are in 2.6 mainline.

Con

--------------enig58A5655F7EF6DC06EAAFB9D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA68/KZUg7+tp6mRURAoWUAJ4jtw7B1GDtG5CIPMTSbaP3LgqK3QCZAXPI
aNUCzFbEurqor3K4DMxEhAs=
=O95d
-----END PGP SIGNATURE-----

--------------enig58A5655F7EF6DC06EAAFB9D3--
