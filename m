Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRKKVI1>; Sun, 11 Nov 2001 16:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKKVIR>; Sun, 11 Nov 2001 16:08:17 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:24895 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281068AbRKKVIG>; Sun, 11 Nov 2001 16:08:06 -0500
Message-ID: <3BEEE9E5.56D04353@mindspring.com>
Date: Sun, 11 Nov 2001 13:13:09 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide floppy iomega zip driver or vfat?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug in iomega zip drives internal 100 meg drives.  It seems to
be in 2.4.x kernels. I am not sure which ones work and which ones do
not.  Currently I am using 2.4.14 and saw this in 2.4.9 to 2.4.14.

I mount the zip drive floppy like "mount /mnt/zip100.0"  I then try to
copy a file to that drive and the copy fails and the cp command becomes
defunct.  It cannot be killed with kill -9 or kill -TERM.  I cannot shut
the system down as it is trying to access the drive.

It seems that using the mount /mnt/zip100.0 command mounts the drive as
vfat which causes this problem.  If I do an explicit mount "mount -t
msdos /dev/hdd4 /zip100.0"  it works better.

In either case using eject to eject the drive also hangs as dmesg shows
lots of the following:

hdd: lost interrupt
ide-floppy: CoD != 0 in idefloppy_pc_intr
hdd: ATAPI reset complete

Then I just kill eject and then try umount <drive> and it says "driver
not mounted"

Ideas? Thanks

Joe (not on the lkm list)

