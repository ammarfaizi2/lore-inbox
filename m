Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSGCQet>; Wed, 3 Jul 2002 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSGCQes>; Wed, 3 Jul 2002 12:34:48 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:64221 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317072AbSGCQer>; Wed, 3 Jul 2002 12:34:47 -0400
Date: Wed, 3 Jul 2002 12:42:14 -0400
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703164214.GB5689@lnuxlab.ath.cx>
References: <20020703094031.GA4462@lnuxlab.ath.cx> <Pine.LNX.4.33.0207031155080.7491-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207031155080.7491-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 11:56:46AM -0400, Mark Hahn wrote:
> ugh, this is very old, back in the 10G/platter days.
> considering that 60G/platter ship now, and all new disks
> are 30-40G/platter.
> 
> out of curiosity, what does hdparm say about the low-level speed
> of this disk?

* hdparm -Tt /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.73 seconds =175.34 MB/sec
 Timing buffered disk reads:  64 MB in  2.22 seconds = 28.83 MB/sec

* hdparm /dev/hda
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1868/255/63, sectors = 30015216, start = 0
 busstate     =  1 (on)

* hdparm -i /dev/hda
/dev/hda:

 Model=Maxtor 51536U3, FwRev=DA6207V0, SerialNo=K304R35C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=30015216
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
