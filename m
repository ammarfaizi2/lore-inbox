Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVJaECf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVJaECf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 23:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVJaECf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 23:02:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38016
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750853AbVJaECe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 23:02:34 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [git patches] 2.6.x libata update
Date: Sun, 30 Oct 2005 22:02:28 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051030194512.GA21782@havoc.gtf.org> <20051030123907.6ea5d442.akpm@digeo.com>
In-Reply-To: <20051030123907.6ea5d442.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302202.28690.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 14:39, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > Please pull from 'upstream-linus' branch of
> >  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> Linus may not receive this.  For me at least, large amounts of incoming and
> outgoing OSDL email have been disappearing into the ether for the past 12
> hours or so.

It's probably delayed.  I got the "could not deliver for 4 hours, connection 
with smtp.osdl.org timed out" warning on the original "Is this a viable 
option?" question, and Linus has since replied, so it went through...

Rob

P.S.  The git source also wanted the -dev version of libcurl installed, 
whatever that is.  Been happily banging on this box for months without ever 
needing it.  Am now reading through the git tutorial.  Very dry.

I read through the git bisect source (well, the bits in rev-list.c anyway), 
and yeah it's cheating mightily with the "distance" thing, and by supplying 
"good" and "bad" you're actually making the greater than or less than 
decisions yourself.  Whee.

If all else fails, it's got a sort-by-date function in there, so if you plug 
the date thing in for the good and bad you at least get something consistent, 
but I can see Linus's warnings about huge, evil, unintelligible revisions 
from jumping around like that.

Of course you don't have to make the ordering decision right away: I get two 
halves, and can bisect each one all the way to binary tree without having to 
make a single greater than or less than decision.  Then when putting the tree 
back together, the criteria is "which direction produces the smallest 
cumulative patch", which isn't nicely resolving in my head into code yet but 
I'm working on it...

Need to get a kernel tree to play with, which means finishing this tutorial.

Need... more... caffeine.

Still Rob
