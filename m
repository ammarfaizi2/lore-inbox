Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbUDBKCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUDBKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:02:17 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:34403 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263511AbUDBKCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:02:15 -0500
Message-ID: <406D3985.5000008@yahoo.com.au>
Date: Fri, 02 Apr 2004 19:59:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>, John Hawkes <hawkes@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler balancing statistics
References: <200404020853.i328rQ303262@owlet.beaverton.ibm.com>
In-Reply-To: <200404020853.i328rQ303262@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> 	From an analysis standpoint it would be nice to know which of
> 	the major features are being activated for a particular load.
> 	So imbalance-driven moves, power-driven moves, and the number of
> 	times each domain tried to balance and failed would all be useful.
> 	I think your output covered those.
> 
>     It doesn't get into the finer points of how the imbalance is derived,
>     but maybe it should...
> 
> It's ok to wait and see if those are useful before implementing them. I
> suspect they would be relatively easily added if they were needed.
> One reason there are 6 versions of scheduler statistics is that the
> information needed kept changing, both due to a better understanding of
> bottlenecks and due to changing code.
> 

Yep.

>     Well, every domain that is reported here will cover the entire system
>     because it simply takes the sum of statistics from all domains.
> 
> I would suggest creating an output format that gives you all this
> information (since we have it anyway) but I think it is quite reasonable
> for the program which *interprets* this information to summarize it.
> 

OK, yeah that is a fine idea.

> 	Would you say these would be in addition to the schedstats or
> 	would these replace them?
> 
>     It will replace some of them, I think.
> 
> That's my thought too.	I would suggest that we merge them into one patch.
> Much as I'd like to see my schedstats hit the mainline, I think it
> is prudent to separate the major architectural changes sched-domains
> introduces from statistics both related and unrelated to them --
> and having two statistics patches for the scheduler, even if they are
> complementary, makes it harder on Andrew and more confusing for users.
> 

No, I started with your sources, and the plan has always
been to merge my changes back to you where possible.
