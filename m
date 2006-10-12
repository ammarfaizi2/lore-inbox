Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWJLUg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWJLUg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWJLUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:36:28 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:34315 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1750797AbWJLUg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:36:28 -0400
Message-ID: <452EA73B.4000606@tuxrocks.com>
Date: Thu, 12 Oct 2006 15:36:11 -0500
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.6.19-rc1
References: <452D43B6.8020406@tuxrocks.com>	<20061012000643.f875c96e.akpm@osdl.org>	<452E93D7.6020004@tuxrocks.com> <20061012125714.a44c3a1d.akpm@osdl.org>
In-Reply-To: <20061012125714.a44c3a1d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 12 Oct 2006 14:13:27 -0500
> Frank Sorenson <frank@tuxrocks.com> wrote:
> 
>> Andrew Morton wrote:
>>> On Wed, 11 Oct 2006 14:19:18 -0500
>>> Frank Sorenson <frank@tuxrocks.com> wrote:
>>>
>>>> I'm getting kernel panics within a few minutes of boot with 2.6.19-rc1 
>>>> (latest git) on x86_64.  Other than "make oldconfig", it's an identical 
>>>> configuration to a working kernel on 2.6.18.
>>>>
>>>> The panic scrolls off the screen, but I copied down what was on the screen:
>>> Can you get netconsole going?  Documentation/networking/netconsole.txt.
>>> It's pretty simple.
>> Three netconsole dumps attached.  I hope they provide more information. 
>>   Let me know if there's anything more I can provide.
>>
> 
> hmm.
> 
> 
>> [   20.889846] warning: process `date' used the removed sysctl system call
>> [  143.574063] do_IRQ: 0.65 No irq handler for vector
> 
> This might be the cause.  Please try the appended fix.

This patch seems to fix the problem, and since it's already gone into 
the kernel, the latest git tree works without modification.

Thanks for the quick response,

Frank
