Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWDVSfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWDVSfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDVSfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:35:30 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:2988 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750888AbWDVSf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:35:29 -0400
Date: Fri, 21 Apr 2006 23:43:29 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: harald.dunkel@t-online.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.16.9, amd64, usbcore: NULL pointer dereference
Message-ID: <20060422064329.GA18974@kroah.com>
References: <4448FCC7.6070309@t-online.de> <20060421160916.37b9c771.akpm@osdl.org> <20060421231904.5751e70b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421231904.5751e70b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 11:19:04PM -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > 
> > (Added linux-usb-devel)
> > 
> > Harald Dunkel <harald.dunkel@t-online.de> wrote:
> > >
> > > Hi folks,
> > > 
> > > Sometimes my PC dies at boot time:
> > > 
> > > :
> > > usb 3-3: config 1 has 0 interfaces, different from the descriptor's value: 1
> > > Unable to handle kernel NULL pointer dereference at 000000000000000d RIP:
> > > <ffffffff8809493e>(:usbcore:usb_new_device+350)
> > > :
> > > :
> > > 
> > > Unfortunately it is not visible in any log file, so I took
> > > a snapshot of the screen.
> > > 
> > > Surely it would be unacceptable to send huge attachments
> > > to everybody on this list. Is somebody interested? Or is
> > > there some upload area available, that I could use?
> > 
> > Please email the image to myself and I'll upload it.
> > 
> > > # lsusb
> > > Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 Card Reader
> > > Bus 003 Device 002: ID 0ace:1211 ZyDAS 802.11b/g USB2 WiFi
> > > Bus 003 Device 004: ID 124a:4023 AirVast
> > > Bus 003 Device 001: ID 0000:0000
> > > Bus 002 Device 001: ID 0000:0000
> > > Bus 001 Device 001: ID 0000:0000
> > > 
> > 
> 
> It's at http://www.zip.com.au/~akpm/linux/patches/stuff/oops.jpg
> 
> Harald, if nothing happens on this bug (and it may well not :() could
> you please remember to create a report against USB at bugzilla.kernel.org?

I think that we have a patch in 2.6.17-rc2 that should let devices like
this work without crashing the kernel (note that your device is lying
about what it says it has.)

What kind of device is this?  Is it shipping so that people can buy it?

thanks,

greg k-h
