Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289973AbSBKSSi>; Mon, 11 Feb 2002 13:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289982AbSBKSS2>; Mon, 11 Feb 2002 13:18:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49670 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289973AbSBKSSJ>; Mon, 11 Feb 2002 13:18:09 -0500
Date: Mon, 11 Feb 2002 13:16:57 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Francois Romieu <romieu@cogenit.fr>
cc: "Peter H. R?egg" <pruegg@eproduction.ch>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
In-Reply-To: <20020209205734.A17825@fafner.intra.cogenit.fr>
Message-ID: <Pine.LNX.3.96.1020211131230.32755D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Francois Romieu wrote:

> Raid1 is software only.
> As soon as a filesystem on the promise adapter comes into play, writes maxes 
> out at 2,5Mo/s. The previous machine (old PA2012 motherboard) with 8 times 
> less memory was able to stand 4~5Mo/s with vanilla broken kernel.
> Now it's running 2.4.18-pre3-ac2 but the behavior is the same with vanilla
> pre, vanilla + akpm ll, +ide patches. Feel free to ask if you want a test on a
> specific version. I have dedicated a partition on each disk for testing.

I don't have a fix for this directly, but the slow speed can be fixed on
many Promise controllers with hdparm. Testing the transfer rate of some of
my mature (ATA/66) drives, I find that raising the transfer rate from 3MB
to 14MB is often possible after setting the options.

NOTE: wrong options will hose your data! WHich is why I don't tell you
what to use, just look at -m -c (I use 3), -d and -X34. Again, it may bite
you, have backups.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

