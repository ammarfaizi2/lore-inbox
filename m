Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264582AbRFYXPZ>; Mon, 25 Jun 2001 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264586AbRFYXPP>; Mon, 25 Jun 2001 19:15:15 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:64160 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264582AbRFYXPH>; Mon, 25 Jun 2001 19:15:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.5-ac16/17/18: floppy driver problem with lilo boot disks?
Date: Tue, 26 Jun 2001 01:41:29 +0200
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010625231513Z264582-17720+7582@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I mount my bootdisk (minix filesystem) with "mount /dev/fd0 /mnt" and copy my 
new compiled kernel to it. After that I do a "lilo -v -C /mnt/lilo.conf".

All following commands which are floppy related (filesystem) fall into the D 
state. Load goes up by 100 for every D state process.

ls /mnt
umount /mnt
sync

SunWave1#cat /proc/version
Linux version 2.4.5-ac16 (root@SunWave1) (gcc version 2.95.2 19991024 
(release)) #1 Wed Jun 20 18:01:34 CEST 2001
 
SunWave1#ps aux
root      1039  0.0  0.0  1404   64 pts/1    D    16:24   0:00 umount /mnt
nuetzel   1108  0.1  0.1  1412  500 pts/5    D    16:28   0:00 sync

Even "reboot" do nothing. I have to push the reset button.
Luckily I have ReiserFS running and only some seconds to wait during bootup 
for replay the transaction logs.

But mount/umount other disk partitions works as expected.

Thanks,
	Dieter
