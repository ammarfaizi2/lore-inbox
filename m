Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313912AbSDUVun>; Sun, 21 Apr 2002 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDUVum>; Sun, 21 Apr 2002 17:50:42 -0400
Received: from pc132.utati.net ([216.143.22.132]:59546 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313902AbSDUVuf>; Sun, 21 Apr 2002 17:50:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sun, 21 Apr 2002 11:52:01 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421080030.44E2647B@merlin.webofficenow.com> <E16yx1z-0000jV-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020421221109.44A3047B@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 11:44 am, Daniel Phillips wrote:
> Here's my wrapup...
>
> On Sunday 21 April 2002 03:41, Rob Landley wrote:
> > On Friday 19 April 2002 06:34 pm, Daniel Phillips wrote:
> > > I'm not arguing that BK is not a good way to do the grunt maintainance
> > > work. I think it is, and that's great.  Heck, I'm not arguing against
> > > Bitkeeper *at all*.  I'm arguing against building the bitkeeper
> > > documentation into the kernel tree, giving the impression that
> > > Bitkeeper is *required* for submitting patches.
> >
> > I'm under the impression that Linus specifically asked for that
> > documentation, because BK is a tool he used that he was getting flooded
> > with questions about.
>
> Yes, it came out in the course of the thread - Linus and Jeff had a private
> email exchange in which Linus add Jeff to push his Bitkeeper documentation
> files into the tree.  Linus's tree, which is of course, 'our' tree as well,
> in the sense that everybody here has code in it.

You could say the same of Alan Cox's tree, Marcelo's tree, or Dave Jones's 
tree.  They're all public trees acting in some capacity as code integration 
and exchange points.

> So... there are some who perceive the advent of Bitkeeper as a kind of
> creeping takeover of the Linux development toolchain, and for these people,
> seeing the documentation files appear in the Documentation directory as if
> Bitkeeper were not only *a* sourcecode management tool, but *the* Linux
> sourcecode management tool, is an irritant.

Nopt the Linux source code management tool, the *Linus* source code 
management tool.

Yeah, I typo those two myself all the time.  (I wonder if Linus himself does? 
:)

> Any argument that these people exist, or that they are irritated?

There are people still mightily upset that devfs is in the tree, and see THAT 
as a creeping takeover.  And ACPI -IS- a creeping takeover, although mostly 
on the part of hardware manufacturers.

The existence of irritated people is a constant.  There are a bunch of very 
high level people irritated by the binary modules policy (on both ends: that 
binary-only modules are allowed at all, AND that there's no consistent binary 
module interface from version to version).  And both sides have a point, but 
reality continues unimpeded regardless.

If Linus is documenting how to work with Linus, it's his right.  The process 
could involve a live chicken and spandex, and if that's what he has found to 
be the most efficient way to work...

Putting the submitting patches stuff together into a single subdirectory and 
pointing out that what's being documented is actually Linus, not the tools 
themselves, would probably help clarify the issue a bit.

> By the way, I'm not one of them, and I'm not going to do any further
> speaking for them.

Why have you done this much?

> I have my own agenda: I'd like to see the development process carried out
> more in the open and to that extent, increasing reliance on Bitkeeper,
> with its convenient point-to-point push/pull paths is worrisome.

So you're worried that the other tool is convenient?

Does  this mean you want developers to use something inconvenient?  Or make 
it 

If Linus and the top dozen lieutenants all had special scripts and encryption 
keys set up (all using open source software) so that their code got to each 
other's systems more easily and was looked at first before shoveling through 
the signal to noise ratio on lkml, or the random spam linus gets daily 
porting some subsystem to c++...

Bitkeeper is not open source, but it's by no means exclusive. 

The above scenario would be open source, but there -IS- no software more 
exclusive than GPG.  (That's what it's FOR...)

> Al's kind of a special case though.  What we have now is, *everybody* with
> a piece of kernel to maintain is in on the private, point-to-point thing
> now.  It's efficient, no doubt, but I fear we're also weakening one of one
> the basic driving forces of Linux development, that is, the public debate
> part.

Cut, halt, wait, stop, hold it, whoa, cease, desist...

Bit of momentum built up there.

I should write a "patch penguin aftermath" thing with what we all LEARNED 
from this.  Linus has seperated the maintainers list into two layers because 
he cream-skimmed out a half dozen lieutenents in charge of major subsystems.  
Those lieutenants have a direct hotline to Linus, and the maintainers are 
expected to filter their patches through them.  Individual contributers 
filter their patches through the maintainers, then the lieutenants, then 
Linus.

This is not a bad thing, it means that by the time Linus sees code it's been 
code reviewed by two people: one with intimate knowledge of the particular 
subsystem and the other with broader knowledge of other areas it needs to 
interoprate with.

And this hierarchy, now that people know about it, is probably equally as 
responsible for the declogging of the patch queue as Bitkeeper is.  Now when 
a filesystem patch gets ignored by linus, people know they have to get Jens 
Axboe to sign off on it first.

A list of who the lieutenants are and what maintainers are under them would 
be a worthy goal.  I've tried to assemble such a list a couple times, but 
it's too much of a judgement call from this end.  (And Linus doesn't want to 
be pinned down.)  Off the top of my head, Al Viro, Jens Axboe, Greg KH, Jeff 
Garzik, and Dave Jones all seem to be people Linus listens directly to on a 
regular basis.  Strangely enough Andrea Arcangeli is NOT: his patches tend to 
get filtered through somebody like Dave before winding up in Linus's tree, 
although Linus does irregularly scoop them up directly as well.  (Rik van 
Riel used to be, but then the whole 2.4 memory management thing happened...)

The important thing is that a maintainer know who their lieutenant is, when 
there's somebody they need to go through to get Linus's attention.

And all this has NOTHING to do with bitkeeper.

> If you go take a survey of current lkml postings you won't find a
> lot of design discussion there, even though a huge amount of design work
> is taking place at the moment, and many changes are taking place that will
> affect kernel development for years to come.

O(1) scheduler and numa?  Preemptible kernel?  Reverse mapping VM?  Ratcache 
page tables?  Software suspend?  The new build system?  Redoing the boot 
process around ramfs?  Are you saying these haven't been discussed?

I seem to remember rather a LOT of discussion of Jens' new block layer (about 
half of which I could follow), and the need to slash-and-burn the SCSI 
subsystem.  And the big move away from device numbers Linus was on about a 
while back still doesn't seem to have happened yet, although they've been 
busy...

> It used to be that every major change would start with an [RFC].

When exactly was this mythical golden age, and did it last longer than a 
month?  I don't remember the VM switch in 2.4.10 involving an RFC at any 
point.  And there were about five different proposed scheduler rewrites being 
argued over for most of a year, which were all obsolted by Ingo's O(1) 
scheduler which basically came out of the blue one day and was in the kernel 
a week or two later...

>  Now the
> typical way is to build private concensus between a few well-placed
> individuals and go straight from there to feeding patches.  At least,
> that's my impression of the trend.

It continues to be Linus's call about what goes into Linus's tree.  There 
have been times when he's disagreed with EVERYBODY else.  (Is there somebody 
OTHER than Linus who thinks having a kernel level debugger would be a bad 
idea?)

http://lwn.net/2000/0914/a/lt-debugger.php3

Anything else has been, and continues to be, an illusion.  We have the choice 
of using other trees if this is unacceptable, but so far it's been rather 
nice.  Consensus is a convenience, nothing more.

> This may in fact be nothing more than a fear.  However if there is any
> chance I'm talking about a real phenomenon then I would indeed be remiss in
> failing to draw attention to it.

So you aren't proposing a solution, are not even entirely certain of the 
nature (or existence) of the problem, but you'd like to draw attention to an 
issue?  Just trying to understand here...

Generally, in a situation like that, I try asking questions.  Works For Me 
(tm).  (And yes posting errors (or guesses) is often more effective than 
asking questions, but the goal's the same...)

> If it's a real phenomenon then the question is, what if anything needs to
> be done about it?

That sentence belongs in congress, not on a technical list...

> Well, I'm not going to suggest anything at the moment
> because, in truth, I don't have concrete suggestions to make, I just have
> a nagging feeling that now is the time to apply a bit of the old eternal
> vigilance.

What's the status of integrating the ext2 directory index stuff into ext3, by 
the way?  (I realise that's completely off topic, but I'm curious...)

> Besides, OLS is coming up fast, and there the price of a plane ticket buys
> you the chance to be part of the cabal (oops, the cabal that doesn't
> exist) for a week.  Erm, and if there are real issues, they are certain to
> be raised.

There Is No Cabal (tm).

> All that said, I have to observe that the current process is *not broken*

Use a bigger hammer. :)

> > It seems like the BitKeeper documentation belongs together with the other
> > submitting patches documentation, and should be moved to the directory
> > "Documentation/Linus".
>
> Well you know, that would be nice.  At least it would show a little
> sensitivity to the issue.  Though arguably the prospect of Linus acting
> sensitive could be more worrisome than anything ;-)

Okay, step back and ask the question: What do you WANT?  (Do you HAVE a goal 
in mind in this discussion?  I generally fall back on "education" myself.  
Good, all-purpose goal.  But it does tend to involve a different ratio of 
declarative to interrogative statements.  Or at least a lot of weasel words 
like "tends" and "generally" indicating willingness to be contradicted... :)

> > And this differs from emailing him a patch without cc'ing linux-kernel in
> > what way?
>
> Depending on the nature of the patch, both are wrong.

Memo to self: emailing a patch to Linus is wrong.  Check.

> It's just getting
> very easy to mix fundamental changes in with the 'boring' patch stream. 
> IMHO, the temptation to do this needs to be resisted.

You mean like the out of the blue 2.4.10 VM switch?

What do you mean "needs"? Who needs it?  (Is this the same "they" who are not 
members of the cabal?  Everybody's doing it?  Nixon's "silent majority".)

> > Either you trust Linus's judgment about what patches to accept, or you
> > use somebody else's tree.  Did I miss where voting on linux-kernel ever
> > got a patch in that Linus didn't want to merge, or kept one out that he
> > did?
>
> Not voting, discussion.  Without the discussion we miss the chance to get
> thousands of eyeballs on the issue, some of which may be more experienced
> in certain aspects of the work than the designer/submitted.

Open source is good at debugging.  AFTER the fact.  People notice WHEN it 
breaks, not that it's GOING to break.

Linus released a brown paper bag 2.2.0 and 2.4.0 largely because everybody 
who was going to test it ahead of time already HAD, and the ONLY way to find 
the remaining bugs was to let people put it into service in the field and see 
where it broke.

The number of people who seriously thump on stuff ahead of time (run 
prepatches, or even the whole 2.5 development series) could probably 
comfortably fit into a single shopping mall, without making it seem 
particularly crowded...

> > And AFTER the merge, you still get to flame all you want.
>
> No no no.  Think about what you just said.  Barn.  Door.  Horse.  Gone.

Huh?  You've never seen a changelog entry with the words "back out" in it?

Think about Al Viro ripping somebody a new one because of some stupidity that 
went into the latest prepatch.  Think about what Martin is doing to all the 
block copied code Andre Hedrick put in the tree...

> > The ONLY reduction in access I can see to Linus's pending unmerged patch
> > queue is due to the fact that completed patches don't hang around
> > unmerged for months at a time anymore.  And since Bitkeeper seems to have
> > significantly contributed to lubricating Linus's in-box, I consider it a
> > net benefit.
>
> Yes, I haven't tried that yet myself but we shall see.  True, I haven't
> noticed a lot of grumbling about dropped patches lately.  Replaced by other
> grumbling I suppose.

You mean like this thread?

> > Proprietary software sucks when you derive work from it in an exclusive
> > and dependent way.  Then they own your derived work.  (Like a microsoft
> > word file you wrote, which microsoft can charge you to access because
> > they own word and your file is useless without it.)  When it's something
> > you can use but don't have to, it's basically a service.  Not owning a
> > service is unsurprising.
>
> Huh.  I think the advertising material that Bitkeeper has now got in the
> Linux tree is excessive, given its license, and I don't have more to say
> about that.

The documentation wasn't written by bitkeeper, I believe it was written by 
Jeff Garzik.  It wasn't requested or placed in the tree by bitkeeper, it was 
requested and placed in the tree by Linus.

I'm pretty darn sure this counts as an honest, spontaneous, grassroots 
endorsement.  Yes, such a thing is possible, even in the US...

Rob
