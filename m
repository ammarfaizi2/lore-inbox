Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVAEJGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVAEJGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVAEJGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:06:09 -0500
Received: from fmr19.intel.com ([134.134.136.18]:46028 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262304AbVAEJF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:05:56 -0500
Subject: Re: [ACPI] Re: [PATCH 4/4]An ACPI callback for pci_set_power_state
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20050105084954.GA5170@elf.ucw.cz>
References: <1104893456.5550.135.camel@sli10-desk.sh.intel.com>
	 <20050105084954.GA5170@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1104915909.17388.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 17:05:09 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 16:49, Pavel Machek wrote:
> Hi!
> 
> > This is an ACPI callback for pci_set_power_state. Besides setting PCI
> > config space, changing device's power state sometimes requires to power
> > on device's power source and to invoke other firmware methods.
> 
> 
> > diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
> > --- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
> > +++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
> > @@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
> >  				  void *alignf_data);
> >  /* Firmware callbacks */
> >  extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
> > +extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
> 
> What kind of state is passed here? Why is it u32 in one case and int
> in the second one?
This is the types of current pci routines (pci_set_power_state and pci_device_suspend). 
Both are PCI device states. I agree it's confused.

> I'm about to introduce separate types for pci power states and system
> power states; could you at least add comments which states are which?
> Also few lines of documentation would be very usefull...
I planed post the patches after your patches enter before, but it seems
have a long delay. What's your plan? I'm ok to merge the patches after
yours.

Thanks,
Shaohua

