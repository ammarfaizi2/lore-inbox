Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWESJ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWESJ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWESJ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:29:25 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:19426 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751307AbWESJ3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:29:24 -0400
Message-ID: <446D8F36.3010201@aitel.hist.no>
Date: Fri, 19 May 2006 11:26:14 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux cbon <linuxcbon@yahoo.fr>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
In-Reply-To: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux cbon wrote:

> --- Helge Hafting <helge.hafting@aitel.hist.no> a
>écrit : 
>
>  
>
>>All graphical applications - sure.
>>    
>>
>
>As already discussed here, not all graphical
>applications should be rewritten, but only some
>layers.
>And none, if we can emulate X.
>  
>
Well, sure.  You have some work to do though, all that rewriting of yours.

>
>  
>
>>Now you want to move graphichs into the kernel???
>>    
>>
>
>Unix was NOT designed for graphics.
>Linux is supposed to be *modern*.
>  
>
There is nothing "modern" about graphichs in the kernel.

You did not answer my question - because you couldn't.  You
are trapped in a logic flaw of your own.  A sane person would
admit it - you answer with meaningless talk about "being modern".

1. You dislike X for running stuff as root - that's dangerous.
    The obvious solution then, is to run X (or that rewritten X)
    in a less dangerous fashion - the only choice then is
    to run as a non-root user.

2. You want to run the graphichs in the kernel. But that is stupid,
    because it is even more dangerous than running as root.
    So you're trying to "solve" a problem by making it WORSE.
    Pretty dumb, actually.


>The kernel already drives the files system, the
>network, the cdrom, the cpu, etc. Why not the graphics
>?
>  
>
See above!  I also explained that in the previous email.
But since you are slow at getting things,
here it is again:

Kernel graphichs are more dangerous than root graphichs, so
you only make the security flaws worse by moving it into the kernel.

Don't bother arguing for "kernel graphichs" on the grounds that
it is "modern".  First, it isn't modern.  Vendors who use in-kernel
graphichs are moving away from it. The modern (and safe) approach
is graphichs separated from the kernel.  This is one of the many
things that unix got right from the very start.

Second - who cares what is "modern" or "fashionable"???
Nobody, except people buying clothes.  For computer
software, we care about stability and performance.

>Why dont we have "good" 3D support in X ?
>  
>
Wrong question - we have excellent 3D support in X.  It is called opengl,
and is really good!  Sure, it is only available for a handful of cards, 
there
are lots of good 3D cards without linux 3D support.

This problem is trivially solvable by writing drivers for the cards in
question.  A rewrite of X now, will make that process much slower,
as people will be tied up rewriting X instead of writing 3D drivers.

The problem with writing those 3D drivers is not complexity
or "historic baggage" in the X codebase.  It is the fact that
only the vendors know how the cards work, and most of them
won't tell us.

To which the solution is:  buy the cards that work, and screw the rest.
Or raise enough money to purchase specs without NDA.  A rewrite of X,
or stupidly moving graphichs into the kernel won't help with this
_at all_, the specs will still be in the dark. So you'll do all that work,
perhaps improving X a little, perhaps making it more unsafe,
and you still won't have 3D drivers for more than a handful of cards.

>>Your solution does not mean "no window system at
>>all"
>>You still got one, except now it is in the kernel
>>and
>>therefore more dangerous.  We do not have 2 os now,
>>because X is _not_ an os.  Please look up what an os
>>_is_,
>>and you'll see that. 
>>    
>>
>
>I trust the linux kernel to command my hardware
>correctly, so why not the graphical too ?
>  
>
Code does not magically become "correct"  once it gets into
the kernel.  Shifting an X graphichs driver into the kernel
won't improve code quality at all, so nothing to gain there.
If you think a rewrite will get you better code - well maybe,
but then there is no reason to stick it in the kernel.

Stuff doesn't go into the kernel because it is a nifty place to stick it.
Stuff ends up in the kernel when it absolutely have to, and this is
not the case for graphichs.  Well, perhaps a very small part,
such as the direct manipulation of hardware registers could
go in the kernel.  All the rest, i.e. higher level stuff like handling
"images", "windows", "fonts", "3D surfaces" definitely belongs
in userspace where the _inevitable_ bugs in any large piece of
software won't kill the box.

>>Also, please tell why this would be faster, simpler,
>>or
>>easier to manage.  Stuff in the kernel is generally
>>harder to manage than userspace stuff, and
>>definitely
>>not simpler.  Kernel code lives with all sorts of
>>requirements
>>and limitations that an application programmer would
>>hate
>>to have to worry about. 
>>    
>>
>
>Put X in the kernel, so we dont have 7924 bad written
>incompatible implementations of it.
>  
>
We don't have a bunch of incompatible implementations of X.
We have a single version, the newest version of x.org.
Of course there exist many older
versions (including xfree86).  Surely you can't complain
that older versions exist - that is the case for any software, including
the linux kernel.

There aren't many other X implementations for linux, certainly
none of importance.  You're mistaken here.

>Even much better : put a replacement for X (and an X
>emulation for old softwares), so we can have
>simplicity, speed, 3D etc.
>  
>
I repeat - putting software in the kernel does not magically
make it faster, simpler, or easier to manage.  It won't even
stamp out any "incompatible implementations".
There is, for example, an userspace nfs server even though
we have had kernel nfs for a long time now.

>In my opinion, graphics do belong to the OS, like
>sound, network and file system.
>  
>
That's your opinion.  As for graphichs, it is your opinion _alone_,
because it is not founded on reason.  You have failed to
provide even one example of why it'd be useful,
all your arguments either comes down to meaningless
busswords like "modern" or "your own opinion."
That won't _ever_ work here, and if you can't do better, quit!

Or show us all that you are right by rewriting a kernel X yourself.

Too much work or not interested? Neither are we!  You see, anyone
cabable of undertaking this sort of work is also capable of
visionary planning, so we _don't need you_ to provide _ideas_.

Helge Hafting
