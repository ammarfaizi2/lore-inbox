Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUA3PF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUA3PF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:05:57 -0500
Received: from integer.pobox.com ([208.58.1.194]:16029 "EHLO integer.pobox.com")
	by vger.kernel.org with ESMTP id S261681AbUA3PFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:05:52 -0500
From: "Dave Paris" <dparis@w3works.com>
To: <linux-kernel@vger.kernel.org>
Cc: <rspchan@starhub.net.sg>
Subject: RE: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Date: Fri, 30 Jan 2004 10:04:00 -0500
Message-ID: <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Xine.LNX.4.44.0401300939070.15830-100000@thoron.boston.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has this been demonstrated on *any* system/arch using GCC 3.2.3 (or other
3.2 series) or is it limited in scope to the description below?  Does it
seem to do this with other implementations (other than sha256.c) or other
kernels?  Just trying to get an idea if this is a complier optimization bug
or something much more limited in scope.

My personal lab is currently being unboxed and I won't be able to run my own
tests for another week or so.  (apologies in advance)

In any case, this is *extremely* serious from a number of angles.

Kind Regards,
-dsp

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of James Morris
Sent: Friday, January 30, 2004 9:40 AM
To: R CHAN
Cc: linux-kernel@vger.kernel.org; David S. Miller
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch
pentium3,4


On Fri, 30 Jan 2004, R CHAN wrote:

> 2.6.2-rc2 sha256.c is miscompiled with gcc 3.2.3.
> (User space is RedHat 3ES.)
>
> Just an observation:
>
> gcc 3.2.3 is miscompiling sha256.c when using
> -O2 -march=pentium3
> or pentium4.
>
> gcc 3.3.x is ok, or the problem disappears
> if I use arch=i686 or reduce the optimisation level to -O2.
>
> Sympthoms are all the sha256 test vectors fail.
> If I extract the guts of the file to compile in user space
> the same problem occurs.

Have you noticed if this happens for any of the other crypto algorithms?



- James
--
James Morris
<jmorris@redhat.com>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



