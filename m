Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbRAVWVd>; Mon, 22 Jan 2001 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131145AbRAVWVP>; Mon, 22 Jan 2001 17:21:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130536AbRAVWUx>;
	Mon, 22 Jan 2001 17:20:53 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222139.f0MLd8r01730@flint.arm.linux.org.uk>
Subject: Re: Partition IDs in the New World TM
To: clausen@conectiva.com.br (Andrew Clausen)
Date: Mon, 22 Jan 2001 21:39:08 +0000 (GMT)
Cc: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A6C642E.2DF49CC0@conectiva.com.br> from "Andrew Clausen" at Jan 22, 2001 02:47:42 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen writes:
> But, for "well behaved operating systems", can't we do it this way?
> (For the dos partition table scheme, 0x83 could be our "file system
> type", 0x82 our "swap type", or whatever)

I think you're complaining about the partition IDs in this thread, and not
the partition "schemes" that Linux supports.  Am I right?

Well, the Linux kernel doesn't really care about partition IDs at all,
except in one circumstance - to detect auto RAID partitions.  Apart from
that, the kernel couldn't care.  You could set all your Ext2 partitions
as ID 82, your swap as ID 83 and Linux would carry on as if nothing had
changed.

About the only user programs that know about partition IDs are:
- fdisk (its part of the partition table format)
- installers (to stop users doing stupid things)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
