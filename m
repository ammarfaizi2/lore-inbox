Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSLLL4I>; Thu, 12 Dec 2002 06:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLLL4I>; Thu, 12 Dec 2002 06:56:08 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:6289 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S262779AbSLLL4H>; Thu, 12 Dec 2002 06:56:07 -0500
Message-ID: <029301c2a1d6$85cbe280$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Anders Henke" <anders.henke@sysiphus.de>, <linux-kernel@vger.kernel.org>
References: <20021212111237.GA12143@schlund.de>
Subject: Re: using 2 TB  in real life
Date: Thu, 12 Dec 2002 07:03:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like it's already handled in 2.5.
Here's a patch for 2.4:
http://www.gelato.unsw.edu.au/patches-index.html

----- Original Message ----- 
From: "Anders Henke" <anders.henke@sysiphus.de>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 12, 2002 6:12 AM
Subject: using 2 TB in real life


> I've just added a 1.9 TB array to one of my servers (running 2.4.20,
> the device is an 12bay-IFT IDE-to-Fibre-RAID connected via a 
> Qlogic 2300 HBA):
> 
> Disk /dev/sdb: 255 heads, 63 sectors, 247422 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdb1             1    247422 1987417183+  83  Linux
> [...]
> Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
> SCSI device sdb: -320126976 512-byte hdwr sectors (-163904 MB)
>  sdb: sdb1
> 
> 
> Another array (1.2 TB) gives almost the same effect:
> Disk /dev/sdb: 255 heads, 63 sectors, 157450 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdb1             1    157450 1264717093+  83  Linux
> [...]
> Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
> SCSI device sdb: -1765523456 512-byte hdwr sectors (195564 MB)
>  sdb: sdb1
> 
> These issues arise when using arrays larger than around 0.5 T;
> nevertheless, these devices do work fine with both xfs or ext3, 
> it's "just" a cosmetical issue. However, this negative
> values make one feel like Linux isn't truely capable of using up to
> 2 TB of disk devices and so this should be resolved.
> To me it seems that sd.c doesn't know how to calculate the
> correct values for such beasts - any ideas?
> 
> 
> Regards
> 
> Anders
> -- 
> http://sysiphus.de/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
