Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265358AbSJRTko>; Fri, 18 Oct 2002 15:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265359AbSJRTko>; Fri, 18 Oct 2002 15:40:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265358AbSJRTkn>; Fri, 18 Oct 2002 15:40:43 -0400
Date: Fri, 18 Oct 2002 15:45:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Olien <dmo@osdl.org>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.43 disk repartitioning problems
In-Reply-To: <20021017105205.C3841@acpi.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1021018154148.23760D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Dave Olien wrote:

> I'm working on the Mylex DAC960 device driver, bring in up to date
> with the new block and dma interfaces.  I've been posting patches on
> occasion.  I've also noticed you updating the driver when you make changes
> to the gendisk kernel interfaces.   Those updates are very helpful.
> 
> I've noticed in 2.4.3 at least, that some changes to disk partitions
> aren't noticed until you reboot.  The same problem is seen with aacraid.
> I don't THINK this is a driver issue.  But, I might have missed something.  

Linux has always read the partition table at first use AFAIK. So if you
have never used a drive you can repartition it and then use it, but once
you use any one partition the table is not reread.

I *think* if you unmount all partitions (including swapoff swaps) you can
see changes, but that's from memory, I haven't tried it in a long time.

Don't believe it's a bug, it's a design decision.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

