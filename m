Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbRLaAse>; Sun, 30 Dec 2001 19:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285883AbRLaAsP>; Sun, 30 Dec 2001 19:48:15 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:1545 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S285878AbRLaAry>;
	Sun, 30 Dec 2001 19:47:54 -0500
Message-ID: <3C2FB545.BA4544D7@obviously.com>
Date: Sun, 30 Dec 2001 19:45:57 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why would a valid DVD show zero files on Linux?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a DVD ROM (It's DeLorme Topo USA), which works fine booted in Windows.
Under Linux it mounts fine, but shows no files.  Everything looks normal, like
it should just work.

What's up?  And ideas?


[root@HardHat bryce]# df
...
/dev/scd0               326028    326028         0 100% /mnt/cdrom
/dev/hdc               3277426   3277426         0 100% /mnt/dvdrom

[root@HardHat bryce]# uname -a
Linux HardHat 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown


[root@HardHat bryce]# cat /proc/filesystems 
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
nodev   proc
        ext2
        iso9660
nodev   devpts
nodev   usbdevfs
        vfat
nodev   autofs

[root@HardHat bryce]# dd if=/dev/hdc of=/tmp/A bs=1024 count=200
200+0 records in
200+0 records out
[root@HardHat bryce]# strings /tmp/A
CD001
                                T3DVD                           
                                                                                                                                DELORME                                                                                                                         ADJ                                                                                                                                                                                                                                                                                                                                                                            1999111712541000
2001022814540400
2001022814540400
CD001
9%/E
1999111712541000
2001022814540400
2001022814540400
CD001
BEA01
NSR02
TEA01
T3DVD
00026f70 MTC ForDVD 5.9, March 2000
OSTA Compressed Unicode
OSTA Compressed Unicode
*Multimedia Tech. Cntr.
*UDF LV Info
