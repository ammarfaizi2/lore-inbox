Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbRFTQxz>; Wed, 20 Jun 2001 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFTQxp>; Wed, 20 Jun 2001 12:53:45 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:65292
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264327AbRFTQxc>; Wed, 20 Jun 2001 12:53:32 -0400
Date: Wed, 20 Jun 2001 09:53:29 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
Message-ID: <20010620095329.M3089@work.bitmover.com>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010620042544.E24183@vitelus.com> <3B30BD5D.153A5FE9@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B30BD5D.153A5FE9@candelatech.com>; from greearb@candelatech.com on Wed, Jun 20, 2001 at 08:12:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 08:12:29AM -0700, Ben Greear wrote:
> Aaron Lehmann wrote:
> > On Wed, Jun 20, 2001 at 09:00:47AM +0000, Henning P. Schmiedehausen wrote:
> > > Just the fact that some people use Java (or any other language) does
> > > not mean, that they don't care about "performance, system-design or
> > > any elegance whatsoever" [2].
> > 
> > However, the very concept of Java encourages not caring about
> > "performance, system-design or any elegance whatsoever". If you cared
> 
> System-design and elegance are easy to get
> in Java, and in fact are independent of language.  Good c code will beat
> Java in most cases, performance wise, but lately the difference has become
> small enough not to matter for most applications.  Speed is not the most
> important feature in a great many programs, otherwise we'd all be using
> assembly still.
> 
> > about any of those things you would compile to native code (it exists
> > for a reason). Need run-anywhere support? Distribute sources instead.
> 
> When was the last time you wrote a large cross-platform GUI that just
> worked on other platforms, without any additional tweaking, after you
> developed it on your Linux machine?

When was the last time you did the same thing?  Nobody gets client side
Java to work properly across all the platforms without a lot of tweaking.

And the last time we did it was recently, the entire BK GUI is in tcl/tk,
almost 20,000 lines of code (that would be 80,000 for you Java fans),
and the GUI has revision history browsers, changeset browsers, source
browsers, check in tools, diff tools, rename tools, file mergers, etc.
It's pretty complete and it typically comes very close to just working
across all platforms.  The sort of differences we deal with are little
things like the font names not being the same on Unix/NT.  Java would
*love* to be that good, it's nowhere near.

Here's some more stats.  We fired up a Java based file merge tool on a
file and then did the same thing with our tk based one.  The Java tool
took 38MB to do the same merge as the tk one; the tk one took 4MB.  And
before you start saying "well, the tk one must be simplistic", we hand
the Guiffy guy our test cases all the time and it fails them.  So it's
a pretty reasonable apples to apples, in fact, it's slanted in favor of
the Java tool.

We couldn't believe that Java was really that bad so our GUI guy, Aaron
Kushner, sat down and rewrote the revision history browser in Java.
On a 500 node graph, the Java tool was up to 85MB.  The tk tool doing
the same thing was 5MB.  Note that we routinely run the tool on files 
with 4000 nodes, we can't even run the Java tool on files that big,
it crashes.

You could argue that we need custom widgets to do what we are doing,
but that's lame.  We don't need any custom widgets for tk, in fact, 
we are using straight tk, no extensions.

So, yeah, we have done what you think we haven't done, and we've tried
the Java way, we aren't making this stuff up.  We run into Java fanatics
all the time and when we start asking "so what toolkits do you use" we
get back "well, actually, err, umm, none of them are any good so we write
our own".  That's pathetic.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
