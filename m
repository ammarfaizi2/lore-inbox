Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbRLLJjU>; Wed, 12 Dec 2001 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLLJjK>; Wed, 12 Dec 2001 04:39:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40719 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285129AbRLLJi6>;
	Wed, 12 Dec 2001 04:38:58 -0500
Date: Wed, 12 Dec 2001 10:38:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Ritson <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011212093852.GB13498@suse.de>
In-Reply-To: <20011211142831.GV13498@suse.de> <Pine.LNX.4.33.0112120754240.1679-100000@eden.lincnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112120754240.1679-100000@eden.lincnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12 2001, Carl Ritson wrote:
> On Tue, 11 Dec 2001, Jens Axboe wrote:
> 
> > On Sun, Dec 09 2001, Jens Axboe wrote:
> > > > Ok works with DMA off, so I expect that this new error is due to my resent
> > > > memory upgrade (36 Hours ago) and the switch to using HIGHMEM(4GB)..
> > > > So am I to believe that DMA is a problem with HIGHMEM(4GB) enabled ?
> > >
> > > No it's probably still an ide-scsi bug, I'm not suspecting your
> > > hardware. The reason I ask is because until -pre8 (since bio merge in
> > > -pre2), ide-scsi never used DMA even though it was set for the drive.
> >
> > Ok finally had a chance to look some more at this -- it was a bit more
> > hairy than I had hoped. Please try this ide-scsi one liner, it should
> > cure it. (the bug fix is the bio->bi_vcnt = 1 change only)
> >
> >
> This Patch appears to work fine.  Tested with DMA on and DMA off, no
> Errors.. :)

Super, thanks for testing.

-- 
Jens Axboe

