Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292694AbSBUSSJ>; Thu, 21 Feb 2002 13:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292695AbSBUSSA>; Thu, 21 Feb 2002 13:18:00 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4873 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S292694AbSBUSRk>;
	Thu, 21 Feb 2002 13:17:40 -0500
Message-ID: <3C75399F.8010207@evision-ventures.com>
Date: Thu, 21 Feb 2002 19:17:03 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <E16dxMU-0007eZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>In esp using a CardBus ide adapter will give you after first
>>plug: /dev/hdc, after second plug /dev/hde and so on... on 2.4.17
> 
> Just tried that - its working for me in 2.4.18pre - do you know what
> triggers that ?

1. Clarification: The system where 2.4.18rc2, 2.5.5+x

2. Yes I know it is the very same bad workflow of initialization
and deallocation routines. I suppose that the particular cause is
inside the ide_module_t area.

3. I was compleatly ignorant about calling some device eject utilities
or similar.

>>I'm just rying to clarify the code-flow before stuff like the above
>>can be cleaned up.
>>
> 
> The problem is if you keep cleaning up stuff which was there ready to
> merge new stuff, then its impossible to merge new stuff. At the moment
> there are two many cooks involved in that code. It all needs to go via one
> person and in an ordered way - even if it isnt Andre since Linus and Andre
> aren't the most compatible people 8)

Andre already asked in private if I would dare to take care of new stuff
comming from him for 2.5.5.

Please note that thus far I didn't see *any* concerete code from him.

But I still don't see any great problems in merging some forthcomming
stuff iff it comes along.

Please see as well the quite nice mode of cooperation I had with
Vojtech Pavlik.

Please note further that the foundations for true hot plugging done the
right way where comming from Pavel Machek i have just picked it up
as well as the _IDE_C mess and some other nit's here and there.

And finally - I don't do anything inside an ebony tower - I just
*post* everything to lkml - whatever finished or not.
Please feel free to discuss it.

Everybody who wants to contribute *please feel free* to post
a ide-clean-11+x.diff. I'm NOT playing hodge on the code at all!

So the political problems you talk about are perhaps just not there...

