Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267723AbUBTHwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267715AbUBTHwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:52:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:61865 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267723AbUBTHwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:52:36 -0500
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dsaxena@plexity.net
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040220074041.GA6680@plexity.net>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>  <20040220074041.GA6680@plexity.net>
Content-Type: text/plain
Message-Id: <1077263253.20789.1221.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 18:47:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you mean the USB target device itself, can't you walk the
> tree until you find a device that is no longer on bus_type
> usb to determine your root?

I don't feel like walking the tree on each pci_dma access

> You could stuff that into platform_data on PCI devices on your platforms.

I want automatic inheritance to child devices, shouldb't be _that_
difficult to do ;)

> I think we're not quite there yet, but once you have the device
> struct, in theory, you can walk up the tree to grab the platform_data
> for say the device's parent and do any tweaks based on platform-specific
> bus parameters.  With PCI, you could even stuff this into pci_bus->sysdata.
> 
> I think having a function pointer table for things like dma mapping
> and ioremap on all devices would be a very good thing, but not sure
> if the powers that be would allow that in 2.6.
> 
> ~Deepak
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

