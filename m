Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbSI1LCc>; Sat, 28 Sep 2002 07:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261187AbSI1LCb>; Sat, 28 Sep 2002 07:02:31 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:2432 "EHLO zigo.dhs.org")
	by vger.kernel.org with ESMTP id <S261158AbSI1LCb>;
	Sat, 28 Sep 2002 07:02:31 -0400
Date: Sat, 28 Sep 2002 13:07:51 +0200 (CEST)
From: =?ISO-8859-1?Q?Dennis_Bj=F6rklund?= <db@zigo.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: detect udma66 cable (vt82c686a)
Message-ID: <Pine.LNX.4.44.0209281253240.1342-100000@zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get my Gigabyte 7ZX-1 to detect my udma66 cable. It is a brand new 
ata66/100 cable so I believe that the cable is not the problem.

As seen from /proc/ide/via below it thinks my cable is a 40w (on id0 I do 
have a 40w so that is correct, but in ide1 there is a 80w).

I've also tried to boot with ide1=ata66 and then it says that the transfer
rate is 66.0MB/s, but it still detects the cable as 40w. hdparam -t gave
bigger values when booting with ata66 so something changes to the better.
But I would prefer if it was autodetected and to know why it does not
work in the first place. Also I don't know what bad can come from forcing 
it to ata66.

The computer is a redhat 7.3 with kernel 2.4.18-4

After searching the archives and finding others with similar problems I
really thought that booting with ata66 was going to make it detect my
cable, but no. Or maybe it does work correctly when forced even though it 
still says 40w?

Any help is appreciated!

# cat /proc/ide/via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xffa0
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns      60ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s

-- 
/Dennis

