Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTAFCrj>; Sun, 5 Jan 2003 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAFCri>; Sun, 5 Jan 2003 21:47:38 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:5277 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265708AbTAFCrh>; Sun, 5 Jan 2003 21:47:37 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 18:43:35 -0800 (PST)
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
In-Reply-To: <418420000.1041781806@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0301051838180.23962-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same 'failed memory mapped' error (and the inability to run 2.5
kernels) on my SIS K6 board which has been running without a problem with
2.2 and 2.4 kernels.
this is /proc/pci from 2.4.18

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 2).
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   0, function  1:
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
      Master Capable.  Latency=128.
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   1, function  0:
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 177).
  Bus  0, device   1, function  1:
    Class ff00: Silicon Integrated Systems [SiS] ACPI (rev 0).
  Bus  0, device   2, function  0:
    PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 3).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0xda00 [0xdaff].
      Non-prefetchable 32 bit memory at 0xeffef000 [0xeffeffff].
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex] (rev
0).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=3.Max Lat=8.
      I/O at 0xdc00 [0xdc1f].
  Bus  0, device  12, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8338A (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xde00 [0xdeff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Silicon Integrated Systems [SiS] 6306
3D-AGP (rev 162).
      Master Capable.  Latency=32.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xff000000 [0xff7fffff].
      Non-prefetchable 32 bit memory at 0xe7ef0000 [0xe7efffff].
      I/O at 0xcc00 [0xcc7f].

David Lang

On Sun, 5 Jan 2003, Justin T. Gibbs wrote:

> Date: Sun, 05 Jan 2003 08:50:06 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
> Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
>
> > Out of this, two problems :
> >  - AIC7xxx fails to use DMA, with :
> > aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
> > scsi0: PCI error Interrupt at seqaddr = 0x3
> > scsi0: Signaled a Target Abort
>
> This is because your system is violating the PCI spec.  There is
> now an explicit test for this during driver initialization so that
> the driver doesn't unexpectedly fail later.  I can change the driver
> so that it doesn't print out the diagnostic if it would make you
> feel better. 8-)
>
> Just out of curiosity, what MB/Chipset are you using?
>
> --
> Justin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
