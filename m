Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSEXXHI>; Fri, 24 May 2002 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSEXXHH>; Fri, 24 May 2002 19:07:07 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:53259 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S312619AbSEXXHF>; Fri, 24 May 2002 19:07:05 -0400
Message-ID: <3CEEC729.74625C2B@opersys.com>
Date: Fri, 24 May 2002 19:05:13 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for taking the time to look at this Linus. I understand what
you are saying, but I think that there is a large part of the history
of the rtlinux patent that has not been properly communicated to the
kernel developers. I will try my best to explain this in the following,
but feel free to ask questions if things need clarifications. There is
only so much I can put in one mail.

When the patent was first noticed by Jerry Epplin in early 2000, he
posted a question about it on the rtlinux mailing list. Here is
Victor's reply at the time: http://lwn.net/2000/0210/a/vy-patent.html
The message clearly says: "The main purpose of the patent was defensive ..."

So the real-time Linux community waited for what was to follow.

Next came the first version of the patent license. That version
violated the GPL itself, requiring you to register all the users
of the software with FSMLabs. Plus, it had the following "APPROVED
USE" section:
	In addition to the other terms and conditions of this License, use
	of the Patented Process is permitted, without fee or royalty, when used:

		A.	By software licensed under the GPL; or 

		B.	By software that executes within an Open RTLinux Execution
			Environment - whether that software is licensed under the GPL or not. 

Basically, Victor was saying that anyone wanting to write a real-time
application must either license it under GPL or use FSMLabs'
Open RTLinux Execution Environment, a version of RTLinux distributed
by FSMLabs.

Many in the real-time Linux community were, evidently, displeased
with this turn of events and tried to obtain clarifications from
Victor. To this day, however, the real-time Linux community is
still waiting for the answers to very basic questions such as:
"Does anyone developping a non-GPL application for RTAI (the other
real-time Linux extension) have to pay licensing fees to FSMLabs?"

This matter remained unchanged until the FSF came out later and
declared publicly that the patent was violating the GPL. At that
time, Eben Moglen came out and publicly explained the implications
of the patent and the "corrected" patent license. Here is Eben's
explanation:
http://www.aero.polimi.it/~rtai/documentation/articles/moglen.html

Basically, this calmed things down and the RTAI development team,
including myself, tried to comply with Eben's recommendations.

All would have been fine if things had ended there, but Victor then
came out and threw more uncertainty about the matter:
http://linuxdevices.com/articles/AT6164867514.html

Just when Eben Moglen was saying that real-time applications were
not subject to the patent, Victor Yodaiken came out and said:
"If you want to make, use, sell, distribute, import,
etc. non-GPL software -- regardless of whether such software is labeled as
an "application," "module," or anything else -- please make sure you have
obtained competent legal advice regarding whether your software and its use
is an approved use under the Open RTLinux Patent License or whether a
license under the RTLinux patent must be secured to authorize your software
and its use."

This was certainly not helpful. When I asked Victor why he did this,
he said 
> I can't offer legal advice. My understanding is that these things can be
> quite complex.

I could have understood that this was indeed genuine, but here we
have Eben Moglen, a respected lawyer, publicly clarfying a situation
and instead of backing his position or keeping simply silent, Victor
comes out and casts a doubt on the very clarifications made by Eben.

The story goes on and the real-time Linux community is still in limbo.
At this stage, my understanding is that the FSF is very upset with
Victor's latest comments. But the FSF's point of view or its dealings
with Victor's patent are only a partial picture of this story.

In reality, the patent is but the tip of the iceberg.

To get the real picture, you must understand what has happened to
the various real-time projects in existence: RTAI and RTLinux. Today,
RTAI has clearly taken the lead as the primary real-time addition to
Linux. But it only got there because all the developers who work on
it today were, at one point or another, very interested in making
contributions to RTLinux. In every instance, they were turned down
or dismissed by Victor. And in most instances, those who were
turned down went to work on RTAI.

And there is a very logical reason for this. FSMLabs dual-licenses
RTLinux in closed-source form to many of its clients. This involves
that it be the owner of all the code within RTLinux. And indeed,
if you take a look at the core files making up RTLinux, they all
belong to FSMLabs and FSMLabs alone. There is nothing wrong with this
per se. But it does affect the development policy of RTLinux since
no outside contributions are ever included in RTLinux's codebase.

At most, there is "contributors" file with some names, but no
copyrights in the files. Which begs for a very fundamental question:
Has no one ever made a contribution to RTLinux? If someone has, then
why are there no names in those file headers except FSMLabs'?

At this point in time, all the bleeding-edge development being
done in RTLinux is not available in GPL and must be purchased for
a fee.

This isn't really a problem, since RTAI has now surpassed RTLinux
in terms of capabilities, ports and support. The problem, however,
is that the rtlinux patent is being used to wage an FUD campaign
against RTAI.

Hence, someone who currently wants to do real-time in Linux digs
a little and finds RTLinux and RTAI. He then tries to get the
latest and greatest in RTLinux and realizes that the GPL RTLinux
is actually a bait-and-switch. So he takes a closer look at
RTAI, but as soon as he does this he sees all these warnings
given out by Victor about RTAI and decides to drop Linux altogether
and use another OS.

This isn't an imaginary scenario. This has happened time and again
with many very big name users. I can provide you with email
addresses of people you ask about this.

To sum up, anyone today wanting to do real-time development with
Linux faces a barrage of uncertainty. Even if he uses the now
GPL RTAI, he doesn't know whether he needs to purchase licenses
for his non-GPL applications.

Notice that the argument that the rt tasks running on RTAI must
also be GPL because RTAI is GPL doesn't hold because RTAI allows
normal Linux processes to become full hard-real-time tasks. This
is done through a single call to the RTAI layer rt_make_hard_real_time().
When this function is called, RTAI steals the task from the Linux
scheduler and schedules it himself. Hence, the entire task is
in user-space.

And as the copyright notice in the kernel sources says, user
applications are not subject to the GPL. You added this yourself
because you felt that application developers should not be subject
to the GPL. The real-time Linux community only expects the same.
We don't want a non-GPL real-time executive or a non-GPL OS. All
we want is the right to develop applications using our licenses as
others are for Linux. We have tried to obtain this through discussion
and through enforcement of the GPL. Every time, we faced FUD and
unanswered questions. The only venue left today is a total dismissal
of the patent.

One last thing: Clearly, if non-GPL applications were not allowed
with Linux, we wouldn't be talking today. The same holds for non-GPL
RT apps.

I hope this has provided some insight regarding the current
situation. As I said before, feel free to ask for more clarifications
if need be.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
