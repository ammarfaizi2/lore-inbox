Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293733AbSCKNmx>; Mon, 11 Mar 2002 08:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293735AbSCKNme>; Mon, 11 Mar 2002 08:42:34 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:43017 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S293733AbSCKNmb>;
	Mon, 11 Mar 2002 08:42:31 -0500
Mailbox-Line: From tmh@nothing-on.tv  Mon Mar 11 13:42:26 2002
Mailbox-Line: From tmh@nothing-on.tv  Mon Mar 11 13:42:18 2002
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: Dog slow IDE
Date: Mon, 11 Mar 2002 13:40:59 +0000
Organization: cvsnt.org news server
Message-ID: <3C8CB3EB.8070704@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sisko.my.home 1015854135 26226 192.168.2.3 (11 Mar 2002 13:42:15 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason the my IDE is running extremely slow (which accounts for 
why this box feels so sluggish).

hdparm gives:

/dev/hda:

  Model=Maxtor 53073U6, FwRev=DA6207V0, SerialNo=K607RFNC
  Config={ Fixed }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60030432
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 
ATA-4 ATA-5

/dev/hdb:

  Model=MAXTOR 4K040H2, FwRev=A08.1500, SerialNo=572124112782
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
  BuffType=DualPortCache, BuffSize=2000kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78198750
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=no WriteCache=enabled
  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 
ATA-4 ATA-5

Both drives claim to be using UDMA if I read the above correctly.

However:

/dev/hda:
  Timing buffered disk reads:  64 MB in 16.27 seconds =  3.93 MB/sec

/dev/hdb:
  Timing buffered disk reads:  64 MB in 32.99 seconds =  1.94 MB/sec

1.94MB/sec is *way* to slow for a UDMA5 hard disk surely?

Tony

