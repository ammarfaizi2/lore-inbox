Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTE3FYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 01:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTE3FYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 01:24:15 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:27618 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263277AbTE3FYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 01:24:12 -0400
Date: Fri, 30 May 2003 01:30:51 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: [announce] procps 2.0.13 with NPTL enhancements
To: linux-kernel@vger.kernel.org
Message-id: <1054272651.22088.619.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
On Thu, 2003-05-29 at 18:08, Adrian Bunk wrote:

>> Well, since I read Albert Cahalan's comment in
>> Debian bug #172735 [1] I understand the people
>> maintaining a different branch...
>
> Exactly.
>
> That bug is fixed in the official tree, fyi.
> A segfault, as you said, is always a bug.
> An error message is displayed.

You asked for it...

Nice cheapshot there. So, if I remove some
critical kernel interfaces from your system,
nothing should crash? How about I take out
a few choice system calls or a chunk of libc?

(note: the "bug" is not exploitable)

Face it. For nearly a decade, /proc has been
a critical kernel interface. This isn't 1991.
(embedded systems excepted; they don't use procps)

That said, I may do something about the issue
simply to please users with messed-up systems.

> Once that bug is fixed, he will probably find
> that the inability to read files in /proc also
> causes a crash. Such is the problem with this
> duplicated effort. It sucks.

I could tell you about some inputs that
make your programs crash... Nah. Find them
yourself. I wait for your screams. >:-)

You finally fixed a SEGV that I fixed well
over a year ago. Congradulations. You have
others to fix, and a minor (?) security
issue as well. Have fun.

Oooh... I think you have an exploitable
buffer overflow as well. Anybody running
his procps as an i386 binary on IA-64?

> I told Albert I
> would be happy to merge each and every (sane)
> change he sends me. He refuses. To be fair,
> I also refuse to work under his tree. His comments
> on this list is part of the reason. For what its
> worth, he did not fork off and create his tree
> until Rik starting work on the official tree.

Nope. Rik's activity was one of two reasons
for me to increment the major number, and one
of many reasons to put the project on SourceForge.

Prior to that, I had provided 2.x.x versions
to Debian for years. Also note that I wrote
the ps program itself and a large portion of
the library you use. This all was long before
you and Rik touched procps.

Go ahead and check the 2.x.x in Debian. It's mine.

> In the end, all that matters to me really is that
> Red Hat and other big distributions use my tree
> (apparently whether I maintain it or not) and I
> use those distributions. If I used Debian, maybe
> my view would be different. Or maybe I would make
> them switch trees :)

You: Connectiva, Red Hat
Me: Debian, Slackware, SuSE, Mandrake, Rock, LFS, Gentoo...

No wonder. Your "NPTL enhancements" depend on
kernel patches that Red Hat uses. For regular
non-NPTL threads, you get this nice fat bug:
(and an "I told you so" -- you KNEW about it)

------------------------------------------------------------
From:    Yakov Lerner
To:      procps-bugs@redhat.com
Subject: 'ps -C name' without -m shows all threads of the process ?
Date:    Mon, 05 May 2003

We have multithreaded process with number of threads
between 20 and 60 [and changing sometimes]. This is RedHat 8.

Suddenly out of blue, 'ps -C OurprOc' started
to show all threads of the process instead of 1 line.

'ps -l -C xxx' also showed many lines -- 1 per thread
-- although expected to show 1 line only. Looking at PPIDs
in 'ps -l -C xxx' -- it's definitely all threads of a single process.

Then, 10 minutes after, 'ps -C OurprOc' reverted
to normal: showing 1 line. There is no alias of ps to 'ps -m'
or like. The process was not even restarted, same pid. It has now
74 threads.

BTW: when ps showed incorrect output, the system was highly loaded,
and when ps reverted to normal, the load subsided. I don't know
it it's related.

Is this known bug in ps ?
----------------------------------------------------------------

IMHO, important system programs don't exhibit
random behavior like that. If they do, you fix
it damn quick. You don't go and add unstable hacks
even after you've been warned... but you did.

A maintainer should say "NO" to cool new features
that come with obviously unfixable serious bugs.



