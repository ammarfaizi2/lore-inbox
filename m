Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319445AbSIGG65>; Sat, 7 Sep 2002 02:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319446AbSIGG65>; Sat, 7 Sep 2002 02:58:57 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6921 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319445AbSIGG64>; Sat, 7 Sep 2002 02:58:56 -0400
Date: Sat, 7 Sep 2002 00:02:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
In-Reply-To: <200209061713.51387.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.4.10.10209062354300.11256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First BACK up what is left.

Next dig out smartsuite from http://www.linux-ide.org/smart.html

Run it in full capture mode, please use another disk to run root, or the
system will tank.

Read and save smart logs.

cat /dev/zero > /dev/hd{IBM-DTLA-307060}x

Rerun Smart in full capture mode.

Reread smart logs and compare.

cat /dev/urandom > /dev/hd{IBM-DTLA-307060}x

If you get no errors you can reuse the drive, for how long? Maybe 6 months
to a year.

Now, I can not tell you what, why, how things are going on.
Sheesh, I expect to be in a deep six for this series of events already.

Sorry, I can not say anymore.

If you do not like the above, you need to run out and buy another drive
fast.

Cheers,

On Fri, 6 Sep 2002, DevilKin wrote:

> Hello kernel people,
> 
> Kernel running: 2.4.20-pre1ac3 or -pre5ac2 (same under both)
> 
> Today I discovered a stale copy of qt-3.0.3 lying about on my disk. When I 
> tried to delete it, this started showing up in my log files:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862, 
> sector=1803472
> end_request: I/O error, dev 03:06 (hda), sector 1803472
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
> of [612671 612672 0x0 SD]
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862, 
> sector=1803472
> end_request: I/O error, dev 03:06 (hda), sector 1803472
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
> of [612671 612677 0x0 SD]
> 
> and rm just reported me 'Permission denied'.
> 
> I've looked up these errors on the net, and as far as i can tell it means that 
> the drive has some bad sectors at the given addresses and that it will 
> probably die on me sooner or later.
> 
> Can someone either confirm this to me or tell me what to do to fix it?
> 
> The drive involved is an IBM-DTLA-307060, which has served me without problems 
> now for about 2 years.
> 
> Thanks!
> 
> DK
> -- 
> If all the Chinese simultaneously jumped into the Pacific off a 10 foot
> platform erected 10 feet off their coast, it would cause a tidal wave
> that would destroy everything in this country west of Nebraska.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

