Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310553AbSCLLYk>; Tue, 12 Mar 2002 06:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310552AbSCLLYV>; Tue, 12 Mar 2002 06:24:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56583 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310284AbSCLLYJ>; Tue, 12 Mar 2002 06:24:09 -0500
Message-ID: <3C8DE4CC.9060302@evision-ventures.com>
Date: Tue, 12 Mar 2002 12:21:48 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>, andersen@codepoet.org,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com> <3C8D692B.7070508@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
> 
>>
>> On Mon, 11 Mar 2002, Jeff Garzik wrote:
>>
>>> You have convinced me that unconditional filtering is bad.  But I still
>>> think people should be provided the option to filter if they so desire.
>>>
>>
>> Hey, choice is always good, except if it adds complexity.
>>
>> The problem with conditional filtering is that either it is a boot (or
>> compile time) option, or it is a dynamic filter.
>>
> heh, I couldn't have given a better argument against a dynamic filter.
> 
> I was actually assuming the filter would be a compile-time option, for 
> security's sake.  Boot-time option works too.
> 
> So, it sounds like you could be sold on an fixed-at-compile-time filter 
> that can be disabled at boot :)  I know you don't like 
> fixed-at-compile-time as you mentioned, but it's my argument there is a 
> class of users that definitely do.  MandrakeSoft would likely enable the 
> filter in the "secure" kernel and disable it in the "normal" kernel, for 
> example.

Mandrake Soft should disable the whole sidestepping
ioctl - even the generic one - in a secure kernel.
Filtering them all to -EINVAL is the bast one can do for *security*.
The stuff which is not should be implemented with generic ioctl
with a proper sementics.

Rings a bell?

No matter how you turn it it turns out that the taskfile stuff as it
is is just useless - formal verification inside the kernel can
be done at coding time. Formal verification for vendor specific
stuff can be done in user land. Formal verification for security
stuff doens't make sense, becouse the whole interface doesn't
make sense for security concerns. Formal verification of the
commands for political reasons is just plain naive...

