Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273922AbRIXOlH>; Mon, 24 Sep 2001 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273925AbRIXOk5>; Mon, 24 Sep 2001 10:40:57 -0400
Received: from waste.org ([209.173.204.2]:24609 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S273922AbRIXOkt>;
	Mon, 24 Sep 2001 10:40:49 -0400
Date: Mon, 24 Sep 2001 09:42:34 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 - necessary patches
In-Reply-To: <E15lJF4-0000rL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0109240936140.11663-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Alan Cox wrote:

> > --- linux-2.4.10-pre7/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
> > +++ linux/include/scsi/scsi.h	Mon Sep 10 03:53:58 2001
> > @@ -214,6 +214,12 @@
> >  /* Used to get the PCI location of a device */
> >  #define SCSI_IOCTL_GET_PCI 0x5387
> >
> > +/* Used to invoke Target Defice Reset for Fibre Channel */
> > +#define SCSI_IOCTL_FC_TDR 0x5388
> > +
> > +/* Used to get Fibre Channel WWN and port_id from device */
> > +#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
> > +
>
> These are compaq made up ioctls. They shouldnt be merged like that. Instead
> there needs to be proper discussion about what is actualyl needed

And please, not ioctl(). iSCSI (SCSI-over-IP) is going to require similar
per-device information (this info isn't FC-specific), but probably a lot
more. Adding a dozen ioctls is bad. At least one of the current iSCSI
drivers puts this info in /proc/scsi/iscsi.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

