Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271892AbRIEJxm>; Wed, 5 Sep 2001 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271894AbRIEJxY>; Wed, 5 Sep 2001 05:53:24 -0400
Received: from mail.webmaster.com ([216.152.64.131]:16031 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271892AbRIEJxG>; Wed, 5 Sep 2001 05:53:06 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Justin Guyett" <justin@soze.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 02:53:24 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMGECJDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0109050209460.17769-100000@kobayashi.soze.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 5 Sep 2001, David Schwartz wrote:

> > 	Sure, they have the legal right to ask for the source, but
> > they might or
> > might not do so and might or might not make the source available to the
> > reporter.

> If the reporters don't ask for the code, why should anyone help them solve
> their problem by buying the module themselves and then requesting source
> themselves?  Sure, it might happen, but I wouldn't expect it.

	Exactly! So *force* the submitter to actually *have* the source code to the
module. It doesn't matter whether the module is GPL or not, it just matters
whether the submitter compiled the module from source code which he has.

> GPL *REQUIRES* the vendor make source available, it is not a "might or
> might not" situation.

	Under some circumstances, yes, but not all. Suppose, for example, the
module isn't distributed. Suppose the written offer for source expired.

> No scheme is perfect. Of course even if your
> kernel isn't tainted, if you're using a binary module that's GPL'd but the
> company won't release source, it might as well be tained, but that's
> an obvious case that really has no relevance here.

	Right. So, as I suggested, consider the kernel tainted if there are any
modules loaded that weren't compiled from source on that box with that
kernel version and headers. Suggest the user recompile his modules,
reproduce the problem, and submit a bug report with the source or URL to any
modules. Problem solved, no licensing prejudice involved.

> > 	I think, perhaps, the logic should be that a module
> > shouldn't taint the
> > kernel if:
> >
> > 	1) The user built the module from source on that machine, OR
> >
> > 	2) The module source is freely available without restriction
> >
> > 	But maybe I'm still not understanding what tainting is
> > supposed to mean.
> > Note that both '1' and '2' are orthogonal to whether the module
> > is GPL'd or
> > not.

> It means nobody can help you because nobody outside the company that
> produces the module has the source code.  1 is not necessarily valid
> because bugs are present in code regardless of what architecture they're
> run on, and regardless of whether the bug manifests itself.  It's
> certainly more difficult to debug when the bug only shows up on other
> people's systems, but such debugging isn't usually impossible.  The bigger
> hurdle would be understanding the module well enough to spot problems even
> if they did happen on your machine.

	So tell the user that he must be willing to provide the source code to any
modules in order to have his bug report honored. Another possibility would
be a system to tag modules with a URL from which the source could be freely
downloaded and include that in the bug report. If that tag was not present,
then taint.

> > 	'2' would require a copyrighted tag, so that legal action
> > could be taken

> GPL or GPL-compatible licenses are some of the few that have the necessary
> qualities to allow debugging in a community.  You seem to be agreeing
> somewhat, although the restriction of having to have bought the binary
> isn't a problem in this case, so 2 is overly restrictive.

	If '2' isn't met, then tell the user that he *must* be willing to make the
source available to anyone who wishes to help debug. If he isn't, then he
won't get help.

> > 	I think it's worth the effort to get this right to avoid sending the
> > message that if you use anything that's not GPL'd, the Linux
> > community won't
> > help you. (Not that that's really what's happening, but it may look that
> > way.)

> Absolutely.  Perhaps GPL-compatible licenses are not the only ones that
> allow community debugging.  That's why the license is hopefully listed by
> the module.  There's no force that will prevent someone from helping
> someone else debug a module because the license matched "X", if that
> someone can legally get the code and distribute patches.

> The point isn't to be fascist, it's to point out that it's not usually
> productive for people to go chasing down bugs that could be in code that
> nobody has access to, either to notice or to fix the problem.  Again,
> nothing's stopping someone from trying to debug a problem on a "tainted"
> system.  Nobody's proposing a new kernel license that prohibits debugging
> of a "tainted" kernel.

	I hope I'm not overreacting. It just seems that tainting based upon
licensing doesn't do what's really wanted, which is to make sure that the
user has the source and those who wish to debug can also get the source. The
first part of that is really easy to check directly (and you catch stupidity
due to mismatched versions, SMP versus UP, and so on). I think it makes
sense to 'force' the user to replicate the bug after having cleanly compiled
the module. This ensures that at least he has the source.

	DS

