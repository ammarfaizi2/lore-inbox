Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbQLFWdd>; Wed, 6 Dec 2000 17:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFWdX>; Wed, 6 Dec 2000 17:33:23 -0500
Received: from ruddock-207.caltech.edu ([131.215.90.207]:64260 "EHLO
	agard.caltech.edu") by vger.kernel.org with ESMTP
	id <S131063AbQLFWdL>; Wed, 6 Dec 2000 17:33:11 -0500
Message-ID: <3A2EB765.62FEF645@its.caltech.edu>
Date: Wed, 06 Dec 2000 14:02:13 -0800
From: James Lamanna <jlamanna@its.caltech.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with PDC202xx driver
In-Reply-To: <Pine.LNX.4.10.10012061327260.23184-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an excerpt from /proc/pci:

Bus  0, device  11, function  0:
    RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x9400 [0x9407].
      I/O at 0x9000 [0x9003].
      I/O at 0x8800 [0x8807].
      I/O at 0x8400 [0x8403].
      I/O at 0x8000 [0x803f].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd501ffff].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev
2).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0x7800 [0x7807].
      I/O at 0x7400 [0x7403].
      I/O at 0x7000 [0x7007].
      I/O at 0x6800 [0x6803].
      I/O at 0x6400 [0x643f].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd481ffff].

> Now if you have a device that reports it storage class as RAID then it may
> misbehave.  Otherwise, if it is reporting "Unknown Mass Storage" then you
> have an Ultra/ATA controller.

It would seem that it reports itself as both.

> 
> There are two different BIOS cores for each design.
> Linux cleanly supports the BIOS cores know as "Ultra" and not the ones
> know as "Fasttrak".

Is there a plan to support the Fasttrak BIOS core at some point (I
hope..)
So I guess I'm stuck with loading their proprietary module whenever I
want 
to use the drive....

But thanks for the clarification.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
