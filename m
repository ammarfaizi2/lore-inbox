Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSKFXSy>; Wed, 6 Nov 2002 18:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266211AbSKFXSy>; Wed, 6 Nov 2002 18:18:54 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:16381 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266210AbSKFXSx>;
	Wed, 6 Nov 2002 18:18:53 -0500
Date: Wed, 6 Nov 2002 18:25:29 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106232529.GC27210@www.kroptech.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106074457.GE4369@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106074457.GE4369@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 08:44:57AM +0100, Jens Axboe wrote:
> On Wed, Nov 06 2002, Jens Axboe wrote:
> > > when the cdrecord buffer underran was surprising, though: oops below.
> > > Very repeatable. Can supply copious hw details if it helps.
> > 
> > I'll try and reproduce that here, there's been a similar report (same
> > oops) before. If you can just send me the dmesg output after a boot that
> > should be fine.
> 
> Could you reproduce with this patch? I'd like to see the request state
> when this happens.

Here you go... This was with max tags locked at 4. I've included some of
the surrounding lines from cdrecord.

--Adam

Track 01:   85 of  437 MB written (fifo   0%) [buf  31%]   3.3x./opt/schily/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 AA BE 00 00 1F 00
status: 0x1 (GOOD STATUS)
resid: 63488
cmd finished after 0.011s timeout 40s

write track data: error after 89518080 bytes
cdrom_newpc_intr: dev hdc: flags = REQ_RW REQ_NOMERGE REQ_STARTED REQ_BLOCK_PC REQ_FAILED REQ_QUIET
sector 0, nr/cnr 124/8
bio 00000000, biotail c1cd0860, buffer c968d000, data 00000000, len 63488
cdb: 2a 00 00 00 aa be 00 00 1f 00 00 00 00 00 00 00
hdc: padding 63488 bytes
Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00

