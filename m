Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSKLJMU>; Tue, 12 Nov 2002 04:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSKLJMT>; Tue, 12 Nov 2002 04:12:19 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:11404 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266323AbSKLJMT>;
	Tue, 12 Nov 2002 04:12:19 -0500
Date: Tue, 12 Nov 2002 10:15:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Torben Mathiasen <torben.mathiasen@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
Message-ID: <20021112101546.A29909@ucw.cz>
References: <1036780850.16651.105.camel@irongate.swansea.linux.org.uk> <Pine.LNX.3.96.1021111120435.18680B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1021111120435.18680B-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Nov 11, 2002 at 12:10:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 12:10:13PM -0500, Bill Davidsen wrote:
> On 8 Nov 2002, Alan Cox wrote:
> 
> > On Fri, 2002-11-08 at 16:56, Jens Axboe wrote:
> > > > Linus please drop this patch for now. Its not been tested on enough
> > > > controllers, its making things unneccessarily ugly and its also just
> > > > going to make updates hard.
> > > 
> > > Alan, the patch is pretty much straight forward. Cleaning up the magic
> > > numbers and ->autotune consistencies is a good thing, imo.
> > 
> > You can clean up the naming but it still hasn't been tested, not all
> > bioses neccessarily give us timings we can trust either.  I'm not
> > opposed to the concept but after the previous IDE mess in 2.5 merging
> > something that isnt tested on lots of controllers and might have weird
> > effects does both me a bit
> 
> This is one of those things which we should allow at user risk. After all,
> you can shoot yourself in the foot with hdparm as well, there are many
> unwise things allowed.
> 
> Having seen all the warnings from bad setup of MPS and ACPI in dmesg, I
> would say it's more likely that the BIOS get these settings right, since
> they may be used by that other operating system.

I can tell you that many VIA (namely older) boards simply crash after
the first DMA access when you don't fix the timings/fifo settings of the
chip after what mess the BIOS left there.

-- 
Vojtech Pavlik
SuSE Labs
