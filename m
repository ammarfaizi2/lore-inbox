Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVFWCCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVFWCCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVFWB7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:59:43 -0400
Received: from opersys.com ([64.40.108.71]:4627 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261933AbVFWB6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:58:24 -0400
Message-ID: <42BA19CB.4040300@opersys.com>
Date: Wed, 22 Jun 2005 22:09:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com> <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz> <42BA0ED4.80207@opersys.com> <Pine.LNX.4.62.0506221821240.16773@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0506221821240.16773@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang wrote:
> what pinout do I need to connect the printer ports

For LRTBF you'll find the pinout in the README of the package.

> I'm thinking that the best approach for this would be to setup a static 
> logger and host and then one (or more) target machines, then we can setup 
> a small website on the host that will allow Ingo (and others) to submit 
> kernels for testing, queue those kernels and then run the tests on each 
> one in turn (and if it runs out of kernels to test it re-tests the last 
> one with a longer run)

Things is you're going to need one logger per target. As for a
small website, that sounds good enough. Don't know how feasible
it would be but it may be desirable to also have a background
task that automatically checks for new releases and conducts
the tests automatically.

> how much needs to change in userspace between the various tests? I would 
> assume that between the plain, preempt, and RT kernels no userspace 
> changes are needed, what about the other options?

There are no user-space changes needed, but you may need to
install a few things that aren't there (LMbench, LTP, hackbench,
etc.)

> given the slow speed of these systems it would seem to make more sense to 
> have a full kernel downloaded to them rather then having the local box 
> compile it.

It's your choice really, but if the tests are to be automated,
then local compile shouldn't be a problem since you won't be
waiting on it personally.

> does this sound reasonable?

For me at least.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
