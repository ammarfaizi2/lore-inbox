Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVCYSK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVCYSK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCYSK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:10:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:39370 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261716AbVCYSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:10:21 -0500
Date: Fri, 25 Mar 2005 10:10:14 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325181014.GA13436@kroah.com>
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325180136.GA4192@linux-sh.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 08:01:36PM +0200, Paul Mundt wrote:
> On Wed, Mar 09, 2005 at 04:34:39PM -0800, Greg KH wrote:
> > [PATCH] driver core: Separate platform device name from platform device number
> > 
> > Separate platform device name from platform device number such that
> > names ending with numbers aren't confusing.
> > 
> This might make sense for devices that end in numbers, but does it really
> make sense for devices that don't?

Then fix those drivers to not put the number in there if they don't have
one :)

> I don't really see how having something like randomfb.0 is intuitive,
> this may make sense for things like serial8250 where another 0 would
> be misleading without some form of delimiter, but those are the corner
> cases and should be treated as such.

I don't see the serial8250 driver adding that .0 to it on my machines,
does this happen on yours?

> It's a bit irritating to have to constantly update userspace code that is
> acting under the false pretense that there is some sort of consistent
> naming scheme in place that won't change every time some new corner case
> crops up.

What userspace code are you referring to?

thanks,

greg k-h
