Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbUJ2RTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbUJ2RTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbUJ2RST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:18:19 -0400
Received: from alog0559.analogic.com ([208.224.223.96]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263363AbUJ2RPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:15:34 -0400
Date: Fri, 29 Oct 2004 13:08:22 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Steinmetz <ast@domdv.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <41826A7E.6020801@domdv.de>
Message-ID: <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Andreas Steinmetz wrote:

> Linus Torvalds wrote:
>> 
>> On Fri, 29 Oct 2004, linux-os wrote:
>> 
>>> Linus, please check this out.
>> 
>> 
>> Yes, I concur. However, I'd suggest changing the "addl $4,%esp" into a 
>> "popl %ecx", which is smaller and apparently faster on some CPU's (ecx 
>> obviously gets immediately overwritten by the next popl).
>
> Hmm, I didn't check the instruction length but modern CPUs usually work best 
> with the following:
>
> leal 4(%esp),%esp
>
> -- 
> Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
>

Probably so because I'm pretty certain that the 'pop' (a memory
access) is not going to be faster than a simple register operation.

I'll make another patch and post it (if the machine will boot!)

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
