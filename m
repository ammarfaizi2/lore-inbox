Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292234AbSCAC3W>; Thu, 28 Feb 2002 21:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310328AbSCAC1d>; Thu, 28 Feb 2002 21:27:33 -0500
Received: from nobugconsulting.ro ([213.157.160.38]:46734 "EHLO
	mail.nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S310323AbSCACZl>; Thu, 28 Feb 2002 21:25:41 -0500
Message-ID: <3C7EE6A3.FF431772@pcnet.ro>
Date: Fri, 01 Mar 2002 04:25:39 +0200
From: lonely wolf <wolfy@pcnet.ro>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <E16gDmU-0006PG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Moore
>Please post dmesg, /proc/pci and chipset info from /proc/ide. Also,
>what is result from 'hdparm -tT /dev/hda'?

From: Andre Hedrick
>What is more useful is the cat /proc/ide/ide0/config !!!


[root@bugmaster /root]# cat /proc/ide/ide0/config
pci bus 00 device f9 vid 8086 did 244b channel 0
86 80 4b 24 05 00 80 02 11 80 01 01 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 4d 42
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
07 a3 77 e3 38 00 00 00 0d 00 02 33 00 00 00 00
00 00 00 00 5d 04 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 4d 04 00 00 00 00 00 00

[root@bugmaster /root]# cat /proc/ide/ide1/config
pci bus 00 device f9 vid 8086 did 244b channel 1
86 80 4b 24 05 00 80 02 11 80 01 01 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 4d 42
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
07 a3 77 e3 38 00 00 00 0d 00 02 33 00 00 00 00
00 00 00 00 5d 04 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 4d 04 00 00 00 00 00 00

[root@bugmaster /root]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 8086:1130 (Intel Corporation) (rev 4).
  Bus  0, device   2, function  0:
    VGA compatible controller: PCI device 8086:1132 (Intel Corporation) (rev 4).

      IRQ 11.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Non-prefetchable 32 bit memory at 0xffa80000 [0xffafffff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corporation 82801BAM PCI (rev 17).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 17).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corporation 82801BA IDE U100 (rev 17).
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 17).
      IRQ 10.
      I/O at 0xef40 [0xef5f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corporation 82801BA(M) SMBus (rev 17).
      IRQ 9.
      I/O at 0xefa0 [0xefaf].
  Bus  0, device  31, function  4:
    USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 17).
      IRQ 6.
      I/O at 0xef80 [0xef9f].
  Bus  1, device   8, function  0:
    Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 3).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xff8ff000 [0xff8fffff].
      I/O at 0xdf00 [0xdf3f].

[root@bugmaster /root]# cat /proc/ide/drivers
ide-floppy version 0.98
ide-disk version 1.11

[root@bugmaster /root]# cat /proc/ide/piix

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               yes
UDMA enabled:   yes              no              yes               yes
UDMA enabled:   4                X               4                 4
UDMA
DMA
PIO

[root@bugmaster /root]# /sbin/hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.10 seconds =116.36 MB/sec
 Timing buffered disk reads:  64 MB in  3.73 seconds = 17.16 MB/sec
[root@bugmaster /root]# /sbin/hdparm -tT /dev/hda;/sbin/hdparm -i /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.11 seconds =115.32 MB/sec
 Timing buffered disk reads:  64 MB in  3.48 seconds = 18.39 MB/sec

/dev/hda:

 Model=QUANTUM FIREBALLlct15 07, FwRev=A01.0F00, SerialNo=611025994167
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=15522/15/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
 CurCHS=15522/15/63, CurSects=-771620641, LBA=yes, LBAsects=14668290
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4



