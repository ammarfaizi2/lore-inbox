Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312773AbSCVR5r>; Fri, 22 Mar 2002 12:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312774AbSCVR52>; Fri, 22 Mar 2002 12:57:28 -0500
Received: from [66.35.146.201] ([66.35.146.201]:14 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S312773AbSCVR5S>;
	Fri, 22 Mar 2002 12:57:18 -0500
Message-ID: <3C9B7056.502BB64E@nea-fast.com>
Date: Fri, 22 Mar 2002 12:56:38 -0500
From: walt <walt@nea-fast.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-SGI_XFS_1.0.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abdij Bhat <Abdij.Bhat@kshema.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Upgrade Hangs!
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FA4@BHISHMA>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abdij Bhat wrote:

> Hi,
>  I am trying to build the 2.4.17 Kernel and upgrade my existing 2.4.7-10 Red
> Hat Linux System. Here is the procedure I followed ( based on Red Hat
> Documentation on the same ):
>
> 1. tar -xvzf linux-2.4.17.tar.gz
> 2. cd linux
> 3. make mkproper
> 4. make menuconfig
> 5.make dep
> 6. make clean
> 7. make bzImage
> 8. make modules
> 9. make modules_install
> 10. cp /usr/src/linux-2.4.17/arch/i386/boot/bzImage /boot/vmlinuz-2.4.17
> 11. cp /usr/src/linux-2.4.17/System.map /boot/System.map-2.4.17
> 12. cd /boot rm System.map ln -s System.map-2.4.17 System.map
> 13. mkinitrd /boot/initrd-2.4.17.img 2.4.17
> 14. Modify the /etc/lilo.conf to add
>                 image=/boot/vmlinuz-2.4.17
>                 label=linux-Mine
>                 root=/dev/hda1
>                 initrd=/boot/initrd-2.4.17
>                 read-only
>
>  Now when i reboot and select the linux-Mine option the screen displays
>                 Loading vmlinuz-2.4.7
>                 Uncompressing Linux... Ok, booting the kernel
>
>  and then HANGS!!!!!!
>
>  What might be the problem. I have followed the instruction to the T. I
> tried without the initrd option too. I have enabled the RAM diak
> option/disabled it....
>
>  Please help me out on the issue.
>
> Thanks and Regards,
> Abdij
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

You must run /sbin/lilo so lilo knows the "physical" location on the disk of
the kernel image

