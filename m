Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313688AbSDPOOc>; Tue, 16 Apr 2002 10:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313692AbSDPOOb>; Tue, 16 Apr 2002 10:14:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51073 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313688AbSDPOOa>; Tue, 16 Apr 2002 10:14:30 -0400
Date: Tue, 16 Apr 2002 08:14:05 -0600
Message-Id: <200204161414.g3GEE5808527@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <3CBBE42D.7030906@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> David Lang wrote:
> > The common thing I use byteswap for is to mount my tivo (kernel 2.1.x)
> > drives on my PC (2.4/5.x).  those drives are byteswapped throughout the
> > entire drive, including the partition table.
> > 
> > It sounds as if you are removing this capability, am I misunderstaning you
> > or is there some other way to do this? (and duplicating the drive to use
> > dd to byteswap is not practical for 100G+)
> 
> Same problem as with SCSI disks, which are even more commonly moved
> between different system types - please look there for a solution.
> BTW. I hardly beleve that your tivo is containing a DOS partition
> table - otherwise the partition table will handle it all
> autmagically.

Well, there *is* a partition table on the drive, but the byte-swapping
isn't handled automatically. Otherwise people wouldn't need to bswap
their TiVo drives when plugging into an x86 box.

Having the bswap option is definately useful. With it, you can "bless"
the drive and then mount the partitions and poke around. Please don't
remove the bswap option. You'll make life harder for a bunch of
people.

This gratuitous removal of features in the guise of "cleanups" is why
you got flamed earlier this year. I thought you'd learned :-/

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
