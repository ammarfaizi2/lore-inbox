Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288354AbSA2Hc5>; Tue, 29 Jan 2002 02:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSA2Hcs>; Tue, 29 Jan 2002 02:32:48 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:62091
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288354AbSA2Hcm>; Tue, 29 Jan 2002 02:32:42 -0500
Message-Id: <200201290732.g0T7WRU02551@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 02:33:24 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201282153160.10900-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201282153160.10900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 01:00 am, Linus Torvalds wrote:
> On Mon, 28 Jan 2002, Rob Landley wrote:
> > > A word of warning: good maintainers are hard to find.  Getting more of
> > > them helps, but at some point it can actually be more useful to help
> > > the _existing_ ones.  I've got about ten-twenty people I really trust,
> > > and quite frankly, the way people work is hardcoded in our DNA.  Nobody
> > > "really trusts" hundreds of people.  The way to make these things scale
> > > out more is to increase the network of trust not by trying to push it
> > > on me, but by making it more of a _network_, not a star-topology around
> > > me.
> >
> > You don't see an integration maintainer as a step in the right direction?
> > (It's not a star topology, it's a tree.)
>
> No, I don't really think an "integration manager" works well.

So what was Alan Cox doing all those years?  What is Dave Jones currently 
doing?

> I think it helps a lot to have people pick up patches that nobody else
> wants to maintain, and to gather them up. Andrea does that to some degree.

It's not a question of patches people don't want to maintain, it's a question 
of patches getting much wider testing and better feedback when they're in a 
larger tree, and the maintainers of the various patches getting better 
warning about other patches that break them or that they break other patches.

When two developers share a common tree, they notice when they break each 
other's stuff, and they resolve it.  When two developers go off in isolation, 
they break each other's stuff as a matter of course.  And testers who have to 
hunt down a patch are are willing to apply it generally aren't the ones who 
raise an objection once it gets applied to the next tree they download.

> But it is _much_ better if you have somebody who is a point-man for
> specific areas.

I'm not proposing replacing the current subsystem maintainers.  But are the 
current subsystem maintainers happy?

I thought they weren't, but I guess that by their silence, they must be 
thrilled, so...  (Sorry, I seem to be getting a lot more support in private 
than anybody is willing to cc: to the list.  I'm new at this politics 
business...)

> The problem with an overall guy is that there can't be too many of them.
> The very thing you are _complaining_ about is in fact that there are a
> number of over-all guys without clear focus, which only leads to confusion
> about who handles what.
>
> Clarity is good.

The fact Jens Axboe handles one system, Stephen C. Tweedie another, Andre 
Hedrick a third, Rik van Riel a fourth, and Eric Raymond a fifth, is not 
particularly confusing.  It's when the integration and debugging of Jens' 
patches in 2.5 blocks the inclusion of basically anything else for a month or 
two, and then Andre Hedrick has to mount a publicity campaign on linux-kernel 
to get any attention paid to his patches, and Eric's help patches get ignored 
for 33 consecutive releases.

Rik was replaced by Andrea as the VM maintainer, and Rik has publicly stated 
that he thinks you were dropping his VM patches for months at a time, while 
he was the maintainer and the VM was a subsystem definitely in need of 
patches.  Are you saying that the system was working well?  Are you saying 
that it was a one-time thing that is now resolved and won't recur?

Okay, maybe a lot of this is all miscommunication.  But that just identifies 
the TYPE of the problem, doesn't it?

> > Are you saying that Alan Cox's didn't serve a purpose during the 2.2
> > kernel time frame, and that Dave Jones is currently wasting his time?
>
> No, I'm saying that there are not very many peopel who can do it, and who
> can get the kind of trust that they are _everywhere_. Let's face it, Alan
> grew to be respected because he did lots of different stuff over many
> years, and he proved himself more than capable. And I suspect he's _quite_
> happy not being in the middle of it right now.. It's a tough job.

It is a tough job, and I understand that not everybody can be a good 
maintainer.  But currently at least Alan, Dave Jones, and Andrea are all 
maintaining their own public trees, from which they break out patches to send 
on to an "official" Linux tree.  (As for Alan not being "in the middle of 
it", he IS doing his tree again.  He's just doing it for 2.4.  He's basically 
being Marcelo's integration lieutenant.  Whatever he's burned out on, it's 
apparently not the job of maintaining a tree.  And he's doing it for Marcelo, 
whose architect role is largely rejecting as much as he possibly can since 
2.4 is not a development branch...)

You currently HAVE a de facto integration lieutenant, or else I totally 
misunderstand what Dave Jones is doing.  This is not a position for which 
applicants currently need to be interviewed, is it?  (Do you have a complaint 
with the job Dave is doing?)

> It's a lot more likely to find people who can maintain _parts_. And if
> there are patches that fall out of those parts, that tends to indicate a
> lack of modularity, and perhaps a lack of maintainer for those parts.

Sure.  But how do the maintainers piece together their code, resolve the 
obvious conflicts, and get the new stuff tested by live users in the field 
who want to live dangerously?  They USED to feed stuff into the -ac tree, 
months if not YEARS before you accepted (or rejected) it.  That's not my 
opinion or my recommendation, that's history.  I'm simply proposing that 
people consider the fact it might be an important and natural part of the 
process.  (When Alan stopped doing it, somebody else basically got shanghaied 
into doing it.)

> And more likely, even if you _do_ find ten people who can do everything,
> you don't want them to.

No, you want one guy with final responsibility for maintaining any tree.  
Committees produce mostly compromises and deadlocks.  That's why I proposed 
one guy for this job.  As I said, the CVS thing was a confusing side issue.  
(An easier way for the maintainers to do lower-friction merges with the 
integration maintainer, who would by the CVS administrator and would still 
have final say over what goes into his tree.)

But the -ac tree did not serve the same purpose as your tree did, and I was 
under the strong impression that the -ac tree DID serve a purpose.  (And, for 
Marcelo, is starting to do so again.)

There is currently no tree for provisionally integrating code.  Or for taking 
the flood of new driver patches that Alan Cox always fielded.  Not code from 
left field, but code like keith owens' new kbuild, CML2, or rik van riel's 
reverse mapping patches.  Things which have a strong possiblity of being 
integrated (two of the above you okayed at the kernel summit, one you've 
expressed interest in), and are ready for wider testing.

> 		Linus

Rob
