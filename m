Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTLEJei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 04:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTLEJei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 04:34:38 -0500
Received: from web9504.mail.yahoo.com ([216.136.129.134]:38041 "HELO
	web9504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263478AbTLEJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 04:34:36 -0500
Message-ID: <20031205093435.61652.qmail@web9504.mail.yahoo.com>
Date: Fri, 5 Dec 2003 01:34:35 -0800 (PST)
From: neel vanan <neelvanan@yahoo.com>
Subject: Kernel panic...
To: linux-kernel@vger.kernel.org
In-Reply-To: <S263478AbTLEJ0s/20031205092648Z+878@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
currently i am compiling kernel 2.6.0-test11, After
making kernel image and installing new module when i
boot with new kernel image i am getting this error:

 Red Hat nash version 3.4.42 starting
 Loading sd_mod.ko module
 Loading aic79xx.ko module
 scsi0: Adaptec AIC79xx PCI-X SCSI HBA DRIVER, Rev
1.3.9
        .....................................
 scsi0:A:0:0: Tagged Queing enabled, Depth 32
 scsi device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: unknown partition
table
 Attached scsi disk sda at scsi0, channel0, id0, lun0
 mounting /proc file system
 creating block devices
 creating Root devices
 Mounting root filesystem
 mount : erro 6 mounting ext3
 pivotroot : pivot_root (/sysroot, /sysroot/initrd)
failed:2
 umount /initrd/proc failed :2
 Mounting devfs on /dev
 freeing unused kernel memory : 464k freed
 Kernel panic: no init found. Try passing init= option
to kernel
After then blinking cursor.

#Entries in grub.conf is:
 title Red Hat Linux (2.6.0)
 root (hd0,0)
 kernel /vmlinux2.6.0 ro root=/dev/sda3
 initrd /initrd-2.6.0.img
 #
also i had tried append="hdc=ide-scsi root=LABEL=/"
and append="hdc=ide-scsi root=/dev/sda3"

 <content of /etc/fstab>
 LABEL=/      /          ext3    defaults        1 1
 LABEL=/boot  /boot      ext3    defaults        1 2
 none         /dev/pts   devpts  gid=5,mode=620  0 0
 none         /proc      proc    defaults        0 0
 none         /dev/shm   tmpfs   defaults        0 0
 /dev/sda2    swap       swap    defaults        0 0
 /dev/cdrom   /mnt/cdrom udf,iso9660
noauto,owner,kudzu,ro 0 0
 /dev/fd0     /mnt/floppy auto  noauto,owner,kudzu 0 0

Please let me know where i am wrong.

Thanks.

Neel


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
