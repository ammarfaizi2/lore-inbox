Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUFDTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUFDTxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUFDTxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:53:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:32739 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265958AbUFDTxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:53:41 -0400
Date: Fri, 4 Jun 2004 12:52:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604195247.GA12688@kroah.com>
References: <20040604193911.GA3261@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604193911.GA3261@babylon.d2dc.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 03:39:11PM -0400, Zephaniah E. Hull wrote:
> Starting at 2.6.7-rc1 or so (that is when we first noticed it) the new
> pilot-link libusb back end started deadlocking the entire USB bus that
> the palm device was on.
> 
> I have finally tracked it down to happening when we make the
> USBDEVFS_RESET ioctl, we never return from it and from that point on the
> bus in question is completely dead, no processing is done, no
> notifications of devices being plugged in or unplugged.
> 
> This is still happening in 2.6.7-rc2-mm1.
> 
> It seems to happen with both the UHCI and OHCI back ends, so it is
> probably above that.
> 
> Given that there were heavy locking changes, I suspect that the case in
> question got screwed up somehow.

This needs to go to the linux-usb-devel list, now CC:

Anyway, can you look at the output of SysRq-T and see where the
processes are hung?

thanks,

greg k-h
