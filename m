Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUG0D2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUG0D2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUG0D2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:28:40 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:21432 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265930AbUG0D2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:28:38 -0400
Message-ID: <4105CBD9.7080209@yahoo.com.au>
Date: Tue, 27 Jul 2004 13:28:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
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
References: <41008386.9060009@yahoo.com.au> <20040726022202.GA21602@sgi.com> <41048324.8070302@yahoo.com.au> <200407261106.33173.jbarnes@engr.sgi.com>
In-Reply-To: <200407261106.33173.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

>On Sunday, July 25, 2004 9:05 pm, Nick Piggin wrote:
>
>>Yes of course, thank you.
>>
>>The fix is for cpu_to_phys_group() to just return cpu when
>>!CONFIG_SCHED_SMT.
>>
>
>Here's the node domain span stuff on top of your consolidation patch, along 
>with the two fixes mentioned in this thread.  It compiles and works fine on 
>my small box, but I haven't tested it on a large box yet.
>
>

You'll also want Jack Steiner's one liner. (I've sent all these to Andrew.)


Looks pretty neat. It may even be usable in the generic setup code if more
architectures start needing it.

For now, put it in your arch code when it is ready to be merged up of 
course.
I would be very interested to see what sort of performance improvements you
get out of the scheduler...


