Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRH3Uxp>; Thu, 30 Aug 2001 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272450AbRH3Uxf>; Thu, 30 Aug 2001 16:53:35 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:26890 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272449AbRH3Ux2>;
	Thu, 30 Aug 2001 16:53:28 -0400
Date: Thu, 30 Aug 2001 13:51:43 -0700
From: Greg KH <greg@kroah.com>
To: Stefan Fleiter <stefan.fleiter@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010830135143.B18294@kroah.com>
In-Reply-To: <20010830124700.A3694@shuttle.mothership.home.dhs.org> <3117682009.999188508@[10.132.112.53]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3117682009.999188508@[10.132.112.53]>; from linux-kernel@alex.org.uk on Thu, Aug 30, 2001 at 04:21:48PM +0100
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 04:21:48PM +0100, Alex Bligh - linux-kernel wrote:
> 
> 
> --On Thursday, August 30, 2001 12:47 PM +0200 Stefan Fleiter 
> <stefan.fleiter@gmx.de> wrote:
> 
> > Does it really make any sense to optimize for size and at the same time
> > force the user to install a bash compatible shell?
> 
> No, that's why diet /sbin/hotplug didn't require any shell (as I understood
> it), whereas the normal hotplug suite does.

Exactly.  diethotplug does not require any shell or awk to be present to
work.  It compiles to a binary which is smaller than the existing
modules.usbmap file is (and can get smaller, I haven't started to
optimize for space yet.)

To help clear up a few questions I've been getting, diethotplug is for
systems that care about space, like embedded or boot rescue discs.  It
will also be handy for loading PCI and USB kernel modules at boot time
based on what devices are present in the system, with the upcoming 2.5
initrd method.

It is not a replacement for the current linux-hotplug scrips, but
another alternative for situations that they didn't make sense.

thanks,

greg k-h
