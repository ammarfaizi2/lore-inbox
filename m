Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289770AbSBOOIh>; Fri, 15 Feb 2002 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSBOOI1>; Fri, 15 Feb 2002 09:08:27 -0500
Received: from Mix-Toulon-101-2-81.abo.wanadoo.fr ([193.248.29.81]:13696 "HELO
	www.kalou.net") by vger.kernel.org with SMTP id <S289770AbSBOOIK> convert rfc822-to-8bit;
	Fri, 15 Feb 2002 09:08:10 -0500
Date: Fri, 15 Feb 2002 15:05:57 +0100 (CET)
From: Olivier Kaloudoff <kalou@kalou.net>
To: linux-kernel@vger.kernel.org
Cc: qa@mandrakesoft.com
Subject: 2.4.17: LOOP_SET_FS: Invalid argument
Message-ID: <Pine.LNX.4.43.0202151458150.2090-100000@clients.nfrance.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gurus,


	I'm simply trying to mount a filesystem
located in a file, and get in trouble with this
message I don't understand...

[root@www root]# dd if=/dev/zero of=/tmp/test bs=1024k count=10
10+0 enregistrements lus.
10+0 enregistrements écrits.

[root@www root]# ls -lh /tmp/test 
-rw-r--r--    1 root     root          10M fév 15 15:00 /tmp/test

[root@www root]# dd if=/dev/zero of=/tmp/test bs=1024k count=10
10+0 enregistrements lus.
10+0 enregistrements écrits.

[root@www root]# mkfs /tmp/test 
mke2fs 1.25 (20-Sep-2001)
/tmp/test is not a block special device.
Proceed anyway? (y,n) y
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
2560 inodes, 10240 blocks
512 blocks (5.00%) reserved for the super user
First data block=1
2 block groups
8192 blocks per group, 8192 fragments per group
1280 inodes per group
Superblock backups stored on blocks: 
        8193

Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 25 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.

[root@www root]# mount /tmp/test /mnt/test/
mount : /tmp/test n'est pas un périphérique de bloc (essayez `-o loop' ?).

[root@www root]# mount /tmp/test /mnt/test/ -o loop
ioctl: LOOP_SET_FD: Invalid argument

[root@www root]# mount /tmp/test /mnt/test/ -o loop -t ext2
ioctl: LOOP_SET_FD: Invalid argument

[root@www root]# mount /tmp/test /mnt/test/ -o loop -t ext3
ioctl: LOOP_SET_FD: Invalid argument

[root@www root]# cat /proc/filesystems  | grep ext 
        ext2
        ext3

[root@www root]# uname -a
Linux www.kalou.net 2.4.17-16mdk #1 Fri Feb 8 16:00:03 CET 2002 i686 unknown


Best Regards,

Kalou

