Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRALTa1>; Fri, 12 Jan 2001 14:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131645AbRALTaR>; Fri, 12 Jan 2001 14:30:17 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:42377 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S131152AbRALTaC>;
	Fri, 12 Jan 2001 14:30:02 -0500
Date: Fri, 12 Jan 2001 20:30:07 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Stephen Torri <s.torri@lancaster.ac.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux booting from HD on Promise Ultra ATA 100
In-Reply-To: <Pine.LNX.4.21.0101121555240.4828-100000@egb070000014.lancs.ac.uk>
Message-ID: <Pine.LNX.4.21.0101122027230.6699-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Stephen Torri wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 12 Jan 2001, Martin Josefsson wrote:
> 
> > My setup looks like this, I boot from hde
> > I configured my BIOS to boot from SCSI (I have no scsi-adapter but the
> > promise card reports itself as one at boottime)
> > 
> > boot = /dev/hde3
> > delay = 50
> > message = /boot/message
> > vga = extended
> > read-only
> > lba32
> > disk=/dev/hde
> >   bios=0x80
> 
> 
> The line "lba32" is for what? I have to ask this because I have never seen
> it in an example of a lilo.conf file before.

it is a BIOS extension that allows you to boot of a partition thats
located above cylinder 1024. I think it's called EDB or something like
that.

> Also you put "disk=/dev/hde and bios=0x80" to inform lilo that there was a
> disk there and its bios address is 0x80. Is this right?

yes.

> If I would follow your example then I would put:
> 
> lba32
> disk=/dev/hdf
>    bios=0x82

I think that would be correct yes, and install LILO on hde (I think the
promise-card only tries to boot from primary master when you have selected
SCSI in BIOS. But I'm not sure.

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
