Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268834AbRHKULB>; Sat, 11 Aug 2001 16:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRHKUKv>; Sat, 11 Aug 2001 16:10:51 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:6411 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S268834AbRHKUKa>;
	Sat, 11 Aug 2001 16:10:30 -0400
Date: Sat, 11 Aug 2001 13:10:40 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Large ramdisk crashes 2.4.8
Message-ID: <Pine.LNX.4.33.0108111309170.19041-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A large ramdisk will either crash or make useless a
2.4.8 kernel.  I did the following.

I cleared out buffered memory by running this till it
appropiately died.
perl -e "$x='x' x 10000 while 1"

top then said I was using 7 megs of ram on my 128 meg box.

I then did

mke2fs /dev/ram0 70000
mount /dev/ram0 /mnt
dd if=/dev/zero of=/mnt/junk bs=1024000 count=100

Usually at this point my system was not totally crashed but may as well
have been.  I could usually ping the box.  I could sometimes switch
virtual consoles though I couldn't log in.  I could press keys and they
would display on the console.  That's about it.  Once I got a kernel
panic. I also tried allocating 500 megs on a 1 gig box I have available
to me with similar results.

I reported similar problems with 2.4.[4-7] though the symptoms were
a little different.  At this point I've consigned myself to wasting
2/3 of my memory.  I won't report further on this issue unless someone
is interested.


