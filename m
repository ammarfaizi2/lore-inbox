Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbQKITrp>; Thu, 9 Nov 2000 14:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130634AbQKITre>; Thu, 9 Nov 2000 14:47:34 -0500
Received: from mout1.freenet.de ([194.97.50.132]:11957 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S130531AbQKITr1>;
	Thu, 9 Nov 2000 14:47:27 -0500
Date: Thu, 9 Nov 2000 21:50:45 +0000
From: Ingo Rohloff <lundril@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Problems with NFS in 2.4test10
Message-ID: <20001109215045.A591@flashline.chipnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First a description of my machine:
I use a Dual Celeron System with glibc-2.1.3 and
linux-2.4test10 . 
For information on peripherial devices I give the output of /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=128.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  
      I/O at 0xe000 [0xe01f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   8, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 16.
      I/O at 0xe400 [0xe41f].
  Bus  0, device  11, function  0:
    VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 0).
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe57fffff].


I have another computer (a K6) which is used as NFS server
(running Universal NFS Server 2.2beta41 under glibc-2.0.7 and
 linux-2.2.16 )

I try to Encode WAV files to MP3s, which are both hosted
on the K6. The files are located on a ReiserFS partition,
which is mounted via NFS from the Dual Celeron.

My Dual Celeron locks up regularily during this operation.
The encoding process simply stops and the whole computer
locks up. (No pinging possible).

I first suspected that it had something to do with 
the Kernel NFS _Server_ which I use on the Dual Celeron,
but since in this case the Dual Celeron acts as client,
this shouldn't be the reason right ?

Any Ideas how to track down this problem (like putting
some printk's in strategically important locations ?)

so long
  Ingo

PS: I might be a hardware problem, since dual Celerons
    should be impossible... But i do a lot of compiling
    on this machine and it never locked up, or threw errors
    during compiling. So I suspect it isn't the hardware.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
