Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129743AbQKGAg4>; Mon, 6 Nov 2000 19:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129519AbQKGAgh>; Mon, 6 Nov 2000 19:36:37 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:3760 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129509AbQKGAg3>; Mon, 6 Nov 2000 19:36:29 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 00:34:14 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011061521200.30217-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.10.10011061521200.30217-100000@innerfire.net>
MIME-Version: 1.0
Message-Id: <00110700362203.00940@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Gerhard Mack wrote:
> On Mon, 6 Nov 2000, James A. Sutherland wrote:
> 
> > Except this isn't possible with the hardware in question! If it were, there
> > would be no problem. In cases where the hardware doesn't support the
> > functionality userspace "needs", why put the kludge in the kernel?
> > 
> > If userspace wants to know what settings it set last time, it should store
> > those values somewhere.
> > 
> > > jas88@cam.ac.uk said:
> > > >  The right thing in this context is not to screw with hardware
> > > > settings unless and until it is given settings to set. Do not set
> > > > values arbitrarily: set only the values you are explicitly given.
> > > > Anything else is simply a bug in your driver. 
> > > 
> > > It is unwise to assume that the hardware is in a sane state when the driver 
> > > has been unloaded and reloaded. I agree that you should set the values that 
> > > were explicitly given. That's why we should remember them.
> > 
> > No values are being explicitly given. Loading the driver should not cause
> > any settings to be changed: changing the settings should do that!
> > 
> > There is no need for the drivers to change any settings. If the settings need
> > to be (re)set, let userspace do it.
> >  
> > 
> > James. 
> 
> Sure .. lets see you start a laptop in class or buisness meeting and have
> everyone turn to look at you wondering why your laptop let off an ear
> piercing shreak because the hardware defaults to all settings max.

That only happens if the driver is stupid enough to try guessing "correct"
volume settings. If it leaves well alone until it KNOWS the correct settings,
there is no ear piercing shriek. Nor is there any break in the sound if you
were listening to something from the mixer.

> And you will _STILL_ have that shriek for 1/2 - 1 second before the
> userspace app loads.

Wrong. The userspace app is the one triggering the device init, when it gives
the sound driver the correct volume settings. There is no half second delay.

> And no we couldn't unplug either the mike or the speakers since they come
> embedded in the laptop's case. 
> 
> I don't see in any of your trolling an answer for this problem.

It isn't trolling, and there is a perfectly simple answer, as I have already
explained.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
