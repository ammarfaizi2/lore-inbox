Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268369AbSIRVAm>; Wed, 18 Sep 2002 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268375AbSIRVAm>; Wed, 18 Sep 2002 17:00:42 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:61447 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268369AbSIRVAl>;
	Wed, 18 Sep 2002 17:00:41 -0400
Date: Wed, 18 Sep 2002 14:05:45 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918210545.GF10970@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A68@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A68@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 04:59:08PM -0400, Bloch, Jack wrote:
> Ok, my driver is for a specific cPCI biard which we have developed here. I
> want the Linux Kernel to tell me when this board is inserted and/or removed.

That will already happen today.  /sbin/hotplug will be called whenever a
new PCI card is added or removed, IF you have a PCI Hotplug controller
driver that works for your cPCI board.

> I am running on a 700Mhz PIII with a 2.4.18-3 Kernel (Red Hat 7.3) My driver
> is written with a call to pci_module_init in the init routine wherein I
> specify a probe and remove routine. According to Linux Device Drivers 2nd
> edition (pages 489 - 493), As long as the HW supports hot swap, I should get
> called automatically whenevr one of the devices (vendor ID device ID) which
> I specified in my table gets inserted or ejected. Am I totaly wrong about
> this? I am not trying to write a driver for a hotplug controller but for a
> device.

Yes, you are correct.  But odds are there is not a PCI Hotplug
controller for your hardware, so this probably will not work.  However,
your driver should work just fine to control your card.

What kind of cPCI controller do you have?

thanks,

greg k-h
