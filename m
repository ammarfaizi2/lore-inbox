Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314086AbSDQOJA>; Wed, 17 Apr 2002 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDQOI7>; Wed, 17 Apr 2002 10:08:59 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:9689 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S314086AbSDQOI6>; Wed, 17 Apr 2002 10:08:58 -0400
Date: Wed, 17 Apr 2002 10:08:20 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Andrey Slepuhin <pooh@msu.ru>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx driver v6.2.5 freezes the kernel
In-Reply-To: <20020417111515.GE7342@glade.nmd.msu.ru>
Message-ID: <Pine.LNX.4.44.0204170953510.8334-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Andrey ,  Version 6.2.6 on my patched upto pre-6 kernel
	does not lock my present system .  Hth ,  JimL

Linux version 2.4.19-pre6 (root@(none)) (gcc version 2.95.3 20010315
(release)) #1 SMP Sat Apr 13 22:17:13 UTC 2002
...
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: HITACHI   Model: DK32CJ-36MC       Rev: JBBB
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
  Vendor: HITACHI   Model: DK32CJ-36MC       Rev: JBBB
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 72205440 512-byte hdwr sectors (36969 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 72205440 512-byte hdwr sectors (36969 MB)
 sdb: sdb1 sdb2 sdb3


On Wed, 17 Apr 2002, Andrey Slepuhin wrote:

> On Tue, Mar 19, 2002 at 02:33:47PM -0700, Justin T. Gibbs wrote:
> > >lspci output attached. BTW, I tried new driver on another computer with
> > >the same hardware configuration - effect is repeatable, so the problem is
> > >unlikely a hardware bug.
> >
> > No, but it is certainly hardware dependent.  As soon as I get a break here
> > at work, I'll see what I can dig out from your lspci output.

> Hi Justin,
> I tracked the problem down and I find that the following change between
> versions 6.2.4 and 6.2.5 causes system freeze:

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+


