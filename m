Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317632AbSFLFm6>; Wed, 12 Jun 2002 01:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSFLFm5>; Wed, 12 Jun 2002 01:42:57 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:41955 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317632AbSFLFm4>; Wed, 12 Jun 2002 01:42:56 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: adam@luchjenbroers.com, linux-kernel@vger.kernel.org
Subject: Re: Parallel Port and USB Device Drivers
Date: Wed, 12 Jun 2002 15:39:57 +1000
User-Agent: KMail/1.4.5
In-Reply-To: <20020612052609Z317582-22020+2716@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206121539.57589.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002 15:28, Adam Luchjenbroers wrote:
> Could someone tell me where I can find some documentation regarding
> implementing LPT and USB device drivers.
USB Printer Class spec + USS720 data sheet + a quick search of drivers/usb for 
files called printer.c and uss720.c might help.

> Also, is it possible to have a function called timed to the LPT output
> (since LPT data rates are very slow it would be more efficient for the
> driver to be called when the port is ready to output the next byte instead
> of having it perform a few delay loops).
You normally get buffering with the device.

> Any information regarding how I'd go about building these drivers as kernel
> modules would be nice.
CONFIG_USB_PRINTER=m
CONFIG_USB_USS720=m
is probably enough :)

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
