Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVCWWBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVCWWBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVCWWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:01:08 -0500
Received: from alog0098.analogic.com ([208.224.220.113]:20659 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261431AbVCWWBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:01:05 -0500
Date: Wed, 23 Mar 2005 17:00:44 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: sounak chakraborty <sounakrin@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: repeat a function after fixed time period
In-Reply-To: <1111613230.12808.0.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503231654260.16973@chaos.analogic.com>
References: <20050323194308.8459.qmail@web53307.mail.yahoo.com> 
 <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com> 
 <1111610935.6306.97.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0503231551570.16734@chaos.analogic.com>
 <1111613230.12808.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Arjan van de Ven wrote:

> On Wed, 2005-03-23 at 15:56 -0500, linux-os wrote:
>>>> static void start_timer(void)
>>>> {
>>>>      if(!atomic_read(&info->running))
>>>>      {
>>>>          atomic_inc(&info->running);
>>>
>>> same race.
>>
>> No such race at all.
>
> here there is one; you use add_timer() which isn't allowed on running
> timers, only mod_timer() is. So yes there is a race.
>

Well add_timer() is only executed after the timer has expired
or hasn't started yet so the "isn't allowed" is pretty broad.
If I should use mod_timer(), then there are a _lot_ of buggy
drivers in the kernel because that's how a lot repeat the
sequence. Will mod_timer() actually restart the timer???

If so, I'll change it and thank you for the help.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
