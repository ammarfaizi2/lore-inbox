Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRFSN3i>; Tue, 19 Jun 2001 09:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263772AbRFSN33>; Tue, 19 Jun 2001 09:29:29 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:29296 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S263149AbRFSN3U>; Tue, 19 Jun 2001 09:29:20 -0400
Message-ID: <3B2F5282.30602@niisi.msk.ru>
Date: Tue, 19 Jun 2001 17:24:18 +0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: "David L. Parsley" <parsley@linuxjedi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru> <3B2A538A.BA62148A@linuxjedi.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David L. Parsley wrote:

>Mathias Killian wrote a patch to allow cramfs initrd's, see:
>http://www.cs.helsinki.fi/linux/linux-kernel/2001-01/1064.html
>
Thank you. I applied this patch, and recompiled my kernel.
All works fine, if the size of root filesystem less than 4096Kb. But 
when i create
an image of root filesystem which size is bigger than 4096Mb, the kernel 
said:
...
RAMDISK driver initialized: 16 RAM disks of 4096K size 4096 blocksize
...
RAMDISK: cramfs filesystem found at block 0  
RAMDISK: Loading 2300 blocks [1 disk] into ram disk... done.
...
Freeing unused kernel memory: 116k freed  
Algorithmics/MIPS FPU Emulator v1.4
Error -3 while decompressing!     
804172a4(-166740)->803da000(4096)      
bash#

As you can see, the size of image is only 2300kb.
The kernel command line is:
root=/dev/ram init=/bin/bash ramdisk_blocksize=4096

When i tried to mount this image on a running kernel it is all OK.

# mount -o loop -t cramfs cramfsdisk.bin /mnt/ramdisk
# chroot /mnt/ramdisk /bin/bash

I already asked Matthias, but he said that he didn't try cramfs for
ram disks larger than 4k. Did anybody try it? Does anybody work on
cramfs now?


