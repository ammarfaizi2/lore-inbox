Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUCDBZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUCDBZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:25:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:11182 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261385AbUCDBZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:25:40 -0500
Date: Wed, 3 Mar 2004 17:25:31 -0800
From: Greg KH <greg@kroah.com>
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: Ed Tomlinson <edt@aei.ca>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304012531.GC2207@kroah.com>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com> <20040303225305.GB30608@weiser.dinsnail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303225305.GB30608@weiser.dinsnail.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:53:05PM +0100, Michael Weiser wrote:
> On Wed, Mar 03, 2004 at 07:14:33AM -0800, Greg KH wrote:
> > > > file creation. So my idea is to initialise /dev with some static files,
> > > > for hardware I know is there but hasn't had a driver loaded yet.  My
> > > > question is: Is there a nicer and more elegant way than just unpacking a
> > > > tarball into /dev before starting udevd? A tarball would also break a
> > > > (theoretical) use of dynamic major/minor numbers by the kernel.
> > > This item keeps coming up as the one feature that devfs has and udev
> > > does not.  It keeps getting dismissed.  Users seem to actually want it...
> > Users need to learn that the kernel is changing models from one which
> > automatically loaded modules when userspace tried to access the device,
> > to one where the proper modules are loaded when the hardware is found.
> Is this a general roadmap decision already made by all the developers or
> a proposal? If the latter I'd very much like to advocate for the old
> model.

Sorry, but you're a bit late.  We've been moving this way since before
2.4.0.

The fact that module unload even works today is a blessing due to all of
the well-documented issues involved.  I doubt any distro will enable
module unloading because of it.

> If udev support for yet undriven but present hardware is so hard to
> implement I can certainly live with a partly static /dev.

That's fine, and the proper response, as it's impossible to sove with
udev.

> > Note that this is a much more sane model due to removable devices, and
> > instances of multiple types of the same kind of devices in the same
> > system.
> I have to admit - I haven't become aware of the issue until recently
> when trying to switch from 2.4 to 2.6 and seeing that devfs is
> depreceated now. Where do the problems lie with the current model? (I
> don't mean devfs vs. udev now - I read the README.)

{sigh}  Please read the archives.  This comes up about every other week
these days it seems...

thanks,

greg k-h
