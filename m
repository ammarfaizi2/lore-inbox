Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVAEJM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVAEJM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVAEJMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:12:19 -0500
Received: from gprs215-128.eurotel.cz ([160.218.215.128]:64897 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262283AbVAEJME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:12:04 -0500
Date: Wed, 5 Jan 2005 10:11:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [ACPI] Re: [PATCH 4/4]An ACPI callback for pci_set_power_state
Message-ID: <20050105091141.GC5170@elf.ucw.cz>
References: <1104893456.5550.135.camel@sli10-desk.sh.intel.com> <20050105084954.GA5170@elf.ucw.cz> <1104915909.17388.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104915909.17388.9.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is an ACPI callback for pci_set_power_state. Besides setting PCI
> > > config space, changing device's power state sometimes requires to power
> > > on device's power source and to invoke other firmware methods.
> > 
> > 
> > > diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
> > > --- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
> > > +++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
> > > @@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
> > >  				  void *alignf_data);
> > >  /* Firmware callbacks */
> > >  extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
> > > +extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
> > 
> > What kind of state is passed here? Why is it u32 in one case and int
> > in the second one?
> This is the types of current pci routines (pci_set_power_state and pci_device_suspend). 
> Both are PCI device states. I agree it's confused.

Ok, that should become pci_power_t in very near future, then.

> > I'm about to introduce separate types for pci power states and system
> > power states; could you at least add comments which states are which?
> > Also few lines of documentation would be very usefull...
> I planed post the patches after your patches enter before, but it seems
> have a long delay. What's your plan? I'm ok to merge the patches after
> yours.

pci_power_t patches were merged to Greg, so I'd say they are going to
linus "real soon now" :-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
