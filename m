Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWAEA2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWAEA2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWAEA2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:28:07 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:24533 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750840AbWAEA2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:28:06 -0500
Date: Wed, 4 Jan 2006 16:28:18 -0800
From: Greg KH <gregkh@suse.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: ak@suse.de, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Clock going way too fast on 2.6.15 for amd64 processor
Message-ID: <20060105002818.GA9019@suse.de>
References: <20060104233919.GA15724@kroah.com> <200601050054.45824.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601050054.45824.oliver@neukum.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:54:45AM +0100, Oliver Neukum wrote:
> Am Donnerstag, 5. Januar 2006 00:39 schrieb Greg KH:
> > Hi,
> > 
> > I tried digging through the mess in
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=3927
> > but got lost in a see of conflicting patches.
> > 
> > I too have a amd64 box that is showing that the clock is running way too
> > fast (feels about double speed, haven't checked for sure.)  I'm running
> > it in 32bit mode for now, and the boot dmesg is below.
> > 
> > Any hints on patches that I should test out to try to track this down?
> > I haven't run any real old kernels on it to see if it is something new
> > (shows up on a 2.6.13 and 2.6.14 kernel too.)
> 
> Did you try "disable_timer_pin_1" on the kernel command line?

Nice, that worked just fine, no kernel patch needed.  Thanks for
pointing it out to me, I totally missed it.

Now to go fix the usb irq "ignore" issue for this machine, and I'll be
able to switch to using it all the time...

greg k-h
