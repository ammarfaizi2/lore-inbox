Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRDASwb>; Sun, 1 Apr 2001 14:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDASwV>; Sun, 1 Apr 2001 14:52:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:57575 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132521AbRDASwN>;
	Sun, 1 Apr 2001 14:52:13 -0400
Message-ID: <3AC7773F.9090401@optibase.com>
Date: Sun, 01 Apr 2001 20:45:19 +0200
From: Constantine Gavrilov <const-g@optibase.com>
Organization: Optibase
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac26customSMP i686; en-US; 0.8) Gecko/20010211
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Anton.Safonov@bestlinux.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA problems on IBM ThinkPad 600X
In-Reply-To: <Pine.LNX.3.96.1010401123249.28121B-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> On Sun, 1 Apr 2001, Constantine Gavrilov wrote:
> 
>> There are problems with some PCMCIA drivers included in the kernel. For 
>> example, support for cardbus 3com cards was moved to 3c59x.o driver. It 
>> works (on 600X at least) only of you compile it in. It will not work as 
>> a module.
> 
> 
> It works just fine as a module.  What problems are you seeing?
> 
Exactly as reported by Anton.  "cs: socket XXXXX timed out during reset" 
messages on the console when loading the module. This is at least on IBM 
Thinkpad 600X. 16-bit cards work fine.

> 
>> I think a much better solution right now is to use drivers from 
>> pcmcia-cs package. It always works. If you do not configure any support 
>> for pcmcia in your kernel, when you build pcmcia-cs it will build kernel 
>> drivers from its own source tree. Just make sure you use the latest 
>> version. This also allows configuration files interoperbility with 2.2.x 
>> kernel, if you wish to use that as well.
> 
> 
> pcmcia-cs does not always work, and it puts your nice 32-bit hardware
> into 16-bit compatibility mode AFAIK.
> 
> If you have 2.4 bugs, please report them instead of spewing B.S.
> 
> 	Jeff
> 
> 
Several points:
* this bug and the workaround have been reported several times on 
several mailing lists, probably on linux-kernel as well. Explanations 
also stated that it has been broken and reported since 2.4.0-preX (I do 
not remember which pre-release). So it is not a hidden knowledge and I 
do not have to report a known bug.

* I do not think pcmcia-cs puts cardbus cards into 16-bit compatibility 
mode. According to David Hinds, pcmcia code has been integrated into 
2.4, so 2.4 uses a similar code base. My tests of bonding code showed 2 
Mbit/sec with PCMCIA (100% CPU utilization) and 12 Mbit/sec with CardBus 
(<5% CPU utilization).

* The letter has not been addressed to you, but to the list. Why are you 
taking this personal? What I said is no BS. The bug has been known and 
reported. I personally use multiple versions of 2.2.x and 2.4.x kernels 
installed on my machine for research and development. These include 
various experimental patches and pre-releases. For people in my 
situation, it is more convenient to use drivers from pcmcia-cs mainly 
for two reasons: 1) I can use the same PCMCIA configuration for all 
kernels; 2) I do not have to recompile kernel to upgrade PCMCIA drivers. 
Why should it bother you?

David's stuff happens to work better right now. So what? There are 
several quite logical reasons for it:
* PCMCIA code has been integrated relatively recently and not all 
integration problems have been solved yet. "Official" and "unofficial" 
Linux documentation state this and recommend pcmcia-cs in the case of 
problems.
* Since 2.4 has come out, a lot of efforts are made to fix bugs. Some 
changes in the code incidentally break "other" stuff. Since David has to 
concentrate on PCMCIA only, he can respond quickly to fix integration 
problems. He is not bound to kernel release schedules and can release 
more frequently. In the current situation, it helps.
* When you (or somebody else) update network drivers, you cannot 
possibly make sure that changes work across all card models. For David, 
on the other hand, it is by far much easier to insure compatibility, 
since he has to deal with CardBus and PCMCIA only. He also has had a lot 
of experince doing this and his releases have always being of high quality.

So, you do not have to get angry. I did not reflect on the quality of 
your code and  the thought has not even occurred to me. After all, if 
you update epro100 code, for instance, these changes appear in pcmcia-cs 
package rather quickly. Part of David's job has been to make sure that 
network drivers written in whole or in large part by other people work 
WELL with PCMCIA and CardBus cards. He has been doing an excellent job 
-- why should it bother you?

-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------

