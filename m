Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWIFPKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWIFPKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIFPKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:10:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751336AbWIFPK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:10:29 -0400
Date: Wed, 6 Sep 2006 08:09:57 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [linux-usb-devel] [RFC] USB device persistence across suspend-to-disk
Message-ID: <20060906150957.GA27983@kroah.com>
References: <20060905091318.42c273d2.rdunlap@xenotime.net> <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org> <20060906053637.GI7043@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906053637.GI7043@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 05:36:38AM +0000, Pavel Machek wrote:
> Hi!
> 
> > > > +main kernel instead of as a separate module, you can put
> > > > +"usbcore.persist=1" on the boot command line.  You can also change the
> > > > +kernel's behavior on the fly using sysfs: Type
> > > > +
> > > > +	echo y >/sys/module/usbcore/parameters/persist
> > > 
> > > Does sysfs treat 'y' as '1'?
> > > Anyway, it would be Good to be consistent.
> > 
> > Yes; I'll change everything to 'y'.
> 
> Actually I'd prefer 0/1... that's what other parts of kernel use IIRC.

The module paramater parsing code in the kernel will accept either, so
it really isn't a big deal.

thanks,

greg k-h
