Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVCWRY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVCWRY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVCWRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:23:12 -0500
Received: from alog0254.analogic.com ([208.224.222.30]:42441 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262775AbVCWRSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:18:47 -0500
Date: Wed, 23 Mar 2005 12:16:16 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux lover <linux_lover2004@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing data structure from kernel space
In-Reply-To: <20050323164129.70589.qmail@web52204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503231214080.15948@chaos.analogic.com>
References: <20050323164129.70589.qmail@web52204.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, linux lover wrote:

> Hello linux-os,
> --- linux-os <linux-os@analogic.com> wrote:
>> On Wed, 23 Mar 2005, linux lover wrote:
>>
>>> Hello all,
>>>        I have one linked list data structure added
>> to
>>> a file in kernel source code which has some kernel
>>> info. I want to acess that linked list structure
>> from
>>> user space. Is that possible??
>>>        Also how to add own system call usable at
>> user
>>> level from kernel module??
>>> regards,
>>> linux_lover.
>>>
>>
>> Many people will tell you to use the /proc
>> file-system.
>> I suggest you make a simple "character" driver and
>> access
>> your kernel structure using ioctl() or mmap().
>>
>      How can i access that linked list structure in
> kernel at user space say if i write character driver
> as /dev/readll then how to link that structure to
> device driver
> ?

Gawd.... `man ioctl`. Execute that. Learn. Write code
that handles such a call in your module.
`man mmap`. execute that. Learn. Write code that
handles memory-mapping in your module.

>> You don't add your own system call __ever__, even if
>> you
>> are a long-time kernel developer. The current API
>> already
>> has lots of standard interface capabilities.
>> Thinking, even
>> for an instant, that you need more means that you
>> don't
>> understand Unix/Linux.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.11 on an i686 machine
>> (5537.79 BogoMips).
>>   Notice : All mail here is now cached for review by
>> Dictator Bush.
>>                   98.36% of all statistics are
>> fiction.
>>
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
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
