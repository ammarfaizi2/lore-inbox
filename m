Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265129AbTL2XGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTL2XGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:06:42 -0500
Received: from [24.35.117.106] ([24.35.117.106]:65161 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265129AbTL2XFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:05:09 -0500
Date: Mon, 29 Dec 2003 18:05:03 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Mon, 29 Dec 2003, Thomas Molina wrote:
> >
> > I just finished a couple of comparisons between 2.4 and 2.6 which seem to 
> > confirm my impressions.  I understand that the comparison may not be 
> > apples to apples and my methods of testing may not be rigorous, but here 
> > it is.  In contrast to some recent discussions on this list, this test is 
> > a "real world" test at which 2.6 comes off much worse than 2.4.  
> 
> Are you sure you have DMA enabled on your laptop disk? Your 2.6.x system 
> times are very high - much bigger than the user times. That sounds like 
> PIO to me.


Sorry.  One other bit of data from 2.6:

[root@lap bitkeeper]# hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DJSA-220, FwRev=JS4OAC3A, SerialNo=44V44FT3300
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=39070080
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

 * signifies the current active mode


