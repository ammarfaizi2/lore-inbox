Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286866AbSABJb6>; Wed, 2 Jan 2002 04:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSABJbs>; Wed, 2 Jan 2002 04:31:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30735 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286866AbSABJb3>;
	Wed, 2 Jan 2002 04:31:29 -0500
Date: Wed, 2 Jan 2002 10:31:14 +0100
From: Jens Axboe <axboe@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was: "sr: unaligned transfer" in 2.5.2-pre1]
Message-ID: <20020102103114.A28530@suse.de>
In-Reply-To: <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de> <20020101152859.D14915@one-eyed-alien.net> <06df01c1934f$ee4e68a0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06df01c1934f$ee4e68a0$6800000a@brownell.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01 2002, David Brownell wrote:
> > > No, you can always ask to get pages low mem bounced. Highmem is no
> > > requirement, and if your device really can't support it there's no point
> > > in attempting to support it.
> >
> > I presume there is some overhead in bouncing to lowmem?  I imagine that
> > highmem support for the HCDs wouldn't be that difficult -- they are just
> > PCI devices, after all.
> 
> I'm unclear on what "bouncing to lowmem" involves, but I'd rather avoid
> teaching all three HCDs a second model for addressing transfer buffers.
> 
> At least until later in the 2.5 series, when we believe they'll share a lot
> more common code and so that new model can be taught to just ONE
> piece of code.  Fixing bugs in one place easier than in three!

Ehm I was discussing 2.5, 2.4 will always bounce the high mem pages for
you so it's moot there.

-- 
Jens Axboe

