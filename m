Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130117AbQLYHc6>; Mon, 25 Dec 2000 02:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbQLYHcs>; Mon, 25 Dec 2000 02:32:48 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:1040 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S130117AbQLYHcl>; Mon, 25 Dec 2000 02:32:41 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200012250702.XAA01122@cx518206-b.irvn1.occa.home.com>
Subject: Re: Proposal: devfs names ending in %d or %u
To: radoni@crosswinds.net
Date: Sun, 24 Dec 2000 23:02:39 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <E14AQT2-0001ud-00@dfw-mmp2.email.verio.net> from "Eric Shattow" at Dec 24, 2000 11:46:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Shattow wrote:
[snip]
> when i insert a FAT formatted disc with a PC partition table, the partition
> i want to mount is part1.  when i insert a HFS formatted disc with a MAC
> partition table, the partition i want to mount is part4. this is very ugly,

and it has nothing to do with devfs. Those would be /dev/sda1 (adjust
device name for IDE instead of SCSI, etc.) and /dev/sda4 without devfs.

In this case, the problem is that different Zip disks really do have their
data on different partitions. (If you use enough different disks and
formatting utilities, it won't even be the same partition for all PC disks
or all Mac disks, IIRC.) I don't use Zip disks much anymore, although
there's a similar phenomenon with my SCSI MO drive on my desktop Mac
(which I recently started using Linux on again).

What would be nice is if there were a way of saying, "here's the disk,
mount the Right Partition(tm) in /mnt/whatever." For all I know, maybe
someone's done that already. If not, it seems to me that a userspace
utility (== no extra kernel bloat) could parse the partition table and use
some heuristics or something to pick the partition to mount. (I'm probably
going to do other stuff instead of implementing this, but I haven't
decided for sure yet.) In any case, I think the solution would be
completely orthogonal to devfs...

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
