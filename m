Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310111AbSCAAC4>; Thu, 28 Feb 2002 19:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310238AbSCAABI>; Thu, 28 Feb 2002 19:01:08 -0500
Received: from nobugconsulting.ro ([213.157.160.38]:30862 "EHLO
	mail.nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S310235AbSB1X6n>; Thu, 28 Feb 2002 18:58:43 -0500
Date: Fri, 1 Mar 2002 01:58:41 +0200 (EET)
From: lonely wolf <wolfy@pcnet.ro>
X-X-Sender: wolfy@nobugconsulting.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7EB3C2.5090401@bcgreen.com>
Message-ID: <Pine.LNX.4.44.0203010148360.922-100000@nobugconsulting.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Stephen Samuel wrote:

> Picking nits, perhaps -- but after giving us data on hdc,
> you did the test on hdd.  I realize you said that it is identical
> for both, but if you missed something critical, we'll never see it.
they are 100% identical. except for the fact that one is 
master and the other slave on the same cable.
I did not include the results for both in order to shorten the message.
here we go, just in case:

[root@bugmaster /root]# /sbin/hdparm -tT /dev/hdc /dev/hdd;/sbin/hdparm  
/dev/hdc /dev/hdd;/sbin/hdparm -i /dev/hdc /dev/hdd

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  1.17 seconds =109.40 MB/sec
 Timing buffered disk reads:  64 MB in  3.01 seconds = 21.26 MB/sec

/dev/hdd:
 Timing buffer-cache reads:   128 MB in  1.09 seconds =117.43 MB/sec
 Timing buffered disk reads:  64 MB in  2.96 seconds = 21.62 MB/sec

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 23989/16/63, sectors = 156301488, start = 0

/dev/hdd:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 23989/16/63, sectors = 156301488, start = 0

/dev/hdc:

 Model=ST380021A, FwRev=3.05, SerialNo=3HV080KH
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

/dev/hdd:

 Model=ST380021A, FwRev=3.05, SerialNo=3HV07SDN
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


Mr Davidovac Zoran mentioned normal transfer speeds with kernel 2.4.17.  
Should I try ? Are there significant differences between 2.4.9-21 (or -31)
and 2.4.17 in the IDE drivers ?



- 
This is Linux Country. On a quiet night, you can hear
Windows NT reboot!



