Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310869AbSCMReT>; Wed, 13 Mar 2002 12:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310906AbSCMReJ>; Wed, 13 Mar 2002 12:34:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16906
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310869AbSCMRdu>; Wed, 13 Mar 2002 12:33:50 -0500
Date: Wed, 13 Mar 2002 09:32:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Karsten Weiss <knweiss@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.10.10203130129520.18254-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10203130926190.19703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Andre Hedrick wrote:

> On Wed, 13 Mar 2002, Jens Axboe wrote:
> 
> > On Wed, Mar 13 2002, Andre Hedrick wrote:
> > > 
> > > Jens,
> > > 
> > > Please try again because that is not the real problem.
> > > All you have shown is that we disagree on the method of page walking
> > > between BLOCK v/s IOCTL.  This is very minor and I agreed that it is
> > > reasonable to map the IOCTL buffer in to BH or BIO so this is a net zero
> > > of negative point.
> > 
> > No this is two issues -- you (ab)using request interface for ioctls is
> > one thing, I don't care too much about that (although it spreads
> > confusion and I've already seen at least one copy this code). The other
> > is that the task handlers are now forced to be separate and the legacy
> > handlers in ide-disk used.
> 
> Well, now that you see a little more.
> 
> The reason for segmenting the data handlers to separate and isolate the
> errors and flaws in the Linus failed attempt to push forward multimode io.
> Also it is not isolated to writes, it is a read issue too.
> Since this is now moving to the technical asspect I wanted you to go,
> please go on to the third point below.
> 
> > > How about attempting to describe the differences between the atomic and
> > > what is violated by who and where.  I will help you later if you get
> > > stuck.
> > 
> > and bingo, here comes a third issue. Please stay on track.
> 
> Please go on on the third point because coming full circle to see an error.

Well I promised to help you if you got stuck, so here is a hint.
Describe the variations between the hardware atomic segment wrt to the
bh/bio OS atomic segment.  Then explain the event ordering of the state
diagram.  Be specific when bh/bio's should be updated and reported to
block as complete.  Finally then explain where things are wrong and why it
is wrong and a solution to fix it.  You should note the policy which is
wrong belongs to Linus and not you, but you are charge to make it happen.

Cheers,


Andre Hedrick

