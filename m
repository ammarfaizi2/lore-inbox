Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130865AbRASVB6>; Fri, 19 Jan 2001 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRASVBr>; Fri, 19 Jan 2001 16:01:47 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:16448 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S130865AbRASVB2>;
	Fri, 19 Jan 2001 16:01:28 -0500
Message-ID: <3A68AAEC.7@valinux.com>
Date: Fri, 19 Jan 2001 14:00:28 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang
In-Reply-To: <200101191756.f0JHuns30179@aslan.scsiguy.com> <3A6881F9.17F7B9F6@mailhost.cs.rose-hulman.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> There is also a known issue with U160 modes and the currently
>> embedded aic7xxx driver.  
> 
> 
> That's true the problem is the TCQ command seems to be sequencing wrong.
> 
> 
>> You might want to try the Adaptec
>> supported driver from here:
>> 
>> http://people.FreeBSD.org/~gibbs/linux/
>> 
>> 6.09 BETA should be released later today.

Just a little FYI, I wanted to point out that 6.08 BETA fixed a problem 
I've been having since the 2.4.0-test series on a machine with the 
following adaptec integrated controller:
   Bus  4, device   7, function  0:
     SCSI storage controller: Adaptec 7899P (rev 1).
       IRQ 19.
       Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
       I/O at 0x5000 [0x50ff].
       Non-prefetchable 64 bit memory at 0xf7e00000 [0xf7e00fff].
   Bus  4, device   7, function  1:
     SCSI storage controller: Adaptec 7899P (#2) (rev 1).
       IRQ 16.
       Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
       I/O at 0x5400 [0x54ff].
       Non-prefetchable 64 bit memory at 0xf7f00000 [0xf7f00fff].

This is an Ultra160 controller I believe (or at least thats what it says 
during bootup.)

Before I applied this patch it would print garbage for the 
Vendor/Rev/Type/ANSI SCSI revision of my hard disk.  With this patch it 
does not.

I unfortunately know very little about SCSI drivers, so I can't say 
exactly what causes this problem with the stock 2.4.0 adaptec driver.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
