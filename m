Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbRDSNEE>; Thu, 19 Apr 2001 09:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135656AbRDSNDx>; Thu, 19 Apr 2001 09:03:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45318 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135655AbRDSNDj>;
	Thu, 19 Apr 2001 09:03:39 -0400
Date: Thu, 19 Apr 2001 15:03:32 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Message-ID: <20010419150332.B22159@suse.de>
In-Reply-To: <01041714250400.01376@antares> <01041914131100.01232@antares> <20010419141538.S16822@suse.de> <01041914440701.01232@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041914440701.01232@antares>; from s-jaschke@t-online.de on Thu, Apr 19, 2001 at 02:44:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Stefan Jaschke wrote:
> On Thursday 19 April 2001 14:15, Jens Axboe wrote:
> > This is really strange, are you sure your drive is ok? Does mounting
> > dvd-rom and cd-rom's work fine?
> 
> OK. I'll check again with 2.4.4-pre4+patches:
> (1) Mounting the SuSE DVD-ROM (-t iso9660) from /dev/hdc on /dvd and 
>     reading from /dvd works. Same for CD-ROMs. I don't have a formatted
>     DVD-RAM.
> (2) Reading with "dd if=/dev/hdc ..." 
>    (2.1) works with CD-ROM inserted
>    (2.2) fails with DVD-ROM inserted

dd fails with DVD-ROM inserted??? In the same way? Is this the SuSE DVD,
and not a movie DVD? Also, check dmesg for errors.

>    (2.3) fails with DVD-RAM inserted
> (3) Writing with "dd of=/dev/hdc ..." works (with DVD-RAM inserted).
> (4) "mke2fs -b 2048 /dev/hdc" fails (with DVD-RAM inserted).

Side note -- use as big a block size as you can for a DVD-RAM hosted fs,
4kB is better than 2kB.

> As if the drive gives the driver wrong information (like size=0)?

Could be, try

cat /proc/ide/hdc/capacity

and see what that says.

But at least it looks like your drive is just fine.

> If nothing helps, I have to plug the drive into a Windows machine
> to make sure it really works with Toshiba's own drivers. This would
> be a major hassle, though. No place for Windows on my own machine.

Lets not go that far yet :)

> Hence some amount of screwing... :-(

And lets stick to hardware for now, ok? :-)

-- 
Jens Axboe

