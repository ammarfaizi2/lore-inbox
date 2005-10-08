Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVJHXCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVJHXCU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 19:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVJHXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 19:02:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36336 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751330AbVJHXCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 19:02:17 -0400
In-Reply-To: <20051008225201.GK22818@devserv.devel.redhat.com>
References: <1BE252F0-3845-11DA-8153-000A959BB91E@mvista.com> <20051008221429.GJ22818@devserv.devel.redhat.com> <FE0888ED-3849-11DA-8153-000A959BB91E@mvista.com> <20051008225201.GK22818@devserv.devel.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91C172BF-384F-11DA-8153-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: robust futex patch for 2.6.14-rc3-rt13
Date: Sat, 8 Oct 2005 16:02:15 -0700
To: Jakub Jelinek <jakub@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 8, 2005, at 3:52 PM, Jakub Jelinek wrote:

> On Sat, Oct 08, 2005 at 03:22:20PM -0700, david singleton wrote:
>>
>> On Oct 8, 2005, at 3:14 PM, Jakub Jelinek wrote:
>>
>>> On Sat, Oct 08, 2005 at 02:47:23PM -0700, david singleton wrote:
>>>>
>>>> Ingo,
>>>>    here's a patch for the robust futex changes that match the
>>>> glibc/nptl changes
>>>> for robust futexes.  The kernel and glibc now both have robustness 
>>>> and
>>>> priority inheritance independent.
>>>
>>> Are you aware of the futex FUTEX_WAKE_OP addition from over a month
>>> ago?
>>> Futex command 5 is already taken, so you can't use it for the robust
>>> futex commands.
>>
>> Yes.   I merged the robust ops a while back to be compatible with
>> WAKE_OP.
>>
>> Currently, 2.6.14-rc3-rt13,  the ops are defined thusly:
>>
>> #define FUTEX_WAIT              0
>> #define FUTEX_WAKE              1
>> #define FUTEX_FD                2
>> #define FUTEX_REQUEUE           3
>> #define FUTEX_CMP_REQUEUE       4
>> #define FUTEX_WAKE_OP           5
>> #define FUTEX_WAIT_ROBUST       6
>> #define FUTEX_WAKE_ROBUST       7
>> #define FUTEX_REGISTER          8
>> #define FUTEX_DEREGISTER        9
>> #define FUTEX_RECOVER           10
>
> That's ok.
> I was judging by the glibc patch you posted this Friday:

Sorry, that was against an old tree.   The patch today was against 
2.6.14-rc3-rt13.

I've done that twice now.  I have to back up to the bleeding edge.

David


> +#define FUTEX_WAIT_ROBUST      5
> +#define FUTEX_WAKE_ROBUST      6
> +#define FUTEX_REGISTER         7
> +#define FUTEX_DEREGISTER       8
> +#define FUTEX_RECOVER          9
>
> 	Jakub

