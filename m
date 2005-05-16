Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVEPPGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVEPPGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEPPEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:04:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:64192 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261680AbVEPO7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:59:55 -0400
Date: Mon, 16 May 2005 17:03:56 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
In-Reply-To: <20050516085832.GA9558@gmail.com>
Message-ID: <Pine.LNX.4.62.0505161701410.2390@dragon.hyggekrogen.localhost>
References: <20050516085832.GA9558@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Grégoire Favre wrote:

> Hello,
> 
> as I reported in
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111554477416794&w=2
> 
> I have lots of problem with aic7xxx (and till 2.6.12-rc2 everything
> works perfectly). I have tried to compil 2.6.12-rc4-mm1 without probe
> all Lun and it don't change anything at all to this problem.
> 
> I have two different controllers :
> 
> 0000:00:05.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
> 0000:00:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
> 
> And I also use libsata.
> 
> Anyone got an idea on what's going wrong ?
> 
Not me, it works perfectly here, but then I have different hardware (but 
using the aic7xxx driver).

Here's what 2.6.12-rc4-mm1 has to say about my devices : 

[   33.618922] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
[   33.618925]         <Adaptec 29160N Ultra160 SCSI adapter>
[   33.618927]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   33.618930]
[   49.640570] (scsi0:A:4:0): refuses WIDE negotiation.  Using 8bit transfers
[   49.644190]   Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
[   49.646714]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   49.649172]  target0:0:4: Beginning Domain Validation
[   49.651858] (scsi0:A:4:0): refuses WIDE negotiation.  Using 8bit transfers
[   49.657561]  target0:0:4: Domain Validation skipping write tests
[   49.660414] (scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
[   49.665476]  target0:0:4: Ending Domain Validation
[   49.673599]   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
[   49.676263]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   49.678814]  target0:0:5: Beginning Domain Validation
[   49.683510]  target0:0:5: Domain Validation skipping write tests
[   49.686322] (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 16)
[   49.690423]  target0:0:5: Ending Domain Validation
[   49.694849]   Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
[   49.697572]   Type:   Direct-Access                      ANSI SCSI revision: 03
[   49.700193] scsi0:A:6:0: Tagged Queuing enabled.  Depth 250
[   49.702793]  target0:0:6: Beginning Domain Validation
[   49.708229] WIDTH IS 1
[   49.711280] (scsi0:A:6): 6.600MB/s transfers (16bit)
[   49.718361] (scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
[   49.730609]  target0:0:6: Ending Domain Validation
[   51.784340] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   51.788211] SCSI device sda: drive cache: write back
[   51.791748] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   51.795598] SCSI device sda: drive cache: write back
[   51.798176]  sda: sda1 sda2 sda3 sda4
[   51.817055] Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
[   51.821630] sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
[   51.824276] Uniform CD-ROM driver Revision: 3.20
[   51.826937] Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
[   51.831792] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   51.834486] Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0


--
Jesper Juhl


