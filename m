Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285556AbRL3PNK>; Sun, 30 Dec 2001 10:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287429AbRL3PNA>; Sun, 30 Dec 2001 10:13:00 -0500
Received: from mout1.freenet.de ([194.97.50.132]:8341 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S285556AbRL3PMz>;
	Sun, 30 Dec 2001 10:12:55 -0500
Message-ID: <3C2F2F62.3060606@athlon.maya.org>
Date: Sun, 30 Dec 2001 16:14:42 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: knobi@knobisoft.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2F18A5.B50792F0@sirius-cafe.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:

>>Re: [2.4.17/18pre] VM and swap - it's really unusable
>>
>>
>>My observation:
>>Why does the kernel swap to get free memory for caching / buffering? I
>>can't see any sense in this action. Wouldn't it be better to shrink the
>>cashing / buffering-RAM to the amount of memory, which is obviously free?
>>
>>Swapping should be principally used, if the RAM ends for real memory
>>(memory, which is used for running applications). First of all, the
>>memory-usage of cache and buffers should be reduced before starting to
>>swap IMHO.


[...]


>  In any case, 2.4 Caches/Buffers show to much persistance. This is
> basically true for both branches of VM. I was using the -ac kernels
> because, being far from perfect, the VM gave considreabele better
> interactive behaviour.


I did some tests with different VM-patches. I tested one ac-patch, too. 
I detected the same as you described - but the memory-consumption and 
the behaviour at all isn't better. If you want to, you can test another 
patch, which worked best in my test. It's nearly as good as kernel 
2.2.x. Ask M.H.vanLeeuwen (vanl@megsinet.net) for his oom-patch to 
kernel 2.4.17.
But beware: maybe this strategy doesn't fit to your applications. And 
it's not for productive use.
I and some others surely too, would be interested in your experience 
with this patch.

>>Or would it be possible, to implement more than one swapping strategy,
>>which could be configured during make menuconfig? This would give the
>>user the chance to find the best swapping strategy for his purpose.
>>
>>
> 
>  That is another option. But I would prefer something that could be
> selected dynamically or at boot time.

Dynamic selection - this would be great. For all situations the best 
swapping strategy. On servers switched with a cronjob or a intelligent 
daemon.


Regards,
Andreas Hartmann

