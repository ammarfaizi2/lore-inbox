Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131952AbRBNLdW>; Wed, 14 Feb 2001 06:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131957AbRBNLdM>; Wed, 14 Feb 2001 06:33:12 -0500
Received: from pptp2.speedcast.com ([202.174.129.5]:64784 "EHLO ns.kriljon.ru")
	by vger.kernel.org with ESMTP id <S131952AbRBNLc4>;
	Wed, 14 Feb 2001 06:32:56 -0500
Message-Id: <200102141229.f1ECSwh21119@ns.kriljon.ru>
Date: Wed, 14 Feb 2001 21:28:09 +0000
From: Eugene Danilchenko <eugene@kriljon.ru>
To: Ashwin D <ashwinds@yahoo.com> (by way of Ashwin D
	<ashwinds@yahoo.com>)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.4.x??
In-Reply-To: <01021409381901.00688@localhost.localdomain>
In-Reply-To: <01021409381901.00688@localhost.localdomain>
X-Mailer: stuphead version 0.5.0 (GTK+ 1.2.8; Linux 2.4.1; i686)
Organization: Kriljon
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

the same behavior I have :

[root@localhost eugene]# uname -a
Linux localhost.localdomain 2.4.1 #1 ðÎÄ æÅ× 12 23:19:20 /etc/localtime 2001 i686 unknown
[root@localhost eugene]# hdparm -i /dev/hdb
 
/dev/hdb:
 
 Model=ST38410A, FwRev=3.32, SerialNo=7EG23EXT
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=512kB, MaxMultSect=32, MultSect=32
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16841664
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
[root@localhost eugene]# hdparm  /dev/hdb
 
/dev/hdb:
 multcount    = 32 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1048/255/63, sectors = 16841664, start = 0
[root@localhost eugene]# hdparm  -t /dev/hdb
 
/dev/hdb:
 Timing buffered disk reads:  64 MB in  8.00 seconds =  8.00 MB/sec                                                      


On Wed, 14 Feb 2001 09:38:18 +0530
Ashwin D <ashwinds@yahoo.com> (by way of Ashwin D <ashwinds@yahoo.com>) wrote:

ADAYCBWOAD> Hi
ADAYCBWOAD> 
ADAYCBWOAD> Well, it may not be a bug, but it sure is bugging me - i have been on this 
ADAYCBWOAD> for more than a week. Well, here goes; 
ADAYCBWOAD> 
ADAYCBWOAD> Why is it that my DMA performance under the kernel 2.4.x is worse than the
ADAYCBWOAD> one under 2.2? I have attached the stats below the mail- information and test
ADAYCBWOAD> results under both kernels.
ADAYCBWOAD> 
ADAYCBWOAD> I use the following option under rc.local to set dma ;
ADAYCBWOAD>          /sbin/hdparm -c1 -d1 -m16 -X66 /dev/hda
ADAYCBWOAD> 
ADAYCBWOAD> I use resierfs, Iam disappointed that 2.4 results are about 1/3rd and need to
ADAYCBWOAD> know what to do.
ADAYCBWOAD> 
ADAYCBWOAD> I use a i810 mobo and seagate 8.4 gb hdd
ADAYCBWOAD> 
ADAYCBWOAD> I have tried recompiling the kernel - iam informed a broken .config could 
ADAYCBWOAD> have caused this, but no change. 
ADAYCBWOAD> I have tried random settings with hdparm to tune /dev/hda.
ADAYCBWOAD> 
ADAYCBWOAD> Thanks for your time.
ADAYCBWOAD> Ashwin
ADAYCBWOAD> (Iam not on the list yet, so please cc me personally) 
ADAYCBWOAD> 
ADAYCBWOAD> -------------------------
ADAYCBWOAD> TEST RESULTS
ADAYCBWOAD> ___________________________
ADAYCBWOAD> 
ADAYCBWOAD> a) Kernel 2.2.17 (mandrake)
ADAYCBWOAD> 
ADAYCBWOAD> (i) hdpartm -i:
ADAYCBWOAD> /dev/hda:
ADAYCBWOAD> 
ADAYCBWOAD>  Model=ST38420A, FwRev=3.07, SerialNo=7AZ0PTZT
ADAYCBWOAD>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
ADAYCBWOAD>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
ADAYCBWOAD>  BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
ADAYCBWOAD>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16841664
ADAYCBWOAD>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
ADAYCBWOAD>  PIO modes: pio0 pio1 pio2 pio3 pio4
ADAYCBWOAD>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
ADAYCBWOAD> 
ADAYCBWOAD> (ii) hdpartm -t:
ADAYCBWOAD> /dev/hda:
ADAYCBWOAD>  Timing buffered disk reads:  64 MB in  4.38 seconds = 14.61 MB/sec
ADAYCBWOAD> 
ADAYCBWOAD> 
ADAYCBWOAD> b) Kernel 2.4.1 (linux )
ADAYCBWOAD> 
ADAYCBWOAD> (i) hdparm -i
ADAYCBWOAD> /dev/hda:
ADAYCBWOAD> 
ADAYCBWOAD>  Model=ST38420A, FwRev=3.07, SerialNo=7AZ0PTZT
ADAYCBWOAD>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
ADAYCBWOAD>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
ADAYCBWOAD>  BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
ADAYCBWOAD>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16841664
ADAYCBWOAD>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
ADAYCBWOAD>  PIO modes: pio0 pio1 pio2 pio3 pio4
ADAYCBWOAD>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
ADAYCBWOAD> 
ADAYCBWOAD> (ii) hdparm -t
ADAYCBWOAD> 
ADAYCBWOAD> /dev/hda:
ADAYCBWOAD>  Timing buffered disk reads:  64 MB in 11.61 seconds =  5.51 MB/sec
ADAYCBWOAD> -
ADAYCBWOAD> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
ADAYCBWOAD> the body of a message to majordomo@vger.kernel.org
ADAYCBWOAD> More majordomo info at  http://vger.kernel.org/majordomo-info.html
ADAYCBWOAD> Please read the FAQ at  http://www.tux.org/lkml/

--
