Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280930AbRKOQXT>; Thu, 15 Nov 2001 11:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280727AbRKOQXI>; Thu, 15 Nov 2001 11:23:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43791 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280932AbRKOQXB>;
	Thu, 15 Nov 2001 11:23:01 -0500
Date: Thu, 15 Nov 2001 17:22:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux i/o tweaking
Message-ID: <20011115172246.Z27010@suse.de>
In-Reply-To: <Pine.LNX.4.30.0111151535060.13411-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111151535060.13411-100000@mustard.heime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15 2001, Roy Sigurd Karlsbakk wrote:
> Hi all
> 
> After three days at Compaq's lab in Oslo, testing their medium-level
> servers and storage systems with Linux, I've come to some sort of
> conclusions, although these may be wrong. I also have come over a few
> problems that I couln't find a good solution to.
> 
>  * When running RAID from a Compaq Smart 5302/64 controller, software
> RAID-5 is (slightly - ~15%) faster (on JBOD - each disk is configured as
> a RAID-0 device with max - 256kB - stripe size) than the
> hardware/controller based RAID-5. Both CPUs (1266MHz/512kB cache) are
> maxed out by reading from software RAID-5 (???), giving me >= 107MB/s on
> two SCSI-3 buses with six disks on each bus.
> 
>  * Even though I can get up to 25 MB/s from each disk, I can't get more
> than 107 MB/s on the whole bunch (12 drives). It doesn't help much to do
> RAID-0 either. Don't understand anything ...

Could you please try and profile where the time is spent? Boot with
profile=2, and then do

# readprofile -r
# do I/O testing
# readprofile | sort -nr

-- 
Jens Axboe

