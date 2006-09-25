Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWIYBBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWIYBBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWIYBBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:01:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751700AbWIYBBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:01:16 -0400
Date: Mon, 25 Sep 2006 03:01:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060925010115.GB4547@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060923235315.GB24214@1wt.eu> <20060924181641.GA4547@stusta.de> <20060924200204.GB31404@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924200204.GB31404@1wt.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 10:02:04PM +0200, Willy Tarreau wrote:
> On Sun, Sep 24, 2006 at 08:16:41PM +0200, Adrian Bunk wrote:
>...
> > > Anyway, the case above was even not that. It was simply that if the shiny
> > > new sata_piix driver detected the sata controller, it would then steal the
> > > resources first, preventing ata_piix from registering.
> > 
> > I know that ATA is an area that requires extra care (and I don't plan 
> > any big updates in this area).
> > 
> > But having:
> > - two saa7134 cards in your computer and
> > - one of them formerly not supported and
> > - depending on one of them being the first one
> > is a case you can theoretically construct, but then there's the point 
> > that this is highly unlikely, and OTOH the value of the added support is 
> > more realistic.
> 
> I don't personaly have problems with those cards (I don't use them at all),
> I was just arguing general principles in response to Greg's comments. I
> think you're already taking extreme care in what you accept, but I think
> that what you're currently doing is middle way between Greg's stable policy
> and what yourself would really like to do. I hope that in the end, you will
> not get frustrated by refraining from merging patches you would have liked
> to get, while being criticized for having merged too many.
> 
> Probably that later you will have to either maintain several other versions
> (let's say 2.6.16+2.6.18) or have sort of an "enhanced" branch with more
> fixes (which is easy to do with GIT).

Instead of 2.6.16+2.6.18, it would be easier to simply use 2.6.18.

And this is what I have in mind as a possible solution:

Start a similar stable series based on e.g. 2.6.22 or 2.6.24, and 
announce an EOL date for 2.6.16 half a year or one year after this 
branch starts.

Well, that's all very far in the future (even 2.6.22 + half a year will 
most likely be in 2008), but it's better than backporting huge updates.

> > If I was as extremely regarding regressions as you describe regarding 
> > hardware updates, I would also have to reject any bugfixes that are not 
> > security fixes since they might cause regressions.
> 
> Hmm, don't say this publicly, you'll get people saying that it is what
> they expect !

I say what I want to do, and I did say the same before I started 
maintaining the 2.6.16 branch.

> > I do know that the only value of the 2.6.16 tree lies in a lack of 
> > regressions and act accordingly, but I'm trying to do this in a 
> > pragmatic way.
> 
> That's what I observed till now. I just wanted to warn you about the risks
> of getting hit.

Is someone wants to prove me wrong, he should send me the reports of 
regressions my changes have caused...

> Cheers,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

