Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJSIXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJSIXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:23:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23301
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262076AbTJSIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:23:48 -0400
Date: Sun, 19 Oct 2003 01:19:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Paul <set@pobox.com>
cc: Larry McVoy <lm@work.bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
In-Reply-To: <20031019050019.GE13549@squish.home.loc>
Message-ID: <Pine.LNX.4.10.10310190115360.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Oct 2003, Paul wrote:

> Larry McVoy <lm@bitmover.com>, on Sat Oct 18, 2003 [09:15:53 PM] said:
> > On Sun, Oct 19, 2003 at 11:16:42AM +0900, Norman Diamond wrote:
> > > We need those bad block lists.  They are as necessary as they ever were.
> > 
> > I'm not sure why this is a news flash.  When I was at Sun a 2GB drive
> > cost us $4000.  I think we sold them for $6000.  You can't buy a 2GB
> > drive today nor a 20GB drive.  A 200GB drive costs $160.  That's 100
> > times bigger for 25 times less money, or a net increase of price/capacity
> > of 2500.  In the same period of time, CPUs have not kept up though they
> > are close.
> > 
> > You're suprised that drives are unreliable?  Please.  You are getting
> > unbelievable value from those drives and you demanded it.  Price is the
> > only way people make purchasing decisions, that's why DEC got out of the
> > drive business, then HP did, and then IBM did.  They couldn't afford to
> > compete with the cutrate junk that we call drives today.
> > 
> > I'm not blaming you, I'm as bad as the next guy, I buy based on price
> > as well but I have no illusions that what I am buying is reliable.
> > The drives we put into servers here go through a couple weeks of all bit
> > patterns being changed and even then we don't depend on them, everything
> > is backed up.
> > 
> > I've told you guys over and over that you need to CRC the data in user
> > space, we do that in our backup scripts and it tells us when the drives
> > are going bad.  So we don't get burned and you wouldn't either if you
> > did the same thing.
> > 
> > Drives are amazingly cheap, it's a miracle that they work at all, don't
> > be so suprised when they don't.
> > -- 
> > ---
> > Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
>         Hi;
> 
>         I think you may be missing the point he is trying to make
> in order to take your hobby horse for a spin;) He is trying to
> claim, that he has a disk that is not dying, that has a bad
> sector that he cant get remapped, and thus, there needs to be
> support for bad blocks in the filesystem layer. (in the face
> of the argument that modern disks make filesystem support of
> bad blocks irrelevant.)

First you have to make Linux have a direct path back to the application
layer which owns the request.  Then you can attempt a filesystem remapping
code war.

Well basically there are ways to force invoke the remap but 99% of the
people can not and will not go through the hassle.  So I am not going to
spend time explaining each and every vendor mode.

That is what people in media forensics get paid to do.

>         As a side note, I also have a 6gig disk, which a few
> years ago was, ahem, bumped during a write. It now has a handful
> of screwy sectors, that I cant get rid of, even after doing
> the stuff Norman describes. I used the -c option to e2fsck,
> and its been doing great ever since-- a few years of use without
> more bad sectors.
> 
> Paul
> set@pobox.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

