Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136098AbRDVNFr>; Sun, 22 Apr 2001 09:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136102AbRDVNFi>; Sun, 22 Apr 2001 09:05:38 -0400
Received: from CPE-61-9-151-92.vic.bigpond.net.au ([61.9.151.92]:7676 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S136098AbRDVNFU>;
	Sun, 22 Apr 2001 09:05:20 -0400
Message-ID: <3AE2D6F9.3AFE9F73@eyal.emu.id.au>
Date: Sun, 22 Apr 2001 23:04:57 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rIqf-0005hx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4/include -Wall
> > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> > -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
> > -DMODVERSIONS -include
> > /data2/usr/local/src/linux-2.4/include/linux/modversions.h   -c -o
> > inode.o inode.c
> > inode.c: In function `affs_notify_change':
> > inode.c:236: void value not ignored as it ought to be
> > make[2]: *** [inode.o] Error 1
> > make[2]: Leaving directory `/data2/usr/local/src/linux-2.4/fs/affs'
> 
> In the -ac tree inode_setattr is int. So if this is a -ac tree something is
> misapplied. It may well be wrong in Linus tree right now

Yep, I think this is a -pre4 problem, not -ac12.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
