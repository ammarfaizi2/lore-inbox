Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbRAJEGb>; Tue, 9 Jan 2001 23:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRAJEGV>; Tue, 9 Jan 2001 23:06:21 -0500
Received: from cs2732-110.austin.rr.com ([24.27.32.110]:3057 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131745AbRAJEGN>; Tue, 9 Jan 2001 23:06:13 -0500
Message-ID: <3A5B9C9F.2A698B60@flash.net>
Date: Tue, 09 Jan 2001 17:19:59 -0600
From: Rob Landley <landley@flash.net>
Organization: Boundaries Unlimited
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Learn from minix: fork ramfs.] - linus's ACTUAL reply.
Content-Type: multipart/mixed;
 boundary="------------6A930F49A903113D9FD201AC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A930F49A903113D9FD201AC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Okay, the sleep situation has not improved.  I'll admit that right now. 
But it's ABOUT to.  G'night...

Rob
--------------6A930F49A903113D9FD201AC
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from neon-gw.transmeta.com (neon-gw.transmeta.com [209.10.217.66])
	by ogopogo.flash.net (8.9.3/Pro-8.9.3) with ESMTP id VAA16747
	for <landley@flash.net>; Mon, 8 Jan 2001 21:03:34 -0600 (CST)
Received: (from root@localhost)
	by neon-gw.transmeta.com (8.9.3/8.9.3) id SAA05544;
	Mon, 8 Jan 2001 18:53:17 -0800
Received: from mailhost.transmeta.com(10.1.1.15) by neon-gw.transmeta.com via smap (V2.1)
	id xma005541; Mon, 8 Jan 01 18:53:02 -0800
Received: from penguin.transmeta.com (penguin.transmeta.com [10.1.2.202])
	by deepthought.transmeta.com (8.9.3/8.9.3) with ESMTP id TAA02684;
	Mon, 8 Jan 2001 19:03:06 -0800 (PST)
Received: from localhost (torvalds@localhost) by penguin.transmeta.com (8.9.3/8.7.3) with ESMTP id TAA01467; Mon, 8 Jan 2001 19:03:05 -0800
X-Authentication-Warning: penguin.transmeta.com: torvalds owned process doing -bs
Date: Mon, 8 Jan 2001 19:03:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@flash.net>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Learn from minix: fork ramfs.
In-Reply-To: <3A5A3756.3664B63A@flash.net>
Message-ID: <Pine.LNX.4.10.10101081900040.1371-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Mozilla-Status2: 00000000



On Mon, 8 Jan 2001, Rob Landley wrote:
> 
> So fork ramfs already.  Copy the snapshot you like as an educational
> tool, call it skeletonfs.c or some such, and let the current code evolve
> into something more useful.

The thing is, that I'm not sure that even the extended ramfs is really
useful except for very controlled environments (ie initrd-type things
where the contents of the ramdisk is _controlled_, and as such the
addition of limits is not necessarily all that useful a feature). Others
have spoken up on why tmpfs isn't a good thing either, with good
arguments.

So it's not all about teaching.

I think the ramfs limit code has a good argument from Alan for embedded
devices, so that probably will make it in. However, even so it's obviously
not a 2.4.1 issue, AND as shown by the fact that apparently the thing is
buggy and still worked on I wouldn't want the patches right now in the
first place.

		Linus



--------------6A930F49A903113D9FD201AC--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
