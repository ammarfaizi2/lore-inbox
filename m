Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJJCBr>; Tue, 9 Oct 2001 22:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273818AbRJJCBh>; Tue, 9 Oct 2001 22:01:37 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:51752 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273783AbRJJCBX>; Tue, 9 Oct 2001 22:01:23 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@ufl.edu>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110100036.UAA128640@ufl.edu>
In-Reply-To: <200110100036.UAA128640@ufl.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 22:02:36 -0400
Message-Id: <1002679359.862.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 20:36, safemode wrote:
> I'm very pleased so far with ac10 with the preempt patch.  Much better than
> 2.4.9-ac18-preempt, which is what i was using.  I'm just going to put up some
> output from lmbench to see if anyone who is running the non-preempt version
> is seeing better or worse timings and scores.   Perhaps the improvement is
> all in my head due to me moving my atapi devices off of the promise card
> (since you're not supposed to put any on it) and now everything is generally
> running faster despite the kernel being used.  Heh.  so here they are

I've noticed good improvements on 2.4.10-ac10, too.  You may want to try
Rik's eatcache patch available at
http://www.surriel.com/patches/2.4/2.4.10-ac9-eatcache - It does a
noticeable job of preventing the cache thrashing that occurs during
heavy cache activity.  This will result in less VM activity, hopefully,
and thus less lock held time.  He can use the feedback to tune it
better.

Also, you will really want to run lmbench on 2.4.10-ac10-nopreempt
yourself.  While a lot of lmbench is pretty kernel-specific
machine-agnostic, a faster MHz CPU will certainly change almost every
result.

	Robert Love

