Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275434AbTHNTnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275436AbTHNTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:43:00 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:53255 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275434AbTHNTm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:42:56 -0400
Message-ID: <3F3BE9BD.20304@techsource.com>
Date: Thu, 14 Aug 2003 15:57:49 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: William Lee Irwin III <wli@holomorphy.com>, rob@landley.net,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F3A5D61.7080207@techsource.com> <20030814060959.GK32488@holomorphy.com> <200308141659.33447.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> On Thu, 14 Aug 2003 16:09, William Lee Irwin III wrote:
> 
>>William Lee Irwin III wrote:
> 
> 
>>"scale" on which scheduling events should happen, and as tasks become
>>more cpu-bound, they have longer timeslices, so that two cpu-bound
>>tasks of identical priority will RR very slowly and have reduced
>>context switch overhead, but are near infinitely preemptible by more
>>interactive or short-running tasks.
> 
> 
> Actually the timeslice handed out is purely dependent on the static priority, 
> not the priority it is elevated or demoted to by the interactivity estimator. 
> However lower priority tasks (cpu bound ones if the estimator has worked 
> correctly) will always be preempted by higher priority tasks (interactive 
> ones) whenever they wake up.


Ok, so tasks at priority, say, 5 are all run before any tasks at 
priority 6, but when a priority 6 task runs, it gets a longer timeslice?

How much longer?


