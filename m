Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSGYFdA>; Thu, 25 Jul 2002 01:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSGYFc7>; Thu, 25 Jul 2002 01:32:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49677 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318324AbSGYFcg>;
	Thu, 25 Jul 2002 01:32:36 -0400
Message-ID: <3D3F9012.B066A944@zip.com.au>
Date: Wed, 24 Jul 2002 22:43:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [IDE bug] hdparm lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.28, uniprocessor

00:0f.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

quad:/home/akpm> 0 hdparm -i /dev/hdc 

/dev/hdc:
 HDIO_GETGEO_BIG failed: Invalid argument
 (what's this?)

 Model=Maxtor 96147H6, FwRev=ZAH814Y0, SerialNo=V60JT12C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120064896
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 
 Kernel Drive Geometry LogicalCHS=7473/255/63

The command

	hdparm -d1 -A1 -m16 -u1 -a64 /dev/hdc

freezes the machine.
