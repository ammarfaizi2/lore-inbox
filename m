Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCPQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCPQEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:04:55 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:59665 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263309AbUCPQEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:04:31 -0500
Message-ID: <40572922.10109@techsource.com>
Date: Tue, 16 Mar 2004 11:19:46 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
References: <40571A62.8050204@techsource.com> <20040316154611.GA31510@mulix.org>
In-Reply-To: <20040316154611.GA31510@mulix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Muli Ben-Yehuda wrote:
> On Tue, Mar 16, 2004 at 10:16:50AM -0500, Timothy Miller wrote:
> 
> 
>>This way, after gcc has run a few times, it'll be flagged as a CPU-bound 
>>process and every time it's run after that point, it is always run at an 
>>appropriate priority.  Similarly, the first time xmms is run, its 
>>interactivity estimate won't be right, but after it's determined to be 
>>interactive, then the next time the program is launched, it STARTS with 
>>an appropriate priority:  no ramp-up time.
> 
> 
> This is something that I've thought of doing in the past. The reason I
> didn't pursue it further is that it's impossible to get it right for
> all cases, and it attacks the problem in the wrong place. The kernel
> shouldn't need to guess(timate) what the process is going to do. The
> userspace programmer, who knows what his process is going to do,
> should tell the kernel. 

I agree... somewhat.  It would be nice if we could trust every program 
to always do the right thing, always accurately indicate its priority, 
and always yield the CPU at the best time.  But if that were reality, 
we'd still be using cooperative multitasking.

Unfortunately, the OS has to play babysitter to processes, because 
they're guaranteed to misbehave.  Preemption exists to ensure fairness 
amongst processes.  Thus, while you're right that it would be nice to 
have processes report their CPU requirements, if we were to actually DO 
that, it would be a disaster.


