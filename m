Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSJBBbt>; Tue, 1 Oct 2002 21:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJBBbt>; Tue, 1 Oct 2002 21:31:49 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2062 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262901AbSJBBbs>; Tue, 1 Oct 2002 21:31:48 -0400
Date: Tue, 1 Oct 2002 18:35:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
In-Reply-To: <20021001224740.GA30488@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10210011827551.3976-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Pavel Machek wrote:

> Hi!
> 
> > > This cleans up swsusp a little bit and fixes ide disk corruption on
> > > suspend/resume. Please apply,
> > 
> > It also seems to be doing things with the device manager. Mind explaining 
> > those changes too?
> 
> Those are forward port of what we had there already. I make IDE child
> of PCI device with the controller (in cases its on PCI). That seems
> logical place for it and we had it like that in 2.5.30 or
> so. ide-disk.c is there to make disk sleep before we go
> suspend. Without that, data corruption happens.

Pavel,

I pointed out to you various other device other than disk support DMA, and
moving the suspend point up to the mainloop away from the subdrivers.
This would insure the entire sub-system is out.  Why are we block after
the request has been sent to the sub-driver?  Why do you see this the
preferred location and not before it enters the system?  Given that you
have stated it does not parse the difference between S3 v/s S4, I am
graveful concerned.  However, if this is how you and Linus have decide to
impliment this project, I shall attempt to sustain interoperablity.

Sigh ...

Andre Hedrick
LAD Storage Consulting Group

