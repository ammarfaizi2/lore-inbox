Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289093AbSAGCxQ>; Sun, 6 Jan 2002 21:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSAGCxG>; Sun, 6 Jan 2002 21:53:06 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:28425 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289093AbSAGCwq>;
	Sun, 6 Jan 2002 21:52:46 -0500
Date: Sun, 6 Jan 2002 18:50:57 -0800
From: Greg KH <greg@kroah.com>
To: Dylan Egan <crack_me@bigpond.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 - hanging due to usb
Message-ID: <20020107025057.GA4110@kroah.com>
In-Reply-To: <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com> <5.1.0.14.0.20020107121314.00ba4258@mail.bigpond.com> <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20020107132332.00b564a8@mail.bigpond.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 09 Dec 2001 23:34:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 01:25:39PM +1100, Dylan Egan wrote:
> 
> >Which kind of usb-storage device?
> 
> ScanLogic USBIDE.... it works in windows :(

Doesn't mean too much :)

> >There is no oops message?
> 
> Nope
> 
> >Has this usb-storage device ever worked on any previous kernel version?
> 
> Wouldnt know just got it

Can you not load the usb-storage driver, load the usbcore module, and
the USB host driver that you are using, and point hotplug to somewhere
else:
	echo /bin/true > /proc/sys/kernel/hotplug

Then plug in your device, and send the output of /proc/bus/usb/devices
to the list (and the linux-usb-devel list, which is a better place for
this :)

> >Do any other types of USB devices work with Linux on this machine?
> 
> Tried a mouse........ the cursor came up but it wouldnt move around

Did you set it up properly?  See the Linux USB Guide at
http://www.linux-usb.org/ for info on how to do it.

thanks,

greg k-h
