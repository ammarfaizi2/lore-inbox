Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268251AbSIRUc7>; Wed, 18 Sep 2002 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268261AbSIRUc7>; Wed, 18 Sep 2002 16:32:59 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:56839 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268251AbSIRUc5>;
	Wed, 18 Sep 2002 16:32:57 -0400
Date: Wed, 18 Sep 2002 13:37:58 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918203757.GC10970@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A64@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A64@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cced back to lkml as I hate taking things off-line unless it's
necessary, archives are your friend.

On Wed, Sep 18, 2002 at 07:50:49AM -0400, Bloch, Jack wrote:
> Thanks for the response. In my driver init routine, I use the
> pci_module_init( ) to register my driver with the PCI subsystem. Is this
> enough?

No, that's enough to register your driver as a PCI driver.  I'm guessing
your pci hotplug controller looks like a PCI device?

> What exactly is the hotplug_core and or pcihpfs?

See drivers/hotplug/pci_hotplug.h for the interface that a pci hotplug
controller driver needs to interface with (specifcly the
pci_hp_register() and pci_hp_unregister() functions are what you need).

> Do I have to implement the pci_insert_device/pci_remove_device methods
> or does the kernel simply call the probe_one/remove_one which I
> specify during my initialization. 

I'm confused, are you talking about a normal PCI card driver, or a PCI
Hotplug controller driver?  What exactly does your driver do?  Does it
talk to a specific PCI card, or does it control power to PCI slots?

thanks,

greg k-h
