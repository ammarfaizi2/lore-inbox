Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282801AbSAARlD>; Tue, 1 Jan 2002 12:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282413AbSAARko>; Tue, 1 Jan 2002 12:40:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22277 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282067AbSAARkX>;
	Tue, 1 Jan 2002 12:40:23 -0500
Date: Tue, 1 Jan 2002 18:40:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20020101184004.B16092@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231145455.C6465@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31 2001, Matthew Dharm wrote:
> Jens --
> 
> Thanks for the info.  It may have been discussed 'here' (tho, this is
> crosposted to two different lists), but I've been focused on 2.4 bugs (one
> more left!) and hadn't seen this item.

oh sorry, 'here' means linux-kernel to me :-)

> I think for the first 2.5 kernels, we'll o with your 'vaddr' line, but I
> think that being able to set highmem_io is a worthwhile thing.  Which leads
> me to two questions:

indeed

> (1) Do the USB HCDs support highmem?  I seem to recall they do, but I'm not
> certain.

most likely, I don't know though. I would imagine they support full
32-bit dma.

> (2) How do I pass a highmem address to the HCDs?  The URB structures we use
> don't seem particularly well-suited for this.

you need to use the pci dma mapping interface, see
Documentation/DMA-mapping.txt

-- 
Jens Axboe

