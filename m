Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUGUWwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUGUWwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUGUWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:52:50 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:9137 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266607AbUGUWwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:52:39 -0400
Message-ID: <40FEF3AB.7080005@yahoo.com.au>
Date: Thu, 22 Jul 2004 08:52:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Wood <scott@timesys.com>
CC: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys>
In-Reply-To: <20040721183415.GC2206@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:
> On Wed, Jul 21, 2004 at 09:32:46PM +1000, Nick Piggin wrote:
> 
>>What do you think about deferring softirqs just while in critical
>>sections?
>>
>>I'm not sure how well this works, and it is CONFIG_PREEMPT only
>>but in theory it should prevent unbounded softirqs while under
>>locks without taking the performance hit of doing the context
>>switch.
> 
> 
> You're still running do_softirq() with preemption disabled, which is
> almost as bad as doing it under a lock.
> 

do_softirq is only run a maximum of once with preemption disabled,
instead of an unbounded number of times.
