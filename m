Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbRE3UAc>; Wed, 30 May 2001 16:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbRE3UAW>; Wed, 30 May 2001 16:00:22 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:39300 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S261950AbRE3UAG>; Wed, 30 May 2001 16:00:06 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Wed, 30 May 2001 14:58:57 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
To: Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.33.0105300719130.567-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0105300719130.567-100000@mikeg.weiden.de>
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
MIME-Version: 1.0
Message-Id: <01053014585700.01976@quark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 May 2001 01:02, Mike Galbraith wrote:
> On Tue, 29 May 2001, Vincent Stemen wrote:
> > On Tuesday 29 May 2001 15:16, Alan Cox wrote:
> > > > a reasonably stable release until 2.2.12.  I do not understand why
> > > > code with such serious reproducible problems is being introduced
> > > > into the even numbered kernels.  What happened to the plan to use
> > > > only the
> > >
> > > Who said it was introduced ?? It was more 'lurking' than introduced.
> > > And unfortunately nobody really pinned it down in 2.4test.
> >
> > I fail to see the distinction.  First of all, why was it ever released
> > as 2.4-test?  That question should probably be directed at Linus.  If
> > it is not fully tested, then it should be released it as an odd
> > number.  If it already existed in the odd numbered development kernel
> > and was known, then it should have never been released as a production
> > kernel until it was resolved.  Otherwise, it completely defeats the
> > purpose of having the even/odd numbering system.
> >
> > I do not expect bugs to never slip through to production kernels, but
> > known bugs that are not trivial should not, and serious bugs like
> > these VM problems especially should not.
>
> And you can help prevent them from slipping through by signing up as a
> shake and bake tester.  Indeed, you can make your expectations reality
> absolutely free of charge, <microfont> and or compensation </microfont>
> what a bargain!
>
> X ___________________ ;-)
>
> 	-Mike

The problem is, that's not true.  These problems are not slipping
through because of lack of testers.  As Alan said, the VM problem has
been lurking, which means that it was known already.  We currently
have no development/production kernel distinction and I have not been
able to find even one stable 2.4.x version to run on our main
machines.  Reverting back to 2.2.x is a real pain because of all the
surrounding changes which will affect our initscripts and other system
configuration issues, such as Unix98 pty's, proc filesystem
differences, device numbering, etc.

I have the greatest respect and appreciation for Linus, Alan, and all
of the other kernel developers.  My comments are not meant to
criticize, but rather to point out some the problems I see that are
making it so difficult to stabilize the kernel and encourage them to
steer back on track.

Here are some of the problems I see:

There was far to long of a stretch with to much code dumped into both
the 2.2 and 2.4 kernels before release.  There needs to be a smaller
number changes between major releases so that they can be more
thoroughly tested and debugged.  In the race to get it out there they
are making the same mistakes as Microsoft, releasing production
kernels with known serious bugs because it is taking to long and they
want to move on forward.  I enjoy criticizing Microsoft so much for
the same thing that I do not want to have to stop in order to not
sound hypocritical :-).  The Linux community has built a lot of it's
reputation on not making these mistakes.  Please lets try not to
destroy that.

They are disregarding the even/odd versioning system.
For example:
There was a new 8139too driver added to the the 2.4.5 (I think) kernel
which Alan Cox took back out and reverted to the old one in his
2.4.5-ac? versions because it is apparently causing lockups.
Shouldn't this new driver have been released in a 2.5.x development
kernel and proven there before replacing the one in the production
kernel?  I haven't even seen a 2.5.x kernel released yet.

Based on Linus's original very good plan for even/odd numbers, there
should not have been 2.4.0-test? kernels either.  This was another
example of the rush to increment to 2.4 long before it was ready.
There was a long stretch of test kernels and and now we are all the
way to 2.4.5 and it is still not stable.  We are repeating the 2.2.x
process all over again.  It should have been 2.3.x until the
production release was ready.  If they needed to distinguish a code
freeze for final testing, it could be done with a 4th version
component (2.3.xx.xx), where the 4 component is incremented for final
bug fixes.


- Vincent Stemen
