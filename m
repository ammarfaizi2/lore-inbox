Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWFWBU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWFWBU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWFWBU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:20:59 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19750 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751146AbWFWBU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:20:58 -0400
Date: Thu, 22 Jun 2006 19:19:52 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: how to access pci memory from driver?
In-reply-to: <1150930994.956075.281770@c74g2000cwc.googlegroups.com>
To: mcharon@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <449B41B8.8040009@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1150908928.606361.322650@p79g2000cwp.googlegroups.com>
 <1150912563.834382.301960@p79g2000cwp.googlegroups.com>
 <1150930994.956075.281770@c74g2000cwc.googlegroups.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mcharon@gmail.com wrote:
> hi steve,
> that's another thing i forgot to mention. lspci doesn't show anything.
> so it seems that there's no pci device. but the fact that cat
> /proc/iomem shows
> 0x60000000-0x67ffffff : PCI1 host bridge, does this mean that the my
> device which is supposed to be at 0x60040000 is mapped to I/O space??
> the lease significant bit of bar0 is indeed 0.
> 
> the linux is running on ppc platform. we had to modify the u-boot in
> order to load linux on our system. so i am not sure if we have
> performed the necessary steps to be able to map our pci device.
> 
> for one thing, we are not registering any of our pci devices when uboot
> loads
> linux.  we are going to use our driver to read and write to the pci
> device.
> can we still map to the device eventhough it is not registered?

I don't know PPC, but if your device doesn't even show up in lspci then 
you have bigger problems than your driver, either with the device, the 
machine hardware or the kernel's PCI detection.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

