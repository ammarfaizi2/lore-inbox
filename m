Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWFWE1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFWE1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWFWE1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:27:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:36557 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932205AbWFWE1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:27:30 -0400
Date: Thu, 22 Jun 2006 21:26:14 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060623042614.GB23232@kroah.com>
References: <20060622235112.GA30484@kroah.com> <Pine.LNX.4.44L0.0606222241390.18690-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606222241390.18690-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:45:15PM -0400, Alan Stern wrote:
> On Thu, 22 Jun 2006, Greg KH wrote:
> 
> > > And yes, we _should_ care about whether or not any interface is
> > > still active, until the pm core code starts to pay attention to
> > > the driver model tree at all times ... even outside of system-wide
> > > suspend transitions.  Today, the pm core code doesn't even use
> > > that tree directly, and all runtime state changes (like selective
> > > suspend with USB) completely bypass that pm tree.
> > 
> > Hm, ok, yes, we should care about interfaces, but we need some way to
> > only walk them, not anything else that might be attached to us...
> 
> In my upcoming patch set this test isn't needed at all, because suspending
> a device automatically suspends all of its interfaces first.  I've already
> submitted the first few revised patches in that set (not the part that
> removes the test, though), but you've probably been too busy to look at
> them yet.

I've glanced at them (and yes, been busy, they are still in my TO-APPLY
queue, trying to sync up with Linus first), but I don't see anything in
that set that changes the suspend logic.

Or am I just missing something obvious?  Which patch does that in your
revised series?

thanks,

greg k-h
