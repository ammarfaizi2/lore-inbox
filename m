Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbUK3SGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUK3SGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3R7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:59:54 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49575 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262223AbUK3RxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:53:12 -0500
Message-Id: <200411301750.iAUHooVE008263@laptop11.inf.utfsm.cl>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory 
In-Reply-To: Message from Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> 
   of "30 Nov 2004 17:03:14 -0000." <1101834194.17826.194.camel@pear.st-and.ac.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 30 Nov 2004 14:50:50 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
> On Tue, 2004-11-30 at 16:31, Horst von Brand wrote:
> > > But namespace unification is important,

> > Why? Directories are directories, files are files, file contents is file
> > contents. Mixing them up is a bad idea.

> I disagree, I think it is a good idea.

Looks that way ;-)

> Why is namespace unification important? Because you can use the same
> tools on everything. Previously, each tool could handle one namespace.

Right.

> A very simple example would be:
> I want to count the words in the Appendix of my book.

I can do it... each chapter is a separate file ;-)

> If I can't select the appendix, my "wc" tool is useless (or very
> difficult to use). On the other hand if I can say
> 
> wc ~/book/Appendix

> it's fine.

Exactly what I'd do.

>            Hans Reiser would say that "namespaces are the roads and
> waterways of the operating system" and "the value of an operating system
> is proportional to the number of connections you can make". I think he
> is right in that.

I happen to agree.

>                   And the authors of Unix knew it too, when they used
> the same namespace for devices and files. They didn't say "files are
> files and devices are devices". They said the difference should not
> matter to the applications.

Right. And network connections, and pipes (connecting programs) are files
too.

> But there is still namespace fragmentation even in Unix, and this is
> just one of them.

You are right.

The next question is "Is the fragmentation required?", and then "How would
an OS without this fragmentation work?". Anwer to the first question is
"Not really, but...", answer to the second one is "It has been tried, got
nowhere" (The various IBM minicomputer OSes had no filesystem, just a
(relational) database for everything; didn't catch on. Multiple people have
worked on "persistent programming" (data floats around, programs munge it
and then go away), even APL and similar languages worked on that principle;
none did never get anywhere near "popular". There must be other examples
around).  You can't just go around pretending an element in an array is the
same as a device or a full database, recursively.  That way lies madness,
recursion _has_ to stop somewhere.

> >  Sure, you could build a filesystem
> > of sorts (perhaps more in the vein of persistent programming, or even data
> > base systems) where there simply is no distinction (because there are no
> > differences to show), but that is something different.

> > >                                         and to unify the namespace, you
> > > have to use the same syntax. I guess you disagree with me on that. (If
> > > not, how would you do it?)
> > 
> > I'd go one level up: Eliminate the distinctions that bother you, not try to
> > patch over them.
> 
> But that is my point too.

But the result _can't_ live inside the Unix worldview, it is quite at odds
with it on a fundamental level. I.e., build an environment that works that
way, don't go around trying to pretend things are what they aren't. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
