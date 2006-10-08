Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWJHHGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWJHHGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWJHHGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:06:34 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:19845 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750849AbWJHHGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:06:33 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 09:07:16 +0200
User-Agent: KMail/1.8
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610080907.16443.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 04:03 schrieb Alan Stern:
> On Sat, 7 Oct 2006, David Brownell wrote:
> 
> > On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:
> > 
> > > > > I dare say that the commonest scenario involving USB is a laptop with
> > > > > an input device attached. Input devices are for practical purposes always
> > > > > opened. A simple resume upon open and suspend upon close is useless.
> 
> You are distorting what I said.  The "resume upon open and suspend upon

Sorry.

> close" scheme was not intended for things like input devices, which are
> more or less permanently open.  It was intended for things like
> fingerprint readers or printers, which spend most of their time not being
> used.

OK.

> > That is, the standard model is useless?  I think you've made
> > a few strange leaps of logic there ... care to fill in those
> > gaps and explain just _why_ that standard model is "useless"???
> > 
> > Recall by the way that the autosuspend stuff kicked off with
> > discussions about exactly how to make sure that Linux could
> > get the power savings inherent in suspending USB root hubs,
> > with remote wakeup enabling use of the mouse on that keyboard.
> > (I remember Len Brown talking to me a few years back about how
> > that was the "last" 2W per controller easily available to save
> > power on Centrino laptops ... now we're almost ready to claim
> > that savings.)
> 
> The most obvious model for suspending keyboards or mice is an inactivity 
> timeout (with the timeout limit set from userspace), but other policies 
> certainly could be useful in specific circumstances.

The simplicity is much reduced if each class of devices needs to have
its own method of determining activity. And if you don't find a good way
for some devices, users with these are out in the rain and can do nothing
about it if suspension cannot be triggered from user space.

> Considering that we have virtually no autosuspend capability now, taking
> the first few simple steps will be a big help.  Just getting an

No question about that.

> infrastructure in place is a good start, even without a userspace API.  
> Later on, when we have a better idea of what we want, bells and whistles
> can be added.

I've never said that autosuspend is a bad idea. For many devices it is
simple and painless. But it is insufficient. Therefore I think removing
the ability to explicitely request a suspension from user space is wrong.

> Even Oliver has admitted that the implementation issues are very tricky 
> and he doesn't know the best approach to take.

If so many people cannot come up with a good design, doesn't that indicate
there's no single method that satisfies all needs?

	Regards
		Oliver
