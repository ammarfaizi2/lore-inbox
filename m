Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUBXVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbUBXVlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:41:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:13221 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262480AbUBXVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:41:18 -0500
Date: Tue, 24 Feb 2004 13:38:07 -0800
From: Greg KH <greg@kroah.com>
To: Pat Gefre <pfg@sgi.com>
Cc: davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
Message-ID: <20040224213807.GA2045@kroah.com>
References: <20040223210448.GA22598@kroah.com> <Pine.SGI.3.96.1040224131328.43293F-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1040224131328.43293F-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:16:14PM -0600, Pat Gefre wrote:
> On Mon, 23 Feb 2004, Greg KH wrote:
> 
> + On Mon, Feb 23, 2004 at 08:55:14AM -0600, Pat Gefre wrote:
> + > +#define SYSCTL_PCI_UNINITIALIZED	(SYSCTL_PCI_ERROR_BASE - 0)
> + > +    { SYSCTL_PCI_UNINITIALIZED, "module not initialized" },
> + 
> + What are you going to do with this large table of strings?  I see where
> + you copy them to somewhere, but don't see anything beyond that.
> + 
> + Are we missing a huge piece of the puzzle?
> 
> Greg,
> 
> They are used in sysctl_pci_error_lookup(), which is called
> pcibr_slot_pwr(), which is the code to put a device on-line. It all
> traces back to the slot_enable call that is made from the hot plug
> driver (which is not included in this mod).

Ok, as stated before, please post both pieces so we can see if it even
makes sense for you to be splitting things up in this way (you realize
that no other pci hotplug driver needs to do it in this manner, right?)

thanks,

greg k-h
