Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131070AbQLCTw6>; Sun, 3 Dec 2000 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131100AbQLCTws>; Sun, 3 Dec 2000 14:52:48 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:52114 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S131070AbQLCTwf>;
	Sun, 3 Dec 2000 14:52:35 -0500
Date: Sun, 3 Dec 2000 14:21:47 -0500
Message-Id: <200012031921.OAA17544@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: "Saber Taylor" <aquabrake@hotmail.com>
CC: linux-kernel@vger.kernel.org
In-Reply-To: Saber Taylor's message of Sun, 03 Dec 2000 05:59:47 -0000,
	<F231OceuLyR1mDxJr5D0000c3f6@hotmail.com>
Subject: Re: lost dirs after fsck-1.18 (kt133, ide, dma, test10, test11)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Saber Taylor" <aquabrake@hotmail.com>
   Date: 	Sun, 03 Dec 2000 05:59:47 -0000

   Well that's the last time I run a devel kernel with a nontest
   system.  sigh.

   Had one directory replaced with a different directory
   and also a directory replaced with a file. Possible further
   corruption.

   I don't think I lost the directories until I did a 'fsck -y'
   on the partition. Something to remember.

If it was just the directories that got lost, the files should have
been reparented to the /lost+found directory for that filesystrem.  If
however the bug wiped out part of your inode table, then you would have
probably lost both the directory and the files in that directory, since
directories and files tend to be stored in the same block group.

   If anyone has advice on recovering the directories other than
   the following links, I'm all ears:

Without more details about how the corruption happened or what the
nature of the corruption is, it's hard to give good general advice.
Those websites aren't bad places to start.  Good luck.....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
