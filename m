Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSFKG2l>; Tue, 11 Jun 2002 02:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSFKG2l>; Tue, 11 Jun 2002 02:28:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33038 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316848AbSFKG2j>; Tue, 11 Jun 2002 02:28:39 -0400
Message-ID: <3D059893.60206@evision-ventures.com>
Date: Tue, 11 Jun 2002 08:28:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: fdisk on scsi disks in 2.5.21
In-Reply-To: <3D054432.88C5BE59@torque.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> $ fdisk -l /dev/sda
> 
> Disk /dev/sda: 1 heads, 35843670 sectors, 1 cylinders
> Units = cylinders of 35843670 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sda1   *         1         1     32098+  83  Linux
> Partition 1 has different physical/logical beginnings (non-Linux?):
>      phys=(0, 1, 1) logical=(0, 0, 64)
> Partition 1 has different physical/logical endings:
>      phys=(3, 254, 63) logical=(0, 0, 64260)
> Partition 1 does not end on cylinder boundary:
>      phys=(3, 254, 63) should be (3, 0, 35843670)
> /dev/sda2             1         1    168682+  83  Linux
> Partition 2 has different physical/logical beginnings (non-Linux?):
>      phys=(4, 0, 1) logical=(0, 0, 64261)
> Partition 2 has different physical/logical endings:
>      phys=(24, 254, 63) logical=(0, 0, 401625)
> Partition 2 does not end on cylinder boundary:
>      phys=(24, 254, 63) should be (24, 0, 35843670)
> ....
> 
> One head, one cylinder and lots of sectors??
> I put some debug in drivers/scsi/scsicam.c and it doesn't
> seem like it was called.
> 
> Is my fdisk (from RH 7.2) too old?

No please: Just please don't look at ide-scsi in 2.5.21
without applying IDE  patch number 86.

