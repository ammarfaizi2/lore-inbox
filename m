Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270534AbUJTUnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270534AbUJTUnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270530AbUJTUmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:42:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269908AbUJTUhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:37:48 -0400
Date: Wed, 20 Oct 2004 16:37:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Register corruption --patch
In-Reply-To: <20041020202711.GA3685@finwe.eu.org>
Message-ID: <Pine.LNX.4.61.0410201636330.6918@chaos.analogic.com>
References: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com>
 <20041020003408.GA6101@finwe.eu.org> <Pine.LNX.4.61.0410200836020.10672@chaos.analogic.com>
 <20041020202711.GA3685@finwe.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Jacek Kawa wrote:

> Richard B. Johnson wrote
>
>> On Wed, 20 Oct 2004, Jacek Kawa wrote:
>>> Richard B. Johnson wrote:
>>>
>>>> This 'C' compiler destroys parameters passed to functions
>>>> even though the code does not alter that parameter.
> [...]
>>>> I have been having trouble with mysterious things like:
>>> [...]
>>>> (4) Data errors in email.
>>>> (5) Network connections failing to go away `netstat -c` shows
>>>> hundreds of lines of very old history.
>>>> ... etc.
>>>
>>> Having troubles with some strange (and -as it seems- temporary)
>>> data corruptions here[*], I was wondering, whether would it be
>>> posiible to easily diagnose this somehow?
>>>
>>> [*] like diff running serval times over same two files can
>>>   only once in a while show one character altered
> [...]
>> If the corruption goes away, you've either fixed the problem
>> or have changed the size of something so that something that
>> was getting trashed before by some completely-unrelated code,
>> is now able to survive.
>
> In a way patch helped to track down the error: while compiling
> new kernel[*] I was hit by SEGFAULT, so I ran memtest....
> Well, it's not new RAM, so it goes away now, and I will give
> a plain 2.6.9 next try.
>
> [*] I compiled -rc4 and -final (well, even twice) not so long
>    ago and everythig was fine those days. :/
>
>> Without some specific OOPS, some code to trace, it's just
>> a crap game. But, the semaphore patch can't hurt anything.
>
> Thanks for explanation. I will apply workaround in case
> of 'mysterious' corruption reappear.
>
> BTW, could it be, that CONFIG_REGPARM makes problem visible with
>     your compiler (somehow)?
>

That's disabled in my .config.

> -- 
> Jacek Kawa   **So, logically...  If she weighs the same as a duck,
>            she's made of wood. And therefore-? A witch! A witch!**
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
