Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSJIJ0Y>; Wed, 9 Oct 2002 05:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSJIJ0Y>; Wed, 9 Oct 2002 05:26:24 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1028 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261322AbSJIJ0X>;
	Wed, 9 Oct 2002 05:26:23 -0400
Date: Tue, 8 Oct 2002 23:57:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE driver model update
Message-ID: <20021008215728.GA841@elf.ucw.cz>
References: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu> <200210081325.g98DP6MY000340@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210081325.g98DP6MY000340@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > _ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
> > > > own rules for lifetimes of their structures.  And that's not likely to
> > > > change - these objects belong to drivers and in some cases (IDE) are
> > > > not even allocated dynamically - they are reused if nothing is holding
> > > > them.
> > > 
> > > IDE objects can also outlast the hardware - consider an active mount on
> > > an ejected pcmcia card. Right now we don't do the right stuff to
> > > reconnect that on re-insert but one day we may need to. As it is we keep
> > > the instance around to avoid crashes
> > 
> > Ouch.  That (reconnects) may require interesting things from queue-related
> > code.  What behaviour do you want while card is disconnected?  All requests
> > getting errors / all requests getting blocked / reads failing, writes blocking?
> 
> This raises the interesting possibility of being able to refer to
> things like removable media directly, instead of the device the media
> is inserted in.
> 
> The Amiga was doing this years ago.  You could access floppy drives
> as, E.G. df0:, df1:, etc, but if you formatted a volume and called it
> foobar, you could access foobar: no matter which floppy drive you put
> it in to.
> 
> Also, Plan 9 does similar interesting things - you can do the equivilent of:
> 
> ls /internet/websites/kernel.org/
> 
> and treat the website as a filesystem.

uservfs.sf.net, and you can do similar stuff on linux.
									Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
