Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTF1Dtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTF1Dtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:49:53 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:38292 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S265059AbTF1Dtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:49:51 -0400
Date: Sat, 28 Jun 2003 00:04:05 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
In-Reply-To: <20030628031920.GF18676@work.bitmover.com>
Message-ID: <Pine.LNX.4.56.0306272352480.19613@filesrv1.baby-dragons.com>
References: <20030627145727.GB18676@work.bitmover.com>
 <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net>
 <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk>
 <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com>
 <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain>
 <20030628031920.GF18676@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Larry ,  Foooeeyyyyy !  It was not the SCSI drives that
	failed you from what you had posted .  It was the drivers which
	were puking (afaict) .  I'll admit that tape backup of heavily
	changing data is a test in futility .  But I'll NOT fail in making
	my backups ,  ever !-) .  Twyl ,  JimL

 # dmesg | grep -B2 -A5 -i adaptec
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 at faa48000 size=100000 irq=26
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001
TID 525  Vendor: ADAPTEC      Device: RAID-5       Rev: 380E
scsi2 : Vendor: Adaptec  Model: 2110S            FW:380E
  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
  Type:   Direct-Access                      ANSI SCSI revision: 02

 # dmesg | grep sdd
SCSI device sdd: 177827840 512-byte hdwr sectors (91048 MB)

 # df /home/archive /home/jiml
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdd1             57422288  24301792  30156504  45% /home/archive
/dev/sdd2             28703752  19319748   7902412  71% /home/jiml
                                --------
                                43621540

 root@filesrv1:~ # tapeinfo -f /dev/sg3
Product Type: Tape Drive
Vendor ID: 'COMPAQ  '
Product ID: 'TSL-9000        '
Revision: '2.06'


On Fri, 27 Jun 2003, Larry McVoy wrote:
> On Fri, Jun 27, 2003 at 08:51:40PM -0400, Scott McDermott wrote:
> > Larry McVoy on Fri 27/06 17:16 -0700:
> > > I don't know if you all realize this but at one point we
> > > had corrupted data in several repositories and the backups
> > > were also shot.
> >
> > ever hear of tapes?
>
> bkbits is 45GB of data and growing.  Tapes are completely impractical,
> that's why we have hot spares.
>
> > how about SCSI?
>
> The raid system that failed is SCSI.
>

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
