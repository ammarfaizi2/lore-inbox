Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155317AbPFWM0g>; Wed, 23 Jun 1999 08:26:36 -0400
Received: by vger.rutgers.edu id <S155281AbPFWMYv>; Wed, 23 Jun 1999 08:24:51 -0400
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:14434 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S155161AbPFWMWJ>; Wed, 23 Jun 1999 08:22:09 -0400
Subject: The file system corruption bug (Summary)
To: linux-kernel@vger.rutgers.edu
Date: Wed, 23 Jun 1999 13:20:57 +0100 (BST)
Content-Type: text
Message-Id: <E10wm1T-0008P3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

Ok this is the distilled info so far

2.2.7 -> 2.2.9 broke a small number of systems. I can't tell if 2.2.8 was
a problem or not. 2.2.8 had enough other problems nobody ran it.

The reports of 2.2.7 worked 2.2.9/10 blow up all fall into the following
categories

o	Block numbers off the end of the disk
o	Reports of incorrect bitmaps
o	Bizarre C compiler error reports

With the cases I followed up on, hitting the reset button after such odd
reports generally made them vanish. That is the corruption was in memory
not on media. Unlike the other noise reports there is a consistent "2.2.7 OK
2.2.9 fails" message.

It doesn't matter what platform  - PMac (actually this is the worst hit) 
Mips x86 all have reports. IDE and SCSI seem affected.

The most bizarre part of the whole matter is that a given machine will almost
always be affected by the same variant of the problem not a mix.

Lower memory machines seem most likely to trip it.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
