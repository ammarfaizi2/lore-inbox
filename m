Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135576AbRDXReS>; Tue, 24 Apr 2001 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135595AbRDXReI>; Tue, 24 Apr 2001 13:34:08 -0400
Received: from [62.81.160.201] ([62.81.160.201]:54481 "EHLO smtp4.eresmas.com")
	by vger.kernel.org with ESMTP id <S135576AbRDXReA>;
	Tue, 24 Apr 2001 13:34:00 -0400
Date: Tue, 24 Apr 2001 19:19:41 -0400
From: Ignacio Monge <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PIO disk writes using 100% system time and performing poorly with VIA vt82c686b on kernels 2.2 & 2.4
Message-Id: <20010424191941.5e719746.ignaciomonge@navegalia.com>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi.
	I have  VIA686a too and a UDMA100 hard disk.
	This is my cat /proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xb800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        DMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns      90ns     330ns     330ns
Data Recovery:       30ns      30ns     270ns     270ns
Cycle Time:         120ns      60ns     600ns     600ns
Transfer Rate:   16.5MB/s  33.0MB/s   3.3MB/s   3.3MB/s


	As you can see, l use UDMA66 instead UDMA100. I don't know why. Maybe VIA vt82c686a doesn't support it? I have answering in this list a days ago about this problem. but none seems to have a question. Like you, my system goes down when I try to compile something (I have a 394 Mb of RAM and a 1 Ghz processor).
	Although, my hdparm output is this:
	/dev/hde2:
 Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
 Timing buffered disk reads:  64 MB in  2.44 seconds = 26.23 MB/sec
	and sometime looks better.

	I don't know is this is a problem with the VIA kernel driver or not. But the system doesn't seem to work fine since 2.4.2 or 2.4.1 kernel. I hope (plz!) this problem will be fixed in future.
	Luck.

	PS: in cat /proc/ide/via I see "Cable Type:                   40w                 40w"... Is it right? I have a 80w cable, not 40.

	
