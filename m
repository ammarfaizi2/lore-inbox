Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVLTJh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVLTJh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 04:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVLTJh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 04:37:57 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:50055 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750868AbVLTJh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 04:37:56 -0500
Date: Tue, 20 Dec 2005 10:38:02 +0100
From: Sander <sander@humilis.net>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: sander@humilis.net, Willy Tarreau <willy@w.ods.org>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com, axboe@suse.de, vandrove@vc.cvut.cz, aia21@cam.ac.uk,
       akpm@osdl.org
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220093802.GA15866@favonius>
Reply-To: sander@humilis.net
References: <1135047119.8407.24.camel@leatherman> <20051220051821.GM15993@alpha.home.local> <2cd57c900512192206g7292cb1m@mail.gmail.com> <20051220085653.GA3137@favonius> <2cd57c900512200131l4ff29837o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900512200131l4ff29837o@mail.gmail.com>
X-Uptime: 10:33:31 up 32 days, 21:33, 26 users,  load average: 2.06, 1.36, 1.38
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote (ao):
> 2005/12/20, Sander <sander@humilis.net>:
> > Coywolf Qi Hunt wrote (ao):
> > > 2005/12/20, Willy Tarreau <willy@w.ods.org>:
> > > > On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
> > > > >       I'm getting a little tired of my roommates not knowing how to safely
> > > > > eject their usb-flash disks from my system and I'd personally like it if
> > > > > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > > > > suid the eject command, but that seems just as bad as changing the
> > > > > permissions in the kernel (eject wouldn't be able to check if the user
> > > > > has read/write permissions on the device, allowing them to eject
> > > > > anything).
> > > >
> > > > You may find my question stupid, but what is wrong with umount ? That's
> > > > how I proceed with usb-flash and I've never sent any eject command to
> > > > it (I even didn't know that the ioctl would be accepted by an sd device).
> > >
> > > IMHO, umount doesn't guarantee sync, isn't it?
> 
> Actually I was think umount(2), since this is the kernel list, but off
> topic here.
> 
> >
> > I'm pretty sure it does :-)
> 
> That is because: usually your removable media is not the file system
> root, hence umount(8) can return successfully only if no processes are
> busy working on it.
> 
> If you boot from or chroot/pivot into a removable media, and you
> remount it ro, and unplug it, then you may lose data.
 
eject wont help you here, right?

And the OP was talking about usb-flash sticks his roommates use and his
ipod. He doesn't need to eject those. umount will do.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
