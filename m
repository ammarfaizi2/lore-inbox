Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQLNBcR>; Wed, 13 Dec 2000 20:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQLNBcI>; Wed, 13 Dec 2000 20:32:08 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:60165 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129736AbQLNBb6>;
	Wed, 13 Dec 2000 20:31:58 -0500
Date: Wed, 13 Dec 2000 18:21:31 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Alexander Viro <viro@math.psu.edu>, "Mohammad A. Haque" <mhaque@haque.net>,
        Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org,
        orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001209113439.B12659@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.21.0012131755030.24165-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > It was just an example. Basically, you'd be able to do in with just
> > > about any language that has ORBit bindings.

> Agree.  I remember a big complaint about Windows was the huge APIs,
> compared with Unix' tiny list of syscalls.  And then I saw the GNOME
> docs... ew!

Err... how about this:  Give me two or three kORBit syscalls and I can get
rid of all the other 100+ syscalls!  :) 

We're not trying to port GNOME to the kernel.  We're not trying to bloat
the kernel API, actually we're trying to do the opposite.  Consider this:

1. kORBit adds about 150k of code to the 2.4t10 kernel.
2. kNFS adds about 100k of code to the 2.4t10 kernel.
3. kORBit can do everything kNFS does, plus a WHOLE lot more: For example
   implement an NFS like server that uses SSL to send files and
   requests... so it is really actually "secure".

> > Yeah... "Infinitely extendable API" and all such. Roughly translated
> > as "we can't live without API bloat". Frankly, judging by the GNOME

<sarcasm>
Whoa, you are so right... a well defined API is a terrible thing!
Instead, lets try doing the following:

1. Define our API to be a bizarre and poorly documented collection of
   inline functions, macros, and normal functions.
2. Lets make this API have all kinds of subtle side effects, and lets not
   document these!
3. Lets raise the level that people have to be at to even TOUCH our
   APIs.  Only uber-hackers that have worked with the system for 1+ years
   should be able to comprehend what's going on in the big picture...
4. Nobody that is "allowed" to work on this thing is dumb enough to
   produce any bugs.  Because of that, debuggers are outlawed and anyone who
   attempts to debug code is shunned from existance...
5. Lets duplicate code all over the place that does mostly the same thing,
   but has subtle differences.
6. Lets structure the file layout such that files are in poorly grouped
   catagories, often with ambiguous locations, and lets drop HUNDREDS of
   .c files into individual directories.  After all that's much easier
   than actually sorting them out. 

oh wait, we have this, the Linux kernel.
</sarcasm>

Yes yes, this was definately a pot shot at the kernel tree, and I'm not at
all serious about this.  The fact of the matter, however, is that there
are a lot of cool things that a well defined interface for kernel
programming can buy you.  Yes, there is an overhead, but do you really
care about how performant your parrellel port scanner driver is?  I'm not
advocating that people write their fibre channel drivers with kORBit. :)

Actually, if you really want to get technical about this thing, I never
said anyone should use this at all.  :)  I just mentioned that it is out
there and if people feel like it they can use it or play with it.  I
happen to think it addresses a point that is currently poorly addressed in
the Linux kernel: you can't do RPCs to the kernel in a well defined
manner.  Linux is facing a crisis that is growing every day, and that is
that there is no well defined interface for drivers to use... so
compatibilty across releases it almost impossible.

Don't worry about kORBit.  Like most open source projects, it will simply
die out after a while, because people don't find it interesting and there
is really no place for it.  If it becomes useful, mature, and refined,
however, it could be a very powerful tool for a large class of problems
(like moving code OUT of the kernel).

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
