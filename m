Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWIJNI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWIJNI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIJNI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:08:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:52181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932119AbWIJNI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:08:26 -0400
Date: Sun, 10 Sep 2006 06:02:36 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060910130236.GB6968@kroah.com>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org> <450283D5.1020404@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450283D5.1020404@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 05:05:25AM -0400, Jeff Garzik wrote:
> I wanted to note what Martin Mares just raised in the thread "State of 
> the Linux PCI Subsystem for 2.6.18-rc6":
> 
> >Changing the device order in the middle of the 2.6 cycle doesn't sound
> >like a sane idea to me. Many people have changed their systems' 
> >configuration
> >to adapt to the 2.6 ordering and this patch would break their setups.
> >I have seen many such examples in my vicinity.
> >
> >I believe that not breaking existing 2.6 setups is much more important
> >than keeping compatibility with 2.4 kernels, especially when the problem
> >is discovered after more than 2 years after release of the first 2.6.
> 
> 
> I'm not siding with either Martin or Matt explicitly, just noting that 
> there are good arguments for both sides.

I agree, there are.

But I know we explicitly tried to keep 2.4 compability in 2.6 for this
very thing.  And the fact that almost no one has reported having
problems with it, leads me to believe that the sorting order isn't as
broken as you might think.  Some machines, like the ones that Matt wrote
this patch for, need this change, but for all others, it's not really
needed.

Let's let this sit in -mm for a bit to see if anyone notices any
problems.

thanks,

greg k-h
