Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSGYSM3>; Thu, 25 Jul 2002 14:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGYSM3>; Thu, 25 Jul 2002 14:12:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51465 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315928AbSGYSM2>;
	Thu, 25 Jul 2002 14:12:28 -0400
Date: Thu, 25 Jul 2002 11:15:19 -0700
From: Greg KH <greg@kroah.com>
To: Sven.Riedel@tu-clausthal.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Message-ID: <20020725181519.GC16518@kroah.com>
References: <20020724140026.GE9765@moog.heim1.tu-clausthal.de> <20020724173505.GE10124@kroah.com> <20020725161221.GA10866@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725161221.GA10866@moog.heim1.tu-clausthal.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 27 Jun 2002 14:33:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 06:12:21PM +0200, Sven.Riedel@tu-clausthal.de wrote:
> On Wed, Jul 24, 2002 at 10:35:05AM -0700, Greg KH wrote:
> > Is CONFIG_USB_HIDINPUT selected in your .config? 
> Now it is, and now it works. Thanks for the tip.

Ah, and I didn't believe people when I said this wasn't going to be a
problem...:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101761858728615&w=2

> > You _did_ run 'make oldconfig' when upgrading kernel versions, right?
> Uhm, no. What does that do? Never heard of it before...

EVERY TIME you move a different .config file from a different kernel
version you HAVE to run 'make oldconfig' to fix up the differences.
This means everytime you upgrade your kernel version, you have to do it
before rebuilding the kernel.

I think the 2.5 Makefile now detects this condition and will tell you to
run it.

thanks,

greg k-h
