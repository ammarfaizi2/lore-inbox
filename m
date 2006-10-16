Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWJPF1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWJPF1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 01:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWJPF1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 01:27:19 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:62399 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751463AbWJPF1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 01:27:19 -0400
Date: Mon, 16 Oct 2006 08:27:15 +0300
From: Ville Herva <vherva@vianova.fi>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061016052715.GC23144@vianova.fi>
Reply-To: vherva@vianova.fi
References: <17710.54489.486265.487078@cse.unsw.edu.au> <20061015082921.GC22674@vianova.fi> <17714.51511.845336.721450@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17714.51511.845336.721450@cse.unsw.edu.au>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 09:50:15AM +1000, you [Neil Brown] wrote:
> On Sunday October 15, vherva@vianova.fi wrote:
> > On Fri, Oct 13, 2006 at 09:50:49AM +1000, you [Neil Brown] wrote:
> > > 
> > > Hi,
> > >  I was looking into an issue that someone was having with raid5.
> > > They made an md/raid5 out of 5 whole devices and by luck the data
> > > that was written to the first block of the 5th device looked
> > > slightly like a partition table.  fdisk output below for the curious.
> > > However some partitions were beyond the end of the device.
> > 
> > That reminds me of an old long-standing mystery I had with a machine that
> > had a RAID-5 of three whole devices. 
> > 
> > I wonder if there's ever a change the kernel partition detection code could
> > _write_ on the disk, even when there's really no partition table?
> 
> No, kernel partition detection never writes.

Well yeah, that sounded very improbable to begin with. But then again, there
were very few things that could've done it apart from kernel early boot/late
shutdown code, bios and cosmic radiation. 
 
> I can't imagine what could have been causing your very-interesting
> corruption.  However as it was only demonstrated on old code and
> cannot be explored further, I suspect we just have to forget it and
> move one :-(

Yes, that's certainly the most sensible thing to do.

Although it did happen with both 2.2 and 2.4 (never tried 2.6
unfortunately), but only on a single box, and I never heard of anybody else
seeing anything similar, so it can't be a wide spread problem even it still
were present.

Thanks for the reply.



-- v -- 

v@iki.fi

