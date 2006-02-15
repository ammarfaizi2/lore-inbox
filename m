Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWBOCHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBOCHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBOCHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:07:23 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:61322
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932072AbWBOCHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:07:23 -0500
From: Rob Landley <rob@landley.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 21:07:16 -0500
User-Agent: KMail/1.8.3
Cc: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141732.22712.rob@landley.net> <20060214234736.GB10590@kroah.com>
In-Reply-To: <20060214234736.GB10590@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602142107.16709.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 6:47 pm, Greg KH wrote:
> On Tue, Feb 14, 2006 at 05:32:22PM -0500, Rob Landley wrote:
> > Changes to the kernel have already managed to break us twice
> > (switching /sys/class from real subdirectories to symlinks means we can't
> > just ignore symlinks when recursing down through directories anymore,
> > which is a problem because the existing symlinks form loops.
>
> I've shown a simple way to handle this, so this should not be a problem
> anymore.

Yup.  We're ok with the current stuff, thanks.

(I haven't updated the mdev code yet because I need to build a 2.6.16-pre 
kernel with the new layout to test against, but I've got a couple options 
worked out.)

> > And deprecating /sbin/hotplug means we've got to bloat the code with
> > netlink stuff.)  But we'll cope, and the user interface isn't
> > changing.
>
> Since when is /sbin/hotplug "depreciated"?

http://lwn.net/Articles/166377/

  The hotplug helper /sbin/hotplug is now officially deprecated. The control
  file /proc/sys/kernel/hotplug has moved to /sys/kernel/uevent_helper, but it
  is expected to be disabled on most systems in favor of udev and the netlink
  interface.   

> It still works just fine, and isn't going anywhere anytime soon.

Good news for fans of small and simple, then. :)

> Turns out that some distros just don't want to use it, and use netlink
> instead.  That should not stop you from using it if you wish, as the
> kernel sure doesn't care one way or the other.

Cool.  For busybox, /sbin/hotplug is "the easy way".

> thanks,
>
> greg k-h

Rob
-- 
Never bet against the cheap plastic solution.
