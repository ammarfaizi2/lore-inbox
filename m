Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSHDTU7>; Sun, 4 Aug 2002 15:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHDTU7>; Sun, 4 Aug 2002 15:20:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:60684 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318257AbSHDTU6>;
	Sun, 4 Aug 2002 15:20:58 -0400
Date: Sun, 4 Aug 2002 12:22:15 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb devicefs flaw
Message-ID: <20020804192215.GA23659@kroah.com>
References: <UTC200208041858.g74IwNr05640.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200208041858.g74IwNr05640.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 07 Jul 2002 18:17:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 08:58:23PM +0200, Andries.Brouwer@cwi.nl wrote:
> In drivers/usb/core/usb.c the routine usb_alloc_dev() will
> set the devpath for the root hub to "/".
> Then usb_find_drivers() constructs a filename used by driverfs
> using
> 
>                 sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
>                          dev->bus->bus_name, dev->devpath,
>                          interface->altsetting->bInterfaceNumber);
> 
> This leads to filenames like "00:07.2-/:0" with embedded '/'.

Fix is already in Linus's tree, thanks to David Brownell:
	http://linus.bkbits.net:8080/linux-2.5/cset@1.437.41.12

Original patch sent to linux-usb-devel for this is at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=102831350007377&w=2
	
thanks,

greg k-h
