Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132943AbRAVWqn>; Mon, 22 Jan 2001 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRAVWqe>; Mon, 22 Jan 2001 17:46:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5136 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130794AbRAVWqV>;
	Mon, 22 Jan 2001 17:46:21 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222242.WAA00893@raistlin.arm.linux.org.uk>
Subject: Re: Partition IDs in the New World TM
To: clausen@conectiva.com.br (Andrew Clausen)
Date: Mon, 22 Jan 2001 22:42:06 +0000 (GMT)
Cc: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A6CB49E.75B8937D@conectiva.com.br> from "Andrew Clausen" at Jan 22, 2001 08:30:54 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen writes:
> Why is this necessary?  Can't the RAID drivers probe the device for
> signatures, the same way file systems do?

One possible problem I can see here is to do with removal of RAID.  Think
of a RAID-1 array (2 or more disks containing identical data).  The
partition can be validly identified as an ext2 filesystem.  But wait, it
has a RAID superblock at the end.

How do we know if this superblock is current or not?  After all, a mke2fs
on the device won't remove it.  Yes, you could fill the partition with
zeros and start again, or you could just change the partition ID.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
