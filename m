Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSETPWU>; Mon, 20 May 2002 11:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316083AbSETPWT>; Mon, 20 May 2002 11:22:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316080AbSETPWR>; Mon, 20 May 2002 11:22:17 -0400
Date: Mon, 20 May 2002 11:22:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Mounting 'foreign' file-systems
Message-ID: <Pine.LNX.3.95.1020520111351.169A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Linux 2.4.18, I can no longer mount CDROMs that were created
using ext2 as the file-system (yes I know this is not specified).
I used to use these CDROMs as part of a "rescue" package.

Now, these can still be mounted through the loop device as is
shown below....

Script started on Mon May 20 11:12:16 2002
# mount /dev/sr0 /mnt
mount: block device /dev/sr0 is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/sr0,
       or too many mounted file systems
# mount -o loop /dev/sr0 /mnt
# ls /mnt
bin  dev  etc  lib  lost+found	mnt  root  sbin  tmp  usr
# umount /mnt
# exit
exit
Script done on Mon May 20 11:13:01 2002

So the question is, how could I put the mount options on the command
line during LILO boot? I tried root=/dev/sr0 {failed}
                               root="/dev/sr0 -o loop" {failed}
                               root=/dev/sr0,-o,loop {failed}
...etc...

..or.. is there a problem that is going to be fixed to revert to
the older behavior ..or.. Am I going to have to redo my rescue
stuff to use iso-9660?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

