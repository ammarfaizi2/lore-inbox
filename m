Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313078AbSC0TZC>; Wed, 27 Mar 2002 14:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313082AbSC0TYw>; Wed, 27 Mar 2002 14:24:52 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:47109 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313078AbSC0TYi>;
	Wed, 27 Mar 2002 14:24:38 -0500
Date: Wed, 27 Mar 2002 11:24:40 -0800
From: Greg KH <greg@kroah.com>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>,
        linux-kernel@vger.kernel.org
Subject: Re: USB Microsoft Natural KeyB not recogniced as a HID device
Message-ID: <20020327192439.GG3972@kroah.com>
In-Reply-To: <20020325183011.GA29011@kroah.com> <Pine.LNX.4.30.0203251957590.5375-200000@stud.fbi.fh-darmstadt.de> <20020325192216.GD29011@kroah.com> <3CA216C2.8CA0D6F5@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 27 Feb 2002 15:55:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 08:00:18PM +0100, Gunther Mayer wrote:
> 
> Greg, bad guessing. This is not the device's fault but the linux usb
> drivers are buggy.
> 
> The messages:
>         bInterfaceClass cannot get string descriptor 1, error = Broken pipe(32)
>         cannot get string descriptor 2, error = Broken pipe(32)
> 
> go away after "rmmod hid" (or whatever driver is using the device).
> 
> This is a long standing bug.

Bug in lsusb or in the kernel drivers?

Can you send what /proc/bus/usb/devices looks like with the device
plugged in, _and_ the driver bound to the device?  Doing that reads the
strings from the device, just like lsusb should be doing.  If that is
successful, I think the problem would be in lsusb.

thanks,

greg k-h
