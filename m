Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTHOR51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTHOR51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:57:27 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50702 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270652AbTHOR5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:57:23 -0400
Message-ID: <3F3D2290.6070804@techsource.com>
Date: Fri, 15 Aug 2003 14:12:32 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <20030814070119.GN32488@holomorphy.com> <3F3BEA65.8080907@techsource.com> <200308160238.05185.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> On Fri, 15 Aug 2003 06:00, Timothy Miller wrote:
> 
>>If my guess from my previous email was correct (that is pri 5 gets
>>shorter timeslide than pri 6), then that means that tasks of higher
>>static priority have are penalized more than lower pri tasks for expiring.
>>
>>Say a task has to run for 15ms.  If it's at a priority that gives it a
>>10ms timeslice, then it'll expire and get demoted.  If it's at a
>>priority that gives it a 20ms timeslice, then it'll not expire and
>>therefore get promoted.
>>
>>Is that fair?
> 
> 
> Yes, it's a simple cutoff at the end of the timeslice. If you use up the 
> timeslice allocated to you, then you have to pass a test to see if you can go 
> onto the active array or get expired. Since higher static priority (lower 
> nice) tasks get longer timeslices, they are less likely to expire unless they 
> are purely cpu bound and never sleep.


Ok, I'm just a little confused, because of this inversion of "high 
priority" with "low numbers".

First, am I correct in understanding that a lower number means a higher 
priority?

And for a higher priority, in addition to begin run before all tasks of 
lower priority, they also get a longer timeslice?


