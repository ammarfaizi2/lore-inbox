Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRLMIM0>; Thu, 13 Dec 2001 03:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283708AbRLMIMQ>; Thu, 13 Dec 2001 03:12:16 -0500
Received: from [195.66.192.167] ([195.66.192.167]:9747 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283658AbRLMIME>; Thu, 13 Dec 2001 03:12:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Joy Almacen <joy@empexis.com>, wa@almesberger.net,
        linux-kernel@vger.kernel.org
Subject: Re: pivot_root and initrd kernel panic woes
Date: Thu, 13 Dec 2001 08:09:59 -0200
X-Mailer: KMail [version 1.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <3C165586.457A26F0@empexis.com>
In-Reply-To: <3C165586.457A26F0@empexis.com>
MIME-Version: 1.0
Message-Id: <01121308095901.01849@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boy, what a detailed report!

I never used lilo, but:

> After which I added this line  my  /etc/lilo.conf file:
>
> image=/boot/vmlinuz-2.4.9-12smp
>         label=2.4.9smp
>         append="initrd=/boot/initrd-2.4.9-12smp.img root=/dev/ram0
> init=/linuxrc rw"
>
> Reran lilo
>
> [root@tinkerbell /root]# lilo -v
>
> LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
> 'lba32' extensions Copyright (C) 1999,2000 John Coffman
>
> Reading boot sector from /dev/sda
> Merging with /boot/boot.b
> Mapping message file /boot/message
> Boot image: /boot/vmlinuz-2.4.2-2smp
> Mapping RAM disk /boot/initrd-2.4.2-2smp.img
> Added linux
> Boot image: /boot/vmlinuz-2.4.2-2
> Mapping RAM disk /boot/initrd-2.4.2-2.img
> Added linux-up *
> Boot image: /boot/vmlinuz-2.4.9-12smp    ## Entry for SMP kernel
> Added 2.4.9smp
> Boot image: /boot/vmlinuz-2.4.9-12-smp-4th
> Added custom
> /boot/boot.0800 exists - no backup copy made.
> Writing boot sector.

"Mapping RAM disk" seems to be missing for 2.4.9-12, so you'll get:

> "VFS: Cannot open root device "ram0" or 01:00
> Please append a correct "root=" boot option
> Kernel panic: VFS:  unable to mount root fs on 01:00 "

Check your lilo conf. Include it in your reply.

BTW, don't go for 2.4x, x>10. initrd is broken there and is still unfixed.
--
vda
