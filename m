Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUHZXpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUHZXpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269699AbUHZXoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:44:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:61421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269672AbUHZXk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:40:57 -0400
Date: Thu, 26 Aug 2004 16:25:05 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pci_disable_device kills hardware (was Re: [PATCH] propagate pci_enable_device() errors)
Message-ID: <20040826232505.GB14515@kroah.com>
References: <200408261329.16825.bjorn.helgaas@hp.com> <412E3F93.9030503@pobox.com> <20040826224117.GC12762@kroah.com> <412E6EC3.4060606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412E6EC3.4060606@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 07:14:11PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >On Thu, Aug 26, 2004 at 03:52:51PM -0400, Jeff Garzik wrote:
> >
> >>thanks much.
> >>
> >>We still need to figure out what to do for multiple-driver situations, 
> >>since the additional of pci_disable_device() calls literally 
> >>_guarantees_ failures in a two-drivers-for-the-same-hardware situation.
> >
> >
> >the "two-drivers-for-the-same-hardware" is what needs to be fixed.
> >You are on your own if you do that.
> 
> 
> Sure, but that's handwaving away reality...  It stands to reason that we 
> would all _prefer_ one driver for each piece of hardware.

That's what the pci driver model forces you to do.  If you go around
behind the back of it, you get what you deserve :)

For stuff like this, the IDE drivers need to be changed to use the (what
is it, 4 years old now?) pci driver model.  There's no reason technical
why such a conversion hasn't happened yet, right?

thanks,

greg k-h
