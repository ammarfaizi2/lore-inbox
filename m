Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTH2T27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2T27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:28:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2240
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261545AbTH2T2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:28:44 -0400
Date: Fri, 29 Aug 2003 21:28:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shantanu Goel <sgoel01@yahoo.com>, Antonio Vargas <wind@cocodriloo.com>,
       linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030829192844.GB24409@dualathlon.random>
References: <20030829180623.GB27023@matchmail.com> <20030829184644.5968.qmail@web12802.mail.yahoo.com> <20030829185728.GA3846@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829185728.GA3846@matchmail.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 11:57:28AM -0700, Mike Fedyk wrote:
> [CCing AA & MCP]
> 
> > --- Mike Fedyk <mfedyk@matchmail.com> wrote:
> > > But have you compared your patch with the VM patches
> > > in -aa?  Will your
> > > patch apply on -aa and make improvements there too?
> > > 
> > > In other words: Why would I want to use this patch
> > > when I could use -aa?
> 
> On Fri, Aug 29, 2003 at 11:46:44AM -0700, Shantanu Goel wrote:
> > I prefer to run stock kernels so I don't have as much
> > experience with the -aa patches.  However, I took a
> > look at the relevant code in 2.4.22pre7aa1 and I
> > believe my patch should help there as well.  The
> > writepage() and page rotation behaviour is similar to
> > stock 2.4.22 though the inactive_list is per-classzone
> > in -aa.  I am less sure about the inode/dcache part
> > though under -aa.
> 
> You need to integrate with -aa on the VM.  It has been hard enough for
> Andrea to get his stuff in, I doubt you will fair any better.
> 
> If your patch shows improvements when applied on -aa Andrea will probably
> integrate it.

yes, at this point in time I'm willing to merge only anything that is an
obvious improvement. More doubious things would better go in 2.6.

I didn't see the patch in question, Shantanu, if you're interested to
merge it in -aa, could you submit against 2.4.22pre7aa1? Otherwise I'll
check it and possibly merge it myself later (i've quite some backlog to
merge already for the short term, but it can go in queue)

> Marc/Andrea, what do you think?  Any holes to poke in this here patch?

didn't check it yet.

Andrea
