Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAONlk>; Mon, 15 Jan 2001 08:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAONla>; Mon, 15 Jan 2001 08:41:30 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:57093 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129867AbRAONlK>; Mon, 15 Jan 2001 08:41:10 -0500
Date: Mon, 15 Jan 2001 15:40:53 +0200 (EET)
From: Heikki Lindholm <holindho@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Total loss with 2.4.0 (release)
Message-ID: <Pine.GSO.4.20.0101151517590.26077-100000@famine.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I managed to kill my dear files and if anyone can help I'd be very
thankful. The events leading to this were something like:
Happy system with 2.4.0-test9 -> update to 2.4.0 (release) -> works
nicely; no complaints of any kind (no crc errors or dma-disabling) ->
reboot -> play Diablo II for some time (win98) -> restart linux ->
VFS: cannot mount root. 
I have two ext2 partitions plus root and one of them is on another disk
(same ide lead, however) and it survived with no errors.

When I ran e2fsck (1.18) on root partition, in addition to having to
run it many times before succeeding (segfaulted sometimes), nothing was
left in the partition except lost+found with lots of
files. Valid superblock wasn't found at 0, but at 8193.

I really don't get what would have caused this or how to cure it. I still
have my /home in need of repairing, but I won't be running fsck on it with
this good expectancy-of-recovery (I actually tried once with a backup on
another disk and it resulted two VERY old directoried, everything else was
lost...and found(?)).

I also updated my machine from VIA MVP3 based K6II to VIA KT133 (with 868B
southbridge - ATA100, that is) based Duron, but linux (2.4.0-test9) worked
fine with both configurations. I think this might be some sort of DMA
problem.  

I read from kernel notes that ac1 fixes root umount handling. Might that
be connected with the symptoms I had? If anyone has any suggestions,
please post them. I would, at least, like to know how could I verify if
the filesystem is really messed (for example, overwritten with something
at the bus at the time) or if it's just some minor issue that confuses
fsck totally.

-- Heikki Lindholm

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
