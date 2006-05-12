Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWELO5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWELO5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWELO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:57:17 -0400
Received: from thelinuxbeat.net ([213.133.108.86]:2590 "EHLO bortal.de")
	by vger.kernel.org with ESMTP id S932108AbWELO5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:57:16 -0400
Subject: Re: [ MOUNT ] Can not mount compact flash drive hda (ext3) with
	2.6.16
From: Mario Ohnewald <mario@bortal.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1147425102.6987.2.camel@spiekey.spiekey>
References: <1147425102.6987.2.camel@spiekey.spiekey>
Content-Type: text/plain
Date: Fri, 12 May 2006 17:08:38 +0200
Message-Id: <1147446518.6987.9.camel@spiekey.spiekey>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has nobody got an idea or hint?


> Hello List,
> 
> i am booting a linux box via NFS. 
> When it boot it with a 2.4.32 kernel i CAN mount my compact flash drive
> hda.
> 
> If i boot a 2.6.16 kernel i CAN NOT.
> 
> 
> hdaX is ext3 and ext3 is compiled into the kernel.
> Am i missing a kernel option?
> 
> More infos:
> 
> ~# fdisk -l
> 
> Disk /dev/hda: 1024 MB, 1024450560 bytes
> 32 heads, 63 sectors/track, 992 cylinders
> Units = cylinders of 2016 * 512 = 1032192 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/hda1   *           1          73       73552+  83  Linux
> /dev/hda2              74         751      683424   83  Linux
> /dev/hda3             752         799       48384   83  Linux
> /dev/hda4             800         992      194544   83  Linux
> 
> ~# mount
> rootfs on / type rootfs (rw)
> /dev/root on / type nfs
> (rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> usbfs on /proc/bus/usb type usbfs (rw)
> /dev/root on /dev/.static/dev type nfs
> (rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
> none on /dev type tmpfs (rw)
> tmpfs on /tmp type tmpfs (rw)
> devpts on /dev/pts type devpts (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> 
> 
> ~# cat /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / nfs
> rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
> proc /proc proc rw 0 0
> sysfs /sys sysfs rw 0 0
> usbfs /proc/bus/usb usbfs rw 0 0
> /dev/root /dev/.static/dev nfs
> rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
> none /dev tmpfs rw 0 0
> tmpfs /tmp tmpfs rw 0 0
> devpts /dev/pts devpts rw 0 0
> tmpfs /dev/shm tmpfs rw 0 0
> 
> 
> ~# lsof | grep hda
> <no result>
> 
> 
> ~# dmesg | grep hda
>     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
> hda: TOSHIBA THNCF1G02PG, CFA DISK drive
> hda: max request size: 128KiB
> hda: 2000880 sectors (1024 MB) w/2KiB Cache, CHS=1985/16/63
>  hda: hda1 hda2 hda3 hda4
> 
> ~# mount -t ext3 /dev/hda1 /mnt/
> mount: /dev/hda1 already mounted or /mnt/ busy
> 
> 
> ~# mkfs.ext3 /dev/hda1
> mke2fs 1.38 (30-Jun-2005)
> /dev/hda1 is apparently in use by the system; will not make a filesystem
> here!
> 
> 
> Attachted is my kernel config of the 2.6.16 kernel.
> 
> Do you need more infos?
> 
> 
> Thanks, Mario
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

