Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272552AbRH3XUO>; Thu, 30 Aug 2001 19:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272553AbRH3XUE>; Thu, 30 Aug 2001 19:20:04 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:46602 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272552AbRH3XTz>;
	Thu, 30 Aug 2001 19:19:55 -0400
Date: Thu, 30 Aug 2001 16:18:09 -0700
From: Greg KH <greg@kroah.com>
To: Carlos E Gorges <carlos@techlinux.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Message-ID: <20010830161809.A19258@kroah.com>
In-Reply-To: <01083019402502.01265@skydive.techlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01083019402502.01265@skydive.techlinux>; from carlos@techlinux.com.br on Thu, Aug 30, 2001 at 07:40:25PM -0300
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 07:40:25PM -0300, Carlos E Gorges wrote:
> Hardware detection tool 0.2
> 
> The main idea is keep a unified database of modules and 
> create a good tool for hardware configurators.

Why don't you just pull the PCI and USB module information out of the
drivers themselves?  All the information you need it in the
MODULE_DEVICE_TABLE() macro.  You don't get a pretty vendor string for
most all of the USB devices that use a USB class spec, but that isn't
necessary.

All you are caring about is what device is supported by what module,
right?  That can be easily determined by the info in the modules.usbmap
and modules.pcimap files in the /lib/modules/<kernel_version>/
directory.

Keeping tables like these will be a tough thing to do, that's why the
linux-hotplug project relies on the drivers themselves to do the work.

thanks,

greg k-h
