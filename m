Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVFWCSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVFWCSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVFWCR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:17:59 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:18105 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262026AbVFWCQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:16:40 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 22 Jun 2005 19:15:34 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
In-Reply-To: <42BA19CB.4040300@opersys.com>
Message-ID: <Pine.LNX.4.62.0506221914110.16773@qynat.qvtvafvgr.pbz>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com>
 <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com>
 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>
 <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
 <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>
 <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz> <42BA0ED4.80207@opersys.com>
 <Pine.LNX.4.62.0506221821240.16773@qynat.qvtvafvgr.pbz> <42BA19CB.4040300@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Karim Yaghmour wrote:

> David Lang wrote:
>> what pinout do I need to connect the printer ports
>
> For LRTBF you'll find the pinout in the README of the package.
>
>> I'm thinking that the best approach for this would be to setup a static
>> logger and host and then one (or more) target machines, then we can setup
>> a small website on the host that will allow Ingo (and others) to submit
>> kernels for testing, queue those kernels and then run the tests on each
>> one in turn (and if it runs out of kernels to test it re-tests the last
>> one with a longer run)
>
> Things is you're going to need one logger per target. As for a
> small website, that sounds good enough. Don't know how feasible
> it would be but it may be desirable to also have a background
> task that automatically checks for new releases and conducts
> the tests automatically.

the only problem with that would be the need for these low-powered boxes 
to compile the kernel.

>> how much needs to change in userspace between the various tests? I would
>> assume that between the plain, preempt, and RT kernels no userspace
>> changes are needed, what about the other options?
>
> There are no user-space changes needed, but you may need to
> install a few things that aren't there (LMbench, LTP, hackbench,
> etc.)
>
>> given the slow speed of these systems it would seem to make more sense to
>> have a full kernel downloaded to them rather then having the local box
>> compile it.
>
> It's your choice really, but if the tests are to be automated,
> then local compile shouldn't be a problem since you won't be
> waiting on it personally.

that depends on how quickly Ingo releases updates, it would be nice to 
have a system fast enough to run the tests on each version before the next 
is released :-)

>> does this sound reasonable?
>
> For me at least.
>
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
