Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUJYMcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUJYMcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUJYMcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:32:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261775AbUJYMcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:32:17 -0400
Date: Mon, 25 Oct 2004 08:32:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: printk() with a spin-lock held.
In-Reply-To: <1098503815.13176.2.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0410250828460.18507@chaos.analogic.com>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
 <1098503815.13176.2.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Lee Revell wrote:

> On Fri, 2004-10-22 at 15:07 -0400, Richard B. Johnson wrote:
>> Linux-2.6.9 will bug-check and halt if my code executes
>> a printk() with a spin-lock held.
>>
>> Is this the intended behavior?
>
> Yes.  printk() can sleep.  No sleeping with a spinlock held.
>
>> If so, NotGood(tm).
>
> See above.  If you think you can improve the situation, patches are
> welcome, as always.
>
> Lee
>

I recall that printk() useds to just write stuff into a buffer,
that the buffer (the same buffer used for dmesg), was written
out only when it was safe to do so.


Now, if printk() can't do that anymore, how does one de-bug
ISR code? Or do you just heave it off the cliff and hope that
it flies?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
