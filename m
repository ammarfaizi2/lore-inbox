Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262377AbTCPFPU>; Sun, 16 Mar 2003 00:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTCPFPU>; Sun, 16 Mar 2003 00:15:20 -0500
Received: from adsl-64-165-208-253.dsl.snfc21.pacbell.net ([64.165.208.253]:12467
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262377AbTCPFPR>; Sun, 16 Mar 2003 00:15:17 -0500
Subject: Re: BitBucket: GPL-ed KitBeeper clone
From: Robert Anderson <rwa@alumni.princeton.edu>
To: Petr Baudis <pasky@ucw.cz>
Cc: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>,
       arch <arch-users@lists.fifthvision.net>
In-Reply-To: <20030316001840.GB11761@pasky.ji.cz>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl>
	<20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1> 
	<20030316001840.GB11761@pasky.ji.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Mar 2003 21:43:14 -0800
Message-Id: <1047793395.9619.173.camel@lan1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 16:18, Petr Baudis wrote:
> Dear diary, on Sat, Mar 15, 2003 at 10:53:34PM CET, I got a letter,
> where Robert Anderson <rwa@alumni.princeton.edu> told me, that...
> > On Sat, 2003-03-15 at 13:25, Daniel Phillips wrote:
> > > On Sat 15 Mar 03 17:21, Horst von Brand wrote:
> > > > Daniel Phillips <phillips@arcor.de> said:
> > > > > On Thu 13 Mar 03 01:52, Horst von Brand wrote:
> ..snip..
> > > > > Does anybody have a convenient mailing list for this design discussion?
> > > >
> > > > Good idea to move this off LKML
> > > 
> > > Yup, but nobody has offered one yet, so...
> > 
> > I think the arch-users@lists.fifthvision.net list would be happy to host
> > continuing discussion in this vein.  Considering Larry's repeated
> > attempts to get people to look at arch as a "better fit," it seems
> > particularly appropriate.
> > 
> > Of course, you'd have to tolerate "arch community" views on a lot of
> > these issues, but I suspect that might help focus the discussion.
> 
> I'm not sure if arch is the right thing to base on. Its concepts are surely
> interesting, however there are several problems (some of them may be
> subjective):

I, for one, was not necessarily interesting in "basing on" arch.  I
think what the arch crowd would like to see is what kernel developers
are asking for, first, and then potentially to relate those needs to
arch.

But, let me address some of your points anyway:

> * Terrible interface. Work with arch involves much more typing out of long
> commands (and sequences of these), subcommands and parameters to get
> functionality equivalent to the one provided much simpler by other SCMs. I see
> it is in sake of genericity and sometimes more sophisticated usage scheme, but
> I fear it can be PITA in practice for daily work.

The commands are verbose, but they are verbose for the simple reason
that the command set for arch is very rich, and verbosity is somewhat
necessary to avoid ambiguity.  I would certainly recommend the use of
completion facilities to use the command set as it exists natively.  If
you are a bash user, try the bash completion code here:

rwa@alumni.princeton.edu--rwa-2003
      http://rwa.homelinux.net/{public-archives}/rwa-2003

Certainly robust completion would mitigate much of the "typing problem."

But, there is also an alternate solution to this which consists of
having aliased "short forms" of the commands.  Some work has also been
done in this area to provide complete, unambiguous, and easy to type
short forms.  Search the arch mailing list archive for "short forms" for
the discussion and results so far.

> * Awful revision names (just unique ids format). Again, it involves much more
> typing

There will always be a tension between clarity and terseness of names in
general.  arch tends to the side of clarity.   You seem to favor
terseness for reasons of typing effort.  That tension can be mitigated
in any number of ways; completion probably being the most pragmatic.

 and after some hours of work, the dashes will start to dance around and
> regroup at random places in front of your eyes.

I don't think I've ever seen a complaint about "dashes dancing around in
front of people's eyes" on the mailing list since its inception.  In
fact, I've started using the double-dash separator in a number of other
contexts since growing accustomed to it as a "hard break" in a name.

 The concepts behind (like
> seamless division to multiple archives; I can't say I see sense in categories)

You can't see a sense in categories?  That statement is hard to fathom. 
Possibly you mean you don't see a sense in separate branch and version
qualifiers, and that's a more legitimate question in my view.

> are intriguing, but the result again doesn't seem very practical.

> * Evil directory naming. {arch} seems much more visible than CVS/ and SCCS/,

Well, {arch} does not litter every directory like CVS/ does.  It marks
the root of a project tree, and therefore it's actually a _nice_ thing
to have be visible.  That's the point of giving it a noticeable name. 
There's nothing "evil" about it from my perspective.

> particularly as it gets sorted as last in a directory, thus you see it at the
> bottom of ls output. Also it's a PITA with bash, as the stuff starting by '='
> (arch likes to spawn that as well)

No, it doesn't.

 is. The files starting by '+' are problem
> for vi, which is kind of flaw when they are probably the only arch files
> dedicated for editting by user (they are supposed to contain log messages).

The output of make-log is now prefixed with an absolute path; the ++
does not cause a problem in that context anymore, even with vi, i.e.:

vi `larch make-log`

is fine now.

While I think both the ++ and = convention should be reconsidered as
users almost uniformly resist them when first getting used to arch, I
don't think this is much of a substantive problem.  It's just a
character or two, after all.

> * Cloud of shell scripts. It poses a lot of limitations which are pain to work
> around (including speed, two-fields version numbers [eek] and I can imagine
> several others; I'm not sure about these though, so I won't name further; you
> can possibly imagine something by yourself).

Out of curiosity, what is your favorite language that you would like to
see arch implemented in?  Some of the usual concerns regarding shell
scripts having been addressed on the wiki under "ArchMyths."

> * Absence of sufficient merging ability,

With all due respect, I think this reveals your level of familiarity
with arch to be, umm, not high.  I'm not aware of any revision control
system that has the depth of capability that arch has with respect to
merging.  BitKeeper may; I'm not a BitKeeper expert, but I'm pretty sure
nothing else comes close.

 at least impression I got from the
> documentation. Merging on the *.rej files level I cannot call sufficient ;-).

I think you've misunderstood something fairly basic.

> Also, history is not preserved during merging, which is quite fatal.

Which documentation were you reading again?  I'm not being facetious,
there's several versions of various forms of documentation still around,
I'd like to know which one gave you that impression.

  And it
> looks to me at least from the documentation that arch is still in the
> update-before-commit stage.

I'm not sure what the "update-before-commit stage" is.  Can you clarify?

> * Absence of checkin/commit distinction. File revisions and changesets seem to
> be tied together, losing some of the cute flexibility BK has.

I'm not aware of any such thing as a "file revision" in arch.  Perhaps
you could expand on what that is and why you think you need such a
thing.

> I must have missed terribly something in the documentation

Yes, I believe you did.

 given how arch is
> being recommended, please feel encouraged to correct me. But as I see it, most
> of the juicy stuff is missing

Let's start with the above problems with your first reading of the docs,
then we'll move onto the "juicy stuff."

 (altough I really like the concept of
> configurations and especially the concept of caching --- mainly that you do not
> _have_ to pull all the stuff from the clonee repository, which can be a pain
> with more poor internet connection; then also if you aren't doing any that big
> changes and you're confident that the remote repository is going to stay there,
> it is less expensive to talk with the repository over network)

Signs of life... :)

 and the existing
> stuff is mostly in the form of shell scripts, which it has to leave and be
> rewritten sooner or later anyway.

Most of us would probably like to see that, but I think "has to" is
debatable.

  The backend history format doesn't appear to
> be particularily great as well. Dunno. What's so special about arch then?

Let's talk about what kernel developers think they need, then we can
frame "what is so special about arch" in terms of that.  I think that's
a reasonable way to frame the discussion.

Bob


