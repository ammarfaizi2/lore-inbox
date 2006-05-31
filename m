Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWEaV1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWEaV1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWEaV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:27:40 -0400
Received: from dvhart.com ([64.146.134.43]:7570 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965163AbWEaV1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:27:39 -0400
Message-ID: <447E0A49.4050105@mbligh.org>
Date: Wed, 31 May 2006 14:27:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu>
In-Reply-To: <20060531211530.GA2716@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>>EIP is at check_deadlock+0x15/0xe0
> 
> 
>>>  <c012b77b> check_deadlock+0xa5/0xe0  <c012b922> 
>>>debug_mutex_add_waiter+0x46/0x55
>>>  <c02d50de> __mutex_lock_slowpath+0x9e/0x1c0  <c0160061> 
>>>lookup_create+0x19/0x5b
>>>  <c016043a> sys_mkdirat+0x4c/0xc3  <c01604c0> sys_mkdir+0xf/0x13
>>>  <c02d6217> syscall_call+0x7/0xb
>>
>>Looks like the lock validator came unstuck.  But there's so much other 
>>crap happening in there it's hard to tell.  Did you try it without all 
>>the lockdep stuff enabled?
> 
> 
> AFAICS this isnt the lock validator but the normal mutex debugging code 
> (CONFIG_DEBUG_MUTEXES). The log does not indicate that lockdep was 
> enabled.

Buggered if I know how that got turned on. I thought we turned it off
by default now? That's what screwed up all the perf results before.

http://test.kernel.org/abat/33803/build/dotconfig
That's the build config it ran with.

CONFIG_DEBUG_MUTEXES=y

Grrr. Humpf. I can't see the option being turned on for lockdep ...
what was the config option, and is it enabled by default?

M.


