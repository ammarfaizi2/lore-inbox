Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSBJBm5>; Sat, 9 Feb 2002 20:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSBJBmr>; Sat, 9 Feb 2002 20:42:47 -0500
Received: from iggy.triode.net.au ([203.63.235.1]:20690 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S289167AbSBJBmj>; Sat, 9 Feb 2002 20:42:39 -0500
Date: Sun, 10 Feb 2002 12:42:07 +1100
From: Linux Kernel Mailing List <kernel@iggy.triode.net.au>
To: linux-kernel@vger.kernel.org
Subject: ALI 15X3 DMA Freeze
Message-ID: <20020210124207.C5191@iggy.triode.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.4.18-pre9, which has a problem when I switch DMA on 
the IDE hard drive. With DMA enabled, I cannot complete a kernel
compile without the machine locking up. The motherboard is an
ASUS board, with 512MB of DDR RAM and an Athlon 1800 XP. If I
turn the ide DMA off, then I can compile as many linux kernels
as I like with no lockup. This DMA lockup also occurs on other
2.4.x kernels. Is anyone interested in getting me to test a
fix for this problem?

Feb 10 10:44:35 solaris kernel: PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Feb 10 10:44:35 solaris kernel: ALI15X3: IDE controller on PCI bus 00 dev 20
Feb 10 10:44:35 solaris kernel: ALI15X3: chipset revision 196
Feb 10 10:44:35 solaris kernel: ALI15X3: not 100%% native mode: will probe irqs later
Feb 10 10:44:35 solaris kernel: ALI15X3: ATA-66/100 forced bit set (WARNING)!!


with dma off  hdparm -Tt /dev/hda gives:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.56 seconds =228.57 MB/sec
 Timing buffered disk reads:  64 MB in 14.85 seconds =  4.31 MB/sec


with dma off  hdparm -Tt /dev/hda gives:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.49 seconds =261.22 MB/sec
 Timing buffered disk reads:  64 MB in  1.70 seconds = 37.65 MB/sec


Cheers.  Paul


