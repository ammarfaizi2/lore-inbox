Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130776AbRCFNrC>; Tue, 6 Mar 2001 08:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130777AbRCFNqm>; Tue, 6 Mar 2001 08:46:42 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:42887 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130776AbRCFNqc>; Tue, 6 Mar 2001 08:46:32 -0500
Message-Id: <l0313030cb6ca98eb60a7@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0103060513160.15874-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0103060449230.15874-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 13:45:54 +0000
To: dean gaudet <dean-list-linux-kernel@arctic.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>,
        Jeremy Hansen <jeremy@xxedgexx.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> i assume you meant to time the xlog.c program?  (or did i miss another
>> program on the thread?)

Yes.

>> i've an IBM-DJSA-210 (travelstar 10GB, 5411rpm) which appears to do
>> *something* with the write cache flag -- it gets 0.10s elapsed real time
>> in default config; and gets 2.91s if i do "hdparm -W 0".
>>
>> ditto for an IBM-DTLA-307015 (deskstar 15GB 7200rpm) -- varies from .15s
>> with write-cache to 1.8s without.
>>
>> and an IBM-DTLA-307075 (deskstar 75GB 7200rpm) varies from .03s to 1.67s.
>>
>> of course 1.8s is nowhere near enough time for 200 writes to complete.
>
>hi, not enough sleep, can't do math.  1.67s is exactly the ballpark you'd
>expect for 200 writes to a correctly functioning 7200rpm disk.  and the
>travelstar appears to be doing the right thing as well.

I was just about to point that out.  :)  I ran the program with 2000
packets in order to magnify the difference.

So, it appears that the IBM IDE drives are doing the "right thing" when
write-caching is switched off, but the Seagate drive (at least the one I'm
using) appears not to turn the write-caching off at all.  I want to try
this out with some other drives, including a Seagate SCSI drive and a
different Seagate IDE drive (attached to a non-UDMA controller), and
perhaps a couple of older drives which I just happen to have lying around
(particularly a Maxtor and an old TravelStar with very little cache).
That'll have to wait until later, though - university work beckons.  :(

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


