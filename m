Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135853AbRDZSk7>; Thu, 26 Apr 2001 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135886AbRDZSkt>; Thu, 26 Apr 2001 14:40:49 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:35308 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S135853AbRDZSkk>; Thu, 26 Apr 2001 14:40:40 -0400
Message-ID: <3AE879AE.387D3B78@antefacto.com>
Date: Thu, 26 Apr 2001 20:40:30 +0100
From: Padraig Brady <padraig@antefacto.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramdisk/tmpfs/ramfs/memfs ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on an embedded system here which has no harddisk.
So, I can't swap to disk and need to have /var & /tmp in RAM.
I'm confused between the various options for in RAM file-
systems. At the moment I've created a ramdisk and made an 
ext2 partition in it (which is compressed as I applied the 
e2compr patch), which is working fine. Anyway questions:

1. I presume the kernel is clever enough to not cache any
   files from these filesystems? Would it ever need to?
2. Is tmpfs is basically swap and /tmp together in a ramdisk?
   The advantage being you need to reserve less RAM for both
   together than seperately?
3. If I've no backing store (harddisk?) is there any advantage 
   of using tmpfs instead of ramfs? Also does tmpfs need a 
   backing store?
5. Can you set size limits on ramfs/tmpfs/memfs?
6. Is a ramdisk resizable like the others. If so, do you have
   to delete/recreate or umount/resize a fs (e.g. ext2) every
   time it's resized? Do ramfs/tmpfs/memfs do this transparently?
   Are ramdisks resizable in kernel 2.2?
7. What's memfs?
8. Is there a way I can get transparent compression like I now
   have using a ramdisk+ext2+e2compr with ramfs et al?
9. Apart from this transparent compression, is there any other
   functionality ext2 would have over ramfs for e.g, for /tmp
   & /var? Also would ramfs have less/more speed over ext2?

thanks,
Padraig.
