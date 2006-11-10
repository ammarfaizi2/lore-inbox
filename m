Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946059AbWKJIgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946059AbWKJIgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbWKJIgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:36:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:3233 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946059AbWKJIf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:35:59 -0500
Date: Fri, 10 Nov 2006 14:48:46 +0900
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
Message-ID: <20061110054846.GA9137@kroah.com>
References: <1163033121.28571.792.camel@localhost.localdomain> <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com> <1163111737.4982.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163111737.4982.40.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 09:35:37AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2006-11-09 at 17:04 +0100, Cornelia Huck wrote:
> > On Thu, 09 Nov 2006 11:45:21 +1100,
> > Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> > 
> > >  - Add a dev_sysdata structure to struct device whose content is arch
> > > specific. It will allow architectures like powerpc, arm, i386, ... who
> > > need different types of DMA ops for busses and other kind of auxilliary
> > > data for devices in general (numa node id, firmware data, etc...) to put
> > > them in there, without bloating all architectures. The patch adds an
> > > empty definition for the structure to all architectures.
> > 
> > I like this. If we could move the dma stuff in there, we could get rid
> > of it on s390 where it is just bloat we drag around...
> > 
> > (Maybe dev_archdata would be a better name, since the definition is
> > architecture specific?)
> 
> Hrm... I wonder why I posted from my IBM address :-) I have no firm
> preference on the name of the structure. So far, I had no feedback on
> that patch at all appart from yours though.
> 
> Andrew, Greg ? Is that something you would take for 2.6.20 ? I need to
> know wether I should rework my patches to use that or stick to my hacks
> involving hijacking firmware_data.

Sorry, I'm in Japan this week, and access to email is limited.

I like this change, but I like the dev_archdata name better.  It lets
people know who owns the pointer much better.

Care to respin these patches with this change?

And yes, I don't see a problem with such a change like this for 2.6.20,
it's pretty simple.

thanks,

greg k-h
