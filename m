Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUDBIyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDBIyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:54:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61585 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263364AbUDBIyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:54:18 -0500
Message-Id: <200404020853.i328rQ303262@owlet.beaverton.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@redhat.com>, John Hawkes <hawkes@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler balancing statistics 
In-reply-to: Your message of "Fri, 02 Apr 2004 17:52:43 +1000."
             <406D1BCB.3090304@yahoo.com.au> 
Date: Fri, 02 Apr 2004 00:53:25 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From an analysis standpoint it would be nice to know which of
	the major features are being activated for a particular load.
	So imbalance-driven moves, power-driven moves, and the number of
	times each domain tried to balance and failed would all be useful.
	I think your output covered those.

    It doesn't get into the finer points of how the imbalance is derived,
    but maybe it should...

It's ok to wait and see if those are useful before implementing them. I
suspect they would be relatively easily added if they were needed.
One reason there are 6 versions of scheduler statistics is that the
information needed kept changing, both due to a better understanding of
bottlenecks and due to changing code.

    Well, every domain that is reported here will cover the entire system
    because it simply takes the sum of statistics from all domains.

I would suggest creating an output format that gives you all this
information (since we have it anyway) but I think it is quite reasonable
for the program which *interprets* this information to summarize it.

	Would you say these would be in addition to the schedstats or
	would these replace them?

    It will replace some of them, I think.

That's my thought too.	I would suggest that we merge them into one patch.
Much as I'd like to see my schedstats hit the mainline, I think it
is prudent to separate the major architectural changes sched-domains
introduces from statistics both related and unrelated to them --
and having two statistics patches for the scheduler, even if they are
complementary, makes it harder on Andrew and more confusing for users.

Rick
