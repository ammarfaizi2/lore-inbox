Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSBLLCT>; Tue, 12 Feb 2002 06:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290966AbSBLLCK>; Tue, 12 Feb 2002 06:02:10 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:5814 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S290965AbSBLLCA>; Tue, 12 Feb 2002 06:02:00 -0500
Message-ID: <20020212030159.03649@helen.CS.Berkeley.EDU>
Date: Tue, 12 Feb 2002 03:01:59 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Larry McVoy <lm@work.bitmover.com>, Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.89.1
In-Reply-To: <20020211070009.S28640@work.bitmover.com>; from Larry McVoy on Mon, Feb 11, 2002 at 07:00:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Larry McVoy (lm@bitmover.com):
> On Mon, Feb 11, 2002 at 12:20:57AM -0800, Josh MacDonald wrote:
> > > In essence arch isn't that different from RCS in that arch is
> > > fundamentally a diff&patch based system with all of the limitations that
> > > implies.  There are very good reasons that BK, ClearCase, Aide De Camp,
> > > and other high end systems, are *not* diff&patch based revision histories,
> > > they are weave based.  Doing a weave based system is substantially
> > > harder but has some nice attributes.  Simple things like extracting any
> > > version of the file takes constant time, regardless of which version.
> > > Annotated listings work correctly in the face of multiple branches and
> > > multiple merges.  The revision history files are typically smaller,
> > > and are much smaller than arch's context diff based patches.
> > 
> > Larry, I don't think you're saying what you mean to say, and I doubt
> > that what you mean to say is even correct.  In fact, I've got a
> > master's thesis to prove you wrong.  I wish you would spend more time
> > thinking and less time flaming or actually _do some research_.
> 
> Right, of course your masters thesis is much better than the fact that
> I've designed and shipped 2 SCM systems, not to mention the 7 years of
> research and development, which included reading lots of papers, even
> the xdelta papers.

I'm impressed.

> > But as I understand your weave method, its not even linear as a
> > function of version size, its a function of _archive size_.  The
> > archive is the sum of the versions woven together, and that means your
> > operation is really O(N+A) = O(A).
> 
> The statement was "extracting *any* version of the file takes constant
> time, regardless of which version".  It's a correct statement and 
> attempts to twist it into something else won't work.  And no diff&patch
> based system can hope to achieve the same performance.

Didn't you read what I wrote?

> > Let's suppose that by "diff&patch" you really mean RCS--generalization
> > doesn't work here.  
> 
> Actually, generalization works just fine.  By diff&patch I mean any system
> which incrementally builds up the result in a multipass, where the number
> of passes == the number of deltas needed to build the final result.  

No, I guess you didn't read what I wrote.

> > Your argument supposes that the cost of an RCS
> > operation is dominated by the application of an unbounded chain of
> > deltas.  The cost of that sub-operation is linear as a function of the
> > chain length C.  RCS has to process a version of length N, an archive
> > of size A, and a chain of length C giving a total time complexity of
> > O(N+C+A) = O(C+A).
> > 
> > And you would like us to believe that the weave method is faster
> > because of that extra processing cost (i.e., O(A) < O(C+A)).  I doubt
> > it.
> 
> Hmm, aren't you the guy who started out this post accusing me (with
> no grounds, I might add) of not doing my homework?  And how are we
> to take this "I doubt it" statement?  Like you didn't go do your
> homework, perhaps?

You haven't denied the claim either.  I said you were wrong on your
regarding complexity analysis.  You're ignoring the cost of disk 
accesses which have nothing to do with "number of deltas needed to
build a final result".  Do you ever say something with less than
100% confidence?  I should hope so, given how often you're wrong.

> > [etc]
> > The cost of these operations is likely dominated by the number of
> > blocks transferred to or from the disk, period.
> 
> I notice that in your entire discussion, you failed to address my point
> about annotated listings.  Perhaps you could explain to us how you get an
> annotated listing out of arch or xdelta and the performance implications
> of doing so.

Separate problems, separate solutions.

> > So from my point of view, the "weave" method looks pretty inadequate.
> 
> I'm sure it does, you are promoting xdelta, so anything else must be bad.
> I am a bit curious, do you even know what a weave is?  Can you explain 
> how one works?  Surely, after all that flaming, you do know how they 
> work, right?

Of course.  But disk transfer cost is the same whether you're in RCS
or SCCS, and rename is still a very expensive way to update your files.

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
