Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLBBBK>; Fri, 1 Dec 2000 20:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLBBBA>; Fri, 1 Dec 2000 20:01:00 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:34448 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129319AbQLBBAu>; Fri, 1 Dec 2000 20:00:50 -0500
From: kumon@flab.fujitsu.co.jp
Date: Sat, 2 Dec 2000 09:30:09 +0900
Message-Id: <200012020030.JAA17290@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <3A283409.C6DEFDB9@uow.edu.au>
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk>
	<Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu>
	<3A26C82D.26267202@uow.edu.au>
	<20001201141659.A4562@redhat.com>
	<3A283409.C6DEFDB9@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Andrew Morton writes:
 > - I then killed everything with ALT-SYSRQ-T.  It's been 20 minutes
 >   now and the disk LED is *still* hard on.  This machine has 256 megs
 >   and the hdparm disk bandwidth is 20 megs/sec.
 > 
 > You can observe the latter problem pretty easily by running `misc001' on
 > its own.  Kill it after 20 seconds and the disk remains active for *ages*.
 > Usually ninety seconds.  Long enough to write all physical memory out
 > ten times...

If the benchmark writes blocks completely random, the random writing
performance should be used instead of the bandwidth.  It is tipically
30blk/s to 200blk/s depends on the seek speed.

90 second writing corresponds to 10MB to 72MB dirty buffer
(4K fs block), it is not so crazy.  But 30 minutes is still
too long on 256MB physical memory.

I think they are different, aren't they?

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
