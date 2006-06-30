Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWF3CQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWF3CQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWF3CQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:16:57 -0400
Received: from ns1.suse.de ([195.135.220.2]:8841 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751411AbWF3CQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:16:56 -0400
Date: Thu, 29 Jun 2006 19:13:32 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Gay <andy@andynet.net>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
Message-ID: <20060630021332.GB30911@suse.de>
References: <1151537247.3285.278.camel@tahini.andynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151537247.3285.278.camel@tahini.andynet.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 07:27:27PM -0400, Andy Gay wrote:
> I have adapted the modified Airprime driver that Greg posted a few weeks
> ago to add support for these 2 modules.
> 
> That driver works for these modules if the USB IDs are added, and fixes
> the throughput problems in the earlier driver. I had to make some
> changes though -
> 
> - there's a memory leak because the transfer buffers are kmalloc'ed
> every time the device is opened, but they're never freed;
> 
> - these modules present 3 bulk EPs, the 2nd & 3rd can be used for
> control & status monitoring while data transfer is in progress on the
> 1st EP. This is useful (and necessary for my application) so we need to
> increase the port count.
> 
> So what should I do next? I see a few possibilities, assuming anyone is
> interested in this:
> 
> - I could post a diff from Greg's driver. But I don't have hardware to
> test whether my changes will break it for the other devices that it
> supports;
> 
> - I could post it as a new driver for just these 2 modules, using some
> other name;
> 
> - I could post it as a replacement for Greg's driver (which isn't yet in
> the official sources, I think), including all the USB IDs, if someone
> can test it for the other devices.

or:
  - send a patch against 2.6.17 that is my changes + your fixes to
    actually make it work.

My patch was just a "throw it out there and see what works or not", as I
don't even have the device to test it with.

thanks,

greg k-h
