Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLGOQp>; Thu, 7 Dec 2000 09:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLGOQf>; Thu, 7 Dec 2000 09:16:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129464AbQLGOQ2>; Thu, 7 Dec 2000 09:16:28 -0500
Subject: Re: fatfs BUG() in test12-pre5
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 7 Dec 2000 13:47:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012061949330.1043-100000@imladris.demon.co.uk> from "David Woodhouse" at Dec 06, 2000 07:51:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1441Ow-0002Rc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This code in fs/fat/file.c::fat_get_block() is getting triggered when I
> run wine:
> 
>         if (iblock<<9 != MSDOS_I(inode)->mmu_private) {
>                 BUG();
>                 return -EIO;
>         }

[I'd suggest you don't run the FAT file system code in 2.4test* unless you are
 doing it read only or have the patches applied that fix truncate, otherwise
 you will turn your msdos fs to gloop right now]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
