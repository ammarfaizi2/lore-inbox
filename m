Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDSQhn>; Thu, 19 Apr 2001 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDSQhe>; Thu, 19 Apr 2001 12:37:34 -0400
Received: from ns0.petreley.net ([64.170.109.178]:58330 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S131323AbRDSQgY>;
	Thu, 19 Apr 2001 12:36:24 -0400
Date: Thu, 19 Apr 2001 09:36:09 -0700
From: Nicholas Petreley <nicholas@petreley.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: More ATA100 oddity
Message-ID: <20010419093609.A7170@petreley.com>
Mail-Followup-To: Nicholas Petreley <nicholas@petreley.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed something odd. (I'm using 2.4.3-ac9 on an
ASUS A7V, Athlon 1000 mHz)


(1) As noted in other messages, my machine boots up the Promise
chipset as UDMA(100)


hde: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63, UDMA(100)


(2) hdparm recognizes it as UDMA5 with 27 MB/sec speed


/dev/hde:
 
 Model=Maxtor 54098H8, FwRev=DAC10SC0, SerialNo=K80EP5NC Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16,MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes,LBAsects=80041248
 IORDY=on/off, tPIO={min:120,w/IORDY:120},tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 Timing buffered disk reads:  64 MB in  2.31 seconds = 27.71 MB/sec



(3) /proc/ide/pdc202xx sees it as UDMA 4



                                PDC20265 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 1
Interrupt Check Status Polling Delay : 2
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled
66 Clocking     enabled                          disabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0---------- drive1 ------
DMA enabled:    yes              no              no             no
DMA Mode:       UDMA 4           NOTSET          NOTSET         NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET        NOTSET



Oh, and by the way, ACPI support has never powered off this
machine.  Ever.  But I use apm and I'm happy. 


-Nick

-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
