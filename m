Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSBCGXg>; Sun, 3 Feb 2002 01:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBCGX1>; Sun, 3 Feb 2002 01:23:27 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:52750 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285850AbSBCGXV>;
	Sun, 3 Feb 2002 01:23:21 -0500
Date: Sat, 2 Feb 2002 22:21:24 -0800
From: Greg KH <greg@kroah.com>
To: Nathan <wfilardo@fuse.net>
Cc: Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
Message-ID: <20020203062124.GA15134@kroah.com>
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com> <3C5B8C0D.8090009@fuse.net> <20020202133358.A5738@suse.de> <3C5C8CA2.9000103@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5C8CA2.9000103@fuse.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 06 Jan 2002 04:04:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 08:04:34PM -0500, Nathan wrote:
> Dave Jones wrote:
> 
> >On Sat, Feb 02, 2002 at 01:49:49AM -0500, Nathan wrote:
> >
> >> Alright... a 2.5.3 with no extras boots fine (with init=/bin/bash) and 
> >> can load and unload hotplug several times without OOPSing.  So it 
> >> appears to be something else.  Hope that helps.
> >
> >Do you have driverfs mounted ? Can you try 2.5.3 + greg's
> >USB driverfs patch ?
> >
> Unless driverfs is mounted by default or by something other than 
> /etc/fstab, no I don't have it on.

It's internally mounted even if you don't physically mount the fs.

> w/ Greg's USB driverfs patch : system proves to be stable.
>    (though 2.5.3 sometimes looses my keyboard after a time?)

Is this a USB keyboard?  Are there any kernel log messages?

> Raw -dj1:  explosion as above. [no ACPI (doesn't compile anyway), no 
> preempt this time around, either.]
>    (also lost my keyboard.  Odd.  Seems to be about 50% of the time 
> with 2.5.3 + anything.)

Hm, input layer changes?

Glad 2.5.3 is working for you :)

Thanks for testing it with my driverfs patch.

greg k-h
