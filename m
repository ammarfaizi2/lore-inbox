Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278412AbRJMVNZ>; Sat, 13 Oct 2001 17:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278413AbRJMVNP>; Sat, 13 Oct 2001 17:13:15 -0400
Received: from rj.SGI.COM ([204.94.215.100]:11686 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278412AbRJMVNK>;
	Sat, 13 Oct 2001 17:13:10 -0400
Message-ID: <3BC8AE84.48808982@sgi.com>
Date: Sat, 13 Oct 2001 14:13:40 -0700
From: L A Walsh <law@sgi.com>
Organization: Trust Technology, Core Linux, SGI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Maximum size of ext2 files on ia32 is?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was hesitantly and pleasantly surprised when I was copying across an
unmounted 8G unmounted file partition via dump to an NFS partition.  Until
August, regular backups splitted the dump image (used the "-M" flag to
dump) to into 4 2G files.  My backup disk died so it took some time to
replace it and just got around to doing so (I know, running w/out backups
is like unprotected sex, but lets ignore that critique).  So I startup
dump and it produced 1 9G file.  I was a bit concerned that NFS had
a screwed up mapping of the local file, but the server confirmed the file
size.  'du' confirmed it was 8.8G, I even unmounted, forced an fsck on it
and remounted -- still 8.8G.  I was allocating special partitions to
backup non-dump compatible partitions (win) to the server but find now they
can be backed up into a single 8G+ file.  I notice some utils from my latest
suse72 install (stat) don't know about it either:
> du -sh *
14M     BOOT_101101.dump
8.8G    HOME_101201.dump.001
...
> stat HOME_101201.dump.001
HOME_101201.dump.001: Value too large for defined data typ

So, I have been a bit busy and distracted and all, but when did large 
file support go in for the i386 arch and what is the new max files size?

Congratulations and great work for addressing that limitation!  

Linda

p.s. -- I hope this is a real feature and not considered a bug...:-)

--  -    _    -    _    -    _    -    _    -    _    -    _    -    _    -
L A Walsh, law at sgi dot com     | Senior Engineer
01-650-933-5338                   | Trust Technology, Core Linux, SGI
