Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261243AbRELNk2>; Sat, 12 May 2001 09:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261245AbRELNkT>; Sat, 12 May 2001 09:40:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261243AbRELNkG>; Sat, 12 May 2001 09:40:06 -0400
Date: Sat, 12 May 2001 15:39:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
Message-ID: <20010512153951.H8259@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu> <20010511171124.M30355@athlon.random> <15100.18375.367656.3591@pizda.ninka.net> <20010512032453.A8259@athlon.random> <15100.37367.477922.66043@pizda.ninka.net> <20010512045456.E8259@athlon.random> <15100.51153.711892.548545@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15100.51153.711892.548545@pizda.ninka.net>; from davem@redhat.com on Fri, May 11, 2001 at 10:19:13PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 10:19:13PM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > you _must_ know very well what the mainteinance of that code means ;).
> 
> Which is why I added the facility by which such ioctl conversions can
> be registered at runtime by the subsystem/driver itself.

Which no one single piece of common code is using yet in 2.4.5pre1 so
right now (2.4.5pre1) you must be doing the mainteinance yourself the
old way.

But I certainly agree that it is promising and that in the future
de-localizing the 32bit wrappers is a good thing so at least people will
see this code when they break it while changing the common code ;).

> I'm already planning on doing this, but it is a 2.5.x project.
> Dave Mosberger agrees with this as has anyone else I've mentioned
> the idea to, so consider it basically done in 2.5.x sometime.

Nice to hear that, when you do that please keep patches@x86-64.org in
CC so we follow it.

After we change the wrapper mechanism by avoiding the mainteinance work by
de-localizing the wrappers and after we share the wrapper logic as well, it
will be a _real_ pleasure to support the lvm ioctl from 32bit userland on
x86-64 too indeed and then it will be a worthwhile effort to support
those ioctl.

Thanks,
Andrea
