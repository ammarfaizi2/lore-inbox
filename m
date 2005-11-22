Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVKVGkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVKVGkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKVGkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:40:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:31720 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932090AbVKVGkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:40:40 -0500
Date: Mon, 21 Nov 2005 22:39:04 -0800
From: Greg KH <gregkh@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Secure Digital Host Controller PCI class
Message-ID: <20051122063904.GA24853@suse.de>
References: <4381B364.2020808@drzeus.cx> <20051121214733.GA17793@suse.de> <4382B596.5080001@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4382B596.5080001@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:07:18AM +0100, Pierre Ossman wrote:
> Greg KH wrote:
> 
> >On Mon, Nov 21, 2005 at 12:45:40PM +0100, Pierre Ossman wrote:
> >  
> >
> >>I'm working on a driver for the Secure Digital Host Controller
> >>interface. This is a generic interface, so it uses a PCI class for
> >>identification instead of vendor/device ids.
> >>
> >>The class ID used is 0805 and the programming interface (correct term?)
> >>indicates DMA capabilities. Greg, since you're the PCI maintainer,
> >>perhaps you have the possibility of checking this ID?
> >>    
> >>
> >
> >What do you mean "checking this ID"?  Checking it with what?
> >
> >  
> >
> 
> I figured you might have access to the official allocations from the PCI
> SIG.

I do have access to the PCI specs from the SIG website by virtue of my
current employer, not by any recognition by the PCI-SIG that Linux is
important at all...

If you let me know what document you think this might be in, I'll dig
around to see if I can find it.

> >>The standard also dictates a register at offset 0x40 in PCI space. This
> >>is a one byte register detailing the number of slots on the controller
> >>and the first BAR to use.
> >>    
> >>
> >
> >Do you have a pointer to the standard?
> >
> >  
> >
> 
> The SDHC standard itself is a well guarded secret. We're basing this
> work on the little information that is out there and reverse engineering
> the Windows driver. The PCI registers are described in a spec. by Texas
> Instruments though:
> 
> http://www-s.ti.com/sc/ds/pci6411.pdf
> 
> They only use three bits for each field (since their controller only has
> three slots), but the Windows driver reads four so that is what I've put
> in the patch.

Nice, thanks for the link.

But how about I wait to add your patch, until you submit your driver
that needs that change?  At that time I'll be glad to add it.

thanks,

greg k-h
