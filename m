Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289515AbSAOM1L>; Tue, 15 Jan 2002 07:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289516AbSAOM1C>; Tue, 15 Jan 2002 07:27:02 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:44834 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S289515AbSAOM0r>; Tue, 15 Jan 2002 07:26:47 -0500
Date: Sun, 13 Jan 2002 17:17:46 +0000
To: linux-lvm@sistina.com
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
Message-ID: <20020113171746.A10429@btconnect.com>
In-Reply-To: <Pine.GSO.4.21.0201141227260.224-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 14, 2002 at 10:01:25AM -0800
From: Joe Thornber <thornber@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:01:25AM -0800, Linus Torvalds wrote:
> Consider that done. ANYTHING that exports kdev_t to user space is
> incredibly broken, and will not work in a few months when the actual bit
> representation (and size) will change.

The kdev_t's in the driver interface are just one of the *minor*
problems with the LVM driver.

I came to the conclusion last summer that a rewrite was in order, of
both the kernel driver and the userland tools.  The new driver is
called 'device-mapper', and has been discussed briefly on this list.
It aims to support volume management in general, ie. not be LVM
specific.

The userland tools (known as LVM2), will go into beta this week.
Initially they will just replicate the functionality of LVM1, but we
do have a lot of extra features queued which will go in subsequent
releases.

Of course Sistina will continue to support the existing LVM1 driver
for the 2.4 series.

As far as the 2.5 series is concerned, I would much rather see people
embracing the new architecture (or telling me why it sucks).  Rather
than trying to hack the LVM1 driver so it works.  People have been
complaining for the last year about LVM, we weren't able to do much
about it since we were in a stable kernel and couldn't change any
interfaces.  Now that 2.5 is finally here it is time for people to
address the real problems - kdev_t's only scratch the surface.

- Joe



