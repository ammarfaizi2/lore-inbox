Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSFNPSv>; Fri, 14 Jun 2002 11:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSFNPSv>; Fri, 14 Jun 2002 11:18:51 -0400
Received: from [207.65.182.3] ([207.65.182.3]:16286 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S312590AbSFNPSt>;
	Fri, 14 Jun 2002 11:18:49 -0400
To: Duncan Sands <duncan.sands@wanadoo.fr>, linux-kernel@vger.kernel.org,
        devfs@oss.sgi.com
From: gphat@cafes.net
Subject: Re: 2.5.19 - 2.5.21 don't boot with devfs
Date: Fri, 14 Jun 2002 15:14:57 GMT
X-Originating-IP: 67.105.23.116
Message-Id: <20020614151457.63A9A6838EDB@mail.cafes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem, as the familiar /dev/hdN devices were not there. 
 
You can likely find them deep /dev/ata/... 
 
I adjusted my fstab to use /dev/ata/... devices.  I believe I had done that 
once for /dev/ide, but then it was switched to ata ;) 
 
> Starting from 2.5.19 (x86), booting fails at "Checking root file system..." 
> if devfs is mounted; there is no problem if devfs is not mounted.  With 
> devfs mounted I get: 
>  
> .... 
> Checking root file system... 
> fsck 1.27 (8-Mar-2002) 
> .... 
> fsck.ext3: No such file or directory while trying to open /dev/hda2 
>  
> Here is my fstab: 
>  
> # /etc/fstab: static file system information. 
> # 
> # <file system> <mount point> <type> <options>   <dump> <pass> 
> /dev/hda2 /  ext3 defaults,errors=remount-ro 0 1 
> /dev/hda3 none  swap sw           0 0 
> /dev/hda1 /windows vfat defaults,user,exec  0 2 
> proc  /proc  proc defaults   0 0 
> none     /proc/bus/usb usbdevfs defaults  0 0 
> none  /devices driverfs defaults  0 0 
>  
> Any ideas? 
>  
> Duncan. 
> - 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in 
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/ 
> 



