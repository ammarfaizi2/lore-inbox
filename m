Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSBKSVS>; Mon, 11 Feb 2002 13:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289982AbSBKSVI>; Mon, 11 Feb 2002 13:21:08 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:39371 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S290017AbSBKSU6>; Mon, 11 Feb 2002 13:20:58 -0500
Date: Mon, 11 Feb 2002 11:36:33 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ookhoi <ookhoi@humilis.net>
Cc: linux@3ware.com, linux-kernel@vger.kernel.org
Subject: Re: 3ware: SCSI device sda: 1562951681 512-byte hdwr sectors (-299279 MB)
Message-ID: <20020211113633.A13212@vger.timpanogas.org>
In-Reply-To: <20020211140519.B10896@humilis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211140519.B10896@humilis>; from ookhoi@humilis.net on Mon, Feb 11, 2002 at 02:05:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need revision XX.15 > of the 3ware driver to handle 48 bit LBA.
I am running at present with 160GB drives on the 7810 and no 
problem.  There's also a firmware upgrade required of the 
card to get 48 bit LBA to work properly.  www.3ware.com has
the latest firmware.

Jeff


On Mon, Feb 11, 2002 at 02:05:20PM +0100, Ookhoi wrote:
> Hi!
> 
> Not sure if this is a 3ware driver 'bug'. This is a 3ware 7810 with 8
> 100GB disks, configured hw raid0.
> 
> part of dmesg:
> 
> SCSI subsystem driver Revision: 1.00
> 3ware Storage Controller device driver for Linux v1.02.00.010.
> scsi0 : Found a 3ware Storage Controller at 0x1090, IRQ: 5, P-chip: 1.3
> scsi0 : 3ware Storage Controller
>   Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 1562951681 512-byte hdwr sectors (-299279 MB)
>  sda: unknown partition table
> 
> 
> It should say something like 800GB, but says -299279 MB.
> 
> This is with the xfs 2.4.17 kernel. The raid works fine, it seemes just
> cosmetic, but thought I'd better report it anyway.
> 
>         Ookhoi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
