Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVHXP0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVHXP0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVHXP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:26:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10245 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751064AbVHXP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:26:11 -0400
Date: Wed, 24 Aug 2005 17:26:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
Message-ID: <20050824152609.GB4851@stusta.de>
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk> <20050824112655.GQ5603@stusta.de> <20050824145736.GI9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824145736.GI9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 03:57:36PM +0100, Al Viro wrote:
> On Wed, Aug 24, 2005 at 01:26:55PM +0200, Adrian Bunk wrote:
> > On Tue, Aug 23, 2005 at 10:45:41PM +0100, Al Viro wrote:
> > 
> > > infiniband uses PCI helpers all over the place (including the core parts) and
> > > won't build without PCI.
> > >...
> > 
> > CONFIG_INFINIBAND=y and CONFIG_PCI=n compiles for me on i386.
> > 
> > Can you post the compile error you got?
> 
> On which platform?  There's a lot of them on the architectures that do not

As I said, on i386.

> have PCI at all - same situation as with firewire.  Note that you won't
> get any low-level drivers on PCI-less config even on i386, so while I
> agree that more accurate dependency would be nice here (as well as for
> drivers/ieee1394), for all practical purposes the same dependency works
> here.
> 
> BTW, this is more general question - do we expect pci helpers to be present
> on all platforms and do we consider their use acceptable in code that does
> not depend on PCI?
>...

Are you talking about the ones that already have dummy functions for the 
PCI=n case in include/linux/pci.h, or about other functions?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

