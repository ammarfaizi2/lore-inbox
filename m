Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRHFCOd>; Sun, 5 Aug 2001 22:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbRHFCOW>; Sun, 5 Aug 2001 22:14:22 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:5761 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S266263AbRHFCOM>;
	Sun, 5 Aug 2001 22:14:12 -0400
Date: Mon, 6 Aug 2001 05:15:14 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: <linux-kernel@vger.kernel.org>
Subject: smb/mount bug.
Message-ID: <Pine.LNX.4.33L2.0108060511330.25283-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should be self explanatory. My guess is, its probably the smb
filesystem reporting as mounting again a share after network failure.

spiral:~$ uname -a
Linux spiral.extreme.ro 2.4.6-ac5 #6 Sun Jul 29 12:11:51 EEST 2001 i686
unknown
spiral:~$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hdb1             29024544  22020024   5530160  80% /
tmpfs                   485948         0    485948   0% /dev/shm
/dev/hda1             12277680   9646264   2631416  79% /mnt/win1
/dev/hda5              2369552   2155780    213772  91% /mnt/win2
//hq/kits             40201216  22372352  17828864  56% /mnt/hq
//hq/Homes$           40201216  22372352  17828864  56% /home/pdan/hq
//hq/kits             40201216  22372352  17828864  56% /mnt/hq
//hq/Movies           40201216  22372352  17828864  56% /mnt/movies
//hq/Homes$           40201216  22372352  17828864  56% /home/pdan/hq
//hq/kits             40201216  22372352  17828864  56% /mnt/hq
//hq/Movies           40201216  22372352  17828864  56% /mnt/movies
//hq/Homes$           40201216  22372352  17828864  56% /home/pdan/hq
/dev/scd0               662752    662752         0 100% /mnt/cdrom
spiral:~$ mount
/dev/hdb1 on / type ext2 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,mode=0620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda1 on /mnt/win1 type vfat (rw)
/dev/hda5 on /mnt/win2 type ntfs (ro)
//hq/kits on /mnt/hq type smbfs (0)
//hq/Homes$ on /home/pdan/hq type smbfs (0)
//hq/kits on /mnt/hq type smbfs (0)
//hq/Movies on /mnt/movies type smbfs (0)
//hq/Homes$ on /home/pdan/hq type smbfs (0)
//hq/kits on /mnt/hq type smbfs (0)
//hq/Movies on /mnt/movies type smbfs (0)
//hq/Homes$ on /home/pdan/hq type smbfs (0)
/dev/scd0 on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev)
spiral:~$ cat /proc/mounts
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
/dev/hda1 /mnt/win1 vfat rw 0 0
/dev/hda5 /mnt/win2 ntfs ro 0 0
//hq/kits /mnt/hq smbfs rw 0 0
//hq/Homes$ /home/pdan/hq smbfs rw 0 0
//hq/kits /mnt/hq smbfs rw 0 0
//hq/Movies /mnt/movies smbfs rw 0 0
//hq/Homes$ /home/pdan/hq smbfs rw 0 0
//hq/kits /mnt/hq smbfs rw 0 0
//hq/Movies /mnt/movies smbfs rw 0 0
//hq/Homes$ /home/pdan/hq smbfs rw 0 0
/dev/cdrom /mnt/cdrom iso9660 ro,noexec,nosuid,nodev 0 0


