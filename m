Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRCYPd6>; Sun, 25 Mar 2001 10:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRCYPds>; Sun, 25 Mar 2001 10:33:48 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9999 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S132038AbRCYPdi>;
	Sun, 25 Mar 2001 10:33:38 -0500
Message-ID: <3ABE0CC2.268D8C3C@evision-ventures.com>
Date: Sun, 25 Mar 2001 17:20:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <Pine.LNX.4.21.0103251156450.1863-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 25 Mar 2001, Martin Dalecki wrote:
> 
> > Ah... and of course I think this patch can already go directly
> > into the official kernel. The quality of code should permit
> > it. I would esp. request Rik van Riel to have a closer look
> > at it...
> 
> - the algorithms are just as much black magic as the old ones
> - it hasn't been tested in any other workload than your Oracle
>   server (at least, not that I've heard of)

No that's not true! Read the code please. The result is a simple
wighted sum without artificial unit.

> - the comments are just too rude  ;)
>   (though fun)

That's only a matter for the "smooth" anglosaxons. Different
cultures have different measures on this. I don't feel the need
to adjust myself to the american cultural obstructivity.
I esp. to the habit of don't saying clearly what one means if one
want's to criticize something.

> - the AGE_FACTOR calculation will overflow after the system has
>   an uptime of just _3_ days
> - your code might be good for server loads, but for normal
>   users it will kill what amounts to a random process ... this
>   is horribly wrong for desktop systems

No that isn't true.  I esp. the behaviour will be predictable.

> In short, I like some of your ideas, but I really fail to see why
> this version of the code would be any better than what we're having
> now. In fact, since there seem to be about 1000x more desktop boxes
> than Oracle boxes (probably even more), I'd say that the current
> algorithm in the kernel is better (since it's right for more systems).

You misunderstood me compleatly. I wasn't using an running oracle
db as a test case. I was using the INSTALLATION process.
Since you apparently don't know about oracle I will tell you:
It involves a lot of different applications. Infact TONS of:
Java, shell, compiler, linker, apache, perl and whatanot.

> Now if you can make something which preserves the heuristics which
> serve us so well on desktop boxes and add something that makes it
> also work on your Oracle servers, then I'd be interested.

I would like to state: The current heuristics DON'T serve us well 
on desktop boxes...

> Alternatively, I also wouldn't mind a completely new algorithm, as
> long as it turns out to work well on desktop boxes too. But remember

I was testing on a NOTEBOOK.

> that we cannot tell this without first testing the thing on a few
> dozen (hundreds?) of machines with different workloads...

That's true for sure.
