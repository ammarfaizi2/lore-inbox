Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVEDAnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEDAnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVEDAnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:43:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:32870 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261877AbVEDAnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:43:52 -0400
Message-ID: <42781AC5.1000201@yahoo.com.au>
Date: Wed, 04 May 2005 10:43:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] how do we move the VM forward? (was Re: [RFC] cleanup of
 use-once)
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com> <42771904.7020404@yahoo.com.au> <Pine.LNX.4.61.0505030913480.27756@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0505030913480.27756@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 3 May 2005, Nick Piggin wrote:
> 
>> I think the biggest problem with our twine and duct tape page reclaim
>> scheme is that somehow *works* (for some value of works).
> 
> 
>> I think we branch a new tree for all interested VM developers to work
>> on and try to get performing well. Probably try to restrict it to page
>> reclaim and related fundamentals so it stays as small as possible and
>> worth testing.
> 
> 
> Sounds great.  I'd be willing to maintain a quilt tree for
> this - in fact, I've already got a few patches ;)
> 

OK I'll help maintain and review patches.

Also having a box or two for running regression and stress
testing is a must. I can do a bit here, but unfortunately
"kernel compiles until it hurts" is probably not the best
workload to target.

In general most systems and their workloads aren't constantly
swapping, so we should aim to minimise IO for normal
workloads. Databases that use the pagecache (eg. postgresql)
would be a good test. But again we don't want to focus on one
thing.

That said, of course we don't want to hurt the "really
thrashing" case - and hopefully improve it if possible.

> Also, we should probably keep track of exactly what we're
> working towards.  I've put my ideas on a wiki page, feel
> free to add yours - probably a new page for stuff that's
> not page replacement related ;)
> 

I guess some of those page replacement algorithms would be
really interesting to explore - and we definitely should be
looking into them at some stage as part of our -vm tree.

Though my initial aims are to first simplify and rationalise
and unify things where possible.

NUMA "issues" related to page reclaim are also interesting to
me.

I'll try to get some time to get my patches into shape in the
next week or so.

-- 
SUSE Labs, Novell Inc.

