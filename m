Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291446AbSBMH6q>; Wed, 13 Feb 2002 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291449AbSBMH6j>; Wed, 13 Feb 2002 02:58:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43789 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291446AbSBMH62>;
	Wed, 13 Feb 2002 02:58:28 -0500
Date: Wed, 13 Feb 2002 08:58:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213085819.U1907@suse.de>
In-Reply-To: <20020213084756.T1907@suse.de> <Pine.LNX.4.10.10202122339330.668-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202122339330.668-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Andre Hedrick wrote:
> > > On Wed, 13 Feb 2002, Jens Axboe wrote:
> > > 
> > > > On Tue, Feb 12 2002, Andre Hedrick wrote:
> > > > > I just love how the copy of a request has worked its way back into to the
> > > > > code-base. :-/  I recall Linus stating it was/is a horrid mess.
> > > > 
> > > > The copy itself is not the horrid mess, the handling of multi write is
> > > > what is the horrible mess. Having a private copy to mess with is pretty
> > > > much a necessity IMO if you want to handle > current_nr_sectors at the
> > > > time without completing it chunk by chunk.
> > > 
> > > Exactly, and I am about to have a valid clean solution that is short and
> > > proper.  Now that I have the handler working, I need to have the one walk
> > > function to do the bio indexing.  Also it is less than 30 lines.
> > 
> > Those changes add yet another member to struct bio for no good reason.
> > I'd much rather just do the private copy. So... ->
> 
> NO NEW STRUCT TO BIO ...
> Private COPY is a given, just using it cleanly the issue.

Last we talked there was a new member added. But again, it's really hard
to say without a reference patch...

> > > Not the stuff you added as an interm fix :-/
> > 
> > I don't consider the copy an interim fix at all. But please show your
> > working handler and we can discuss it, it's pointless to debate what fix
> > is the better one you are sitting on yours.
> 
> Yep but this time you get a clean solution that works.

Where? :-)

> > > You know why these changes people are pushing are wrong, because it is way
> > > to early to being the compression code process.
> 
> You if any know the original TCQ of mine would scream, much less the
> derivative you started off that code base.  Keep that in mind, with an
> expanded code thread we can isolate changes and test variation.

First of all, my TCQ stuff is in no way based on your code base. It's
started from scratch by me. The only patch if yours I was could not
achieve any queueing above depth 1.

> The fillin(blah, blah, blah) is!

Is what?

-- 
Jens Axboe

