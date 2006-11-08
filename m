Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161729AbWKHWJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161729AbWKHWJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161733AbWKHWJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:09:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:53791 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161729AbWKHWJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:09:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eD6YmWuKrPT2P3nxYkSX1abTC5UrHkOsEdlrTxJ6tdNdE+Pe4OViMR8y5aFLqC9REs6re1YwZPFo67ecSEslH/++QWe/D07u3wr/pH5iiRgR8MWi6vtHq4uzzcNu24YGRE0bL26yL4g23/pnalrD8Nkds/Yq4+CeQd0A0MY2JwM=
Message-ID: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:09:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: A proposal; making 2.6.20 a bugfix only version.
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a suggestion. Why don't we make 2.6.20 a "bug fixes only" kernel version?

I think it would be a good idea to dedicate just one kernel cycle to
pure bug fixes and cleanups. Why? I'll tell you :)

We keep merging new features and destabilizing things all the time,
and while that's more or less just the new 2.6 model working (and
working well) it does have some problems.

There's no shortage of issues that need fixing, but since we keep
merging new stuff, a lot of bugfixing energy gets spend on the new
cool stuff instead of fixing up any other issues we have.
Also, regressions seem to show up with every new kernel version, and
while they usually get fixed it's not always so (Adrian's list of
known regressions seems to help though).

So, what are all these bugs I'm talking about?  Well, lets see ...

Coverity has, as of this writing, identified 728 issues in the current
kernel. Sure, some of those have already been identified as false or
ignorable issues, but many are flagged as actual bugs and still more
are as yet uninspected.

The kernel bugzilla has many many entries that are real bugs, some
even have patches.

Many bugreports are made to LKML weekly and while some of the issues
get picked up and fixed, many also get lost.
(many patches also get posted and subsequently ignored - which is a shame).

Building current kernels show up tons of warnings (and sometimes
errors) that should be investigated/fixed - some of them are real
bugs.

The kernel janitors have a long list of issues that need to be
investigated and cleaned up/fixed.

Adrian Bunk has his list of known regressions and, I'll bet, also some
patches in the trivial queue for small issues.

There are many bug fixes in -mm and other trees that we ought to
dedicate some time to merging.

There are many parts of the kernel that are not documented.

I'm sure most distributions have a bunch of bug fixing patches lying
about that they could push.


What I'm trying to say is that, maybe we should resist the temptation
to merge new cool features for just a single kernel cycle and instead
dedicate it to fixing as many of our known issues as possible - we
have plenty...

Let's dedicate a cycle to bug fixing only.
Trivial bug fixes, involved bug fixes, new docs, fixes to existing
docs, obviously correct cleanups - all OK.
What's not OK is stuff that introduce new functionality/features, adds
support for new hardware (unless trivial such as just adding a new PCI
ID), breaks currently working behaviour, etc.


There are a few other reasons, besides the many lists of known bugs,
that inspired me to make this suggestion, a few are listed below.

- I've personally felt a greater and greater need to test kernel.org
kernels recently before putting them into production use, both at home
and at work. In my subjective oppinion, quality of releases seems to
be a lot more uncertain than it used to. Can't put my finger on when
this started to happen, just a subjective feeling over time (as well
as seeing my home box and servers at work have problems with new
kernels more often than they used to).

- A while back, akpm made some statements about being worried that the
2.6 kernel is getting buggier
(http://news.zdnet.com/2100-3513_22-6069363.html).

- The need for the -stable tree and the (relatively large) number of
-stable releases between each new major release clearly shows that we
are leaving lots of regressions in our wake.


In the long term I think it might be a good idea to do something like
this every once in a while (perhaps every .20, .30, .40 etc), we'll
see if that makes sense, but doing it at least once won't do any harm
(except delaying new features a few months).. Let's try it.

Let's make a public statement that 2.6.20 will be a "bug fixes and
stabilization only" release.
Let us invite all distributions to submit their internal bugfixes.
Let us encourage people to work on known issues instead of new stuff
for just this one release (there are enough bugs to choose from that
there should be something worthwhile to do for both newbie and
experienced hacker alike).
Let us comb the mailing list archives and dig up all the lost bug fix patches.
Let us get all pending bug fix patches from the various trees merged,
but just the fixes.
Let us encourage everyone to postpone new stuff to 2.6.21 and re-base
it on top of the 2.6.20 -rc kernels.

What do you say - could it hurt?
I think it would do us a lot of good.

Fixing bugs makes users happy.
Fixing bugs provides a more stable base going forward.
Fixing bugs inspires confidence in the product we provide.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
