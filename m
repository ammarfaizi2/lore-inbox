Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWKDKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWKDKqE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWKDKqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:46:04 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:59864 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965225AbWKDKqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:46:01 -0500
Date: Sat, 4 Nov 2006 11:46:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061104104601.GA16991@wohnheim.fh-wedel.de>
References: <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <20061103101901.GA11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz> <20061103122126.GC11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz> <20061103134802.GD11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz> <20061103145329.GE11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031953411.30722@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611031953411.30722@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 20:01:56 +0100, Mikulas Patocka wrote:
> >
> >So which, if I may ask, are the advantages of your design over sprite
> >lfs?
> 
> It is very different from LFS. LFS is log-filesystem, i.e. journal spans 
> the whole device. The problem with this design is that it's fast for write 
> (cool benchmark numbers) and slow in real-world workloads.
> 
> LFS places files according to time they were created, not according to 
> their directory.
> 
> If you have directory with some project where you have files that you 
> edited today, day ago, week ago, month ago etc., then any current 
> filesystem (even ext2) will try to place files near each other --- while 
> LFS will scatter the files over the whole partition according to time they 
> were written. --- I believe that this is the reason why log-structured 
> filesystems are not in wild use --- this is a case where optimizing for 
> benchmark kills real-world performance.

Darn, I was asking the wrong question again.  Let me rephrase:

So which, if I may ask, are the advantages of your crash
count/transaction count design over the sprite lfs checkpoint design?

Allocation strategy is an interesting topic as well.  Rosenblum and
Ousterhout were wrong in their base assumption that read performance
won't matter long-term, as caches are exponentially growing.  It
turned out that storage size was growing just as fast and the ratio
remained roughly the same.  But let us postpone that for a while.

Jörn

-- 
tglx1 thinks that joern should get a (TM) for "Thinking Is Hard"
-- Thomas Gleixner
