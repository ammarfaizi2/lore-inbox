Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbRGORpL>; Sun, 15 Jul 2001 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbRGORpD>; Sun, 15 Jul 2001 13:45:03 -0400
Received: from geos.coastside.net ([207.213.212.4]:15245 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S266718AbRGORox>; Sun, 15 Jul 2001 13:44:53 -0400
Mime-Version: 1.0
Message-Id: <p0510031ab77784b66bc8@[207.213.214.37]>
In-Reply-To: <20010716051046.A10956@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
 <20010716051046.A10956@weta.f00f.org>
Date: Sun, 15 Jul 2001 10:39:52 -0700
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:10 AM +1200 2001-07-16, Chris Wedgwood wrote:
>On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:
>
>     As far as I can tell none of them at least in the IDE world
>
>Can you test with the code I posted a hour or so ago please?

AC's comment was about whether the drive's cache would be written out 
on power failure, which is another issue, a little harder to test 
(and not easily testable by writing a single sector). I raise the 
related question of what happens to the write cache on a bus reset on 
SCSI drives.

>I ask this because I tested writes to:
>
>   -- buffered devices
>
>   -- ide with caching on
>
>   -- ide with caching off
>
>   -- scsi (caching on?)
>
>To a buffered device, I get something silly like 63000
>writes/second. No big surprises there (other than Linux is bloody lean
>these days).
>
>To a SCSI device (10K RPM SCSI-3 160 drive), I get something like 167
>writes/second, which seems moderately sane if caching is disabled.

My impression, based a a little but not much research, is that most 
SCSI drives disable write caching by default. IBM SCSI drives may be 
an exception to this.

>To a cheap IDE drive (5400 RPM?) with caching off, I get about 87
>writes/second.
>
>To the same drive, with caching on, I get almost 4000 writes/second.
>
>This seems to imply, at least for my test IDE drive, you can turn
>caching off --- and its about half as fast as my SCSI drives which
>rotate at about twice the speed (sanity check).
>
>IDE drive:  IBM-DTTA-351010, ATA DISK drive
>SCSI drive: SEAGATE ST318404LC


-- 
/Jonathan Lundell.
