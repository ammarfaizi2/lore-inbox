Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWIUK2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWIUK2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWIUK2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:28:54 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:30666 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750756AbWIUK2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:28:54 -0400
Date: Thu, 21 Sep 2006 13:28:52 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Luke Yang <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Message-ID: <20060921102852.GQ16047@mea-ext.zmailer.org>
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com> <20060920222837.8b2d2a88.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920222837.8b2d2a88.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 10:28:37PM -0700, Randy.Dunlap wrote:
> On Thu, 21 Sep 2006 11:33:05 +0800 Luke Yang wrote:
> 
> > This is the serial driver for Blackfin. It is designed for the serial
> > core framework.
> > 
> > As to other drivers, I'll send them one by one later.
> > 
> > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> > 
> >  drivers/serial/Kconfig      |   35 +
> >  drivers/serial/Makefile     |    3
> >  drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/serial_core.h |    3
> >  4 files changed, 943 insertions(+), 1 deletion(-)
> > 
> > diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
> > linux-2.6.18.patch2/drivers/serial/Kconfig
> > --- linux-2.6.18.patch1/drivers/serial/Kconfig	2006-09-21
> > 09:14:42.000000000 +0800
> > +++ linux-2.6.18.patch2/drivers/serial/Kconfig	2006-09-21
> > 09:38:17.000000000 +0800
> > @@ -488,6 +488,41 @@
> >  	  your boot loader (lilo or loadlin) about how to pass options to the
> >  	  kernel at boot time.)
> > 
> > +config SERIAL_BFIN
> > +	bool "Blackfin serial port support (EXPERIMENTAL)"
> > +	depends on BFIN && EXPERIMENTAL
> > +	select SERIAL_CORE
> 
> Just curious:  why bool and not tristate?  (i.e., why is loadable
> module not allowed?)

Target is, after all, uCLinux embedded processor, where one should
be able to pre-determine what things go in as baseline kernel (what
hardware was used to build it) and what are possible options.

All Blackfins have internal UART (or two).
Some multiplex on same pins also CAN.

One of these weeks I should push onward my own BF537 project, I am
still just pre-collecting all tools to be able to debug it once
I commit boards to manufacturing...


  /Matti Aarnio
