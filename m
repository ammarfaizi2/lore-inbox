Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbSKPQR3>; Sat, 16 Nov 2002 11:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267304AbSKPQR3>; Sat, 16 Nov 2002 11:17:29 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:17351 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267303AbSKPQR1> convert rfc822-to-8bit; Sat, 16 Nov 2002 11:17:27 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sat, 16 Nov 2002 17:24:17 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211161657.51357.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

I've applied your patch to 2.4.19 final and 2.4.20 final and those "pausings" 
still exists when I do a full kernel tree copy with "cp -a linux-2.4.19 
linux-2.4.20". When I am in a screen session and try to do a Ctrl-A-C to 
create a new screen session it comes up within 3-5 seconds ... If I want to 
switch to another session with Ctrl-A-N it sometimes happens fast and 
sometimes within 3-5 seconds ... I've put above in a "while true; do ...; 
done" loop. There is nothing else running or eating CPU and also nothing else 
eating i/o. This does not happen with virgin 2.4.18.

This is with a Celeron Tualatin 1300MHz, i815 chipset, 512MB RAM, UDMA100 HDD, 
DMA enabled.


/dev/hda:

 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 7299/255/63, sectors = 117266688, start = 0

 Model=MAXTOR 6L060J3, FwRev=A93.0500, SerialNo=663219752652
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117266688
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5

Does also appear if unmaskirq is set to 1.

ciao, Marc

