Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284289AbSABV0E>; Wed, 2 Jan 2002 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbSABVZw>; Wed, 2 Jan 2002 16:25:52 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:20938 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S284289AbSABVY2>; Wed, 2 Jan 2002 16:24:28 -0500
Date: Wed, 2 Jan 2002 13:23:28 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.10.10201021052090.10050-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0201021319400.6763-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jan 2002, Andre Hedrick wrote:

>
> Brian,
>
> This was true in the past and with many older drivers.  However when and
> if the new driver I have is adpoted, it will make SCSI cry.  So please
> stop polluting the issue.
>
> Let me be as objective as I can be.
>
> I built a special Mylex 3-channel raid 10 systems using 6 15K drive at
> Ultra160.  Given that I was clever, I was able to push that system to read
> and write at 170MB/sec.  I was very impressed by this performance, however
> this was hardware raid, caching of 256MB, and 66/64 pci bus.  This was a
> dual PIII w/ 2GB of EEC-Buffered-Registered.
>
> Now I have managed to use two hosts w/ 4 channels no caching controller,
> no hardware raid, 4 7200RPM drives and software raid 0.  I was able to
> push 109MB/sec writing and 167MB/sec reading.
>
> Also under a similar environment, I was able to, using a single card, 4
> drives, not hardware-raid, no caching controller, reach 90MB/sec writing
> and reading was about 78MB/sec.
>
> Now lets adjust cost of componets and SCSI loses big.
> Once there are 10K ATA drives in the market, and none exist that I know of
> to date even in beta, then we can retest .

And since here in the real world, where the set of all people not
including you lives, seek time dominates storage performance thus 15000RPM
disks are going to chew up and spit out 7200RPM disks.

It is very silly to compare a hardware RAID 0+1 to a software RAID 0,
since RAID 0+1 has to push twice as many bytes as RAID 0 to acheive the
same effect, and your software RAID 0 has a much more powerful CPU than
the i960 on your Mylex RAID controller.

-jwb

