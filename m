Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSJRWLb>; Fri, 18 Oct 2002 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJRWLb>; Fri, 18 Oct 2002 18:11:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265409AbSJRWLa>;
	Fri, 18 Oct 2002 18:11:30 -0400
Date: Fri, 18 Oct 2002 15:17:24 -0700
From: Dave Olien <dmo@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 disk repartitioning problems
Message-ID: <20021018151724.A6207@acpi.pdx.osdl.net>
References: <20021017105205.C3841@acpi.pdx.osdl.net> <Pine.LNX.3.96.1021018154148.23760D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1021018154148.23760D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Fri, Oct 18, 2002 at 03:45:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill,

Hmm.  

The disks I'm working with aren't mounted and are not being used for
swap.  There are no applications holding any partitions open.
At the time I'm modifying a disk's partition tables, there are no users
of any partitions on that disk.

I experimented removing and adding partitions in 2.4.18, and repeating
those experiemnts in 2.5.43.  The two versions of OS definately
behave differently.  

Dave

On Fri, Oct 18, 2002 at 03:45:50PM -0400, Bill Davidsen wrote:
> On Thu, 17 Oct 2002, Dave Olien wrote:
> 
> > I'm working on the Mylex DAC960 device driver, bring in up to date
> > with the new block and dma interfaces.  I've been posting patches on
> > occasion.  I've also noticed you updating the driver when you make changes
> > to the gendisk kernel interfaces.   Those updates are very helpful.
> > 
> > I've noticed in 2.4.3 at least, that some changes to disk partitions
> > aren't noticed until you reboot.  The same problem is seen with aacraid.
> > I don't THINK this is a driver issue.  But, I might have missed something.  
> 
> Linux has always read the partition table at first use AFAIK. So if you
> have never used a drive you can repartition it and then use it, but once
> you use any one partition the table is not reread.
> 
> I *think* if you unmount all partitions (including swapoff swaps) you can
> see changes, but that's from memory, I haven't tried it in a long time.
> 
> Don't believe it's a bug, it's a design decision.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
