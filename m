Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUASUDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUASUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:03:20 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:18512 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S261812AbUASUDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:03:16 -0500
Message-ID: <400C37E3.5020802@samwel.tk>
Date: Mon, 19 Jan 2004 21:02:43 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk> <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk> <Pine.LNX.4.53.0401191311250.8046@chaos>
In-Reply-To: <Pine.LNX.4.53.0401191311250.8046@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 19 Jan 2004, Bart Samwel wrote:
[... lots of text ...]
>>I'm not familiar with the exact history of the project, but I expect
>>that they decided to do C++ because the model they try to express is
>>best modeled using C++. This design decision can be debated, because it
>>is perfectly feasible (albeit with a lot more work) to implement an OO
>>model in C. In fact, I have helped to implement a similar framework (the
>>OKE CORRAL) which was written completely in C. But, the fact of the
>>matter is, this useful (but huge) kernel module is there now (and it has
>>been here since the early 2.2 kernels), and it was not written just to
>>"prove" that it could be done, but because C++ seemed at the time to be
>>the best language for the job. The start of this project may very well
>>predate the many times that this was hashed-over on the LKML
>>(disclaimer: I wasn't there, so I don't know). You refer to "what can
>>only be" the arrogance of the writers, yet continue by claiming:
>>
>> > I'd suggest that you spend some time converting it to C if you need
>> > that "module".
>>
>>and
>>
>> > The conversion will surely take less time than going through the
>> > kernel headers looking for "::".
>>
>>Excuse me, but before calling somebody else arrogant, I would suggest
>>that you might want check whether you're not calling the kettle black.
>>It's not a sign of modesty when you assume without a trace of doubt that
>>a module (that happened to have been developed over the course of four
>>years by a team of people at MIT) is just a "\"module\"" and that it
>>will take less time to port it to C than to make the kernel headers
>>parse in a C++ extern "C" clause. In addition, imagine how you would
>>feel if somebody referred to your work as a "\"module\""! The fact that
>>you "can't imagine why anybody would even attempt to write a kernel
>>module in C++" may just as well be due to a lack of imagination on your
>>side, but in your statement I detect no trace of a doubt. And _yes_ you
>>may very well be right about their initial decision being stupid (and
>>you might not be -- I don't know), and _yes_ you are probably right
>>about the whole thing being hashed-over many times (I don't know -- I
>>wasn't there), and _yes_ there are people out there who would do
>>anything just to prove they can do something others think is impossible
>>or just filthy. So, yes, there _may_ be a point to what you're saying.
>>_May_. I'm not saying you're wrong, and I'm not saying you're right.
>>What I'm saying is that simply assuming that any C++ module is nothing
>>more than a few lines of (de)glorified C and accusing the writers of
>>being arrogant just because they wrote a kernel module in C++ is, in my
>>opinion, jumping to conclusions based on
>>technical-preference-turned-prejudice (at least, that's how it seems),
>>and it's not very polite either.
> 
> The possibility that something may have been written by some MIT people
> can't change the fact that C++ is not the tool that should have been
> used within the kernel. I once worked on a project at Princeton. That
> doesn't make me know anything about Relativity. Einstein didn't rub
> off due to some proximity effect.

No. But the fact that you haven't seen the module means that you can't 
possibly know whether the module is a "\"module\"" or just a "module" -- 
there are probably solid technical reasons to dislike C++ in the kernel, 
but that is no excuse to start calling things "\"module\"" instead of 
just "module". The fact that you're now attacking this minor point (the 
fact that these people happen to be MIT people) means that you missed 
the major point -- you were jumping to conclusions and calling people 
arrogant without checking the specific background, and without reserve. 
I usually think it's wise to *either* not check the background *or* keep 
no reserve, but not both. But that's just me. :)

> If the "MIT Team", as you so state, had actually inspected some
> kernel code, and actually understood what a Linux/Unix kernel does,
> then learned persons could not possibly have selected C++ for this
> project.
> 
> If you review the project, you will probably also find that a
> large percentage of the code should have been implemented in
> user-mode (a daemon, or several). That's where C++ really shines.

For most projects, you might be right. For this project, I think you're 
not. This project implements a new network router design, one that is 
aimed at achieving the best possible routing performance that can be 
achieved while maintaining maximum flexibility. The flexibility is 
achieved by having large amounts of configurable elements available, so 
that practically any routing task can be composed of the available 
elements. To achieve enough speed (and lack of latency) to be really 
viable as a router, they need to be as close to the hardware as 
possible. See it like this: as soon as pkttables can be moved to 
userspace with negligible performance loss, this app will be able to 
move too.

> However, it wasn't. Which, to me, means that the developers
> were either clue-less or, once somebody actually figured out
> how a kernel works, it was way too late to change (an all to common
> problem).

The router code of the project works both in userspace and in 
kernel-space. It just works much slower in userspace. If they were able 
to get the right kind of performance in userspace they probably would. 
AFAIK these guys were also very early in the adoption of polling, 
according to the changelog they built polling support in April 2000. 
This got them a 4-5x speed increase. Not your typical project that you 
can make a daemon -- unless you're working in a microkernel OS, of 
course. Definitely not in Linux 2.2.

> The number of persons who worked on a project does not affect the
> correctness of the tools nor the architecture chosen. Facts are
> not democratic. You can't vote them into or out of existence.

The main point of that phrase was to indicate that more than four 
person-years went into this module. It didn't have anything to do with 
facts regarding correctness nor architecture, only with the fact that 
you stated without much reserve something that led me to believe that 
you had not considered that the size of this module may be larger than 
you imagined.

>>Unfortunately, this is how flame wars get started (as can be seen by the
>>slightly agitated tone this message has taken, sorry about that! :) ).
>>Just to make this clear to everyone: I'm not trying to instigate a flame
>>war here about C vs. C++, as I don't really have an opinion on that
>>subject. This posting has to do with my preferences w.r.t. personal
>>style, and nothing with my technical preferences.
> 
> This is not about preferences. Most software engineers wish that
> everything could be done using the first language they learned. Once
> they try to write a state-machine in FORTRAN (my native language), they
> begin to understand that there are other tools more suited for the
> job. Unfortunately, especially for students at well-known universities,
> learning a language often opens the door to a cult. I remember
> the "Pascal cult", the "forth cult", the "C cult" the "C++ cult", and
> now the "C# cult". Next year there may be "D" and the cycle will
> continue.

Yes, I know how this works. Although I have never programmed in FORTRAN, 
I have at least 15 other languages on my list (covering all of the 
well-known paradigms), not counting scripting languages, and I know that 
there is definitely a thing such as "the right tool for the right job". 
I do not dispute that. What I care about is your response, which seemed 
to indicate that you had already grouped the module authors in the "C++ 
cult" category, without keeping open the possibility that they might not 
be. You had already called them arrogant without checking any 
background. I don't care if they _are_ part of the "C++ cult", as you 
call it, but you had not enough information at this point to derive 
that. It seems that you're so allergic to the idea of mixing C++ with 
the kernel that you're blocking all possibility of discussion 
immediately. Calling somebody "arrogant" before they can even tell you 
why they did what they did is a perfect way to prevent any reasonable 
conversation from happening. It's not productive towards solving the 
problem at hand, and also not towards convincing people of your opinion.

-- Bart
