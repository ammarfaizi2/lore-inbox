Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285091AbRLLIC2>; Wed, 12 Dec 2001 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285089AbRLLICS>; Wed, 12 Dec 2001 03:02:18 -0500
Received: from pc2-camb4-0-cust100.cam.cable.ntl.com ([213.107.105.100]:9600
	"EHLO eden.lincnet") by vger.kernel.org with ESMTP
	id <S285091AbRLLICL>; Wed, 12 Dec 2001 03:02:11 -0500
Date: Wed, 12 Dec 2001 08:02:05 +0000 (GMT)
From: Carl Ritson <critson@perlfu.co.uk>
X-X-Sender: <critson@eden.lincnet>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
In-Reply-To: <20011211142831.GV13498@suse.de>
Message-ID: <Pine.LNX.4.33.0112120754240.1679-100000@eden.lincnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Jens Axboe wrote:

> On Sun, Dec 09 2001, Jens Axboe wrote:
> > > Ok works with DMA off, so I expect that this new error is due to my resent
> > > memory upgrade (36 Hours ago) and the switch to using HIGHMEM(4GB)..
> > > So am I to believe that DMA is a problem with HIGHMEM(4GB) enabled ?
> >
> > No it's probably still an ide-scsi bug, I'm not suspecting your
> > hardware. The reason I ask is because until -pre8 (since bio merge in
> > -pre2), ide-scsi never used DMA even though it was set for the drive.
>
> Ok finally had a chance to look some more at this -- it was a bit more
> hairy than I had hoped. Please try this ide-scsi one liner, it should
> cure it. (the bug fix is the bio->bi_vcnt = 1 change only)
>
>
This Patch appears to work fine.  Tested with DMA on and DMA off, no
Errors.. :)

Carl Ritson

