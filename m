Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBJAWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBJAWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWBJAWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:22:49 -0500
Received: from smtpout.mac.com ([17.250.248.71]:61923 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750837AbWBJAWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:22:49 -0500
In-Reply-To: <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru> <m1hd7condi.fsf@ebiederm.dsl.xmission.com> <1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com> <20060208215412.GD2353@ucw.cz> <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: swsusp done by migration (was Re: [RFC][PATCH 1/5] Virtualization/containers: startup)
Date: Thu, 9 Feb 2006 19:21:50 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2006, at 13:20, Eric W. Biederman wrote:
> Pavel Machek <pavel@ucw.cz> writes:
>> Well, for now software suspend is done at very different level (it  
>> snapshots complete kernel state), but being able to use migration  
>> for this is certainly nice option.
>>
>> BTW you could do whole-machine-migration now with uswsusp; but  
>> you'd need identical hardware and it would take a bit long...
>
> Right part of the goal is with doing it as we are doing it is that  
> we can define what the interesting state is.
>
> Replacing software suspend is not an immediate goal but I think it  
> is a worthy thing to target.  In part because if we really can rip  
> things out of the kernel store them in a portable format and  
> restore them we will also have the ability to upgrade the kernel  
> with out stopping user space applications...
>
> But being able to avoid the uninteresting parts, and having the  
> policy complete controlled outside the kernel are the big wins we  
> are shooting for.

<wishful thinking>
I can see another extension to this functionality.  With appropriate  
changes it might also be possible to have a container exist across  
multiple computers using some cluster code for synchronization and  
fencing.  The outermost container would be the system boot container,  
and multiple inner containers would use some sort of network- 
container-aware cluster filesystem to spread multiple vservers across  
multiple servers, distributing CPU and network load appropriately.
</wishful thinking>

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



