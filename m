Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVKRBvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVKRBvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVKRBvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:51:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:58338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750739AbVKRBvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:51:51 -0500
Date: Thu, 17 Nov 2005 17:09:32 -0800
From: Greg KH <gregkh@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality to USB core
Message-ID: <20051118010932.GA11514@suse.de>
References: <20051117162533.GB26824@suse.de> <Pine.LNX.4.44L0.0511171219040.5089-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511171219040.5089-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 12:19:43PM -0500, Alan Stern wrote:
> On Thu, 17 Nov 2005, Greg KH wrote:
> 
> > > > +	fields = sscanf(buf, "%x %x", &idVendor, &idProduct);
> > > > +	if (fields < 0)
> > > > +		return -EINVAL;
> > > 
> > > Don't you want to test (fields < 2)?
> > 
> > No, it's ok to just specify the vendor, if you want a product of 0 :)
> > 
> > PCI does it this way too.
> 
> Well, in that case shouldn't you test (fields < 1)?

Yeah, good point.  I've also changed it to be < 2, as it doesn't really
make sense to have a product number of 0.

thanks,

greg k-h
