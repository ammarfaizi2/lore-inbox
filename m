Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277413AbRJJVvd>; Wed, 10 Oct 2001 17:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277432AbRJJVvX>; Wed, 10 Oct 2001 17:51:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15790 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277413AbRJJVvN>; Wed, 10 Oct 2001 17:51:13 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Paul Mackerras <paulus@samba.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF99CB0435.488D4308-ON88256AE1.0077A859@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Wed, 10 Oct 2001 14:47:05 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/10/2001 03:51:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Oct 10, 2001 at 01:33:58PM +1000, Paul Mackerras wrote:
> > 1. Define an rmbdd() which is a no-op on all architectures except for
> >    alpha, where it is an rmb.  Richard can then have the job of
> >    finding all the places where an rmbdd is needed, which sounds like
> >    one of the smellier labors of Hercules to me. :)
>
> I don't think it's actually all that bad.  There won't be all
> that many places that require the rmbdd, and they'll pretty
> much exactly correspond to the places in which you have to put
> wmb for all architectures anyway.

Just to make sure I understand...  This rmbdd() would use IPIs to
get all the CPUs' caches synchronized, right?  Or do you have some
other trick up your sleeve?  ;-)

                              Thanx, Paul

