Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVL0EUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVL0EUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVL0EUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:20:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:64137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932212AbVL0EUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:20:10 -0500
Date: Mon, 26 Dec 2005 20:19:19 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
Message-ID: <20051227041919.GA24050@kroah.com>
References: <1134937642.6102.85.camel@gaston> <20051218215051.GA18257@kroah.com> <20051222160244.GA2747@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222160244.GA2747@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 04:02:44PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > What exactly changed in the recent USB stacks that is causing it to
> > > abort system suspend much more often ? I'm getting lots of user reports
> > > with 2.6.15-rc5 saying that they can't put their internal laptops to
> > > sleep, apparently because a driver doesn't have a suspend method
> > > (internal bluetooth in this case).
> > > 
> > > It's never been mandatory so far for all drivers of all connected
> > > devices to have a suspend method... didn't we decide back then that
> > > disconneting those was the right way to go ?
> > 
> > Yes it is, and I have a patch in my tree now that fixes this up and
> > keeps the suspend process working properly for usb drivers that do not
> > have a suspend function.
> > 
> > Hm, I wonder if it should go in for 2.6.15?
> 
> It would be nice to have some fixes in 2.6.15, so we are
> not swamped with bugreports. Its a regression after all.

It's already in 2.6.15-rc7.

thanks,

greg k-h
