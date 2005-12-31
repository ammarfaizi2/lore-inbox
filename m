Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVLaAzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVLaAzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVLaAzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:55:04 -0500
Received: from [202.67.154.148] ([202.67.154.148]:61838 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751264AbVLaAzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:55:03 -0500
Message-ID: <43B5D6D0.9050601@ns666.com>
Date: Sat, 31 Dec 2005 01:54:40 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com> <200512310027.47757.s0348365@sms.ed.ac.uk> <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk>
In-Reply-To: <200512310051.03603.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Saturday 31 December 2005 00:42, Mark v Wolher wrote:
> 
>>Alistair John Strachan wrote:
>>
>>>On Saturday 31 December 2005 00:20, Mark v Wolher wrote:
>>>[snip]
>>>
>>>
>>>>>This is good news -- you stand a better chance of achieving the
>>>>>stability you require by eliminating variables. VMWare and NVIDIA are
>>>>>useful softwares, and I would not deny that, but they are closed source
>>>>>and thus any conflicts resulting from their use are not necessary LKML
>>>>>material (however, if the interaction is generic and is as a result of
>>>>>a kernel bug, then the maintainer would very much like to hear it).
>>>>
>>>>Okay, i have something interesting now, i only had the nvidia module
>>>>loaded so my x-configuration starts up as usual. (not saying the nvidia
>>>>module is flawless, i'm sure it still contains bugs)
>>>>But here is the crash info, this time it was mozilla, i think this
>>>>speaks more hehe :
>>>>
>>>>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 061f0c08.
>>>>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 06b96000.
>>>>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 18000bf8.
>>>>Dec 31 00:55:28 localhost kernel: ------------[ cut here ]------------
>>>>Dec 31 00:55:28 localhost kernel: kernel BUG at mm/mmap.c:2214!
>>>>Dec 31 00:55:28 localhost kernel: invalid operand: 0000 [#1]
>>>>Dec 31 00:55:28 localhost kernel: SMP
>>>>Dec 31 00:55:28 localhost kernel: Modules linked in: nvidia
>>>
>>>Steady and sure progress. Now, the trace below doesn't explicitly mention
>>>any nvidia symbols, but this line must disappear before anybody will
>>>bother to read your report.
>>>
>>>Remove the module. This does not mean unload, this means "never load in
>>>the first place". Then reproduce the problem. If you are successful, send
>>>a new email (not pinned to this thread) with a subject a la "kernel BUG
>>>at mm/mmap.c:2214". State that the kernel is not tainted.
>>>
>>>At this point all you can do is wait. Good luck!
>>
>>Well, i guess i'll have to do that to be sure. But i must say that i did
>>try the nv module and de-installed the nvidia binary module. It didn't
>>matter, the system froze but didn't leave anything in the logs, this
>>time it did. Doesn't that help at all ?
>>
>>I'll try again, put nv up and wait for a something to happen. If some
>>one has in the meantime more advise or maybe even could check out of
>>curiousity why it says kernel BUG i'd appreciate it ofcourse.
> 
> 
> Probably upwards of 95% of BUGs in mm/ are due to defective memory in the 
> system running the kernel. However, since you claim to have run other OSes 
> successfully on this configuration, I did not suggest it.
> 
> However, I would highly recommend running memtest86 at least twice on the 
> machine if you cannot track down the source of the problem.
> 
> It is always worth eliminating hardware.
> 

Indeed, i'm going soon to get some sleep but leave memtest86 running for
 the night and when i wake up then i'll see if something is reported.
It's 2x256 pc2100 ECC memory. I also expect next week monday or tuesday
new memory, which i can use to replace this memory and exclude that
eitherway.

Thanks !







