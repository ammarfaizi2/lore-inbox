Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWE2XM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWE2XM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWE2XM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:12:26 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:197 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932082AbWE2XMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:12:25 -0400
Message-ID: <447B7FD6.6020405@bigpond.net.au>
Date: Tue, 30 May 2006 09:12:22 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net>
In-Reply-To: <447B64BF.4050806@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 29 May 2006 23:12:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Peter Williams wrote:
> 
>> Yes, but not yet publicly available.  I use quilt to keep the patch 
>> series up to date and do the change as a relatively large series (30 or 
>> so) to make it easier for me to cope with changes in the kernel.  When I 
>> do the next release I'll make a tar ball of the patch series available.
>>
>> Of course, if your eager to start right away I could make the 
>> 2.6.17-rc4-mm1 one available?
>>  
>>
> 
> Well a piecewise patchset does make it a lot easier to see what's going
> on, especially if it's got descriptions of each patch along the way. 

It's a bit light on descriptions at the moment :-(  as I keep putting 
that in the "do later" bin.

> I'd certainly be interested in having a look through the split out patch
> to see how namespaces and this advanced scheduling system might
> interoperate.

OK.  I've tried very hard to make the scheduling code orthogonal to 
everything else and it essentially separates out the scheduling within a 
CPU from other issues e.g. load balancing.  This separation is 
sufficiently good for me to have merged PlugSched with an earlier 
version of CKRM's CPU management module in a way that made each of 
PlugSched's schedulers available within CKRM's infrastructure.  (CKRM 
have radically rewritten their CPU code since then and I haven't 
bothered to keep up.)

The key point that I'm trying to make is that I would expect PlugSched 
and namespaces to coexist without any problems.  How it integrates with 
the "advanced" scheduling system would depend on how that system alters 
things such as load balancing and/or whether it goes for scheduling 
outcomes at a higher level than the task.

I'm assuming that you're happy to wait for the next release?  That will 
improve the likelihood of descriptions in the patches :-).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
