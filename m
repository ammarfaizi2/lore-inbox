Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSAUMKq>; Mon, 21 Jan 2002 07:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSAUMKi>; Mon, 21 Jan 2002 07:10:38 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11792
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285060AbSAUMKb>; Mon, 21 Jan 2002 07:10:31 -0500
Date: Mon, 21 Jan 2002 03:51:06 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121123828.C24754@suse.cz>
Message-ID: <Pine.LNX.4.10.10201210345040.14375-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Vojtech Pavlik wrote:

> On Mon, Jan 21, 2002 at 12:29:54PM +0100, Jens Axboe wrote:
> > On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> > > I always thought it is like this (and this is what I still believe after
> > > having read the sprcification):
> > > 
> > > ---
> > > SET_MUTIPLE 16 sectors
> > > ---
> > > READ_MULTIPLE 24 sectors
> > > IRQ
> > > PIO transfer 16 sectors
> > > IRQ
> > > PIO transfer 8 sectors
> > > ---
> > > 
> > > Where am I wrong?
> > 
> > I agree completely, see previous mail.
> > 
> > > By the way, the device *isn't* required to support any lower multiple
> > > count than the maximum one it advertizes. Ugly.
> > 
> > Oh? That basically narrows down the multi count value from hdparm to a
> > boolean on-or-off. I'd be surprised to see any drives break with lower
> > multi count in real life, though..
> 
> The spec seems to mandate to check the Identify data again after setting
> new Multmode to see whether the drive supported the value we wanted to
> program it to.

Forget the TEXT in the command description, cause what you are looking for
is not there.  It is stated and expressed in the state-diagrams, only.
There is minimal text, and only timing profiles for the device
manufacturers.  How to make it go is in the pictures and the text is only
supporting information.

That is why it is so painful to decode, and why it does not fit into the
requirements of early return of ever 4k or page of data back to the upper
layers.  So if we can not do the entire transfer w/ contigious memory we
are forced into this game of jump through the hoops.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

