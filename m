Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268689AbUIGVvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbUIGVvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUIGVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:49:03 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:9740 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268261AbUIGVrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:47:21 -0400
Date: Tue, 7 Sep 2004 14:44:56 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Huey <bhuey@lnxw.com>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040907214456.GA6137@nietzsche.lynx.com>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <1094150760.5809.30.camel@localhost.localdomain> <20040902215627.GA15688@nietzsche.lynx.com> <1094165289.6163.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094165289.6163.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:48:10PM +0100, Alan Cox wrote:
> On Iau, 2004-09-02 at 22:56, Bill Huey wrote:
> > It also depends on who you ask. I can't take a lot of the mainstream
> > X folks serious since they are still using integer math as parameters
> 
> The X folks know what they are doing. Modern X has a complete
> compositing model. Modern X has a superb font handling system. Nobody
> broke anything along the way. The new API's can be mixed with the old,
> there are good fallbacks for old servers.

Keith Packard knows what he's doing. The rest that don't follow his lead
on these issues are useless or detracting and redirecting resources away
from critical problems that have been solved under other, more mature,
operating systems, specifically Apple's OS X.

Notice, that you didn't deflect the claim that folks are still using
integer math to draw things. This is critical...

> In fact they are so good at it that most people don't notice beyond the
> fact their UI looks better than before.
> 
> That is how you do change *right*

It's one way, but it's not top-level redesign heavily enough that you still
have a substandard rendering system. Notice that were wasn't a mention of
device independent rendering, WYSIWYG (what you get is what you see) in
their rasterization model, nor was there any mention of how a scalable
unified rasterization model used in an application. OpenStep ruled during
it's time and rendered and generate better PostScript than Macintosh
applications because of this unified rasterization model. Split development
and the lack of "connecting the dots" across systems is one of the reasons
why X has such poor app development. It takes way more time to do things
in this environment than in other system.

What folks X land are missing here is a notion of design verses piecewise
hacks to half emulate a critical function. The fault in this matter is
really spread out to multipule camps not doing their homework regarding
these matters.

Also, there's no mention of making OpenGL a first class citizen in this
system so that all compositing is hardware accelerate. What OS has this ?
You guess it Apple's OS X has this with full transparency and bitmap
backstore for region invalidating and redrawing. X currently has none of
this stuff. You could say that this is planned in the future, but there
has been no push for doing this in this aggressive a manner which is a
leadership failure of that community as a whole.

Also, the notion of color space, not just RGB, but CMYK is a first class
citizen in Display Postscript. X is also missing this. These aren't
things that you can gradually add in. It's about looking at the system
from the top-down and solving these problems using other systems that.

X is at best piecewise and substandard to just about any modern rendering
system that I've used.

> > more dynamic systems. And the advent of XML (basically a primitive and
> > flat model of what Hans is doing) for .NET style systems are going to
> 
> I see you don't really get XML either. XML is just an encoding. Its
> larger and prettier than ASN.1 and easier to hack about with perl. You
> can do the same thing with lisp lists for that matter.

I get it fine. What you don't get is something called Model View Controller
in that .NET applications have the ability to take that serialized structure,
apart of their entire object store/serialization system and transform
it into many views. The same widget data can be used not only to build HTML
for a web page, but also a standard component driven GUI system a native
windowing kit. This exploits polymorphism and how OOP should have been
done in the first place. This use of it is very important and obviously
useful in this case.

In MVC, all data has relationships and XML s the kind of DB format that these
systems use for object serialization. XML is the storage layer in these systems.
It's used for every object, remote or local.

This is why something like Reiser FS 4 with it's persistent object store
capability may have a critical influence on how these systems are built.
These systems are returning nothing but structured storage in the form
of XML analougs.

Your Perl/Python, what ever example here doesn't cut it and explicate
how XML based system are being generically used in this sense. It's too
technically shallow for this context.

> > have been lost to older commericial interests (Microsoft Win32) and that
> > has wiped out the fundamental classic computer science backing this from
> > history. This simple "MP3 metadata" stuff is a very superficial example
> > of how something like this is used.
> 
> The trouble with computer science is that most of it sucks in the real
> world. We don't write our OS's in Standard ML, we don't implement some
> of the provably secure capability computing models. At the end of the
> day they are neat, elegant and useless to real people.

Java and .NET are just those things that you have been talking about.
As these systems become more and more prevalent (they will) they're
influence is just the beginning. These system have pretty much happened
overnight and can't be ignored by kernel folks.

> > Unix folks tend to forget that since they either have never done this
> > kind of programming or never understood why this existed in the first
> > place. It's about a top-down methodology effecting the entire design of
> > the software system, not just purity Unix. If it can be integrate
> > smoothly into the system, then it should IMO.
> 
> The Unix world succeeded because Unix (at least in v7 days) was the
> other way around to every other grungy OS on the planet. It had only
> thing things it needed. I've used some of the grungy crawly horrors that
> were its rivals and there is a reason they don't exist any more.

Look, I agree with you for the most part about Unix, but these issues
have to be reexamined again after some period of time has elapsed.

I can only guess that some of these system are horribly implemented
minimally, but I can't comment about their original intentions since
I've personally never used them.
 
> I would sum up the essence of the unix kernel side as
> 	- Does only what it must do
> 	- "Makes the usual easy makes the unusual possible"
> 	- Has an API that is small enough for developers to learn
> 	  easily (an API so good every other OS promptly ripped it off)
> 	  People forget the worlds of SYS$QIO, RMS, FCB's and the like
> 
> Its worked remarkably well for a very very long time, and most of the
> nasties have come from people trying to break that model or not
> understanding it.

This is a difficult topic, but I don't how folks can dimiss something
like Reiser FS semantics and the importance of systems like this for
future software design across all application boundaries.

There has to be a way of getting this stuff in and keeping the traditional
semantics in place.

I was thinking about have a dual mounted file system, one with traditional
Unix semantics with read-only permissions, but then having it also being
mounted in a special namespace directory structure (something like /proc)
that would reveal other streams for "stream aware" applications with
read/write permissions.

It might solve both problems in this case. Don't know.

I've been on vacation for the last couple of days at Burning Man, which
is why this response has been delayed. :)

bill

