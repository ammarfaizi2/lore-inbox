Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSIFPL4>; Fri, 6 Sep 2002 11:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSIFPL4>; Fri, 6 Sep 2002 11:11:56 -0400
Received: from [212.3.242.3] ([212.3.242.3]:33266 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S318626AbSIFPLz>;
	Fri, 6 Sep 2002 11:11:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: ide drive dying?
Date: Fri, 6 Sep 2002 17:13:51 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209061713.51387.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel people,

Kernel running: 2.4.20-pre1ac3 or -pre5ac2 (same under both)

Today I discovered a stale copy of qt-3.0.3 lying about on my disk. When I 
tried to delete it, this started showing up in my log files:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862, 
sector=1803472
end_request: I/O error, dev 03:06 (hda), sector 1803472
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [612671 612672 0x0 SD]
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862, 
sector=1803472
end_request: I/O error, dev 03:06 (hda), sector 1803472
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data 
of [612671 612677 0x0 SD]

and rm just reported me 'Permission denied'.

I've looked up these errors on the net, and as far as i can tell it means that 
the drive has some bad sectors at the given addresses and that it will 
probably die on me sooner or later.

Can someone either confirm this to me or tell me what to do to fix it?

The drive involved is an IBM-DTLA-307060, which has served me without problems 
now for about 2 years.

Thanks!

DK
-- 
If all the Chinese simultaneously jumped into the Pacific off a 10 foot
platform erected 10 feet off their coast, it would cause a tidal wave
that would destroy everything in this country west of Nebraska.

