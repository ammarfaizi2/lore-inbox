Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSGYVlJ>; Thu, 25 Jul 2002 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSGYVlJ>; Thu, 25 Jul 2002 17:41:09 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:37873 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316538AbSGYVlI>; Thu, 25 Jul 2002 17:41:08 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>, Sven.Riedel@tu-clausthal.de
Subject: Re: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Date: Fri, 26 Jul 2002 07:39:39 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020724140026.GE9765@moog.heim1.tu-clausthal.de> <20020725161221.GA10866@moog.heim1.tu-clausthal.de> <20020725181519.GC16518@kroah.com>
In-Reply-To: <20020725181519.GC16518@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207260739.39546.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 04:15, Greg KH wrote:
> On Thu, Jul 25, 2002 at 06:12:21PM +0200, Sven.Riedel@tu-clausthal.de wrote:
> > On Wed, Jul 24, 2002 at 10:35:05AM -0700, Greg KH wrote:
> > > Is CONFIG_USB_HIDINPUT selected in your .config?
> >
> > Now it is, and now it works. Thanks for the tip.
>
> Ah, and I didn't believe people when I said this wasn't going to be a
> problem...:
> 	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101761858728615&w=2
For your sins, I sentence you to two weeks of user support.

> > > You _did_ run 'make oldconfig' when upgrading kernel versions, right?
> >
> > Uhm, no. What does that do? Never heard of it before...
>
> EVERY TIME you move a different .config file from a different kernel
> version you HAVE to run 'make oldconfig' to fix up the differences.
> This means everytime you upgrade your kernel version, you have to do it
> before rebuilding the kernel.
This isn't strictly true. You could do any of the make config versions,
[make config, make menuconfig, make xconfig, make oldconfig]
but you have to look at every new option, and that is a bit error prone
(because you missed something subtle, or you were hasty, whatever).
make oldconfig helps you here, because it gives you only the new
options, which is probably what you want.

Some people always like to run make xconfig as well, because Rusty
says "it is the only one with a static parser" (or something like that).
If you do this, you don't need to change anything - just save the config
again.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
