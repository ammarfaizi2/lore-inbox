Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRAUFgx>; Sun, 21 Jan 2001 00:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRAUFgo>; Sun, 21 Jan 2001 00:36:44 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:23812
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130093AbRAUFgh>; Sun, 21 Jan 2001 00:36:37 -0500
Date: Sat, 20 Jan 2001 21:36:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <3A6A28B2.83807A1@transmeta.com>
Message-ID: <Pine.LNX.4.10.10101201651070.657-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, H. Peter Anvin wrote:

> Andre Hedrick wrote:
> > >
> > > No, I think I understood perfectly well.  I said that if it's going to be
> > > bound to each block device subsystem it would make more sense to
> > > establish that tie explicitly -- if that isn't possible I'm a bit
> > > confused.
> > 
> > Okay, I am definitely not clear because I am leading the wrong direction.
> > A single char-device would access all of ATA or all of SCSI.
> > 
> 
> That's fine.  ATA and SCSI are a bit special because they have multiple
> majors -- something that I hope we can get rid of with the dev_t
> expansion anyway, but I think the principle still holds.

Hi Peter,

Regardless if we rip out the entire rule of majors for dev_t, will there
be a service dummy driver to various block-devices?  There is a real need
for this if we are going to get full control of the hardware by indirect
access obtain the functionality that I see and need in the near future.

I want to use KMOD to an advantage.

Assume removable device bays such that you can swap in any and every kind
of ata-atapi device and/or all scsi-devices, one needs to have a way to
tell the driver to do things that are not native to its general mode of
operations as of today.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
