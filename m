Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRARTUF>; Thu, 18 Jan 2001 14:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132265AbRARTTz>; Thu, 18 Jan 2001 14:19:55 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:30369 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130194AbRARTTn>; Thu, 18 Jan 2001 14:19:43 -0500
Date: Thu, 18 Jan 2001 19:58:11 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101180822020.18072-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101181938310.25170-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jan 2001, Linus Torvalds wrote:

> > Actually, this is a great example, because at one point I was working
> > on a device interface which would offload all of the disk-disk copying
> > overhead to the disks themselves, and not involve the CPU/RAM at all.
> 
> It's a horrible example.
> 
> device-to-device copies sound like the ultimate thing. 
> 
> They suck. They add a lot of complexity and do not work in general. And,
> if your "normal" usage pattern really is to just move the data without
> even looking at it, then you have to ask yourself whether you're doing
> something worthwhile in the first place.
> 
> Not going to happen.

device-to-device is not the same as disk-to-disk. A better example would
be a streaming file server. Slowly the pci bus becomes a bottleneck, why
would you want to move the data twice over the pci bus if once is enough
and the data very likely not needed afterwards? Sure you can use a more
expensive 64bit/60MHz bus, but why should you if the 32bit/30MHz bus is
theoretically fast enough for your application?
So I'm not advising it as "the ultimate thing", but I don't understand,
why it shouldn't happen.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
