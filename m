Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270165AbRIEJl2>; Wed, 5 Sep 2001 05:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRIEJlU>; Wed, 5 Sep 2001 05:41:20 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:10689
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S270165AbRIEJlK>; Wed, 5 Sep 2001 05:41:10 -0400
Date: Wed, 5 Sep 2001 02:41:31 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: David Schwartz <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
In-Reply-To: <NOEJJDACGOHCKNCOGFOMMEBMDLAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.33.0109050209460.17769-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2001, David Schwartz wrote:

> 	Sure, they have the legal right to ask for the source, but they might or
> might not do so and might or might not make the source available to the
> reporter.

If the reporters don't ask for the code, why should anyone help them solve
their problem by buying the module themselves and then requesting source
themselves?  Sure, it might happen, but I wouldn't expect it.

GPL *REQUIRES* the vendor make source available, it is not a "might or
might not" situation.  No scheme is perfect.  Of course even if your
kernel isn't tainted, if you're using a binary module that's GPL'd but the
company won't release source, it might as well be tained, but that's
an obvious case that really has no relevance here.

> 	I think, perhaps, the logic should be that a module shouldn't taint the
> kernel if:
>
> 	1) The user built the module from source on that machine, OR
>
> 	2) The module source is freely available without restriction
>
> 	But maybe I'm still not understanding what tainting is supposed to mean.
> Note that both '1' and '2' are orthogonal to whether the module is GPL'd or
> not.

It means nobody can help you because nobody outside the company that
produces the module has the source code.  1 is not necessarily valid
because bugs are present in code regardless of what architecture they're
run on, and regardless of whether the bug manifests itself.  It's
certainly more difficult to debug when the bug only shows up on other
people's systems, but such debugging isn't usually impossible.  The bigger
hurdle would be understanding the module well enough to spot problems even
if they did happen on your machine.

> 	'2' would require a copyrighted tag, so that legal action could be taken

GPL or GPL-compatible licenses are some of the few that have the necessary
qualities to allow debugging in a community.  You seem to be agreeing
somewhat, although the restriction of having to have bought the binary
isn't a problem in this case, so 2 is overly restrictive.

> 	I think it's worth the effort to get this right to avoid sending the
> message that if you use anything that's not GPL'd, the Linux community won't
> help you. (Not that that's really what's happening, but it may look that
> way.)

Absolutely.  Perhaps GPL-compatible licenses are not the only ones that
allow community debugging.  That's why the license is hopefully listed by
the module.  There's no force that will prevent someone from helping
someone else debug a module because the license matched "X", if that
someone can legally get the code and distribute patches.

The point isn't to be fascist, it's to point out that it's not usually
productive for people to go chasing down bugs that could be in code that
nobody has access to, either to notice or to fix the problem.  Again,
nothing's stopping someone from trying to debug a problem on a "tainted"
system.  Nobody's proposing a new kernel license that prohibits debugging
of a "tainted" kernel.


justin

