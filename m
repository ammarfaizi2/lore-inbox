Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUBJRuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUBJR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:26:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:36584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265992AbUBJRZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:25:53 -0500
Date: Tue, 10 Feb 2004 09:25:52 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210172552.GB27779@kroah.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210171337.GK4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:13:39AM -0800, Mike Bell wrote:
> On Tue, Feb 10, 2004 at 09:01:57AM -0800, Greg KH wrote:
> > Did you read:
> > 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs
> 
> Yes, I've read everything since the original OLS one, and liked udev
> less and less with each one.

Fine, that's your option.  I'm not forcing you to use udev, yet :)

> > But that is not what sysfs does.  And sysfs will not do this.  So this
> > point is moot.
> 
> No, you misunderstand. I'm not suggesting that sysfs /should/ export
> device files. I'm saying that sysfs exporting type/major/minor as files
> is not really that different from exporting full-fledged device files.
> Making udev a sort of ugly-hack devfsd.

No that is not what sysfs is about at all.  sysfs exports the internal
device tree that the kernel knows so that userspace can use this
information for all sorts of different things (proper power management,
etc.)  Please go read all of the sysfs and driver model documentation
(and OLS and linux.conf.au papers) for more details about what sysfs and
the driver core is all about.

And claiming udev as "a sort of ugly-hack devfsd" is pretty harsh.
Given that udev uses a documented, open interface, and easily allows
_any_ program to run from it, no matter what the language.  Try reading
the devfsd code some time, or getting it to run your perl script to name
a single type of device :)

Anyway, I'm done with this devfs vs. udev arguments that in the end go
nowhere.  See that document for my position.

If you like devfs, fine, use it.  If you don't, take a look at udev.
And if you like neither, then either create your own solution, or don't
use either.

thanks,

greg k-h
