Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbREPH1x>; Wed, 16 May 2001 03:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbREPH1e>; Wed, 16 May 2001 03:27:34 -0400
Received: from aeon.tvd.be ([195.162.196.20]:55401 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S261808AbREPH10>;
	Wed, 16 May 2001 03:27:26 -0400
Date: Wed, 16 May 2001 09:25:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B016F9A.360A0CFD@mandrakesoft.com>
Message-ID: <Pine.LNX.4.05.10105160924430.23225-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > Now, if we just fundamentally try to think about any device as being
> > hot-pluggable, you realize that things like "which PCI slot is this device
> > in" are completely _worthless_ as device identification, because they
> > fundamentally take the wrong approach, and they don't fit the generic
> > approach at all.
> 
> Should I interpret this as you disagreeing with
> exporting-bus-info-to-userspace type additions?  ie. some random
> get-info ioctl spits out pci_dev->slot_name to userspace.
> 
> I believe there are rare cases where this is useful.  When one already
> has the /dev node (via an open fd used for ioctl, usually), additionally
> you need the bus info to make an association between an active device on
> the hardware bus, and an active driver in the kernel.  X could use this
> info to figure out which fbdev devices to avoid.  SCSI is already using
> similar info, as of 2.4.4, as are net devs.  Userspace apps that diddle
> hardware are a definite minority case, but for that case the PCI slot
> info is useful.

X can already look at the fb_fix_screeninfo.{smem,mmio}_start fields and match
that with pci_dev.resource[*].

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

