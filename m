Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264325AbUEIQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUEIQxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 12:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUEIQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 12:53:50 -0400
Received: from mail.tmr.com ([216.238.38.203]:15888 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264325AbUEIQxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 12:53:47 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Sun, 09 May 2004 13:00:02 -0400
Organization: TMR Associates, Inc
Message-ID: <c7lnh2$4fo$1@gatekeeper.tmr.com>
References: <200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org> <c7bin8$fg7$1@gatekeeper.tmr.com> <200405060104.55340.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084121442 4600 192.168.12.10 (9 May 2004 16:50:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <200405060104.55340.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 05 of May 2004 22:31, Bill Davidsen wrote:
> 
>>Andrew Morton wrote:
>>
>>>Dominik Karall <dominik.karall@gmx.net> wrote:
>>>
>>>>On Wednesday 05 May 2004 10:31, you wrote:
>>>>
>>>>>+make-4k-stacks-permanent.patch
>>>>>
>>>>>Fill my inbox.
>>>>
>>>>Hi Andrew!
>>>>
>>>>Is there any reason why this patch was applied? Because NVidia users
>>>>can't work with the original drivers now without removing this patch
>>>>every time.
>>>
>>>We need to push this issue along quickly.  The single-page stack
>>>generally gives us a better kernel and having the stack size configurable
>>>creates pain.
>>
>>Add my voice to those who don't think 4k stacks are a good idea as a
>>default, they break some things and seem to leave other paths (as others
>>have noted) on the edge. I'm not sure what you have in mind as a "better
>>kernel" but I'd rather have a worse kernel and not have to check 4k
>>stack as a possible problem before looking at other things if I get bad
>>behaviour.
>>
>>Reliability first, performance later. We've lived with the config for a
>>while, pain there is better than pain at runtime.
> 
> 
> Opposite opinion here.
> 
> If you want 100% reliability you shouldn't use -mm in the first place.
> 
> Making 4kb stacks default in -mm is very good idea so it will get necessary
> testing and fixing before being integrated into mainline.
> 
> Please also note that users of binary only modules always have choice:
> - new kernels without binary only modules
> - old kernels with binary only modules
> 
> It is really that simple.

No it's not that simple, this has nothing to do with binary modules, and 
everything to do with not making 4k stack the only available 
configuration in 2.6. Options are fine, but in a stable kernel series I 
don't think think that the default should change part way into the 
series, and certainly the availability of the original functionality 
shouldn't go away, which is what I read AKPMs original post to state as 
the goal.

Making changes to the kernel which will break existing applications 
seems to be the opposite of "stable." People who want a new kernel for 
fixes don't usually want to have to upgrade and/or rewrite their 
applications. The "we change the system interface everything we fix a 
bug" approach comes from a well-known software company, but shouldn't be 
the way *good* software is done.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
