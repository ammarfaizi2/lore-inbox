Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJJFRx>; Wed, 10 Oct 2001 01:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJJFRn>; Wed, 10 Oct 2001 01:17:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58538 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274774AbRJJFR2>; Wed, 10 Oct 2001 01:17:28 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
 insertion
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Rival <frival@zk3.dec.com>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF67B5934D.F6C40E7A-ON88256AE1.0019DF83@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 21:43:01 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 11:17:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The point here is that it is suprisingly that alpha needs this IPI
> unlike all other architectures. So while the IPI is certainly safe we
> wouldn't expect it to be necessary on alpha either.
>
> Now my only worry is that when you worked on this years ago with the
> alpha architects there were old chips, old caches and old machines (ev5
> maybe?).
>
> So before changing any code, I would prefer to double check with the
> current alpha architects that the read dependency really isn't enough to
> enforce read ordering without the need of rmb also on the beleeding edge
> ev6/ev67/etc.. cores. So potentially as worse we'd need to redefine
> wmb() as wmbdd() (and friends) only for EV5+SMP compiles of the kernel,
> but we wouldn't be affected with any recent hardware compiling for
> EV6/EV67.  Jay, Peter, comments?

Hello, Andrea!

This is a very good point.  I will double-check with the people I know.
I agree that it would also be very good to get an independent check.
There is clearly no use in adding expensive IPIs to the kernel except
where they are absolutely necessary!

                              Thanx, Paul

