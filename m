Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUHXXFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUHXXFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269108AbUHXXFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:05:11 -0400
Received: from gizmo06ps.bigpond.com ([144.140.71.41]:32192 "HELO
	gizmo06ps.bigpond.com") by vger.kernel.org with SMTP
	id S269098AbUHXXEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:04:40 -0400
Message-ID: <412BC984.6060408@bigpond.net.au>
Date: Wed, 25 Aug 2004 09:04:36 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040824211141.13585.qmail@web13921.mail.yahoo.com>
In-Reply-To: <20040824211141.13585.qmail@web13921.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com wrote:
> --- Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>Could you try it in "pb" mode with both max_ia_bonus and max_tpt_bonus 
>>set to zero?  That will disable all "priority" fiddling and tasks should 
>>just round robin at a priority determined solely by their "nice" value 
>>and since (according to your earlier mail) all the daemons have the same 
>>"nice" value they should just round robin with each other.
> 
> 
> 
> Hi, I tried the latest  V-5.0 patch over 2.6.8.1 in these conditions with the
> actual server subsystem, and I get components timeouts :(
> I also ran the watchdog script on the box while running the test, and saw
> deltas of around 3 seconds every few hours:
> 
> Tue Aug 24 03:02:13 PDT 2004
> 
>>>>>>>>delta = 3
> 
> Tue Aug 24 05:50:14 PDT 2004
> 
>>>>>>>>delta = 3
> 
> Tue Aug 24 09:05:24 PDT 2004
> 
>>>>>>>>delta = 4
> 
> Tue Aug 24 09:06:20 PDT 2004
> 
>>>>>>>>delta = 4
> 
> Tue Aug 24 09:36:22 PDT 2004
> 
>>>>>>>>delta = 3
> 
> Tue Aug 24 10:20:16 PDT 2004
> 
>>>>>>>>delta = 3
> 
> Tue Aug 24 13:28:19 PDT 2004
> 
>>>>>>>>delta = 3
> 
> 
> Could I do something more useful than just displaying those deltas? Maybe I
> could dump the process list in some way, or enable some debugging code in the
> kernel to find out what is going on?

You could try Lee Revell's (rlrevell@joe-job.com) latency measuring 
patches and also try applying Ingo Molnar's (mingo@elte.hu) 
voluntary-preempt patches.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

