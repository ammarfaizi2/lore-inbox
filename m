Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSFNQdx>; Fri, 14 Jun 2002 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317952AbSFNQdx>; Fri, 14 Jun 2002 12:33:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:527 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317950AbSFNQdv> convert rfc822-to-8bit;
	Fri, 14 Jun 2002 12:33:51 -0400
Message-ID: <3D0A1AE4.3060106@evision-ventures.com>
Date: Fri, 14 Jun 2002 18:33:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Dave Jones <davej@suse.de>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.SOL.4.30.0206141758350.7326-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bartlomiej Zolnierkiewicz napisa³:
> Just my 0.02 plns...
> 
> On Fri, 14 Jun 2002, Dave Jones wrote:
> 
> 
>>On Fri, Jun 14, 2002 at 05:17:03PM +0200, Jens Axboe wrote:
>>
>> > And finally a small plea for more testing. Do you even test before
>> > blindly sending patches off to Linus?! Sometimes just watching how
>> > quickly these big patches appears makes it impossible that they have
>> > gotten any kind of testing other than the 'hey it compiles', which I
>> > think it just way too little for something that could possible screw
>> > peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
>> > currently. The success ratio of posted over working patches is too big.
> 
> I review every single patch from Martin and they are usually ok,
> but it is generally good habbit to wait for next patch before running
> previous one (just to see if there was any bugs in previous one)...

And I'm gald you do. You know that I admit if I screw
things up even in my change logs. Finally I'm sometimes just
the shield for screwups done by others. (No problem I can
take the heat :-).

>>Ditto. As we rapidly approach the 100th incarnation of Martin's IDE
>>patches, there are still cases where we die within seconds of booting
>>on some old PIO-only boxes for eg.  There seems to be far too much
>>"lets rip this out as it doesn't do much anyway" rather than fixing
>>known problems.
> 
> 
> I will try to fix them one by one soon...

Many people just do not realize that I don't hunt for the
easy fruits. I tend to solve fundamental things first before
getting down. (See for example the TCQ in and out
discussion I had with Jens - it turned out to be much
better to do the infrastructure thing at same time instead of
hacking up on the existing thing.)

Down to the point - there was *no way in hell* to
solve the PIO problems util:

1. The basic datastructures we have now where there.

2. The locking issues get resolved and take place on a sane
level.

3. The number of possible code flows got sanitized.

Heck, contrary to the habbits of many others I'm constantly
trying to explain even the reasoning behing the changes I do.
Not just what gets changes.

But fortunately right now we are indeed "getting just there" as
the fact shows that the last series of the IDE patches is moving
more and more down to the actual transport layer. And since
the overall structure starts to become more and more
clean even more and more people start to work together with
me on not just some very well separated areas like for
example host chip timing but the overall infrastructure as well.
(Adam, Bartek - I'm glad you are around :-).

Everybody out there proclaiming that this could have
all been solved far earlier by some kind of "easy" fix had just
enough of time to prove me worng on this issue.

Unless I get complains from people who work with me together
on the code itself I indeed tend to follow my own agenda
of prio.

It's that simple.

