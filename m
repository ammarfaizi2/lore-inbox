Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVL3WFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVL3WFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVL3WFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:05:37 -0500
Received: from [202.67.154.148] ([202.67.154.148]:8593 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750788AbVL3WFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:05:37 -0500
Message-ID: <43B5AF19.5080105@ns666.com>
Date: Fri, 30 Dec 2005 23:05:13 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours /	random	apps	crashing
References: <43B53EAB.3070800@ns666.com>	 <9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>	 <43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com>	 <20051230164751.GQ3105@vanheusden.com> <43B56ADD.7040300@ns666.com>	 <20051230183021.GV3105@vanheusden.com> <43B5890E.30104@ns666.com>	 <20051230202429.GD11594@vanheusden.com> <43B59F88.1030704@ns666.com>	 <43B5A371.4050905@ns666.com>  <43B5A6F7.3090708@ns666.com>	 <1135978501.31111.24.camel@mindpipe>  <43B5AAF1.70503@ns666.com>	 <1135979488.31111.28.camel@mindpipe>  <43B5AD40.2070101@ns666.com> <1135980022.31111.31.camel@mindpipe>
In-Reply-To: <1135980022.31111.31.camel@mindpipe>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-12-30 at 22:57 +0100, Mark v Wolher wrote:
> 
>>Lee Revell wrote:
>>
>>>On Fri, 2005-12-30 at 22:47 +0100, Mark v Wolher wrote:
>>>
>>>
>>>>Lee Revell wrote:
>>>>
>>>>
>>>>>On Fri, 2005-12-30 at 22:30 +0100, Mark v Wolher wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Mark v Wolher wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>>Mark v Wolher wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>Folkert van Heusden wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>>Hmm, i disabled MSI in the kernel, irq-balancing is on in the kernel,
>>>>>>>>>>and after a restart with irqbalance i see the cpu's show numbers !
>>>>>>>>>>I guess MSI was preventing them ? But does that means because of MSI
>>>>>>>>>>that performance was lower in some way ?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>did you also restart with only irqbalance activated?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Folkert van Heusden
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>Yes, when MSI was disabled i had irq-balancing in the kernel on, i
>>>>>>>>rebooted without the irqbalance daemon and it showed no reaction on the
>>>>>>>>cpu's. When i enabled the irqbalance daemon then i got finally reaction
>>>>>>>
>>>>>>>>from the cpu's.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>I'm also curious if this will solve those random freezes...which somehow
>>>>>>>>i suspect have to do with the tvcard and maybe having MSI on.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>:( just got a total freeze, number 2 today. This time i noticed the
>>>>>>>mouse started to go very slow and 2 seconds later all was frozen.
>>>>>>>
>>>>>>>Maybe it's because of vmware ... i will not use vmware and see how it goes.
>>>>>>>-
>>>>>>
>>>>>>
>>>>>>Some new info, i just noticed this in the logs:
>>>>>>
>>>>>>
>>>>>>Dec 30 22:21:24 localhost kernel: bttv0: OCERR @ 1fde0000,bits: HSYNC
>>>>>>OFLOW FBUS OCERR*
>>>>>>Dec 30 22:21:24 localhost last message repeated 5 times
>>>>>>Dec 30 22:21:24 localhost kernel: bttv0: timeout: drop=0
>>>>>>irq=41296/41296, risc=1fde001c, bits: HSYNC OFLOW
>>>>>>Dec 30 22:21:24 localhost kernel: bttv0: reset, reinitialize
>>>>>>Dec 30 22:21:24 localhost kernel: bttv0: PLL: 28636363 => 35468950 . ok
>>>>>>
>>>>>>
>>>>>>But vmware is not active at this moment, i'll not use vmware and see if
>>>>>>a freeze occurs, i'll test up to 24 hours.
>>>>>>
>>>>>>I can swear it might have to do with the tvcard with tv on and vmware at
>>>>>>the same time also active. Or maybe just 1 of them. I'm even considering
>>>>>>to buy tomorrow a new tvcard and see if it makes any difference.
>>>>>
>>>>>
>>>>>It does not matter whether VMWare is active at the moment.  Any bug
>>>>>report where a binary module has been loaded, active or not, is tainted.
>>>>>
>>>>>Can you reproduce with a 100% clean kernel?
>>>>>
>>>>>Lee
>>>>>
>>>>
>>>>Hi Lee,
>>>>
>>>>But unloading all vmware modules should be good enough ? And how about
>>>>the binary module of nvidia ? It's active ofcourse else i'd not be able
>>>>to use all the features i normally use.
>>>>
>>>>Eitherway, several kernels back also made no difference for this issue.
>>>>
>>>>So right now, i'm leaning on the experience i have with working with
>>>>this system and trying to isolate things i suspect, before i go to more
>>>>radical steps :)
>>>>
>>>>And again, under windows 2k server, xp pro, redhat enterprise and
>>>>freebsd i never had these issues.
>>>>
>>>
>>>
>>>No, it's not good enough to unload them and no, the nvidia module
>>>absolutely cannot have been loaded.  Binary modules can do ANYTHING and
>>>we have NO IDEA what they are up to, how could you possibly think such a
>>>system would be debuggable?
>>>
>>>Please, search the LKML archives, this has come up again and again and
>>>again and still people post bug reports with binary only modules and
>>>expect them to be debuggable.
>>>
>>>Lee
>>>
>>>
>>>
>>>
>>>
>>
>>Well Lee, you might be right indeed, but i see only some one who has
>>something against binary modules and assuming they're always to blame.
>>I do not agree with this and i will proceed from simple to advanced in
>>solving this problem, not start thinking difficult while the problem
>>might be solved by a simple move. :)
>>
> 
> 
> No I'm not assuming they are to blame, the point is that without the
> source code we can't prove they aren't.
> 
> What if the vmware or nvidia module did something wrong that just
> happened to work by chance in older kernels?  We have no way to prove
> that this is not happening.
> 
> Lee
> 
> 
> 

Yes, "what if" .. that means anything could be the cause, even a
cockroach in the box causing circuit to fail when it moves hehe
So don't worry, first i'll do these very simple tests and see what
effect they have and later go to more radical moves and strip all binary
modules and so on. This is only the initial point where i start to look
for common problems and people can give their advise in general.




