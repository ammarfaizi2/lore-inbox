Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTJJL5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJJL53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:57:29 -0400
Received: from 209-123-183-81.site5.com ([209.123.183.81]:47806 "EHLO
	suna.site5.com") by vger.kernel.org with ESMTP id S261660AbTJJL5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:57:10 -0400
Message-ID: <3F86C17A.8060209@4-sms.com>
Date: Fri, 10 Oct 2003 17:26:02 +0300
From: SMS WebMaster <sms@4-sms.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030819
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>,
       linux-config@vger.kernel.org, linux-userfs@vger.kernel.org
Subject: mount: / mounted already or bad option
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - suna.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - 4-sms.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi
I have Gentoo linux in my PC
I just installed the kernel 2.4.22 and compile it and install it (using 
genkernel command)
Right now if I reboot my PC with my new kernel I got :
mount: / mounted already or bad option
and the system stop and ask me to type the root password
and when I login with the root and type
mount -o remount,rw /

I got the same message
mount: / mounted already or bad option

but if I write
mount -o remount,rw /dev/hda4  /
then the root filesystem if remounted as read/write

Anyway the stupid thing is that if I boot with my old kernel I don't get 
this problem !!!
Any Help

My /etc/fstab :

/dev/hda2               /boot           ext2            noauto,noatime 
        1 1
/dev/hda4               /               reiserfs 
defaults,noatime,notail,iocharset=utf8          0 0
/dev/hda3               none            swap            sw 
        0 0
/dev/hda1       /mnt/win        ntfs 
auto,ro,umask=000,iocharset=utf0 0
/dev/cdroms/cdrom0      /mnt/cdrom      iso9660 
noauto,ro,umask=000,iocharset=utf8      0 0
/dev/fd0        /mnt/floppy     vfat 
noauto,defaults,umask=000,iocharset=utf8        0 0
none                    /proc           proc            defaults 
        0 0
none                    /dev/shm        tmpfs           defaults 
        0 0

My /etc/lilo.conf :
image = /boot/kernel-2.4.22
         root = /dev/hda4
         label = Gentoo
         initrd=/boot/initrd-2.4.22
         append="root=/dev/hda4 init=/linuxrc hdc=ide-scsi"

image = /boot/kernel-2.4.20-gentoo-r5
         root = /dev/hda4
         #root = /devices/discs/disc0/part3
         label = Old-Gentoo
         initrd=/boot/initrd-2.4.20-gentoo-r5
         #read-only # read-only for checking
         append="root=/dev/hda4 init=/linuxrc hdc=ide-scsi"
 


-- 
http://www.4-SMS.Com
http://eShop.4-SMS.Com
http://Mozilla.4-SMS.Com
-*- If Linux doesn't have the solution, you have the wrong problem -*-

