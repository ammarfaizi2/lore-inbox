Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269806AbUJGMl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269806AbUJGMl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUJGMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:31:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60806 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269820AbUJGM1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:27:11 -0400
Date: Thu, 7 Oct 2004 08:26:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <20041007121741.GB23612@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0410070823300.10118@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
 <1097143144.2789.19.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com>
 <20041007121741.GB23612@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Arjan van de Ven wrote:

> On Thu, Oct 07, 2004 at 08:01:47AM -0400, Richard B. Johnson wrote:
>> Also, when this driver is running, transferring large volumes
>> of data, the kernel decides that there have been too many interrupts, and
>> does:
>>
>> Message from syslogd@chaos at Wed Oct  6 21:22:57 2004 ...
>> chaos kernel: Disabling IRQ #18
>>
>> This, in spite of the fact that interrupts occur only when
>> DMA completion happens and new data are available, i.e.,
>> one interrupt every 16 megabytes of data transferred.
>>
>> Who decided that it had a right to disable my interrupt????
>
> the kernel did because you don't return the proper value for "I handled the
> IRQ" from your ISR.

Do you know what that value is? I can't find it. I just returned 0
and it worked for awhile.

>
> Also I don't see where you call cleanup_module(), the function that does the
> deregistration of the chardev... where do you call that ????
>

The kernel calls cleanup_module() and the printk() shows that it
was truly called.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

