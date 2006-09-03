Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWICDsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWICDsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 23:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWICDsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 23:48:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:56020 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752011AbWICDsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 23:48:38 -0400
Date: Sat, 2 Sep 2006 20:48:36 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Message-ID: <20060903034836.GB6505@kroah.com>
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com> <44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org> <44F9EE86.4020500@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F9EE86.4020500@drzeus.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2006 at 10:50:14PM +0200, Pierre Ossman wrote:
> Andrew Morton wrote:
> > On Sat, 02 Sep 2006 13:15:52 +0200
> > Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> >   
> >> Andrew, we could use some help with how this driver should fit into the
> >> kernel tree. The hardware is multi-function, so there will be a couple
> >> of drivers, one for every function, and a common part. How has this been
> >> organised in the past?
> >>
> >>     
> >
> > Greg would be a far better person that I for this.   Is it a PCI device?
> >   
> 
> It's always difficult to know who to contact when there's an issue that
> isn't specific to one single area. And since you are the 2.6 maintainer
> I figured it wouldn't be too off base to throw this in your lap. ;)
> 
> This is a PCI device yes. Which has a number of card readers as
> separate, hot-pluggable functions. Currently this means it interacts
> with the block device and MMC subsystems of the kernel. As more drivers
> pop up, the other card formats will probably get their own subsystems
> the way MMC has. So there are three issues here:
> 
>  * Where to put the central module that handles the generic parts of the
> chip and pulls in the other modules as needed.

Right now, the drivers/mmc directory has such a driver, the sdhci.c
file, right?

>  * If the subfunction modules should be put with the subsystems they
> connect to or with the main, generic module.

It all depends on how bit it grows over time.  It is always easy to move
files around at a later time if you so wish.

For now, is the drivers/mmc/ directory acceptable?  If other card
formats show up, we can reconsider it at that time.  Is that ok?

thanks,

greg k-h

-- 
VGER BF report: U 0.476704
