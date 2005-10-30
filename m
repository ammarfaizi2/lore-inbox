Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbVJ3CaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbVJ3CaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbVJ3CaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:30:21 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15541
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932795AbVJ3CaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:30:21 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Mark Jenkins <umjenki5@cc.umanitoba.ca>
Subject: [OT] Re: Is sharpzdc_cs.o not a derivitive work of Linux?
Date: Sat, 29 Oct 2005 21:30:08 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <43625208.60703@cc.umanitoba.ca> <200510290410.48454.rob@landley.net> <4363F2B5.6090309@cc.umanitoba.ca>
In-Reply-To: <4363F2B5.6090309@cc.umanitoba.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510292130.11182.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 17:07, Mark Jenkins wrote:
> Rob,
>
> It is wonderful that a day will come when most modules will need to use
> a symbol with attached documentation that says, "if you this symbol,
> your code will be a derivative work, and by extension you must license
> it under a GNU GPL compatible license".

Someday as Linux's internal infrastructure evolves, they'll need to drive 
internal Linux-only infrastructure to get Linux to do what they want to do, 
yes.  If Linux does things in a sufficiently different way than other 
operating systems, then they can't say "oh, this is a simple port of ancient 
unix crap, not a derived work of Linux".  (A derived work can have plenty of 
original content in it and yet still be a derived work.)

A general solution that pretty much comes about naturally, with time.  If you 
hate binary-only modules, offer to test out dynamic device numbering.

> A cynical person would respond to this and say "if somebody comes along
> and uses one of those symbols in a proprietary module, the Linux
> developers will let them get away with it".
>
> I hold no such cynicism. I believe the Linux developers would act to
> enforce their license in such a case.

Anybody who binds to a GPL_ONLY export from non-GPL code is explicitly 
violating the license, yes.  Linus has been very clear on this.  There may 
not be a bright line between light and dark here, but there's a bright line 
between light and the gray area.

> This high regard that I have for the Linux developers is why I'm willing
> to raise questions about a "binary only" module, despite the fact that
> it doesn't use any symbols labeled EXPORT_SYMBOL_GPL. Linus makes it
> clear that one can not conclude that he and others will say such a
> module is *not* a derivative work. His position was that modules *are*
> derivative works, unless a strong counter argument is made.
> (see http://people.redhat.com/arjanv/COPYING.modules)
>
> Therefor, if the Linux developers are faced with a module like
> sharpzdc_cs.o, and if they conclude that good evidence is unavailable
> that it is *not* a derivative work,

Lack of evidence to the contrary is not proof.  If you don't believe that a 
case based what you're saying could potentially drag on in court for _years_, 
then you have no business playing with the legal system at all.  (Look at the 
SCO mess, they've got _nothing_ but they've already whipped up enough smoke 
and mirrors to drag things out for two and a half years, simply because they 
have enough money to keep lawyers talking.  Between the two sides, they've 
probably burned through a hundred million dollars in legal fees and related 
costs.  With no actual _case_.)

When you go into court you either want a very, very, very bright line or you 
want the stomach to outlast the other guy in trench warfare.  If both sides 
are reasonable, you try to stay _out_ of court in the first place.

Now let's back up and look at a few fallacies in your approach here.  This is 
almost a FAQ:

1) "The Linux developers" are only a group in the way science fiction fans are 
a group.  I'm a science fiction fan, but I don't subscribe to locus magazine, 
am not on the Worldcon organizing committee, and could name a dozen other 
organizations I have nothing to do with.  I am an individual.  There are 
topics I sympathize with, but nobody speaks for me except me.

Asking "the linux developers" to do anything means finding somebody (an 
individual) to do whatever it is, and passing around some kind of petition to 
get permission from other people for that person to represent them in 
whatever issue it is.  This is a _massive_ undertaking.  (There are certain 
organizations, like OSI or OSDL, that already have the petition and 
representation part down.  For the fraction of the community, on the specific 
issues, they've already done this work for.  But on something like this, 
they'd need a renewal of that commitment: they'd have to contact people, 
gather support, lobby the undecideds, and so on.  It sounds like politics 
because it's democracy in action.  You can't represent people without their 
consent and endorsement, and it's a HUGE amount of work simply to _collect_ 
it even when they're already ready to sign up.)

2) Individual Linux developers aren't "faced with a module like 
sharpzdc_cs.o".  Most of them can happily ignore it, because they don't have 
that hardware, don't need that hardware, and have at most an academic 
interest in supporting that hardware.  It's just not important to us.  And 
_that_ means we're unlikely to stop what we're doing and go deal with it as a 
priority problem, since we've all got to-do lists a mile long.  We have 
finite time, finite attention.  You're asking us to spend donate time and 
attention to something you care about that we don't.

Are we lazy, or are we extremely busy?  (Ask any kernel developer and see if 
they can resist answering "Yes".)

Of course the other side of this is that if anybody comes to ask us to support 
about a system with a binary-only module in it, we laugh them off the stage.  
So yeah you who have such a flawed product have reason to care.  But this is 
definitely a caveat emptor situation.  Doctor, it hurts when I buy hardware 
with closed-source drivers...

3) You're asking for people to commit to a position on something we have no 
information about.  We haven't seen this module, and aren't about to come up 
to speed on it just now (see #2).  Giving you an informed answer would 
require us to do work.

4) However, we'd like to leave the option open to do something about it if we 
start to care later, for whatever reason.  (Maybe just because one of us got 
one for christmas.)  The _last_ thing you want to do is go "Ha! This right 
here is a violation, and we're not going to do anything about it! " And later 
they'll bring up before the judge that we knew about it and did nothing, and 
thus they had implicit permission or squatter's rights or something...  They 
don't, and we don't want to imply they do.  If it becomes a priority, then 
we'll do the analysis and state an opinion on the record, and follow up on 
it.  But you don't declare war before you're ready to march, and we have lots 
of other stuff to do.  (Including sneaky strategies to render the whole 
question moot, ala last message.)

By the way, I can say all this because I very much do NOT represent the 
community, and thus can speak freely without binding them to a position.  I 
relish my lack of authority on this topic.

5) Behind the scenes negotiation is WAY more effective than open belligerence.  
People send nice letters to the other side's lawyers before any actual suits 
are filed and the process starts costing both sides a lot of money.  Once 
you've made it clear the other side has to spend the money anyway, they have 
no incentive to do anything a judge doesn't tell them to do at the end of 
their appeals.  They'll appease you to avoid bad PR, because it's cheaper 
than a lawsuit, because the easiest/fastest/cheapest way to make you go away 
is to give you what you want.  (This is _after_ you prove that the easy way 
isn't simply to ignore you.)

They do NOT do things because you showed up and yelled at them and they went 
"Lo, you are mighty, see us cower before you, we have no pride."  Diplomacy 
involves walking softly and _carrying_ a big stick.  Actually using the big 
stick means the diplomacy part failed.  If you can't pull of the diplomacy 
bit motivating our side, don't even ATTEMPT it on the other side, you'll just 
poison the well.

6) You don't need us.  If you have a copyright interest in the Linux kernel, 
you can pursue this yourself without anybody else's permission.  (See #5!  
See #5 first!)  Or you can sign your copyright over to somebody like Harald 
Weite of gpl-violations.org, who pursues this kind of thing on general 
principles, as a sort of hobby.  If you're interested in causing bad PR for 
some company (in hopes they switch to BSD or something), you can try to get 
the issue listed in Erik Andersen's hall of shame.  These are all to get them 
past the "ignoring you" phase of trying to make the problem go away.

If you don't have a copyright interest in the kernel, you have no business 
getting upset about whether or not somebody _else's_ IP rights may or may not 
be properly respected.  Yes you care, and want to help, and that's cool.  
Notifying them the problem exists is helpful.  But getting upset when it 
doesn't jump to the top of their to-do list?  Not so much.

Do you think this is the _only_ binary-only module of questionable provenance?  
Trying to push other people into opening a can of worms is fairly impolite.  

7) Look into the difference between strategy and tactics.  GPL_ONLY exports 
gradually obsoleting the non-GPL ones is a strategy.  (We rewrite each major 
subsystem every few years anyway.)  Playing whack-a-mole with binary-only 
modules is tactics without a strategy.

> I believe they would be willing to 
> listen to a complaint that their license of choice is not being
> followed, and act on that complaint if they felt it was valid.

A polite letter, please.  (Their response will almost certainly be either to 
ignore you, or to reply "We think it's not a derivative work" and then ignore 
you, but hey.  A polite letter is less likely to do more harm than good, 
anyway.)

> I will reply again later with an attempt to compare the criteria
> available here:
> http://people.redhat.com/arjanv/COPYING.modules
> against the behavior of sharpzdc_cs.o and Sharp's distribution behavior.
>
> In particular, I would like help with this part of it,
> "anything that has knowledge of and plays with fundamental internal
>    Linux behavior

As does any userspace program that uses sysctl or twiddles entries in /proc.

"Ah, but that's through an API!"

Yeah, and non-GPL exports are, sort of, an unintentional/unmaintained/unstable 
API.  The "sort of" is very grey here.  And grey is what lawyers live on.

>    is clearly a derived work. If you need to muck around 
>    with core code, you're derived, no question about it.
> "

Sez you.

Have you been following the SCO case?  You'd be amazed what questions can be 
raised about.  They'll point to established practice and the existence of 
GPL_ONLY as a _defense_, because there are forbidden symbols they're not 
using, therefore the merely grey symbols they're using must be kosher, eh?  
(I didn't say it would work as a defense, just that they can spin that out 
for years in court if it came to it.  And they know it.  And if you _don't_ 
know it they write you off as a bumpkin.)

You don't have millions of dollars to spend on lawyers.  They do.  They don't 
_want_ to spend millions of dollars on lawyers any more than the US _wants_ 
to use nuclear weapons, irradiate the planet, and provoke retaliation.  But 
having the _option_ to do big and painful things is very important in the 
diplomacy parts of things.  You _carry_ the big stick.  Conspiculously.  
Rattle the saber, not draw it.

Lawyers say "pound on the facts, pound on the law, pound on the table".  In 
that order.  Don't argue about the law if the facts are on your side, and 
don't make grandiose statements about fairness or constitutionality when you 
can cite laws and cases that support your position.  The fact that even their 
_anecdotes_ have two fallback positions is a bit of a hint that your "X 
obviously is a derived work, cough up the source" argument is not going to go 
unopposed, eh?  They will _find_ opposing experts to say it isn't, if you 
push hard enough the wrong way.  Idiots with a PhD aren't hard to buy.

And if they hold you of for five years so the product isn't even in the 
bargain rack anymore and the kernel version the module was against is totally 
obsolete anyway, who cares if you win?

Binary only modules are a real problem.  Being legally in the right is 
necessary but not sufficient.  GPL_ONLY exports are a bright line test, and 
adding them as new development means there's no vague "this used to be gray 
and now it's black, its' pedigree is muddled, it's still gray!" line of 
argument.  (Well, the argument would be "binding against this symbol in the 
_old_ kernel didn't explicitly confirm acceptance of the GPL, and we wrote 
this module against the OLD kernel and forward-ported it, so why did forward 
porting it make it a derived work?  All you did was rename the symbols.  
Simple renaming doesn't make us a derived work."  Again, not necessarily 
true, just a position for people to take that requires effort to disprove, 
costing time and money and injecting uncertainty into the proceedings.)

GPL_ONLY symbols are not and never were available to non-gpl modules.  That's 
a bright line.  And we're not arbitrarily yanking the old symbols (which 
could be argued is just another type of renaming; yank the old one and add a 
new one and you've renamed), we're just obsoleting them naturally with new 
development, and the new ones are indeed different.

The kernel guys know what they're doing.  The old symbols can be marked 
"obsolete" once there's a new (GPL_ONLY) way that's justifiably better.  And 
then old exports don't have to be _yanked_.  Not right now.  Just mark them 
obsolete and wait.  It's not even saber rattling because we don't have to 
rattle anything.  It's just there, and they know it.  Best kind.  Build a big 
stick, then carry it along, while walking softly...

Rob

P.S.  All this is just my understanding.  I could be completely wrong about 
all of it.  IANAL.  YMMV.  Void where prohibited by weight, not volume.
