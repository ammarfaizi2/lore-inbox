Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVECJtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVECJtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 05:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVECJtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 05:49:11 -0400
Received: from tornado.reub.net ([60.234.136.108]:2956 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261435AbVECJtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 05:49:05 -0400
Message-ID: <4277490D.7040205@reub.net>
Date: Tue, 03 May 2005 21:49:01 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
References: <fa.gbejpad.1vj8f9r@ifi.uio.no>	<42773DC0.4050803@reub.net> <20050503020705.29bbffbd.akpm@osdl.org>
In-Reply-To: <20050503020705.29bbffbd.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>Hi Andrew,
>>
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/
>>>
>>>- There's still a bug in the new timer code.  If you think you hit it,
>>>  please revert 
>>>
>>>	timers-fixes-improvements-fix.patch			then
>>>	timers-fixes-improvements-smp_processor_id-fix.patch	then
>>>	timers-fixes-improvements.patch
>>>
>>>  or, better, fix the bug.
>>
>>FWIW, I can reproduce this timer bug fairly consistently, by simply 
>>rebooting my cisco router.  That means that my linux box has no default 
>>gateway, and hence the networking blows up within about 30s and dies 
>>with a stack trace which has references to timers.
>>
>>I'll back out those three patches and see if it continues, but hopefully 
>>my little discovery is useful to someone in terms of coming up with a 
>>fix....
>>
> 
> 
> Rather than backing things out, please add this instead:
> 
> 
> From: Oleg Nesterov <oleg@tv-sign.ru>
> 
> The bug was identified by Maneesh Soni.

Yup, this patch seems to fix it.  I did 3 router reboots, and my linux 
box held up fine.  Previous to this patch it had fatally oopsed 5 out of 
the 6 times I reloaded the router..

Thanks :)

reuben

