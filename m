Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUG1BIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUG1BIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266747AbUG1BIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:08:16 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:18270 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266745AbUG1BIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:08:14 -0400
Message-ID: <4106FC7A.9010102@yahoo.com.au>
Date: Wed, 28 Jul 2004 11:08:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Dimitri Sivanich <sivanich@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] consolidate sched domains
References: <41008386.9060009@yahoo.com.au> <200407261106.33173.jbarnes@engr.sgi.com> <4105CBD9.7080209@yahoo.com.au> <200407270915.40600.jbarnes@engr.sgi.com>
In-Reply-To: <200407270915.40600.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Monday, July 26, 2004 8:28 pm, Nick Piggin wrote:
> 
>>You'll also want Jack Steiner's one liner. (I've sent all these to Andrew.)
> 
> 
> Including the consolidation patch?
> 

Yep.

> 
>>Looks pretty neat. It may even be usable in the generic setup code if more
>>architectures start needing it.
>>
>>For now, put it in your arch code when it is ready to be merged up of
>>course.
>>I would be very interested to see what sort of performance improvements you
>>get out of the scheduler...
> 
> 
> Ok, this new patch has no effect on platforms that don't define 
> ARCH_HAS_SCHED_DOMAIN, but changes the arch specific callback.  I didn't want 
> to duplicate all the code you just ripped out, but if you think that's best I 
> can...
> 

Except that architectures now can't override arch_init_sched_domains now.
Hmm.. I guess yours is the right way to go and we could put it in generic
code. Well get back to me when you have something that does the right thing
for you on your big systems.

Thanks.
