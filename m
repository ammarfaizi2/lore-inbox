Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUBMWSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUBMWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:18:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:49870 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267249AbUBMWSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:18:50 -0500
Date: Fri, 13 Feb 2004 14:18:50 -0800
From: Greg KH <greg@kroah.com>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040213221850.GB15998@kroah.com>
References: <fa.i9mtr77.1pja9qf@ifi.uio.no> <fa.de6p9mb.1ikipbl@ifi.uio.no> <402D4AE4.5020700@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D4AE4.5020700@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 02:08:36PM -0800, walt wrote:
> Greg KH wrote:
> 
> > ...sysfs exports loads of info about every device in your system, not
> >   only the major:minor info.  It exports what device this major:minor
> >   is assigned to, the topology of the device...
> 
> For the benefit of us schlubs looking in from the outside, could you tell
> us what you mean by 'topology' ?

Run 'tree' from /sys/devices/ to see the topology of how all of the
different devices in your system are hooked together.  Notice how the
usb mouse is connected to a usb controller which is connected to a pci
device, and so on.

udev can use that "chain" of devices to determine how to name your
device.

thanks,

greg k-h
