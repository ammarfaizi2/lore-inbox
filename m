Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbRFORTS>; Fri, 15 Jun 2001 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264202AbRFORTI>; Fri, 15 Jun 2001 13:19:08 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:21360 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S263344AbRFORS6>; Fri, 15 Jun 2001 13:18:58 -0400
Message-ID: <3B2A42D4.7090004@niisi.msk.ru>
Date: Fri, 15 Jun 2001 21:16:04 +0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru> <14506.992621390@redhat.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David.
David Woodhouse wrote:

>Where does the bootloader get the initrd from?
>
Bootloader only jumps to the kernel entry point. The initrd image is 
compiled
inside the kernel. ( special section in the ELF kernel binary )
.config:
...
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
...
If 'root=/dev/ram' option is set in command line, the root file system 
will bi in
RAM. When the linux kernel is booting, it tries to identify_ramdisk_image()
( at drivers/block/rd.c ). So it can only understand ext2, minix, romfs,
and gzipped images. But what about cramfs? How can i use a cramfs image 
to mount
it as my root file system? Is any patches to the rd.c requiried?

