Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSLWMb3>; Mon, 23 Dec 2002 07:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLWMb3>; Mon, 23 Dec 2002 07:31:29 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:59855 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264799AbSLWMb2> convert rfc822-to-8bit; Mon, 23 Dec 2002 07:31:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Date: Mon, 23 Dec 2002 13:39:02 +0100
User-Agent: KMail/1.4.3
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>
References: <200212221439.28075.m.c.p@wolk-project.de> <20021223120349.GJ12643@louise.pinerecords.com>
In-Reply-To: <20021223120349.GJ12643@louise.pinerecords.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212231339.03019.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 December 2002 13:03, Tomas Szepe wrote:

Hi Tomas,

> > 2.4.18
> > 2147483648 bytes transferred in 119.140681 seconds (18024772 bytes/sec)
> >
> > 2.4.19
> > 2147483648 bytes transferred in 140.305836 seconds (15305733 bytes/sec)
>
> Well I'm getting the numbers the other way round. <g>
lol, strange.

root@codeman:[/] # egrep 'model name|MHz' /proc/cpuinfo
model name      : Intel(R) Celeron(TM) CPU                1300MHz
cpu MHz         : 1295.718

root@codeman:[/] # grep MemTotal /proc/meminfo
MemTotal:          515056 kB

root@codeman:[/proc/ide] # egrep 'Intel|UDMA enabled' /proc/ide/piix 
                                Intel PIIX4 Ultra 100 Chipset.
UDMA enabled:   yes              no              no                no 
UDMA enabled:   5                X               X                 X

root@codeman:[/] # hdparm -i /dev/hda

/dev/hda:

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

ciao, Marc
