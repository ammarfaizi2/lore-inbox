Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTIDAty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTIDAty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:49:54 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19072 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264419AbTIDAtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:49:49 -0400
Date: Wed, 3 Sep 2003 17:49:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Nick Piggin <piggin@cyberone.com.au>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904004943.GB5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Nick Piggin <piggin@cyberone.com.au>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme> <3F55907B.1030700@cyberone.com.au> <27780000.1062602622@[10.10.2.4]> <20030903153901.GB5769@work.bitmover.com> <31190000.1062604245@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31190000.1062604245@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:50:46AM -0700, Martin J. Bligh wrote:
> > Err, when did I ever say it wasn't SSI?  If you look at what I said it's
> > clearly SSI.  Unified process, device, file, and memory namespaces.
> 
> I think it was the bit when you suggested using bitkeeper to sync multiple
> /etc/passwd files when I really switched off ... perhaps you were just
> joking ;-) Perhaps we just had a massive communication disconnect.

I wasn't joking, but that has nothing to do with clusters.  The BK license
has a "single user is free" mode because I wanted very much to allow distros
to use BK to control their /etc files.  It would be amazingly useful if you
could do an upgrade and merge your config changes with their config changes.
Instead we're still in the 80's in terms of config files.

By the way, I could care less if it were BK, CVS, SVN, SCCS, RCS,
whatever.  The config files need to be under version control and you
need to be able to merge in your changes.  BK is what I'd like because
I understand it and know it would work, but it's not a BK thing at all,
I'd happily do work on RCS or whatever to make this happen.  It's just
amazingly painful that these files aren't under version control, it's
stupid, there is an obviously better answer and the distros aren't
seeing it.  Bummer.

But this has nothing to do with clusters.

> > I'm pretty sure people were so eager to argue with my lovely personality
> > that they never bothered to understand the architecture.  It's _always_
> > been SSI.  I have slides going back at least 4 years that state this:
> > 
> > 	http://www.bitmover.com/talks/smp-clusters
> > 	http://www.bitmover.com/talks/cliq
> 
> I can go back and re-read them, if I misread them last time than I apologise.
> I've also shifted perspectives on SSI clusters somewhat over the last year. 
> Yes, if it's SSI, I'd agree for the most part ... once it's implemented ;-)

Cool!

> I'd rather start with everything separate (one OS instance per node), and
> bind things back together, than split everything up. However, I'm really
> not sure how feasible it is until we actually have something that works.

I'm in 100% agreement.  It's much better to have a bunch of OS's and pull
them together than have one and try and pry it apart.

> I have a rough plan of how to go about it mapped out, in small steps that
> might be useful by themselves. It's a lot of fairly complex hard work ;-)

I've spent quite a bit of time thinking about this and if it started going
anywhere it would be easy for you to tell me to put up or shut up.  I'd 
be happy to do some real work on this.  Maybe it would just be doing the 
architecture stuff but I strongly suspect there are few people out there
masochistic enough to make controlling tty semantics work properly in this
environment.  I don't want to do it, I'd love someone else to do it, but 
if noone steps up to the bat I will.  I did all the POSIX crud in SunOS,
I understand the issues, I can do it here and it is part of the least fun
work so if I'm pushing the model I should be willing to put some work into
the non fun part.

The VM work is a lot more fun, I'd like to play there but I suspect that if
we got rolling there are far more talented people who would push me aside.
That's cool, the best people should do the work.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
