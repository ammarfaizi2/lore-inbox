Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRIGAWt>; Thu, 6 Sep 2001 20:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRIGAWk>; Thu, 6 Sep 2001 20:22:40 -0400
Received: from mx-outgoing.delfi.lt ([213.197.128.109]:36618 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S269515AbRIGAW1>; Thu, 6 Sep 2001 20:22:27 -0400
Date: Fri, 7 Sep 2001 02:22:23 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: replaying reiserfs journal and bad blocks (was: Re[3]: Basic reiserfs question)
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Reiser <reiser@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
 <3B97729B.1F49AACA@namesys.com>
 <20010907000239.26A738F91C@mail.delfi.lt>
In-Reply-To: <20010907000239.26A738F91C@mail.delfi.lt>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Message-Id: <20010907002246.877E28F698@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NB> If you think it's RedHat, you probably are wrong - I use RH with reiserfs
NB> a long time (more than a year - 6.2, now 7.1), and never got a message about
NB> replaying journal if system was shut down correctly.

After just written that, I got a real problem. There was a power loss a few minutes ago,
and I think when hdd was active. Trying to boot 2.4.7 kernel I got a message about
replaying journal, then hdd error:

hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }                    
hdd: dma_intr: error=0x40 { UncorrectableError }, LBAsect=84415, sector=36216  

and kernel panic. Please note that I mount root read-write with this kernel.

Then I rebooted 2.2.19 kernel (which mounts root as read-only if that matters):

Checking ReiserFS transaction log (device 16:42) ...
Warning, log recovery starting on readonly filesystem
hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x40 { UncorrectableError }, LBAsect=84415, sector=36216
end_request: I/O error, dev 16:42 (hdd), sector 36216
Replayed 33 transactions in 6 seconds
Using r5 hash to sort names
...
ReiserFS version 3.5.32
VFS: Mounted root (reiserfs filesystem) readonly.

and system booted normally.
Now I rebooted back to 2.4.7 and everything seems to be OK.
So what to do now? Run badblocks? Change disk? Any suggestions?

Regards,
Nerijus


