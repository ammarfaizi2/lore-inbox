Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACWz5>; Wed, 3 Jan 2001 17:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRACWzi>; Wed, 3 Jan 2001 17:55:38 -0500
Received: from [212.187.138.98] ([212.187.138.98]:32265 "HELO
	opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S129771AbRACWzh>; Wed, 3 Jan 2001 17:55:37 -0500
Date: Wed, 3 Jan 2001 22:55:40 +0000 (GMT)
From: Mark Zealey <mark@itsolve.co.uk>
To: Alexander Viro <viro@math.psu.edu>
cc: Dan Hollis <goemon@anime.net>, Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.GSO.4.21.0101031740340.17363-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0101032254040.1150-100000@sunbeam.itsolve.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Alexander Viro wrote:

> 
> 
> On Wed, 3 Jan 2001, Mark Zealey wrote:
> 
> > On Wed, 3 Jan 2001, Alexander Viro wrote:
> > 
> > > 
> > > 
> > > On Wed, 3 Jan 2001, Dan Hollis wrote:
> > > 
> > > > On Wed, 3 Jan 2001, Alexander Viro wrote:
> > > > > On Wed, 3 Jan 2001, Dan Aloni wrote:
> > > > > > without breaking anything. It also reports of such calls by using printk.
> > > > > Get real.
> > > > 
> > > > Why do you always have to be insulting alex? Sheesh.
> > > 
> > > Sigh... Not intended to be an insult. Plain and simple advice. Idea is
> > > broken for absolutely obvious reasons (namely, every real-life program
> > 
> > This doesnt stop syscalls, only syscalls from writable areas.
> 
> And? Syscall is a couple of bytes. 0xcd and 0x80. Find one in non-writable
> area, put whatever you want into registers and jump to the address where
> these two bytes sit. Voila. If all such places are in writable areas -
> there you go, the process you've attacked could not perform any
> system calls itself.

And the ret and other stuff, you now have to search thru memory for a
10-byte sequance (sya?) to do the correct thing, what are the chances of
finding that, never mind coding all the stuff to find that into a faked
packet or whatever, this is gonna make the r00ter's life (do they have
one? ;) a lot harder, plus it will take a while to make a solution that
works.

> 
> Come on, folks, you can't be serious - think for a couple of minutes and
> you'll come up with a trivial way to work around such protection. In a
> dozen bytes or so.
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
