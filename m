Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314060AbSDQExZ>; Wed, 17 Apr 2002 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSDQExY>; Wed, 17 Apr 2002 00:53:24 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2576 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314060AbSDQExY>;
	Wed, 17 Apr 2002 00:53:24 -0400
Date: Tue, 16 Apr 2002 20:52:36 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417035236.GC29897@kroah.com>
In-Reply-To: <20020417025104.GC29064@kroah.com> <Pine.LNX.4.33.0204162121060.13362-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 01:21:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:35:33PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Apr 2002, Greg KH wrote:
> >
> > Linus, here is an updated changeset series with the USB device support.
> 
> Since I haven't pulled any of the usb device updates yet, might I suggest:
> 
>  - redoing the BK archive completely without the broken series (ie an
>    actual "bk undo")

Well since you don't want to pull it, I can just trash this tree, it
only contains the Lineo code.

>  - explaining to me what a "usb device" is, that isn't a normal USB
>    device? Why is "usb/device/xxx" different from the existing USB device
>    drivers?

It's code to be a USB client device, not a USB host device, which is
what we currently have.  It is used in embedded devices that run Linux,
like the new Sharp device (can't remember the name right now...)

> In other words, please explain what the _point_ of this code is?
> Especially since the code is obvious crap, from the little I looked at it,
> and quite frankly my immediate reaction is that it shouldn't get even
> _close_ to the kernel before it has gone through some _major_ cleanup.
> 
> Let's face it, look at the absolute SHIT in usbd-debug.c, where somebody
> has re-created strcmp/strcpy/etc, except with stupid names, and bad
> implementation.
> 
> In short, I refuse to pull this crap. The people who wrote it were either
> on drugs, incompetent, or just plain crazy. "Just say no".

Sorry.  I spend most of my time on this code just cleaning the format
and removing build errors, instead of looking at the content :(

I'll work on fixing all of the crap before submitting it again.

thanks,

greg k-h
