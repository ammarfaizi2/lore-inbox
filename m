Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUL2TPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUL2TPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUL2TPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:15:53 -0500
Received: from dialin-166-233.tor.primus.ca ([216.254.166.233]:10112 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261396AbUL2TPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:15:41 -0500
Date: Wed, 29 Dec 2004 14:15:25 -0500
From: William Park <opengeometry@yahoo.ca>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041229191525.GA2597@node1.opengeometry.net>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	Andreas Unterkircher <unki@netshadow.at>
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2A7BE.2030806@grupopie.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 12:49:02PM +0000, Paulo Marques wrote:
> William Park wrote:
> >[...]
> >
> >Ideally, motherboard should support booting from USB key drive
> >directly.  I'm told that most modern motherboards do support usbboot,
> >but my machine doesn't.  So, I trying to load the kernel from floppy
> >(harddisk for testing purpose).  This is part of my attempt to build
> >Linux thin-client out of mini-ITX type of computer (Via CLE266
> >chipset, Via C3 cpu).
> >
> >Now, I need to find a machine that actually can do usbboot...
> 
> You will have the same problem even if the BIOS supports booting from
> USB. The BIOS will load the bootloader and map the USB drive as if it
> were a regular disk, so that the INTxx calls (can't say the number
> from memory) that LILO (or another bootloader) uses to load the kernel
> and initrd into memory will work.
> 
> After that, the kernel boots the same way as if it were loaded from a
> floppy. It still needs to discover the USB drive to mount the root
> filesystem, and that will still take the 5 seconds you were
> complaining about.

Ah, right. 

> 
> As Trent Lloyd already mentioned, you could solve this using a small
> initrd and a "nash" script, instead of patching the kernel, although
> I'm in favor of a patch of this sort getting into mainline.

I read Documentation/initrd.txt and I don't understand it.  If I
understand it right, I have to build a complete root filesystem with all
the stuffs necessary for mounting the second (real) root filesystem.  If
I'm loading the kernel from floppy, then I only have 200k to work with.
I'll try initrd.txt, step by step over the holidays.

> 
> After all, what is the use of kernel saying "Panic, can not mount the
> root filesystem" instead of saying "humm... no root file system there.
> Let me try again in a second or so and see if anything as come up..."?

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
