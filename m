Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbTAREYO>; Fri, 17 Jan 2003 23:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAREYO>; Fri, 17 Jan 2003 23:24:14 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:35020 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262392AbTAREYN>;
	Fri, 17 Jan 2003 23:24:13 -0500
Date: Sat, 18 Jan 2003 04:33:09 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Is the BitKeeper network protocol documented?
Message-ID: <20030118043309.GA18658@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Larry,

Please don't take this as a contentious question.  I have an honest
request, and would like a technical answer without politics if that's
possible.


Can't use BitKeeper
-------------------

I'll explain where I'm coming from.

Recently, I was debating with Linus about the new vsyscall code.  To
keep track of Linus' changes, so that I might make better comments and
produce a patch or so, I had a need to track the head of the kernel's
bitkeeper repository at bkbits.net.  (The experimental code was not
yet available as a normal patch from Linus).

Although I am unfortable using closed source software, it seemed
pragmatic to fetch and install BitKeeper.  I went to bitmover.com, and
read the free license before downloading:

	http://www.bitkeeper.com/Sales.Licensing.Free.html

That looked ok.  I am allowed to use it.  Great!

So I downloaded version 3.0, and typed "bk help bkl".  I found that
the license with the software is _different_ to the licence on the web
page.

	[Note to Larry, you may wish to update the above URL to the
	current version].

Unfortunately, the license that comes with the download adds a new
clause 3(d): that's the clause which tells me that actually I'm not
allowed to use BitKeeper, because of other software I occasionally
work on.  (No, I do not work on Subversion, but I do occasionally
dabble with sophisticated version management scripts).

So, being conscientious and obedient, I removed BitKeeper from my system.

As a result I had great difficulty having a meaningful debate with
Linus - as I had no easy way to look at the code Linus was checking
in, that we were talking about!  (And submitting a patch to illustrate
my thoughts was out of the question).


Real-time kernel tree only available over BitKeeper protocol?
-------------------------------------------------------------

To synchronise with the kernel repository, in order to communicate
effectively with Linus about changes as they are checked in, I think
that it's necessary to use the BitKeeper network protocol (or the
over-HTTP equivalent).

I know that Rik van Riel keeps a mirror of the repository in various
formats over at nl.linux.org:

	http://ftp.nl.linux.org/linux/bk2patch/

Thus far, the best solution I have for tracking checkins is to rsync
the SCCS files from Rik's mirror, and use a Perl script to extract the
head version from each SCCS file.  (I could use GNU CSSC, but for this
purpose a simple Perl script is enough; the SCCS file format is quite
simple).

However, as is the nature of mirrors, I'd rather not have to wait for
the time delay getting updates to Rik's mirror.  Not to mention the
lack of tree-wide atomicity, if I rsync at the wrong moment (I am not
sure if this is a problem in practice).

Anyway, the point is I would like to be able to access the "official"
kernel development tree, in real time like everyone else, which I
understand is only available at bkbits.net.

As far as I know, the only way to follow updates to the offical tree
is using the BitKeeper network protocol.

And I have not been able to find any documentation of that protocol.
(I hope it is not necessary to reverse engineer it!)


My question
-----------

Larry, or anyone else, can you direct me to the information I need to
track the kernel development tree in real time?  A document describing
the BitKeeper network protocol would be ideal.

I don't require to use the bk protocol - but if it that is as
efficient as you say on the bitmover.com web site, that would be nice.

Please note that I am _not_ writing a bk clone, or any other
significant VC project.  However I do wish to use my own software to
analyse changes to the Linux kernel as they are checked in, and I
think that is a reasonable request.


Thanks in advance,
-- Jamie Lokier
