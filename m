Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135572AbRDSGYi>; Thu, 19 Apr 2001 02:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135573AbRDSGY1>; Thu, 19 Apr 2001 02:24:27 -0400
Received: from ns0.petreley.net ([64.170.109.178]:34518 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S135572AbRDSGYU>;
	Thu, 19 Apr 2001 02:24:20 -0400
Message-ID: <3ADE8491.6080402@petreley.com>
Date: Wed, 18 Apr 2001 23:24:17 -0700
From: Nicholas Petreley <nicholas@petreley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; 0.8) Gecko/20010322
X-Accept-Language: en
MIME-Version: 1.0
To: ignaciomonge@navegalia.com, linux-kernel@vger.kernel.org
Subject: Re: ATA 100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duh, mea stupida.  I misread your message.  You're trying to get 
the Promise IDE working at 100, no?  My Asus A7V133 has the 686b 
which does ATA100 without having to rely on the Promise chipset, 
and that seems to work fine. But if it helps to know, I've got an 
A7V with the 686a and I use the PDC20265 for my ATA100 drive. It 
boots with a message that says it's doing UDMA(100):

hde: 80041248 sectors (40981 MB) w/2048KiB Cache, 
CHS=79406/16/63, UDMA(100)

But /proc/ide/pdc202xx says:

                    PDC20265 Chipset.
--------------- drive0 ---------
DMA Mode:       UDMA 4

Shouldn't that be UDMA 5?

-Nick


I have the same motherboard, and it works fine for me.  Note the
80w cable detection.  Perhaps you've got a bad cable?

-Nick

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA       PIO
Address Setup:       30ns      30ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      30ns      30ns     270ns
Cycle Time:          20ns      20ns      60ns     600ns
Transfer Rate:  100.0MB/s 100.0MB/s  33.3MB/s   3.3MB/s


