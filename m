Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVBIUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVBIUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBIUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:16:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30603 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261919AbVBIUOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:14:39 -0500
Date: Wed, 09 Feb 2005 15:13:48 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-reply-to: <20050209184629.GR22893@bitmover.com>
X-X-Sender: nico@localhost.localdomain
To: Larry McVoy <lm@bitmover.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Jon Smirl <jonsmirl@gmail.com>,
       tytso@mit.edu, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20050209184629.GR22893@bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Larry McVoy wrote:

> On Wed, Feb 09, 2005 at 12:17:48PM -0500, Nicolas Pitre wrote:
> > On Tue, 8 Feb 2005, Larry McVoy wrote:
> > > You know, you could change all this.  Instead of complaining that we
> > > are somehow hurting you, which virtually 100% of the readers know is
> > > nonsense, you could be producing an alternative answer which is better.
> > 
> > IMHO something is flawed in this whole argument.  Why would someone be
> > interested into any alternative answer for working on the Linux kernel
> > tree if the whole thing can't be imported into it with the same
> > granularity as can be found in BK?  IOW what's the point to alternatives
> > if you can't retrieve the entire workset?
> 
> Please explain to me where the data is being lost.  100% of the patches
> are available on bkbits.net with no license agreement required.  They
> always have been.

Are you saying that it is now OK to write scripts that would bit bang on 
the bkbits http interface to fetch patches/comments with the purpose of 
populating an alternate scm?  Andreas tried that a while ago but you 
threatened to shut the service down entirely if he was to continue.

> The problem is that you want us to tell you how BK manages those patches.
> That was never part of the agreement, in fact we made it clear in the
> license that that information was considered to be IP and could not be
> distributed.  How BK does that is our business, not yours.

I completely agree here.  But just to be on the same page, let me quote 
Stelian's proposal here again:

On Tue, 8 Feb 2005, Stelian Pop wrote:

| What you could make available in the bkcvs export would be, for each
| changeset (both for the changesets and for the merged changesets),
| include three BKRevs:  the changeset's one, the changeset's parent one,
| and the changeset's merge parent one.
|
| That information could be used to reconstruct the entire tree,
| using either bk-commit-head (preferred) or bkbits, provided you
| put the BKRev: tag into the bk-commit-head posts too.
|
| Technicaly speaking this should be very easy for you to implement.

Is the above actually part of the protected BK IP?  Can anyone run with 
such information and clone BK in a smooth breeze with that?  I don't see 
how such info can tell how BK manages it.

> If you want
> to know how BK does it you must go figure it out without the benefit
> of BK itself or metadata managed by BK.

I think what people want here is the tree structure representation in 
whatever form, not necessarily in the BK format.  One example of that 
was provided above. You can't deny others access to the whole of the 
Linux kernel development history even if their purpose is to import it 
into a competing system (more on that below).

> While I understand that you don't like it, is there no sense of fairness
> left?  We did the hard work to create BK.  Some of us worked for *years*
> without pay to create this product.  Some of us put our life savings
> into the product.  It's our IP, we paid heavily to create this, is it
> so unreasonable of us to want to protect our work?  I believe we are
> within our legal rights, or so our legal team tells us, but that should
> be beside the point.  It's our work.  We paid for it.  We certainly
> don't have any obligation to tell you how we did it and to us it seems
> pretty unreasonable that you don't just go off and do the work yourself.

Again I wholeheartedly agree with you above.  But that's not exactly the 
point.  You certainly have the right to protect your work.  But please 
admit that the Linux kernel developers own the right to move (100% not 
96%) of the development tree with all its branches _they_ produced.  In 
other words, the product of the current Linux BK repository is the 
result of those Linux developers not yours.  Of course BK is the 
indispensable tool that made it possible, but BK could have been 
developed even without the Linux BK repository.

So what people are asking for again and again is a way to represent in 
alternate form to BK internal metadata the Linux development tree 
structure but without you to give away the BK IP, be that in XML, plain 
text, or just with BK refs attached to patches like suggested above.  
Unless I'm completely dumb, this won't reveal anything about BK itself 
and how you did it?

Now obviously enough some people will run away with that raw data and 
try to import the Linux kernel source tree in their own scm of choice.  
That's why I'm asking you "and so what?"  Granted all the efforts you 
put into BK as you say above, do you really expect the alternative scm 
to suddenly be as functional and scalable as BK in a single swoop just 
because they can import the Linux BK tree with the same patch 
granularity as BK does?  If you worked so hard on BK for many years it 
means the competition should be far behind.  Therefore what do you fear?

Note that if someone actually needs a big tree to test bench an 
alternate scm there are alternatives to the kernel -- gcc is a good 
example.  So allowing the Linux kernel tree to be imported into another 
scm is not really a requirement for developing on said scm.

> And pretty unadmirable as well, don't you have any faith in your own
> abilities?

Do you have faith in your own work?  If so allowing others to import the 
complete Linux development tree into alternative scm shouldn't scare you 
so much.  You probably know already that they won't be able to scale as 
well as BK, and we're not even talking about the ability to perform push 
and pull type operations here.  So what do you actually fear?  I'll be 
fully on your side once I grasp the actual threat to BK.

Note I'm trying to understand what the actual problem is here.  I'm not 
concerned by the non-free nature of BK at all.  It is the best tool for 
distributed development available, and it's been applied to Linux 
development with no $ cost.  I'm just wondering why providing some 
additional info which would allow for rebuilding the tree with all 
changeset relationships (into whatever alternate inferior scm that's not 
the point) would uncover your IP.  It's just a graph with patches 
attached to it in the end.  No need to tell us how BK manages it.


Nicolas
