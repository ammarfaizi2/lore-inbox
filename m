Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286799AbRLVPHH>; Sat, 22 Dec 2001 10:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286798AbRLVPG6>; Sat, 22 Dec 2001 10:06:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41482 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286797AbRLVPGo>; Sat, 22 Dec 2001 10:06:44 -0500
Subject: Re: Mount point permissions
To: alvieboy@alvie.com (Alvaro Lopes)
Date: Sat, 22 Dec 2001 15:16:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1009033045.935.1.camel@dwarf> from "Alvaro Lopes" at Dec 22, 2001 02:57:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Hnsu-0004Rp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dwarf:~# ls -ld /tmp
> drwxrwxrwt    8 root     root          336 Dez 22 14:55 /tmp
> dwarf:~# mount /dev/RAID0VOL/TEMP /tmp
> dwarf:~# ls -ld /tmp
> drwxr-xr-x    2 root     root           48 Dez 22 14:45 /tmp
> 
> Shouldn't mount preserve original mountpoint permissions ?

It does. If you umount it you will get them back. mount replaced "/tmp"
with the root inode of your new volume, hence the change. Fix the root 
inode of the new fs and all will be happy
