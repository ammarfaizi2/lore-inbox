Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130319AbRACWjx>; Wed, 3 Jan 2001 17:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131802AbRACWjq>; Wed, 3 Jan 2001 17:39:46 -0500
Received: from [212.187.138.98] ([212.187.138.98]:9737 "HELO
	opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S130319AbRACWjf>; Wed, 3 Jan 2001 17:39:35 -0500
Date: Wed, 3 Jan 2001 22:39:39 +0000 (GMT)
From: Mark Zealey <mark@itsolve.co.uk>
To: Alexander Viro <viro@math.psu.edu>
cc: Dan Hollis <goemon@anime.net>, Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.GSO.4.21.0101031716000.17363-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0101032238540.1139-100000@sunbeam.itsolve.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Alexander Viro wrote:

> 
> 
> On Wed, 3 Jan 2001, Dan Hollis wrote:
> 
> > On Wed, 3 Jan 2001, Alexander Viro wrote:
> > > On Wed, 3 Jan 2001, Dan Aloni wrote:
> > > > without breaking anything. It also reports of such calls by using printk.
> > > Get real.
> > 
> > Why do you always have to be insulting alex? Sheesh.
> 
> Sigh... Not intended to be an insult. Plain and simple advice. Idea is
> broken for absolutely obvious reasons (namely, every real-life program

This doesnt stop syscalls, only syscalls from writable areas.

> contains at least one syscall that it _can_ execute). Expecting _any_
> part of userland to be rewritten into the form that would not have
> such places (i.e. all IO is done by trusted processes that poll
> memory areas shared with the programs needing said IO, exit is done
> either by explicit kill() from another process or by dumping core, signals
> are done by putting request into shared area and letting a trusted process
> do the thing, etc.) warrants such suggestion, doesn't it? If somebody
> seriously believes that it can be done (and that's the only way how this
> patch could give any protection)... Well, scratch "get real", I've got a
> nice bridge for sale.

That's a bit OTT, no? ;)

> 
> 
> 

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@itsolve.co.uk
mark@sexygeek.org
mark@x-paste.de

UL++++$ (GCM/GCS/GS/GM)GUG! dpu? s-:-@ a15! C+++>$ P++$>+++@ L+++>+++++$
!E---? W+++>$ N++@>+ o->+ w--- !M--? !V--? PS- PE--@ !PGP----? r++
!t---?@ !X---? !R- b+ !DI---? e->+++++ h+++*! y-

(www.geekcode.com)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
