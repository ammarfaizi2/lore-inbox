Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287112AbSABWfG>; Wed, 2 Jan 2002 17:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287150AbSABWeA>; Wed, 2 Jan 2002 17:34:00 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:33520 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S287116AbSABWcv>; Wed, 2 Jan 2002 17:32:51 -0500
Date: Wed, 2 Jan 2002 23:32:45 +0100 (MET)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun2.lrz-muenchen.de>
To: Jens Axboe <axboe@suse.de>
cc: David Brownell <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>,
        Matthew Dharm <mdharm@one-eyed-alien.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was "sr: unalignedtransfer" in 2.5.2-pre1]
In-Reply-To: <20020102194404.A482@suse.de>
Message-Id: <Pine.SOL.4.33.0201022330170.5969-100000@sun2.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Jens Axboe wrote:

> On Wed, Jan 02 2002, David Brownell wrote:
> > > > requirement for drivers is that the transfer buffers can be passed to
> > > > pci_map_single() calls by the Host Controller Drivers (HCDs).  The
> > > > device drivers, and URBs, don't expose such mappings, they only
> > > > require that they can be created/destroyed.
> > >
> > > .. which is the requirement that you want to change to use pci_map_page
> > > or pci_map_sg
> >
> > OK, I think I'm clear on this much then:  in 2.5, to support block drivers
> > over USB (usb-storage only, for now) there needs to be an addition to
> > the buffer addressing model in usbcore, as exposed by URBs.
> >
> >   - Current "transfer_buffer" + "transfer_buffer_length" mode needs to
> >     stay, since most drivers aren't block drivers.
>
> Why? Surely USB block drivers are not the only ones that want to support
> highmem.

Probably for a long time they'll be the only ones.
All the char drivers will mainly do a copy_to/from_user
or want memory they can manipulate directly.

	Regards
		Oliver


