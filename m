Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUD1GEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUD1GEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264699AbUD1GEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:04:39 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:19400 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264695AbUD1GEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:04:15 -0400
In-Reply-To: <200404280323.i3S3N19W024148@pincoya.inf.utfsm.cl>
References: <200404280323.i3S3N19W024148@pincoya.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DF14FD4C-98D9-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
Date: Wed, 28 Apr 2004 02:04:12 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 27, 2004, at 11:23 PM, Horst von Brand wrote:

> Marc Boucher <marc@linuxant.com> said:
>> On Apr 27, 2004, at 8:25 PM, David Gibson wrote:
>>> On Tue, Apr 27, 2004 at 08:02:03PM -0400, Marc Boucher wrote:
>>>> Rusty, the workaround was done a while ago, back in the 2.5 days
>>>> when your new module code was still very much in flux. It was
>>>> necessary to have an effective short-term solution for the existing
>>>> installed base (2.4), since we could not continue to confuse
>>>> customers while waiting for the patch to propagate. In other cases,
>>>> we have gladly submitted patches when we encountered bugs and could
>>>> fix them. Had we known that the module fix was so simple, it would
>>>> of course have been submitted it to you in parallel.
>
>>> No, it wasn't *necessary*:  you made a choice that not confusing your
>>> customers was more important to you than not increasing the support
>>> burden on kernel developers by releasing a silently tainted module
>>> into the wild.
>
>> In an enterprise, customers always come first. Nonetheless, I don't
>> believe that this issue had a significant impact on kernel developers.
>
> You have absolutely no right to place _any_ burden at all on kernel
> hackers. "I don't believe..." just doesn't cut it.

I stated a personal opinion based on the observation that the issue was 
raised
in a politically provocative way. It didn't come up because specific 
kernel
developers were having a hard time debugging systems with our drivers.

People should understand that we are really trying to help Linux by 
providing
alternative  support and drivers for proprietary hardware that 
otherwise cannot
be easily handled in the traditional free-software ways, otherwise they 
would
already have been implemented long ago by one of the many talented 
linux kernel
hackers out there.

Folks who do not agree with the freedom of choice we are providing can 
simply
avoid  purchasing hardware without 100% open-source drivers, instead of
launching political attacks based on incorrect facts or behaving like a 
wild mob
using intimidation practices (someone posted my personal physical 
address
on Slashdot today).

>
> [...]
>
>> Futile attempts to perform license checks generating redundant and
>> confusing errors, restricting access to kernel APIs for religious
>> reasons,
>
> So? It is not _your_ call to decide under what conditions (if any) you 
> are
> allowed to use said APIs. You did not comply with the conditions as 
> stated.
> Nothing more to be said about it, you admitted so yourself.

AFAIK, no GPLONLY APIs are involved. The workaround is for a confusing
cosmetic issue that has been acknowledged by kernel developers and is
being fixed. I have also sent Rusty a proposal for a technical change 
in our
modem drivers that would restore tainting (again, there was never any 
intent,
motivation nor purpose to bypass that) while keeping the volume of 
messages
under control.

>
>> and the general lack of stable APIs and pragmatic understanding for 
>> the
>> needs of third-party driver suppliers result in much greater everyday
>> inconveniences  to ordinary users and are more damaging to the
>> acceptance
>
> Third-party driver suppliers are welcome to work _with_ the kernel
> community, who will in many cases happily fix their drivers as a 
> matter of
> course when updating the kernel. As long as source is available, that
> is. If not, hackers don't want to spend time for _others_ to be able to
> reap benefits. Go read the GPL, and then think hard about why Linux 
> hackers
> elected the GPL as the license for the kernel.

We have not asked for nor expected the kernel community to fix the 
proprietary
parts of, for the sake of example, the Conexant softmodem drivers, 
which is not
an easy task to do just from a practical point of view since it often 
requires
expensive test equipment and specialized DSP knowledge to work on 
effectively.

However the portions of our products that specifically relate to the 
linux kernel are
provided in source form and generally accessible to the community.

>
>> of linux than the theoretical inconvenience our workaround might have
>> caused to kernel developers.
>
> There is a very down-to-earth inconvenience called "license violation"
> here. You got a license to use the kernel API under certain 
> conditions, you
> violated those.

There is a very down-to-earth tendency on the part of some people to 
play
lawyer on the net and make unsubstantiated allegations.

Cordially
Marc

> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

