Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWFPVEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWFPVEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:04:40 -0400
Received: from relay03.pair.com ([209.68.5.17]:60945 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751341AbWFPVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:04:39 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 16 Jun 2006 16:04:36 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: Jes Sorensen <jes@sgi.com>, Andi Kleen <ak@suse.de>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
In-Reply-To: <4492A8A1.5000101@bull.net>
Message-ID: <Pine.LNX.4.64.0606161601590.23743@turbotaz.ourhouse>
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de>
 <44928FB1.5070107@sgi.com> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com>
 <4492A5E4.9050702@bull.net> <4492A6E6.3090805@sgi.com> <4492A8A1.5000101@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Zoltan Menyhart wrote:

> Jes Sorensen wrote:
>>  Zoltan Menyhart wrote:
>> 
>> > Just to make sure I understand it correctly...
>> > Assuming I have allocated per CPU data (numa control, etc.) pointed at 
>> > by:
>>
>>
>>  I think you misunderstood - vgetcpu is for userland usage, not within
>>  the kernel.
>>
>>  Cheers,
>>  Jes
>> 
> I did understand it as a user land stuff.
> This is why I want to map the current task structure into the user space.
> In user code, we could see the actual value of the 
> "current->thread_info.cpu".
> My "#define current ((struct task_struct *) 0x...)" is not the same as
> the kernel's one.

I think it's probably best to leave most of the stuff in task_struct 
private (ie, mapped in kernel only).

> Thanks,
>
> Zoltan

Thanks,
Chase
