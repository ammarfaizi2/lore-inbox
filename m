Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTH2Tqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTH2Tqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:46:39 -0400
Received: from web12807.mail.yahoo.com ([216.136.174.42]:51028 "HELO
	web12807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261684AbTH2Tqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:46:37 -0400
Message-ID: <20030829194636.33817.qmail@web12807.mail.yahoo.com>
Date: Fri, 29 Aug 2003 12:46:36 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
To: Andrea Arcangeli <andrea@suse.de>, Antonio Vargas <wind@cocodriloo.com>,
       linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
In-Reply-To: <20030829192844.GB24409@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

I'll test and submit a patch against -aa.  Also, is
there a common benchmark that you use to test for
regression?

Thanks,
Shantanu

--- Andrea Arcangeli <andrea@suse.de> wrote:
> On Fri, Aug 29, 2003 at 11:57:28AM -0700, Mike Fedyk
> wrote:
> > [CCing AA & MCP]
> > 
> > > --- Mike Fedyk <mfedyk@matchmail.com> wrote:
> > > > But have you compared your patch with the VM
> patches
> > > > in -aa?  Will your
> > > > patch apply on -aa and make improvements there
> too?
> > > > 
> > > > In other words: Why would I want to use this
> patch
> > > > when I could use -aa?
> > 
> > On Fri, Aug 29, 2003 at 11:46:44AM -0700, Shantanu
> Goel wrote:
> > > I prefer to run stock kernels so I don't have as
> much
> > > experience with the -aa patches.  However, I
> took a
> > > look at the relevant code in 2.4.22pre7aa1 and I
> > > believe my patch should help there as well.  The
> > > writepage() and page rotation behaviour is
> similar to
> > > stock 2.4.22 though the inactive_list is
> per-classzone
> > > in -aa.  I am less sure about the inode/dcache
> part
> > > though under -aa.
> > 
> > You need to integrate with -aa on the VM.  It has
> been hard enough for
> > Andrea to get his stuff in, I doubt you will fair
> any better.
> > 
> > If your patch shows improvements when applied on
> -aa Andrea will probably
> > integrate it.
> 
> yes, at this point in time I'm willing to merge only
> anything that is an
> obvious improvement. More doubious things would
> better go in 2.6.
> 
> I didn't see the patch in question, Shantanu, if
> you're interested to
> merge it in -aa, could you submit against
> 2.4.22pre7aa1? Otherwise I'll
> check it and possibly merge it myself later (i've
> quite some backlog to
> merge already for the short term, but it can go in
> queue)
> 
> > Marc/Andrea, what do you think?  Any holes to poke
> in this here patch?
> 
> didn't check it yet.
> 
> Andrea


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
