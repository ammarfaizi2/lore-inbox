Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTHLOuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTHLOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:50:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:29194 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270384AbTHLOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:50:25 -0400
Message-ID: <3F39020C.6040408@techsource.com>
Date: Tue, 12 Aug 2003 11:04:44 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: rob@landley.net, Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net> <3F382B8B.9000301@techsource.com> <20030812001759.GS1715@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

> 
> Guys, it's _way_ premature to say any of this. AFAICT _no_ alternatives
> to the duelling queues with twiddled priorities have been explored yet,
> nor has the maximum been squeezed out of twiddling the methods for
> priority adjustment in that yet (which is Con Kolivas' area).
> 


Ok... this reminds me that there is an aspect of all of this that I 
don't understand.  Please pardon my ignorance.  And furthermore, if 
there is some document which answers all of my questions, please direct 
me to it so I don't waste your time.



I understand that the O(1) scheduler uses two queues.  One is the active 
queue, and the other is the expired queue.  When a process has exhausted 
its timeslice, it gets put into the expired queue (at the end, I 
presume).  If not, it gets put into the active queue.

Is this the vanilla scheduler?

One thing I don't understand is, for a given queue, how do priorities 
affect running of processes?  Two possibilities come to mind:

1) All pri 10 processes will be run before any pri 11 processes.
2) A pri 10 process will be run SLIGHTLY more often than a pri 11 process.

For the former, is the active queue scanned for runnable processes of 
the highest priority?  If that's the case, why not have one queue for 
each priority level?  Wouldn't that reduce the amount of scanning 
through the queue?

What it comes down to that I want to know is if priorities affect 
running of processes linearly or exponentially.

How do nice levels affect priorities?  (Vanilla and interactive)

How do priorities affect processes in the expired queue?

In the vanilla scheduler, can a low enough nice value keep an expired 
process off the expired queue?  How is that determined?

Does the vanilla scheduler have priorities?  If so, how are they determined?


Thanks.

