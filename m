Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbTGaV6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270000AbTGaV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:58:00 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:26249 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S269913AbTGaV5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:57:54 -0400
Message-ID: <3F299193.20407@pacbell.net>
Date: Thu, 31 Jul 2003 15:00:51 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Charles Lepple <clepple@ghz.cc>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] reorganize USB submenu's
References: <20030731101144.32a3f0d7.shemminger@osdl.org>	<23979.216.12.38.216.1059672599.squirrel@www.ghz.cc>	<20030731125032.785ffba1.shemminger@osdl.org>	<3F298517.8060202@pacbell.net> <20030731141811.2c7e13fd.shemminger@osdl.org>
In-Reply-To: <20030731141811.2c7e13fd.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>>Why do you want to remove that choice menu?  By doing that,
>>you've enabled illegal configurations.
> 
> 
> Because the choice appears to be only useful for radio box type
> selections.  Try the following with the linux-2.5 version of xconfig.
> 
> 	USB_GADGET=y
> 	USB Peripheral Controller support = y (not module)
> 	USB Gadgets = y (not module)
> 
> The Netchip becomes a radio button.

As should be.  If some hardware supports net2280 and another
controller (maybe PCI, maybe not), only one of them can provide
the device's single upstream port -- so choose only one.


> And Gadget Zero and Gadget Ethernet become select one radio buttons.

As should be.  You can't use them at the same time, only one
of them can "own" the controller driver -- so choose only one.

- Dave



