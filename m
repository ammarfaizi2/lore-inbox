Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275062AbTHGFML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275066AbTHGFML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:12:11 -0400
Received: from anumail2.anu.edu.au ([150.203.2.42]:31107 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S275062AbTHGFMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:12:10 -0400
Message-ID: <3F31DF98.6020908@cyberone.com.au>
Date: Thu, 07 Aug 2003 15:11:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Cliff White <cliffw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
References: <200308061910.h76JAYw16323@mail.osdl.org> <200308071240.54863.kernel@kolivas.org>
In-Reply-To: <200308071240.54863.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.8)
X-Spam-Tests: DATE_IN_PAST_06_12,EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Thu, 7 Aug 2003 05:10, Cliff White wrote:
>
>>>Binary searching (insert gratuitous rant about benchmarks that take more
>>>than two minutes to complete) reveals that the slowdown is due to
>>>sched-2.6.0-test2-mm2-A3.
>>>
>
>This is most likely the round robinning of tasks every 25ms. The extra 
>overhead of nanosecond timing I doubt could make that size difference (but I 
>could be wrong). There is some tweaking of this round robinning in my code 
>which may help this, but it won't bring it back up to original performance I 
>believe. Two things to try are add my patches up to O12.3int first to see how 
>much (if at all!) it helps, and change TIMESLICE_GRANULARITY in sched.c to 
>(MAX_TIMESLICE) which basically disables it completely. If there is still  a 
>drop in performance with this, the remainder is the extra locking/overhead in 
>nanosecond timing.
>
>
What is the need for this round robining? Don't processes get a calculated
timeslice anyway?


