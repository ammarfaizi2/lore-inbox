Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTJDVkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJDVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 17:40:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:4557 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262774AbTJDVkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 17:40:11 -0400
Date: Sat, 4 Oct 2003 14:39:09 -0700
From: Greg KH <greg@kroah.com>
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: trying to get udev running with 2.6.0-test6
Message-ID: <20031004213909.GA8566@kroah.com>
References: <200310040220.h942KVT9004376@orion.dwf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310040220.h942KVT9004376@orion.dwf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 08:20:31PM -0600, reg@dwf.com wrote:
> Im trying to get udev working with 2.6.0 (as a replacement for devfs).

First off, linux-kernel is probably not the place to be asking this.
You should try this on the linux-hotplug-devel list and at least cc: the
author of udev.  Anyway...

> Im following the instructions as I read them, but *nada*.

What instructions?  :)

> So, I must be mis-interpreting something...
> 
> OK, I made sysfs, actually I added the line
> 
>     none       /sysfs      sysfs   defaults        0 0
> 
> to /etc/fstab, and did a 'mount -a'.
> There is 'stuff' below this node.

Try mounting it at /sys instead, that's the "recommended" place for it,
but udev should still be able to figure out where it is.

> I built udev-0.2, and put udev in /sbin/udev
> 
> I put /sbin/udev into /proc/sys/kernel/hotplug (replacing /bin/true) with
> 
>     echo /sbin/udev > /proc/sys/kernel/hotplug
> 
> doing a cat /proc/sys/kernel/hotplug shows that it is there.
> 
> I have then plugged and unplugged a USB device and /udev does not appear.
> So I did a 'mkdir /udev'.
> Plug and unplug again.
> 
> Still nothing.
> 
> So, what am I missing???

The fact that the config files are hardcoded to be looked for at
/home/greg/src/udev/ and you probably do not have that path on your
system?  :)

> [[ there are numerous messages in the /var/log/messages for each plug/unplug
> of the USB device ]]

Are they from udev?  What do they say?  Any errors?

Yes, I need to write a better install script and instructions, sorry.
It's on my list of things to do...

thanks,

greg k-h
