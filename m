Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUGSU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUGSU5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUGSU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:57:45 -0400
Received: from mail.tmr.com ([216.238.38.203]:59658 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263475AbUGSU5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:57:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.8-rc1-np1
Date: Mon, 19 Jul 2004 17:00:14 -0400
Organization: TMR Associates, Inc
Message-ID: <cdhca9$6h8$1@gatekeeper.tmr.com>
References: <40F8B7C5.9030201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090270345 6696 192.168.12.100 (19 Jul 2004 20:52:25 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <40F8B7C5.9030201@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/2.6.8-rc1-np1/
> 
> Now that I finally a highmem system, I've been able to make some progress
> on the memory management chaneges. Still needs more work though. Feedback
> would be nice if anyone is testing.
> 
> Scheduler behaviour is generally pretty good now so I've increased the
> timeslice size to see how far I can push it. Some workloads really demand
> small timeslices though, so I've added /proc/sys/kernel/base_timeslice.
> If you have any problems with the default, please report it to me, and
> check if lowering this value helps.
> 
> Things are working alright on my desktop with base_timeslice at 10000
> which corresponds to around 15-20 *second* timeslices, however I don't
> do much fancy, and it does have the problem of a newly forked CPU hog
> possibly causing a long freeze (fixable by using a smaller value for
> the first timeslice).

I think most people will find the long freeze worth avoiding, thanks for 
making it easily adjustable. As I found out when I was evaluating sorts 
and human interfaces that users would rather use a slower sort which 
didn't have a "jackpot case" than one which was 30% faster but linear in 
response. This was for 1-2sec typical response.

Just my guess.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
