Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268475AbTANBPd>; Mon, 13 Jan 2003 20:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTANBPd>; Mon, 13 Jan 2003 20:15:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12551 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268475AbTANBOc>;
	Mon, 13 Jan 2003 20:14:32 -0500
Date: Mon, 13 Jan 2003 17:23:20 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb mouse and 2.5.56bk
Message-ID: <20030114012319.GD10764@kroah.com>
References: <200212141215.49449.tomlins@cam.org> <200212172243.52786.tomlins@cam.org> <20021218054802.GF28629@kroah.com> <200301122242.01033.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301122242.01033.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 10:42:01PM -0500, Ed Tomlinson wrote:
> Greg,
> 
> Something strange with 2.5.56.  My usb mouse is no longer working
> after boot.  I can get it to work by repluging it.  Here is my
> dmesg ang the init.d/local that should make sure the modules needed 
> are loaded.  Before tring to replug I unloaded and reloaded hid and
> psmouse to see if this would fix things (it did not).
> 
> I suspect the changeset below:
> 
> ChangeSet@1.889.19.1, 2003-01-09 10:29:40-08:00, greg@kroah.com
> 
> which got added just before .56 - I have been tracking bk fairly
> closely and all was working up to the version of 55bk built at 8am
> on the 9th.

Hm, that single changeset only modified the ehci driver, which should
not bother your USB mouse at all, unless it's a USB 2.0 mouse :)

It looks like from your logs that the usb core saw a bunch of devices.
What does /proc/bus/usb/devices look like after booting, when your mouse
is not working?  The log also shows that a usb mouse was found by the
hid driver and bound to it, so I don't know why it wouldn't be working.

thanks,

greg k-h
