Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTGQKoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271406AbTGQKn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:43:57 -0400
Received: from web20008.mail.yahoo.com ([216.136.225.71]:28689 "HELO
	web20008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271401AbTGQKmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:42:46 -0400
Message-ID: <20030717105739.70395.qmail@web20008.mail.yahoo.com>
Date: Thu, 17 Jul 2003 03:57:39 -0700 (PDT)
From: navneet panda <navneet_panda@yahoo.com>
Subject: kernel panic at boot
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My HP ZE 5170 laptop has RH9 with gcc
gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

grub.conf reads 

title Red Hat Linux (2.6.0-test1-ac1)
        root (hd0,5)
        kernel /boot/vmlinuz-2.6.0-test1-ac1 ro
root=LABEL=/ hdc=ide-scsi idebus=66
        initrd /boot/initrd-2.6.0-test1-ac1.img
 
title Red Hat Linux (2.4.20-18.9)
        root (hd0,5)
        kernel /boot/vmlinuz-2.4.20-18.9 ro
root=/dev/hda6 hdc=ide-scsi idebus=66
        initrd /boot/initrd-2.4.20-18.9.img
 
title Debian
        root (hd0,3)
        kernel /boot/vmlinuz-2.4.18-bf2.4
root=/dev/hda4 hdc=ide-scsi idebus=66


I compiled the source for 2.6 test after applying the
second patch and then 

make mrproper
make xconfig 
make bzImage 
make modules 
make modules_install 
make install

copied the .config to the appropriate file in /boot

The message upon bootup is

mounting root filesystem
mount error 19 mounting ext3
pivotroot: pivot_root (/sysroot, /sysroot/initrd)
failed:2
umount /initrd/proc failed : 2

Freeing unused kernel memory : 228K freed

Kernel panic : No init found 
Try passing init= option to kernel

I did include ext3 fs support because it was already
part of old config file from 2.4 which was used as a
base for the new config file. 

I don't think this should make a difference but ....
Under 2.4 I had made the change that I had made
separate reiserfs partitions for /usr /var /tmp after
the initial install and moved all the relevant files
there. / is still ext3. the 2.6 source is under
/usr/src. 

The strange thing is I pass exactly the same options
to the 2.4 kernel as well as kernel 2.4.18-bf2.4 (
debian on reiserfs ) and there isn't any problem.

Should I be trying some debugging? I am not very sure
how to go about that.

Thanks in advance.

Panda


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
