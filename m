Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278354AbRJSJG1>; Fri, 19 Oct 2001 05:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278351AbRJSJGQ>; Fri, 19 Oct 2001 05:06:16 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:57756 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S278349AbRJSJGK>; Fri, 19 Oct 2001 05:06:10 -0400
Date: Fri, 19 Oct 2001 10:05:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jimmy <x55k@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UNABLE TO BOOT WITH 2nd SCSI DRIVE
Message-ID: <20011019100532.A32252@flint.arm.linux.org.uk>
In-Reply-To: <20011018233359.2084.qmail@web20206.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018233359.2084.qmail@web20206.mail.yahoo.com>; from x55k@yahoo.com on Thu, Oct 18, 2001 at 04:33:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 04:33:59PM -0700, jimmy wrote:
> I hope you can shed a light to my problem. The server
> works just fine with a single SCSI drive.
> Unfortunately, when we add the 2nd SCSI drive, the
> system does not boot.

You've given all the information for the case that works, but no information
about the case that doesn't work.

> Host: scsi0 Channel: 00 Id: 06 Lun: 00

If this drive remains as ID 6, and your new drive has a lower ID, then
the new drive will become sda, and this one will move to sdb.  A possible
solution would be to configure this drive as ID 0, and your new drive
as ID 1.

>   Vendor: IBM      Model: DNES-309170W     Rev: SAH0
>   Type:   Direct-Access                    ANSI SCSI
> revision: 03
>...


> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.7
>         <Adaptec 29160 Ultra160 SCSI adapter>
>         aic7892: Wide Channel A, SCSI Id=7, 32/255 SCBs
> 
>   Vendor: IBM       Model: DNES-309170W      Rev: SAH0
>   Type:   Direct-Access                      ANSI SCSI
> revision: 03
> scsi0:0:6:0: Tagged Queuing enabled.  Depth 8
> Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
> (scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
> SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)

What whould be really useful is the above message fragment for the case
where it doesn't boot, particularly which drives it's seeing and the
order it's seeing them.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

