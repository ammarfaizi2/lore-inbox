Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbRLRFCL>; Tue, 18 Dec 2001 00:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285135AbRLRFBv>; Tue, 18 Dec 2001 00:01:51 -0500
Received: from willow.seitz.com ([207.106.55.140]:15370 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S284264AbRLRFBt>;
	Tue, 18 Dec 2001 00:01:49 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Tue, 18 Dec 2001 00:01:45 -0500
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org, Jurgen Botz <jurgen@botz.org>
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011218000145.A15150@willow.seitz.com>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org> <20011218003359.A555@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218003359.A555@diego>; from grundig@teleline.es on Tue, Dec 18, 2001 at 12:33:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is my opinion:
> 	-Something (reiserfs, anything) has caused fs corruption
> 	-It should be repaired by reiserfsck, but it's broken :-((
> 	-This corruption should NOT have happened, reiserfsck shouldn't
> have to be used.
> 	-I'm not a kernel hacker, so I can't try anything...what I know is
> that
> 		/etc in hc5 doesn't work. /usr, /var....works correctly.
> 
> Well, I'd like to know what's happened in my drive. Can somebody try to
> give an explanation?

I've seen this happen when being careless about partitioning my drive.  If
you changed your partition table and created the filesystem without a reboot
you could be in for this problem.  If fdisk was unable to update the
partition table after writing it out and you ran mkreiserfs, you just made a
filesystem on the *old* partition, according to the *old* partition table.
Upon rebooting, the disk will be synced to the new partition table.  If you
happened to shrink the parition a bit, the filsystem is suddenly longer than
the partition.

Ross Vandegrift
ross@willow.seitz.com
