Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSBYTNt>; Mon, 25 Feb 2002 14:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292163AbSBYTNk>; Mon, 25 Feb 2002 14:13:40 -0500
Received: from fw2.primusdatacenter.net ([62.72.60.251]:45168 "HELO
	main.primuseurope.com") by vger.kernel.org with SMTP
	id <S292130AbSBYTNY>; Mon, 25 Feb 2002 14:13:24 -0500
Date: Mon, 25 Feb 2002 19:09:53 +0000
From: Manohar Pradhan <mpml@isp.primuseurope.com>
Reply-To: Manohar Pradhan <mpml@isp.primuseurope.com>
Message-ID: <194779754037.20020225190953@isp.primuseurope.com>
To: linux-kernel@vger.kernel.org
Subject: Urgent SCSI I/O Error
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This question might have been raised before but I am stucked in
between wierd/helpless situation and wondering if someone can help me
out.

I have Red Hat Linux 6.2 (2.2.14-5.0smp) running in my HP Netserver
box. I have 2 9.1 GB HDD. The server has been up for few months and
have not had seen any problem. But today all of sudden it gave
panicking message saying following:

Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 4194368
Feb 25 18:48:12 nsdb1 kernel: EXT2-fs error (device sd(8,6)): ext2_write_inode: unable to read inode block - inode=251018, block=524296
Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:06: sense key Not Ready
Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 1835048
Feb 25 18:48:12 nsdb1 kernel: EXT2-fs error (device sd(8,6)): ext2_write_inode: unable to read inode block - inode=109814, block=229381
Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:06: sense key Not Ready
Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 40
Feb 25 18:48:12 nsdb1 kernel: EXT2-fs error (device sd(8,6)): ext2_write_inode: unable to read inode block - inode=57, block=5
Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:07: sense key Not Ready
Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:07, sector 1048832
Feb 25 18:48:12 nsdb1 kernel: EXT2-fs error (device sd(8,7)): ext2_write_inode: unable to read inode block - inode=62495, block=131104
Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:06: sense key Not Ready
Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 0
Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:07: sense key Not Ready
Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:07, sector 0

I have system running but cannot access files/database saved in
volumes in the second HDD sdb. Following are the partitions I have and
I haven't used any RAID while instaling, means plain hard drive spaces
in 2 drives.

/dev/sdb6               917072    732972    137516  84% /
/dev/sda1                18820      5811     12037  33% /boot
/dev/sda6              2218336    462492   1643156  22% /www
/dev/sda5              5297560    418936   4609520   8% /home
/dev/sda7              1210440    711516    437436  62% /software
/dev/sdb1              5550188     50896   5217356   1% /usr
/dev/sdb5              2016016     28572   1885032   1% /var

I can access files in all the other partitions but cannot access
files/directories in partition /www. I can see files in the
directories listing using 'ls' however accessing any file gives
Input/Output error saying:

cat check1.htm: Input/output error



Can anyone help/suggest me what should I do to make it work? I am
wondering if I reboot the system, I may fall into problem on booting
itself. Is there any thing I need to do to make this partition work?

Thanks in advance for the help.

Regards
Manohar

