Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWEKRrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWEKRrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWEKRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:47:35 -0400
Received: from thelinuxbeat.net ([213.133.108.86]:7539 "EHLO bortal.de")
	by vger.kernel.org with ESMTP id S1030381AbWEKRre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:47:34 -0400
Subject: can not mount compact flash drive hda (ext3) with 2.6.16
From: Mario Ohnewald <mario@bortal.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ZyhyLs3ufME95Au3OEdS"
Date: Thu, 11 May 2006 19:58:50 +0200
Message-Id: <1147370330.6999.13.camel@spiekey.spiekey>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZyhyLs3ufME95Au3OEdS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello List,

i am booting a linux box via NFS. 
When it boot it with a 2.4.32 kernel i cCAN mount my compact flash drive
hda.

If i boot a 2.6.16 kernel i CAN NOT.


hdaX is ext3 and ext3 is compiled into the kernel.
Am i missing a kernel option?

More infos:

~# fdisk -l

Disk /dev/hda: 1024 MB, 1024450560 bytes
32 heads, 63 sectors/track, 992 cylinders
Units = cylinders of 2016 * 512 = 1032192 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1          73       73552+  83  Linux
/dev/hda2              74         751      683424   83  Linux
/dev/hda3             752         799       48384   83  Linux
/dev/hda4             800         992      194544   83  Linux

~# mount
rootfs on / type rootfs (rw)
/dev/root on / type nfs
(rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/root on /dev/.static/dev type nfs
(rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252)
none on /dev type tmpfs (rw)
tmpfs on /tmp type tmpfs (rw)
devpts on /dev/pts type devpts (rw)
tmpfs on /dev/shm type tmpfs (rw)


~# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / nfs
rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/root /dev/.static/dev nfs
rw,v2,rsize=4096,wsize=4096,hard,nolock,proto=udp,addr=192.168.1.252 0 0
none /dev tmpfs rw 0 0
tmpfs /tmp tmpfs rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0


~# lsof | grep hda
<no result>


~# dmesg | grep hda
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
hda: TOSHIBA THNCF1G02PG, CFA DISK drive
hda: max request size: 128KiB
hda: 2000880 sectors (1024 MB) w/2KiB Cache, CHS=1985/16/63
 hda: hda1 hda2 hda3 hda4

~# mount -t ext3 /dev/hda1 /mnt/
mount: /dev/hda1 already mounted or /mnt/ busy


~# mkfs.ext3 /dev/hda1
mke2fs 1.38 (30-Jun-2005)
/dev/hda1 is apparently in use by the system; will not make a filesystem
here!


Attachted is my kernel config of the 2.6.16 kernel.

Do you need more infos?


Thanks, Mario

--=-ZyhyLs3ufME95Au3OEdS
Content-Disposition: attachment; filename=kernel_config.gz
Content-Type: application/x-gzip; name=kernel_config.gz
Content-Transfer-Encoding: base64

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


--=-ZyhyLs3ufME95Au3OEdS--

