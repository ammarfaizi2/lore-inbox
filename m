Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274872AbTGaVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274873AbTGaVS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:18:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274872AbTGaVS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:18:26 -0400
Date: Thu, 31 Jul 2003 14:18:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Charles Lepple <clepple@ghz.cc>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] reorganize USB submenu's
Message-Id: <20030731141811.2c7e13fd.shemminger@osdl.org>
In-Reply-To: <3F298517.8060202@pacbell.net>
References: <20030731101144.32a3f0d7.shemminger@osdl.org>
	<23979.216.12.38.216.1059672599.squirrel@www.ghz.cc>
	<20030731125032.785ffba1.shemminger@osdl.org>
	<3F298517.8060202@pacbell.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 14:07:35 -0700
David Brownell <david-b@pacbell.net> wrote:

> Stephen Hemminger wrote:
> > --- linux-2.5/drivers/usb/gadget/Kconfig	2003-06-05 10:04:40.000000000 -0700
> > +++ usb/drivers/usb/gadget/Kconfig	2003-07-31 12:45:04.000000000 -0700
> > @@ -35,9 +35,6 @@
> >  #
> >  # USB Peripheral Controller Support
> >  #
> > -choice
> > -	prompt "USB Peripheral Controller Support"
> > -	depends on USB_GADGET
> >  
> >  config USB_NET2280
> >  	tristate "NetChip 2280 USB Peripheral Controller"
> > @@ -54,21 +51,23 @@
> >  	   dynamically linked module called "net2280" and force all
> >  	   gadget drivers to also be dynamically linked.
> >  
> > -endchoice
> 
> Why do you want to remove that choice menu?  By doing that,
> you've enabled illegal configurations.

Because the choice appears to be only useful for radio box type
selections.  Try the following with the linux-2.5 version of xconfig.

	USB_GADGET=y
	USB Peripheral Controller support = y (not module)
	USB Gadgets = y (not module)

The Netchip becomes a radio button.

And Gadget Zero and Gadget Ethernet become select one radio buttons.

