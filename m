Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263892AbRFDVKT>; Mon, 4 Jun 2001 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263893AbRFDVKJ>; Mon, 4 Jun 2001 17:10:09 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:45321 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S263892AbRFDVJz>; Mon, 4 Jun 2001 17:09:55 -0400
Date: Mon, 4 Jun 2001 23:09:33 +0200
From: Jens Axboe <axboe@suse.de>
To: PROFETA Mickael <profeta@crans.ens-cachan.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide retry on 2.4.5-ac7
Message-ID: <20010604230932.A23128@suse.de>
In-Reply-To: <20010604140207.A529@alezan.dyndns.org> <20010604221404.A19333@suse.de> <20010604230215.A6188@alezan.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010604230215.A6188@alezan.dyndns.org>; from profeta@crans.ens-cachan.fr on Mon, Jun 04, 2001 at 11:02:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04 2001, PROFETA Mickael wrote:
> On Mon, Jun 04, 2001 at 10:14:04PM +0200, Jens Axboe wrote:
> > 
> > It worked sucessfully for you in 2.4.5-ac4 but not in -ac7? I can't see
> > any changes to the patch, so more details on the nature of the problem
> > would be helpful.
> 
> Ok, this is the results of a hdparm -tT on my second hard disk:
> 
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide1: reset: success
> 64 MB in  7.03 seconds =  9.10 MB/sec
> 
> and then the kernel has shifted to udma3 and I have no more error in this
> session with that hard disk
> 
> I tried the same thing on -ac7 and I always have the errors, the kernel does
> not reset ide... Looking at the different change on ac patches, I can not see 
> why...

This is not the case that is attempted solve. The above could be a cable
error (it looks like it). These are usually genuine and indicate a real
hw problem.

-- 
Jens Axboe
