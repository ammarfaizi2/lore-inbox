Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287312AbRL3OtU>; Sun, 30 Dec 2001 09:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287428AbRL3OtL>; Sun, 30 Dec 2001 09:49:11 -0500
Received: from mail.gmx.de ([213.165.64.20]:25510 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287312AbRL3OtE>;
	Sun, 30 Dec 2001 09:49:04 -0500
Message-ID: <3C2F2948.DB59646A@gmx.net>
Date: Sun, 30 Dec 2001 15:48:40 +0100
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops: UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently had a horrendous experience while unmounting some partitions.
Ironically exactly those I wanted to backup ASAP :-(

SITUATION:
2 weeks ago I assembled a brand new Duron system. I connected my brand
new UDMA/100 HDD on /dev/HDA and my old UDMA/33 one on /dev/HDB. Jumpers
are correct. Cable is 80 ribbon. All the funky stuff in the BIOS has
NEVER been enabled, so everything has been at default from assembly on.
The only thing somewhat not-kosher was the fact that the SLAVE drive was
mounted at the END of the ribbon cable (instead of in the middle) as a
result of having installed this drive as an afterthought and not having
the space. I still don't know how relevant this is.
CONTENTS OF /dev/hdb:
hdb3: old /home
hdb5: old /
hdb6: old /usr/local
In the last week I've mounted and unmounted these a couple of times to
copy stuff. I mounted /home the most, I mounted /home like twice and
/usr/local never.

WHAT HAPPENED:
So yesterday I had /dev/hdb3 mounted...I try to umount it from /mnt and
it oopses on me!? According to 'mount' it still mounted and there's no
way to (u)mount it again. I thought "OK whatever" and try to mount
/dev/hda5...OOPS again. Remebering what important university reports and
stuff I had there I completely freak out and change /etc/fstab to e2fsck
it at bootup and reboot the machine normally.
Now the fun starts: at bootup it tells me that it can't find any
superblocks on any of the THREE partitons anymore...they're all gone.
No matter what I tried with e2fsck it couldn't do anything. 'sfdisk -V'
reported everything OK and /dev/hda1 (vfat) still mounts and umounts
correctly.

At first I thought maybe the partitions were long overdue to be
force-fscked but they'd been asymmetrically (u)mounted (every one a
different amount of time).
Rest assured I had NOT been doing any "weird" things, I had (u)mounted
stuff just like I've been doing for nearly 2 years.
This is all mind-boggling to me, so if anyone has any suggestions for me
no matter how silly let me know! I want my data back!

Please CC me as I'm not subscribed to LKML.
Thanks in advance and thanks for a great kernel.
-Mike Neman

