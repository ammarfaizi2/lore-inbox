Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313617AbSDHNWz>; Mon, 8 Apr 2002 09:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313618AbSDHNWy>; Mon, 8 Apr 2002 09:22:54 -0400
Received: from [209.202.134.86] ([209.202.134.86]:5395 "EHLO
	cpemail1.silverbacktech.com") by vger.kernel.org with ESMTP
	id <S313617AbSDHNWx>; Mon, 8 Apr 2002 09:22:53 -0400
Message-ID: <E7D41DF26971D51197F100B0D020EFF856076C@kashmir.silverbacktech.com>
From: Noah White <nwhite@silverbacktech.com>
To: linux-kernel@vger.kernel.org
Subject: badblocks, sector/bit copies and other musings
Date: Mon, 8 Apr 2002 09:19:53 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

I had some general questions regarding how the kernel/fs handle bad blocks
and such and how that relates to various copying techniques such as Norton
Ghost, hardware disk duplicators (the old octopus's) and such.

Specifically, I'm curious as to how the following situation is handled. If I
have:

drive A which is say a 30 GB IDE drive which I've built in a standard
fashion with the 2.2.12-20 kernel and created two ext-2 partitions and one
swap partition

drive b which is also the same model 30 GB IDE drive which is empty and has
no file system on it OR has a windows file system (FAT or NTFS) 

Now in the case of copying drive A onto drive B using a sector or bit copy
technique and I:

1) Use Ghost with sector copy mode OR
2) Use a hardware harness which does a straight bit copy of the drive (and
is non-file system aware)

How will the bad blocks be mapped? From the file system perspective will
drive B think its bad blocks are the same as drive A thus setting drive B up
for possible errors because its bad block mappings are incorrect?

This leads to my ultimate question which is what is the safest and fastest
way to dup a linux/ext-2 drive? 

Thanks in advance,

-Noah

