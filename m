Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286790AbRLVPA1>; Sat, 22 Dec 2001 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286791AbRLVPAR>; Sat, 22 Dec 2001 10:00:17 -0500
Received: from marao.utad.pt ([193.136.40.3]:2566 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S286790AbRLVPAB> convert rfc822-to-8bit;
	Sat, 22 Dec 2001 10:00:01 -0500
Subject: Mount point permissions
From: Alvaro Lopes <alvieboy@alvie.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 22 Dec 2001 14:57:23 +0000
Message-Id: <1009033045.935.1.camel@dwarf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I just created a RAID0-reiserfs filesystem to hold /tmp (I expect to
have some increased performance since my rootfs is on a LVM/RAID5
array). The problem (althrough I can easily override it) is whenever the
new fs is mounted, all permissions on /tmp are overriden (I double
checked on mount options and there seems no option is provided for
mountpoint permissions). So what I get is:

dwarf:~# ls -ld /tmp
drwxrwxrwt    8 root     root          336 Dez 22 14:55 /tmp
dwarf:~# mount /dev/RAID0VOL/TEMP /tmp
dwarf:~# ls -ld /tmp
drwxr-xr-x    2 root     root           48 Dez 22 14:45 /tmp

Shouldn't mount preserve original mountpoint permissions ?

Álvaro Lopes

