Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbRCBPIo>; Fri, 2 Mar 2001 10:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRCBPIf>; Fri, 2 Mar 2001 10:08:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39949 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129215AbRCBPIP>;
	Fri, 2 Mar 2001 10:08:15 -0500
Date: Fri, 2 Mar 2001 16:07:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Mario Hermann <ario@eikon.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a second loop-device with 2.4.2-ac7
Message-ID: <20010302160759.G408@suse.de>
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de> <20010301172145.T21518@suse.de> <3A9FADAB.F37E5449@eikon.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A9FADAB.F37E5449@eikon.tum.de>; from ario@eikon.tum.de on Fri, Mar 02, 2001 at 03:26:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02 2001, Mario Hermann wrote:
> > > I tried the following commands with 2.4.2-ac7:
> > >
> > > losetup /dev/loop0 test.dat
> > > losetup /dev/loop1 /dev/loop0
> > > mke2fs /dev/loop1
> > >
> > > My System reboots immediatly. I tried it with 2.4.2-ac4,ac5 too -> same
> > > effect.
> > >
> > > With 2.4.2 it hangs immediatly.
> > 
> > This should make it work again.
> 
> There is another small bug with the loop over loop problem. Now it works
> fine for
> files but not for Devices:
> 
> losetup /dev/loop0 /dev/sr1
> losetup /dev/loop1 /dev/loop0
> dd if=/dev/loop1 of=test.dat bs=2048 count=1024
> 
> Makes dd hang. (BTW: /dev/sr1 is a CD-ROM)
> 
> Tried the same on /dev/hda1, /dev/sda1 with 2.4.2-ac7-your_patch and
> with 2.4.2-ac8.

I must admit that I haven't tried loop-over-loop at all really,
I'll make a note to look at this tonight.

> BTW: Did extensiv testing with and without the crypto patches. And all
> other tests worked fine! :-)

Great.

-- 
Jens Axboe

