Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVCWQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVCWQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVCWQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:04:29 -0500
Received: from alog0379.analogic.com ([208.224.222.155]:6309 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261663AbVCWQEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:04:08 -0500
Date: Wed, 23 Mar 2005 11:01:33 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: sounak chakraborty <sounakrin@yahoo.co.in>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: error while implementing kill()
In-Reply-To: <Pine.LNX.4.61.0503231548450.10048@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0503231058380.15396@chaos.analogic.com>
References: <20050323140803.15895.qmail@web53308.mail.yahoo.com>
 <Pine.LNX.4.61.0503231548450.10048@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kill_proc(pid, SIGNAL, x) is used inside the kernel to
send signals to kernel threads. It is not necessarily
the way to kill user-mode tasks. They should be
sent a fatal signal from user-mode.

On Wed, 23 Mar 2005, Jan Engelhardt wrote:

>> dear sir,
>> I am unable to use the system call kill(pid,sig).I
>> have included the header file <signal.h>. I used it in
>> a module to kill a process. The module is compiling
>> properly but giving the following error while
>> inserting the module,
>>   unresolved symbol kill()
>
> Who says that kill() is
> 1) a defined function
> 2) is the function that does what the libc call does
> 3) is the function that does what you expect
>
> As for sending signals,
> it's been posted today already, see the archives.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111155537319322&w=2
>
>
> Jan Engelhardt
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
