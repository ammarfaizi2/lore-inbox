Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWC1XJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWC1XJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWC1XJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:09:50 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:25412 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964810AbWC1XJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:09:49 -0500
Message-ID: <4429BCAC.80208@tmr.com>
Date: Tue, 28 Mar 2006 17:46:04 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com>
In-Reply-To: <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 3/27/06, Pierre PEIFFER <pierre.peiffer@bull.net> wrote:
>> I found a (optimization ?) problem in the futexes, during a futex_wake,
>>   if the waiter has a higher priority than the waker.
> 
> There are no such situations anymore in an optimal userlevel
> implementation.  The last problem (in pthread_cond_signal) was fixed
> by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
> at is simply not optimized for the modern kernels.

What are you suggesting here, that the kernel can be inefficient as long 
as the user has a way to program around it?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

