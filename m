Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVBKGeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVBKGeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVBKGeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:34:22 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:53724 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S262195AbVBKGeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:34:16 -0500
Message-ID: <420C51DF.3000707@bigpond.net.au>
Date: Fri, 11 Feb 2005 17:34:07 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       rlrevell@joe-job.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
References: <200502110341.j1B3fS8o017685@localhost.localdomain> <1108098286.5098.41.camel@npiggin-nld.site>
In-Reply-To: <1108098286.5098.41.camel@npiggin-nld.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> On Thu, 2005-02-10 at 22:41 -0500, Paul Davis wrote:
> 
>>  [ the best solution is .... ]
>>
>>  [ my preferred solution is ... ]
>>
>>  [ it would be better if ... ]
>>
>>  [ this is a kludge and it should be done instead like ... ]
>>
>>did nobody read what andrew wrote and what JOQ pointed out?
>>
>>after weeks of debating this, no other conceptual solution emerged
>>that did not have at least as many problems as the RT LSM module, and
>>all other proposed solutions were also more invasive of other aspects
>>of kernel design and operations than RT LSM is.
>>
> 
> 
> Sure, it is quick and easy. Suits some. At least I do prefer
> this to altering the semantics of realtime scheduling.
> 
> I can't say much about it because I'm not putting my hand up to
> do anything. Just mentioning that rlimit would be better if not
> for the userspace side of the equation. I think most were already
> agreed on that point anyway though.

I think that the rlimits are a good idea in themselves but not as a 
solution to this problem.  I.e. having a RT CPU rate rlimit should not 
be a sufficient (or necessary for that matter) condition to change 
policy to SCHED_OTHER or SCHED_RR but could still be used to limit the 
possibility of lock out.  (But I guess even that is a violation of RT 
semantics?)

Peter
PS Zaphod's per task hard/soft CPU rate caps (which are the equivalent 
of an rlimit on CPU usage rate) are only enforced for SCHED_NORMAL tasks 
and should not (therefore) effect RT semantics.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
