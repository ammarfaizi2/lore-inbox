Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSLSTdw>; Thu, 19 Dec 2002 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSLSTdw>; Thu, 19 Dec 2002 14:33:52 -0500
Received: from [81.2.122.30] ([81.2.122.30]:19208 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266069AbSLSTdu>;
	Thu, 19 Dec 2002 14:33:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212191952.gBJJqTb3002477@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: davej@codemonkey.org.uk (Dave Jones)
Date: Thu, 19 Dec 2002 19:52:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, lm@bitmover.com,
       lm@work.bitmover.com, torvalds@transmeta.com, vonbrand@inf.utfsm.cl,
       akpm@digeo.com
In-Reply-To: <20021219184958.GA6837@suse.de> from "Dave Jones" at Dec 19, 2002 06:49:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > >It could warn the user if they attach an un-decoded oops that their
>  > >bug report isn't as useful as it could be, and if they mention a
>  > >distribution kernel version, that it's not a tree that the developers
>  > >will necessarily be familiar with
>  > Perhaps a more generalized hook into bugzilla for 'validating' a bug 
>  > report, then code specific validators for kernel work?
> 
> Its a nice idea, but I think it's a lot of effort to get it right,
> when a human can look at the dump, realise its not decoded, and
> send a request back in hardly any time at all.

Somebody still has to answer it - loads of mails to LKML go unanswered
because people are spending their time coding instead of reading the
list, (which is good).

> I also don't trust things like this where if something goes wrong,
> we could lose the bug report.

How?  I don't see as that is more likely than with Bugzilla.  Anyway,
loads of LKML posts get ignored, and nobody seems to worry about it :-).

> People are also more likely to ping-pong ,argue or "how do I..."
> with a human than they are with an automated robot.

The idea is that the bug database does a sanity check on their bug
report.  It still gets entered in to the database, but it would return
something like:

"
Hi,

You submitted a bug to the bug database.  Please note the following:

* You mentioned kernel version foobar.  This appears to be a vendor
kernel, not an official kernel tree.  Your distribution maintainers
might be more appropriate people to contact

* You included an undecoded oops - this is probably useless.  Please
read the FAQ.

Thanks for using the bug database.  Your bug has been assigned to
[whoever].
"

I don't see any way of making Bugzilla do all the things I described
originally, specifically the advanced tracking of versions tested.
That could help to find duplicates, which is a big problem when you
have 1000+ bugs.

John.
