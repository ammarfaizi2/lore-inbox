Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUK2TfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUK2TfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUK2TeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:34:03 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15319 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261615AbUK2TKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:10:41 -0500
Date: Mon, 29 Nov 2004 11:07:39 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] touchkitusb: module_param to swap axes
Message-ID: <20041129190739.GD15452@kroah.com>
References: <200411242228.53446.daniel.ritz@gmx.ch> <200411250010.09049.dtor_core@ameritech.net> <200411252118.17690.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411252118.17690.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 09:18:17PM +0100, Daniel Ritz wrote:
> On Thursday 25 November 2004 06:10, Dmitry Torokhov wrote:
> > On Wednesday 24 November 2004 04:28 pm, Daniel Ritz wrote:
> > > add a module parameter to swap the axes. many displays need this...
> > > 
> > > --- 1.2/drivers/usb/input/touchkitusb.c	2004-09-18 10:07:25 +02:00
> > > +++ edited/drivers/usb/input/touchkitusb.c	2004-11-24 18:57:59 +01:00
> > > @@ -59,6 +59,10 @@
> > >  #define DRIVER_AUTHOR			"Daniel Ritz <daniel.ritz@gmx.ch>"
> > >  #define DRIVER_DESC			"eGalax TouchKit USB HID Touchscreen Driver"
> > >  
> > > +static int swap_xy;
> > > +module_param(swap_xy, bool, 0);
> > 
> > It looks it can easily be exported to userspace to allow switching "on-fly"
> > since it is checked for every packet. I think 0600 will do.
> >  
> 
> agreed. and when 0600 is ok, i guess 0644 is ok too.

Applied, thanks.

greg k-h

