Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTJUAxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTJUAxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:53:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:42717 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263135AbTJUAxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:53:22 -0400
Date: Mon, 20 Oct 2003 17:50:26 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031021005025.GA28269@kroah.com>
References: <20031017055652.GA7712@kroah.com> <200310171757.h9HHvGiY006997@orion.dwf.com> <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com> <1066696767.10221.164.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066696767.10221.164.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 02:39:27AM +0200, Martin Schlemmer wrote:
> On Mon, 2003-10-20 at 12:07, Greg KH wrote:
> > On Fri, Oct 17, 2003 at 11:19:23AM -0700, Greg KH wrote:
> > > 
> > > Ah, yeah, udev seg faults right now for partitions.  Let me try to track
> > > down the bug, give me a bit of time...
> > 
> > Here's a patch that fixes the partition logic for me.  Sorry about this, I
> > need to make sure to test partitions more next time.
> > 
> 
> This works fine for me, thanks.

Great!

> Three questions if you do not mind:
> 
> 1)  Is it possible to maintain naming of tarball/version ?  Meaning,
>     say we forget about the 003 version, could the next be 0.4, or even
>     0.3.1 or whatever ?  Just changing makes trying to keep packages
>     sane a hassle.  Thanks :)

The naming will be consistant from now on.  Next release will be 004,
followed by 005, and so on.  Remember, version numbers mean nothing :)

As there is no installed base before 003, I don't think this will really
be a problem, do you?

> 2)  Is the libsysfs included later than that in sysfsutils-0_2_0.tar.gz?

It's older, I think.

>     If not, any idea if/when udev will start following official
>     libsysfs?  Yes, not a biggie, but it would be nice to have
>     sysfsutils its own package :)

I just got a patch today from Dan that merged the latest version of
libsysfs into udev.  It's in the udev bk tree already.  libsysfs will
always be a copy in the udev tree, as udev links statically, and it
keeps the build process and debug process much easier.

sysfsutils can still be its own package, other programs are starting to
use libsysfs already.

> 3)  Any plans to have namedev support wildcarts ?  Like:
> 
>   dsp*:root:audio:0660
>   audio*:root:audio:0660
>   midi*:root:audio:0660
>   mixer*:root:audio:0660

Yes, I would love to support that.  Care to send a patch?  :)

Of course you need a kernel patch for the sound class that is only
available in my kernel tree right now for sound devices to work with
udev...

thanks,

greg k-h
