Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVCXMJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVCXMJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVCXMJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:09:44 -0500
Received: from alog0141.analogic.com ([208.224.220.156]:30957 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262805AbVCXMJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:09:29 -0500
Date: Thu, 24 Mar 2005 07:09:22 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: repeat a function after fixed time period
In-Reply-To: <20050323231324.96262.qmail@web53301.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503240708140.29746@chaos.analogic.com>
References: <20050323231324.96262.qmail@web53301.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, sounak chakraborty wrote:
>
> --- linux-os <linux-os@analogic.com> wrote:
>> On Wed, 23 Mar 2005, Arjan van de Ven wrote:
>>
>>> On Wed, 2005-03-23 at 15:56 -0500, linux-os wrote:
>>>>>> static void start_timer(void)
>>>>>> {
>>>>>>      if(!atomic_read(&info->running))
>>>>>>      {
>>>>>>          atomic_inc(&info->running);
>>>>>
>>>>> same race.
>>>>
>>>> No such race at all.
>>>
>>> here there is one; you use add_timer() which isn't
>> allowed on running
>>> timers, only mod_timer() is. So yes there is a
>> race.
>>>
>>
>> Well add_timer() is only executed after the timer
>> has expired
>> or hasn't started yet so the "isn't allowed" is
>> pretty broad.
>> If I should use mod_timer(), then there are a _lot_
>> of buggy
>> drivers in the kernel because that's how a lot
>> repeat the
>> sequence. Will mod_timer() actually restart the
>> timer???
>>
>> If so, I'll change it and thank you for the help.
>
>
>   i have applied the code
> as i was intedded to call a function repeated ly in
> fork.c i written the code over there
> it compiled smoothly
> but while booting
> it is showing
> kernel panic no init found
> kjournal starting .commit interval after 5 seconds
>
> sounak
>

*** AWWK *** Sanity check failed.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
