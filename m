Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJTJjZ>; Sun, 20 Oct 2002 05:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbSJTJit>; Sun, 20 Oct 2002 05:38:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36820 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263246AbSJTJc3>;
	Sun, 20 Oct 2002 05:32:29 -0400
Date: Sun, 20 Oct 2002 11:38:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jan Dittmer <jan@jandittmer.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Message-ID: <20021020093818.GC24484@suse.de>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de> <20021019222403.B3018@ucw.cz> <20021019230434.A800@ucw.cz> <20021020003834.GJ871@suse.de> <20021020104601.C8606@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020104601.C8606@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20 2002, Vojtech Pavlik wrote:
> On Sun, Oct 20, 2002 at 02:38:34AM +0200, Jens Axboe wrote:
> > On Sat, Oct 19 2002, Vojtech Pavlik wrote:
> > > On Sat, Oct 19, 2002 at 10:24:03PM +0200, Vojtech Pavlik wrote:
> > > 
> > > > > It's not an oops, and it's not causes by TCQ either. The above is simply
> > > > > a reminder to fix the ide init sequence, because it's probe sequence
> > > > > tries to use drive->disk before it has been set up. That is worked
> > > > > around, but stack is dumped for good measure. So you can feel
> > > > > comfortable using 2.5.44 regardless.
> > > > > 
> > > > > But I'm curious about TCQ on your system, since another VIA user
> > > > > reported problems. Does it appear to work for you?
> > > > 
> > > > It definitely works on my VIA just fine.
> > > 
> > > Famous last words. I tried to play with the /proc using_tcq setting and
> > > got a filesystem corruption immediately.
> > 
> > There _may_ be issues with changing depth on the fly. So if you could
> > just test without fiddling with changing depths that would be great.
> 
> Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> automatically (checked that in kernel config0, it works perfectly fine.

Thanks for verifying that! Jan, you appeared to have problems even with
tcq-per-default enabled and not touching the depth while running io, is
that correct?

-- 
Jens Axboe

