Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUBJTYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUBJTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:24:35 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:2189 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266036AbUBJTYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:24:30 -0500
Date: Tue, 10 Feb 2004 11:24:57 -0800
From: Mike Bell <kernel@mikebell.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210192456.GB4814@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40291A73.7050503@nortelnetworks.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 12:52:51PM -0500, Chris Friesen wrote:
> What names would you use for your device files?  This is the key 
> difference.  With udev it gets a notification that says "I have a new 
> block device", it then looks it up, applies the rules, and creates a new 
> entry.  The whole point is to move the naming scheme into userspace for 
> easier management.

Why does it make management easier to have no predictable name for a
device?

> You could have the kernel export a simple devfs with a hardcoded naming 
> scheme based on similar ideas as what is in sysfs (which would then make 
> sysfs and the daemon optional for tiny embedded setups), but the only 
> advantage over just exporting the information in sysfs is to save a few 
> bytes at the cost of yet another filesystem to maintain.

I think the space savings are a pretty good reason alone. Add to that
the fact I think devfs would be a good idea even if it cost MORE
memory... You can mount a devfs on your RO root instead of needing to
mount a tmpfs on /dev and then run udev on that. A devfs gives
consistant names for devices in addition to the user's preferred
user-space dictated naming scheme. A devfs means even with dynamic
majors/minors, even if you have new hardware in your system, your /dev
at least has the devices it needs.
