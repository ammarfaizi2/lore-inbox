Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWC3UZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWC3UZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWC3UZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:25:27 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:18196 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750814AbWC3UZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:25:26 -0500
Message-ID: <442C3F3F.5050107@tmr.com>
Date: Thu, 30 Mar 2006 15:27:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <4429BCAC.80208@tmr.com> <20060329152643.GA13194@elte.hu>
In-Reply-To: <20060329152643.GA13194@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Bill Davidsen <davidsen@tmr.com> wrote:
> 
>> Ulrich Drepper wrote:
>>> On 3/27/06, Pierre PEIFFER <pierre.peiffer@bull.net> wrote:
>>>> I found a (optimization ?) problem in the futexes, during a futex_wake,
>>>>  if the waiter has a higher priority than the waker.
>>> There are no such situations anymore in an optimal userlevel
>>> implementation.  The last problem (in pthread_cond_signal) was fixed
>>> by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
>>> at is simply not optimized for the modern kernels.
>> What are you suggesting here, that the kernel can be inefficient as 
>> long as the user has a way to program around it?
> 
> What are you suggesting here, that FUTEX_WAKE_UP is a "user way to 
> program around" an inefficiency? If yes then please explain to me why 
> and what you would do differently.

The point I'm making is that even if an application is "not optimized
for modern kernels" or whatever, there's no reason to ignore
inefficiencies. As Pierre Pfeiffer noted this happens independently of
user code. If a change can eliminate some CPU cycles and possible cache
activity, it would seem to be worth investigation.

The suggestion that the user code was inefficient was not mine...

Did I clarify it this time?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

