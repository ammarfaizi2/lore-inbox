Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRGXNFD>; Tue, 24 Jul 2001 09:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbRGXNEx>; Tue, 24 Jul 2001 09:04:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37650 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267520AbRGXNEe>;
	Tue, 24 Jul 2001 09:04:34 -0400
Date: Tue, 24 Jul 2001 15:04:24 +0200
From: Jens Axboe <axboe@suse.de>
To: David Johnson <dave-kernel-list@centerclick.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD-RAM media detected with wrong number of blocks (2.4.7)
Message-ID: <20010724150424.S4221@suse.de>
In-Reply-To: <v04210101b781c827accb@[10.0.2.30]> <20010724102526.K4221@suse.de> <v04210100b783212ef7bd@[10.0.2.30]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v04210100b783212ef7bd@[10.0.2.30]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24 2001, David Johnson wrote:
> On 7/24/01, Jens Axboe wrote:
> >On Mon, Jul 23 2001, David Johnson wrote:
> >>When attempting to create an ext2 partition on a dvd-ram (2.6G/5.2G)
> >>media the number of blocks is detected wrong causing only half of the
> >>disk to be usable.  When creating the filesystem with mke2fs only
> >>609480 2K blocks are allowed instead of 1218960 2K blocks, and I end
> >>up with a 1.2GB partition instead of 2.4GB one.  The 1.2GB fs works
> >>fine, it's just a bit small :(
> >>
> >>This is with 2.4.7 using a Creative DVD-RAM drive (1216S) on an Adaptec
> >>2940UW.
> >>
> >>The correct number of blocks is detected in 2.4.6
> >
> >Does this work?
> >
> 
> Shifting another bit causes the size to get cut in half again, not 
> shifting at all appears to be the correct thing to do.

Yes of course, braino. So eliminating the shift gets the right size for
you, correct?

-- 
Jens Axboe

