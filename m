Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUDZKWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUDZKWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbUDZKWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:22:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:25308 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264471AbUDZKWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:22:47 -0400
Date: Mon, 26 Apr 2004 12:22:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040426102224.GE2938@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0404231624010.1352@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 April 2004 16:34:21 -0400, Richard B. Johnson wrote:
> 
> If you want to have fast disks, then you should do what I
> suggested to Digital 20 years ago when they had ST-506
> interfaces and SCSI was available only from third-parties.
> It was called "striping" (I'm serious!). Not the so-called
> RAID crap that took the original idea and destroyed it.
> If you have 32-bits, you design an interface board for 32
> disks. The interface board strips each bit to the data that
> each disk gets. That makes the whole array 32 times faster
> than a single drive and, of course, 32 times larger.
> 
> There is no redundancy in such an array, just brute-force
> speed. One can add additional bits and CRC correction which
> would allow the failure (or removal) of one drive at a time.

...and so you add latency to the ever-growing list of concepts you
publically prove to be unaware of.

Those 32 disks now have something like 32x50MB/s or 1.6GB/s, great.
Seek time is still 10ms, though, so now each seek costs as much as
16MB of continuous data transfer.  Nice.  So readahead will be 64MB,
and disk cache 1GB, just to get rid of some seeks again?  Sure.

If you were a little smarter and used the so-called RAID crap, you
would have stripes of about the readahead size (or more) and seeks get
spread up between disks.  Sure, transfer speed will usually be lower
than 1.6GB/s, but who cares.  The point is that each seek will only
cost you as much as 500kB of continuous transfer.

But like so many other things, you will refuse to understand this as
well, right?  Well, at least don't try to convince the unaware,
please.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
