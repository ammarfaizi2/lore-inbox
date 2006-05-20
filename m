Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWETJn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWETJn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 05:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWETJnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 05:43:55 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:39948 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932303AbWETJnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 05:43:53 -0400
Message-ID: <446EE4D8.9090208@vmware.com>
Date: Sat, 20 May 2006 02:43:52 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
References: <1147759423.5492.102.camel@localhost.localdomain>	<20060516064723.GA14121@elte.hu>	<1147852189.1749.28.camel@localhost.localdomain>	<20060519174303.5fd17d12.akpm@osdl.org>	<20060520010303.GA17858@elte.hu>	<20060519181125.5c8e109e.akpm@osdl.org>	<Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>	<20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org> <446EE1C2.7060400@vmware.com>
In-Reply-To: <446EE1C2.7060400@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Andrew Morton wrote:
>> vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled vmm:/home/akpm# 
>> vmm:/home/akpm> ls -l
>> zsh: segmentation fault  ls -l
>>
>>  
>>> That could tell us whether it's an init bug or a glibc bug.
>>>     
>>
>> It tells us neither.  This could be a new kernel bug which only 
>> certain old
>> userspace setups are known to trigger.  Until we know exactly why 
>> this is
>> occurring, we don't know where the bug is.
>>
>> And once we've worked that thing out, and if we determine that the 
>> bug is
>> in userspace then we might be able to craft the patch in such a fashion
>> that the old userspace continues to work, which would be a win.
>>   
>
> Please try my patch - sent earlier, but attached again.  It will tell 
> you with 100% confidence if the problem is with userspace expecting 
> the vsyscall page to be at a particular address.

I should rephrase.  100% confidence - engineer stupidity factor is more 
appropriate.  I can't guarantee an absolute.  But it is my belief that 
the only kernel space mapping that could ever have been relied on by 
userspace on i386 is the vsyscall page.

Zach
