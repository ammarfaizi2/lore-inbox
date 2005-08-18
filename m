Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVHRFlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVHRFlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVHRFlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:41:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:7403 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750757AbVHRFlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:41:42 -0400
Date: Wed, 17 Aug 2005 22:23:11 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matthew Wilcox <matthew@wil.cx>, James.Smart@Emulex.Com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050818052311.GD29301@kroah.com>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com> <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk> <1124145677.5089.68.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124145677.5089.68.camel@mulgrave>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 05:41:17PM -0500, James Bottomley wrote:
> On Sun, 2005-08-14 at 16:02 +0100, Matthew Wilcox wrote:
> > /sys/class/tty/ttyS0/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > /sys/class/tty/ttyS1/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > /sys/class/tty/ttyS2/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:04.0
> > /sys/class/tty/ttyS3/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
> > /sys/class/tty/ttyS4/device -> ../../../devices/parisc/0/0:0/pci0000:00/0000:00:05.0
> 
> Actually, isn't the fix to all of this to combine Greg and James'
> patches?

Yes it is.

> The Greg one fails in SCSI because we don't have unique class device
> names (by convention we use the same name as the device bus_id) and
> James' one fails for ttys because the class name isn't unique.  However,
> if the link were derived from something like
> 
> <class name>:<class device name>
> 
> Then is would be unique in both cases.

I agree.

> Unless anyone can think of any more failing cases?

I'll try this out and see if anything breaks :)

thanks,

greg k-h
