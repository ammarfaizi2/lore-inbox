Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282814AbRLBICu>; Sun, 2 Dec 2001 03:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282813AbRLBICl>; Sun, 2 Dec 2001 03:02:41 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:2688 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S282817AbRLBIC3>;
	Sun, 2 Dec 2001 03:02:29 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200112020801.fB281Wt07893@meduna.org>
Subject: Re: Coding style - a non-issue
To: linux-kernel@vger.kernel.org
Date: Sun, 2 Dec 2001 09:01:32 +0100 (CET)
In-Reply-To: <E16AHWZ-0008IS-00@the-village.bc.nu> from "Alan Cox" at dec 01, 2001 09:18:15
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "it works/does not work for me" is not testing. Testing
> > is _actively_ trying to break things, _very_ preferably
> > by another person that wrote the code and to do it
> > in documentable and reproducible way. I don't see many
> > people doing it.
> 
> If you want a high quality, tested supported kernel which has been through
> extensive QA then use kernel for a reputable vendor, or do the QA work
> yourself or with other people.

Correct. But this has one problem - it is splitting resources.
Pushing much of the QA work later in the process means
that the bugs are found later, that there is more people
doing this as absolutely necessary and that much more
communication (and this can be the most important bottleneck)
is needed as necessary.

The need of the VM change is probably a classical example -
why was it not clear at the 2.4.0-pre1, that the current
implementation is broken to the point of no repair? I am
not seeking who is guilty, it is irrelevant, but I think
there is a lesson to be learned and I would like to see
the cause to be identified and steps to be taken that move
such experiments into the development series. The 2.2 also
had issues, but 2.4 has IMHO more issues that are not
localized and fixable without affecting other parts.

Evolution does not need to be efficient. I still think that
software development should be - if we loose half a year,
the more organized competitor will be more than happy.

As a user of the vendor's kernel I have no idea what to do
with a bug. The vendor kernel has hundreds of patches that
are or are not, fully or partially merged into the mainstream
for various reasons - you know this surely much better
than I do :-) Now where do I send a bug report and -
more important - where do I look when I want to have
all available information to an issue, so I can be
more specific (or cancel the report completely because
it is clearly duplicate)? Should I consult my vendor's
bugzilla, systems of all other vendors, l-k and specialized
mailing lists of the given subsystem? I doubt that
many of us will...

There is no single place where the bug reports are sent and -
much more important - where their history can be viewed.
The kernel itself has nothing but linux-kernel (overloaded
with tons of non-relevant stuff such as this thread :-))
and probably various TODO lists of the developers.

I really feel that at least the information should be
centralized so that the info can be hyperlinked. You work
with the kernel so closely that you are probably able
to keep the track of the important issues. 99% of users
wanting to at least report bugs are not. Finding something
in the l-k is hard, but even the managers can normally
operate an issue tracking system - I see them doing it
every day :-)

The classical tools such as version control or issue tracking
system were discussed many times and were rejected - not
by evolution, but by one-man decision. linux-kernel does
not show me when and _why_ something was changed. Changelogs
are big step in the right direction, but I think that more
is needed. Frankly, I think that managing the submissions
in a mail folder of Linus is not the right way of doing this
for a project of this size.

I understand that it is impossible for Linus to write a meaningful
comment and to check in a changeset each time he decides to
accept stuff. I think that at some time he will be forced
to give some write-access to a mainstream branch to a few
other people (btw, this final review is imho in strong conflict
with his evolution theory).

> We have kernel janitors, so why not kernel QA projects ?

Yes, this should be probably discussed. If a development
can be distributed and quite organized at the same time,
so can probably the testing. I have already seen such project
somewhere on the web - no idea where they are now.

But an effective QA project is not possible without support
from the developers themselves. Black-box testing is only
one kind of tests. If a design is not documented, it is
much more harder to try to break it.

> However you'll need a lot of time, a lot of hardware and
> a lot of attention to procedure

I know - our QA department sits next door and this is userspace
application, so hardware does not matter :-)

Regards
-- 
                                       Stano

