Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVGIQBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGIQBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVGIQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:01:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:53920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261562AbVGIQBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:01:15 -0400
Date: Sat, 9 Jul 2005 08:59:40 -0700
From: Greg KH <greg@kroah.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Christoph Hellwig'" <hch@lst.de>
Subject: Re: [SYSFS QUESTION] How to add new sysfs attributes under /sys/modul e/<my module>
Message-ID: <20050709155940.GA7559@kroah.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCFAB@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCFAB@exa-atlanta>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 06:13:38PM -0400, Bagalkote, Sreenivas wrote:
> Sysfs Gurus,
> 
> I want to export few driver specific sysfs attributes when my driver loads.
> This driver is a pci hotplug driver. I want to export these sysfs attributes
> as soon as my pci_module_init succeeds.
> 
> 1. I see that there is /sys/modules directory lists all the modules. Is this
> a right place to have such information? Is this only for the insmod'ed
> modules?
> After pci_module_init, I have struct pci_driver object that gives me
> kobject.
> (pci_driver.driver.kobj). But from this kobject, I couldn't find a way to
> reach /sys/modules/<my driver kobject>

No, use DRIVER_ATTR() and put it in your driver directory instead.

See the many other drivers that do this as examples.

For more details see the book, Linux Device Drivers, Third edition.
It's online for free if you don't wish to buy it.

Hope this helps,

greg k-h
