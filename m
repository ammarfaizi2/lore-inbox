Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAIB0r>; Mon, 8 Jan 2001 20:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRAIB0X>; Mon, 8 Jan 2001 20:26:23 -0500
Received: from linuxcare.com.au ([203.29.91.49]:2055 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129324AbRAIB0N>; Mon, 8 Jan 2001 20:26:13 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode 
In-Reply-To: Your message of "Mon, 08 Jan 2001 09:37:03 PDT."
             <Pine.LNX.4.10.10101080930410.3750-100000@penguin.transmeta.com> 
Date: Tue, 09 Jan 2001 12:25:58 +1100
Message-Id: <E14FnXz-0000oy-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.10.10101080930410.3750-100000@penguin.transmeta.com> you
 write:
> I've been thinking of doing a cramfs2, and the only thing I'd change is
> (a) slightly bigger blocksize (maybe 8k or 16k) and (b) re-order the
> meta-data and the real data so that I could easily compress the metadata
> too. cramfs doesn't have any traditional meta-data (no bitmap blocks or
> anything like that), but it wouldn't be that hard to put the directory
> structure in the page cache and just compress the directories the same way
> the real data is compressed.

And you'd still be worse than compressed loopback w/32k blocks, and
more complex.  Now most of the loopback bugs seem fixed in 2.4, I'll
port the cloop stuff, and we can compare.

Time to stop this cramfs madness!
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
