Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWIFDuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWIFDuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 23:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWIFDuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 23:50:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:16107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751682AbWIFDuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 23:50:54 -0400
Date: Tue, 5 Sep 2006 20:33:47 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Message-ID: <20060906033347.GE7886@kroah.com>
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com> <44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org> <44F9EE86.4020500@drzeus.cx> <20060903034836.GB6505@kroah.com> <44FAA61F.9000504@drzeus.cx> <20060905191241.GA18427@kroah.com> <44FDD94E.7060701@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FDD94E.7060701@drzeus.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 10:08:46PM +0200, Pierre Ossman wrote:
> Greg KH wrote:
> > On Sun, Sep 03, 2006 at 11:53:35AM +0200, Pierre Ossman wrote:
> >   
> >> Is there no driver in the kernel that already has this design?
> >>     
> >
> > Not directly, no.  USB-storage handles a wide range of devices like this
> > by virtue of them following the usb storage spec (which is really just
> > scsi).
> >   
> 
> How about this... We put the main driver in drivers/misc, add a Kconfig
> for it that isn't visible, put the submodules in their respective
> subsystems and set their Kconfigs to select the main module. Does that
> sound like a good solution?

But there is no "subsystem" for a memory card reader, right?  That's one
of the problems here :)

I don't know, but misc/ is fine with me unless someone else has a good
idea of where to put it.

thanks,

greg k-h
