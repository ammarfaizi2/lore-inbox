Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264028AbTCXAku>; Sun, 23 Mar 2003 19:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264029AbTCXAku>; Sun, 23 Mar 2003 19:40:50 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:62303 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S264028AbTCXAks>;
	Sun, 23 Mar 2003 19:40:48 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Robert Love <rml@tech9.net>,
       Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <404260000.1048452717@[10.10.2.4]> ("Martin J. Bligh"'s message
 of "Sun, 23 Mar 2003 12:51:58 -0800")
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	<200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	<20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	<1048448838.1486.12.camel@phantasy.awol.org>
	<20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
	<1048450211.1486.19.camel@phantasy.awol.org>
	<402760000.1048451441@[10.10.2.4]>
	<20030323203803.A12220@devserv.devel.redhat.com>
	<404260000.1048452717@[10.10.2.4]>
Date: Mon, 24 Mar 2003 01:51:51 +0100
Message-ID: <86ptohk2mw.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "martin" == Martin J Bligh <mbligh@aracnet.com> writes:

Hi

martin> Well, that is a minefield of subjective opinions. Yes, the distros merge
martin> stuff back ... but there's not enough of it going on. RHAS and UL are
martin> *massively* diverged. There are also changes that are in just about every
martin> distro that aren't back in mainline. I fail to see the point of that ...
martin> people complain about problems with things like O(1) scheduler, and yet
martin> the distros all distribute it ... very odd.

Problem is the same than ever.  Full major kernel releases take 2
years.  That means that we need to force things in the _stable_ branch
that should be in next branch.  2.4 should be in maintenance mode (aka
something similar to what happens in 2.2 just now), but as 2.6 is not
ready (and will not in at least several months yet), we have to live
with big changes like the big IDE merge.

About the reasons for having lots of patches in a vendor kernel.  It
is just a pain in the ass :(  I completely agree with Arjan on that.
Problem is that getting patches back merged upstream sometimes is not
easy either :(  For instance, users test the distro when they are in
release candidate, and when you found that problems and you got fixes
for that, it is posible that kernel code base has already changed,
what makes merging your fixes difficult.  And not, merging code for
mainline during a release candidate cycle is Just a Bad Idea (tm).

martin> The question of "what is mainline 2.4 for anyway" is becoming
martin> increasingly interesting, especially as fewer people are using
martin> it. If there was more of a common base between the distros,
martin> there would be IMHO less duplicated work.

Will be basically the same work.  Somebody needs to be in charge of
that branch.  And if you get <somebody> to pass your changes, then you
have also the same posibilities to pass the patch Marcelo :)

martin> I'm not so worried about what Marcelo chooses to do with this particular
martin> issue - that's his call. However, I'm extremely concerned by the general
martin> "you should be using a vendor kernel" attitude.

Here, I completely agree with Pavel, you should never tell that
sentence in that list :)  You should use a vendor kernel only if:
- you don't know how to compile your own, and you are not interested
  in learn how to do it.
- you are lazy, and think that it is _easier_ for you to use a vendor
  kernel.

Later, Juan "who knows what is the pain of having lots of patches"

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
