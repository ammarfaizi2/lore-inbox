Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267984AbSIRQwa>; Wed, 18 Sep 2002 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267918AbSIRQvg>; Wed, 18 Sep 2002 12:51:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:29191 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267890AbSIRQu1>;
	Wed, 18 Sep 2002 12:50:27 -0400
Date: Wed, 18 Sep 2002 09:55:32 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Duncan Sands <duncan.sands@wanadoo.fr>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.26 hotplug failure
Message-ID: <20020918165532.GA9654@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <200209152353.41285.duncan.sands@wanadoo.fr> <20020918065225.GB6840@kroah.com> <200209181715.51314.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209181715.51314.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 05:15:50PM +1000, Brad Hards wrote:
> On Wed, 18 Sep 2002 16:52, Greg KH wrote:
> > On Sun, Sep 15, 2002 at 11:53:41PM +0200, Duncan Sands wrote:
> > > A simple fix is to change the test to [ $COUNT -lt 2 ];
> >
> > Good catch, yes the drivers file disappeared, and until now, almost no
> > one noticed it :)
> I assume that /proc/bus/usb/drivers went to driverfs. Everyone likes the new 
> guy:)

The functionality went there, not the actual file.  The file is obsolete
now :)

> I'd like the file back. We have a lot of debugging advice that asks people to 
> send that particular file to us, and it is very useful. Even if you update 
> the few places that you can find, then you will still have a lot of confusion 
> (well, if you have 2.4, then send this, and if you have 2.6, send this, and 
> if that doesn't exist, and you're on 2.4, mount this filesystem, else mount 
> this filesystem). Ugly, and increases the support workload.
> 
> A symlink will do, assuming both filesystems are mounted. If we only have 
> usbfs, I still want the data.

'ls <wherever_you_mounted_driverfs>/bus/usb/drivers' will now show you
all of the registered USB drivers.  As for what the minor numbers are
for the drivers that happened to use the USB major number, I'm working
on that.

> Please fix this before 2.6.

Sorry, but I'm not going to put the file back.  I understand your
concerns.  We should have some kind of program (lsdev like) that shows
the system information present at that moment in time.  It will be able
to provide what the /proc/bus/usb/drivers file showed in the past.

thanks,

greg k-h
