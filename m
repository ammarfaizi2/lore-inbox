Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136063AbRDVMTD>; Sun, 22 Apr 2001 08:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136065AbRDVMSy>; Sun, 22 Apr 2001 08:18:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136063AbRDVMSr>; Sun, 22 Apr 2001 08:18:47 -0400
Subject: Re: Linux 2.4.3-ac12
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sun, 22 Apr 2001 13:20:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AE29CFD.C438C8B9@eyal.emu.id.au> from "Eyal Lebedinsky" at Apr 22, 2001 06:57:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rIqf-0005hx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
> -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4/include/linux/modversions.h   -c -o
> inode.o inode.c
> inode.c: In function `affs_notify_change':
> inode.c:236: void value not ignored as it ought to be
> make[2]: *** [inode.o] Error 1
> make[2]: Leaving directory `/data2/usr/local/src/linux-2.4/fs/affs'

In the -ac tree inode_setattr is int. So if this is a -ac tree something is
misapplied. It may well be wrong in Linus tree right now



